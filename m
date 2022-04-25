Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4509350E296
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242323AbiDYOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiDYOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:06:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBA4A6E1A;
        Mon, 25 Apr 2022 07:03:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x18so21071459wrc.0;
        Mon, 25 Apr 2022 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:content-transfer-encoding;
        bh=vHE174Z9h+D8IRxEakiZcXraLef3MhiUW81ttXp5zB8=;
        b=cgEpQqwLUVjChD/Rj5VVHkkdu/+D4zqMOxvcWqSYRae3NTVAF+Xya2rbkYQE1sXV4u
         GW2ATjHp7hpB/1zhZjgHL47drfmEl1/PFRToMg0UaBUjoQvwbs+Ff0dONSiMJiBI9BNK
         TBhLTu9y5w4B6vS5HF4rdQemm5gOpAEalmo8MVgX6IosmPBbebroUvzeXcvJfETMNybP
         DTFoEdGoVxhfnIMUQC2SE+MkXSIKfQT/GszWnUOzI2A4peMWIjVQpzfFxYvcIUCupl60
         4yNTTVSV+mpwyJpB0ieSBvcqiSGQsYNwBp0S/Sj3yfFn0KqMlFgAYQzKj1QFXVKPYceL
         6VZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:content-transfer-encoding;
        bh=vHE174Z9h+D8IRxEakiZcXraLef3MhiUW81ttXp5zB8=;
        b=rOSgV+aUSIkdvVyFNzaSlLTdj3VGxjYQ0cMOzywhZnbEwq5YYqpwsjYuBcD5F7jisS
         C15v7F9X7xmPMcVH6RMNB3kchwTh3DRwLcoZKYVb5Wq39HG0NkKO0pUEJXwskorbCdU5
         pAJw96SVKJtqJ3S/2tzrme/p+w52Q3IsN7mCI9YMdjSQHCAoqz/Y15kW60hqsrcGYHXS
         5aP4HDWcoGn+Bx39EiKXnWYwJjVX+SA2kUbtWPex2CfR6Z0GPAFSKl3wQFLJf47myfwP
         PmszXB1pTASG2CVvZyyYqhEVOA5a44kLsP4pqK2P0B51SluoO9swsJ1IPeBfD+HS8jZH
         yU6Q==
X-Gm-Message-State: AOAM5319tutIgafGuUYpOvixMtVr0GTGs15F3vp8SB+5c6KmKXpwsxjB
        O6WcYElb2lpr5wvFQMmA7k24jGAbq7M=
X-Google-Smtp-Source: ABdhPJycZKg2263JNtF56nGgr7jczuNgRSgJ6+YzpPZcKVm+Illialtm+rWK6j+EYHUbuFfA9AY+YQ==
X-Received: by 2002:adf:ebd2:0:b0:20a:9c10:ab29 with SMTP id v18-20020adfebd2000000b0020a9c10ab29mr14345984wrn.212.1650895400626;
        Mon, 25 Apr 2022 07:03:20 -0700 (PDT)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id e4-20020a5d6d04000000b0020a8bbbb72bsm10942891wrq.97.2022.04.25.07.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 07:03:20 -0700 (PDT)
Message-ID: <45c2dac8-277b-c7f1-bb52-16cf4d82ba5a@googlemail.com>
Date:   Mon, 25 Apr 2022 15:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Chris Clayton <chris2553@googlemail.com>
Subject: Oops in 5.18.0-rc4 when removing module dvb_usb_dtt200u
To:     LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As $SUBJECT says, I'm seeing an oops when I remove dvb_usb_dtt200u. The backtrace is as follows:

Mon Apr 25 13:11:39 2022] usbcore: deregistering interface driver dvb_usb_dtt200u
[Mon Apr 25 13:11:39 2022] ------------[ cut here ]------------
[Mon Apr 25 13:11:39 2022] WARNING: CPU: 8 PID: 1774 at kernel/module.c:1094 module_put.part.0+0x45/0x50
[Mon Apr 25 13:11:39 2022] Modules linked in: dvb_usb_dtt200u(-) rfcomm bnep xt_MASQUERADE iptable_nat nf_nat xt_LOG
nf_log_syslog xt_limit xt_multiport xt_conntrack iptable_filter ntfs3 wmi_bmof snd_hda_codec_hdmi coretemp hwmon usbhid
r8169 snd_hda_codec_realtek realtek snd_hda_codec_generic mdio_devres ledtrig_audio x86_pkg_temp_thermal libphy
snd_hda_intel snd_intel_dspcfg snd_hda_codec i2c_i801 snd_hwdep i2c_smbus snd_hda_core i915 drm_buddy ttm drm_dp_helper
drm_kms_helper mei_me syscopyarea sysfillrect sysimgblt mei fb_sys_fops intel_lpss_pci intel_lpss uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 btusb videobuf2_common wmi btintel nf_conntrack_ftp xt_helper
nf_conntrack nf_defrag_ipv4 tun
[Mon Apr 25 13:11:39 2022] CPU: 8 PID: 1774 Comm: modprobe Not tainted 5.18.0-rc4 #928
[Mon Apr 25 13:11:39 2022] Hardware name: Notebook                         NP50DE_DB                       /NP50DE_DB
                   , BIOS 1.07.04 02/17/2020
[Mon Apr 25 13:11:39 2022] RIP: 0010:module_put.part.0+0x45/0x50
[Mon Apr 25 13:11:39 2022] Code: f0 0f b1 93 c8 02 00 00 75 ef bf 01 00 00 00 e8 61 aa f9 ff 65 8b 05 da 3f 6d 5b 85 c0
74 03 5b c3 cc e8 a5 a4 eb ff 5b c3 cc <0f> 0b eb dc 0f 1f 80 00 00 00 00 48 85 ff 74 02 eb a9 c3 cc 0f 1f
[Mon Apr 25 13:11:39 2022] RSP: 0018:ffffb99700bfbd58 EFLAGS: 00010297
[Mon Apr 25 13:11:39 2022] RAX: 0000000000000000 RBX: ffffffffc04d5bc0 RCX: 0000000000001000
[Mon Apr 25 13:11:39 2022] RDX: 00000000ffffffff RSI: ffffffffc04cf740 RDI: 0000000000000001
[Mon Apr 25 13:11:39 2022] RBP: ffffffffc04cf740 R08: ffffffffc04d5bc0 R09: 0000000000000262
[Mon Apr 25 13:11:39 2022] R10: ffffffffc04cf740 R11: ffff96eff93db2f5 R12: ffff96efc4bb8c00
[Mon Apr 25 13:11:39 2022] R13: ffffffffc04cf740 R14: ffff96efc4bbb030 R15: 0000000000000000
[Mon Apr 25 13:11:39 2022] FS:  00007ff523738b80(0000) GS:ffff96f700600000(0000) knlGS:0000000000000000
[Mon Apr 25 13:11:39 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mon Apr 25 13:11:39 2022] CR2: 00007ff523836d10 CR3: 000000013944a002 CR4: 00000000007706e0
[Mon Apr 25 13:11:39 2022] PKRU: 55555554
[Mon Apr 25 13:11:39 2022] Call Trace:
[Mon Apr 25 13:11:39 2022]  <TASK>
[Mon Apr 25 13:11:39 2022]  symbol_put_addr+0x2f/0x50
[Mon Apr 25 13:11:39 2022]  dvb_frontend_put+0x98/0xc0
[Mon Apr 25 13:11:39 2022]  dvb_usb_adapter_frontend_exit+0x3c/0x60
[Mon Apr 25 13:11:39 2022]  dvb_usb_device_exit+0x80/0x140
[Mon Apr 25 13:11:39 2022]  usb_unbind_interface+0x82/0x260
[Mon Apr 25 13:11:39 2022]  device_release_driver_internal+0x1a2/0x200
[Mon Apr 25 13:11:39 2022]  driver_detach+0x3f/0x80
[Mon Apr 25 13:11:39 2022]  bus_remove_driver+0x50/0xd0
[Mon Apr 25 13:11:39 2022]  usb_deregister+0x63/0xbd
[Mon Apr 25 13:11:39 2022]  __do_sys_delete_module.constprop.0+0x14f/0x220
[Mon Apr 25 13:11:39 2022]  ? fpregs_assert_state_consistent+0x1a/0x40
[Mon Apr 25 13:11:39 2022]  ? exit_to_user_mode_prepare+0x3b/0x110
[Mon Apr 25 13:11:39 2022]  do_syscall_64+0x38/0x90
[Mon Apr 25 13:11:39 2022]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[Mon Apr 25 13:11:39 2022] RIP: 0033:0x7ff523866b77
[Mon Apr 25 13:11:39 2022] Code: 73 01 c3 48 8b 0d f1 72 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00
00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 72 0c 00 f7 d8 64 89 01 48
[Mon Apr 25 13:11:39 2022] RSP: 002b:00007ffd19bd25a8 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
[Mon Apr 25 13:11:39 2022] RAX: ffffffffffffffda RBX: 00000000006cd900 RCX: 00007ff523866b77
[Mon Apr 25 13:11:39 2022] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00000000006cd968
[Mon Apr 25 13:11:39 2022] RBP: 00000000006cd900 R08: 0000000000000000 R09: 0000000000000000
[Mon Apr 25 13:11:39 2022] R10: 00007ff52376cd10 R11: 0000000000000202 R12: 00000000006cd968
[Mon Apr 25 13:11:39 2022] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000006cd900
[Mon Apr 25 13:11:39 2022]  </TASK>
[Mon Apr 25 13:11:39 2022] ---[ end trace 0000000000000000 ]---
[Mon Apr 25 13:11:39 2022] dvb-usb: WideView WT-220U PenType Receiver (Typh successfully deinitialized and disconnected.

I get the same oops in 5.17.4 and 5.15.35 too. I'll try 5.10.112 and 5.4.190 and report back.

The oops semems to be in kernel/module.c, but as I can insert and remove other modules, I've copied this report to both
LMKL and the linux-media list.

Please do let me know if you want any additional diagnostics, but you will need to cc me as I'm not subscribed..

Chris
