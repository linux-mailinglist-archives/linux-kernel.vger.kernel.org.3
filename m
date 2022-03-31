Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35C24ED3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiCaGFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiCaGFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:05:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A311D41A5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C51CB81EA0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E4FC340ED;
        Thu, 31 Mar 2022 06:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648706591;
        bh=A0m+Ep1Uons0hoytgDZ+0JywZF4PGusJ+GkrcK012yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLrgOnwSctG+gm6aPt7XUieMGp8JxaThqmsq5M+Y0SN3UAmkZX/W7s2RYLYk7J/tO
         aRGSNDA1IYzqtgKQMrUer0TzbsGCx3WsAArVeL27deJwzheoHrSSMcdZowfOjzxCjW
         btqPzaWcNO3DSd+gu8AvHke6bT9EgEOV/KAh55c8=
Date:   Thu, 31 Mar 2022 08:03:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: r8188eu: properly handle the kzalloc()
Message-ID: <YkVEHNubZCXmgeMx@kroah.com>
References: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:16:07PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to handle the return
> of it to prevent potential wrong memory access.
> For the kzalloc() in go_add_group_info_attr(), since there is a lack
> of error handlers along the call chain it lies and the lifetime of
> `pdata_attr` is only in go_add_group_info_attr(), `pdata_attr` is roughly
> changed to a local variable on stack like the other functions in 
> rtw_p2p.c, such as `u8 p2pie[MAX_P2P_IE_LEN] = { 0x00 };` in 
> issue_p2p_presence_resp().
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_p2p.c     |  6 ++----
>  drivers/staging/r8188eu/core/rtw_xmit.c    | 12 +++++++++---
>  drivers/staging/r8188eu/include/rtw_xmit.h |  2 +-
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
> index e2b6cf2..f1a5df8 100644
> --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> @@ -27,15 +27,14 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
>  	struct list_head *phead, *plist;
>  	u32 len = 0;
>  	u16 attr_len = 0;
> -	u8 tmplen, *pdata_attr, *pstart, *pcur;
> +	u8 pdata_attr[MAX_P2P_IE_LEN] = { 0x00 };

You just created a huge variable on the stack.  Are you _SURE_ that is
ok?

Have you tested this change to make sure it works?  If not, I can't take
it, sorry.

greg k-h
