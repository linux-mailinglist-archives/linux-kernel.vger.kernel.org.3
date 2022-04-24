Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443D050D525
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbiDXUvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiDXUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 16:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCDC637A99
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650833306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3NvTX43lcTPT1i7RkbjZNy/yIFWQsTFd1AzWg2yj2kI=;
        b=KusJUH0hHSdkE02PS3bO/fvMAhDarvWCsPtX1NBAkHMyR8BiFKjgfs8qtU6EN2gai4Br0x
        lQssiMvj2pzyOR1ToAUKQVv00tAf+4R/2rfgcOJpdKoz1esuMHeJYb7GNbZAcN9xmX3wTz
        lL0bzsTbHkpYNJVMd5p2XyrDAArYNbQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-tpXuNxmDPy6-r6BVndExNQ-1; Sun, 24 Apr 2022 16:48:21 -0400
X-MC-Unique: tpXuNxmDPy6-r6BVndExNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CE933806706;
        Sun, 24 Apr 2022 20:48:21 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 206C0145BEFC;
        Sun, 24 Apr 2022 20:48:21 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23OKmLrJ019044;
        Sun, 24 Apr 2022 16:48:21 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23OKmKoL019040;
        Sun, 24 Apr 2022 16:48:20 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 24 Apr 2022 16:48:20 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Mike Snitzer <msnitzer@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] hex2bin: fix access beyond string end
Message-ID: <alpine.LRH.2.02.2204241643030.17244@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we pass too short string to "hex2bin" (and the string size without the
terminating NUL character is even), "hex2bin" reads one byte after the
terminating NUL character. This patch fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 lib/hexdump.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6/lib/hexdump.c
===================================================================
--- linux-2.6.orig/lib/hexdump.c	2022-04-24 18:51:16.000000000 +0200
+++ linux-2.6/lib/hexdump.c	2022-04-24 18:51:16.000000000 +0200
@@ -45,10 +45,13 @@ EXPORT_SYMBOL(hex_to_bin);
 int hex2bin(u8 *dst, const char *src, size_t count)
 {
 	while (count--) {
-		int hi = hex_to_bin(*src++);
-		int lo = hex_to_bin(*src++);
+		int hi, lo;
 
-		if ((hi < 0) || (lo < 0))
+		hi = hex_to_bin(*src++);
+		if (hi < 0)
+			return -EINVAL;
+		lo = hex_to_bin(*src++);
+		if (lo < 0)
 			return -EINVAL;
 
 		*dst++ = (hi << 4) | lo;

