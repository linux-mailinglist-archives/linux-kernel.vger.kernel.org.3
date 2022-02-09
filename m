Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315FA4AF8AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiBIRpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiBIRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:45:14 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EEFC05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:45:17 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id bt13so8248058ybb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 09:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gD6+6fOZDI/HKXGfRSG82dKdDnf9SIUtKqDdAI9gUIY=;
        b=5lCpYrPIU7RZnscmLJHgtAwaKl6chvIGm424aJUynPVeclGP+X7CTEO5xfJdL2ed/+
         lsduYsGVrA9JQ69qNHm6d6Dc0UlzrxJdaByG6arKRazN70mzeiLnuRV+JHY6Junh7rXM
         vOGTnfKUrto/Q7uMa+pdr/Qktrmmgs0bvFsCA9txj7ieTXnf3E2bPw1JFG/z4aiqa4sl
         BWAA2KTLn52QUMqxjJ74bnF9uISADnywZZa6Cp9n2g0fBEltj5yoOCASVgJnvdfER8+1
         joueBc7rxx7q1Lq5V1+ZjK5O+m+MaMOoOE0Dbwts8qfscbsjLJD46G4nKBe+k7BgYIlu
         HwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gD6+6fOZDI/HKXGfRSG82dKdDnf9SIUtKqDdAI9gUIY=;
        b=Bvtx0f9HApGRL2lu95ka/yiy0jWnQpTCwqQf0qM2M2RnxxY9bOsfH6YjY+TOui1GCg
         u53nZqXyR2S1xPlVPWFv754UO45LAJ8FvYhkQTZ6TSTk6u+v14cuDdyiWOFI/mp0Omt6
         mTiwiFw/zDbYDrSgSMPGSxwX8v4Q4DP5UzUF/d4nnNPsnInYOBLqJ5H5OyBCakDkZy7n
         53JfS2u/wRIHrxa2toRk64P1HElnffUyyU9chli1j2mFJJRbtFXA6IiBI/G3FeghukrX
         FI67Ebs0XJ6ipUK1Hk22qSCRONvzSY3FjVt/otDhNnt+q/1+s5geJxduoiMaSKElOsPn
         lUzw==
X-Gm-Message-State: AOAM532SqmWQtVZDavRmrLZfSJrZbL+OqTy6RkRC699gnp766gC9DLip
        JgjslIUJItuJsHouL8TZCrkGUx1eq676E8t4rz5n7Q==
X-Google-Smtp-Source: ABdhPJwhWpq0ee53uKYyflTZnACOXuDwbm7I2k+8UIDQIGyms9s0qKMFUnRE+b3kh7biYCO/JElnJcqiAilE3/yI5Gg=
X-Received: by 2002:a25:35c5:: with SMTP id c188mr3252557yba.700.1644428716428;
 Wed, 09 Feb 2022 09:45:16 -0800 (PST)
MIME-Version: 1.0
References: <YgOQBNIdf0UnSH+M@Red>
In-Reply-To: <YgOQBNIdf0UnSH+M@Red>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 9 Feb 2022 19:45:12 +0200
Message-ID: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 9, 2022 at 11:57 AM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> Hello
>
> Booting a salvator X with CRYPTO_MANAGER_EXTRA_TESTS lead to:
> [   37.510039] ------------[ cut here ]------------
> [   37.514712] WARNING: CPU: 7 PID: 616 at /home/clabbe/linux-next/kernel=
/dma/mapping.c:200 __dma_map_sg_attrs+0xb8/0x108
> [   37.525444] Modules linked in: des_generic ofb snd_soc_hdmi_codec dw_h=
dmi_cec dw_hdmi_i2s_audio rcar_du_drm rcar_lvds crct10dif_ce snd_soc_audio_=
graph_card simple_bridge snd_soc_simple_card_utils rcar_dw_hdmi dw_hdmi drm=
_cma_helper cec rcar_csi2 rcar_fdp1 v4l2_mem2mem vsp1 rcar_cmm videobuf2_vm=
alloc rcar_fcp renesas_usb3 snd_soc_rcar rcar_vin v4l2_fwnode v4l2_async vi=
deobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common videode=
v pwm_rcar mc snd_soc_ak4613 max9611 ccree(+) renesas_usbhs phy_rcar_gen3_u=
sb3 libdes usb_dmac gpio_bd9571mwv at24 display_connector drm_kms_helper pw=
m_bl drm ecb xts cts essiv cmac xcbc ccm
> [   37.581446] CPU: 7 PID: 616 Comm: cryptomgr_test Tainted: G        W  =
       5.17.0-rc3-next-20220207-00110-g41bd5fbfc1e4 #5
> [   37.592672] Hardware name: Renesas Salvator-X board based on r8a77950 =
(DT)
> [   37.599555] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   37.606526] pc : __dma_map_sg_attrs+0xb8/0x108
> [   37.610978] lr : __dma_map_sg_attrs+0x48/0x108
> [   37.615430] sp : ffff80000c1632a0
> [   37.618749] x29: ffff80000c1632a0 x28: ffff0004c2997c00 x27: ffff0004c=
2997e20
> [   37.625909] x26: 0000000000000000 x25: 0000000000000008 x24: 000000000=
0000000
> [   37.633068] x23: 0000000000000000 x22: ffff0004cc777840 x21: 000000000=
0000000
> [   37.640226] x20: 0000000000000000 x19: ffff0004c164c010 x18: ffff80000=
b3a72f0
> [   37.647385] x17: 0000000000000000 x16: 0000000000000072 x15: 000000000=
0000010
> [   37.654544] x14: 001fffffffffffff x13: 000000006894887f x12: 818235788=
794af1b
> [   37.661703] x11: 00000000000ef000 x10: ffff0004c164c518 x9 : ffff80000=
9aa6a38
> [   37.668862] x8 : ffff80000b2759d8 x7 : ffff80000c1633a0 x6 : 000000000=
0000000
> [   37.676021] x5 : ffff800009aa6a38 x4 : 0000000000000000 x3 : 000000000=
0000000
> [   37.683179] x2 : 74374306a1f1c500 x1 : 0000000000000000 x0 : 000000000=
0000000
> [   37.690338] Call trace:
> [   37.692789]  __dma_map_sg_attrs+0xb8/0x108
> [   37.696894]  dma_map_sg_attrs+0x10/0x28
> [   37.700739]  cc_map_sg+0x64/0xf8 [ccree]
> [   37.704711]  cc_map_aead_request+0x158/0x920 [ccree]
> [   37.709703]  cc_proc_aead+0x148/0xeb8 [ccree]
> [   37.714087]  cc_aead_encrypt+0x44/0x68 [ccree]
> [   37.718557]  crypto_aead_encrypt+0x44/0x78
> [   37.722669]  test_aead_vec_cfg+0x244/0x900
> [   37.726779]  test_aead_vec+0x8c/0x190
> [   37.730450]  test_aead+0x78/0xe0
> [   37.733687]  alg_test_aead+0xa4/0x3e0
> [   37.737358]  alg_test.part.29+0xb4/0x398
> [   37.741289]  alg_test+0x48/0x78
> [   37.744439]  cryptomgr_test+0x48/0x50
> [   37.748109]  kthread+0x11c/0x128
> [   37.751347]  ret_from_fork+0x10/0x20
> [   37.754939] irq event stamp: 119412
> [   37.758431] hardirqs last  enabled at (119411): [<ffff800009188a54>] _=
raw_spin_unlock_irqrestore+0x8c/0x90
> [   37.768105] hardirqs last disabled at (119412): [<ffff800009179e20>] e=
l1_dbg+0x28/0x90
> [   37.776040] softirqs last  enabled at (119376): [<ffff80000125ac20>] c=
c_send_request+0xa0/0x208 [ccree]
> [   37.785462] softirqs last disabled at (119374): [<ffff80000125abf4>] c=
c_send_request+0x74/0x208 [ccree]
> [   37.794883] ---[ end trace 0000000000000000 ]---#
>
> When cryptlen and authsize are both 0, the driver try to map a 0 size buf=
fer which display this warning.

Thank you very much, Corentin!

I thought we squashed all these corner case size bugs but it seems
this is not the case...

I am away from my test equipment right now for covid related reasons
but will dig into this (and your other patch), hopefully early next
week.

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
