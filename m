Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9C5721EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiGLRp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiGLRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:45:56 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8334CCDA2B;
        Tue, 12 Jul 2022 10:45:55 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id n68so8591605iod.3;
        Tue, 12 Jul 2022 10:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EeA/Q4dpzXnIdEu9s3UYVlS9gYTtGYBnZ7WQ/eoGAPk=;
        b=qxaiuVAXsabNBVVCVvb13Nc7Q8i1/ZzQbJs1k95To8cJhV30t6jx/h8iiFKy/fBNvj
         f3fQKglC8/D9DWlIZ5K3Pcn+L/tXbrhx6z0ILLVIvo/tc+Jfcd7W1k061FcWzOwivxi1
         LFsPf8xsBrjcUL8onn69iwMAmvM00Uzb5zIGppz2/TQqVHPrB6aS60jxCIRtTt0kLP0z
         v9qtNaR7pcN1fOA4UVOSvZ1FyHqVHOMANf7zsRHExG0rbQ6oNsZZMAAz+FdCLY81QzJV
         W6kUSEP3JwnJ/jDTkh1u1SnfbmFpAiOU1IskBhngIppeRhHS9eJuU/FqcwBfT5zFJ01p
         lC3Q==
X-Gm-Message-State: AJIora/koPsKWf8VgCLWhAgQN2272de54HOpt8lwF9Dy6eu8mFxoo5na
        FXJgjVNEAnAzzPntw/Kqtg==
X-Google-Smtp-Source: AGRyM1uOsNLXCW82QVYju7l6Xv2Jo7ce6JDXo6vc89kZT8WdBgtZT0+8I+FmmdzRidS+JO3TPYW5FQ==
X-Received: by 2002:a05:6638:2404:b0:33f:7105:ed23 with SMTP id z4-20020a056638240400b0033f7105ed23mr2456174jat.50.1657647954774;
        Tue, 12 Jul 2022 10:45:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o9-20020a022209000000b0033f7d500749sm171977jao.128.2022.07.12.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 10:45:54 -0700 (PDT)
Received: (nullmailer pid 2083290 invoked by uid 1000);
        Tue, 12 Jul 2022 17:45:51 -0000
Date:   Tue, 12 Jul 2022 11:45:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
Message-ID: <20220712174551.GG1823936-robh@kernel.org>
References: <20220627210407.GA2905757-robh@kernel.org>
 <CACeCKackdbDZrk5fk7qyMwSdTdzyTS=m1vHPFnQOj672W=2nOA@mail.gmail.com>
 <20220628182336.GA711518-robh@kernel.org>
 <CAEXTbpex9nxP-nyPWvSBchAW4j3C4MZfVHTb=5X0iSLY1bSAKg@mail.gmail.com>
 <CAEXTbpf_jxK-R5aA81FCbpAH4bChA2B9+8qExZUbA7Y+Ort=Gg@mail.gmail.com>
 <CAL_Jsq+C04RXLtm6Ac85Ru3EGwJbqV_UD3_dDWVrKvFSvdm7Ng@mail.gmail.com>
 <CAE-0n53ers881LOTCEmKDDxJQt+5vvXJSURs=o6TcOiR5m_EAw@mail.gmail.com>
 <CACeCKacJnnk4_dXEX7XiboOWrYpfAcE=ukP63agVAYUxWR9Vbg@mail.gmail.com>
 <CAE-0n50jm1ovUcBC0GCQJszk-4u+0vDQtAxHxsu9SLyn_CkQuQ@mail.gmail.com>
 <CACeCKadtmGZ5iuTHdMms6ZHGn-Uv=MbcdtqmUzqCb=5WHuPj2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKadtmGZ5iuTHdMms6ZHGn-Uv=MbcdtqmUzqCb=5WHuPj2Q@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:10:32AM -0700, Prashant Malani wrote:
> (CC+ Bjorn)
> 
> On Wed, Jun 29, 2022 at 4:55 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Prashant Malani (2022-06-29 15:55:10)
> > > On Wed, Jun 29, 2022 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > My understanding is there are 4 DP lanes on it6505 and two lanes are
> > > > connected to one usb-c-connector and the other two lanes are connected
> > > > to a different usb-c-connector. The IT6505 driver will send DP out on
> > > > the associated two DP lanes depending on which usb-c-connector has DP
> > > > pins assigned by the typec manager.
> > [...]
> > >
> > > We can adopt this binding, but from what I gathered in this thread, that
> > > shouldn't be done, because IT6505 isn't meant to be aware of Type-C
> > > connections at all.
> >
> > How will the driver know which usb-c-connector to route DP to without
> > making the binding aware of typec connections?
> 
> I agree with you; I'm saying my interpretation of the comments of this
> thread are that it's not the intended usage of the it6505 part, so the driver
> shouldn't be updated to support that.

That's not the right interpretation. There should not be some Type-C 
specific child mux/switch node because the device has no such h/w within 
it. Assuming all the possibilities Stephen outlined are valid, it's 
clear this lane selection has nothing to do with Type-C. It does have an 
output port for its DP output already and using that to describe the 
connection to DP connector(s) and/or Type-C connector(s) should be 
handled.

Whether the driver is type-C aware is a separate question from the 
binding. I would think the driver just needs to be told (or it can ask) 
which endpoint should be active and it just enables output on the
corresponding lanes for that endpoint. I'm not sure if all DP bridge 
chips have the same flexibility on their output lanes, but I would 
assume many do and we don't want to be duplicating the same code to 
handle that in every bridge driver.

Rob
