Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A466C4F7507
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbiDGFAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 01:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiDGFAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:00:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B583A1DB7C6;
        Wed,  6 Apr 2022 21:58:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t13so3999133pgn.8;
        Wed, 06 Apr 2022 21:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JP74ztnW9mN5Wx5SZxZ1rwxOY5BhzSJW2zDiwmBFA8c=;
        b=lf4bCwCADH4PnWz+xVjyrp3OLa2XZn0LE4eJTYa5HRncMriSOQm3kecvJpNID9GKPy
         0lxfOTBLqW1YFniQs1hOQlicrE6FQOwkk0UgippUw9cy81/+NjCz1LB3smnbIJc75Pn/
         ukkmK8pWMc3w4B3sMYdYmAsaotLThoZWZmUvptlIY1TpwfCkE/9OMZ36HzshUzFt9HWW
         NvqKH1oW7yqetneVxt+yXaLcfX5ND5dy5ztbIePf1WXksZro3ANAV061lyHwsuCtVQg2
         uCuu3WyO2ai+murmZAwE/n+XdcfZhCe+caW5LxctPap+B9uQr6cHhVBQV21h1rrpRpYg
         iD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JP74ztnW9mN5Wx5SZxZ1rwxOY5BhzSJW2zDiwmBFA8c=;
        b=zbCSjL2lZ+ZH6taii1bt7o3PKPBwK2bZ8MWwUIyVGepxLxg8CqNiesvN3QlUkwUfQi
         LDo5zJHbvszE8/iO5kK1Aw0CIXrS982Wu0Psm938xVrlu8LN7X+Hu6w+ezSUcBGwEezA
         pshxbbcrbI1ojXZW3u3DLXeiJs3EQtgmeVe1Sq3GpbWhB8D7xtyiEpIynjJ1hLMW7T0z
         j81BObdsh+jzz0It/n4KjfVMP2jSOMb4/+03JpsT47DUBPlGdP4hswjMjQDOUCNKwzXm
         eIec4MqgDnqR+iEHjLgro6JC1BRp+rAhJiMMCag1jLuvEaSCgqZzp+W5iIAwGz0+bSge
         fCUA==
X-Gm-Message-State: AOAM5323daBoIU/FUp4Di55krA3sn0BkUyeLBo0TRHGLhtBhp08X1Jiu
        UBajeiQ4/6yegEqZAVnNx+wSSap5Ds2hzbUR
X-Google-Smtp-Source: ABdhPJzuQb2+diHki7FV0XVGsaaeG3wNIfPoOd/ZJr1T1ATmJeGtjN8t0lkeSC2qqXoYyVv1xRmpLg==
X-Received: by 2002:a62:4e4e:0:b0:4fa:b1d4:3405 with SMTP id c75-20020a624e4e000000b004fab1d43405mr12409865pfb.71.1649307520038;
        Wed, 06 Apr 2022 21:58:40 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm21946356pfi.149.2022.04.06.21.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:58:39 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: arch_pgtable_helpers: demote pgtable list headings
Date:   Thu,  7 Apr 2022 11:58:30 +0700
Message-Id: <20220407045830.181514-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All page title headings in arch_pgtable_helpers.txt except
"Architecture Page Table Helpers" should have been subheadings instead.

Demote them to chapter headings.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]: 
   - Rebased on v5.18-rc1
   - Describe why the patch do the job

 [1]: https://lore.kernel.org/linux-doc/20220326131313.691027-1-bagasdotme@gmail.com/
 Documentation/vm/arch_pgtable_helpers.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
index f8b225fc919047..cbaee9e592410f 100644
--- a/Documentation/vm/arch_pgtable_helpers.rst
+++ b/Documentation/vm/arch_pgtable_helpers.rst
@@ -13,7 +13,7 @@ Following tables describe the expected semantics which can also be tested during
 boot via CONFIG_DEBUG_VM_PGTABLE option. All future changes in here or the debug
 test need to be in sync.
 
-======================
+
 PTE Page Table Helpers
 ======================
 
@@ -79,7 +79,7 @@ PTE Page Table Helpers
 | ptep_set_access_flags     | Converts into a more permissive PTE              |
 +---------------------------+--------------------------------------------------+
 
-======================
+
 PMD Page Table Helpers
 ======================
 
@@ -153,7 +153,7 @@ PMD Page Table Helpers
 | pmdp_set_access_flags     | Converts into a more permissive PMD              |
 +---------------------------+--------------------------------------------------+
 
-======================
+
 PUD Page Table Helpers
 ======================
 
@@ -209,7 +209,7 @@ PUD Page Table Helpers
 | pudp_set_access_flags     | Converts into a more permissive PUD              |
 +---------------------------+--------------------------------------------------+
 
-==========================
+
 HugeTLB Page Table Helpers
 ==========================
 
@@ -235,7 +235,7 @@ HugeTLB Page Table Helpers
 | huge_ptep_set_access_flags  | Converts into a more permissive HugeTLB        |
 +---------------------------+--------------------------------------------------+
 
-========================
+
 SWAP Page Table Helpers
 ========================
 

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
An old man doll... just what I always wanted! - Clara

