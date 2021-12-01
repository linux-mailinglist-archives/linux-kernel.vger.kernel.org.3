Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0F464510
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346249AbhLACwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbhLACw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:52:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F0FC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:49:09 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id o14so16527985plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCrvt5CVCukTtXRGtukRkatMfJD3P4/LCAZAWxjfAHw=;
        b=bzmqI3c0WNGnlQIihmZagI8AWui0T7HmCHZrOFYl4ScG1O+7aegQIag8Q/gx9zFf0O
         sarsMhVoMGSTK1TIuN4nmSaTlqYI8cbdLJm6/mhujBviaK4kQbDQJZPL2e3XPvBPN+/e
         3scMmSo2x1buVEoBI5B8PhTJuQm1dX3Fuz00VTNICUhSml8Vh4yK5Y/IZoR+JlC7wl1g
         lEpQuNgKzySRaBzG8oktiPNKp6poNP5SyhSRJBvplOGaVxhJUcx9Ij1bMtye0CHgENFn
         suK+toCi7RA2eQUSPjs1CfzfzM1yS1IhmqTDROUWJ/QzVz73npbqUZ3eAsSM1PKse2Uq
         qIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCrvt5CVCukTtXRGtukRkatMfJD3P4/LCAZAWxjfAHw=;
        b=HJUn70gzJTXQB/umhvchc6ANiFRt9yQ3gts/ZqPEpNZ/DpVZQ3P1OO3dB1mnahTHmW
         tF/veKrYh4JdDypp5rvN/l7Cj8RrI5NA0IMfXeXM1ZTKZl8ZbpaCnIvi+nXRXTDy/VCX
         rTo5boMNDxeiL44Al8zIm0ktzodEktUNufkD628VeTGn87Nb66zD1cSzhKlP1fPJTY3N
         /9uzHu78tDDpvXRLtTgZU6jpsidl/F3lgNUc+4Z1tfcVk3whUfggQHqODN2RhTKyv6tx
         +78bsHEXGmw47KtMBUkFqMTwl0sFKdzrEOk6NDmsC8KH1sO/v181szDdPbO6Qyak78Ne
         hjBA==
X-Gm-Message-State: AOAM530shLGC4l3jsBmwW7YFVDL9EUVufpopaVX2limJmtVnGsXFLr23
        evDFe6L5508gfgGR0LNDRM5xcae+5fsKXg==
X-Google-Smtp-Source: ABdhPJwTKzuQoZk1wliaKQLSDS+m4f/S8fsPoeGsLXOtSsnrOTVsYSOJfhP5XCvHYSrzl9vGWIwhTw==
X-Received: by 2002:a17:902:7086:b0:143:6ba3:9b27 with SMTP id z6-20020a170902708600b001436ba39b27mr3845481plk.60.1638326949409;
        Tue, 30 Nov 2021 18:49:09 -0800 (PST)
Received: from always-x1.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id f1sm24291704pfj.184.2021.11.30.18.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 18:49:09 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     tglx@linutronix.de, pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/2] Introduce x86_get_cpufreq_khz()
Date:   Wed,  1 Dec 2021 10:46:48 +0800
Message-Id: <20211201024650.88254-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
 - Rename x86_get_freq() to x86_get_cpufreq_khz() to make function
   specific. (Suggested by Thomas Gleixner)
 - Use cpu_feature_enabled(X86_FEATURE_TSC) instead of
   cpu_has(&cpu_data(cpu), X86_FEATURE_TSC) to test feature.
   (Suggested by Thomas Gleixner)
 - Spell fixes. (Suggested by Thomas Gleixner)

v1:
 - Introduce x86_get_freq(), hide detailed implemention from proc
   routine.
 - KVM uses x86_get_freq() to get CPU frequecy.

zhenwei pi (2):
  x86/cpu: Introduce x86_get_cpufreq_khz()
  KVM: x86: use x86_get_freq to get freq for kvmclock

 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/cpu/common.c     | 19 +++++++++++++++++++
 arch/x86/kernel/cpu/proc.c       | 13 +++----------
 arch/x86/kvm/x86.c               |  4 +---
 4 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.25.1

