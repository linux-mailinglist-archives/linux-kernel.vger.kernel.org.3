Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15066512DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiD1IHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiD1IHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:07:14 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297EA92330;
        Thu, 28 Apr 2022 01:04:01 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C205F452; Thu, 28 Apr 2022 10:03:59 +0200 (CEST)
Date:   Thu, 28 Apr 2022 10:03:58 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     xkernel.wang@foxmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, will@kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/msm: add a check for the return of kzalloc()
Message-ID: <YmpKbu4NOIHLQsvW@8bytes.org>
References: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:08:01AM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/iommu/msm_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 3a38352..697ad63 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -597,6 +597,10 @@ static void insert_iommu_master(struct device *dev,
>  
>  	if (list_empty(&(*iommu)->ctx_list)) {
>  		master = kzalloc(sizeof(*master), GFP_ATOMIC);
> +		if (!master) {
> +			dev_err(dev, "Failed to allocate iommu_master\n");
> +			return;
> +		}

This is not enough, if the error happens it also need to be propagated
to the caller.

Regards,

	Joerg
