Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257844E270D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347650AbiCUM6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346113AbiCUM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:58:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE02B1697A0;
        Mon, 21 Mar 2022 05:57:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n15so12665750plh.2;
        Mon, 21 Mar 2022 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sCS6c171oyN7Cq0gnRAYsCzijiKw228qCeDaGu15gbQ=;
        b=kxKHOOABq7S1CRI0KHi/xF4YyJwZK6cmyIAmwClbqrsolrkKTytDk72Ruj1zQ60y+T
         Nu8rNFZiEQIf1Y85wSPGdZnAGOotwnU4irRb20LPXBjW3zPkW8vg5i7swBTxNpr5kQV5
         sofHwBwkj7lvrMa17ETqe0YBxjeqA2mGuyt2bAsCMEQGh2iqppvq9gr7hhy/Z4Y5izRf
         rSgUKLtRTkM46bqRfxVYyCt8xaSxRcm1WaUgyKJhgfdBCvkpzqhdkyi37ugmo5MLzrRR
         ckgR32huHN2VCsgpYMOPznMSjSo8U9JjG7G4k1pIN+nkF3U4MQfqcWKBXVWc9l70Fmf1
         MQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sCS6c171oyN7Cq0gnRAYsCzijiKw228qCeDaGu15gbQ=;
        b=fxUgVtueFeYReARGnKkqyGXWUPxCE7uiIV54glaNhGxMc+PILYPShTc8K8FTg5YLbi
         BeWFXHGxyzXUV77ayhw4OjwuYhoSFUs2W9S9RnAvmWNnecOQLSz81g3X7olN1XUVPlIl
         TgKrbr+pWdfEfpUSicdDDYlCtUgbmD/gppOG3o2CpJ2kQTPiCH/jiSH9bLuA2htjXrFj
         lVQKeKw2cifIOTLsY1v9Ega0e2wZCSVwn3EO0s8oVx8FPEszgLhiizpsoJr3n1+Vktx9
         GgMqso4fSq7MASGdXd3dl6uOIL2WZk9PE4DA3dop34E4LTSi3YKzvHh9TI+nMb3LoxkV
         klCA==
X-Gm-Message-State: AOAM531ybaHvcuIZjSaSayG6A+Pn9deUDQI35OSSrhjnNPmMfExRrOJi
        op5oItUmtNWzfE992+zrqZw7RhAFDs4=
X-Google-Smtp-Source: ABdhPJza+rnxixluZ0BEyTT7Cn7E8pppNLNxJ1YwY3wqwVIRgg/wezDWXN7ZSR4DmrPnM8fJJVdOPQ==
X-Received: by 2002:a17:903:24f:b0:153:32c0:7d6f with SMTP id j15-20020a170903024f00b0015332c07d6fmr12467134plh.36.1647867432121;
        Mon, 21 Mar 2022 05:57:12 -0700 (PDT)
Received: from carrot.localdomain (i114-180-38-233.s42.a014.ap.plala.or.jp. [114.180.38.233])
        by smtp.gmail.com with ESMTPSA id gb5-20020a17090b060500b001c6d46f7e75sm8009046pjb.30.2022.03.21.05.57.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 05:57:11 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [PATCH 0/3] nilfs2 lockdep warning fixes
Date:   Mon, 21 Mar 2022 21:57:04 +0900
Message-Id: <1647867427-30498-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

please consider applying the following changes to -mm tree.

Ryusuke Konishi (3):
  nilfs2: fix lockdep warnings in page operations for btree nodes
  nilfs2: fix lockdep warnings during disk space reclamation
  nilfs2: get rid of nilfs_mapping_init()

The first two are to resolve the lockdep warning issue, and the last
one is the accompanying cleanup and low priority.

The merge window is already open, but this is for the reported issues,
so I'll send it without waiting at this point when tests have passed.

Based on your comment, this series solves the issue by separating
inode object as needed.  Since I was worried about the impact of the
object composition changes, I tested the series carefully not to cause
regressions especially for delicate functions such like disk space
reclamation and snapshots.


Thanks,
Ryusuke Konishi
--
 fs/nilfs2/btnode.c  |  23 +++++++-
 fs/nilfs2/btnode.h  |   1 +
 fs/nilfs2/btree.c   |  27 ++++++---
 fs/nilfs2/dat.c     |   4 +-
 fs/nilfs2/gcinode.c |   7 ++-
 fs/nilfs2/inode.c   | 159 +++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nilfs2/mdt.c     |  43 +++++++++-----
 fs/nilfs2/mdt.h     |   6 +-
 fs/nilfs2/nilfs.h   |  16 +++---
 fs/nilfs2/page.c    |  16 +-----
 fs/nilfs2/page.h    |   1 -
 fs/nilfs2/segment.c |   9 ++-
 fs/nilfs2/super.c   |   5 +-
 13 files changed, 241 insertions(+), 76 deletions(-)

-- 
1.8.3.1

