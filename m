Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1872516149
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 05:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiEADOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 23:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEADOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 23:14:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5A13E15;
        Sat, 30 Apr 2022 20:10:56 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 7so5482830pga.12;
        Sat, 30 Apr 2022 20:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gd2us8NUVipiwLDR5mx/kIPHJNQqA2fk6Bq4Tsdy2Co=;
        b=VczFoOUCenfOx0o7ltypvlFomDEGtBw7M75VNGmo/+qhlW3IfQBL+/8BHAKtPzQRhf
         QhqSqXgPJqCCCfP0TEZbut1EjWkdHBcQCB7jytwl8ODgft9LUfAClmOELAkzTNSnbAsu
         grHi41ndemZ05Q3qdm3MSYN8tAeIVoPTZz4+m9PKSfpTqJD7/aPK+tzKzJDcU8noyy2z
         sHTm588IrnChoSCwSndD1k7a6uxVPNBM8idM0Z1e7Uz8J6lS+AcfoojPeIUKVjvWVzRp
         MvIweRVoWjNE9J0JfOaxzQ7nRLNlPqFKivON9QGntYqMI9+qAQPtZn5ap2eVaXyYJqkz
         oGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gd2us8NUVipiwLDR5mx/kIPHJNQqA2fk6Bq4Tsdy2Co=;
        b=yi3dKVLVLKYvWePWxMp3tkFT3kJL7F7Xaj2esYoPgSf7HleUnymkluSQ34Ls6Dq7gq
         kmy3VRi+Ac5pGEnaS9Hv0YLdKCkw5kJgF1RUqtUFnzs/0Ni/JFoy3wAru2LLAI+RPtXo
         c4eX1nZhYP8TtdoPM/jbeM/PabEB8fJPYKwfzpGuRLyYhcxN6hcOdAOopYbEMp4w+d+J
         7hJh1uQ1ZF/QzOtZYFVnuhrHIKbSCJCUI51h+6AFxWPk/ecgGCsJhIJCXIBSEOHAP8YW
         Dc+m9uvfsLUNJW7FtZdkMkWj28SjlRdwzB4zcsiA0VipelgBMIrhSlgk17ZKZm4SZDAm
         fbkA==
X-Gm-Message-State: AOAM5315mhfHT/ankjtqZDjNGQM2Ia9ASA1UDVLDOFXuLQ6Vwhieuirr
        5b6gyXVgaKzB7Qbi/r9nKN1IPt2+wiznOw==
X-Google-Smtp-Source: ABdhPJy9t5JbvawKY5yDf4AIrS1Ck1CdCfH5hOlD5JtuSy3MaTurzotykCHRPodQg1mp4th+n7sOrg==
X-Received: by 2002:aa7:88d3:0:b0:50d:a2d7:7f12 with SMTP id k19-20020aa788d3000000b0050da2d77f12mr642121pff.27.1651374656345;
        Sat, 30 Apr 2022 20:10:56 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090a13c700b001cd60246575sm17685923pjf.17.2022.04.30.20.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 20:10:55 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
To:     macro@orcam.me.uk, tsbogend@alpha.franken.de,
        liam.howlett@oracle.com, geert@linux-m68k.org,
        ebiederm@xmission.com, dbueso@suse.de, alobakin@pm.me,
        f.fainelli@gmail.com, paul@crapouillou.net, linux@roeck-us.net,
        anemo@mba.ocn.ne.jp
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3] MIPS: adding a safety check for cpu_has_fpu
Date:   Sun,  1 May 2022 11:09:56 +0800
Message-Id: <20220501030956.786012-1-starzhangzsd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

There is a chance 'cpu_has_fpu' would still be overridden when the
CONFIG_MIPS_FP_SUPPORT configuration option has been disabled. So
add a safety check for 'cpu_has_fpu'.

Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 Changelog in v1 -> v2:
 - Choose to redefine cpu_has_fpu to solve the problem silently.

 Changelog in v2 -> v3:
 - Choose to point out the error instead.

 arch/mips/include/asm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index de8cb2ccb781..57ff0f8a507c 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -134,6 +134,11 @@
 # endif
 #else
 # define raw_cpu_has_fpu	cpu_has_fpu
+# ifndef CONFIG_MIPS_FP_SUPPORT
+#  if cpu_has_fpu
+#   error "Forcing `cpu_has_fpu' to non-zero is not supported"
+#  endif
+# endif
 #endif
 #ifndef cpu_has_32fpr
 #define cpu_has_32fpr		__isa_ge_or_opt(1, MIPS_CPU_32FPR)
-- 
2.30.2

