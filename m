Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1DA4EC82E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348165AbiC3P1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbiC3P1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:27:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321219B04D;
        Wed, 30 Mar 2022 08:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADDDCB81BAB;
        Wed, 30 Mar 2022 15:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D05C340EE;
        Wed, 30 Mar 2022 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648653944;
        bh=evEpNcpIO1FCjUfsvj9LcG6TI+SZQZAE/AJCOITs1PY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gdXh5pSgjZqp/sNRDahqhb8DKSZf/bJyeL5BrEd3TVnwKz4WxcwsUC9ssYDFOgMVL
         JxuGAlopLHOSDgI3tb8oOEmspgmrJlQ5gwfRDGX5YBabKVd7ArM8tkcZBBBlCz/jSQ
         WdsZJxAHpwGkRrym34k0H2A5I3T6kBjphjCWPSi6CqvtNL+247N7008knGH0MESB/z
         LWf/jHCNCgWYjF77B/NL7CRktmHlj9bgZWIi9Ax/+pcrMiF5rXVKe1kVxGZCQOCKEM
         vA6OrZ/2nC1T53lOqCKAFHqFIhn0iRXo0c/W1PwaDn5cKgl44cEcLdY4kABEYYCF8b
         aTMtSnUAwLsyQ==
Date:   Wed, 30 Mar 2022 17:25:40 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Mingxuan Xiang <mx_xiang@hust.edu.cn>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rafi Rubin <rafi@seas.upenn.edu>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-ntrig: fix the error handling code in
 ntrig_probe
In-Reply-To: <20220313150237.1214062-1-mx_xiang@hust.edu.cn>
Message-ID: <nycvar.YFH.7.76.2203301722301.24795@cbobk.fhfr.pm>
References: <20220313150237.1214062-1-mx_xiang@hust.edu.cn>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022, Mingxuan Xiang wrote:

> If sysfs_create_group in ntrig_probe fails, sysfs_remove_group in
> ntrig_remove would hit WARN().
> 
> Fix this by returning err in ntrig_probe rather than ignoring the
> failure of sysfs_create_group.
> 
> CC: Dongliang Mu <dzm91@hust.edu.cn>
> Fixes: eab32f5f6557 ("HID: ntrig: add sysfs access to filter parameters")
> Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
> ---
>  drivers/hid/hid-ntrig.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index b5d26f03fe6b..f49427815d98 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -951,10 +951,14 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	ret = sysfs_create_group(&hdev->dev.kobj,
>  			&ntrig_attribute_group);
> -	if (ret)
> +	if (ret) {
>  		hid_err(hdev, "cannot create sysfs group\n");
> +		goto err_sysfs_create;
> +	}
>  
>  	return 0;
> +err_sysfs_create:
> +	hid_hw_stop(hdev);
>  err_free:
>  	kfree(nd);

Thanks for the fix.

However, I believe that the sole fact that sysfs_create_group() failed 
should not be a reason for bailing the probe completely (rendering the 
device completely dysfunctional), given the fact that the probe otherwise 
succeeded and this just means that the parameters can't be tuned in 
runtime.

So just taking a note whether we do actually have sysfs attributes created 
on probe and freeing them only conditionally on remove() sounds like a bit 
less drastic aproach to me.

Could you please adjust the fix and resubmit?

Thanks,

-- 
Jiri Kosina
SUSE Labs

