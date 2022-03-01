Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4464C873A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiCAI6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiCAI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:58:53 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13BE193CB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:58:12 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id d19so17690920ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEgk5klulcAQEghurpTaOMAs7TAwp8sfPglSxNFGlqA=;
        b=XG3qL7R9Ks1hhuMdeycjwObyDGh7unBtQw4SOHVvhjCMmZbQLmvyhn2q299/2DVNB0
         +ZRKx4BcoarPhhRVBGhhSFwXoMr37NYJXq1wxB6JC24A03KR01FX5p6aRy7Dc6OTbPtc
         rkJUWjpPVJQk7B/qZTXiZjEbfIh/fHRj+HGhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEgk5klulcAQEghurpTaOMAs7TAwp8sfPglSxNFGlqA=;
        b=6S2mVm/yHhgKzhmOVtbmfhcKe+0arIqMIGxP3sNH5o0Q3ocxlho+532Nnw8qeS3lNp
         Af0OBpW7S46wcFEEkIMVVuDRsvduyAcRqGTr7HRGx0WlJpg5uEQXfUiDu8rz9P0YsLyp
         +MWC/HCAEZHjL4GMfA7mzb4Vez21sYLhMh8x5UuDxP7cNw81wF8I/YU5WJ50fM25hO1e
         yyRww9GHJ73HXJgSNlt4lAgcfBTyhaqPk9sQP30xZFAK8CQSxdVhHGnotKY6neOTJOiQ
         MtAW3aDFW6g66EL8wHhS61UdITW//jGowq+5g8Q8CDCEFCXxBbus2pjSKShbo7NKEQBw
         +Fdw==
X-Gm-Message-State: AOAM533Uwcjq1mEqDfZBwWzouzfpQSOabozcbyUlh5lN4vSeVfQNSN3U
        lASgGPd4su5xVX1ebkqNN52u+YL0mZTyPHhQtVCDeHbTQac=
X-Google-Smtp-Source: ABdhPJwtjuUQyAbuRtHNGo/QfWRipdcVv450+DMXtNuMsDTCVePqpvJvDKSlueJ7dF0rExgYurnYzBUL+lnobGEkL64=
X-Received: by 2002:a02:2a0d:0:b0:317:380f:8fce with SMTP id
 w13-20020a022a0d000000b00317380f8fcemr6816591jaw.205.1646125092097; Tue, 01
 Mar 2022 00:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20220217082224.1823916-1-hsinyi@chromium.org> <20220217083119.GA3781632@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220217083119.GA3781632@anxtwsw-Precision-3640-Tower>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 1 Mar 2022 16:57:45 +0800
Message-ID: <CAJMQK-gDDtPT-kM56WodE=eo1UAZShbshLsuy_o-YuhorFe8mw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: Clear the DP_AUX_I2C_MOT bit passed in aux
 read command.
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 4:31 PM Xin Ji <xji@analogixsemi.com> wrote:
>
> On Thu, Feb 17, 2022 at 04:22:25PM +0800, Hsin-Yi Wang wrote:
> > If the previous transfer didn't end with a command without DP_AUX_I2C_MOT,
> > the next read trasnfer will miss the first byte. But if the command in
> > previous transfer is requested with length 0, it's a no-op to anx7625
> > since it can't process this command. anx7625 requires the last command
> > to be read command with length > 0.
> >
> > It's observed that if we clear the DP_AUX_I2C_MOT in read transfer, we
> > can still get correct data. Clear the read commands with DP_AUX_I2C_MOT
> > bit to fix this issue.
>
> Hi Hsin-Yi, thanks for the patch!
>
> Reviewed-by: Xin Ji <xji@analogixsemi.com>
>
> Thanks,
> Xin

Hi Robert,

Kindly ping on this fix. Thanks.

> >
> > Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through aux channel")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v1->v2: Offline discussed with Xin Ji, it's better to clear the bit on
> > read commands only.
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 633618bafd75d3..2805e9bed2c2f4 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -253,6 +253,8 @@ static int anx7625_aux_trans(struct anx7625_data *ctx, u8 op, u32 address,
> >       addrm = (address >> 8) & 0xFF;
> >       addrh = (address >> 16) & 0xFF;
> >
> > +     if (!is_write)
> > +             op &= ~DP_AUX_I2C_MOT;
> >       cmd = DPCD_CMD(len, op);
> >
> >       /* Set command and length */
> > --
> > 2.35.1.265.g69c8d7142f-goog
