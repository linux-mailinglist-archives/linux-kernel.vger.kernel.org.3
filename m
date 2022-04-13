Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378684FFDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiDMSc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbiDMScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:32:41 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF8354FBA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:30:19 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t2so45277qta.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=oaw1H7ej+H/u4nXZZIRhEvfXMrTU7J9fBtaSDqIOS9E=;
        b=Tl0MNurF8gO6Y1umghsqtSsBJzR49HHmVF9eLSBm6kpPc2Z9QYhG8CIzCgS9FDWw0P
         pfP53xh63JNatbRx63EPky41tBSo4sWcC34iMbTFh5pABfGjSPgYz4GE36N9nu/w0xUu
         /A4jkv0/kqbTAy9A3F/itIl4ghG24mRQgG/KTjqkEqH27JVXFiEIgLs7h63Rnscj5cPF
         eAAHuN6pJMpOtM/8BMcGCKZzaaQnELvwYog9F+ggl7SNTafduw5ROr05f0tq8Amei4FZ
         H1T0yvOyjEXGra2cOsLJCkj3ZSr6YH8WFeYdZWVjtbr0foGtD/2wQIHMEbtHymqjLhUG
         6n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=oaw1H7ej+H/u4nXZZIRhEvfXMrTU7J9fBtaSDqIOS9E=;
        b=VokX+rk+bBSKig1kxAwYpoQEUIfj5OPc74Qf4w6X43Chyf184zYcFcV/nNo1MJjazt
         9Q/AAhNszQCE17v+v/lqL+4bd2v/O/XC3VpD8ONd0WaFHKluHWq7QHWlPKAdYJGLa7xq
         QDoj2pMAsSfglcmE1/r5NOnDZnptvUCmm9avNtCWlLo9dJQ73svRV3LIHGw8EZuyjUQC
         lnsNTB50RnnHRFnZht06CA/2Ktf+APPS+yNSB8Za4UOy68CqKGzG6xkCJ5mEzTmuSU/b
         EfqRdbLam8Khrbg4Q8YUF2GnGp9fWUpvPDbBSADbA7U8dQQMWSflaAgmaIzoRlsUBzOL
         2cfw==
X-Gm-Message-State: AOAM5335hCQkkyAGy1xYhDE6BKA0DinxRVgqufg0Z2rmWnxphEzDzeoN
        CrznqGFXdE8OHCtdRl2LJ714TA==
X-Google-Smtp-Source: ABdhPJxREgfBX2pCsyX7ZwxQHAa4ijGVIJdD+d2SJEIQwKzRhChdCAVqhwPzb/7CrsUhX+8LDkNB/w==
X-Received: by 2002:ac8:44c1:0:b0:2ed:f66:804a with SMTP id b1-20020ac844c1000000b002ed0f66804amr8113774qto.102.1649874618218;
        Wed, 13 Apr 2022 11:30:18 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm30464060qtx.89.2022.04.13.11.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:30:16 -0700 (PDT)
Message-ID: <2031e84425f0aa8df03328057c394551c30a38f5.camel@ndufresne.ca>
Subject: Re: [PATCH v8, 00/15] media: mtk-vcodec: support for M8192 decoder
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Wed, 13 Apr 2022 14:30:15 -0400
In-Reply-To: <1d9a6259-b1f6-5c4f-7e91-0529b77b6a44@collabora.com>
References: <20220331024801.29229-1-yunfei.dong@mediatek.com>
         <fbfe4572296a133492310f13e3f41db56218fc17.camel@ndufresne.ca>
         <0f385e6e2d0687c3e6de12a576d1617af9504cee.camel@mediatek.com>
         <c5dc9f759054418082849233639f727e39329550.camel@ndufresne.ca>
         <cdcaf769ee162658e3bbb0c30bb8c4cbb168c6d6.camel@mediatek.com>
         <1d9a6259-b1f6-5c4f-7e91-0529b77b6a44@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 13 avril 2022 =C3=A0 09:57 +0200, AngeloGioacchino Del Regno a =
=C3=A9crit=C2=A0:
> Il 13/04/22 09:03, allen-kh.cheng ha scritto:
> > Hi Nicolas,
> >=20
> > On Tue, 2022-04-12 at 10:48 -0400, Nicolas Dufresne wrote:
> > > Le lundi 11 avril 2022 =C3=A0 11:41 +0800, yunfei.dong@mediatek.com a
> > > =C3=A9crit :
> > > > Hi Nicolas,
> > > >=20
> > > > On Thu, 2022-03-31 at 16:48 -0400, Nicolas Dufresne wrote:
> > > > > Hi Yunfei,
> > > > >=20
> > > > > thanks for the update, I should be testing this really soon.
> > > > >=20
> > > > > Le jeudi 31 mars 2022 =C3=A0 10:47 +0800, Yunfei Dong a =C3=A9cri=
t :
> > > > > > This series adds support for mt8192 h264/vp8/vp9 decoder
> > > > > > drivers.
> > > > > > Firstly, refactor
> > > > > > power/clock/interrupt interfaces for mt8192 is lat and core
> > > > > > architecture.
> > > > >=20
> > > > > Similarly to MT8173 and MT8183, a shared* firmware is needed for
> > > > > this
> > > > > CODEC to
> > > > > work (scp.img). I looked into linux-firmware[1] it has not been
> > > > > added
> > > > > for mt8192
> > > > > yet. As your patches are getting close to be ready, it would be
> > > > > important to
> > > > > look into this so the patchset does not get blocked due to that.
> > > > >=20
> > > > > best regards,
> > > > > Nicolas
> > > > >=20
> > > > > [1]
> > > > >=20
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/firmware/linux-firmware.git/tree/mediatek__;!!CTRNKA9wMg0ARbw!zy4N6JDr=
oSXtumXXa7MuxAgYAPAink8uyW-978vpWct8S3vOjBqXirFE8uTEHopHCovbSl0FNP9LPgWCEBr=
ZfMIcvQ$
> > > > >  =20
> > > > > * Shared at least between MDP3 and MTK VCODEC from my knowledge
> > > > >=20
> > > >=20
> > > > Thanks for your remind.
> > > >=20
> > > > I have already sent mt8192 scp.img to github.
> > > >=20
> > > >=20
> > https://urldefense.com/v3/__https://github.com/yunfeidongmediatek/linux=
_fw_scp_8192/commit/3ac2fc85bc7dfcebdb92b5b5808b0268cdfb772d__;!!CTRNKA9wMg=
0ARbw!zy4N6JDroSXtumXXa7MuxAgYAPAink8uyW-978vpWct8S3vOjBqXirFE8uTEHopHCovbS=
l0FNP9LPgWCEBpf9F_nWA$
> > > >  =20
> > > >=20
> > > > Waiting for to be merged.
> > >=20
> > > On boards I have, the firmware is loaded from /lib/firmware/scp.img,
> > > but with
> > > this submission it will be in lib/firmware/mediatek/mt8192/scp.img .
> > > I haven't
> > > found anything around:
> > >=20
> > >   drivers/remoteproc/mtk_scp.c:812:       char *fw_name =3D "scp.img"=
;
> > >=20
> > > That would use the platform path. This seems like a problem to me,
> > > the
> > > upstreaming of the firmware isn't being aligned with the were the
> > > firmware is
> > > picked by the upstream driver. Correct me if I got this wrong, but
> > > I'd really
> > > like to clarify this.
> > >=20
> > > Nicolas
> > >=20
> >=20
> > I am not sure why it's accepted the fw path of scp is
> > /lib/firmware/scp.img in mt8173/8183 but we upload scp.ing in
> > /lib/firmware/mediatek/mt8173(mt8183)/scp.img to
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
.git/tree/mediatek
> >=20
> > Currently, the scp driver will load firmware in /lib/firmware/scp.img.
> > that means there is only one firmware for a specific platform.
> > I think we can send a PATCH to make firmware name of scp being more
> > flexible.
> >=20
> > Maybe get firmware name from dts. e.g.,
> > &scp {
> > 	status =3D "okay";
> > 	firmware-name =3D "mediatek/mt81xx/scp.img";
> > };
> >=20
> > Do you think it feasible?
> > If you have any concerns, please let us know.
> >=20
> > Thanks,
> > Allen
> >=20
>=20
> Hello Allen,
>=20
> what you proposed is exactly what has been done for other platforms becau=
se of
> both per-device firmware differences (different signatures) and per-SoC (=
different
> firmware entirely), found on TI K3, iMX DSP, Qualcomm MSS/DSP remoteproc =
and
> others.
>=20
> Of course this is an accepted way to resolve this situation: please go on=
!

Looks good to me! (don't forget to keep a fallback to /lib/firmware/scp.img=
 to
maintain backward compatibility).

>=20
> Cheers,
> Angelo
>=20

