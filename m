Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8660659D1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbiHWHMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbiHWHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:12:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0541D61D78
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:12:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8558033F07;
        Tue, 23 Aug 2022 07:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661238754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=7rYnIbsTHqMgra5J+MjLdZgHDRmMu3X1VKDoHDywm+8=;
        b=FnOZlSLSPocaKobjTXbWHYwCCzGIpkek3KxBOW2F4vMHZSPX6ZJmgbUg53l9EOOff59E7g
        NsCJtQzbx+rumglvxzJ0csSGZs+48kdwCRMLlHThaD9syuq7eu+Gal3kBgtMX8CvziKKkm
        liFPYya6aEm4+rWx/L5cLMCGnxiTetg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661238754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=7rYnIbsTHqMgra5J+MjLdZgHDRmMu3X1VKDoHDywm+8=;
        b=jGyRtA4dANNwEYH0Ymriix/GaaBT1S8j/lNL8Y7Os6K5QsOKdtkJQHYD8s6/ldV7ADKswb
        RBT8zgzHZCu+OfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B66E13AB7;
        Tue, 23 Aug 2022 07:12:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b8MCGuJ9BGPiNgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 23 Aug 2022 07:12:34 +0000
Date:   Tue, 23 Aug 2022 09:12:33 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: mitigations=off and failsafe boot options
Message-ID: <20220823071233.v5shk3tpu7ssctpc@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Boris asked me to post my problem. So here we go.

On my old lab box (i7-860) the kernel options mitigations=off had no
effect. After booting the machine (openSUSE Tumbleweed kernel
5.19.2-1-default and also 6.0-rc2 with the same config) always enabled
the mitigations:

# cat lscpu-5.19.2-1-default.log

Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Address sizes:                   36 bits physical, 48 bits virtual
Byte Order:                      Little Endian
CPU(s):                          4
On-line CPU(s) list:             0-3
Vendor ID:                       GenuineIntel
Model name:                      Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
CPU family:                      6
Model:                           30
Thread(s) per core:              1
Core(s) per socket:              4
Socket(s):                       1
Stepping:                        5
BogoMIPS:                        5596.26
Flags:                           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid dtherm ida flush_l1d
Virtualization:                  VT-x
L1d cache:                       128 KiB (4 instances)
L1i cache:                       128 KiB (4 instances)
L2 cache:                        1 MiB (4 instances)
L3 cache:                        8 MiB (1 instance)
NUMA node(s):                    1
NUMA node0 CPU(s):               0-3
Vulnerability Itlb multihit:     KVM: Mitigation: VMX disabled
Vulnerability L1tf:              Mitigation; PTE Inversion; VMX vulnerable, SMT disabled
Vulnerability Mds:               Vulnerable; SMT disabled
Vulnerability Meltdown:          Vulnerable
Vulnerability Mmio stale data:   Not affected
Vulnerability Retbleed:          Not affected
Vulnerability Spec store bypass: Vulnerable
Vulnerability Spectre v1:        Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers
Vulnerability Spectre v2:        Vulnerable, IBPB: disabled, STIBP: disabled, PBRSB-eIBRS: Not affected
Vulnerability Srbds:             Not affected
Vulnerability Tsx async abort:   Not affected


After few experiments, I was able to identify the source of the
problem. When I reinstalled the machine recently, the default settings
of the boot medium didn't work so I used the failsafe option which
worked. Those got added to /etc/default/grub and hence were enabled
all the time.

After removing those, the machine booted just fine and most mitigations
are off as requested (except the itlb-multihit).

# uname -a
Linux lf.lan 6.0.0-rc2-1-default+ #4 SMP PREEMPT_DYNAMIC Tue Aug 23 08:29:06 CEST 2022 x86_64 x86_64 x86_64 GNU/Linux

# lscpu
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         36 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  8
  On-line CPU(s) list:   0-7
Vendor ID:               GenuineIntel
  Model name:            Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
    CPU family:          6
    Model:               30
    Thread(s) per core:  2
    Core(s) per socket:  4
    Socket(s):           1
    Stepping:            5
    Frequency boost:     enabled
    CPU max MHz:         2926.0000
    CPU min MHz:         1197.0000
    BogoMIPS:            5595.93
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid dtherm ida flush_l1d
Virtualization features:
  Virtualization:        VT-x
Caches (sum of all):
  L1d:                   128 KiB (4 instances)
  L1i:                   128 KiB (4 instances)
  L2:                    1 MiB (4 instances)
  L3:                    8 MiB (1 instance)
NUMA:
  NUMA node(s):          1
  NUMA node0 CPU(s):     0-7
Vulnerabilities:
  Itlb multihit:         KVM: Mitigation: VMX disabled
  L1tf:                  Mitigation; PTE Inversion; VMX vulnerable
  Mds:                   Vulnerable; SMT vulnerable
  Meltdown:              Vulnerable
  Mmio stale data:       Not affected
  Retbleed:              Not affected
  Spec store bypass:     Vulnerable
  Spectre v1:            Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers
  Spectre v2:            Vulnerable, IBPB: disabled, STIBP: disabled, PBRSB-eIBRS: Not affected
  Srbds:                 Not affected
  Tsx async abort:       Not affected


The failsafe options in question are:

  apm=off acpi=off mce=off barrier=off ide=nodma idewait=50 i8042.nomux
  psmouse.proto=bare irqpoll pci=nommconf resume=...

I am okay to leave at this. Maybe you might find this feedback helpful.

Thanks,
Daniel
