Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048BA4AB4D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352329AbiBGGhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiBGGdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:33:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D785C043187
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wqaArwblmIFSHxUdNBNekbGuuQV19X++bRGa4XtI21U=; b=lxdZaX9HdECBxS8xbH3caitLbH
        PgJ/rcSWAsPKp0w4j5ndf9woh4inxdIS2JIDFXPeAEbv6jdzH9Jo2ntSfHkuj6mUQ7HTrOAokh5qc
        4is/Xb5dtZG07+ioaAog0Tey/v1edHRBpVlQ/9G50rLriinhvV/d9n8u3P6DkytAHoAIRzQrVcWVu
        qUeK/m7kl6g5AO82aINiKwrYAOVXXo11IEJlHfxptb1ZQ4JeiUUJojms+atQUIJLsKgoZPQaQcKqS
        Ppu19zrTCt3BV/fiLaL5lgHLtEmxSGihd4Tx+0ttgGEEJ7i2vxcU+OqN3HDnjubScKNcKlfoiC4Nm
        uoHWy8CQ==;
Received: from [2001:4bb8:188:3efc:2cbe:55d7:bb63:46d2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGxa4-0099Hh-Pj; Mon, 07 Feb 2022 06:32:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: [PATCH 2/8] mm: remove the __KERNEL__ guard from <linux/mm.h>
Date:   Mon,  7 Feb 2022 07:32:43 +0100
Message-Id: <20220207063249.1833066-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207063249.1833066-1-hch@lst.de>
References: <20220207063249.1833066-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__KERNEL__ ifdefs don't make sense outside of include/uapi/.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b19223..7b46174989b086 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,9 +3,6 @@
 #define _LINUX_MM_H
 
 #include <linux/errno.h>
-
-#ifdef __KERNEL__
-
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
 #include <linux/bug.h>
@@ -3381,5 +3378,4 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
-- 
2.30.2

