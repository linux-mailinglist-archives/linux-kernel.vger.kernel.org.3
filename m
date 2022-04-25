Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA550E332
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbiDYOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiDYOeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:34:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280D7286EF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:31:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D32C5C0164;
        Mon, 25 Apr 2022 10:31:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Apr 2022 10:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1650897092; x=1650983492; bh=RypWuAcjXYhvuMrAXCozdcgxcIlBzpaT89Q
        2nmHZmv8=; b=D5uhdhKfZsWZJIiNwrYTpLyeejy7tifoZrD6Jw6grTvCevtOo4+
        pukYeJ21+jwXCD+HCsI55c35QRp5sWWgm8OyZ3kQfjZsEoRYTUvvREu9c6MIRD30
        6SnY7hWWIriRowoJTvWDWeVPvDtruV/xjyY/Xeyk/I3IOonR++GQFuVlN4/BTbWt
        ULB7LF6lYWoMY1ci0hLEYjwQSOBkqxNPjowExCj5PePqS8iNfs0K528zvw1bG5SU
        CrmXHo5p4mf8H6sni0AW8DRIzFjTuxWuc/eJq7cFDGPNz6zEduG/HIlnJvCFO8ij
        VoVxTsqYjmWNmTNB1r6p9sMbKjMJUOfIk6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650897092; x=1650983492; bh=R
        ypWuAcjXYhvuMrAXCozdcgxcIlBzpaT89Q2nmHZmv8=; b=vw2kQpwrp/ECD/KAm
        wvBZK1OZK+1cr/Lx5BBB62qILIkfjHbsGZlNwfwXg+R6orfq1W9q9vB9nx6rSTE/
        0SyywO0ZXE+iYjvHkK9JP2uwtJCB4XIWHjlzq/CaEpiKXuZ0Yi73Cflu7T72sFvR
        6g1aauAs+mT6R47rpLO6hn4qm+WH4dIU4rhCONK6zvOFtSkk9P2QfjxI81ygOeRk
        U2qwEIznwcMRQjYI6MnsoxuU0C4Zec77ilUjwOs5qsLFU9a5JLmDOfRveD+j9XAB
        pdZ+PaJlfmn1www5IS6myrcgId2ng4tdyFWWm+V13tFb7uZ+tsMzUnBFooIhO549
        aAZ9Q==
X-ME-Sender: <xms:xLBmYk-3aioErbE2FmVghcnXJJ19PHgv4GsHQq9Po1LehdtwdKlcqA>
    <xme:xLBmYssi67ZEmj1WON6VUj6_CFt4gUT_iKMpg5X0JxD7Wp5GeZzKu35_9-5HkW20r
    lSxKjDU-RFNKA8EUA>
X-ME-Received: <xmr:xLBmYqCK5Df2EfKfYyl-rSVfrlS_VYfwompN_1mSKRB3-tzvpRTCC8uuOGzxkfegFhgyR27MlpbEkqWjpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddugdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeevhe
    evleehgfduhffhudefteehhfegjeeiudevheevffetuedttdfhkeeuleehudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:xLBmYkcyPvHuTjDSsqEAtDTEr_MIX9lZKZ-pfM3AnFJdAWs-zaJbiA>
    <xmx:xLBmYpP2XsBSpEsQQcl2iYWqVRagOb73o-M12e4NtpqZlSLPpXA9sA>
    <xmx:xLBmYumqYYQmcJf7VIP6Veodr_tX_0NgpMoEdpbvQBWGNZvaWvmAVA>
    <xmx:xLBmYqFTDAH3T3rJAI0qHHcJDQiN67BJBqWlI27zckTN_PhT13BITg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Apr 2022 10:31:31 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v11 6/6] drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
Date:   Mon, 25 Apr 2022 10:31:18 -0400
Message-Id: <20220425143118.2850746-7-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425143118.2850746-1-zi.yan@sent.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

alloc_contig_range() now only needs to be aligned to pageblock_nr_pages,
drop virtio_mem size requirement that it needs to be MAX_ORDER_NR_PAGES.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e7d6b679596d..e07486f01999 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2476,10 +2476,10 @@ static int virtio_mem_init_hotplug(struct virtio_me=
m *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
=20
 	/*
-	 * TODO: once alloc_contig_range() works reliably with pageblock
-	 * granularity on ZONE_NORMAL, use pageblock_nr_pages instead.
+	 * alloc_contig_range() works reliably with pageblock
+	 * granularity on ZONE_NORMAL, use pageblock_nr_pages.
 	 */
-	sb_size =3D PAGE_SIZE * MAX_ORDER_NR_PAGES;
+	sb_size =3D PAGE_SIZE * pageblock_nr_pages;
 	sb_size =3D max_t(uint64_t, vm->device_block_size, sb_size);
=20
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
--=20
2.35.1

