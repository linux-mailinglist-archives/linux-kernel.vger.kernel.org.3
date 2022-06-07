Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E0E53F9E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiFGJfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiFGJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:35:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43FF66C88
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:35:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u26so26655248lfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+9f9l4kafijy5tF7KMskKmJ/qyS50hfAaTAXJIaHigk=;
        b=ey+7OYgV7aR8YmkHepSIEIvJD6ppZYccI9v3aTw4hBckRyBQaaRSg35vILfF+tJaT5
         /ro7BEv3Bwyrw05UTpr1XJeS0spWfXfjSUQ/KXG+Cd+uTs6XXjBfIfLtDhLSYR2ruJjU
         bIkAQEI2fAZiy4V0/ZB3trU4JizsrP74/d5hDbwMq7OqfRejYA8u8JJzOewMEcq0s8h+
         j3qo07tSzA9nBl21TqcNuK4+DcaV0xuJ3sj7WuPNFsrXymWZJGJGygjUdaDLs8mqt7lN
         WwYdAt71DyQPFJjTuRVC4tDx53FvSZMlhyoafCcUMbKDzwMBp8w8IWgJ5ppKQM8wH1Le
         K/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+9f9l4kafijy5tF7KMskKmJ/qyS50hfAaTAXJIaHigk=;
        b=Ps3mw++oMGATLyo1ywnldvcC8qMuDfv+Z/TwcrV9kiQHRLIVe2YEEROjVl8R1gNgQR
         vG6akY5YwI0OFY2DZ7NQvJmon6LfdSFKZAkjYQD+BtSpALphELz8Rg/3zZ+SqQVuVE6V
         HHx9PxH9TT2AzTmyXP/0sfVMQdz6xyznAS/HliPOUxEEio3cLeu/7bFMZnBWP+IR3Vrd
         FJ1BCOCIa2oS9RHqKtK9IWKbZbgA8V0X3WKoJwmTSXUx1bfQnDJ2N5MxJpdu7mo45MDQ
         iTlbISv3yiNGXKhKN3T4Aa+kyOsTvonxw6cE0c4PnhoWhlYPzUpL8diL2f1hRA1JLiJf
         2xBQ==
X-Gm-Message-State: AOAM532ZM5nbZBo7/wzVf3SWN6SpM2BKf6Aj/y9t4OU6zcoOlxECVuM6
        msVr7NOQx6z50bOdd/lTvCs=
X-Google-Smtp-Source: ABdhPJwAahIn/7ZioTC+h2QdikezWSd6RqDgg9/Kn/YVckplbfBuxn7u4AcL72Pvhor6li8lMY4eSQ==
X-Received: by 2002:a05:6512:2143:b0:479:9fd:14dc with SMTP id s3-20020a056512214300b0047909fd14dcmr17936064lfr.505.1654594499850;
        Tue, 07 Jun 2022 02:34:59 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r27-20020a2e575b000000b002554a4ebf5fsm2748043ljd.74.2022.06.07.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:34:59 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 0/5] Reduce a vmalloc internal lock contention preparation work 
Date:   Tue,  7 Jun 2022 11:34:44 +0200
Message-Id: <20220607093449.3100-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Hi.

This small serias is a preparation work to implement per-cpu vmalloc
allocation in order to reduce a high internal lock contention. This
series does not introduce any functional changes, it is only about
preparation.

Uladzislau Rezki (Sony) (5):
  mm/vmalloc: Make link_va()/unlink_va() common to different rb_root
  mm/vmalloc: Extend __alloc_vmap_area() with extra arguments
  mm/vmalloc: Initialize VA's list node after unlink
  mm/vmalloc: Extend __find_vmap_area() with one more argument
  lib/test_vmalloc: Switch to prandom_u32()

 lib/test_vmalloc.c | 15 +++----
 mm/vmalloc.c       | 98 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 76 insertions(+), 37 deletions(-)

-- 
2.30.2

