Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992174FC760
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350162AbiDKWMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiDKWMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:12:13 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9525EB8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:09:57 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 0A0D4180;
        Mon, 11 Apr 2022 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1649714997;
        bh=+BbLsGW2nbD0+iWxTnwzW8eOCpk29Z2Cld9MohScjRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhsieTFZmbRYLvmOF7JRiZjYSCJ63XCo6T5HrMJUC8hIwXhLE3QKL7zCD9oimNhWx
         +UNgQzE6L6tuQYcmH+SLNq7EAtqzO6BUNMu0h5KIoKA/kWwYOSK1+5QSHtr/W4ePcu
         YdXNwjGZDGEpYolYAcCpr/zKm1sIMajKbt3vcFB8=
Date:   Mon, 11 Apr 2022 15:09:53 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 2/2] misc: Add power-efuse driver
Message-ID: <YlSnMVVE63xqGSGa@hatter.bewilderbeest.net>
References: <20220308011811.10353-1-zev@bewilderbeest.net>
 <20220308011811.10353-3-zev@bewilderbeest.net>
 <YicAzSara5Sr3LQ7@kroah.com>
 <YicSj3ZuetRkYxH1@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YicSj3ZuetRkYxH1@hatter.bewilderbeest.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 12:23:44AM PST, Zev Weiss wrote:
>On Mon, Mar 07, 2022 at 11:07:57PM PST, Greg Kroah-Hartman wrote:
>
>>>+EFUSE_ERROR_ATTR(under_voltage, REGULATOR_ERROR_UNDER_VOLTAGE);
>>>+EFUSE_ERROR_ATTR(over_current, REGULATOR_ERROR_OVER_CURRENT);
>>>+EFUSE_ERROR_ATTR(regulation_out, REGULATOR_ERROR_REGULATION_OUT);
>>>+EFUSE_ERROR_ATTR(fail, REGULATOR_ERROR_FAIL);
>>>+EFUSE_ERROR_ATTR(over_temp, REGULATOR_ERROR_OVER_TEMP);
>>>+EFUSE_ERROR_ATTR(under_voltage_warn, REGULATOR_ERROR_UNDER_VOLTAGE_WARN);
>>>+EFUSE_ERROR_ATTR(over_current_warn, REGULATOR_ERROR_OVER_CURRENT_WARN);
>>>+EFUSE_ERROR_ATTR(over_voltage_warn, REGULATOR_ERROR_OVER_VOLTAGE_WARN);
>>>+EFUSE_ERROR_ATTR(over_temp_warn, REGULATOR_ERROR_OVER_TEMP_WARN);
>>>+
>>>+static struct attribute *efuse_attrs[] = {
>>>+	&dev_attr_operstate.attr,
>>>+	&dev_attr_under_voltage.attr,
>>>+	&dev_attr_over_current.attr,
>>>+	&dev_attr_regulation_out.attr,
>>>+	&dev_attr_fail.attr,
>>>+	&dev_attr_over_temp.attr,
>>>+	&dev_attr_under_voltage_warn.attr,
>>>+	&dev_attr_over_current_warn.attr,
>>>+	&dev_attr_over_voltage_warn.attr,
>>>+	&dev_attr_over_temp_warn.attr,
>>>+	NULL,
>>>+};
>>>+ATTRIBUTE_GROUPS(efuse);
>>
>>Shouldn't these all just be what all regulator drivers report?  Or power
>>drivers?  I find it odd that this would be the first driver that would
>>need to export these types of attributes.  Surely there's already a
>>class for this?
>>
>
>The attributes available from the underlying regulator device don't 
>include the error flags, and while they do include its state 
>('operstate' here), it's a read-only attribute, and from previous 
>discussions with Mark I gathered that was unlikely to change (whereas 
>it being read-write is a critical part of this driver's 
>functionality).
>
>Given his input on the first stab at this I took a while back, I've 
>been hoping to hear from Mark as to whether this looked more like 
>something he'd find palatable; perhaps he could chime in on this too?  
>(And/or on the regulator API question in the cover letter.)
>

Ping...Mark (or Liam?), any thoughts on an appropriate path forward on 
this?


Thanks,
Zev

