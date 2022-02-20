Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E54BCDCF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbiBTKCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:02:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiBTKCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:02:05 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Feb 2022 02:01:42 PST
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7837BF7D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:01:40 -0800 (PST)
X-KPN-MessageId: f09f84cd-9233-11ec-944c-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id f09f84cd-9233-11ec-944c-005056994fde;
        Sun, 20 Feb 2022 11:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:subject:from:to:mime-version:date:message-id;
        bh=uXydQkE1lw2CwgT0uQeDu4cD+XcJ7tvjrR2IOH9honI=;
        b=sQhadHjV017pbjCXx9wIeG30F/WhFmhlNBUAXkVBp8YcJWLIIXnlU3uoPl4MfHa9zzC/eS/o9lSzp
         vR/TRbTetaHm228853HP9PyZnsmgHVHEaq/2vaejsfCHOMrfxzyNYLdzpS3VaX8rYFoPh0eMGjQp6M
         fqSmuwWt3KPEblKi6VyIgSE/e9BzPmhL4SICWzuGiLWlJK3GrGkwA4bsn337Eqs46b2Ujgl4wxvBzJ
         q/lbR+0v7w19g1hbE5HPJ9ihSC1drbh7oCwFct+CE8E2ClosAyXR4Zat2+/xOds65oXYerfLCw3cJY
         MIJ+EeAIEfGN2Hcp1cc1s+LZw0INg7w==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|1FJHHENx46EkiHrFXN2SuZ61lF9czSHCkkEqrmXQoJrngGwuXxwGMOwINQbhXMp
 M6EGW3b9rld0WzD7CPD9YRg==
X-Originating-IP: 82.161.210.87
Received: from [192.168.10.70] (pindarots.xs4all.nl [82.161.210.87])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id f33039cc-9233-11ec-afd8-00505699b758;
        Sun, 20 Feb 2022 11:00:36 +0100 (CET)
Message-ID: <6229ac44-dbce-9978-1016-3b56468c8578@xs4all.nl>
Date:   Sun, 20 Feb 2022 11:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: BUG: unable to handle page fault in 5.15.22
Organization: hierzo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Computer crashed (hung..) and after reboot I found this in messages:

Feb 20 10:55:28 kraak1 kernel: [719088.355624] BUG: unable to handle 
page fault for address: fffffffffffffff8
Feb 20 10:55:28 kraak1 kernel: [719088.355629] #PF: supervisor read 
access in kernel mode
Feb 20 10:55:28 kraak1 kernel: [719088.355630] #PF: error_code(0x0000) - 
not-present page
Feb 20 10:55:28 kraak1 kernel: [719088.355631] PGD 51a00c067 P4D 
51a00c067 PUD 51a00e067 PMD 0
Feb 20 10:55:28 kraak1 kernel: [719088.355634] Oops: 0000 [#1] PREEMPT 
SMP NOPTI
Feb 20 10:55:28 kraak1 kernel: [719088.355636] CPU: 10 PID: 769 Comm: 
sdma0 Not tainted 5.15.22 #20
Feb 20 10:55:28 kraak1 kernel: [719088.355638] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Feb 20 10:55:28 kraak1 kernel: [719088.355639] RIP: 
0010:swake_up_locked+0x12/0x40
Feb 20 10:55:28 kraak1 kernel: [719088.355644] Code: 10 48 89 02 eb 83 
f6 80 e1 06 00 00 01 0f 84 5a ff ff ff eb ad 0f 1f 00 48 8b 57 08 48 8d 
47 08 48 39 c2 74 25 53 48 8b 5f 08 <48> 8b 7b f8 e8 25 a1 fe ff 48 8b 
13 48 8b 43 08 48 89 42 08 48 89
Feb 20 10:55:28 kraak1 kernel: [719088.355645] RSP: 
0018:ffff9a1b00dc3e88 EFLAGS: 00010017
Feb 20 10:55:28 kraak1 kernel: [719088.355647] RAX: ffff8e394e4fd248 
RBX: 0000000000000000 RCX: 0000000001f20f40
Feb 20 10:55:28 kraak1 kernel: [719088.355648] RDX: 0000000000000000 
RSI: ffff8e396557a230 RDI: ffff8e394e4fd240
Feb 20 10:55:28 kraak1 kernel: [719088.355649] RBP: ffff8e394e4fd240 
R08: 0000000000000000 R09: ffff9a1b007a5000
Feb 20 10:55:28 kraak1 kernel: [719088.355650] R10: ffff9a1b007a5000 
R11: ffff9a1b007a5000 R12: 0000000000000286
Feb 20 10:55:28 kraak1 kernel: [719088.355651] R13: ffff8e3940e6b9e0 
R14: ffff8e394e4fd238 R15: ffff8e399672b540
Feb 20 10:55:28 kraak1 kernel: [719088.355651] FS: 
0000000000000000(0000) GS:ffff8e407e080000(0000) knlGS:0000000000000000
Feb 20 10:55:28 kraak1 kernel: [719088.355652] CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
Feb 20 10:55:28 kraak1 kernel: [719088.355653] CR2: fffffffffffffff8 
CR3: 000000051a00a000 CR4: 0000000000750ee0
Feb 20 10:55:28 kraak1 kernel: [719088.355654] PKRU: 55555554
Feb 20 10:55:28 kraak1 kernel: [719088.355655] Call Trace:
Feb 20 10:55:28 kraak1 kernel: [719088.355656]  <TASK>
Feb 20 10:55:28 kraak1 kernel: [719088.355657]  complete+0x29/0x40
Feb 20 10:55:28 kraak1 kernel: [719088.355661] 
drm_sched_main+0x1a9/0x3d0 [gpu_sched]
Feb 20 10:55:28 kraak1 kernel: [719088.355664]  ? wait_woken+0x60/0x60
Feb 20 10:55:28 kraak1 kernel: [719088.355666]  ? 
drm_sched_resubmit_jobs+0x10/0x10 [gpu_sched]
Feb 20 10:55:28 kraak1 kernel: [719088.355668]  kthread+0x13c/0x160
Feb 20 10:55:28 kraak1 kernel: [719088.355670]  ? 
set_kthread_struct+0x30/0x30
Feb 20 10:55:28 kraak1 kernel: [719088.355671]  ret_from_fork+0x22/0x30
Feb 20 10:55:28 kraak1 kernel: [719088.355675]  </TASK>
Feb 20 10:55:28 kraak1 kernel: [719088.355675] Modules linked in: 
snd_seq_dummy mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT 
nf_reject_ipv4 xt_u32 xt_multiport iptable_filter 
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT 
nf_reject_ipv6 xt_tcpudp xt_state xt_conntrack nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 it87 hwmon_vid msr ip6table_filter 
ip6_tables binfmt_misc uvcvideo videobuf2_vmalloc videobuf2_memops 
snd_usb_audio videobuf2_v4l2 snd_hda_codec_realtek snd_hwdep videodev 
snd_usbmidi_lib lzo_rle videobuf2_common cdc_acm snd_rawmidi 
snd_hda_codec_generic lzo_compress snd_hda_intel snd_intel_dspcfg 
snd_hda_codec snd_hda_core snd_seq snd_seq_device snd_pcm bfq snd_timer 
snd i2c_piix4 evdev fuse configfs zram zsmalloc ip_tables x_tables 
hid_generic amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
usbhid i2c_dev autofs4


Kind regards,
Udo
