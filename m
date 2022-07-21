Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F41857D57E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiGUVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUVFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:05:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45641EED4;
        Thu, 21 Jul 2022 14:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E570FCE2730;
        Thu, 21 Jul 2022 21:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4B6C3411E;
        Thu, 21 Jul 2022 21:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658437549;
        bh=um1UDUnWaoZYuOrfSJS2U4SJxNiJE4HvKi20iSdo2pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOyDW1eJH30tU0DxQO+zsRiGRXqZkBYqclkyZSaoOCXuf3WPvQy5M+LJ/uqOzwgqF
         Zp5s3t/LMWHdrf7p/dAIQYo8Yh/3UrAbpXY/jmZ1jBn96vMnHiFNhWVcsZCeGa4irh
         gCUVznrVdzw7PDBvzbrZjNXtQFqjKWp5YhWsiyriLVBYK8jU9RUWGhVLfF62pP1ENw
         Tb22Cx22Nm8dCEBNaXw+taG+IReYSgK4qcyuWxmOojwa9lDMJwB0cboFjL3TYNI3Hd
         Ep1un40W6ZYuj03aJSsVkP6rfpGPrfGTjzvIROOJ3+ZG3RxMaMNaJJeIP0vn6/XtYy
         AGaYOlKJpHZBA==
Date:   Thu, 21 Jul 2022 14:05:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] drivers: iommu: fix clang -wformat warning
Message-ID: <Ytm/qj2ozeSY0a3Y@dev-arch.thelio-3990X>
References: <20220721210331.4012015-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721210331.4012015-1-justinstitt@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 02:03:31PM -0700, Justin Stitt wrote:
> When building with Clang we encounter the following warning:
> | drivers/iommu/msm_iommu.c:603:6: error: format specifies type 'unsigned
> | short' but the argument has type 'int' [-Werror,-Wformat] sid);
> 
> `sid` is an int, use the proper format specifier `%x`.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Reported by Nathan here:
> https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/
> 
>  drivers/iommu/msm_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 428919a474c1..6a24aa804ea3 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -599,7 +599,7 @@ static int insert_iommu_master(struct device *dev,
>  
>  	for (sid = 0; sid < master->num_mids; sid++)
>  		if (master->mids[sid] == spec->args[0]) {
> -			dev_warn(dev, "Stream ID 0x%hx repeated; ignoring\n",
> +			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
>  				 sid);
>  			return 0;
>  		}
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 
> 
