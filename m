Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2F566F50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiGENgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGENfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:35:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1525E6EEA0;
        Tue,  5 Jul 2022 05:57:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B95BD66019D1;
        Tue,  5 Jul 2022 13:56:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657025814;
        bh=mmPoxIRR9ChlnYGyGbRq7S9ABg48kE//DWKGRNjh5Ro=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XwGOvaVxerCStoz0xLNMGU+RIiNH3JC1aj01myuSPataEtZUNi8XagF0yQM8EMZSU
         YKSWFuNtgsG/uMRF6hKryUZQjcHiRXkuZCJ95jIZ/O2vswv6EbpFesC/ODEWsLYF+/
         oFfFX33Jz3pSjrYQ6qwCIVNGKhJtwkqhG1t9iCUXer5rMxuLz1b3d94KYCrGeTPi7N
         rABSpZtJFdl1SJojdPzNt6mlcL5rINuKHZ4NrBhHBAGEtuMSiEn+qTW05O19tsaYlj
         wWdaOoKTFPK1gYW8dj0J5/awWfftDTzwVr5Qc7ISMwwn5ArKIbFaFy/45eSw3NlZbS
         A2cQEc8lXFO8w==
Message-ID: <b12d2df4-73e8-a558-582f-200236bd6560@collabora.com>
Date:   Tue, 5 Jul 2022 14:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V10,0/7] Enable two hardware jpeg encoder for MT8195
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
References: <20220627025625.8956-1-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220627025625.8956-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/06/22 04:56, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> This series adds support for multi hardware jpeg encoding, by first
> adding use of_platform_populate to manage each hardware information:
> interrupt, clock, register bases and power. Secondly add encoding
> work queue to deal with the encoding requestsof multi-hardware
> at the same time. Lastly, add output picture reorder function
> interface to eliminate the out of order images.
> 
> This series has been tested with MT8195 Gstreamer.
> Encoding worked for this chip.
> 

Hello Irui,

Unfortunately, I can't reproduce your successful test with gstreamer: when
I try to encode a jpeg with videotestsrc input, I get a kernel panic.

To reproduce this behavior, please run the following:

gst-launch-1.0 videotestsrc ! v4l2jpegenc ! filesink location=hwenctest.jpg


Here's the panic log:

[  342.567211] Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000108

[  342.576014] Mem abort info:

[  342.578805]   ESR = 0x0000000096000004

[  342.582552]   EC = 0x25: DABT (current EL), IL = 32 bits

[  342.587863]   SET = 0, FnV = 0

[  342.590919]   EA = 0, S1PTW = 0

[  342.594062]   FSC = 0x04: level 0 translation fault

[  342.598941] Data abort info:

[  342.601826]   ISV = 0, ISS = 0x00000004

[  342.605668]   CM = 0, WnR = 0

[  342.608643] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000119029000

[  342.615094] [0000000000000108] pgd=0000000000000000, p4d=0000000000000000

[  342.621907] Internal error: Oops: 96000004 [#1] SMP

[  342.626800] Modules linked in: cdc_ether usbnet r8152 af_alg qrtr mt7921e 
mt7921_common mt76_connac_lib mt76 mac80211 btusb btrtl btintel btmtk btbcm 
bluetooth cfg80211 mtk_vcodec_dec_hw uvcvideo snd_sof_mt8195 ecdh_generic 
mtk_vcodec_dec ecc mtk_adsp_common videobuf2_vmalloc snd_sof_xtensa_dsp rfkill 
snd_sof_of v4l2_vp9 panfrost mtk_jpeg snd_sof v4l2_h264 mtk_jpeg_enc_hw 8021q 
mtk_vcodec_common cros_ec_sensors gpu_sched cros_ec_lid_angle mtk_jpeg_dec_hw 
hid_multitouch snd_sof_utils cros_ec_sensors_core crct10dif_ce garp 
cros_usbpd_logger sbs_battery mrp stp llc ipmi_devintf ipmi_msghandler fuse ipv6

[  342.680332] CPU: 3 PID: 180 Comm: kworker/u16:6 Tainted: G        W 
5.19.0-rc3-next-20220622+ #814

[  342.689982] Hardware name: MediaTek Tomato (rev2) board (DT)

[  342.695637] Workqueue: mtk-jpeg mtk_jpegenc_worker [mtk_jpeg]

[  342.701402] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)

[  342.708360] pc : mtk_jpegenc_worker+0x6c/0x3e0 [mtk_jpeg]

[  342.713763] lr : mtk_jpegenc_worker+0x64/0x3e0 [mtk_jpeg]

[  342.719166] sp : ffff8000093cbcd0

[  342.722478] x29: ffff8000093cbcd0 x28: ffffb1f341cdb000 x27: ffff6089885d0505

[  342.729618] x26: ffffb1f341ce1ee0 x25: ffffb1f341d0a2d0 x24: ffff60899078d000

[  342.736758] x23: ffffb1f2e869c590 x22: ffff608990785458 x21: ffff60898a0ea120

[  342.743898] x20: ffff60898a0ea080 x19: ffff60898a0ea080 x18: 0000000000000000

[  342.751038] x17: 0000000000000000 x16: ffffb1f3405a58c0 x15: 0000aaaac092a3d0

[  342.758178] x14: 0000000000000000 x13: 0000000000000c5f x12: 071c71c71c71c71c

[  342.765318] x11: 0000000000000c5f x10: 00000000000027a0 x9 : ffffb1f33f32ce9c

[  342.772458] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffffb1f2e8699804

[  342.779597] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff608985d3c570

[  342.786737] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000

[  342.793876] Call trace:

[  342.796319]  mtk_jpegenc_worker+0x6c/0x3e0 [mtk_jpeg]

[  342.801376]  process_one_work+0x294/0x664

[  342.805392]  worker_thread+0x7c/0x45c

[  342.809055]  kthread+0x104/0x110

[  342.812283]  ret_from_fork+0x10/0x20

[  342.815863] Code: aa1503e0 9400037e f9415662 aa0003e1 (b9410840)

[  342.821956] ---[ end trace 0000000000000000 ]---


Regards,
Angelo
