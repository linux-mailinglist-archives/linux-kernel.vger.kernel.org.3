Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9A157C04F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiGTWvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiGTWvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:51:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB7133E39
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:51:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sz17so100418ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xtJOydR/EOQiDwYXa/x4r5uSnbSPUKnC9SXoK7SwIus=;
        b=JXYOeZ0kA3+i7MNhIuCn5Wb24GcLkYwIYt7IIms7VAQzB0elQZha+S5+kbGHJJGhGq
         pQ91RGDS9Qe0RAtZFi8FLvlu14jX1pL0pjvSRF7cCCCReIiDsc5G3F/+P6KoGQL8r03q
         rX3v/3M9d0B9Hz7yU9b99kd1CV2V+tf4lK37I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xtJOydR/EOQiDwYXa/x4r5uSnbSPUKnC9SXoK7SwIus=;
        b=Bgb68wzdsE+hTIJTWNdTw56CfEboDf38f92O7eQTLLsaRByN3lAmBrbL6P8FAqrIt4
         2H+/OggvgBqQA48oKDrUvaMNJY3fxbyRnTHO/fqaj9LkeBPHIb98Y2LewxE3A5topqwY
         HPmuv1Ds0cnnGVWiluNHoCm34t0HzLH9ePQhfJkz8Ilo92H8A9caq+/nBXWuQnOMaIZs
         lVczO1guXboZCX7V+y2WtC/1Wrrjhy2S5SK61mDhngsflKkYShbxIjoXXIbel20e1S6y
         GCvudkfgmNbwfjOvAT+I8mm08C3SV09wqh/qTwXHAcXp2eNVhzQzf9zYATvtcMSm+5Jq
         c7WA==
X-Gm-Message-State: AJIora9fOxb24vR/YU5fJo0qSEzapu6MY6rJH2VELcpTqN3C27K130BA
        ZGZYFsQ8h8/jpO61dgYfkMUOYxrvtJu/uTaP
X-Google-Smtp-Source: AGRyM1vlLnPqNnqTwlDay+rzUem/6AvIc6Cfqlh5L18l2Jq7My/lfNWafbXRZ3I3xy+5CqmbhWk10w==
X-Received: by 2002:a17:906:9b86:b0:6f8:24e7:af7d with SMTP id dd6-20020a1709069b8600b006f824e7af7dmr38352403ejc.295.1658357488833;
        Wed, 20 Jul 2022 15:51:28 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id f6-20020a05640214c600b0043a6df72c11sm123845edx.63.2022.07.20.15.51.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 15:51:27 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id v5so96650wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:51:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4e86:b0:3a3:2edc:bcb4 with SMTP id
 f6-20020a05600c4e8600b003a32edcbcb4mr995134wmq.85.1658357487010; Wed, 20 Jul
 2022 15:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220720191158.1590833-1-nfraprado@collabora.com>
In-Reply-To: <20220720191158.1590833-1-nfraprado@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Jul 2022 15:51:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UbXus=BBaEEP390ivdB3VsMVV_Kpz8hrADrt8qkvzMGA@mail.gmail.com>
Message-ID: <CAD=FV=UbXus=BBaEEP390ivdB3VsMVV_Kpz8hrADrt8qkvzMGA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add panel entry for B120XAN01.0
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 20, 2022 at 12:12 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Add panel identification entry for the AUO B120XAN01.0 (product ID:
> 0x1062) panel.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
> v1: https://lore.kernel.org/all/20220719203857.1488831-3-nfraprado@collab=
ora.com
>
> Changes in v2:
> - Move entry to the top so it respects the sorting
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


Nothing controversial here, so I went ahead and pushed to drm-misc-next:

b68735e8ef58 drm/panel-edp: Add panel entry for B120XAN01.0

-Doug
