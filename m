Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4973E596844
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiHQEn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiHQEnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:43:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718B4D834;
        Tue, 16 Aug 2022 21:43:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r16so5624991wrm.6;
        Tue, 16 Aug 2022 21:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=UACsgzg4zvHRWZAiY2XTwdGkhFZ7nkJOvMvp+H83efU=;
        b=LxqfgrQRxH9cVxBmy6mNpakfLl7UYj9+tXLCNREcdEntLd0pdXuOO3BbgYC3UKVYlp
         Aqg0rsH3md+ygovnda3zH2j0KA8RKTQNF6MAObW85HYTx3mB2byTk62ZOWkI8Hm+edNU
         ZCu9SgkqMRskKZ6weJ2ZwcMulfOBk6f2q7cfCrJSeTLOOTEmKjySI7xec7gQFbdiLSHi
         0fWObg+Wybl3M5AMhn+rAWXaAEoAe2BFIVOmNz+j4O3oa3TsXAhi9tzJdtrhO4i/yxHU
         gK5WljdrHM+Dw20qNI3tnouNv1eh7+PaGywVliEGMyOVhHhYyYkoamHWA09Ozshl43bD
         g5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UACsgzg4zvHRWZAiY2XTwdGkhFZ7nkJOvMvp+H83efU=;
        b=YuqOm/nCKEQKQTNYQTqbgXdERJ3hfun1vpk186xEL4haaeTjJy/cmtIHgykCpOAy9f
         4KLxwfCjqeq3Yi+ZFLateoiunFVOwhtBB1v9NUz+7Cjc43QaQ+oJJx8S9pS74TuxtOJx
         VD13bigfIL14ty41qQdZDPMoeWUnNKtMuFkr2yUaboU4raoURV3UMAqY6W31YP4sPtJ/
         yCWr6y4z5t0eb2yVVbYuReFA3pq7Xw4zz17yGiWSmb9OZXfIf92FQwzu5gw1f2IaW6Nq
         OE1pXV/g/23QSUf9DuYSyxT+K/CVY537QfibdR2fCZxf5oNuMUY4ikc0YunUnNugiRau
         t67w==
X-Gm-Message-State: ACgBeo0Fz1RSf3SqrduKE86yVxlnzu66Q4EY/8TaaQWbPFhYQYWDulKD
        Axq5Pq++QBVT7D0iwa55Zrc=
X-Google-Smtp-Source: AA6agR5q4ITliuREdqBZMGN+ngSPk5+CneCGqoC3bxyecQ+Oy/RJSsdqRjd7lrglFQLV9L2r1hKpvg==
X-Received: by 2002:a05:6000:1a88:b0:222:ca4d:f0d2 with SMTP id f8-20020a0560001a8800b00222ca4df0d2mr13922194wry.610.1660711432645;
        Tue, 16 Aug 2022 21:43:52 -0700 (PDT)
Received: from felia.fritz.box (200116b82633f20060f31b3eb0891b8b.dip.versatel-1u1.de. [2001:16b8:2633:f200:60f3:1b3e:b089:1b8b])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b003a2f6367049sm735112wmb.48.2022.08.16.21.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 21:43:52 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] xen: x86: remove setting the obsolete config XEN_MAX_DOMAIN_MEMORY
Date:   Wed, 17 Aug 2022 06:43:33 +0200
Message-Id: <20220817044333.22310-1-lukas.bulwahn@gmail.com>
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

Commit c70727a5bc18 ("xen: allow more than 512 GB of RAM for 64 bit
pv-domains") from July 2015 replaces the config XEN_MAX_DOMAIN_MEMORY with
a new config XEN_512GB, but misses to adjust arch/x86/configs/xen.config.
As XEN_512GB defaults to yes, there is no need to explicitly set any config
in xen.config.

Just remove setting the obsolete config XEN_MAX_DOMAIN_MEMORY.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/configs/xen.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/configs/xen.config b/arch/x86/configs/xen.config
index d9fc7139fd46..581296255b39 100644
--- a/arch/x86/configs/xen.config
+++ b/arch/x86/configs/xen.config
@@ -14,7 +14,6 @@ CONFIG_CPU_FREQ=y
 
 # x86 xen specific config options
 CONFIG_XEN_PVH=y
-CONFIG_XEN_MAX_DOMAIN_MEMORY=500
 CONFIG_XEN_SAVE_RESTORE=y
 # CONFIG_XEN_DEBUG_FS is not set
 CONFIG_XEN_MCE_LOG=y
-- 
2.17.1

