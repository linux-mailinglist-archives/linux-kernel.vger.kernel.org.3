Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A047B54BC73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357407AbiFNVCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357400AbiFNVCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:02:30 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6C62AF0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:02:29 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-fe15832ce5so14072104fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAimGb9Is5JImE4nmMqSqzepBpLcg7BYaug+pTNW7Ek=;
        b=W+CutWigu/Y5FqskYVBAH6l+wyfiRrsqjOVvuf+P5yxhTM6iQUm6uCvPaiJEH29nLF
         j2/NUKM85cDRptTVWdeg0WwrXwLd581tGiwqlMuuedPhSxom9fi6NmnZKlDEoZyc+o86
         X61CSdbizveTQgIfQZCLDmH1TJswfwz/ftKfN22fIswrGNw0YXeL369mPiw3PeELpAlY
         lw7l5WSwVGykMHjU+UN+fNQ2hdHBaVoFDjks8mQMn5Chs901PVrO8KjJaT3ukdyWKSG0
         SvxEFQoIiYqb1LZGCmKQLVUvbWIqpbSjowyxks+uEtp0+a8nVhlaFgn5j+IBX2ys2bnA
         V7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAimGb9Is5JImE4nmMqSqzepBpLcg7BYaug+pTNW7Ek=;
        b=hpvlMsG8hBeFWOUjHioxb3od2oAB99jZF+kS86JpC1qc+BwexCxplKZdMt7MfFC6uy
         4+96w8V7WftZdsCATxRNqLNdh9ak6TeiOfSG7Pn+Dni8vSDtILzfBRkhKkAxIeGRIbgs
         rWzWmTuGQ0B7Ld4M1aDNIDKTkAN0YMFrgqCCRnIku7a3IGR/L29tvIqaP7PdmCDpRGo3
         cuER9yV+Mvk4kBSjeKQF9TQiarkk9beR8pz8Tj2HRA9HJ+R7j9h6bfGMHcNvqdyLSKQX
         MTgEEkWqnkJou30EEg3fgciGXDxEMUhAdkEQqo7T/jfKbjET7SCvc6y7MH9aSSOe2BsS
         zdYg==
X-Gm-Message-State: AJIora+ufy4cbFKvabOh0UpNYznBSzW3VqT/H79HmV5wmda2CkJlEWc/
        LodPMXUYs022HwLBzTUwqRISCpizU/lnKkRadBHUvDjIQz6uL65eIQtFG/JTkddRjiWifrkZrCt
        elWcwC/FKra6fv+LXZT/fMvk2TrCs3tmapbUOjsTc3AplO4/vL0Kimn9TIw36Wt8bXMEy1pJ/Dj
        9zi2drR0BSWOHoAxtb
X-Google-Smtp-Source: AGRyM1vsP+e4hZrQ6QJfSbCH2PcvVY+rBqPbC4vJIabh+M75mE9tyoPoJQs8V7RrWy2LSEUbtHYCzA==
X-Received: by 2002:a05:6870:e995:b0:f2:9b89:2f14 with SMTP id r21-20020a056870e99500b000f29b892f14mr3569617oao.84.1655240548458;
        Tue, 14 Jun 2022 14:02:28 -0700 (PDT)
Received: from localhost ([190.123.123.9])
        by smtp.gmail.com with ESMTPSA id g23-20020a544f97000000b0032e73b538dasm5089455oiy.52.2022.06.14.14.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 14:02:27 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, tglx@linutronix.de, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is disabled by BIOS
Date:   Tue, 14 Jun 2022 18:02:17 -0300
Message-Id: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
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
which is inconvinient. This is currently checked for fwupd for
example.

I understand that cpuinfo is supposed to report every feature in the
cpu but since AMD is doing the same for sme/sev I think is good to
have this for Intel too.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/cpu/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fd5dead8371c..7311172aceaf 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -570,6 +570,8 @@ static void detect_tme(struct cpuinfo_x86 *c)

 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
+		if (mktme_status == MKTME_UNINITIALIZED)
+			clear_cpu_cap(c, X86_FEATURE_TME);
 		mktme_status = MKTME_DISABLED;
 		return;
 	}
--
2.30.2

