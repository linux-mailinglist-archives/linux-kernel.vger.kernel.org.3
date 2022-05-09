Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492051F378
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbiEIE1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiEIERT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:17:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D391A11922A;
        Sun,  8 May 2022 21:13:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso11719142pjb.5;
        Sun, 08 May 2022 21:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4ZmSEZyae107M7woQKre9aBPoaep2udL6cDHmolvx4=;
        b=EelE4Sk2rLVbk1vLK9xnYcqXSyseWXVcrB40eFirQUnctT0lgrGQBnNU9A2L6k+bb7
         OjDg+CYdzVjkdzqvx5z0D/d1zRh6WjH0+7K8OQrg1yKK/yaIsti73fDLvugPzgRgE98p
         Po61z8180HgTwzAO1H7b46taafqDlg2GeN2Z8lI+6hpgcfQhlQV2ivduSA92N8HYX79q
         6qN07SFMZpwKLDRQr2aKIJiRfiaTUsp0HBUDbIAPm+s4S8xU32heA+KWOUxMF3xvaVvn
         fTGg+jDPKbodCq8Vtpj2sSfKIvQXG4tMqXOx/iBl9keMTJkMEduWgBvuxY1EFLa/QuB1
         Egqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4ZmSEZyae107M7woQKre9aBPoaep2udL6cDHmolvx4=;
        b=ULAP5IHq7nPoYoWagFHgca4TVzdX6PcHk8CSjbkKR2uql9cD4ftNojc6sDAtfNhzfZ
         gs/DPPBF5eSecSP3E4ww3H44ebF++e4mmUXt3x5NkFLak2WpbRH3wtZtd8GW9OWLSWd0
         UWzdHQP1nMXIxwvrGBoGFowdggGALWfO0jFPLtC0/Y2+D4jK1EvCVQhlBIJ5rHYhxRjq
         ZiOq91IbI6Zwh9dfRLzZ3KiprRZZnVRDBcp6kzibUtK9HuJELV32pavYPlvcKevQkpR3
         Sbm2ew4AaFuVPdMMzxOeqQaXYi23P0R7wmDGgfZJxQrOoYycYttrYaX6evgudR7cUa/k
         oKqA==
X-Gm-Message-State: AOAM533s9h/53jyabYEWfvDRyFjQ2Ea7mZpZr1UXzprsOKkXkJjsRPe4
        9OjfTEYK5H2IfIkBAq3rnZgdH70RPRsx
X-Google-Smtp-Source: ABdhPJwA12GMNtxipiY1QrrqNCB1QXJ3EJmQp3Iv9uD5xQEH9BSDFsZL5vlxX/0LpgkUo1SfW2hNOg==
X-Received: by 2002:a17:903:1211:b0:15e:8208:8cc0 with SMTP id l17-20020a170903121100b0015e82088cc0mr14708514plh.52.1652069600512;
        Sun, 08 May 2022 21:13:20 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090a7f9300b001cd60246575sm11478545pjl.17.2022.05.08.21.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 21:13:20 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCHv3 0/2] cpu/hotplug: Keep cpu hotplug disabled until the rebooting cpu is stable
Date:   Mon,  9 May 2022 12:13:03 +0800
Message-Id: <20220509041305.15056-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
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

For the arches (arm/arm64/ia64/riscv), which relies on the cpu hot-removing
mechanism to implement "kexec -e", it is important to make sure that the
rebooting happens on a valid online cpu. And this logic should have been
guaranteed in migrate_to_reboot_cpu().

But the current code has either contradict (resolved by [2/2]) or
redundancy (resolved by [1/2]) about the logic.

V2 -> V3:
Taking in [2/2], which also has problem with the valid rebooting
cpu. (I had sent three patches for different arches. But maybe it is
better to collapse them into one and collect acks from different arches'
maintainers )

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Baokun Li <libaokun1@huawei.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: kexec@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
To: linux-ia64@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org

Pingfan Liu (2):
  cpu/hotplug: Keep cpu hotplug disabled until the rebooting cpu is
    stable
  arm/arm64/ia64: kexec: fix the primary cpu passed to
    smp_shutdown_nonboot_cpus()

 arch/arm/kernel/reboot.c    |  2 +-
 arch/arm64/kernel/process.c |  2 +-
 arch/ia64/kernel/process.c  |  2 +-
 kernel/cpu.c                | 16 ++++++++++------
 kernel/kexec_core.c         | 10 ++++------
 5 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.31.1

