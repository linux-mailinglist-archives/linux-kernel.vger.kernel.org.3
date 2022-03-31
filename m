Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD04E4ED2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiCaEVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCaEVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:21:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EF022F3EB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TyI6lSLb2VMNQkD37oAbbw8GrUUXDy6JGKq3S68+GAs=; b=N2RXeHOlVWMotZnWmDzYjFmRvE
        1rwxS4cCRHz+rrLZW3bq1Klzv9tSR/P+pFfwJduGkx/RHOrXbiCGigZQezP+2RVGDrWeUW6b4ldS7
        Et5MhqtaU7oAaftlUdnP24FfW5v95xyYRqsGlVWKkHMEECZwvSZ3Xeu+n9h9yLangvp/XsKl9mWvO
        /5GM1jSiGKNMTxt2HGVyV0jgNaRgnd9B0SkYHVtMI7oHPcViliW7Dt7dpLkQub0DtM1tpkHMAr5E6
        3QoetEDLgY2g5033b79N10yje6RFYtjVWzlHVxBAlO11pMWi5ASbag1mt5Ugh5T1eB3zc0mC0GmAT
        y8Pda/ZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZm71-000atJ-TS; Thu, 31 Mar 2022 04:08:43 +0000
Date:   Wed, 30 Mar 2022 21:08:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
Message-ID: <YkUpSy4snmZ7E5xX@infradead.org>
References: <1648659326.eabkokyuym.none.ref@localhost>
 <1648659326.eabkokyuym.none@localhost>
 <YkSa9d3JOExAiBXU@infradead.org>
 <1648667469.u35o6clg82.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648667469.u35o6clg82.none@localhost>
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

On Wed, Mar 30, 2022 at 03:17:20PM -0400, Alex Xu (Hello71) wrote:
> Excerpts from Christoph Hellwig's message of March 30, 2022 2:01 pm:
> > Can you try this patch, which is a bit of a hack?
> > 
> > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > index 50d209939c66c..61997c2ee0a17 100644
> > --- a/arch/x86/mm/mem_encrypt.c
> > +++ b/arch/x86/mm/mem_encrypt.c
> > @@ -28,7 +28,8 @@ bool force_dma_unencrypted(struct device *dev)
> >  	 * device does not support DMA to addresses that include the
> >  	 * encryption mask.
> >  	 */
> > -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> > +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) &&
> > +	    !get_dma_ops(dev)) {
> >  		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> >  		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> >  						dev->bus_dma_limit);
> > 
> 
> This seems to work for me.

Ok, I'll try to come up with a less hacky version and will start a
discussion with the AMD folks that know memory encryption better.
Thanks for the report and testing already!
