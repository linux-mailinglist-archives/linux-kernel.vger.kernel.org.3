Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29A654CFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357575AbiFORaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356282AbiFOR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:29:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582D64C418
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u37so3633090pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtollJahbUnQdMIR/aYwe0ysfbXt4BsX5JTH7cAUXak=;
        b=N4NuWQSKWQiM9FdTh0JRYtj0u28EsEtECIADCbJ92IumR+tzfD/GaDHyaEZCwEPZ45
         ndkfZiW/jfRsteeB9yP9cN9gJTN6ydS9wdWzU+oLNT1WC4vOvwoBdzmDrBH+qpNvAxag
         JpSIsvOqGHCmhbOYwzkelddRSkQVvjIZMqs7jmrSBxqN0FpowIgVL6ZXoXHpGmHD3PZ+
         S2uzDoLcfArRPZ8Mne+aFujCMcOt0U6HXoPEWgUn+o315U9ROrtTdkAbIiHOPZYkP5fK
         idIjGjTzUH0kLYHJQkeMhS/nKieRKIcCdF/6ipPVUxwBIgIBjV91PFInRIenewHra95S
         GHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtollJahbUnQdMIR/aYwe0ysfbXt4BsX5JTH7cAUXak=;
        b=5rE3HVPnhTXGafy/OZbA2UDaX3QB7XQB+23K/fjjk4DrlO1W0oN7ffvWoLIPXahdoP
         Bv9Ho5c1sOugPThS5DU1knWbA5gBdFPzIlyZmSsUJgRZqCb0extR94F7m19LPQz7jUuJ
         IA/z0GsP+iYojsl6VElkNd4Jp146ABOo6+qeLlnPvB7NQlIITwjWlpxYP3jbo0aBs5Ib
         aESLsJnhjtOKYDk1yiVz6+Vx133injfApfBC8m7ufBQyqHsoPaSiYxePFTCaYi0HRNC7
         xcuG2+UwCDznlFryYEIlfnnHHT2e07ShKajJV/tclWWWF1nARf5skXXDswOZJ/kKcHfs
         SKMw==
X-Gm-Message-State: AJIora/8wbqTpm2pypA+Cf1Gmn34+S8pZneN/CYh8ffGCXS5OTmCHMeB
        B+6hhZx/w/wCa3M+Tv8FXGc=
X-Google-Smtp-Source: AGRyM1s7KETEepArG5JL8meMY5y+t8s8chQ/4O2VLPIxoO5+mpzvdwZBLrR6Ib9aQtPfZIU27L5KBg==
X-Received: by 2002:a63:234f:0:b0:405:3981:be7 with SMTP id u15-20020a63234f000000b0040539810be7mr742484pgm.15.1655314183940;
        Wed, 15 Jun 2022 10:29:43 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm9552244plp.302.2022.06.15.10.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:29:43 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 7/7] doc: proc: fix the description to THPeligible
Date:   Wed, 15 Jun 2022 10:29:26 -0700
Message-Id: <20220615172926.546974-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220615172926.546974-1-shy828301@gmail.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The THPeligible bit shows 1 if and only if the VMA is eligible for
allocating THP and the THP is also PMD mappable.  Some misaligned file
VMAs may be eligible for allocating THP but the THP can't be mapped by
PMD.  Make this more explictly to avoid ambiguity.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 Documentation/filesystems/proc.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1bc91fb8c321..a5e41e636a1a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -514,8 +514,10 @@ replaced by copy-on-write) part of the underlying shmem object out on swap.
 "SwapPss" shows proportional swap share of this mapping. Unlike "Swap", this
 does not take into account swapped out page of underlying shmem objects.
 "Locked" indicates whether the mapping is locked in memory or not.
+
 "THPeligible" indicates whether the mapping is eligible for allocating THP
-pages - 1 if true, 0 otherwise. It just shows the current status.
+pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
+It just shows the current status.
 
 "VmFlags" field deserves a separate description. This member represents the
 kernel flags associated with the particular virtual memory area in two letter
-- 
2.26.3

