Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE059B912
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiHVGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiHVGNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:13:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034CB27148
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mWUQq70yU0I2cyOvo8NkbnC9iH3zHKYlyBQj2VYx1S0=; b=SAB4w5C6FM47lQyYqSK6j/E7+7
        6i8XUufkz3arWDAoiYaLVNiC0LIYIvU8Yy03CRNUOCFcaI7gplRlC2IkMxnF5vmnvbhy9s06lppZQ
        X7bIeHrStEHKN9OLyG4c8h1bzPfGDRtedih8qyeCsrODveuQxhSIUweCjLV61D+OK6a12hnAl1KAO
        GpXYL0Z03WqmbApI6NHA8ZFMxN/jJ7BNJNIhNHMnr5UDk0OqQ3r8UmcRjZyFRrYMUnHsHVbJWmHgR
        7VC05LlE2K2EUR8P/tMzKbyyLBWaikI8CBTTQQQ1z6c2oXtgqT+Au2Dg2O8/Kti6kSVebbDXbZ+6F
        +dYiFWcA==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ0gD-005KZq-Jg; Mon, 22 Aug 2022 06:12:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: fix dma coherent pool sizing
Date:   Mon, 22 Aug 2022 08:12:52 +0200
Message-Id: <20220822061255.151688-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 pool.c |   56 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 23 deletions(-)
