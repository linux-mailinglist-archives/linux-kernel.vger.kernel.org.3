Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F664AEEC6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiBIJ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiBIJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:59:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83BBE0E08B2;
        Wed,  9 Feb 2022 01:58:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k1so3029578wrd.8;
        Wed, 09 Feb 2022 01:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GiYVCUQVn5qABu6+pjE+wg7nbhOtHAJxVjxeBiLpFuw=;
        b=EV1xAbPdepQ15yM2hA6yek1hBdtQohPZpV9fqvFAKFPPoiBAlgjtzuxfIUfqVlWDzI
         KEh6coDvA/0rk4oKm7WB9HIqoqCxrI1vy0hhiaRjXPgtiejifUuaN9ub9kHfxmBTrdFn
         8fBo0ATtRRrj4fFNH/hv/6T+/zNjlNjbNVvlVhWnAXH9HpnXyPjDWTFMO4fB0ZY4P1Iy
         KSlQ86ZhzOJKjEGfvNT/BjtPpAB44xw+fdMqgFGNCTdXEJh0P74rxvo26QOqfe8y8j/N
         b6NWKm9xpQHpqj1Fv5WgmtWy9QeT0k74yuyXI9Obl35ugaMHUtItXKjCnbfxCUF/2VRf
         rquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GiYVCUQVn5qABu6+pjE+wg7nbhOtHAJxVjxeBiLpFuw=;
        b=ibFkpyBvr8VQTQ4llFr+wBR+gJMoF8bNXb8esyjrU1B7DvVKPn/IrdwGjgpkZT2LHZ
         0xevLnq403LdBvGHarmi/baL/QQtwkIGkrxLk9PcZ2JQ6eDMSwVMzUgMXxTMfBWsyoHz
         uRRILvLmSElREj3QDuwLJnWhggiG63Ladv5danQhR+nQFyWhEiYszoPYMzMf2BXbPDxl
         Q6hK/0zb+9luVkoii4XMR324sCkJgTzl2bLxrV0upkjUAorcBcsbH0M7n9f167eZ//ol
         yntbPy6XDKZ5/GbYBIiIUHUh0B3ceb2ow11f7My0uUMnciQKBfK1rc+cKx9LqCwClmgm
         nL1g==
X-Gm-Message-State: AOAM531ONbITidI+oUlrdmh5u6FZ3D8EDPaja2ajYUMMpiOrSPRxdSE3
        9T+kd1F7iZQdKUt4FhSZzjY=
X-Google-Smtp-Source: ABdhPJxKVmt8Fb9dGTQOC6VyFXJBFG+zDKJ6r9SV9rgxspR0+tytOz8xGOtGCs8IXIOnFlblx4k9Cw==
X-Received: by 2002:a05:6000:1846:: with SMTP id c6mr1392952wri.683.1644400647938;
        Wed, 09 Feb 2022 01:57:27 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id w6sm13674911wrp.51.2022.02.09.01.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:57:27 -0800 (PST)
Date:   Wed, 9 Feb 2022 10:57:24 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     gilad@benyossef.com, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
Message-ID: <YgOQBNIdf0UnSH+M@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Booting a salvator X with CRYPTO_MANAGER_EXTRA_TESTS lead to:
[   37.510039] ------------[ cut here ]------------
[   37.514712] WARNING: CPU: 7 PID: 616 at /home/clabbe/linux-next/kernel/dma/mapping.c:200 __dma_map_sg_attrs+0xb8/0x108
[   37.525444] Modules linked in: des_generic ofb snd_soc_hdmi_codec dw_hdmi_cec dw_hdmi_i2s_audio rcar_du_drm rcar_lvds crct10dif_ce snd_soc_audio_graph_card simple_bridge snd_soc_simple_card_utils rcar_dw_hdmi dw_hdmi drm_cma_helper cec rcar_csi2 rcar_fdp1 v4l2_mem2mem vsp1 rcar_cmm videobuf2_vmalloc rcar_fcp renesas_usb3 snd_soc_rcar rcar_vin v4l2_fwnode v4l2_async videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common videodev pwm_rcar mc snd_soc_ak4613 max9611 ccree(+) renesas_usbhs phy_rcar_gen3_usb3 libdes usb_dmac gpio_bd9571mwv at24 display_connector drm_kms_helper pwm_bl drm ecb xts cts essiv cmac xcbc ccm
[   37.581446] CPU: 7 PID: 616 Comm: cryptomgr_test Tainted: G        W         5.17.0-rc3-next-20220207-00110-g41bd5fbfc1e4 #5
[   37.592672] Hardware name: Renesas Salvator-X board based on r8a77950 (DT)
[   37.599555] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   37.606526] pc : __dma_map_sg_attrs+0xb8/0x108
[   37.610978] lr : __dma_map_sg_attrs+0x48/0x108
[   37.615430] sp : ffff80000c1632a0
[   37.618749] x29: ffff80000c1632a0 x28: ffff0004c2997c00 x27: ffff0004c2997e20
[   37.625909] x26: 0000000000000000 x25: 0000000000000008 x24: 0000000000000000
[   37.633068] x23: 0000000000000000 x22: ffff0004cc777840 x21: 0000000000000000
[   37.640226] x20: 0000000000000000 x19: ffff0004c164c010 x18: ffff80000b3a72f0
[   37.647385] x17: 0000000000000000 x16: 0000000000000072 x15: 0000000000000010
[   37.654544] x14: 001fffffffffffff x13: 000000006894887f x12: 818235788794af1b
[   37.661703] x11: 00000000000ef000 x10: ffff0004c164c518 x9 : ffff800009aa6a38
[   37.668862] x8 : ffff80000b2759d8 x7 : ffff80000c1633a0 x6 : 0000000000000000
[   37.676021] x5 : ffff800009aa6a38 x4 : 0000000000000000 x3 : 0000000000000000
[   37.683179] x2 : 74374306a1f1c500 x1 : 0000000000000000 x0 : 0000000000000000
[   37.690338] Call trace:
[   37.692789]  __dma_map_sg_attrs+0xb8/0x108
[   37.696894]  dma_map_sg_attrs+0x10/0x28
[   37.700739]  cc_map_sg+0x64/0xf8 [ccree]
[   37.704711]  cc_map_aead_request+0x158/0x920 [ccree]
[   37.709703]  cc_proc_aead+0x148/0xeb8 [ccree]
[   37.714087]  cc_aead_encrypt+0x44/0x68 [ccree]
[   37.718557]  crypto_aead_encrypt+0x44/0x78
[   37.722669]  test_aead_vec_cfg+0x244/0x900
[   37.726779]  test_aead_vec+0x8c/0x190
[   37.730450]  test_aead+0x78/0xe0
[   37.733687]  alg_test_aead+0xa4/0x3e0
[   37.737358]  alg_test.part.29+0xb4/0x398
[   37.741289]  alg_test+0x48/0x78
[   37.744439]  cryptomgr_test+0x48/0x50
[   37.748109]  kthread+0x11c/0x128
[   37.751347]  ret_from_fork+0x10/0x20
[   37.754939] irq event stamp: 119412
[   37.758431] hardirqs last  enabled at (119411): [<ffff800009188a54>] _raw_spin_unlock_irqrestore+0x8c/0x90
[   37.768105] hardirqs last disabled at (119412): [<ffff800009179e20>] el1_dbg+0x28/0x90
[   37.776040] softirqs last  enabled at (119376): [<ffff80000125ac20>] cc_send_request+0xa0/0x208 [ccree]
[   37.785462] softirqs last disabled at (119374): [<ffff80000125abf4>] cc_send_request+0x74/0x208 [ccree]
[   37.794883] ---[ end trace 0000000000000000 ]---#

When cryptlen and authsize are both 0, the driver try to map a 0 size buffer which display this warning.

Regards
