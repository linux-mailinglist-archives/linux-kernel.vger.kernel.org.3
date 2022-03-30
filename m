Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E58D4EBFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbiC3LpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiC3LpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69C1157
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A7B861510
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94ECC340EE;
        Wed, 30 Mar 2022 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648640616;
        bh=C+XthxcZK0slDrivIv8utqwUp6xmswLxrsdKB843Dic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLee5w8CWHKteAqABcDu8vhQDbHClVDcrd071PCg+/6BRslt23gKBCpePgcw3CsE1
         QMrsjGooFhBH8hyEr7uK0q1f9AkMT1pvx/uL4XrMOuqgg/JY7gu0ElMqKVq6Kd7mnT
         kWUZ6BUXldbezyIldPKCheQ8oiKWZRCAOYNPMSxc=
Date:   Wed, 30 Mar 2022 13:43:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix a potential memory leak in
 _rtw_init_cmd_priv()
Message-ID: <YkRCZXmFk7ElDGGl@kroah.com>
References: <tencent_FF6828BEC24B9560FE5D405E998D73633809@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_FF6828BEC24B9560FE5D405E998D73633809@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 07:32:21PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In _rtw_init_cmd_priv(), if `pcmdpriv->rsp_allocated_buf` is allocated
> in failure, `pcmdpriv->cmd_allocated_buf` is not properly released.
> This patch is to free it.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 56910c3..e76015e 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -42,6 +42,8 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
>  	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);
>  
>  	if (!pcmdpriv->rsp_allocated_buf) {
> +		kfree(pcmdpriv->cmd_allocated_buf);
> +		pcmdpriv->cmd_allocated_buf = NULL;
>  		res = _FAIL;
>  		goto exit;

Shouldn't this be handled properly in the exit: portion instead?

thanks,

greg k-h
