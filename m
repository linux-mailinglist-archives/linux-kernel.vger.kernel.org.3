Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820204D4899
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbiCJOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiCJOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:09:33 -0500
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6545040A04
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1646921309; bh=bu6o/I50kLW+ldkVcXBnpNjl1PXQ3BXgWeBlljY2pjE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=uvNQahwzeOQH5ss4uvzBqfp012nt7NNnhsqT/a2txd1hW79o7V1Gh5bihRTUUfyMW
         tpeIUxEQuLiA7WglOt4t4LA3SNt3AbKtPhZ/XnJPIOYpxnLcpWh+lt+c103Md9lBl3
         97dALBjerAO1KfQloAstOnN9dTV4Rj3Oqhe4WHoouapBgvbjUPR9LkZmexxQlSMOJj
         OcTtXl4UBASNCEVU6S0w8lbJEHxnBQdxxkeltljrrJdFH0vz7Vj5RPGPBqkbFz0WDx
         UCXYsFVLUtOMikoEaCz2gnOrZyx3ElGKBWA5Vbfi7X053K+1PlN6lE+I4EMeAt08rc
         ddzrEPQCC2IIg==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 8F7BD8056F;
        Thu, 10 Mar 2022 14:08:18 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, willy@infradead.org,
        roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 1/2] mm: slab: Delete unused SLAB_DEACTIVATED flag
Date:   Thu, 10 Mar 2022 22:07:00 +0800
Message-Id: <20220310140701.87908-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220310140701.87908-1-sxwjean@me.com>
References: <20220310140701.87908-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-03-10_03:2022-03-09,2022-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=771 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2203100077
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
kmem_caches for all accounted allocations") deleted all SLAB_DEACTIVATED
users, therefore this flag is not needed any more, let's delete it.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
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

