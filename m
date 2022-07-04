Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0173256588A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiGDOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiGDOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:23:11 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D58DAE67
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:23:11 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id r1so4507123vke.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NjfI5dDS41DcAEqR2/agxkZ13OppgBz0B61Kzl2i3k=;
        b=TP3LQa567Sk3/C0BJLRZyaG570DvUbTmLmcECNYYWjC0jh6cgiQ0fCt9D4fgYYQLGE
         v1ctsBne4zPKtgZfYrhcTxjf8bf0+kmauuKzSQTsyhXA+mLyiBSLMdHtRQwOA3vcKelW
         IPZnAMFNgK8W3mJrk8aFAN/+okFpZuzLvokaKUhkSGTa7QwQ9q5lK5OzVkLAJ3BydlPC
         Uyq6SynCwgZVvvyb4sRBobHHdh8S7PDgF7Eqjyf3pHV/0wLY1aGqzI85YdX6CbIEx9hH
         r0LYDJ+AzjfhyPNZNW9GzdQ6RhassQUWhbp/JbOPIkrrEdT/76bXvctmuCyT25O2u4Qr
         rU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NjfI5dDS41DcAEqR2/agxkZ13OppgBz0B61Kzl2i3k=;
        b=H9yOTaILh2d/MgMcy1BBUwbHGs7Yixljrp5R/lka7tpUTU8LakrBLrC8gbR28DkIJK
         7mxsN000AeJEFe4sXu3HoQHaACVGc/+6QzReZI6JiIBdy2sxVOWz6VbVA8I/kt00KNkM
         Oznb2Tvl1IaPBoW1mhO0426CbZr0C4+oFdGSrKc/N4ImqznYXlPSIJAxzAUa5ovPY+kS
         X1ou4Of4mKLwwguqULMHEgkuz7ZEKNznIbUGMO2aqsL+XH0ztbO3tj47ssvo9fXb9kGu
         8ho3ZaM3Z3N8L2fpJ8sH5vRTZXHPPgzjUeXCcSouuwKlTKKcwHkUz+JIhcZUyRxIPD8u
         3YhA==
X-Gm-Message-State: AJIora8hmg8WAd9sNEwIZdNADSjSCizCB3cB3dEGLK3Y9EU2aAJUjwjT
        rmnwJAoZKBbUfZhzFW1+gMvRU2YZpVidUi8rnvAKVNv8VcC+p+j1hhQyIsHoD6c5cWJcz3ofr4G
        MvM+MK9tugET/mVd7yzthqopPTuJeNCVJoSjKpbTjbWIBMkvgDoOJgxEedn1pmbYQ/Arn+YIjjI
        UQPT6tPlxH+XIBbwj4
X-Google-Smtp-Source: AGRyM1va83kGDWr99Y82j1sD2a96diKczMjcPAwjv4dySKkFwcRaO6q2C/Vrc+mTwoqK/0vW6swb8w==
X-Received: by 2002:a1f:fc8d:0:b0:36b:fd94:e5c1 with SMTP id a135-20020a1ffc8d000000b0036bfd94e5c1mr16761930vki.11.1656944589735;
        Mon, 04 Jul 2022 07:23:09 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id bi44-20020a05612218ac00b0036bff0dc94esm4539858vkb.34.2022.07.04.07.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 07:23:09 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v2] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is disabled by BIOS
Date:   Mon,  4 Jul 2022 11:22:51 -0300
Message-Id: <20220704142250.1512726-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the only way to check this is by greping the kernel logs,
which is inconvenient. This is currently checked for fwupd for
example.

I understand that cpuinfo is supposed to report every feature in the
cpu but since AMD is doing the same (and it also broke backwards
compatibility [1]) for sme/sev I think it's good to have this for
Intel too.

Another option to prevent greping the logs would be a file in
sysfs. I'm open to suggestions to where to place this infomartion. I
saw a proposal about a firmware security filesystem [2]; that would
fit perfectly.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=08f253ec3767bcfafc5d32617a92cee57c63968e

[2] https://lore.kernel.org/all/20220622215648.96723-3-nayna@linux.ibm.com/

Changelog since v1

Clear the flag not only for BSP but for every cpu in the system.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fd5dead8371c..17f23e23f911 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -570,6 +570,7 @@ static void detect_tme(struct cpuinfo_x86 *c)

 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
+		clear_cpu_cap(c, X86_FEATURE_TME);
 		mktme_status = MKTME_DISABLED;
 		return;
 	}
--
2.30.2

