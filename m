Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC24EEA24
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbiDAJMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiDAJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FFB1C6EFE;
        Fri,  1 Apr 2022 02:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F16761239;
        Fri,  1 Apr 2022 09:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31529C2BBE4;
        Fri,  1 Apr 2022 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648804244;
        bh=LQombThtfiPPOh/Qz1IUNS3ey8nXXAvBl/8UCn9TYoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scUIDmw0nMVwUtqwsfgDy7AJITvNlUh8YrIN8W2z0s3zhmRyjS60VEXAmNHctljOU
         ErdFRneQiialRXKLwXWrZXdY4DsD2YEuy4HjmYVH5Z/xj2GZKkDJww75vFz1pQ4x+9
         y++WB7TQ6SUe31QNkJaWSy6SYZI0nTkVzOT3rF10=
Date:   Fri, 1 Apr 2022 11:10:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     mailhol.vincent@wanadoo.fr, lv.ruyi@zte.com.cn,
        cai.huoqing@linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] usb: host: replace zero-length array with flexible-array
 member
Message-ID: <YkbBktBbsWJakSZo@kroah.com>
References: <20220401080337.2407622-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220401080337.2407622-1-lv.ruyi@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 08:03:37AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/usb/host/oxu210hp-hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
> index b741670525e3..86f92aadeb0e 100644
> --- a/drivers/usb/host/oxu210hp-hcd.c
> +++ b/drivers/usb/host/oxu210hp-hcd.c
> @@ -169,7 +169,7 @@ struct ehci_regs {
>  #define FLAG_CF		(1<<0)		/* true: we'll support "high speed" */
>  
>  	/* PORTSC: offset 0x44 */
> -	u32		port_status[0];	/* up to N_PORTS */
> +	u32		port_status[];	/* up to N_PORTS */
>  /* 31:23 reserved */
>  #define PORT_WKOC_E	(1<<22)		/* wake on overcurrent (enable) */
>  #define PORT_WKDISC_E	(1<<21)		/* wake on disconnect (enable) */
> -- 
> 2.25.1
> 

How did you test to verify that this change is correct?
