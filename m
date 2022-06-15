Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA5C54CDBD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbiFOQEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiFOQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:04:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACD2255BE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:04:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so2476629pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ePN6l7qq+5+AEApPN8ZIDny0v2CL19RcX8ZdNrMR7lM=;
        b=aqM0+dFn+nn8gN9lgLMZUiyexrJiMRh9URiP1j+pSR5rH9FkZgHYRqWHAGfoOH7H/o
         apqcb2Dt7BbllawEZXVjxmkejglQNMu8/m/ujk9rvIJO/2nl+oTm2L5DVPcLrN1HKfOj
         bHAGlIQLWJssv8v2uPJdpwtXpYuCnhLLi1buEkKltNqWnc3wbTTrjB2zJhfAL11UH+CV
         qbsmGDz4A0Ueag0lhEd2Dr+4z4HJ1BHWv8YWg2vD3pOsABM1ZdIkjDWkeoWUFl9QVlI7
         6S6DAA+GJZm+8R4kiejkyXWgiRXnUGU4gp6fZAMJYI3csPLiA3mgAwppGQ44fA8W5EXb
         O62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ePN6l7qq+5+AEApPN8ZIDny0v2CL19RcX8ZdNrMR7lM=;
        b=SfbheBBzXbMyhEpmiVS8qMecX5CsiVjp6uBQ7BCsYYCQ9A+yxAN0ZCvFrgEoSysnpb
         swGMy81a5ZeydHd6OcEJUX9VuyJRAh6FNAwTWSbcDYaM0IyXk6IXd8ZNcWdfYD6DBPUh
         hVr9Q1aQ2eswruABXJmrxMFFn6Wu8atopobPcUPNeMHY5EmTCjEGMMuFlaPe35rCEljq
         hnVe0KI5DqzFJlD+BqmrnBqUhgZ2V0uhE7FVLpAXt3LzcSIo2oXctl0hrX+FsSc/ineC
         mx318KOR0DmGCsvWNT/Hq3ixMnxCKsYR38+y6FsDre19eh9sr0YGzGcmA5JM1K/ps4pL
         e2oA==
X-Gm-Message-State: AJIora9JQB1Osy7kFXRZY4PM0apjRim7WwMeVizVJKaH+XuEMGfTXrrh
        PBHIbqOCmsled7YqUMTSlhDNroUhUlNXwwRHo2Rf3A==
X-Google-Smtp-Source: AGRyM1vn/ajc9Zhrglm4j7l6bDUl6hYAdrUf3Sb59Qp8Lv5t13DLZGtXd5FnN6EgUEj2g6o4jDoor9Cr7RKIsPEATO4=
X-Received: by 2002:a17:902:f353:b0:167:7bc1:b1b9 with SMTP id
 q19-20020a170902f35300b001677bc1b1b9mr84680ple.117.1655309090641; Wed, 15 Jun
 2022 09:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220613163705.1531721-1-nfraprado@collabora.com> <9c8c712c-75d1-bd0f-0205-be769ce5e83d@collabora.com>
In-Reply-To: <9c8c712c-75d1-bd0f-0205-be769ce5e83d@collabora.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 15 Jun 2022 18:04:39 +0200
Message-ID: <CAG3jFysv_LSM2+j5jWmC-zM-jik0WdGjE7Mwm=quAabG_LzB6A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Zero error variable when panel
 bridge not present
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, kernel@collabora.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 at 09:52, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 13/06/22 18:37, N=C3=ADcolas F. R. A. Prado ha scritto:
> > While parsing the DT, the anx7625 driver checks for the presence of a
> > panel bridge on endpoint 1. If it is missing, pdata->panel_bridge store=
s
> > the error pointer and the function returns successfully without first
> > cleaning that variable. This is an issue since other functions later
> > check for the presence of a panel bridge by testing the trueness of tha=
t
> > variable.
> >
> > In order to ensure proper behavior, zero out pdata->panel_bridge before
> > returning when no panel bridge is found.
> >
> > Fixes: 9e82ea0fb1df ("drm/bridge: anx7625: switch to devm_drm_of_get_br=
idge")
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >
>
> I would've preferred s/zero out/cleanup/g but it's also fine as you wrote=
 it.
> Besides, good catch!
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>

Applied to drm-misc-next
