Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71235588F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiFWTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiFWTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:32:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C83F324
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:08:33 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 7-20020a9d0107000000b00616935dd045so196004otu.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=G7GUFKx0kufkNV6cl0VJc529FkLJIKTxF3dZCCvrwdY=;
        b=iN0a13Zqsn8ttJ7ja/KPwL2wPvJTDmHPO333uxUAd1CAaE8rvuUZkbPDyN3+0gOYeh
         yFjnENL67HNFCTd3LjmuhZ4hhwqdRyCMALZc3RW5N1Org7VuzCf1DFMR5WtCyfv2391G
         uo55OZxLAmQCzfMdLjGN999g9b+vwqIJ9/3eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=G7GUFKx0kufkNV6cl0VJc529FkLJIKTxF3dZCCvrwdY=;
        b=2Sat4grgXfVR0I4wCMY9AxRGBE7bizWYrm6gWu1lWj9Fkp2HUMqeMN06WTzII5MLGU
         lyyT8et4EoOrT4iHT7+/hWTDobutMtz67e2unxynxOgy6pLdCeSPn0nHLQONlDn6D3mr
         J69qFCO53H98rAhk2WcgLHPtXtHeqlngH6+HuzkNTTuhRLMc0lPvdfymnUrB5Fp/3Ed8
         CPytvsEfJZqtZwldzONSrepHOuihADlyCo1GsKjw7bUCDtiPIjWWnG4bi9EZaa/KBPjn
         eBm9l06fJNXfSXP6qmi1DcyMUa+jaO+3osBKjZafHPVAW0E60tLXxi+GFAnnDafh2HDM
         FHPQ==
X-Gm-Message-State: AJIora/+Y1YBs/Jk+l0YlqZ4QrWdy9E4WPsHzztwMqABFZyE0bksGLKi
        lRMWewVuwHIrIvTz6x6NMxGmz3WUf65f4jHu0hV3Qg==
X-Google-Smtp-Source: AGRyM1vgbF+x4e8hC812jkDhF5ujgwGy9u1TIoIP8891Q9B03Dipuo0gmMCNmbyza772yJuf+a8CoPoLp42FIFqFmzE=
X-Received: by 2002:a9d:729b:0:b0:60c:21bd:97c0 with SMTP id
 t27-20020a9d729b000000b0060c21bd97c0mr4488368otj.77.1656011312243; Thu, 23
 Jun 2022 12:08:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jun 2022 15:08:31 -0400
MIME-Version: 1.0
In-Reply-To: <CACeCKaduttgNfxyzE2_7eD1N4NLNp_8J1EaWTnn+eqp+_P-i1A@mail.gmail.com>
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-7-pmalani@chromium.org> <CAE-0n51d4S3T+_f+YXsu3es7AMxuyFORSXFQe2LTSkZB4C56Ng@mail.gmail.com>
 <CACeCKaduttgNfxyzE2_7eD1N4NLNp_8J1EaWTnn+eqp+_P-i1A@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 23 Jun 2022 15:08:31 -0400
Message-ID: <CAE-0n53Y4pe3TvNQVKZsqLU4cA-Vs4zH3HHV5U97W_6qCNsEow@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] dt/bindings: drm/bridge: it6505: Add mode-switch support
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
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

Quoting Prashant Malani (2022-06-23 11:37:08)
> On Thu, Jun 23, 2022 at 11:24 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Prashant Malani (2022-06-22 10:34:35)
> > > From: Pin-Yen Lin <treapking@chromium.org>
> > >
> > > ITE IT6505 can be used in systems to switch USB Type-C DisplayPort
> > > alternate mode lane traffic between 2 Type-C ports.
> >
> > How does it work? From what I can tell from the information I find when
> > googling this part[1] and looking at the existing binding doc is that
> > this device is a DPI to DP bridge, and it outputs DP (probably 4 lanes
> > of it?). Does the 2 type-c port design work by transmitting DP on two
> > lanes of DP for one type-c port and another two lanes of DP for the
> > other type-c port?
> >
> > DP could be one lane, so if this device is able to output one lane on
> > any output differential pair then I suspect it could support 4 type-c
> > ports if the hardware engineer connected it that way. Can you confirm my
> > suspicion?
>
> I will let Pin-Yen comment re: this hardware, but 1-lane DP is not a
> supported Type-C Pin assignment
> (as per VESA DP Alternate Mode Spec version 2.0 [2]), so the H/W

Some missing link?

> configuration you are suggesting shouldn't be possible.
>

Alright, cool. But it is possible in the DP spec. So it seems like if
this is connected to 4 DP connectors it could be used to mux between DP
on 4 DP ports.
