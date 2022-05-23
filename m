Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE75531011
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiEWLxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiEWLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:53:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D6224F06;
        Mon, 23 May 2022 04:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F130B8109D;
        Mon, 23 May 2022 11:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C50DC385A9;
        Mon, 23 May 2022 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653306811;
        bh=yZuk3d4cZKnVqTh4bOMLEpn25pDviA0vilD33AxQFpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUYR96xFWGzXcDZBDX2pg0s/9kwtDuE4XDSLUrJHQAkJyaXVrbdmPRICWwrvWGS+c
         RW0BQH9RPek5YS662qI2/bh2Bw93P8Znp4u8/kjG3yvwQFdCVv9sKUmLXZ+nIqxBT3
         MVwwzzDCddoez26k340Y+HXqtAfJ1LwPy9M5/sSVWaBXZNgb/g7TH08ZCdNJUvo6HE
         2G4rCMs7XgucWyoXv3fGDCyUtGtBjfeg834leBb4BdBQ/1KSwDpj8V//Ra/isr/fEI
         AIg7rim+PjncaTqjbCgcrAoJo/fBVhUxqX/dN6Sp57e9v0FMER1UAzf+PXmvqVEwH4
         ZPC/gK8aKVFHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt6cq-00030k-Jb; Mon, 23 May 2022 13:53:28 +0200
Date:   Mon, 23 May 2022 13:53:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     dvhart@infradead.org, andy@infradead.org, tglx@linutronix.de,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] x86, olpc: Avoid leak OF node on error
Message-ID: <Yot1uKb0TRnUPcz9@hovoldconsulting.com>
References: <20220523111253.3114-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523111253.3114-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:12:53AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The OF node should be put before returning error in xo1_rtc_init(),
> otherwise node's refcount will be leaked.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  arch/x86/platform/olpc/olpc-xo1-rtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/olpc/olpc-xo1-rtc.c b/arch/x86/platform/olpc/olpc-xo1-rtc.c
> index 57f210cda761..dc5ac56cd9dd 100644
> --- a/arch/x86/platform/olpc/olpc-xo1-rtc.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-rtc.c
> @@ -59,9 +59,9 @@ static int __init xo1_rtc_init(void)
>  	struct device_node *node;
>  
>  	node = of_find_compatible_node(NULL, NULL, "olpc,xo1-rtc");
> +	of_node_put(node);
>  	if (!node)
>  		return 0;
> -	of_node_put(node);

Is this a joke? Don't you guys even try to understand the code your
"robot" tells you to change?

Please don't send any more patches until you've figured out how you
messed up here.

>  	pr_info("olpc-xo1-rtc: Initializing OLPC XO-1 RTC\n");
>  	rdmsrl(MSR_RTC_DOMA_OFFSET, rtc_info.rtc_day_alarm);

Johan
