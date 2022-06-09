Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72577544C97
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiFIMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbiFIMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:50:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF81F2E2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:50:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e9so10734446pju.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qv9uiCnYkz7r1g81Uxpd/4YaIX8fP8HTMmvq6kZi5lg=;
        b=Z3X3g/QGldKGffMSt6uWhAgADYxTRzzt38s6Pl69DAYLj1AM7WTDnUcZBlWAjKzHjz
         t36dGvwHRMlH5CSHGrAcMtXSlzUVagN60htpNE2pzC10V9BySpRdo555jFDaKA3nGd5E
         nIwSjf7UZWrga5twSOS5YPkCbvTpaHc4eODH0OrzTkv71qCXmAnLNc42dDvobiBRPwCr
         MdC8vysihai1udc5P40yfWlX+wUyurn8FnCLqNZTePbJSyp3XDa3FHNjcYb+rFeHGI5Q
         +j7fF8Cdjx4NOyh1dy4lCJCxK+Ikhv86U7eRUK5LrFxHLXQo/Eeamh8ixO6waC+8ZlB8
         6d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qv9uiCnYkz7r1g81Uxpd/4YaIX8fP8HTMmvq6kZi5lg=;
        b=Bvovqh+Kn6yOQZtapIX3ZMXpLQhFPuGpIp8aNE/UWyJeb8puT5VftqStNP+HpOGJzR
         1l6FKqj72nG4zRLRpAZ8CXPUP71JjaLTA2epPIeyxVMHXJVoyYP0Az/wF5ej9p2mehPw
         Re9la74gdb7RazBFJVIwV9gt3ZlvifRSTo/KWUKhUwwgMsMw1sDLJ84Mp3UDHf/iratH
         CpLd7ODW+RnUoZJJAaFv4KU3LxKPcX/TUlDIT6jTVzdBPhTDvXeNxMihM+6puVfqWH6D
         KCgWZHNhuGHHeChaA6DqY2Op3uMZRwpiG9+ntZAe1zVFQ8qqtyD6o/oXhM9dVgCXFA3z
         R54g==
X-Gm-Message-State: AOAM530zDUcrd4DM09M6Strl2pzmg+2HhYk13+cK2jn01ortVYxolGZB
        e9LAT+/Y1NRFN8gldg6ds5c=
X-Google-Smtp-Source: ABdhPJyBnxAQEPn+HX6J+QIyBBx3dSo2YPqdDlBYIzCGbyEsPlUrXIAm08nFvf+/fUte/mJiqvpZ8w==
X-Received: by 2002:a17:903:120f:b0:15f:99f:9597 with SMTP id l15-20020a170903120f00b0015f099f9597mr38766686plh.45.1654779055575;
        Thu, 09 Jun 2022 05:50:55 -0700 (PDT)
Received: from localhost ([101.86.206.203])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709027ec100b00167736c8568sm9214922plb.70.2022.06.09.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 05:50:55 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v3 0/3] mm: kmemleak: store objects allocated with physical address separately and check when scan
Date:   Thu,  9 Jun 2022 20:49:47 +0800
Message-Id: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmemleak_*_phys() interface uses "min_low_pfn" and
"max_low_pfn" to check address. But on some architectures,
kmemleak_*_phys() is called before those two variables
initialized. The following steps will be taken:

1) Add OBJECT_PHYS flag and rbtree for the objects allocated
   with physical address
2) Store physical address in objects if allocated with OBJECT_PHYS
3) Check the boundary when scan instead of in kmemleak_*_phys()

This patch set will solve:
https://lore.kernel.org/r/20220527032504.30341-1-yee.lee@mediatek.com
https://lore.kernel.org/r/9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com

v2: https://lore.kernel.org/r/20220603035415.1243913-1-patrick.wang.shcn@gmail.com
v1: https://lore.kernel.org/r/20220531150823.1004101-1-patrick.wang.shcn@gmail.com

v2->v3:
 - remove the min_count argument to kmemleak_alloc_phys() function and assume it's 0
 - remove unused kmemleak_not_leak_phys() function
 - add functions to reduce unnecessary changes
 - remove the check for kasan_reset_tag()
 - add Fixes tag in patch 3

v1->v2:
 - add rbtree for the objects allocated with physical address
 - store physical address in objects if allocated with OBJECT_PHYS
 - check the upper object boundary as well and avoid duplicate check

Patrick Wang (3):
  mm: kmemleak: add OBJECT_PHYS flag for objects allocated with physical
    address
  mm: kmemleak: add rbtree and store physical address for objects
    allocated with PA
  mm: kmemleak: check physical address when scan

 Documentation/dev-tools/kmemleak.rst    |   1 -
 drivers/of/fdt.c                        |   2 +-
 include/linux/kmemleak.h                |   8 +-
 mm/kmemleak.c                           | 200 ++++++++++++++++--------
 mm/memblock.c                           |  14 +-
 tools/testing/memblock/linux/kmemleak.h |   2 +-
 6 files changed, 145 insertions(+), 82 deletions(-)

-- 
2.25.1

