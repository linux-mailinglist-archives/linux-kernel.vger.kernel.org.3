Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0891C57E317
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiGVOhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:37:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108A7FE5F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:37:16 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2FF685D1; Fri, 22 Jul 2022 16:37:15 +0200 (CEST)
Date:   Fri, 22 Jul 2022 16:37:13 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Disable guest vapic logging during early
 kdump init
Message-ID: <Ytq2GRX7UJjvXk4w@8bytes.org>
References: <20220721003439.403435-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721003439.403435-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 05:34:39PM -0700, Jerry Snitselaar wrote:
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 1d08f87e734b..2b00d7f28df7 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -815,6 +815,11 @@ static void free_ga_log(struct amd_iommu *iommu)
>  #endif
>  }
>  
> +static void iommu_ga_log_disable(struct amd_iommu *iommu)
> +{
> +	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
> +}
> +
>  static int iommu_ga_log_enable(struct amd_iommu *iommu)
>  {
>  #ifdef CONFIG_IRQ_REMAP
> @@ -2504,6 +2509,7 @@ static void early_enable_iommus(void)
>  		for_each_iommu(iommu) {
>  			iommu_disable_command_buffer(iommu);
>  			iommu_disable_event_buffer(iommu);
> +			iommu_ga_log_disable(iommu);
>  			iommu_enable_command_buffer(iommu);
>  			iommu_enable_event_buffer(iommu);
>  			iommu_enable_ga(iommu);

Looks about right, but I also let Suravee comment on this.

Disabling the GA-Log under a device still using it should hopefully not
put it into some undefined state.
