Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3624C4AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbiBYQbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiBYQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:31:02 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141131D86D4;
        Fri, 25 Feb 2022 08:30:30 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so6880199ooi.2;
        Fri, 25 Feb 2022 08:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1wkrFjytm/bfyZ688DRYD5WIyjqQECAVw3q7pHsvHsw=;
        b=MllEvRIEOPpQjMAQkTCnf0JgePCze6KRNgyFbRr394q0l3s0UEP2pSg2E9jlfSg2m4
         B+wOcO31J+JXtBpoNYgJH8ggZtfhdkzxAl/IeLGHkjCTXfHxB1z8GaUKxQnAtnqXs7RT
         HIyHJlqyYcCNwvtswUGQLcdCYXk/LvsKhNzwykJPkLKV9rlgDkatG+BohTKZYqc5r/dd
         vfCnOzW+kdpK4oFLPJeWD4Fll+2a9j/iZbIGEBInohIXF9cacoLsD3vB11MiMM2aTCP4
         HO5EvSEa7eJL7Rna0QS4h1SXMnWXooyLXpTbaGSQWmS2G6ROlxZGtuJtUwBGxCjyDa9T
         9ukw==
X-Gm-Message-State: AOAM532RrZAYV10YSJNrpYoYknp5NhSzxoUvG/QBDHLf1fbaA9BecS62
        UJSklaPvypQCSmupTymNvw==
X-Google-Smtp-Source: ABdhPJxHnQhONryFwpvuU3O9cL+TRRiq/RY06mE2+ZgOVfuaaBUkDTiEOsd6KQFZQO00sR87pj5RBQ==
X-Received: by 2002:a05:6870:a552:b0:b5:6c53:b96b with SMTP id p18-20020a056870a55200b000b56c53b96bmr1705102oal.124.1645806629409;
        Fri, 25 Feb 2022 08:30:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l20-20020a056820031400b0031cf5913126sm1241648ooe.36.2022.02.25.08.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:30:28 -0800 (PST)
Received: (nullmailer pid 1045540 invoked by uid 1000);
        Fri, 25 Feb 2022 16:30:26 -0000
Date:   Fri, 25 Feb 2022 10:30:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Fritz Koenig <frkoenig@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-media@vger.kernel.org,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Irui Wang <irui.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        srv_heupstream@mediatek.com, George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        linux-mediatek@lists.infradead.org, Tomasz Figa <tfiga@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3, 1/7] dt-bindings: media: mtk-vcodec: Adds decoder
 dt-bindings for lat soc
Message-ID: <YhkEIr/Jlky+5CZY@robh.at.kernel.org>
References: <20220217075758.11369-1-yunfei.dong@mediatek.com>
 <20220217075758.11369-2-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217075758.11369-2-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 15:57:52 +0800, Yunfei Dong wrote:
> Adds decoder dt-bindings for compatible "mediatek,mtk-vcodec-lat-soc".
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 51 +++++++++++++------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
