Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C45A78E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiHaIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiHaIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:21:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F11F1BEA7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:20:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F36D6B81FB0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69EAC433D6;
        Wed, 31 Aug 2022 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661933937;
        bh=oQEpIl02Caai0Z7pk6Qje2yeMx2zYiGnfAAL0WZGH8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vo87sU8KdVcbAx/l5U40sexiMuEH77Cc3O9ceqiSlCV4rGPBqUqZcMQvkoGrGX4ZR
         45EX6wDTl64HVIfnoznHLu2a3TU+hzEaB/WKIZiNkSyandmbo/UrIIZADM+KDlDvLg
         0D8JvJ0lT/2tQuGx0oPt8obpJ9GBz9yrFlUfZf28=
Date:   Wed, 31 Aug 2022 10:19:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        johan@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        zhangxuezhi1@coolpad.com, xyangxi5@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: Add checks after calling kzalloc
Message-ID: <Yw8ZgVojT0HsZO5t@kroah.com>
References: <20220831075742.2175792-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831075742.2175792-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 03:57:42PM +0800, Jiasheng Jiang wrote:
> As the potential failure of the memory allocation,
> it should be better to check the return value after
> calling kzalloc and return error if fails.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/tty/vt/vt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index ae9c926acd6f..a4d59f3a3ce0 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3519,11 +3519,19 @@ static int __init con_init(void)
>  
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (!vc) {
> +			console_unlock();
> +			return -ENOMEM;
> +		}
>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
>  		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (!vc->vc_screenbuf) {
> +			console_unlock();
> +			return -ENOMEM;
> +		}
>  		vc_init(vc, vc->vc_rows, vc->vc_cols,
>  			currcons || !vc->vc_sw->con_save_screen);
>  	}
> -- 
> 2.25.1
> 

This has been attempted many times in the past, sorry.  Unless you can
prove that this can actually happen in real life, we are going to leave
these as-is.

Please do not just do random changes like this without actually testing
to see if it is possible to happen.

thanks,

greg k-h
