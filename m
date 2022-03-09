Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1B74D3159
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiCIO7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiCIO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:59:50 -0500
X-Greylist: delayed 428 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 06:58:50 PST
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C3114F2A4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1646837512; bh=48jfwMLcGTnlVjxOvNm5ewm9LxTU5N6YqL6r45Mbrxs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=d8R2OydC9NAiYHlmmugODOUCm37gszXlWfpZgUxR4qcTwzGWWrF6PJMYpOMGIXl6s
         Y/G1zp8ap8yMYxuiNpUxofPbC+rUwKg72adRkSfGrup/jqlgYsDKYmIHlD5rqqcAv9
         DjVQf1aTtR7Y3a5jG64X/FT4qwa7wgpevDFpS4A4d2NpjLTiYX17Q+aQ99Ar/ZIWis
         AOyexzVP+aPEzDBq/EpxrumTsOdpKV1450ryH+uNVbxu918nHJfN23gfvgdfzT1Yp9
         KBW82RqF9a+0/sOcSYpVFQ2LJPlz/h5OXXi5mNDNs1CuVWOURNnZUVrOsrqk3u0i39
         eKVFx8PkXERHQ==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id BF4978043E;
        Wed,  9 Mar 2022 14:51:47 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH 1/2] mm: slab: Delete unused SLAB_DEACTIVATED flag
Date:   Wed,  9 Mar 2022 22:50:51 +0800
Message-Id: <20220309145052.219138-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309145052.219138-1-sxwjean@me.com>
References: <20220309145052.219138-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-03-09_05:2022-03-09,2022-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=656 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2203090083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Since commit 9855609bde03 ("mm: memcg/slab: use a single set of
kmem_caches for all accounted allocations") deletes all SLAB_DEACTIVATED
users, therefore this flag is not needed any more, let's delete it.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 include/linux/slab.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 37bde99b74af..b6b3eed6c7c4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -117,9 +117,6 @@
 #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
-/* Slab deactivation flag */
-#define SLAB_DEACTIVATED	((slab_flags_t __force)0x10000000U)
-
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
-- 
2.30.2

