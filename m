Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F023F50F9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348439AbiDZKSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348659AbiDZKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:17:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206AE6D86B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:40:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C04B1CE1BF7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B48FC385AE;
        Tue, 26 Apr 2022 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650966047;
        bh=UN8z2B0f1uixgrTjJ4GuWq66nLJBNSlOCFUejl7xRG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRyA9LmX87bAOFVLGVgpQdlLBmlF1yysxasr2dXDjlU1FuDA3gKIYpSzQhJyjc1jN
         zAbpGKMxQfEazx0Ly+jhnTYqk0TYre0bCdoabvuodL0yFkWhS2+gPwLHgR5jwdmrx+
         6eV+LPnM1HGKYF3O1uXOrLPnuKW0+eUKSyKbiaSw=
Date:   Tue, 26 Apr 2022 11:40:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     paskripkin@gmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] staging: r8188eu: fix potential memory leak in
 _rtw_init_xmit_priv()
Message-ID: <Yme+HFZ6u2gvMbfz@kroah.com>
References: <tencent_06FCFF1B2086CCD7B9C51C7C1490E1D64A08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_06FCFF1B2086CCD7B9C51C7C1490E1D64A08@qq.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 09:37:10AM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In _rtw_init_xmit_priv(), there are several error paths for allocation
> failures just jump to the `exit` section. However, there is no action
> will be performed, so the allocated resources are not properly released,
> which leads to various memory leaks.
> 
> To properly release them, this patch unifies the error handling code and
> several error handling paths are added.
> According to the allocation sequence, if the validation fails, it will
> jump to its corresponding error tag to release the resources.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> ChangeLog:
> v1->v2 update the description and adjust the sequence of patches.
> v2->v3 None to this patch, but some to another pathch in this series.
>  drivers/staging/r8188eu/core/rtw_xmit.c | 32 ++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 8 deletions(-)

I still have 12 patches in my queue from you, yet no idea which order
they belong in at all, nor which is the latest versions :(

Please rebase and resubmit them ALL as a single patch series so I can
have a hint as to what to do here.

thanks,

greg k-h
