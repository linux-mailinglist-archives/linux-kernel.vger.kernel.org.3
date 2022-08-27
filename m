Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD2D5A35AC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiH0Hsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 03:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiH0Hsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:48:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60935070D
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 00:48:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x26so3605189pfo.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 00:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=/9N+VLWk58L9OYHZ+uiRPBYWV4cbL6pzerCWfj63tGQ=;
        b=QuEdr8ub9t+ajsptYYnDb/m1rez5h/RRO4vJONK+b8vOSw019ccgx0a4WfrRzq7rag
         xXq6hVFgZ4QTIc0ciJ4fCMFH0tv1lyiP4shPV9hWwmEGkKDZgS6/pFTj7k62U/Bh0OCm
         hg5ct20HmOOts3UqMSxtyspbhsylJPTNJ3TloP2Zi9Zafh7V8flaiQzlInMXfRc72g4d
         ieztSsNO8HJFgc0+y701BYLatPaIejsU+2UFM222pfWmJWmRtSUSY5JR/i0bUq6lVPwt
         oFSjHlb+G+nlHfGMd4hTM2VeYEALd0cv1G2drDv++M8VUk+bUxPs2+sdx0AhSKJ/2cLL
         dabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/9N+VLWk58L9OYHZ+uiRPBYWV4cbL6pzerCWfj63tGQ=;
        b=AzrvKPuE7NLF7KAyRYWiX9jYdd+teAp0Gu1vi07UCjnxRz4JuPxCSmhS5jnG8hSf7X
         5VKJi4Kzsy+WJhlZP0Ld7xaXBmGdGNG1GaQCK4JNT7qilShfNzguyTBsxZwza/7uPKZ6
         OTsJ3Z8z033Sok6SRjAjbJRjLMht5WXcqzCWLE7+4RUr8iZRByQg/i+YdvGzgXfyMtC1
         7lJTrj9aLLfnER1Mp9qsTXvf4z1izqyM2SHq7LUH1aItOzgihjv3LdXtJZUADOS7+NZO
         x6CR28PBRFINsN89DU6jBdyVkClliG+mep/gaoYOG0ycOuCSqTaYpxXtTAqcXfzDXCvH
         Bncw==
X-Gm-Message-State: ACgBeo22G/10av7MGYMkIyMdSOjgP2Iv1zxahDe87N6fLT01bP4Wp/MG
        MjfTPVDZamAAQXTjXKG6e+K/18pB9dY=
X-Google-Smtp-Source: AA6agR7XUiAnkAUgsZZykYL44m+7xr6IijcT+mdRGXU02blgfnaOCpncjbvaIOXVfEAJTpCZdy97TA==
X-Received: by 2002:a63:1e12:0:b0:42b:bb36:f898 with SMTP id e18-20020a631e12000000b0042bbb36f898mr37631pge.469.1661586511237;
        Sat, 27 Aug 2022 00:48:31 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q4-20020a656844000000b0042aaaf6e2d9sm2632006pgt.49.2022.08.27.00.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 00:48:30 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, shaojunjun@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: [RFC PATCH v2 0/2] erofs: support compressed fragments data
Date:   Sat, 27 Aug 2022 15:47:55 +0800
Message-Id: <cover.1661584151.git.huyue2@coolpad.com>
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

mkfs v4: https://lore.kernel.org/all/cover.1661087840.git.huyue2@coolpad.com/

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
 fs/erofs/zdata.c        | 59 +++++++++++++++++++++++++++++++++++++++--
 fs/erofs/zdata.h        |  3 +++
 fs/erofs/zmap.c         | 35 ++++++++++++++++++++++--
 9 files changed, 155 insertions(+), 18 deletions(-)

-- 
2.17.1

