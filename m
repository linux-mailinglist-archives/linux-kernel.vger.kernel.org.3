Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5059550F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiFTEyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 00:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiFTEy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:54:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B394DEB9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:54:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o9so4176538edt.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mukyLCtBBbCJ6QLdWGYeYZEZ9YqINwpy/ZdfkORqBZE=;
        b=UKNKFhdL+7ivgne6rJC21mSSfiaLKZHX9yoOuIh9UmqiDzzaewQHD7yYJipRMbN5SI
         sqMO9Scex5fT2OG4s3idcHiBshzVzr83BQRiz9MclD5AgLHLh9ef6R0EaL7PWErhcE/g
         wKYAz5furNCnzUMXK/fAv/VmQ0Psdwl6aMHDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mukyLCtBBbCJ6QLdWGYeYZEZ9YqINwpy/ZdfkORqBZE=;
        b=rV8bNXRJ3SldOTaVGr8lrGbVd8u+H0bM5oAILNthNsJVSGmxlIDIZuTAIFmUO5LYLJ
         dkn0F4pqVaMe3Z8PSZ2lZ2VR7mhYFOFiT0UD/GQNFAhNziAQVgwIH8mhRhD+yVprnev1
         JUrVenWQVUWt5I397rpFjfHumbkd9IFi/Y+uOKQxgicUFM/awRimkt1zbAKtE1COLcMg
         7WXb6CLvZ/JVQAQ7W+vZg7BvMZHz6w1nfUBEz99TMj1W1YVhvqPUsOAulFQWK9QJWxPi
         FvspZTh9Z+K1x9C/GvjqXbbAcHymRJdhLx5QFzVphe29tRhP7mkj6lZEtmtIgAolkGwi
         RLlA==
X-Gm-Message-State: AJIora+bQTrMHmVpxwObv5XQq+AyI/yFvPOhZmKADZverMDSH8zF1Lkn
        bKwByfRTyHJ2HiL9aeiI++4EjlKXZDHS03FsvXnseA==
X-Google-Smtp-Source: AGRyM1uRThNT8XmE57SQVNixL8TMkzT1S2u9lzIBzMfvygATaLlCkuFrLWUz2Cy72NYhPuNYT7dU009axLMuI9/ox2A=
X-Received: by 2002:a05:6402:3785:b0:435:5d0e:2a2e with SMTP id
 et5-20020a056402378500b004355d0e2a2emr19724945edb.307.1655700863894; Sun, 19
 Jun 2022 21:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220618072929.28783-1-yunfei.dong@mediatek.com>
In-Reply-To: <20220618072929.28783-1-yunfei.dong@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 20 Jun 2022 12:54:12 +0800
Message-ID: <CAGXv+5EFkZ6-bvu68dV4hr795+N3tAwbXYg5WCJp+Zd+pf1Aqw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 3:29 PM Yunfei Dong <yunfei.dong@mediatek.com> wrote:
>
> Need to get dec_capability from scp first, then initialize decoder
> supported format and other parameters according to dec_capability value.
>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Tested on MT8183 on mainline 20220617-next with the vcodec-dec DT node
copied from the ChromeOS v5.10 kernel.

This fixes an issue where the first attempt to enumerate formats on the
device right after boot returns an empty list.
