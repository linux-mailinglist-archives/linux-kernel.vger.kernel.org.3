Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC3A5471B0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348436AbiFKD5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiFKD5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:57:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D8D60
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g186so903797pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJ1428xewNFchdZrYlO+/855yPqA1ZpD9GpS9ECgUW8=;
        b=gv1KTcgDaORWCDyiFRbzOfYmnT5swt6Vy7IsHZdEk/OqpGhonYIbyodiBkQLrWYaj5
         AVB5iyb+Q3Tq1O23WY2EcyyGia5nktw3zUCcihTtNId73vONqxqWhZ3ckGVp2dZBH02l
         msRgZTNGjNcqZ5QXsp+eTCVv++jDS05681if0egA/01Vwf6FG9VNcRqiJ6/cCFnJd478
         HVMO2Xr2dD93otxBQbjYCrG6bFgDA3BxAXlhaV0XZIY2r+4pL5BZ2HMqJ9DKQC9saS36
         taethIfe3+Uj7quEPNz56FdBSlWglUTDEpaFRTm+gW2wUF1zGPYDr642LDGk4ottZPy3
         xilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJ1428xewNFchdZrYlO+/855yPqA1ZpD9GpS9ECgUW8=;
        b=6wLLnAy3jqjDe3LI8UmxP6H7YBekDEw5wkYWwZn3fzHVMuMs7+i0yliwq5kqS+qw4F
         gEUvK25gyH5z8iLBD23ClIwdvDmTxCmvsjOr7LkQ1s8PyFYBKNQK6ODYJOHM2ioDZWw4
         KJrDRq05huFbbN0apAmffXS5gidgs8Zkm1eA3yUhYPJdSpgKzr2NeBLhsXE8JIHnvi2+
         EHFjelNaImcuOqKAfOlm6I8UT59nm7DoO8ZsadSh/jgHIzW++bfpU2nidrhVX76DH/JC
         UBkpHAs7RzSbP1MIgkaoimi6Kx0NPDpemzo56gQcmQv2HYnP/3QZwdeYGxWVDUY0ZHSE
         lPrA==
X-Gm-Message-State: AOAM53109lXPdZ3CaGNbJpQAV1uV6xC2rRyfUOPqUVKUbutJGKjdcU6D
        2m2QCnA9vBNQtwk/iMwMQZw=
X-Google-Smtp-Source: ABdhPJyO+3OsfXbuRV42VlcQc7PTHRUpnOw2Bh852r/keYAn4XeWwBHvTrPrPe6QLLU8TKTClEBHng==
X-Received: by 2002:a05:6a00:16c7:b0:520:6ede:2539 with SMTP id l7-20020a056a0016c700b005206ede2539mr4624621pfc.46.1654919865690;
        Fri, 10 Jun 2022 20:57:45 -0700 (PDT)
Received: from localhost ([101.86.206.203])
        by smtp.gmail.com with ESMTPSA id bw11-20020a056a00408b00b0051868677e6dsm378084pfb.51.2022.06.10.20.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 20:57:44 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v4 0/4] mm: kmemleak: store objects allocated with physical address separately and check when scan
Date:   Sat, 11 Jun 2022 11:55:47 +0800
Message-Id: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
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

v3: https://lore.kernel.org/r/20220609124950.1694394-1-patrick.wang.shcn@gmail.com
v2: https://lore.kernel.org/r/20220603035415.1243913-1-patrick.wang.shcn@gmail.com
v1: https://lore.kernel.org/r/20220531150823.1004101-1-patrick.wang.shcn@gmail.com

v3->v4:
 - fix a build warning
 - move the prototype change of kmemleak_alloc_phys() and the
   kmemleak_not_leak_phys() removal to a separate patch (patch 1)

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

Patrick Wang (4):
  mm: kmemleak: remove kmemleak_not_leak_phys() and the min_count
    argument to kmemleak_alloc_phys()
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

