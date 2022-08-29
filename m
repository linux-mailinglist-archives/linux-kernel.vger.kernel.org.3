Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6492E5A4544
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiH2IhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiH2IhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330F258532
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661762232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NNK3eOpptevpY9xJ/bnha7S6prWm9aG3Q5ZcGIPIuHw=;
        b=GciGZLy47cJtT9LHwWfHMGjJiNPZMn94Q0zITKrnkZUtnWVf8fjbUY+YH/0hOYel3+e0Vu
        84HGcguhlk3h+mu6T0VqIcYg1ozsJSbznM77s+hw56wcO6f3Jid3vAztr2f6cltMxqbFye
        dk8/xhu2vLKM6/bcsF0PHt5s5jlHdhk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-154-PMaYlDgyN-i7qqrOvKlc9Q-1; Mon, 29 Aug 2022 04:37:11 -0400
X-MC-Unique: PMaYlDgyN-i7qqrOvKlc9Q-1
Received: by mail-ej1-f72.google.com with SMTP id qf22-20020a1709077f1600b00741638c5f3cso879141ejc.23
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=NNK3eOpptevpY9xJ/bnha7S6prWm9aG3Q5ZcGIPIuHw=;
        b=bBmo3W1LwDAOdbJn2Cp/4BPYfmQOUTO4+JI/8BY1nbvoVyKdDQNOX3+McK+r28ZekW
         lRN8KMc741tSE05ou8aaBHVfHwygWFkrlCMlGSUALyAZzs6Z2eGwf8efnOpIwG0dOc3N
         HJ0kLTcquQh0KHw0AJqJREx73UukNnTB0TK92cJY/oD92ryrT2dc3hK7WtBiysu6+Lx+
         m1ZJftbtxpg8dTwwLBIWt5mgiDSu0wmXRSswb8KdJlPDMNSdsf9m1EYnYeBxb5lH4mk0
         z8BYI6OTkoTbzdiC5qHTARf60rZFgouoRBWl/VDCVVRkOIx02rl3RkYYh5HEW400mkeY
         5Raw==
X-Gm-Message-State: ACgBeo03VK7shMMbfuTQJNcbvQYRTtbBu59utnYDgRjgGkUmPWxp64Aw
        TrodhyC7kyT+AaXZVTAmMTF+Q5t2EcNZ596eO6OVOh7a5uYlHKF8POUiqWjjqJ+TjhdgrPlL4oO
        SOHshH6C49zxbtgWamgY6UETW
X-Received: by 2002:a17:907:6e94:b0:741:8c76:2ed8 with SMTP id sh20-20020a1709076e9400b007418c762ed8mr2796045ejc.731.1661762230148;
        Mon, 29 Aug 2022 01:37:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7mfj50IDfXwet7kk2IwM0E4z4usxueT3nQjbRrYtq8JMMW5w0cQv+rvCP0RbnRtdS6mv4FDQ==
X-Received: by 2002:a17:907:6e94:b0:741:8c76:2ed8 with SMTP id sh20-20020a1709076e9400b007418c762ed8mr2796029ejc.731.1661762229843;
        Mon, 29 Aug 2022 01:37:09 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id lv4-20020a170906bc8400b007262a5e2204sm4204754ejb.153.2022.08.29.01.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 01:37:09 -0700 (PDT)
Message-ID: <4b4bba5d-d291-d9fa-8382-cdc197b7ed35@redhat.com>
Date:   Mon, 29 Aug 2022 10:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: 6.0 tty regression, NULL pointer deref in flush_to_ldisc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This weekend I noticed that on various Bay Trail based systems which have
their bluetooth HCI connected over an uart (using hci_uart driver /
using the drivers/tty/serial bus) there is a NULL pointer deref in
flush_to_ldisc, see below for the full backtrace.

I *suspect* that this is caused by commit 6bb6fa6908eb
("tty: Implement lookahead to process XON/XOFF timely").

I can cleanly revert this by reverting the following commits:

ab24a01b2765 ("tty: Add closing marker into comment in tty_ldisc.h")
65534736d9a5 ("tty: Use flow-control char function on closing path")
6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")

ATM I don't have one of the affected systems handy. I will give
a 6.0-rc3 kernel with these 3 commits reverted a try tonight (CEST)
and I'll let you know the results.

Note I can NOT confirm yet that these reverts fix things, so please
don't revert anything yet. I just wanted to give people a headsup
about this issue.

Also maybe we can fix the new lookahead code instead of reverting.
I would be happy to add a patch adding some debugging prints the
systems run fine after the backtrace as long as I don't suspend them
so gathering logs is easy.

Regards,

Hans



[   28.626537] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   28.626555] #PF: supervisor instruction fetch in kernel mode
[   28.626563] #PF: error_code(0x0010) - not-present page
[   28.626569] PGD 0 P4D 0 
[   28.626580] Oops: 0010 [#1] PREEMPT SMP PTI
[   28.626589] CPU: 2 PID: 8 Comm: kworker/u8:0 Tainted: G         C  E      6.0.0-rc2+ #102
[   28.626598] Hardware name: MPMAN Converter9/Converter9, BIOS 5.6.5 07/28/2015
[   28.626604] Workqueue: events_unbound flush_to_ldisc
[   28.626617] RIP: 0010:0x0
[   28.626633] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[   28.626639] RSP: 0018:ffffacec40087e28 EFLAGS: 00010202
[   28.626648] RAX: 0000000000000000 RBX: ffff92dc05fee000 RCX: 0000000000000001
[   28.626654] RDX: 0000000000000000 RSI: ffff92dc05fee020 RDI: ffff92dc07341040
[   28.626660] RBP: ffff92dc07341048 R08: ffff92dc05fee020 R09: 00000000f1e77022
[   28.626667] R10: ffffacec40087e30 R11: 000000002f1e7702 R12: ffff92dc07341040
[   28.626673] R13: ffff92dc07341090 R14: 0000000000000000 R15: 0000000000000001
[   28.626679] FS:  0000000000000000(0000) GS:ffff92dc7bb00000(0000) knlGS:0000000000000000
[   28.626687] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.626693] CR2: ffffffffffffffd6 CR3: 00000000060c6000 CR4: 00000000001006e0
[   28.626700] Call Trace:
[   28.626706]  <TASK>
[   28.626712]  flush_to_ldisc+0x178/0x190
[   28.626728]  process_one_work+0x257/0x570
[   28.626749]  worker_thread+0x4f/0x3a0
[   28.626762]  ? process_one_work+0x570/0x570
[   28.626772]  kthread+0xf5/0x120
[   28.626782]  ? kthread_complete_and_exit+0x20/0x20
[   28.626794]  ret_from_fork+0x22/0x30
[   28.626815]  </TASK>
[   28.626820] Modules linked in: fjes(-) snd_soc_rl6231 snd_intel_sdw_acpi hci_uart dw_dmac soc_button_array dptf_power int3406_thermal snd_soc_core btqca int3401_thermal btrtl processor_thermal_device btbcm processor_thermal_rfim snd_compress processor_thermal_mbox processor_thermal_rapl ac97_bus btintel snd_pcm_dmaengine intel_rapl_common int3403_thermal snd_seq int3400_thermal int340x_thermal_zone snd_seq_device acpi_thermal_rel bluetooth intel_int0002_vgpio(E) kxcjk_1013 atomisp_gc0310(CE) industrialio_triggered_buffer atomisp_ov2680(CE) snd_pcm kfifo_buf atomisp_gmin_platform(CE) industrialio acpi_pad silead(+) videodev mc snd_timer snd ecdh_generic rfkill soundcore mei_txe mei dwc3_pci lpc_ich vfat fat zram mmc_block i915 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel drm_buddy drm_display_helper cec ttm video wmi(E) sdhci_acpi sdhci mmc_core pwm_lpss_platform pwm_lpss ip6_tables ip_tables i2c_dev ipmi_devintf ipmi_msghandler fuse
[   28.627005] CR2: 0000000000000000
[   28.627013] ---[ end trace 0000000000000000 ]---
[   28.627020] RIP: 0010:0x0
[   28.627032] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[   28.627038] RSP: 0018:ffffacec40087e28 EFLAGS: 00010202
[   28.627047] RAX: 0000000000000000 RBX: ffff92dc05fee000 RCX: 0000000000000001
[   28.627053] RDX: 0000000000000000 RSI: ffff92dc05fee020 RDI: ffff92dc07341040
[   28.627059] RBP: ffff92dc07341048 R08: ffff92dc05fee020 R09: 00000000f1e77022
[   28.627065] R10: ffffacec40087e30 R11: 000000002f1e7702 R12: ffff92dc07341040
[   28.627071] R13: ffff92dc07341090 R14: 0000000000000000 R15: 0000000000000001
[   28.627077] FS:  0000000000000000(0000) GS:ffff92dc7bb00000(0000) knlGS:0000000000000000
[   28.627085] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.627091] CR2: ffffffffffffffd6 CR3: 00000000060c6000 CR4: 00000000001006e0

