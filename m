Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE611565DB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiGDTBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDTBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:01:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201AC6471;
        Mon,  4 Jul 2022 12:01:30 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F40E660199B;
        Mon,  4 Jul 2022 20:01:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656961288;
        bh=/KVtNYhy5rVIVxZXV9AtclYPaAVRmD/X6xEoREFhDP4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FEyz6NyCNJscR2IV9AFOqZou35TJr0a/CHp1iqyGiHZ+SotFssuVZve4vxpR/kfBS
         /+gLohLwwdoME6Rmy2sgh5La8Gnn+PzjKS0/+b2sK9GxZygSeRFn0PX02EnJ4A29wO
         RzB7FYGI+V9zYVs82TAv1VRHbRMB5exo6bmtyP4fJFUnK6CmPnMZGQjbEx9FaC2jjq
         duXcgLkqHtDh9hV3Nqly3tYYFkEdmmn9BfgTJODRM9BV7/0w8WSHUNrCUd29YyKOnN
         rWvI/hFVnbXH8bbyLID+l7PkKwmZTDv1zT9HcSV+Pi/DqBb1+mQsC8vmWPsd3HDaEC
         ar/8tGoBDxRlA==
Message-ID: <52c9cf205a6b107175225733e4bff0d29c9d86c1.camel@collabora.com>
Subject: Re: [PATCH 0/6] media: mediatek-vcodec: Fix capability fields again
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Mon, 04 Jul 2022 15:01:17 -0400
In-Reply-To: <CAGXv+5Hrc6RageAu1YMBCA22r0kz+-C+9qO=qdDEmn_QhSCB3w@mail.gmail.com>
References: <20220701105237.932332-1-wenst@chromium.org>
         <e601a375-cc80-40cd-9791-e44e9d37cec0@email.android.com>
         <CAGXv+5Hrc6RageAu1YMBCA22r0kz+-C+9qO=qdDEmn_QhSCB3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 01 juillet 2022 =C3=A0 21:10 +0800, Chen-Yu Tsai a =C3=A9crit=
=C2=A0:
> On Fri, Jul 1, 2022 at 8:45 PM Nicolas Dufresne
> <nicolas.dufresne@collabora.com> wrote:
> >=20
> > Hi Chen,
> >=20
> > Le 1 juill. 2022 06 h 52, Chen-Yu Tsai <wenst@chromium.org> a =C3=A9cri=
t :
> >=20
> > Hi everyone,
> >=20
> > The previous round of changes to the mtk-vcodec driver's returned
> > capabilities caused some issues for ChromeOS. In particular, the
> > ChromeOS stateless video decoder uses the "Driver Name" field to
> > match a video device to its media device. As the field was only
> > changed for the video device and not the media device, a match
> > could no longer be found.
> >=20
> >=20
> > This match is not specified in the spec. If you feel like it should, pe=
rhaps consider specifying it first. To me it's nice if they match, but it's=
 for now just cosmetic.
>=20
> Right. Even for cosmetic reasons I think my changes make sense though.
> Fixing the matching is another thing.
>=20
> > Though this requires some discussion, as userland is expected to enumer=
ate the media device and find the video device by walking the topology. Thi=
s is the only specified way to match both.
>=20
> AFAICT, v4l2-ctl does similar matching, though by bus_info. Maybe it's
> out of convenience?

bus_info has indeed been used a lot in the past, it will be more reliable t=
hen
"driver name" matching. Using topology remains the recommended identificati=
on
method.

>=20
> ChenYu
>=20
> >=20
> >=20
> > While fixing this, I found that the current info used for the fields
> > don't make a lot of sense, and tried to fix them in this series.
> >=20
> > Patch 1 reverts the driver name field change. It also makes it
> > explicit that the field really should match the driver name.
> >=20
> > Patch 2 changes the value for the card name, making it a free form
> > string that includes the SoC model.
> >=20
> > Patch 3 removes setting the bus_info field, instead using the default
> > value derived from the underlying |struct device| as set by the V4L2
> > core.
> >=20
> > Patches 4 through 6 do the same as 1 through 3 respectively, but for
> > the encoder side.
> >=20
> > This series is based on next-20220701, and was tested on mainline on
> > MT8183 Juniper, and on ChromeOS v5.10, on which we have a whole bunch
> > of backports pending, on MT8195 Tomato.
> >=20
> > Please have a look.
> >=20
> >=20
> > Thanks
> > ChenYu
> >=20
> > Chen-Yu Tsai (6):
> >   media: mediatek: vcodec: Revert driver name change in decoder
> >     capabilities
> >   media: mediatek: vcodec: Use meaningful decoder card name including
> >     chip name
> >   media: mediatek: vcodec: Use default bus_info for decoder capability
> >   media: mediatek: vcodec: Revert driver name change in encoder
> >     capabilities
> >   media: mediatek: vcodec: Use meaningful encoder card name including
> >     chip name
> >   media: mediatek: vcodec: Use default bus_info for encoder capability
> >=20
> > drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 7 ++++---
> > drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 1 +
> > drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 7 ++++---
> > 3 files changed, 9 insertions(+), 6 deletions(-)
> >=20
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >=20
> >=20

