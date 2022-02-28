Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536A24C64D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiB1IYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiB1IYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:24:51 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEDF3C48B;
        Mon, 28 Feb 2022 00:24:11 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 30F91185;
        Mon, 28 Feb 2022 00:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1646036651;
        bh=nnBN0dGrBVyqWTSRs7wxqWLOPD9yMdE1ClJpxLloK24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5obv454FzMLve6yKLSFEJ65pf1vEvmMRk112EdsRcl1PXOg/EgUAxkBtOCliMhW7
         XoUkl096b9oO2nGCait93mHXdMCWqTiCA2KslzcfY04A9CpuWgODXzg3oM8jgE4A/R
         xzbIf70iH/hNL9AcQOvn8eKrFiH0s5McgsJ8tb2M=
Date:   Mon, 28 Feb 2022 00:24:07 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Renze Nicolai <renze@rnplus.nl>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] hwmon: (nct6775) Rearrange attr-group initialization
Message-ID: <YhyGp0zu9OBOWt/M@hatter.bewilderbeest.net>
References: <20220226133047.6226-1-zev@bewilderbeest.net>
 <20220226133047.6226-2-zev@bewilderbeest.net>
 <b4a1d4e1-a7b9-00f9-75d2-56003138883f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b4a1d4e1-a7b9-00f9-75d2-56003138883f@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 07:01:32AM PST, Guenter Roeck wrote:
>On 2/26/22 05:30, Zev Weiss wrote:
>>We now track the number of attribute groups in nct6775_data, as a
>>measure to simplify handling differences in the set of enabled
>>attribute groups between nct6775 drivers (platform & i2c).  As a side
>>effect, we also reduce the amount of IS_ERR()/PTR_ERR() boilerplate a
>>bit.
>>
>>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>---
>>  drivers/hwmon/nct6775.c | 84 ++++++++++++++++++++---------------------
>>  1 file changed, 42 insertions(+), 42 deletions(-)
>>
>>diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
>>index 2b91f7e05126..139b2fe5ca4d 100644
>>--- a/drivers/hwmon/nct6775.c
>>+++ b/drivers/hwmon/nct6775.c
>>@@ -1198,6 +1198,7 @@ struct nct6775_data {
>>  	const char *name;
>>  	const struct attribute_group *groups[7];
>>+	u8 num_groups;
>>  	u16 reg_temp[5][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
>>  				    * 3=temp_crit, 4=temp_lcrit
>>@@ -1405,10 +1406,18 @@ struct sensor_template_group {
>>  	int base;
>>  };
>>-static struct attribute_group *
>>-nct6775_create_attr_group(struct device *dev,
>>-			  const struct sensor_template_group *tg,
>>-			  int repeat)
>>+static int nct6775_add_attr_group(struct nct6775_data *data, const struct attribute_group *group)
>>+{
>>+	/* Need to leave a NULL terminator at the end of data->groups */
>>+	if (WARN_ON(data->num_groups == ARRAY_SIZE(data->groups) - 1))
>>+		return -ENOSPC;
>>+
>
>At work we are struggling with a whopping 500,000+ (!) WARN backtraces
>_each day_. I would be happy if you send me patches removing some of
>those, but I am not inclined to accept patches adding them. If people
>don't notice that the driver doesn't load, they won't notice the warning
>either, and it will just add to all the other warning backtrace noise.
>

Okay, I can remove that -- I mostly just added it out of concern that 
"no space left on device" would be a fairly confusing error for someone 
to potentially end up with modprobe reporting, and some further 
indication of what went wrong could perhaps make it less mystifying 
(though yes, with any luck it can hopefully remain unreachable in 
practice as long as data->groups gets expanded when needed).

I'd certainly also be open to suggestions of a more appropriate errno 
value to return in that case, though I couldn't find one that seemed 
clearly better to me.  ENOMEM seemed vaguely more appropriate in some 
ways given that it's an in-memory array that's full rather than a 
storage device, but it's also definitely not the usual ENOMEM meaning of 
a dynamic allocation failure due to memory pressure, so...(shrug).  I 
think FreedBSD's got an EDOOFUS errno value, but as far as I can see 
Linux doesn't have one for indicating a purely internal error like this.


Thanks,
Zev

