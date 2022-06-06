Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC77253E602
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbiFFOtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbiFFOtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:49:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB96D866
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:49:12 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a23so16023470ljd.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9gSJdumX788ea5ymBPhF6Qx4oKS3kXqxz2HGbJIL4Q=;
        b=NDhxYiHFP2DQ/Hg/9TucNlDLLMsU/ntXpeN0g2X8O+A2BUihfdLVBLLH7RWDprBeHQ
         YwaJrLW49qHLVTYYoKNvynnJ3jb79kiSyxeSMy2uxFQjXwG+gVg48vktfIa85w7hKfQ1
         g4jx4e8LsxUAl7JSRLIBkVIW6BW0V9jVja/Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9gSJdumX788ea5ymBPhF6Qx4oKS3kXqxz2HGbJIL4Q=;
        b=UGzLpemT4v1Gvd9dQDgaerSujJz82DWwNn9ufpbgbjUm6R4hYcDXN1oQp4PDH3055P
         pw+1MpQDNdszbLqOK3mQ31z3Ue6m1PFQHQygXVLfb7YpJrWhDBOKcrMNduMRuElGkP5L
         4Wf4lclb5YqxP6oMxctdcBWw7YuttQF6uwtOy0ySsR1ruDrsLBjvXKjy43VHhdKoJ/B2
         t9KeBFOMVs/raVMgn/HMdS7EhTyXg1zTXFBRlv/0SVZe/eEbo6/5MO/Tcxza4ma7aBwV
         Hyg193EuOoU7y7PHuBPa7FF0Yb78qpa8LQ453YKfQiY1L4l3ce0jSwyGULNtlCVvP2/5
         qrJQ==
X-Gm-Message-State: AOAM533iTdW0Vmw3G5Yiq+QujK71t/Ax0HH5Wiz1Nk6ZN+gyRZAE+v4a
        AWqebAovNhDSdrTXepWjcBACdj9yh82F19uBIF8=
X-Google-Smtp-Source: ABdhPJy8yTQ/X3yTlwDvDnZGAnXt39UDSHBJ4Fq4pYy5pdfeK2f9AdIHgteCUSw6AIEOggEAs2cb5g==
X-Received: by 2002:a2e:890b:0:b0:255:5f1c:8958 with SMTP id d11-20020a2e890b000000b002555f1c8958mr17359984lji.134.1654526950209;
        Mon, 06 Jun 2022 07:49:10 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i27-20020ac25b5b000000b00478ebc6be69sm735486lfp.261.2022.06.06.07.49.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:49:09 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id y15so10617418ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:49:09 -0700 (PDT)
X-Received: by 2002:a05:6000:1685:b0:218:45f0:5be6 with SMTP id
 y5-20020a056000168500b0021845f05be6mr2533347wrd.301.1654525406801; Mon, 06
 Jun 2022 07:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220606044720.945964-1-hsinyi@chromium.org> <20220606044720.945964-8-hsinyi@chromium.org>
In-Reply-To: <20220606044720.945964-8-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 07:23:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7EiaYgzr57geyeqEafLJ67G2PJa8ejZwgWNV+icD0RQ@mail.gmail.com>
Message-ID: <CAD=FV=V7EiaYgzr57geyeqEafLJ67G2PJa8ejZwgWNV+icD0RQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] drm/panel: elida-kd35t133: Implement
 .get_orientation callback
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 5, 2022 at 9:47 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> v2->v3: add comments for notice.
> ---
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
