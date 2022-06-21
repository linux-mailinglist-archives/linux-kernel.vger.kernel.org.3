Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8897555350C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351944AbiFUO4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350167AbiFUO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:56:19 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C184827CFF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:56:17 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a184so10278734qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=GTf+1EpY6JStEJhVUzLt7wdTH2UAsJxs2Qprj1UXr8w=;
        b=vzCf01wDrq7d7rl2ww+xXP/xbzvTXUf7qGcXWkAS20xRyPJo4WOKyH2icegwtTRSZu
         SBqVqHiy2HzcDo4FeW6zhO9sDootDofeU17TpiBvnZurxOBwgIVwNe2ms8dhl3AX4VFj
         rX89ugpOOGC+1M/wdoqN/lLR8U4xCAGTm/yc68HucT18R8vtCDVs2dMMdx9kWStmu3Ny
         8+03HOZNgV01X7mF0E3HAgd9fGWNB5+sswmMcUeThZ/Z6lod5AuH5rc52pOxhRKzTWBA
         jix9trd26PxfXVEBdHNDv6Ew0By+m42Z1HKms0IVIeTI6b0bkzUEPmSKkJ4Kx85VNS5e
         NGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=GTf+1EpY6JStEJhVUzLt7wdTH2UAsJxs2Qprj1UXr8w=;
        b=C5DQIpRVCWtFm8OYcLLNycPyOTXhojYO7YGpVfAsHuy3qeq+v2przzkszLQ0n2MZtw
         JpseIWiSjBI+Kii8E2n5aG/C80/NoZaU6pbCr3D6YqqGM9j+/mBSJXK2EB6sGDc2yg2z
         IVW/O1onnyoZcQzKHHJu4PFxoJPiQCsPnRRCVxZmdMz/eLAbpXlh1XTq/bQsVMfki2Bi
         NM1p27pWhmT6SN4zZRYHtF1U0bbtGMh1Aa0GzlOgPHqkeoCnZ8Kxatm/kcMiBnESY0p/
         UMvEufKC6gEJzskWol31OQWegXWBrSX1pZ6tHF0JhZaeYB9Ub8NXI7YsndK0OYklBsde
         h1gw==
X-Gm-Message-State: AJIora9BrntJp6xOb+uiMOW8KR6wGOK8BP9s8bVmvhvjB0KAQeQ9LAtn
        0+Lj8CdMzpbQ/ViCR6GLHSomcA==
X-Google-Smtp-Source: AGRyM1sCdWg/g7b5u7199UKjl1f4c99tdgJSVyehh3v1/71400rY80K2fHyGPWzZKjxGptVxhwdmUQ==
X-Received: by 2002:a37:4549:0:b0:69f:556c:4e38 with SMTP id s70-20020a374549000000b0069f556c4e38mr20038724qka.202.1655823376859;
        Tue, 21 Jun 2022 07:56:16 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a2a0c00b006a726b03ad1sm15028164qkp.52.2022.06.21.07.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:56:16 -0700 (PDT)
Message-ID: <32c3750a59eb6a4f8371a9b3349d4c285c809922.camel@ndufresne.ca>
Subject: Re: [PATCH v4, 0/3] add h264 decoder driver for mt8186
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Tue, 21 Jun 2022 10:56:14 -0400
In-Reply-To: <2ebaa25205d651b2f6a62e3a02c0ccab5199a165.camel@mediatek.com>
References: <20220512034620.30500-1-yunfei.dong@mediatek.com>
         <edbb4605c9e30329d2f5a4ff738571acb6b91f1f.camel@ndufresne.ca>
         <2ebaa25205d651b2f6a62e3a02c0ccab5199a165.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 15 juin 2022 =C3=A0 19:37 +0800, yunfei.dong@mediatek.com a =C3=
=A9crit=C2=A0:
> Hi Nicolas,
>=20
> Thanks for your comments.
> On Mon, 2022-06-13 at 16:10 -0400, Nicolas Dufresne wrote:
> > >=20
>=20
> > Le jeudi 12 mai 2022 =C3=A0 11:46 +0800, Yunfei Dong a =C3=A9crit :
> > > Firstly, add mt8186 compatible and private data, then add document
> > > for
> > > compatible "mediatek,mt8186-vcodec-dec". For mt8186 is single core
> > > architecture, need to add new interface for h264 hardware decoder.
> >=20
> > Would be nice to take the habit of sharing fluster score for this new
> > HW, I
> > would expect no less then what the numbers you'd get from running
> > over MT8195 or
> > 92, remains nice to demonstrate that this was tested and document any
> > oops along
> > the way.
> For we don't setup mt8186 fluster test environment. So not to run
> fluster in mt8186. According to our plan, we will do fluster test for
> every project begin from mt8188.
>=20
> When I'm free, we continue to setup the fluster test environment for
> mt8186.

I may be able to help here then if needed. Just let me know. Meanwhile, it =
seems
a bit early to consider merging these patches as they seems to lack the lev=
el of
testing we'd normally expect for non-staging driver changes.

regards,
Nicolas

>=20
> Thanks,
> Yunfei Dong
> > > Patche 1 add mt8186 compatible and private data.
> > > Patche 2 add mt8186 compatible document.
> > > Patche 3 add h264 single core driver.
> > > ---
> > > This patch depends on "support for MT8192 decoder"[1]
> > >=20
> > > [1] =20
> > > https://patchwork.kernel.org/project/linux-mediatek/cover/20220512021=
950.29087-1-yunfei.dong@mediatek.com/
> > > ---
> > > changed with v3:
> > > - fix __iomem not reasonable, align share memory to dram.
> > > changed with v2:
> > > - fix sparse and smatch check fail for patch 3
> > > changed with v1:
> > > - rebase driver to the latest media_stage.
> > > ---
> > > Yunfei Dong (3):
> > >   dt-bindings: media: mediatek: vcodec: Adds decoder dt-bindings
> > > for
> > >     mt8186
> > >   media: mediatek: vcodec: Support MT8186
> > >   media: mediatek: vcodec: add h264 decoder driver for mt8186
> > >=20
> > >  .../media/mediatek,vcodec-subdev-decoder.yaml |   4 +-
> > >  .../platform/mediatek/vcodec/mtk_vcodec_dec.h |   1 +
> > >  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   4 +
> > >  .../vcodec/mtk_vcodec_dec_stateless.c         |  19 ++
> > >  .../vcodec/vdec/vdec_h264_req_multi_if.c      | 177
> > > +++++++++++++++++-
> > >  5 files changed, 203 insertions(+), 2 deletions(-)
> > >=20
> >=20
> >=20
>=20

