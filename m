Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733F754B7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiFNRqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiFNRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:46:11 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5840929
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:46:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id k4so6633991qth.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Xn5U6yTCivKcEB2CQHYVzvugp+BfiT1C9G92C8VTcFE=;
        b=613RfUCkNkGQMLtU7V2MbO04fhnH0mtvC5dKJO2n7m5TCcstyJMNMqLu5YY/jKx85W
         WqQMLAi27pfXea2pgAxcenjo+QPeoTl9CYin1epFcZK/vTqiQCqBD1EYkVVK5uDXlJOk
         /REj65VNDa+2mfoDGydpq55FH9UXhemjGynB7O4/KvsjpjTKj3iXzE5se/WNWb3HwcDQ
         Qm8tyvsIiyWLkoQC0YSKGsXgM6jbVZQWXTcSfHhc7xpqFpsgqnP3lP5KbJsA0tnl+2AB
         IlaRWg/QdubW8ftDo3KKzJL3UuG4GA8jNRl6v8rVtjb0Mt6ik6HtmbEE25xxiVEQixz1
         wZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Xn5U6yTCivKcEB2CQHYVzvugp+BfiT1C9G92C8VTcFE=;
        b=qOeA4eGnC8ZlvRIGu9LgFbAoS5mAOzSwT07KX4FEO+wfHkPll4YfAZsbub1mlKzco7
         hhRh6YtvRW3JL5e4WIjFPp/k8z0Wnlkcuohv3gFJPX47ugO7WBGVF2rK5/NEqkFV6aht
         4N/tsuULn8FtA3UsSznaIBk6pfZ403mQvVF1sSe9kvpx209zH37dry4ZSKWFKEX3YG04
         uPU+6sDSvH51Co7STTZbcgp0YMjbQj8XaU29l7TWY9vvV8cBRp0iSZ4H4El+GSt+PU8c
         wOe1k8SXDIRGZO4dG7y2MmhRDb5x/hudk08Dwv1fG+WtE2dCAzsCGTBjcK04qS55e7dF
         dHAA==
X-Gm-Message-State: AOAM5300C+8vTPZnjDol77BuoEDny8+yL7oxHUyFZKstwOuU/DLqitYw
        cs260Q6y3EDWBSpXjGiCqUz3Jw==
X-Google-Smtp-Source: ABdhPJyz6Dah76Tro/nBusft/e8MUMRJGJMekMTnnVzKmUelFUurRZI3FxaqFWMN0HWssy5n6ZNO1g==
X-Received: by 2002:ac8:5a42:0:b0:305:222b:8ec9 with SMTP id o2-20020ac85a42000000b00305222b8ec9mr5296612qta.214.1655228768303;
        Tue, 14 Jun 2022 10:46:08 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id q12-20020a05622a030c00b00304dd83a9b1sm8255216qtw.82.2022.06.14.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:46:07 -0700 (PDT)
Message-ID: <5316234cef174e49110f949991ef71c578a3478e.camel@ndufresne.ca>
Subject: Re: [PATCH v4, 0/3] add h264 decoder driver for mt8186
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
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
Date:   Tue, 14 Jun 2022 13:46:06 -0400
In-Reply-To: <edbb4605c9e30329d2f5a4ff738571acb6b91f1f.camel@ndufresne.ca>
References: <20220512034620.30500-1-yunfei.dong@mediatek.com>
         <edbb4605c9e30329d2f5a4ff738571acb6b91f1f.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 13 juin 2022 =C3=A0 16:10 -0400, Nicolas Dufresne a =C3=A9crit=C2=
=A0:
> Le jeudi 12 mai 2022 =C3=A0 11:46 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> > Firstly, add mt8186 compatible and private data, then add document for
> > compatible "mediatek,mt8186-vcodec-dec". For mt8186 is single core
> > architecture, need to add new interface for h264 hardware decoder.
>=20
> Would be nice to take the habit of sharing fluster score for this new HW,=
 I
> would expect no less then what the numbers you'd get from running over MT=
8195 or
> 92, remains nice to demonstrate that this was tested and document any oop=
s along
> the way.
> >=20
> > Patche 1 add mt8186 compatible and private data.
> > Patche 2 add mt8186 compatible document.
> > Patche 3 add h264 single core driver.
> > ---
> > This patch depends on "support for MT8192 decoder"[1]
> >=20
> > [1]  https://patchwork.kernel.org/project/linux-mediatek/cover/20220512=
021950.29087-1-yunfei.dong@mediatek.com/

I forgot earlier, but I suppose this will also depends on an scp.img firmwa=
re ?
If so, any linux-firmware submission to link to ?

> > ---
> > changed with v3:
> > - fix __iomem not reasonable, align share memory to dram.
> > changed with v2:
> > - fix sparse and smatch check fail for patch 3
> > changed with v1:
> > - rebase driver to the latest media_stage.
> > ---
> > Yunfei Dong (3):
> >   dt-bindings: media: mediatek: vcodec: Adds decoder dt-bindings for
> >     mt8186
> >   media: mediatek: vcodec: Support MT8186
> >   media: mediatek: vcodec: add h264 decoder driver for mt8186
> >=20
> >  .../media/mediatek,vcodec-subdev-decoder.yaml |   4 +-
> >  .../platform/mediatek/vcodec/mtk_vcodec_dec.h |   1 +
> >  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   4 +
> >  .../vcodec/mtk_vcodec_dec_stateless.c         |  19 ++
> >  .../vcodec/vdec/vdec_h264_req_multi_if.c      | 177 +++++++++++++++++-
> >  5 files changed, 203 insertions(+), 2 deletions(-)
> >=20
>=20

