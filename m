Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814C5547F53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiFMGFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiFMGE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:04:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EBF1027
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=b1PoY1uKlcNqy2edTiTsVL/coyRDE9FCOo38ncps/ZM=; b=asqORLv9fFtRmH0mbdAsX62PEY
        2oM2wjfo4NwjYVsp3GvIcXnsJO9DKRj8XCXW1E4suTxpr2g8LP73vdRMEKnbzqlgoyXVfnbMS54bD
        FBTwd3vKQ1myxZku0vIkaOTi9LwMJKMefz6tfktugd6A88h7XFJ8zVDM64ozYM6Q5rABwX6AKb2fa
        8zxSLwNzq9CLLB7mjw/mVXMIKzM5UZnMYu4GyUGLrYpMbVB2c2wQRdURbri0g+CmKZJ4dWe95IH7X
        ApNaap56yK/FeNrP1odSM3lUI36xBVvmY3EYL/xIb/6e2D8T1L0tLE8e0+gIuJwvSLdsxahG1pSYz
        SAgdlhuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0dBu-001aZ9-At; Mon, 13 Jun 2022 06:04:46 +0000
Date:   Sun, 12 Jun 2022 23:04:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
        jgross@suse.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, sstabellini@kernel.org,
        mpe@ellerman.id.au, konrad.wilk@oracle.com, mst@redhat.com,
        jasowang@redhat.com, joe.jin@oracle.com
Subject: Re: [PATCH RFC v1 4/7] swiotlb: to implement io_tlb_high_mem
Message-ID: <YqbTfi/h2P24ynQZ@infradead.org>
References: <20220609005553.30954-1-dongli.zhang@oracle.com>
 <20220609005553.30954-5-dongli.zhang@oracle.com>
 <YqF/sphJj6n+22Si@infradead.org>
 <e6345c27-78fd-be72-9551-1d1fd5db37a4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6345c27-78fd-be72-9551-1d1fd5db37a4@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 02:56:08PM -0700, Dongli Zhang wrote:
> Since this patch file has 200+ lines, would you please help clarify what does
> 'this' indicate?

This indicates that any choice of a different swiotlb pools needs to
be hidden inside of ѕwiotlb.  The dma mapping API already provides
swiotlb the addressability requirement for the device.  Similarly we
already have a SWIOTLB_ANY flag that switches to a 64-bit buffer
by default, which we can change to, or replace with a flag that
allocates an additional buffer that is not addressing limited.
