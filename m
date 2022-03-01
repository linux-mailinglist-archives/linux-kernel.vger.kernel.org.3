Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23C94C8E70
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiCAO7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiCAO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:59:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEE1140A8;
        Tue,  1 Mar 2022 06:58:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85BE9B81AA6;
        Tue,  1 Mar 2022 14:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E27CC340EE;
        Tue,  1 Mar 2022 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646146733;
        bh=Whkp6sbnmSxppFX3JGsOuKCRNLdvUtUZGKUEI6OjHC4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NbpZGqPJFO1XESRp5KovkQPpM9prMZ5aEqNF70m9KC9H6r9HnlgCnssQg7zUYIanL
         3gjciBx8OK/fO+YzD0GWXuIE9foa5Kszwuuzbeg9Bf8iVv8TIFqgiaVTO60rHhVvnD
         pfpd1GyOJQjuKtvItgFYKZd0aaitMWqzexnQI065mxm7y8jJQKqFu/a1ErQ62rnEbB
         9CgiBsD/5BF+yFMrqphI7PCIWPDbHWiuAaGl3dtFnWxqF4kW+Qswqp42fJMVUGp6mo
         XEWQKVwjOQiwjsO/sMcT91zLijvqcZyTdMyXlxz4/QFP22r6apc/y3vCGdsknZxHUP
         kjcP1y7DN3+zA==
Date:   Tue, 1 Mar 2022 15:58:49 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
cc:     djogorchock@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: hid-nintendo: check the return value of
 alloc_workqueue()
In-Reply-To: <20220225034110.13341-1-baijiaju1990@gmail.com>
Message-ID: <nycvar.YFH.7.76.2203011558150.24795@cbobk.fhfr.pm>
References: <20220225034110.13341-1-baijiaju1990@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022, Jia-Ju Bai wrote:

> The function alloc_workqueue() in nintendo_hid_probe() can fail, but
> there is no check of its return value. To fix this bug, its return value
> should be checked with new error handling code.
> 
> Fixes: c4eae84feff3e ("HID: nintendo: add rumble support")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/hid/hid-nintendo.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index b6a9a0f3966e..2204de889739 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2128,6 +2128,10 @@ static int nintendo_hid_probe(struct hid_device *hdev,
>  	spin_lock_init(&ctlr->lock);
>  	ctlr->rumble_queue = alloc_workqueue("hid-nintendo-rumble_wq",
>  					     WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
> +	if (!ctlr->rumble_queue) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
>  	INIT_WORK(&ctlr->rumble_worker, joycon_rumble_worker);

Thanks for the patch.

For future submissions, please try to make sure to always follow the 
subsystem-specific formatting of the shortlog (upperacase "HID: " prefix 
in this case).

I've fixed that up and applied.

-- 
Jiri Kosina
SUSE Labs

