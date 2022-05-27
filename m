Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2415368AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbiE0V7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiE0V7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AE36622F;
        Fri, 27 May 2022 14:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF7BB60F8C;
        Fri, 27 May 2022 21:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818D8C385A9;
        Fri, 27 May 2022 21:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653688757;
        bh=4FvFvuXe3XVJOjCGf3wxjlycHrRIVzIS0OCClcaFxY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIYECQug6gWaqXvoyMN2ql5uhxF8iaevpQj9AgmtqMeaOFArgmCGAIUXhmpnTl2d6
         ix6vehfeSuJpBdxOorQJRXqI9NMRhViGFRsXbh5vpQWgcpxkIbR2lWPd+FdiWqv0fp
         t2dvdQBO/8mWaAnIBs78jdis6ps6pL5y9OmnQ9ORp0wo1pi0GebPufqSHDoOrgVawr
         iWNUX1qGJWh51d+N38NuoHeFBcP74pHp9SZUuZVT4X3r3idpJRUdeZfNUWPunu8TEt
         C9P3b8NbwnJBJaitfNdNadB/tb/aWV7lEq9fDK0W4fnEcQn2hjz3MBFiP2pDqU+RAP
         B+3+9hl03qjJw==
Date:   Fri, 27 May 2022 17:08:54 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] media: amphion: Replace zero-length array with
 flexible-array member
Message-ID: <20220527220854.GA72220@embeddedor>
References: <20220527212953.797574-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220527212953.797574-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:29:53PM -0700, Kees Cook wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should no
> longer be used[2][3].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> [3] https://github.com/KSPP/linux/issues/78
> 
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Cc: Ming Qian <ming.qian@nxp.com>
> Cc: Shijie Qin <shijie.qin@nxp.com>
> Cc: Zhou Peng <eagle.zhou@nxp.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/media/platform/amphion/vpu_dbg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
> index da62bd718fb8..f72c8a506b22 100644
> --- a/drivers/media/platform/amphion/vpu_dbg.c
> +++ b/drivers/media/platform/amphion/vpu_dbg.c
> @@ -27,7 +27,7 @@ struct print_buf_desc {
>  	u32 bytes;
>  	u32 read;
>  	u32 write;
> -	char buffer[0];
> +	char buffer[];
>  };
>  
>  static char *vb2_stat_name[] = {
> -- 
> 2.32.0
> 
