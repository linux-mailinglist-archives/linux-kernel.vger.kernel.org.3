Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27552596925
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbiHQGHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiHQGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:07:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAA16DF94
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=l6ch1yePjEdG0LmVNEefnc3mognlEW6uEpIRnYmSquI=; b=uP6k6PHyLH765XsfuFSU+OfUkl
        ipkxVfR39RVgw0I0sRf148OKdgLDkwNAfXqTGRCLfFZAmhXfbzY9fGolS7x5PaO7UYpcU8DOdpVoD
        xXslWmVuAd7NzVdzHro2KOL/puDe9A9HmpcRd8bUCqfdWN0Fdg8PKooj4mkR4I6paqnYEW0YNz6eV
        XGxPj86GD63zimN0uJJpP/+pjGYLx0NbV5/MFkDTHSlBP7ado7oQA3XmU+Wye/HRjQDxrlub08S9Z
        MxVOlmV9ekpTz13qOmnBp/sU7dA0ffWLQk82PInfufve+GR4SCQrJ60BpE9MUyFBLoF1QCZqQbgoR
        cNVNX04w==;
Received: from [2a02:1210:321a:af00:5fac:fede:a3b:c715] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOCCT-00BeDu-CB; Wed, 17 Aug 2022 06:06:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: fix dma coherent pool sizing
Date:   Wed, 17 Aug 2022 08:06:44 +0200
Message-Id: <20220817060647.1032426-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Michal pointed out that the sizing of the dma coherent pools is bonkers
as it uses the total memory to size the pool for each zone, which leads
to comically larger zones for the 16-MB ZONE_DMA on x86, which tends
leads to allocation failure warnings.  This series switches to sizing
the ZONE_DMA and ZONE_DMA32 pools based on the number of pages that
actually reside in those zones instead.

Diffstat:
 pool.c |   65 +++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 24 deletions(-)
