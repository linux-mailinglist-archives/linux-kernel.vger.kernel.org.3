Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B65AC90A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiIEDUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEDUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:20:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F11903C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:20:47 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 78so6966695pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 20:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2x1CVvZwxtC17ybrCOH9iYJbvuWGYA3Itll1Ewytvd4=;
        b=oTFlTm37bZl3LpcWRgucfMWbb9z1C0nHrnTqGnsvmCpkS2ETf4Ac3AoW1MnbgBbuwz
         YYKcRZxMxFKDUvynOIP6nwyi4zFA2qjfGK0LkSYioUTkX0wZCYs/PlITA/YMFFTBPx+X
         zs1y+lhGohKdJRfHrG5tbp08aMCO/fcEBTShyzolBooX/bgLDwSNBwBYn8JQQFtlpBz+
         cUJNwIjz3UcU1WRWQyirpt4i8t7IHtjDiVMDnMyRGxDMd7M09wr1v0eYJn6/fbMVejjM
         6oOQvXZHRXhavqIhar2AmGd0BpmpR3U9ZLmm8kD7AXnmoFJSt6dI9ChuC6G56Z7nH40H
         wdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2x1CVvZwxtC17ybrCOH9iYJbvuWGYA3Itll1Ewytvd4=;
        b=Bp4m3MeKU147znfTusr8ZoGAUnkexFi6SB5T3C46Qrd7Lru2tMbfVceIYeUPuwfIb3
         +CaawSVGjede8BR/0/mduqfcmjDDP3oMDnRPAcFPtpBuQY5rFvLn7ctOpPECRq9vUtdC
         kThZGgqZK+L2A1z66xbpkycda4ooX516y5h1Jl0HgySo0WqGgE0uYNu1+nzgssMWHqNN
         CdCHLVoFvnQHVDhW6lfkuMWpfxTvHpK/HdFv1pyDAFyiu3jqkb/fb24kH9XAaaZWOeOt
         0w7KDD7/MtseuhP99DVSflKHe6/bEjMoV8leMhXZRaeyDMGLfMwI5kkAoltknZ6YHbEE
         RAnQ==
X-Gm-Message-State: ACgBeo3vuRuy60MFEZiPyZ0UA4KgOttc04TfjfcXqDeVEPkTpfNANRR/
        AVdDfAPVSmPtU+q9vAmP+lYHt37oHms=
X-Google-Smtp-Source: AA6agR6/5UIS3BCdUojn5irM2bwVVjhd9IDnfVcSg8ZbgrhLuOrCpyZZ8KBXFPTxZG4JzRPjmyYF6g==
X-Received: by 2002:a63:914a:0:b0:42b:4eaf:7c75 with SMTP id l71-20020a63914a000000b0042b4eaf7c75mr40042858pge.306.1662348046857;
        Sun, 04 Sep 2022 20:20:46 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090ac98500b001f216407204sm5610265pjt.36.2022.09.04.20.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 20:20:46 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, zbestahu@gmail.com,
        Yue Hu <huyue2@coolpad.com>
Subject: [RFC PATCH v3 0/2] erofs: support compressed fragments data
Date:   Mon,  5 Sep 2022 11:20:06 +0800
Message-Id: <cover.1662347031.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

This feature can merge tail of per-file or the whole files into a
special inode to achieve greater compression ratio.

Meanwhile, also add a interlaced uncompressed data layout support for
compressed files since fragments feature (and later) can use it.

mkfs v5: https://lore.kernel.org/all/cover.1661687617.git.huyue2@coolpad.com/

changes from v2:
 - enhance the condition to check if pcluster is interlaced or not;
 - no typo.

changes from v1:
 - fix a compiling error without CONFIG_EROFS_FS_ZIP, reported by kernel test
   robot <lkp@intel.com>;
 - introduce the term 'interlaced' for patch 1/2 suggested by Xiang;
 - fix packed inode failure path when read super pointed out by Xiang;
 - use kmap_local_page instead of kmap_atomic pointed out by Xiang;
 - use a simpler way to avoid call read fragment data twice suggested by Xiang;
 - update commit message change.

Yue Hu (2):
  erofs: support interlaced uncompressed data for compressed files
  erofs: support on-disk compressed fragments data

 fs/erofs/compress.h     |  3 +++
 fs/erofs/decompressor.c | 12 +++++----
 fs/erofs/erofs_fs.h     | 28 ++++++++++++++-----
 fs/erofs/internal.h     | 16 ++++++++---
 fs/erofs/super.c        | 15 +++++++++++
 fs/erofs/sysfs.c        |  2 ++
 fs/erofs/zdata.c        | 60 +++++++++++++++++++++++++++++++++++++++--
 fs/erofs/zdata.h        |  3 +++
 fs/erofs/zmap.c         | 33 ++++++++++++++++++++++-
 9 files changed, 155 insertions(+), 17 deletions(-)

-- 
2.17.1

