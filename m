Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A93C550FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiFTFZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTFZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:25:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B18DF2B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:25:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd6so10735227edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTyxMGysFvLVjw1ty4gwMbVdKBXhcL1xQssE1M7jQRs=;
        b=hr/i+COcpVsTSVEVRXmn8BToF7wohakO0101jRn9kRrjM38xXFv36ueZmUYFeF7tMs
         MhQf0KBvD+ufRlJDSD8p+HhwOg1IatNHX5ROaL5G3WIA4Bc/XVrN1sotSR3iUwscYf9w
         zs6/fyN9LhYXinNOiVjFzKY1HepGVgu2Gb5jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTyxMGysFvLVjw1ty4gwMbVdKBXhcL1xQssE1M7jQRs=;
        b=cSM/KV3RB/lcLRB09eMgpHbhfMzvDqOygzmZgrkDCXR1GgVBUC/aTgqsLQGx0FuQ/9
         8bUzTsI1hiCNrHTciooeqYsjGoEh96i7QyUh0CyktZLd7sYh0gWYR5H7/AxqYRoX+laG
         4tH/iAg+x72md3O8aYJ2tWyD0C0YCsLBxUyKWbpkc2I3fg92fG9m7cWhaP8qjHAQbX9h
         rXxwO3VtQRT8JMQ5BDjvk3hHBuTbsia4b3Rv39CAelR1fxtQPfP7yzR5RMbzsV8JlS64
         dgb9U/bYwHd5AqfR9YsoSA+u/Nlx0X3akkdOVyhctmcSctrpTW6PzZG2L/YhwSTR2ZNK
         Ngsw==
X-Gm-Message-State: AJIora/hdd2ZX8HbOf24AZ7qLQjsWfe4eGiYMML+mDyp4fbEmhg+Wzx8
        ruJ3owOP5Bzs6uAspXzD3UhmbzptzkB1nD7Be5fbKg==
X-Google-Smtp-Source: AGRyM1ve6GEVbjnEdneKcnH6buKWIMD7xtxtHnE/K2tR9nDrr6cM5g2g7pzOhyL1GqvCL7sj+U4/HpOoO6q4bsSD2TU=
X-Received: by 2002:a05:6402:4303:b0:435:833a:16ed with SMTP id
 m3-20020a056402430300b00435833a16edmr2517462edc.248.1655702733588; Sun, 19
 Jun 2022 22:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220618072929.28783-1-yunfei.dong@mediatek.com> <CAGXv+5EFkZ6-bvu68dV4hr795+N3tAwbXYg5WCJp+Zd+pf1Aqw@mail.gmail.com>
In-Reply-To: <CAGXv+5EFkZ6-bvu68dV4hr795+N3tAwbXYg5WCJp+Zd+pf1Aqw@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 20 Jun 2022 13:25:22 +0800
Message-ID: <CAGXv+5E2wULkB7_u_H7jFAi6Jk2AvUcfOJdzOp_5m2b4n3shww@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Initialize decoder parameters
 after getting dec_capability
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 12:54 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Sat, Jun 18, 2022 at 3:29 PM Yunfei Dong <yunfei.dong@mediatek.com> wrote:
> >
> > Need to get dec_capability from scp first, then initialize decoder
> > supported format and other parameters according to dec_capability value.
> >
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Tested on MT8183 on mainline 20220617-next with the vcodec-dec DT node
> copied from the ChromeOS v5.10 kernel.
>
> This fixes an issue where the first attempt to enumerate formats on the
> device right after boot returns an empty list.

BTW, this should have a Fixes tag.

Either

Fixes: 7a7ae26fd458 ("media: mediatek: vcodec: support stateless VP8 decoding")

which looks like the first instance of when firmware capability really is
considered, or

Fixes: fd00d90330d1 ("media: mtk-vcodec: vdec: move stateful ops into
their own file")

which matches when ctx->dev->vdec_pdata->init_vdec_params(ctx) was first added.


ChenYu
