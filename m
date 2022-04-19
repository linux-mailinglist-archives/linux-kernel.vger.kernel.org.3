Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42D4507A98
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356474AbiDSUFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356453AbiDSUFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:05:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030CE2C669
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:02:36 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d9so71056qty.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6CDFEYPwind4oeNceo60bPcQaOBxmMPkcuZbyCW2XIc=;
        b=H6yzMlPIaCOW2L5SHT3adB0uN2T9slwU5Iqe4dM8H4xTO8eaGW8mmBPQNO5u/dxvkl
         j4K/dCwo+7rJK16wapkl8JEq7Xup/2+ubrRlqIiM8CisNBTobQHCV18/Azq18CqJEvu2
         U/DXOVkogz+Erij+giIZb55ed9LnluaEj7E8Kc/0kLJ04uuKsy3Iks0wkbeZdX7R+AY6
         eBD4dr5Ne1ez/yfVqghpn2MQ1N9CwbfOFYNXi2oh/cN4rbw9Iw+6As3dCXS3zOvMDZnD
         xhNAP56KX3JKYi5ggqpejQ8fFPVseY4nHQ2AzyNsIU/8GVggvLB4JKnezC1XK0f+ddBE
         Nd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6CDFEYPwind4oeNceo60bPcQaOBxmMPkcuZbyCW2XIc=;
        b=4NZLc8O9/+rlIkKKSyK8mAWh3Qmek7mptJ6UQNG2yGTfbHxWoFTVNqvRK1598VA2NQ
         brWLy7XcKKkmFIe+99ypoeHzjOB3133c70jgYN4mmEY2MZmpLlydDu3wYfmekZIdnI7G
         AUHN5SBlqSlAzlIJPbimiZrF7DywT/y20VEUFEeBWAN3UnnYL2apokZ9HRsEG/xLA9VZ
         xdkFVCETHdfUrjQIo8QKFqUVuqBAr1+8WCSEH11m4pv9SO/voxSkOUZsyh4GuJKW89Mr
         e153Xxhoaf26VcmdrRPZbahbpMjlCnQvyR0K8wW0ytv43yaGgodgrduGTdHb7dithAGW
         zcZA==
X-Gm-Message-State: AOAM531n/TdUGcYHWxxGXH/iZcFhzOg3YkS6JAv9TMxfB9lxVaSHGmTu
        BibHzpq0G6Cd2uKgMNsqQK0+tXg0Cu6jnQ==
X-Google-Smtp-Source: ABdhPJxDoOZBm5NJUNt0Lmrkf9wvSWVfT2Aj29QkkmYznu4GEo/xOWzCwWugY9BzCInq4cE1rBPXWA==
X-Received: by 2002:ac8:5c8a:0:b0:2e1:a65f:5122 with SMTP id r10-20020ac85c8a000000b002e1a65f5122mr11583018qta.239.1650398555129;
        Tue, 19 Apr 2022 13:02:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a28-20020a05620a02fc00b0069e8e766a0csm457007qko.94.2022.04.19.13.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:02:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ngu3V-005KB2-HU; Tue, 19 Apr 2022 17:02:33 -0300
Date:   Tue, 19 Apr 2022 17:02:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org, thunder.leizhen@huawei.com, tglx@linutronix.de,
        john.garry@huawei.com, jean-philippe@linaro.org,
        christophe.jaillet@wanadoo.fr,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Message-ID: <20220419200233.GN64706@ziepe.ca>
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
 <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
 <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
 <Yloj6GM+yykImKvp@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yloj6GM+yykImKvp@Asurada-Nvidia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 07:03:20PM -0700, Nicolin Chen wrote:

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index d816759a6bcf..e280568bb513 100644
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -183,7 +183,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>  {
>         struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
>         struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> -       size_t size = end - start + 1;
> +       size_t size = end - start;

+1 to this bug fix. You should send a formal patch for stable with a fixes/etc

mmu notifiers uses 'end' not 'last' in alignment with how VMA's work:

include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address

Jason
