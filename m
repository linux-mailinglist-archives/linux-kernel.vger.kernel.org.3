Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30F24AE3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiBHWY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386838AbiBHVQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:16:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B900CC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:16:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q199-20020a252ad0000000b0061e113c9953so254768ybq.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ITTJ1A6lXvS57TZRz+Myy0dfx6nkaF0DnZNJ01aeefk=;
        b=R8njhaB+c1wmWoG0XOQ9y15iLwF8nqIFMc++mJHiv8K6Y14SMIgc2E5W7t/1d2x4bl
         jSPfZeX8JfkXAz5jqGvXyDm/WJUh3TIwx/xarNaSTYjsFmPST6lb1vhExTPJbkeSyx5z
         vBaO6RnGFRPqICmEa5HqbHTo77y3B/tDX8FuI3vWa6zHue7poO/K/8YoYUW+XhpoLMQZ
         ne9rwQhfZWr40hQw2bx/cJuo4J/55zUrF55PFthaJpnhmtNroU8YooetYYYdjIj0XEcQ
         nSsKv5o5dsxZQGhj5Ukc6zM+I63aHw+AYe/lljVMAbMKbQnEu/vvkr004fLFxve2E0fi
         0jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ITTJ1A6lXvS57TZRz+Myy0dfx6nkaF0DnZNJ01aeefk=;
        b=Yjhz60UqcriXasOW2+jC3rvs/6vAHwYdZuuhM1xGiq4kaOB2Sy0O05YrTTWOCHE1ap
         S/1NRbwhJuPZ2IHYajJikCCDj5c7pw1BiJZp1H2+7/u1My4ffwOH8Yxb2ZraTy0btFgn
         /y1PTuj6mm13crRmaMRR4jmx4PR89wvyErVLj+MPnOSEpzZlVbyEtO+LbKb2M6iVD7fk
         MTiFLqB+V9kcwV4NpRdxR2xfff8HtXT3W/ZBEN6JRQw3CajYAxLFm2X7zn+XOZuzTZ22
         DyaCpZIwe7TaBDmsR1ilWNRcy4rdKn88ZkORCek4u2W/xyvq+F35/f2oxJRwOnL8r+iI
         1CDg==
X-Gm-Message-State: AOAM530LMMhWPH1G9l8TibvJ6sE7+Al7KWN0QjODm5o902s3W/BKCadO
        TcVQ/0qx5z1QOsOx/isKvz+E9rZIoAWmMKaWoe9lqEftpXgrVW/9nCTZQIZhrp8Tk64wLPhRn9P
        psrV/UC4/aIHHxjL7uwFUkI7o2P4lYJRP4buulP9dSzBEsW4Xy6Xgo7R3KQ0cZEVnbf8Vv4ai
X-Google-Smtp-Source: ABdhPJxQG0xikzGnUvz90O/VQxJVyp/N/4fcLoZFSygdHqkxNqNdoRbL1nu8C1hVgS2iVkIFX6h3jydmX8b3
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a25:2086:: with SMTP id
 g128mr6605100ybg.759.1644355015927; Tue, 08 Feb 2022 13:16:55 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:27 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-3-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 02/12] x86/cpufeatures: add AMD Fam19h Branch Sampling feature
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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

Add a cpu feature for AMD Fam19h Branch Sampling feature as bit
31 of EBX on CPUID leaf function 0x80000008.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4cc0ef96152c..a3e895aded02 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -315,6 +315,7 @@
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 #define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
+#define X86_FEATURE_BRS			(13*32+31) /* Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.35.0.263.gb82422642f-goog

