Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9556A1B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiGGL7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiGGL6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:58:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2960520;
        Thu,  7 Jul 2022 04:56:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n4so12711997ejz.10;
        Thu, 07 Jul 2022 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=2rCng+c6+Ic3ugn7usdk1Bb1bCGkkTmVKqnPhZXSPqk=;
        b=FE1lOsq1SvOf0A7puhlFa8iv0gg261tT/ojI+wPTpodjibJR7/N/37HnPQ0TJ8lu5W
         OfOA5oXX+8JfILRl+YzcvfbyTsolsSYGbvFxXGbImRqFyBOeaoriicR7Ac4x43PIac9L
         ngBNSGsSI1Iz+9QGe5wL2MLKL1wASOhlROtPkfujryvtREu+lCTurM/1IxQMzroNgNY4
         T8RnNSiXBCHXGD6+KRa05dNDDYYHeM4XVvNYwpNwzxn8xfvGsCmlMyNfiOp5YgwdNqDG
         FT8cDqW9F9Y3u7cb8bWeTA8XiBAUmxQam/GTBlGLqqqx8vhoEuLUGvyMWYCd4VqOAvpl
         zAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2rCng+c6+Ic3ugn7usdk1Bb1bCGkkTmVKqnPhZXSPqk=;
        b=Y+4nufCjkB+qDOe+a2Mpo+dC4+9rn9P6VIM7DNp2snrzupjeg/E9LqKIqd4oTqL1UT
         BUEJNjBzmSl/86pODIhmUfaiOiUL1DG5V16RrLX5K20M0wElZUJG20aeRPR4iu1dCPxA
         ZiVDotjFIPCFVNWonGJvD48FROndCzCTuqFDJPtx2olRSgLYHolXuSX/rwsd+Uw7GNBQ
         g622Gr/YoZwrICc0w9pjQWKbLhceF2gZ3srcjjl+58YWFjfiaeVaezcmli//ENS+1LHf
         38j/lZwPtBc3xzdx8192fzxNylBl9c9qKyIFF6RliX298YTKBt1yy/Sap2QrVnicJH1m
         1RaQ==
X-Gm-Message-State: AJIora8oIop3uiWaMO77dXKnJsVzj6/XuGZAMBaqFUXoP83Ns7Oh9FOV
        hGoTuncyQAJd3UTBPi5rMSnIHOuYNso=
X-Google-Smtp-Source: AGRyM1t6B+Y8Zy+zmKbmWqwBGZPp/d+cPAdaYLN//Bp16hveKRBbcKnTN5OLLQqyKEAyZj/CqSIlWg==
X-Received: by 2002:a17:906:4fd4:b0:722:f223:8d86 with SMTP id i20-20020a1709064fd400b00722f2238d86mr44652077ejw.558.1657194985535;
        Thu, 07 Jul 2022 04:56:25 -0700 (PDT)
Received: from felia.fritz.box (200116b826df3d00599ec68d191c47fa.dip.versatel-1u1.de. [2001:16b8:26df:3d00:599e:c68d:191c:47fa])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906301500b00728f6d4d0d7sm12078708ejz.67.2022.07.07.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 04:56:25 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] x86: mm: refer to the intended config STRICT_DEVMEM in a comment
Date:   Thu,  7 Jul 2022 13:54:42 +0200
Message-Id: <20220707115442.21107-1-lukas.bulwahn@gmail.com>
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

Commit a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads") adds a
comment to the function devmem_is_allowed() referring to a non-existing
config STRICT_IOMEM, whereas the comment very likely intended to refer to
the config STRICT_DEVMEM, as the commit adds some behavior for the config
STRICT_DEVMEM.

Most of the initial analysis was actually done by Dave Hansen in the
email thread below (see Link).

Refer to the intended and existing config STRICT_DEVMEM.

Link: https://lore.kernel.org/r/f9074e8d-9314-9d7d-7bf5-5b5538c8be8d@intel.com/

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/all/20211222125347.13054-1-lukas.bulwahn@gmail.com/
 
 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d8cfce221275..5d747a1923cb 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -846,7 +846,7 @@ int devmem_is_allowed(unsigned long pagenr)
 
 	/*
 	 * This must follow RAM test, since System RAM is considered a
-	 * restricted resource under CONFIG_STRICT_IOMEM.
+	 * restricted resource under CONFIG_STRICT_DEVMEM.
 	 */
 	if (iomem_is_exclusive(pagenr << PAGE_SHIFT)) {
 		/* Low 1MB bypasses iomem restrictions. */
-- 
2.17.1

