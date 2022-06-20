Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69FC551121
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiFTHNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiFTHNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:13:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03129E039
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:13:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c13so9303196eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZxNhueMBF9WoNcsQRrgiB02jKYBhNhqYGBvBdIMT/o=;
        b=fy3dwtBDvc791ioyRN1572SmjL/QCaIVbg2+MyM1rCFfoafQv0OE0oBW1d4YrWIIi3
         DIrhnywVf88jJaKxiRQGAN/hGXKMSYTj4hhcL6B1cMYP7QofkT5dyPwudtEpoWiedZkf
         vKInpa/OhzZib4wmyfrDVCwTf9f6YX67mE25E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZxNhueMBF9WoNcsQRrgiB02jKYBhNhqYGBvBdIMT/o=;
        b=XG6H0/aeygqmKdr57mpLbjYArWiOFIqmYhkU6XW6WvambpA8zljbzguMEQc3BcmlwL
         V/w3FUV32xgUjHoy4uJZsOQN7ICTZRMatmIa5JqymjNWNCVsRQrIZ5pXQZv9Q0EwlRno
         3TJdl/xieEDb7/CvpOec4GeAykXtwNYIBmHtvkYoURXt+DXuU+D85bAsGfUKVKj28RFZ
         BA1EOlMYKDni39tcOg6QmWK/OsGUf/XWQ2gf5w6Y6cBwNkpccqCjRJmPXQR/QC5vkFxR
         QelaHnHzHckkKWpC0S20Ix59xh/PSjzBILzlLMwp5vq4hqLOr2/NQRzcBMZzt3EADnfl
         vsng==
X-Gm-Message-State: AJIora+IjzJ76TCGVYptwiEiFHWrS3kvhcya+Vo+V7JRf4OodKje04Xx
        egKrpIE/H7iCjdli/9A/cZduTVL7ewt3VauuP9fKpDxqeyg=
X-Google-Smtp-Source: AGRyM1sL5dIl8AH46jNJrBl/TTzwbPT5YrA248QQiwP24rFmBUawcT2ZGIJ6uCWt77gKUpazkmOZ3P3/igx2WCEym9c=
X-Received: by 2002:aa7:d6c9:0:b0:435:6698:589a with SMTP id
 x9-20020aa7d6c9000000b004356698589amr17234634edr.59.1655709199702; Mon, 20
 Jun 2022 00:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220617072521.21551-1-yunfei.dong@mediatek.com>
In-Reply-To: <20220617072521.21551-1-yunfei.dong@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 20 Jun 2022 15:13:08 +0800
Message-ID: <CAGXv+5GG1rKsECDotA_RpXay1i7ido+te1=CbX0d21638=+Z2A@mail.gmail.com>
Subject: Re: [PATCH, v2] media: mediatek: vcodec: Fix non subdev architecture
 open power fail
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Irui Wang <irui.wang@mediatek.com>,
        George Sun <george.sun@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 3:25 PM Yunfei Dong <yunfei.dong@mediatek.com> wrote:
>
> According to subdev_bitmap bit value to open hardware power, need to
> set subdev_bitmap value for non subdev architecture.
>
> Fixes: c05bada35f01 ("media: mtk-vcodec: Add to support multi hardware decode")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8183 on next-20220617. This makes the hardware operate correctly.
Previously it kept timing out, presumably because the hardware wasn't
properly enabled.
