Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C1A4DA066
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347274AbiCOQtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbiCOQtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:49:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C5443EA;
        Tue, 15 Mar 2022 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NQX8+5nySoNC5mbdZyl6P/Zb6lIGsr4OoSrqjyhxvFw=; b=WN66xSNv72R+8NnaTfLzcrmyQO
        dAwotE14FKTGCz/uOjsYeQmg2LKaBIoVUXeWVAM2noGxnlHiSuHfR0AB+gAfHd8nvl5en038lksxF
        LXDGlF+pcQOtLVtep0t4W1tJdCRVyJNjxqB2ZPg3QUaoTdV8BP/8J/BT3EPRVq72S54CpJHCS3Zel
        0/fYGYJstPcOzvmVcJ6zVZLne91GPKNaxPSDDkJsbAnyPY3mOKuvGwFm/0fIHBYXK0AIevXhzU8Tq
        W2Icp+694MKqfFnuq6/yIXQdG1pd+bAX50OTj/1Zls1rWu4NoKzA+lPw4kQE1+Npdcv89+oMiPxrg
        GpWZr+/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUALJ-009vSs-AR; Tue, 15 Mar 2022 16:48:17 +0000
Date:   Tue, 15 Mar 2022 09:48:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Message-ID: <YjDDUUeZ/dvUZoDN@infradead.org>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
 <20220315162455.5190-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315162455.5190-2-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:24:55AM -0500, Mario Limonciello wrote:
> -	 * handled natively using IOMMU. It is enabled when IOMMU is
> -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> +	 * handled natively using IOMMU. It is enabled when the IOMMU is
> +	 * enabled and either:
> +	 * ACPI DMAR table has DMAR_PLATFORM_OPT_IN set
> +	 * or
> +	 * ACPI IVRS table has DMA_REMAP bitset
>  	 */
>  	return sprintf(buf, "%d\n",
> -		       iommu_present(&pci_bus_type) && dmar_platform_optin());
> +		       iommu_present(&pci_bus_type) &&
> +		       (dmar_platform_optin() || amd_ivrs_remap_support()));

Yikes.  No, the thunderbot code does not have any business poking into
either dmar_platform_optin or amd_ivrs_remap_support.  This needs
a proper abstration from the IOMMU code.
