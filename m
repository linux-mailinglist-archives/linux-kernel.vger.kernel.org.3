Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF66590911
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiHKXRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiHKXRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:17:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4A7A1A5B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D0E195C015C;
        Thu, 11 Aug 2022 19:16:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Aug 2022 19:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259809; x=
        1660346209; bh=581oZMKShZxT8Zn0zMTVJFcTkBUcW/2CxVH64DF0VuQ=; b=m
        rs6vrbJsfqGYoj2XllLGP6k0bBKIeQAXZq+8slnkzIt6qYpHeZEAveoCBv29EsKe
        6cwbZk4Lcaq3J4lyIHnjJOHF3tIEz6ytuFkazkLYiuCOb/ShDAehH+rou8pa0eqA
        rO1EHofDIIfRYsiCf7nnlVs2AN1L6tXN7XbdBa1mohCuFWbUDR0OX/c2q+h2C7A9
        DutPxAftBizB0uxlz1ZKes3fNpkhnsawhOQtZpzHYNIFanJuCZUW1XJPy3JSORhL
        i3rTSpkGLHxZLzHqWBPLR/2MLpZjkU4DlXipWLclUGG5WKh8RQR46oieP9NhYIq7
        /JLKstTjHUtZHGsMqsz/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259809; x=1660346209; bh=5
        81oZMKShZxT8Zn0zMTVJFcTkBUcW/2CxVH64DF0VuQ=; b=ruWSPI7GHkiJJtZH4
        YQ14GNsFKLV1B/p+GrExipeGWDt6nU2munMqzAgANctH2saJFTmNv+9qqn7n7DRt
        yj6/To9gMxrkV6xAJ69EAAT6jmg0K5pmfCQ0K586DPJzvlm+L9FqVrCZx53bAWsq
        c3aqjGn3ohc3m6CEqcpX58nm/VDaLGNPIqB8oiiBZv/dAXN72VB2xHZNlx01Qy+1
        3XWWBPjN0Vi1ngMF8aQt/cNzx+0St6g4Vdf+ELktsz9B8RSVhTZoeVWGSh3C+0Fv
        GWuClr51TgAOisHwT8JmBIhqAQ2faVVgaZxHUQRKjv5hA6tkXTYRDs4KWOedF9k5
        KHQBQ==
X-ME-Sender: <xms:4Y31YlTDZhDOS-HTMiLZueNG2o3I1lKHfIBHjhWVYoZ_ivFHkMGOQw>
    <xme:4Y31Yuy-pIC7tcjZAq1bs3jge-4C7MohSuY9RUPd6ZzPQqm8xYGzBKEn1haEq2P1O
    ioRxe1AwOa-RSIxZA>
X-ME-Received: <xmr:4Y31Yq2qnWr943T7BDsDFLM68-A1BGu22mbjyLGp5gn8SKYM19rE25vp5T0Q1FZkeXMT4gVD0cX6HMUSqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:4Y31YtCF2K4bNAku-_tiV6s2XJcwAPcIRs-I-FttzBCFi-2QC43K1g>
    <xmx:4Y31YuidbfKT7AP8V336d9RJLXtTh6gd2u6fz0gMAx-zRPP-3HhWDg>
    <xmx:4Y31YhpIUfcrrjg_FjyrCRoMuR_XQkShF8rlKAuTDVmYv9yYzHsj4w>
    <xmx:4Y31YjZ6l4aB9lfpSQYbMKOmEdugAe9txHmyzXLsnMNz4pZKz_8Qzw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:49 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 07/12] virtio: virtio_balloon: use pageblock_order instead of MAX_ORDER
Date:   Thu, 11 Aug 2022 19:16:38 -0400
Message-Id: <20220811231643.1012912-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811231643.1012912-1-zi.yan@sent.com>
References: <20220811231643.1012912-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

virtio_balloon used MAX_ORDER to report free page blocks to host, as
MAX_ORDER becomes modifiable in later commits, the reported free size might
be too big. pageblock_order is either 1/2 of or the same as MAX_ORDER
currently. Use pageblock_order instead to make virtio_balloon have a
constant free page block report size when MAX_ORDER is changed in the later
commits.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 5b15936a5214..51447737538b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -33,7 +33,7 @@
 #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN =
| \
 					     __GFP_NOMEMALLOC)
 /* The order of free page blocks to report to host */
-#define VIRTIO_BALLOON_HINT_BLOCK_ORDER MAX_ORDER
+#define VIRTIO_BALLOON_HINT_BLOCK_ORDER pageblock_order
 /* The size of a free page block in bytes */
 #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
--=20
2.35.1

