Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696EA54E8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbiFPRtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiFPRtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:49:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417764D621
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u2so2123544pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbrfBk2owseXTl2TqGluY3ivP+501euUdLqfR5FVpCc=;
        b=F7+G3ESb9pcGIuGXoF2O/H03YvYsGpLhfNOWSQqYVP5yFLNGleH39xqFQ8cWIZuFho
         xg3heTbq6ePKtRc8GFH0juCyjezdh2hqyFjPBLzT9941kxHwTK7yLUeKVkiQKo6mDCxu
         se3LMMGqxW6HiTvu93X33WpwUBs73ecdVSU001ye3aHuc0r0loPqN+9Uj09NMTU9BWna
         ENe8DNgwYHvtpA6ITqyCZUYZN8mAOAXoWKj0lirO78K389Cubg2uLLRLQv4c9eITuXpW
         hzCgRhi/7HJwNubd85XqcCfY+TlKwnYPFZ+SI68tWv28Ig/OEhTEMpCtXj3Cf1NQPEVQ
         Vnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbrfBk2owseXTl2TqGluY3ivP+501euUdLqfR5FVpCc=;
        b=ekDrxr157AJEaTTiz0OPhPOuIA4q6udd4h29O/6yfcrEEa//ud6wnYaAKnPXHnVIgr
         YXeIoVtpapnietsgiErQy9dfMBI2aCBVBEBIxIzDgjVbGjMEH27I5ddypl4EYysqat0u
         6GwcFrJ6Wgy364n/Za3Co1WYW+P3b8kDgLkYwgxEP5+K7pRFXcfGcjmRuehJ6neMqLG5
         88+hd6j0uoO5Oe9MXftR11d9FOa04f+wMI5N1tyPiNMOYm3XxzQ9NbuzKYubRomQ3Q+8
         xv50MClGSLtaTYnXKcwXlnpS40tiqFcUz/lBThk2HtvWttZt6A0g9NALUGR2F7rzaCRy
         JV8w==
X-Gm-Message-State: AJIora92FRQ7oxvDSvyZHxDBpjVuUfEBMeYqGKveavyHniKK4XCCyzHQ
        2rzBuC//FKb2wbI3O0zR1Xo=
X-Google-Smtp-Source: AGRyM1vtFhWJ5FLzx5f3p3o/qmSs8NJRmjg3vyIZZSoaHxETIbvnT3f9vP9XDu44HCWoj/kKASXWTg==
X-Received: by 2002:aa7:88cd:0:b0:51c:188e:fbeb with SMTP id k13-20020aa788cd000000b0051c188efbebmr5782611pff.81.1655401738804;
        Thu, 16 Jun 2022 10:48:58 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001e8520b211bsm1818289pjn.53.2022.06.16.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:48:58 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v5 PATCH 7/7] doc: proc: fix the description to THPeligible
Date:   Thu, 16 Jun 2022 10:48:40 -0700
Message-Id: <20220616174840.1202070-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220616174840.1202070-1-shy828301@gmail.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
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

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
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

