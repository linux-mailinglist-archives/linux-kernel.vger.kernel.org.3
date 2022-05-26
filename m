Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B1535395
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbiEZSyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiEZSyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:54:11 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F49BC5DBD
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:54:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 184-20020a6306c1000000b003f5f304ec78so1174614pgg.20
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JMJVGg1qZnHH7C8ATRhIwxxHuj2y9HrWKG9Y6P+CVa4=;
        b=X5QPBT3rcKnwfVEC/ZgYYSC6s8s4hl/iM07SHcdQvxHX45jXMkjkR98a8tHk1s7i5i
         hljpwk+zr49ln6Bl0myvnXkNbU6M4CQRGem0QlWNioGpY50exkY88Nc0Apae4xthVSQR
         6MPnaB64Oh1y40FPM2rQ67fKHreHbBRsrQpolC3b5t0SUpG8psfDw5rL6EuTo6QvFEsk
         pqJWwDC5nMfeXGHP7Yp9zVScxEy42RXSy8T8hend0JQlo9eTB/K55klwydC8EfiAT8Ow
         Gt+e7E1RE2ynwxJhN+IiRfttkfXCOj2DTeFCcOdejadGU7QPWJ2uPrIKTEdIbNY5XfGa
         Nnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JMJVGg1qZnHH7C8ATRhIwxxHuj2y9HrWKG9Y6P+CVa4=;
        b=h6fy9tMm2Lb3/vbtR4VwQ2dFnPrjcLoDynLkW64M8Ptk2rbi3Ik8Uaji0JPFf4hdfN
         DSKS4Ke5tcKjvbw9gxEaHbiGeKztF9GX8c531zPaq5fRbQq1vfi9M5nznpazUZC64lXk
         PEm/4shiodACKQ6+F5SK+u27HB0ndvOgCI5jZATA6nEVICikpz+QhsUoICeVz21cSs/H
         Fjq/+cXiP7ObLnKruo5RJDDac0Mmb8E6fO6syKysscLqW79llllM71HR9gqTv1S46Blu
         zNifbbITRuDevfDAQV0UERytq3UuGAVFk9AVmmuH4NG4YD2EMQJo13l1m+SA+JdmtMvT
         p51A==
X-Gm-Message-State: AOAM530ltVEmK1U2InJ3hNbGkooWqm3l178ty40GJfEgijdtqWGlogDq
        lQTrXf3F1Sxz+L5tBEofnAqjh2YAgRnX+w==
X-Google-Smtp-Source: ABdhPJwkL12I0XRvEV0PkVlYwPoUUg3RtRs/pjbKCaMCuJjBBTvAJP2uFoE18EfQYR8oMmERKPOp9uUFvMN9/w==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:e2f9:ca60:7aad:75cb])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:996:b0:505:b6d2:abc8 with SMTP
 id u22-20020a056a00099600b00505b6d2abc8mr40111331pfg.11.1653591249518; Thu,
 26 May 2022 11:54:09 -0700 (PDT)
Date:   Thu, 26 May 2022 11:54:02 -0700
Message-Id: <20220526185402.955870-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH] arch: um: Fix build for statically linked UML w/ constructors
From:   David Gow <davidgow@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_CONSTUCTORS is enabled on a statically linked
(CONFIG_STATIC_LINK=y) build of UML, the build fails due to the
.eh_frame section being both used and discarded:

ERROR:root:`.eh_frame' referenced in section `.text' of /usr/lib/gcc/x86_64-linux-gnu/11/crtbeginT.o: defined in discarded section `.eh_frame' of /usr/lib/gcc/x86_64-linux-gnu/11/crtbeginT.o
`.eh_frame' referenced in section `.text' of /usr/lib/gcc/x86_64-linux-gnu/11/crtbeginT.o: defined in discarded section `.eh_frame' of /usr/lib/gcc/x86_64-linux-gnu/11/crtbeginT.o

Instead, keep the .eh_frame section, as we do in dyn.lds.S for
dynamically linked UML.

This can be reproduced with:
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_STATIC_LINK=y --kconfig_add CONFIG_GCOV_KERNEL=y --kconfig_add CONFIG_DEBUG_FS=y

Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/kernel/uml.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 7a8e2b123e29..71a59b8adbdc 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -95,6 +95,7 @@ SECTIONS
   }
 
   .got           : { *(.got.plt) *(.got) }
+  .eh_frame       : { KEEP (*(.eh_frame)) }
   .dynamic       : { *(.dynamic) }
   .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
   .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
-- 
2.36.1.124.g0e6072fb45-goog

