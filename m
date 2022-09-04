Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED6F5AC7BF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiIDVqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiIDVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:45:22 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EBC30F48
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:43:02 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y187so5724227iof.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bXSeYH0zduNfWYtAn2/GFLXR9T03/2CnSS0WiVim3VQ=;
        b=Kz5c1apWMX0yddvgXTrt/BjoeN52CrK81vVC2ejDG94BrieUIvPuQxqUc9mOpTS/PP
         HWECHkoY/OGUf08e39Nmu5OrgrRhJWG04JFoAaPLsxT6JyFH/YDSudtSKAU+VFekFYsq
         Vod9PDrJCKlyWzWt7qenFWfsvqXS3nuOE+JpI9yW2OwLoVmYddOY5g5wBsTWGPdp/8D4
         T8EWSg90FSXg58mfxM0h4Ijo4DgetN371n10Vzcly6r5kLaSzcQu1NTLn9EFrrE/z+XJ
         JBzGq1uSt6X2fse4mVKP1vmF2LWn1W1sfDqy+6kqDBUE4JOdFjuhQGLvtnC0Saz04FMW
         fgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bXSeYH0zduNfWYtAn2/GFLXR9T03/2CnSS0WiVim3VQ=;
        b=3P0llUGmhLrShxFvOD8K817PfE6iYcIYWVOUSG/SG6W+eNnDyrd3U+iaMVk3ElJ7pQ
         YBnrXtbH0xTYcYdp0UEoxLdkQfahJwBttDV1PfdQuWsnjh2uDTSoA2641/4eN/CaNbXx
         lw3dwtsqFaNrYzLHN/a2GV92QMQ4huiFVgSqK7hOc505xYwM3y695OdJlneu1cSjj672
         1xTVbQje9YKiuQMUgYfJnZJf12utPcbb17ioY61Vfag55eeti28unv4Q7P7PD7JHS/Ku
         Y7sTyxU2hJylpmI0IXXG+xEfhxLDaS0tGmRGevHUeuBZV78Qhw0H4S5BaHo39dKEpf6X
         ER1g==
X-Gm-Message-State: ACgBeo3DKyjuRUWv0h8PxjlNe4uZSM9CaVHxiOj1tuBNpJqiXSrUXg6k
        sn46fb7ckVmBOZ2K9Q3xrGM=
X-Google-Smtp-Source: AA6agR4F0Y5uoS0j9obmZc9hPIHDQS7tGY0siR2ILOqRr5ep1L+AxeY27R3APLGSgxbHOp+TIgipXA==
X-Received: by 2002:a05:6638:40a8:b0:346:8e3c:8141 with SMTP id m40-20020a05663840a800b003468e3c8141mr24647914jam.107.1662327782109;
        Sun, 04 Sep 2022 14:43:02 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:43:01 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 54/57] dyndbg: add .gnu.linkonce. & __dyndbg* sections in module.lds.h
Date:   Sun,  4 Sep 2022 15:41:31 -0600
Message-Id: <20220904214134.408619-55-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a long time now, loadable modules have tacitly linked the __dyndbg
section into the .ko, as is observable in dmesg by enabling module.c's
pr_debugs and loading a module.  Recently, __dyndbg_sites was added,
following the original model.

But now, we need to explicitly name those (__dyndbg, __dyndbg_sites)
sections in order to place new .gnu.linkonce.dyndbg* sections in front
of them.

This gives us the properties we need for _ddebug_map_site() to drop
the _ddebug.site pointer:

   fixed offset from &__dyndbg[N] to &__dyndbg[0]
   container_of gets &header
   header has ptr to __dyndbg_sites[]
   __dyndbg_sites[_map] gives de-duplicated site recs

NOTE

HEAD~1 took headers off front of descs,sites and saved them into
_ddebug_info, this puts the gnu.linkonce.* records into those vectors.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/module.lds.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/module.lds.h b/include/asm-generic/module.lds.h
index f210d5c1b78b..328c48dfc88c 100644
--- a/include/asm-generic/module.lds.h
+++ b/include/asm-generic/module.lds.h
@@ -4,7 +4,17 @@
 
 /*
  * <asm/module.lds.h> can specify arch-specific sections for linking modules.
- * Empty for the asm-generic header.
+ *
+ * For loadable modules with CONFIG_DYNAMIC_DEBUG, we need to keep the
+ * 2 __dyndbg* ELF sections, which are loaded by module.c
+ *
+ * Pack the 2 __dyndbg* input sections with their respective
+ * .gnu.linkonce. header records into 2 output sections, with those
+ * header records in the 0th element.
  */
+SECTIONS {
+__dyndbg_sites	: ALIGN(8) { *(.gnu.linkonce.dyndbg_site) *(__dyndbg_sites) }
+__dyndbg	: ALIGN(8) { *(.gnu.linkonce.dyndbg)	  *(__dyndbg) }
+}
 
 #endif /* __ASM_GENERIC_MODULE_LDS_H */
-- 
2.37.2

