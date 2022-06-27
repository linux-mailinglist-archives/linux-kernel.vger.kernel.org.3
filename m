Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B0755D379
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiF0OOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiF0OOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72613F1B;
        Mon, 27 Jun 2022 07:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03D3360F75;
        Mon, 27 Jun 2022 14:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5685C3411D;
        Mon, 27 Jun 2022 14:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656339268;
        bh=1t84Bfpndd4u0r1oAOSW32bSjkdNAJZliswLauwl4To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tldIhm6W3NamIHeQNmmOp0khE2VKbCRJSsN4cX5hKkuSV05STtMuSIu46g/9XzAPa
         +CjNSbrCu8ODqcgr18c6ryakYP08udVqvSG6E1qt6LDoRypMWXCocWCmQ3eRFywRRB
         I2Mjs1ScSjq2xHoMMKSMbj+tGhcYnhIFgF1uhKZk=
Date:   Mon, 27 Jun 2022 16:14:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     peter.wang@mediatek.com
Cc:     matthias.bgg@gmail.com, len.brown@intel.com, pavel@ucw.cz,
        rafael@kernel.org, stanley.chu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        cc.chou@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com, powen.kao@mediatek.com,
        qilin.tan@mediatek.com, lin.gui@mediatek.com,
        tun-yu.yu@mediatek.com
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before
 release supplier
Message-ID: <Yrm7QSRXKZg4/q7s@kroah.com>
References: <20220613120755.14306-1-peter.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613120755.14306-1-peter.wang@mediatek.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 08:07:55PM +0800, peter.wang@mediatek.com wrote:
> From: Peter Wang <peter.wang@mediatek.com>
> 
> With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
> to prevent supplier enter suspend, pm_runtime_release_supplier should
> check supplier_preactivated before let supplier enter suspend.
> 
> If the link is drop or release, bypass check supplier_preactivated.
> 
> Signed-off-by: Peter Wang <peter.wang@mediatek.com>
> ---
>  drivers/base/core.c          |  2 +-
>  drivers/base/power/runtime.c | 15 ++++++++++++---
>  include/linux/pm_runtime.h   |  5 +++--
>  3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7cd789c4985d..3b9cc559928f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -486,7 +486,7 @@ static void device_link_release_fn(struct work_struct *work)
>  	/* Ensure that all references to the link object have been dropped. */
>  	device_link_synchronize_removal();
>  
> -	pm_runtime_release_supplier(link, true);
> +	pm_runtime_release_supplier(link, true, true);
>  
>  	put_device(link->consumer);
>  	put_device(link->supplier);
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 676dc72d912d..3c4f425937a1 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -314,10 +314,19 @@ static int rpm_get_suppliers(struct device *dev)
>   * and if @check_idle is set, check if that device is idle (and so it can be
>   * suspended).
>   */
> -void pm_runtime_release_supplier(struct device_link *link, bool check_idle)
> +void pm_runtime_release_supplier(struct device_link *link, bool check_idle,
> +	bool drop)

This is just making this horrible api even worse.  Now there are 2
boolean flags required, 2 more than really should even be here at all.
Every time you see this function being used, you will now have to look
up the definition  to see what it really does.

Please make a new function that calls the internal function with the
flag set properly, so that it is obvious what is happening when the call
is made.

and really, the same thing should be done for the check_idle flag,
that's not good either.

thanks,

greg k-h
