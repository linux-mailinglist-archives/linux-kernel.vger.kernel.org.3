Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9654CA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbiFONnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiFONnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:43:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835F72459D;
        Wed, 15 Jun 2022 06:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9m0Yel3mKJUR0/9WLy9YG0v6kS0HnL5HFztBLkukfhU=; b=l5pMXoObGe9qCoN1JNmE4rMH8z
        CptrHdOdY0cHpAWepueUiYpA9ETdVP8UOjDY3K6o2t+eaxcm3lmVTzhQfxmAiRDh5s6GklPirU7qc
        7ItQTcUBhxkYiBo455aSSoG68s+N4EKRxBFhfDWelNWPOE1w3kOg0eYS18ESpI2iQwLAJHWmsN4iF
        PdbDG+CjA5QulntLirJsSzM9fKo7qUXPNgDWagSbJtr5R4znSLP1Gra8zg/HL7JXLdR/QCQHPggMG
        3j2UL7hEyIHJ8BuZ8rshW8HmAUOh7wJO1zCXDgpfqC3zV/6c6BS72/yDmGVaddn7Zq5ycCgaZ4DNy
        cpqCY3lA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1TIc-00ElmM-Nl; Wed, 15 Jun 2022 13:43:10 +0000
Date:   Wed, 15 Jun 2022 06:43:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
Message-ID: <Yqnh7vjO8iT4/fiK@infradead.org>
References: <20220615084835.27113-1-jgross@suse.com>
 <YqnBZhiLOHnoalbC@infradead.org>
 <9b9785f5-085b-0882-177f-d8418c366beb@suse.com>
 <YqnCZ+EKZeZ5AEnr@infradead.org>
 <c5a521e0-26b1-b1d6-7f7d-00aa9b4b1e0e@suse.com>
 <YqnIWCXxsGzkfQp7@infradead.org>
 <ab0653bc-7728-e24c-5d83-78cee135528c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0653bc-7728-e24c-5d83-78cee135528c@suse.com>
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

On Wed, Jun 15, 2022 at 02:53:54PM +0200, Juergen Gross wrote:
> On 15.06.22 13:54, Christoph Hellwig wrote:
> > On Wed, Jun 15, 2022 at 01:39:01PM +0200, Juergen Gross wrote:
> > > No, it doesn't. I'm working on a qemu patch series enabling the qemu
> > > based backends to support grants with virtio. The code is working fine
> > > on x86, too (apart from the fact that the backends aren't ready yet).
> > 
> > The code right now in mainline only ever sets the ops for DMA.  So
> > I can't see how you could make it work.
> 
> Ah, you are right. I was using a guest with an older version of the series.
> Sorry for the noise.

No problem.  But whatever you end up using to enable the grant DMA
ops n x86 should also require the platform access feature.  We already
have that information so we can make use of it.
