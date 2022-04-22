Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A50E50BB8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449386AbiDVPVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449385AbiDVPUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:20:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE955DA4F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:17:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s17so11498971plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugUPrPCeG+4KNh4o4UU3L2XGTAsONRbVSCUPTlkzE7s=;
        b=a9+lKlXL3U13tWvDJ6tIe5Q55LL14Jf6zP882Dk0M4Bn8LCTX5wKMesGdJR9Kwkv9p
         Fr7H1cRJiofWgoj74aJUCUiCnHt5riiH/hUtlhavaUdyhjP8DgQ/8JP7VRhIbFuvvqEx
         hQVg01WfwiThjfFqmOqJkrXQfGHwEySV3DgWt8gu93HrwIDOgoK4zzseRN50ZoULGFw7
         mJkRVZU9dYxiZPNh46lxZM9MryhlTMGsjBYLPPUXiD6zw4oBlbmIkLlKQyi+FfLRBikq
         igpMyXwdJ6Qkk5MSDpbaiaYxnqgZwgIhIv3medhzTBWfKRB59oVa33b1Sa/AndcLvZEu
         3HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ugUPrPCeG+4KNh4o4UU3L2XGTAsONRbVSCUPTlkzE7s=;
        b=c53HnsfhlRej82vFWR5M4Dciz2kkAps2DZuoWJZdkMO6x9YfonC0ke/cRvEHBxyfwb
         ZECxLQjXkIRgEOm0/0pAim6JnRNs6HjIbo3RdFINbGHIc0y4jNWfyTTEdlHqdA8NsMO4
         ixPkP8lghKvLOFR7xpEy/ssZLFxP+BJjQSL8GTTxpdMIP1TLa7aoqBuixY5lZBfLvvBz
         E5n8bnTzrxxSwWIScstcFfpm0h04dqTycD6uZuyDgw3ocqp1wh2Fl2N0KLQHZj8PqVNn
         jn/UVii2BjVJXzbSqqVzr9r9nB+yLVj8kvncw+DPBhlSGW0GNOP15DGlzn2+uBHVO85X
         Dl2Q==
X-Gm-Message-State: AOAM531JW8VcywuYmX379lNsDCapzRJVBXZ3MLoTfjP1h3cjfrzOWyTb
        YpZ7F1NUBPagEfKR8rtafEM=
X-Google-Smtp-Source: ABdhPJzG9sdIxFzivmJ9pmxye4wlB9xJam4o9CQAWzW4qnh2/VLQv+LZp+/fy6dblqPnLGOFLfwkUQ==
X-Received: by 2002:a17:902:f64e:b0:14d:20db:8478 with SMTP id m14-20020a170902f64e00b0014d20db8478mr5245444plg.158.1650640678527;
        Fri, 22 Apr 2022 08:17:58 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id o11-20020a62cd0b000000b0050ce8f98136sm2980459pfg.149.2022.04.22.08.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:17:58 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] checksyscalls: ignore -Wunused-macros
Date:   Sat, 23 Apr 2022 00:17:25 +0900
Message-Id: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros defined in this file are for testing only and are purposely
not used. When compiled with W=2, both gcc and clang yield some
-Wunused-macros warnings. Ignore them.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 scripts/checksyscalls.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index 9dbab13329fa..cde15f22ec98 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -255,6 +255,7 @@ cat << EOF
 /* 64-bit ports never needed these, and new 32-bit ports can use statx */
 #define __IGNORE_fstat64
 #define __IGNORE_fstatat64
+
 EOF
 }
 
@@ -268,4 +269,4 @@ syscall_list() {
 }
 
 (ignore_list && syscall_list $(dirname $0)/../arch/x86/entry/syscalls/syscall_32.tbl) | \
-$* -Wno-error -E -x c - > /dev/null
+$* -Wno-error -Wno-unused-macros -E -x c - > /dev/null
-- 
2.35.1

