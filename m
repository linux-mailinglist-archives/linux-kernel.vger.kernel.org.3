Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F294BED93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiBUXIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:08:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiBUXIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:08:19 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CFA245A2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:07:55 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id y7so12580006oih.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6K9hTlkQ4IuC5xmGrUgF+6JWWC3ZwdH6QIpXtFbws0g=;
        b=i8nDzUKLL6rl5JY+BgTbruX22+HINcIGZojgBS+l7EOBSHob/zHQxoKz/rkvzwl1jO
         9YerA5fgBQmJIwTTi6k6UHdz3vUY/X7TxrmsFdswjaJbTgyLqJYI5TRX4qblgzViScrE
         PM5cu952Udn/bV639XnzW7WxzS5pw5h71bhAk2VA+wSZYd8ywnLmyqjJNTB7kHbHm2Te
         USBLUR7yd5Wut+NDPKADvaLjbtefpgdz6NqyJjBGvJve/L7j1nmkE584JVP6jdVZSwTf
         8rBzO56Zby58yhsJAUY/Kg0InO05ihiGpt7p5+9yROxNHi66vc2JfpCRRZYA/vCReqlX
         /rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6K9hTlkQ4IuC5xmGrUgF+6JWWC3ZwdH6QIpXtFbws0g=;
        b=qzRkJnHj6PNPX3agD8ZUyjK6ItaAu/V7kRCJ41jgwbc9r25f1P8hTbAh26ZjVSDE0e
         RHkQYSn/F+4LD3qwrsCdStBxkuqSzU2jtbzhvBTcil7gU9ssTyOXu1hqIkJsFaQmwunO
         k0f6dscg0DmAmZPWtm5niK4SNLwHbnBpW2EjhGrxMYiQn5kMiAENxvdVycGeQONIqJva
         WDgC/QyAJTvhnq3arAOvVhj8n8Occs4cRMKvgJOdRyBBejT8Dg6MZ5drxCkZ1zq+PjEC
         XRrr9XrOosL7B8NX26UP4L6eQwlwfmB1EWEGBXLFErUq4h5g9Y13aYhj02N3C2byaUQv
         raEA==
X-Gm-Message-State: AOAM533p3q1b1hDE1jdewQY3jUA2AM22T9mXXUgvcEiPwxbGXkMaxKo/
        7WxXs49pAZzVqe+GdT8PVaU=
X-Google-Smtp-Source: ABdhPJxCfUmPQeVI/1O8188AGEILF/Zou414Etg6LvUSSQRojMCG4adcQooCcGCcPJHByAYwAym59g==
X-Received: by 2002:a05:6808:128f:b0:2d5:3582:f5fa with SMTP id a15-20020a056808128f00b002d53582f5famr650923oiw.283.1645484874334;
        Mon, 21 Feb 2022 15:07:54 -0800 (PST)
Received: from localhost.localdomain ([189.78.255.5])
        by smtp.gmail.com with ESMTPSA id z4sm6142794otu.24.2022.02.21.15.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 15:07:54 -0800 (PST)
From:   Magali Lemes <magalilemes00@gmail.com>
To:     mpe@ellerman.id.au
Cc:     mwen@igalia.com, maira.canal@usp.br, isabbasso@riseup.net,
        siqueirajordao@riseup.net, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
        Magali Lemes <magalilemes00@gmail.com>,
        kernel test robot <lkp@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Fix missing declaration of [en/dis]able_kernel_altivec()
Date:   Mon, 21 Feb 2022 20:07:41 -0300
Message-Id: <20220221230741.293064-1-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.25.1
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

When CONFIG_PPC64 is set and CONFIG_ALTIVEC is not the following build
failures occur:

   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c: In function 'dc_fpu_begin':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:61:17: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_vsx'? [-Werror=implicit-function-declaration]
      61 |                 enable_kernel_altivec();
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 enable_kernel_vsx
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c: In function 'dc_fpu_end':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:89:17: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_vsx'? [-Werror=implicit-function-declaration]
      89 |                 disable_kernel_altivec();
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 disable_kernel_vsx
   cc1: some warnings being treated as errors

This commit adds stub instances of both enable_kernel_altivec() and
disable_kernel_altivec() the same way as done in commit bd73758803c2
regarding enable_kernel_vsx() and disable_kernel_vsx().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 1f43ef696033..aee25e3ebf96 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -62,6 +62,15 @@ static inline void disable_kernel_altivec(void)
 #else
 static inline void save_altivec(struct task_struct *t) { }
 static inline void __giveup_altivec(struct task_struct *t) { }
+static inline void enable_kernel_altivec(void)
+{
+	BUILD_BUG();
+}
+
+static inline void disable_kernel_altivec(void)
+{
+	BUILD_BUG();
+}
 #endif
 
 #ifdef CONFIG_VSX
-- 
2.25.1

