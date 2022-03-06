Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910714CE9E5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiCFHjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 02:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCFHjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 02:39:48 -0500
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD9CBCB5
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 23:38:51 -0800 (PST)
X-QQ-mid: bizesmtp69t1646552310tk98wg0s
Received: from localhost.localdomain ( [114.222.120.105])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Mar 2022 15:38:22 +0800 (CST)
X-QQ-SSF: 01400000002000B0I000B00A0000000
X-QQ-FEAT: vv5b1ORzlwA//lBeTBx3hH/+TE8VTKy7zZkspP8+8k8WRyWXvDPKr0VnixV9t
        BzaA7vdzzkYkLO/ryAcJ1WE2TX8wsAW8rv0uljFDHFyTWHQ4MJ7ze9/0QMiyfd+NgCQtzMW
        whV+DzzCgCppHMNQpWpw8J1BwBCG8tAn2MCc2uN+Dt+UC2yfX2Bdg462kSPqvHfzJEx7392
        a5QPGrnFRziz/tphxJt6erG8uylxMALHAeL8r/BnJiJXH+CY6iDTnSZPqYf/6stn9KZDqQ4
        mcq1sRAnD07z9sUn2eg53XhxtDDM+f3qbK09pMswDKoiTHv3uf+gpNR9brlrahySilzCAbv
        UehudOt/h2sXFDCw3VjoECDFOO/nJfHL0H/k9mX
X-QQ-GoodBg: 2
From:   Lianjie Zhang <zhanglianjie@uniontech.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Lianjie Zhang <zhanglianjie@uniontech.com>
Subject: [PATCH] mm/slub: helper macro __ATTR_XX to make code more clear
Date:   Sun,  6 Mar 2022 15:38:18 +0800
Message-Id: <20220306073818.15089-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>

diff --git a/mm/slub.c b/mm/slub.c
index 07cdd999c3fe..59992de7d3db 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5358,12 +5358,10 @@ struct slab_attribute {
 };

 #define SLAB_ATTR_RO(_name) \
-	static struct slab_attribute _name##_attr = \
-	__ATTR(_name, 0400, _name##_show, NULL)
+	static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)

 #define SLAB_ATTR(_name) \
-	static struct slab_attribute _name##_attr =  \
-	__ATTR(_name, 0600, _name##_show, _name##_store)
+	static struct slab_attribute _name##_attr = __ATTR_RW_MODE(_name, 0600)

 static ssize_t slab_size_show(struct kmem_cache *s, char *buf)
 {
--
2.20.1



