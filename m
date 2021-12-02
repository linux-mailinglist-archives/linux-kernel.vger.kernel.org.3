Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F06466605
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358852AbhLBPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:02:41 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37452 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358838AbhLBPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:02:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 146D6CE230F;
        Thu,  2 Dec 2021 14:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E21C00446;
        Thu,  2 Dec 2021 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638457153;
        bh=2Nicqlk5acdh/oyplxOzIx5V4wwrXUEljmZvn/zboAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZO+k/OkZcnLVSeutskTq2FpYG29dsxsUBd6PygD3UPMRhywSxYFV2JXDBpiqT4XR3
         qVXViwnbvYOPYGXzz5zO44CCpMnE8Fwajg4hGopuIrvbxwMvHCgnF5JQ54MrDFiIgA
         m7eYY27zg1zpgw2TKE4+H1flKZTh5f508Z3wHgFi1pPV6jaG5DcmLAuWwPsQUo8fq1
         ta80xOUzSL2GXMcZHZaxmJt4XNQkpOCiTR8WIY8U32D8bU+sUDL2muTgBSQWp6I5r+
         Y1MMlTv2NZIDvz7zmsmFcHsSgYw/09RnQUdMWILc/9DLukttD08P1548T94VWHHHdJ
         Y6M87r/8lpiew==
Date:   Thu, 2 Dec 2021 20:29:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 15/20] media: imx290: mark read reg function as
 __always_unused
Message-ID: <20211202145906.GA263467@thinkpad>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
 <2471c2ecdf023fc3014d1ad544f2b0e9436fc9ff.1638179135.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2471c2ecdf023fc3014d1ad544f2b0e9436fc9ff.1638179135.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Mon, Nov 29, 2021 at 10:47:47AM +0100, Mauro Carvalho Chehab wrote:
> Such function is currently unused, but could be needed in the
> future. So, keep it, marking it as __always_unused, in order to
> avoid a clang W=1 error.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/
> 
>  drivers/media/i2c/imx290.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index bf7a6c37ca5d..99f2a50d39a4 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -363,7 +363,7 @@ static inline struct imx290 *to_imx290(struct v4l2_subdev *_sd)
>  	return container_of(_sd, struct imx290, sd);
>  }
>  
> -static inline int imx290_read_reg(struct imx290 *imx290, u16 addr, u8 *value)
> +static inline int __always_unused imx290_read_reg(struct imx290 *imx290, u16 addr, u8 *value)

Can we drop this function instead?

Thanks,
Mani

>  {
>  	unsigned int regval;
>  	int ret;
> -- 
> 2.33.1
> 
