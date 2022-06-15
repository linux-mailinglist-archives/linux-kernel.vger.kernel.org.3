Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5954C4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348237AbiFOJhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiFOJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:37:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDAF3A181
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:37:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n18so9941950plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toOnIScwFyw6W7OXDthcOn14+v/kWcf4sWlmNX4vbyw=;
        b=wAiX39cIni2xV0gs+Aw3x+cqGcmhOg44meG1GgATN4rGOZMTRucugQttdsPTVLCPgd
         lzGVyUPuSgofxRCMzipQtvxYsU74K+kfcsgyw+JroN1p0LsIwpFR1+8h1eEkFAAzFgMn
         QtzlRavMa0womDUiHqAPMnCEpiIK5kCOcNoEvbpI9QLZt98sVZ0vzczrpcpgM7f1oDMl
         BNm/O3cjCiITG5mvpbSyJwF7l0kdkhwxFkbNxP1mPKDOlB/9wu/A86mH48bh/6L4USG2
         AD6wMV04G7O2UKviV0REy+Q6Qh+UrDH8ohQYrbvYnwzYkX6v0zWLR2bIJkT5AbiY1WsW
         E9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toOnIScwFyw6W7OXDthcOn14+v/kWcf4sWlmNX4vbyw=;
        b=pDvEc8POF4dWcqJHVrhG5csMwgAkM2yr2c0HBvySWVonWpBn00EZZl2uOuhvuhQrqH
         tKvQZUajyAi6JL/MXsuZfZThHI8ZowhQTNryzC1A7QqBXb+Gw+/N11rSQzDivoRCKCQN
         EEkK99NXcVJga7h6scPjqlP4HcGn8h61e9YyVTTaV9YEaOK7POiR5CD1dpv88U1vy1Om
         89ZCkeoo23juN8G2Ltlt5OAt3SsXzVJChocly1v/VlWRJnrbrnq+LKqUoLtIN+mEwbvt
         VmXmAPUWhzKY0sG7mh0hIHs0wljyWYnnWUVk0rvzxIgHx6PYTMkWp4oKmFgFyZh2FpGJ
         4sgQ==
X-Gm-Message-State: AJIora9o0UMYDUTkvWO53JKWqI4eQ6Fb66P4bF02zNTzTnS5ShpnlcHp
        zVnPRZ5IN1iRKcqjfZ+lt0LcVoYw4zzzvA==
X-Google-Smtp-Source: AGRyM1uDSjpYzuR/0hLrdYfbzcHDQTf58H3ocD0LXbnal15KuuFX07Jp9SuP/fNMasxYOqlgrk+/5A==
X-Received: by 2002:a17:902:d5c3:b0:168:f037:98d7 with SMTP id g3-20020a170902d5c300b00168f03798d7mr6063522plh.117.1655285820263;
        Wed, 15 Jun 2022 02:37:00 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b00163247b64bfsm8859205plb.115.2022.06.15.02.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:36:59 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pizhenwei@bytedance.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, gregkh@linuxfoundation.org
Subject: [PATCH v6 0/1] mm/memory-failure: don't allow to unpoison hw corrupted page
Date:   Wed, 15 Jun 2022 17:32:08 +0800
Message-Id: <20220615093209.259374-1-pizhenwei@bytedance.com>
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

v5 -> v6:
- Suggested by Naoya, declare 'hw_memory_failure' with initial value
  explicitly, also add __read_mostly. Thanks to Naoya&David!
  Leave 'Cc stable' or not to Andrew to decide.

v4 -> v5:
- Add mf_flags 'MF_SW_SIMULATED' to distinguish SW/HW memory failure,
  and use a global variable to record HW memory failure, once HW
  memory failure happens, disable unpoison.

v3 -> v4:
- Add debug entry "hwpoisoned-pages" to show the number of hwpoisoned
  pages.
- Disable unpoison when a read HW memory failure occurs.

v2 -> v3:
- David pointed out that virt_to_kpte() is broken(no pmd_large() test
  on a PMD), so drop this API in this patch, walk kmap instead.

v1 -> v2:
- this change gets protected by mf_mutex
- use -EOPNOTSUPP instead of -EPERM 

v1:
- check KPTE to avoid to unpoison hardware corrupted page

zhenwei pi (1):
  mm/memory-failure: disable unpoison once hw error happens

 Documentation/vm/hwpoison.rst |  3 ++-
 drivers/base/memory.c         |  2 +-
 include/linux/mm.h            |  1 +
 mm/hwpoison-inject.c          |  2 +-
 mm/madvise.c                  |  2 +-
 mm/memory-failure.c           | 12 ++++++++++++
 6 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.20.1

