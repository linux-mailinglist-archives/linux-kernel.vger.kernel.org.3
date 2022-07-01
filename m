Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8270D56341D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiGANKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiGANK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:10:28 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D1443D0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:10:20 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g4so3945508ybg.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=93Mj4Iau0zpmP/JMwi/VFSHRM8pmBMuEnMbb4W4iqXI=;
        b=UUCeOLLSa8JxepsV6kbA1FCpTxZVNNOcRM6cLxnQj7WL62ivtMfBPCez7Gpugi+NdL
         VmxfTuKRVEf4VR4Wc6uhRq6c1ihOtEZ/3LpSNAXvMDWX6p6PoyUu2ZPGap3qBomly4UR
         f5rPFPHk6kFebaxaGoDQHMzC8gVIcG9TkQOLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=93Mj4Iau0zpmP/JMwi/VFSHRM8pmBMuEnMbb4W4iqXI=;
        b=uGhR//XnAdrBgoROhdl5KsMZiYXZNjK73KTE+EDYwbjEbJWa+gy7Q7hitaDIJLNV5P
         dpckL4dGrtrKLuESqn473P6XsZY2W216597lK5qPa3mOqcZPQKnNtB3JV4aawW3QGO8l
         MK0SX77FvIcAUrK0gMGLwXhEVvSV32L72YrhNvfbS1elNIW6PrAvq8SuBGTGTf7vS6Sv
         DhuhvoywL9KvTxT9k9nAOp81RvcFTxUo6nuDln2A9NKuOoU+S2R5Hb3SfmbyqzjjNlRg
         xJEQFzkd/44Yz2ptb5PURQ09ic0BTL6NFQt5RCuh0GvT6QmQaCPhuhNAZXJOsmCx9H0e
         XnDQ==
X-Gm-Message-State: AJIora+LscT2jE/uVpaNi7tMiRNZ+d4llSXZmboxlxB8EhqjkpaBi706
        Gzk9aLhKPk9dFhsMxAsDOY3j/GP+h79lZHW2gbJVew==
X-Google-Smtp-Source: AGRyM1uWKenMTsIZlQbeXynKt3mVEKH67yHcrh73gv2A0rWP5WfpVj+e/Wz0OfAPf2Dh6QAOgEjdx2kaTlA2uoioq8s=
X-Received: by 2002:a25:81c5:0:b0:66d:55b5:d250 with SMTP id
 n5-20020a2581c5000000b0066d55b5d250mr14906967ybm.501.1656681019536; Fri, 01
 Jul 2022 06:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220701105237.932332-1-wenst@chromium.org> <e601a375-cc80-40cd-9791-e44e9d37cec0@email.android.com>
In-Reply-To: <e601a375-cc80-40cd-9791-e44e9d37cec0@email.android.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Jul 2022 21:10:08 +0800
Message-ID: <CAGXv+5Hrc6RageAu1YMBCA22r0kz+-C+9qO=qdDEmn_QhSCB3w@mail.gmail.com>
Subject: Re: [PATCH 0/6] media: mediatek-vcodec: Fix capability fields again
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 8:45 PM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> Hi Chen,
>
> Le 1 juill. 2022 06 h 52, Chen-Yu Tsai <wenst@chromium.org> a =C3=A9crit =
:
>
> Hi everyone,
>
> The previous round of changes to the mtk-vcodec driver's returned
> capabilities caused some issues for ChromeOS. In particular, the
> ChromeOS stateless video decoder uses the "Driver Name" field to
> match a video device to its media device. As the field was only
> changed for the video device and not the media device, a match
> could no longer be found.
>
>
> This match is not specified in the spec. If you feel like it should, perh=
aps consider specifying it first. To me it's nice if they match, but it's f=
or now just cosmetic.

Right. Even for cosmetic reasons I think my changes make sense though.
Fixing the matching is another thing.

> Though this requires some discussion, as userland is expected to enumerat=
e the media device and find the video device by walking the topology. This =
is the only specified way to match both.

AFAICT, v4l2-ctl does similar matching, though by bus_info. Maybe it's
out of convenience?

ChenYu

>
>
> While fixing this, I found that the current info used for the fields
> don't make a lot of sense, and tried to fix them in this series.
>
> Patch 1 reverts the driver name field change. It also makes it
> explicit that the field really should match the driver name.
>
> Patch 2 changes the value for the card name, making it a free form
> string that includes the SoC model.
>
> Patch 3 removes setting the bus_info field, instead using the default
> value derived from the underlying |struct device| as set by the V4L2
> core.
>
> Patches 4 through 6 do the same as 1 through 3 respectively, but for
> the encoder side.
>
> This series is based on next-20220701, and was tested on mainline on
> MT8183 Juniper, and on ChromeOS v5.10, on which we have a whole bunch
> of backports pending, on MT8195 Tomato.
>
> Please have a look.
>
>
> Thanks
> ChenYu
>
> Chen-Yu Tsai (6):
>   media: mediatek: vcodec: Revert driver name change in decoder
>     capabilities
>   media: mediatek: vcodec: Use meaningful decoder card name including
>     chip name
>   media: mediatek: vcodec: Use default bus_info for decoder capability
>   media: mediatek: vcodec: Revert driver name change in encoder
>     capabilities
>   media: mediatek: vcodec: Use meaningful encoder card name including
>     chip name
>   media: mediatek: vcodec: Use default bus_info for encoder capability
>
> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 7 ++++---
> drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 1 +
> drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 7 ++++---
> 3 files changed, 9 insertions(+), 6 deletions(-)
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
>
