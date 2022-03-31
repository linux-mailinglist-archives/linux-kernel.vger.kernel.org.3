Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3914ED689
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiCaJLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiCaJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:11:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A63EB9F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A96961990
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACD7C340F2;
        Thu, 31 Mar 2022 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648717754;
        bh=AuOZchoDYiYjYJhdm9pzSMXcF4+iwRw1lSwSphKuXj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYG3ZMRWIfD3jvNxp98TSxHaWdteoiSezZEWsB2v0ZwQIzP/N+EFrILUFsV3ecq/n
         GpSxhbIj7RcQ5CrO1KX3+Xd9iENao8swF4V6J0BsjF5bleqm3c5d1/QaKPaRpPVnlD
         eWt7z7GajHWvVCbksEK8QxnLuFC6ftNNqAD2I4dc=
Date:   Thu, 31 Mar 2022 11:09:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: change the allocation type of
 pdata_attr
Message-ID: <YkVvr/Pxfud21Mut@kroah.com>
References: <tencent_884B806033C3E7D6734450A085172A55FF0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_884B806033C3E7D6734450A085172A55FF0A@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:37:00PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> `pdata_attr` was allocated by kzalloc() in go_add_group_info_attr(), but
> there is a lack of error handlers along the call chain it lies and the
> lifetime of `pdata_attr` is only in go_add_group_info_attr().
> Therefore, changing it to a local variable on stack like the other
> functions in rtw_p2p.c is a possible choice, such as
> `u8 p2pie[MAX_P2P_IE_LEN] = { 0x00 };` in build_probe_resp_p2p_ie()
> which is the caller of go_add_group_info_attr().
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_p2p.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
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

As I said before, this is way too big to put on the stack.

