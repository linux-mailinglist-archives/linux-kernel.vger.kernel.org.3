Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B3251FABA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiEILFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiEILE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:04:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06D7219C17
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:00:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v11so11941075pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqGcGcuUwLK05LGJI1ajsT/xW0rShgwvLzQMUoOkfkw=;
        b=EX80u1FgJBDMCHrzbHFVOjvLJY1UUYVtuQOC/wpMOEqIHTAh4jEcrxrWzJW2CQFpPg
         tauJptGinburWR+S+xrNaby09Sr9vlwlQHzwdrwy0iHshuyXvCgkHYGFu+Aeks0oMXdo
         iIVG/PtGR/ongrMfBzhfhvJJOHbGZR2SJBqfP8jnR0okDS+NKso52/KTywOTpp4ww5UX
         PlErlui1S/GuKpm4ZWArZxgrcievn2Eei9iNY/mGvDLmLI8cWpSzDUQwVFmgojyQawfd
         VCt1692u7d6Z5qvdrYHjGDom0bmizuAfn6zL4r3qKxTI5CG7ICW5E4jW+Td+wI8EfTiT
         AhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqGcGcuUwLK05LGJI1ajsT/xW0rShgwvLzQMUoOkfkw=;
        b=QNrgdCe6oARGvZRC9chIXl+gfEBgUZUj9gQeLCkhFvvAHBzV2JbdQ2D6U3ios6GOFm
         NxRoUutQytYhGEVicO2xfh188ZCgOEq9Txvm2zeEn3WW3DPuRI2K+zNObML+yHu0Oxf2
         H/F5AICknd09rnvU5NN2Cp4+fviPSVaeEMwr1pi4NzYhXnLbPhS8ZMlL4iNIE0XFDAhn
         I4MiL59P5AW28l4lz/09+9AYOx0dwxh+7LXUuUpHSYJdTavRCiJ3U8Ebf3xfWsEM8xVc
         jwpe7dGly0A9+dvlMN25W35GDvt+bjNwAga9ybFoRJ5Myw5XgY12/2j//1thxqJGepql
         M67Q==
X-Gm-Message-State: AOAM530KCAc9fNPUq36q/tq2Igzqz17Jfnf6KLqMlN68mc5g0FE90XLJ
        jdB5Ih0ifilEG1MhietsKJ2FkA==
X-Google-Smtp-Source: ABdhPJwaGUhNTPgReYxZbf915o71BtxX+6pcZwG8eJNzhOfcIaOxs1UXcmb8oyitY4T6NxyuvXZYdw==
X-Received: by 2002:a63:f1e:0:b0:3c1:d54f:fc47 with SMTP id e30-20020a630f1e000000b003c1d54ffc47mr13164738pgl.51.1652094058513;
        Mon, 09 May 2022 04:00:58 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902968c00b0015e8d4eb244sm6813303plp.142.2022.05.09.04.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:00:57 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/5] memory-failure: fix hwpoison_filter
Date:   Mon,  9 May 2022 18:56:36 +0800
Message-Id: <20220509105641.491313-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- move clear_hwpoisoned_pages() near the definitions of
  hwpoison_filter*.
- fix typo.
- remove "mm/memofy-failure.c: optimize hwpoison_filter".
- call hwpoison_filter() after get_hwpoison_page().
- disable hwpoison filter during removing
- simplify num_poisoned_pages_inc/dec

Also add background of this work:
As well known, the memory failure mechanism handles memory corrupted event, and try to send SIGBUS to the user process which uses this corrupted page.

For the virtualization case, QEMU catches SIGBUS and tries to inject MCE into the guest, and the guest handles memory failure again. Thus the guest gets the minimal effect from hardware memory corruption.

The further step I'm working on:
1, try to modify code to decrease poisoned pages in a single place (mm/memofy-failure.c: simplify num_poisoned_pages_dec in this series).

2, try to use page_handle_poison() to handle SetPageHWPoison() and num_poisoned_pages_inc() together. It would be best to call num_poisoned_pages_inc() in a single place too.

3, introduce memory failure notifier list in memory-failure.c: notify the corrupted PFN to someone who registers this list.
If I can complete [1] and [2] part, [3] will be quite easy(just call notifier list after increasing poisoned page).

4, introduce memory recover VQ for memory balloon device, and registers memory failure notifier list. During the guest kernel handles memory failure, balloon device gets notified by memory failure notifier list, and tells the host to recover the corrupted PFN(GPA) by the new VQ.

5, host side remaps the corrupted page(HVA), and tells the guest side to unpoison the PFN(GPA). Then the guest fixes the corrupted page(GPA) dynamically.

Thanks to Naoya & David for the suggestions!

v1:
- move clear_hwpoisoned_pages() from sparse.c to memory-failure.c.
- simplify num_poisoned_pages_dec().
- call hwpoison_filter() early in memory_failure().
- add hwpoison_filter for soft offline.

zhenwei pi (5):
  mm/memory-failure.c: move clear_hwpoisoned_pages
  mm/memory-failure.c: simplify num_poisoned_pages_dec
  mm/memory-failure.c: add hwpoison_filter for soft offline
  mm/hwpoison: disable hwpoison filter during removing
  mm/memory-failure.c: simplify num_poisoned_pages_inc/dec

 mm/hwpoison-inject.c |  1 +
 mm/internal.h        | 11 ++++++
 mm/memory-failure.c  | 85 ++++++++++++++++++++++++--------------------
 mm/page_alloc.c      |  1 -
 mm/sparse.c          | 27 --------------
 5 files changed, 59 insertions(+), 66 deletions(-)

-- 
2.20.1

