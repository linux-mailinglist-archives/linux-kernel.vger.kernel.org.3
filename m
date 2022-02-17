Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30A04BA9F4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245300AbiBQTic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:38:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243729AbiBQTia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:38:30 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85608165C2C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:38:14 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p5so15069966ybd.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PQCjjzekxg3oMaEiJqn8HHt7OWCPLCyOJaxC9S1ZDVw=;
        b=ZtRgy5hYOcVdIzv20FLKiRjWKPaiE7pUDV5DGUe5BWiWiBsPcdSs0tXZH6DEFOF7ai
         9sFs+GLvRc3lHoGb2Pxf9G2b68+/ZA12C5RTUWIPaYLOl6VVbz+L7aZ2NNSJjesFMLAN
         UAAJOKA662u4G8AeK8+kWl7VC0W6sqOynwu02NA2sT1v4K4Ogh4M3szTSQ2K4PN8ANhn
         KIE6/0MNRgdI/Q3FYPzPB7LuE9YkekAF41CkJxIDiyzK7TZqysxn2wriHUhF8P4A+pgT
         e2RPzHLjMLwQYlMSKj5PTGyr7aLr4MDQQrGkavGD+a1mkbTqtOisAP8I5s2Qh4CKXd/z
         g9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PQCjjzekxg3oMaEiJqn8HHt7OWCPLCyOJaxC9S1ZDVw=;
        b=3TCgnZ6rsnB+tPQHoDEzLhuy+sgPUq2ocSdTUpqw25pF5zbNnDZO7d/6WlEu9H6ai/
         4evLZUJoaofb05w+yskdR6mVwY4lF9M4NMde+nxDmYVroTOZen/gE5buh5h0nyNA7wYq
         qvHdr6YvXKrJAV0UzkZJTkHMHL7jzjORu02Mk4H/6FiszzCdOM0/a6h4bqDLyfR34y4R
         AqV1j0F3UY2LGcsK3cS1S40MscF35ai0VVmby5tOA5RxHMgiQ0Uh2oNXxx//WCi8Zp4R
         MMV82JgjexuENqA/vhcOXQUTJ3nMWTRRzGh7KhmJ8OGd2R7wDJ1SQQqjm318gKA//J+/
         5AEg==
X-Gm-Message-State: AOAM533d0kafSIEUUv8i3S0mwk5Ol7teXgZnR56lr464TZn4SA8hnqz0
        h6bHaWGYzPsaRrC3f1lp4r68WmmZjPNO62cWvBjUD/9njI8kJQ==
X-Google-Smtp-Source: ABdhPJwI41uDf8dX4KIN1f5IjzA04wlcqME3nDA4v6qHSU4LnAGO+W8+dIxp9JuYeq+C7LN14YF+Ccr3N12/qw94IQ0=
X-Received: by 2002:a25:ba04:0:b0:623:ed7a:701d with SMTP id
 t4-20020a25ba04000000b00623ed7a701dmr3917466ybg.209.1645126693745; Thu, 17
 Feb 2022 11:38:13 -0800 (PST)
MIME-Version: 1.0
References: <YgOQBNIdf0UnSH+M@Red> <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
In-Reply-To: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 17 Feb 2022 21:38:10 +0200
Message-ID: <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, I still do not have access to my Salvator-X board but I attempted
a fix nevertheless and it does not seem to trigger new failures on the
boards I do have so please give it a shot and let me know.

And thanks again for taking the time to report this!

Cheers,
Gilad

On Wed, Feb 9, 2022 at 7:45 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote=
:
>
> Hi,
>
> On Wed, Feb 9, 2022 at 11:57 AM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > Hello
> >
> > Booting a salvator X with CRYPTO_MANAGER_EXTRA_TESTS lead to:
> > [   37.510039] ------------[ cut here ]------------
> > [   37.514712] WARNING: CPU: 7 PID: 616 at /home/clabbe/linux-next/kern=
el/dma/mapping.c:200 __dma_map_sg_attrs+0xb8/0x108
> > [   37.525444] Modules linked in: des_generic ofb snd_soc_hdmi_codec dw=
_hdmi_cec dw_hdmi_i2s_audio rcar_du_drm rcar_lvds crct10dif_ce snd_soc_audi=
o_graph_card simple_bridge snd_soc_simple_card_utils rcar_dw_hdmi dw_hdmi d=
rm_cma_helper cec rcar_csi2 rcar_fdp1 v4l2_mem2mem vsp1 rcar_cmm videobuf2_=
vmalloc rcar_fcp renesas_usb3 snd_soc_rcar rcar_vin v4l2_fwnode v4l2_async =
videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common video=
dev pwm_rcar mc snd_soc_ak4613 max9611 ccree(+) renesas_usbhs phy_rcar_gen3=
_usb3 libdes usb_dmac gpio_bd9571mwv at24 display_connector drm_kms_helper =
pwm_bl drm ecb xts cts essiv cmac xcbc ccm
> > [   37.581446] CPU: 7 PID: 616 Comm: cryptomgr_test Tainted: G        W=
         5.17.0-rc3-next-20220207-00110-g41bd5fbfc1e4 #5
> > [   37.592672] Hardware name: Renesas Salvator-X board based on r8a7795=
0 (DT)
> > [   37.599555] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   37.606526] pc : __dma_map_sg_attrs+0xb8/0x108
> > [   37.610978] lr : __dma_map_sg_attrs+0x48/0x108
> > [   37.615430] sp : ffff80000c1632a0
> > [   37.618749] x29: ffff80000c1632a0 x28: ffff0004c2997c00 x27: ffff000=
4c2997e20
> > [   37.625909] x26: 0000000000000000 x25: 0000000000000008 x24: 0000000=
000000000
> > [   37.633068] x23: 0000000000000000 x22: ffff0004cc777840 x21: 0000000=
000000000
> > [   37.640226] x20: 0000000000000000 x19: ffff0004c164c010 x18: ffff800=
00b3a72f0
> > [   37.647385] x17: 0000000000000000 x16: 0000000000000072 x15: 0000000=
000000010
> > [   37.654544] x14: 001fffffffffffff x13: 000000006894887f x12: 8182357=
88794af1b
> > [   37.661703] x11: 00000000000ef000 x10: ffff0004c164c518 x9 : ffff800=
009aa6a38
> > [   37.668862] x8 : ffff80000b2759d8 x7 : ffff80000c1633a0 x6 : 0000000=
000000000
> > [   37.676021] x5 : ffff800009aa6a38 x4 : 0000000000000000 x3 : 0000000=
000000000
> > [   37.683179] x2 : 74374306a1f1c500 x1 : 0000000000000000 x0 : 0000000=
000000000
> > [   37.690338] Call trace:
> > [   37.692789]  __dma_map_sg_attrs+0xb8/0x108
> > [   37.696894]  dma_map_sg_attrs+0x10/0x28
> > [   37.700739]  cc_map_sg+0x64/0xf8 [ccree]
> > [   37.704711]  cc_map_aead_request+0x158/0x920 [ccree]
> > [   37.709703]  cc_proc_aead+0x148/0xeb8 [ccree]
> > [   37.714087]  cc_aead_encrypt+0x44/0x68 [ccree]
> > [   37.718557]  crypto_aead_encrypt+0x44/0x78
> > [   37.722669]  test_aead_vec_cfg+0x244/0x900
> > [   37.726779]  test_aead_vec+0x8c/0x190
> > [   37.730450]  test_aead+0x78/0xe0
> > [   37.733687]  alg_test_aead+0xa4/0x3e0
> > [   37.737358]  alg_test.part.29+0xb4/0x398
> > [   37.741289]  alg_test+0x48/0x78
> > [   37.744439]  cryptomgr_test+0x48/0x50
> > [   37.748109]  kthread+0x11c/0x128
> > [   37.751347]  ret_from_fork+0x10/0x20
> > [   37.754939] irq event stamp: 119412
> > [   37.758431] hardirqs last  enabled at (119411): [<ffff800009188a54>]=
 _raw_spin_unlock_irqrestore+0x8c/0x90
> > [   37.768105] hardirqs last disabled at (119412): [<ffff800009179e20>]=
 el1_dbg+0x28/0x90
> > [   37.776040] softirqs last  enabled at (119376): [<ffff80000125ac20>]=
 cc_send_request+0xa0/0x208 [ccree]
> > [   37.785462] softirqs last disabled at (119374): [<ffff80000125abf4>]=
 cc_send_request+0x74/0x208 [ccree]
> > [   37.794883] ---[ end trace 0000000000000000 ]---#
> >
> > When cryptlen and authsize are both 0, the driver try to map a 0 size b=
uffer which display this warning.
>
> Thank you very much, Corentin!
>
> I thought we squashed all these corner case size bugs but it seems
> this is not the case...
>
> I am away from my test equipment right now for covid related reasons
> but will dig into this (and your other patch), hopefully early next
> week.
>
> Thanks,
> Gilad
>
> --
> Gilad Ben-Yossef
> Chief Coffee Drinker
>
> values of =CE=B2 will give rise to dom!



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
