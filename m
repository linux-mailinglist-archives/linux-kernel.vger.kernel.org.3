Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD0495A29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378808AbiAUGzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378826AbiAUGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:55:22 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D59C061748
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 22:55:19 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id t7so9552175qvj.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 22:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKxw+p7lB0nsRwM8MVWzboFXmLT34k0K03FPzwtxAHY=;
        b=CARe8ttmcxAQOg/zAxhzRGaZ49Ok+ddErNFqywbC2UesN8xubEII2GKJzptNYrw9Q9
         1RjYToA/5rdw/9NPllBvCxFUKE4quqxeZNPJUXcg5eN4syETNoKJ6xIffwmS289mnF+/
         0Hxptkus69nAwIRtIskF5sR817fe8S310UPl56d7RN98E/ZATN9aktv7mVMq0v+eAOyn
         yo75tDM07jAfSf6ALHGVl8RmfPUUCHKMJGTfwzZEl7tmn+fd2eZ5I3YFMksT8Fr/IWhK
         rDaKNHOsAvOtFFds807V9qZTaOe8RGE+l14Ez8WMGGPwRf5T0R2tJIlYzJZOeS06ETZo
         MamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKxw+p7lB0nsRwM8MVWzboFXmLT34k0K03FPzwtxAHY=;
        b=HHQrh0c3SEBZhg3hxKEy+wKTDjFdZrGhv76NBkCdb631TCGXnN4A75SEZMX+mwN4sj
         NQtisJTBB3nQTLG+66oCZz47UlIorM9pcdgE3UoaB8I+l/V99EqbZVwEC9eiudKb2OMW
         NrfjxFetkBgA0ZaNLAwPAO4s9bpIEA1DRFXLIVwSwAQ0NoxqAVQ8l95Th/B+IEJQSlkc
         vDdxHfbPODggV164YhKlwwzdh4FVyTWsuoLPdDhjV9NdEdVtoGlyoOZ0mqxhEgGm7Zun
         hqRT0WhYQi5P+E+oiStjaeOD5MIja0N5HBJecNbko0t9AN9eo++HCKmXoocH4kQDgc4C
         OnYA==
X-Gm-Message-State: AOAM532Seje+Ria5JuxBU7GeWMeuVlcMh14laeA5TnWczeOhHpZkjVCy
        RkWIEfZJxARYNillaPm0u7E=
X-Google-Smtp-Source: ABdhPJxfWhr//zTGzRLC9EUH9zThXDmG4p7vGEXiC7o+NuZ73/RzmPJGpwGWGvbJz2HDJk0toGDw+w==
X-Received: by 2002:a05:6214:62e:: with SMTP id a14mr2395922qvx.113.1642748118752;
        Thu, 20 Jan 2022 22:55:18 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y16sm2888410qtw.4.2022.01.20.22.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 22:55:18 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: si.hao@zte.com.cn
To:     catalin.marinas@arm.com, pasha.tatashin@soleen.com,
        si.hao@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, james.morse@arm.com
Subject: [PATCH linux-next] arm64: kexec: Support the case of VA_BITS=39 in trans_pgd_idmap_page()
Date:   Fri, 21 Jan 2022 06:52:16 +0000
Message-Id: <20220121065216.1001021-1-si.hao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sihao <si.hao@zte.com.cn>

When the values of CONFIG_ARM64_VA_BITS and CONFIG_ARM64_PA_BITS are not
equal, the following panic occurs when kexec is executed.

This happens because trans_pgd_idmap_page() does not support VA_BITS=39.
So the patch supports the case of VA_BITS=39.

->kexec -e
[   36.168728] 000: kexec_core: Starting new kernel
[   36.168735] 000: Disabling non-boot CPUs ...
[   36.168739] 000: Bye!
[   36.189457] 000: Unable to handle kernel paging request at virtual
address 000000000fb3c000
[   36.189460] 000: Mem abort info:
[   36.189462] 000:   ESR = 0x86000006
[   36.189463] 000:   EC = 0x21: IABT (current EL), IL = 32 bits
[   36.189466] 000:   SET = 0, FnV = 0
[   36.189468] 000:   EA = 0, S1PTW = 0
[   36.189470] 000: user pgtable: 4k pages, 39-bit VAs,
pgdp=000000000de68000
[   36.189475] 000: [000000000fb3c000] pgd=000000000fb24003,
pud=000000000fb24003, pmd=0000000000000000
[   36.189482] 000: Internal error: Oops: 86000006 [#1] PREEMPT SMP
[   36.189488] 000: Modules linked in:
[   36.189493] 000: CPU: 0 PID: 825 Comm: kexec Not tainted XXX
[   36.189498] 000: Hardware name: XXX
[   36.189500] 000: pstate: 600003c5 (nZCv DAIF -PAN -UAO)
[   36.189503] 000: pc : 0xfb3c000
[   36.189510] 000: lr : machine_kexec+0x2a4/0x300
[   36.189520] 000: sp : ffffffc0111fbc90
[   36.189523] 000: x29: ffffffc0111fbc90 x28: ffffff800fb66440
[   36.189527] 000: x27: 0000000000000000 x26: 0000000000000000
[   36.189531] 000: x25: 0000000056000000 x24: 0000000000000015
[   36.189534] 000: x23: 000000000de64000 x22: 000000000fb3c000
[   36.189538] 000: x21: ffffffc010699298 x20: ffffffc010752e90
[   36.189542] 000: x19: ffffff800acc0400 x18: 0000000000000001
[   36.189545] 000: x17: 0000000000000000 x16: 0000000000000000
[   36.189549] 000: x15: ffffff800fb66838 x14: ffffffffffffffff
[   36.189552] 000: x13: ffffffc0108f0b48 x12: ffffffc0111fbba0
[   36.189556] 000: x11: ffffffc01088d450 x10: ffffffc01088d468
[   36.189559] 000: x9 : 0000000000000001 x8 : 0000000000024d30
[   36.189563] 000: x7 : ffffffc0108f0738 x6 : ffffffc0108ebe18
[   36.189566] 000: x5 : 0000000000024d30 x4 : 0000000000004920
[   36.189570] 000: x3 : 0000000000000006 x2 : b9bb936edd96cd00
[   36.189573] 000: x1 : 0000000000000000 x0 : ffffff800acc0400
[   36.189576] 000: Call trace:
[   36.189578] 000:  0xfb3c000
[   36.189580] 000:  kernel_kexec+0x98/0xe8
[   36.189586] 000:  __do_sys_reboot+0x1d0/0x208
[   36.189593] 000:  __arm64_sys_reboot+0x2c/0x38
[   36.189597] 000:  el0_svc_common.constprop.0+0x74/0x168
[   36.189603] 000:  el0_svc_handler+0x80/0xa0
[   36.189607] 000:  el0_svc+0x8/0x204
[   36.189616] 000: Code: bad PC value
[   36.189621] 000: ---[ end trace f930c021f9bf10a9 ]---
[   36.189625] 000: Kernel panic - not syncing: Fatal exception

Reported-by: sihao <si.hao@zte.com.cn>
Signed-off-by: sihao <si.hao@zte.com.cn>
---
 arch/arm64/mm/trans_pgd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index d7da8ca40d2e..3d88185adcf5 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -232,7 +232,7 @@ int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 {
 	phys_addr_t dst_addr = virt_to_phys(page);
 	unsigned long pfn = __phys_to_pfn(dst_addr);
-	int max_msb = (dst_addr & GENMASK(52, 48)) ? 51 : 47;
+	int max_msb = (dst_addr & GENMASK(52, VA_BITS)) ? 51 : (VA_BITS - 1);
 	int bits_mapped = PAGE_SHIFT - 4;
 	unsigned long level_mask, prev_level_entry, *levels[4];
 	int this_level, index, level_lsb, level_msb;
-- 
2.25.1

