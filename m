Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B442653B5E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiFBJUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiFBJUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:20:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C2AE25A;
        Thu,  2 Jun 2022 02:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 393FAB81F08;
        Thu,  2 Jun 2022 09:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E630DC3411E;
        Thu,  2 Jun 2022 09:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654161616;
        bh=7F/dcFYcBW/D/V1Vu9axWLD80UyRHj/JRIWtnD2wpB8=;
        h=From:Date:Subject:To:Cc:From;
        b=Gz+5hvatPjHCePo5gpEGUvAGt6lhyqW/oinGaof+UeEFfzcvuj8aBbQBXmsGDTRNG
         C8DS0/vHUKjKUXJpb8jwWi9M2R9ix+kOnAWDHGmO1G/s2x2kVBL0UOWGQ1g5r7OU2i
         BiMETutDdXZzidKNxGakSD3nTx6i4CqjcM9eIwuPvv/EphgK/KO7c6f8Yb+PPqQfHm
         79eVVhIW7FwR+bGaWGiMCVTfIQ/vkFNPy3MWpb/Vpq10K4u+0n5yH3WQc6SJsdMvJo
         HA1gdwa2yBlXsk/36H1Tpg5Li3S8DE44UmdYJwF+GPqBIFMXrrBLZDPWN5JAxwNsrQ
         EUV4XQ8ZmDgmQ==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-30c1b401711so45290747b3.2;
        Thu, 02 Jun 2022 02:20:16 -0700 (PDT)
X-Gm-Message-State: AOAM532Sd9ZzEv+oYSx1WZAI75h7qQUky2rKtqFl5jmFxHdQRmTXHQpe
        oyqO8aElyfXEKjzhHPOvKGdiSD1pjkZzUzfgNzo=
X-Google-Smtp-Source: ABdhPJzTBS8jd3Q9WrD7oYWK+ybvTG0uuhiqGqkVJBU05vK9oAzJtF8rQszFadhXfouBeX15N2kC4CuN371MXy2vBms=
X-Received: by 2002:a81:745:0:b0:30f:b172:9efb with SMTP id
 66-20020a810745000000b0030fb1729efbmr4425576ywh.495.1654161615905; Thu, 02
 Jun 2022 02:20:15 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 2 Jun 2022 11:19:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
Message-ID: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
Subject: x86/mce/therm_throt incorrect THERM_STATUS_CLEAR_CORE_MASK?
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Xeon W-2265 (family 6, model 85, stepping 7) that started
constantly spewing messages from the therm_throt driver after one
core overheated:

May 31 13:57:54 kernel: [15512.209474] unchecked MSR access error:
WRMSR to 0x19c (tried to write 0x0000000000002a80) at rIP:
0xffffffff9f67f974 (native_write_msr+0x4/0x20)
May 31 13:57:54 kernel: [15512.209486] Call Trace:
May 31 13:57:54 kernel: [15512.209488]  <TASK>
May 31 13:57:54 kernel: [15512.209489]  ? throttle_active_work+0xea/0x1f0
May 31 13:57:54 kernel: [15512.209498]  process_one_work+0x21d/0x3c0
May 31 13:57:54 kernel: [15512.209502]  worker_thread+0x4d/0x3f0
May 31 13:57:54 kernel: [15512.209505]  ? process_one_work+0x3c0/0x3c0
May 31 13:57:54 kernel: [15512.209508]  kthread+0x127/0x150
May 31 13:57:54 kernel: [15512.209510]  ? set_kthread_struct+0x40/0x40
May 31 13:57:54 kernel: [15512.209513]  ret_from_fork+0x1f/0x30
...
May 31 13:57:59 kernel: [15517.333445] CPU11: Core temperature is
above threshold, cpu clock is throttled (total events = 3)

I could not find CPU model specific documentation for this register,
but I see that in [1], the bits 13 through 15 are marked as reserved
in some cases but not others. Manually writing the value 0xa80
instead of 0x2a80 from user space makes the warnings stop, so
my guess is that this CPU does not support the 0x2000 bit:

$ sudo  wrmsr -p 11 0x19c 0xa80 ; dmesg
[177764.874555] msr: Write to unrecognized MSR 0x19c by wrmsr (pid: 142969).
[177764.874560] msr: See
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about for
details.
[177765.371180] CPU11: Core temperature/speed normal (total events = 42)
[177765.371180] CPU23: Core temperature/speed normal (total events = 42)

I have not tried the patch below, but I think this would address it on my
system, while likely breaking other machines. Any ideas what the
correct fix is?

      Arnd

diff --git a/drivers/thermal/intel/therm_throt.c
b/drivers/thermal/intel/therm_throt.c
index 8352083b87c7..620d7f4c013e 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -196,7 +196,7 @@ static const struct attribute_group thermal_attr_group = {
 #define THERM_THROT_POLL_INTERVAL      HZ
 #define THERM_STATUS_PROCHOT_LOG       BIT(1)

-#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) |
BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
+#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) |
BIT(7) | BIT(9) | BIT(11))
 #define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) |
BIT(7) | BIT(9) | BIT(11))

 static void clear_therm_status_log(int level)

[1] https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3b-part-2-manual.pdf
