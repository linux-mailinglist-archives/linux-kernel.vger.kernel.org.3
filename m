Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78244ED3B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiCaGHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiCaGHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:07:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A241DC9B3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41C76B81F94
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81348C340F0;
        Thu, 31 Mar 2022 06:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648706753;
        bh=Fajq2q58T8JQGQNMfV56qm0v4N1kyLJuA/ecjhDD1uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtVXBVFWe65EbTJaSQ0rWEp5jG70gQhlnIMqxtxuAW7E7HqlLsyyMqQ/TnRt3t/yG
         H5bGuBuC7rmOlsot/6n5nIoGrJQQ+xh/PDkP3+RF+iJGZTedWrAWahPNRFgkAgmp7g
         uK+lFoQ/lidLocrhSQ8n/wVQMuaeXtDRqGo8JZpU=
Date:   Thu, 31 Mar 2022 08:05:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: fix a potential memory leak in
 _rtw_init_cmd_priv()
Message-ID: <YkVEug04VgT70AzB@kroah.com>
References: <tencent_1150789052C1FF3548117344EE374723C506@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1150789052C1FF3548117344EE374723C506@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:15:35AM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In _rtw_init_cmd_priv(), if `pcmdpriv->rsp_allocated_buf` is allocated
> in failure, `pcmdpriv->cmd_allocated_buf` is not properly released.
> This patch is to free it.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> ChangeLog:
> v1->v2: simplify the function.
>  drivers/staging/r8188eu/core/rtw_cmd.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 56910c3..3de3a39 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -17,8 +17,6 @@ No irqsave is necessary.
>  
>  static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
>  {
> -	int res = _SUCCESS;
> -
>  	sema_init(&pcmdpriv->cmd_queue_sema, 0);
>  	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
>  	sema_init(&pcmdpriv->terminate_cmdthread_sema, 0);
> @@ -26,34 +24,25 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
>  	_rtw_init_queue(&pcmdpriv->cmd_queue);
>  
>  	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
> -
>  	pcmdpriv->cmd_seq = 1;
> -

Why make whitespace cleanups at the same time?  Please do not do that.

And I do not think this patch applies anymore _rtw_init_queue() is not
in my tree.  Please rebase and fix up and resend.

thanks,

greg k-h
