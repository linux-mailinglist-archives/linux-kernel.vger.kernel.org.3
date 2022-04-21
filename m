Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3601509ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386728AbiDUIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386695AbiDUIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:36:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEEB1C128
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BA85B8237E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71689C385A1;
        Thu, 21 Apr 2022 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650530032;
        bh=p6bgQ7Z9qqrV3XSCYlYFJ6UsMOIanchbxmGz7bNMIOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjZV1eFzBSUr3Vu8AH+Km5fn5LKTLHbTAvPAkvFETrl8aUafFNgofCy+nn6Oa+Y7z
         MnpovExZj+Ez7OOZUbUBVShphPsWnxoHCF9F53/WfTFeXqCP/sc+pLb0zAxuv+xhSk
         PfVgh+6DweF7ldJAn2KsMG/iCj5TVX14H56FqR8TX38Fmy7jDiTOmmkTRJUznqOOpu
         Q8WYLA7lACCNlSEK8wbDHE4PZzUbWMZIItAybWjunGgCpboMyN/ctvHIy33MnCRpN3
         rbe2fhpY0FtQQj6xO3hnjxzUy2HEXfF/q/SvD0LMaBpCb4nTF8+XWJ93KhOoCiV4Rd
         hV+IWiSNlneKg==
Date:   Thu, 21 Apr 2022 09:33:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        sven@svenpeter.dev, robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] iommu/arm-smmu: Clean up bus_set_iommu()
Message-ID: <20220421083345.GA8303@willie-the-truck>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <2e59602d982fd4941ec923571940fa3c628b2188.1649935679.git.robin.murphy@arm.com>
 <20220419144042.GA6186@willie-the-truck>
 <5ae51610-5027-777e-36e3-7bdb92e00752@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae51610-5027-777e-36e3-7bdb92e00752@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 05:05:03PM +0100, Robin Murphy wrote:
> On 2022-04-19 15:40, Will Deacon wrote:
> > On Thu, Apr 14, 2022 at 01:42:33PM +0100, Robin Murphy wrote:
> > > Stop calling bus_set_iommu() since it's now unnecessary. With device
> > > probes now replayed for every IOMMU instance registration, the whole
> > > sorry ordering workaround for legacy DT bindings goes too, hooray!
> > 
> > Ha, I hope you tested this!
> 
> Oh alright then, since it's you... :)
> 
> I've hacked up a Juno DT with the old bindings, and (after needing a while
> to remember that they're fundamentally incompatible with disable_bypass),
> can confirm that with my whole dev branch including this series applied, it
> boots and creates IOMMU groups as expected. I then made the mistake of
> trying without the branch to check whether the squawks from
> iommu_setup_dma_ops() were new or not, and... well... plain rc3 doesn't even
> boot on the same setup - it's somehow blowing up in the failure cleanup path
> of iommu_bus_init(), apparently calling iommu_release_device() on something
> where dev->iommu->iommu_dev is NULL, for reasons that are far from clear and
> I'm not sure I can really be bothered to debug further... :/

Great, so your series is a fix!

Will
