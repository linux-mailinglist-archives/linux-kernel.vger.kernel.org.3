Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597EA58F83B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiHKHS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiHKHS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:18:56 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9071779A63
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:18:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VLyAV5x_1660202327;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VLyAV5x_1660202327)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 15:18:49 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        42.hyeyoo@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/1] mm/slub: release kobject if kobject_init_and_add failed in sysfs_slab_add
Date:   Thu, 11 Aug 2022 15:18:43 +0800
Message-Id: <20220811071844.74020-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kobject_init_and_add() function, the refcount is setted by calling
kobject_init() function, regardless of whether the return value is zero
or not, therefore, we must call kobject_del(&s->kobj) to prevent memory
of s->kobj is leaked.

V1 -> V2
use kobject_put() instead kobject_del().

V1:
https://patchwork.kernel.org/project/linux-mm/patch/20220811025258.68684-1-xhao@linux.alibaba.com/

Xin Hao (1):
  mm/slub: release kobject if kobject_init_and_add failed in
    sysfs_slab_add

 mm/slub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--
2.31.0
