Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B7570BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiGKUc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiGKUcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5855E009
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657571462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKJ4oj2UiV/tUg28XSAFfYDURbHg6O4Bi1B7FR3XWgQ=;
        b=CUCtbNsP4NKalLuuChCo12v9tcxmh5gIHlEoDpDNRqLxtM6JIh0/D1UeUvIZ92hT6pr4dv
        KITH2qiqxVmU1V1eACjpgxDae947/gyTRRlEXjxtgoOlJ90yFlD0SiksD6kyRLHZtysBbu
        J9fLKYl7Bi9xxN6V8aazmN74NjpKvqU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-n-gZLs3CPPO6cRTJza7piw-1; Mon, 11 Jul 2022 16:30:53 -0400
X-MC-Unique: n-gZLs3CPPO6cRTJza7piw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57C74801590;
        Mon, 11 Jul 2022 20:30:53 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BFCC18EA8;
        Mon, 11 Jul 2022 20:30:53 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26BKUrXb005616;
        Mon, 11 Jul 2022 16:30:53 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26BKUqlo005612;
        Mon, 11 Jul 2022 16:30:53 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 11 Jul 2022 16:30:52 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Mike Snitzer <msnitzer@redhat.com>
cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: [PATCH 2/4] dm-writecache: count the number of blocks read, not the
 number of read bios
In-Reply-To: <alpine.LRH.2.02.2207111627260.5249@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2207111630310.5249@file01.intranet.prod.int.rdu2.redhat.com>
References: <20220706093146.1961598-1-yukuai1@huaweicloud.com> <alpine.LRH.2.02.2207111627260.5249@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change dm-writecache, so that it counts the number of blocks read instead
of the number of read bios. Bios can be split and requeued using the
dm_accept_partial_bio function, so counting of bios provided inaccurate
results.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Yu Kuai <yukuai1@huaweicloud.com>

Index: linux-2.6/drivers/md/dm-writecache.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-writecache.c
+++ linux-2.6/drivers/md/dm-writecache.c
@@ -1365,6 +1365,7 @@ read_next_block:
 		}
 	} else {
 		writecache_map_remap_origin(wc, bio, e);
+		wc->stats.reads += (bio->bi_iter.bi_size - wc->block_size) >> wc->block_size_bits;
 		map_op = WC_MAP_REMAP_ORIGIN;
 	}
 
Index: linux-2.6/Documentation/admin-guide/device-mapper/writecache.rst
===================================================================
--- linux-2.6.orig/Documentation/admin-guide/device-mapper/writecache.rst
+++ linux-2.6/Documentation/admin-guide/device-mapper/writecache.rst
@@ -78,8 +78,8 @@ Status:
 2. the number of blocks
 3. the number of free blocks
 4. the number of blocks under writeback
-5. the number of read requests
-6. the number of read requests that hit the cache
+5. the number of read blocks
+6. the number of read blocks that hit the cache
 7. the number of write requests
 8. the number of write requests that hit uncommitted block
 9. the number of write requests that hit committed block

