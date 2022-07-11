Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ACA570BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiGKUcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiGKUcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B00E28053C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657571518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MaqOIGg6xgZBfAmnDVAtLCB8oPOY5LSspAi0WrEqOzs=;
        b=FMqGAEyS7C49ycMA7J9KcKwqCo4MajNnS5YvZGNsOVXcpD/W2fg1AlR7S3+ga6PtVh9whG
        1Of8l2/owdTZWjaUOCqbttGkK3W+uQ6ZjIicLc9w/Ss7+v1X21pM4POfU+f0sPxx2LAFvI
        xqvtSUDhxBY9M2nhNczQpybXDfsSJOE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-PwhzJposNP--KzvI3NNIaw-1; Mon, 11 Jul 2022 16:31:52 -0400
X-MC-Unique: PwhzJposNP--KzvI3NNIaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CC1E2803025;
        Mon, 11 Jul 2022 20:31:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 529DCC15D58;
        Mon, 11 Jul 2022 20:31:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26BKVqfE005700;
        Mon, 11 Jul 2022 16:31:52 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26BKVqBw005696;
        Mon, 11 Jul 2022 16:31:52 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 11 Jul 2022 16:31:52 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Mike Snitzer <msnitzer@redhat.com>
cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: [PATCH 4/4] dm-writecache: count the number of blocks discarded,
 not the number of discard bios
In-Reply-To: <alpine.LRH.2.02.2207111627260.5249@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2207111631360.5249@file01.intranet.prod.int.rdu2.redhat.com>
References: <20220706093146.1961598-1-yukuai1@huaweicloud.com> <alpine.LRH.2.02.2207111627260.5249@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change dm-writecache, so that it counts the number of blocks discarded
instead of the number of discard bios. Make it consistent with the read
and write statistics counters that were changed to count the number of
blocks instead of bios.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6/drivers/md/dm-writecache.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-writecache.c
+++ linux-2.6/drivers/md/dm-writecache.c
@@ -1514,7 +1514,7 @@ static enum wc_map_op writecache_map_flu
 
 static enum wc_map_op writecache_map_discard(struct dm_writecache *wc, struct bio *bio)
 {
-	wc->stats.discards++;
+	wc->stats.discards += bio->bi_iter.bi_size >> wc->block_size_bits;
 
 	if (writecache_has_error(wc))
 		return WC_MAP_ERROR;
Index: linux-2.6/Documentation/admin-guide/device-mapper/writecache.rst
===================================================================
--- linux-2.6.orig/Documentation/admin-guide/device-mapper/writecache.rst
+++ linux-2.6/Documentation/admin-guide/device-mapper/writecache.rst
@@ -87,7 +87,7 @@ Status:
 11. the number of write blocks that are allocated in the cache
 12. the number of write requests that are blocked on the freelist
 13. the number of flush requests
-14. the number of discard requests
+14. the number of discarded blocks
 
 Messages:
 	flush

