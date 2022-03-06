Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6264CED3B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 19:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiCFSku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 13:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiCFSkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 13:40:47 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2A29822
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 10:39:54 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z26so9363364lji.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 10:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJdT0uYnIkrEHo7bQMb01yqEAfgHuebjZMfybZUKXYE=;
        b=B/5f58vo38KUye6rmtbHQBaKoggxbOmSU0CQJSWqOAHyy9t315nFmnDuBmDN1ozPVT
         JuhWsDbopsXEFZIL+xUPJBnH2WPNrq38E6lEDXRBn7DEce6AOKlLN/VYyRVTFYlSh6Rv
         nzjiRiQM0rz62DZOG2Ynfyu+9z8r/oClL3gXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJdT0uYnIkrEHo7bQMb01yqEAfgHuebjZMfybZUKXYE=;
        b=nF7mhFibYzGzwf4F3cZBk+qtEBfDyOymI1eWsY74Csd9pOcsZ2F4qPDFsJ7KTu5xVI
         tEQwa4DK8J1yn0XOZW526NOeNxD8ZP0htV+TOKmuNQsrMENipyED2xq0PUmIvCBYaF2m
         bquPUXofu6eTkrDZCzMd5fAwEQds+NUTjyb/Dar9BBFv1Ypze9rfbF5QW0/0SWhejoBm
         UO9otOM+gDGq6pn5cGPkbuxroIg72b3ZBpsHt7hf9y3JkvBPXUvNiPjPuBtlTe8G532I
         uiE9Bo1OA7P1F9gNRu8BJy4r/2n2nBTqKf1PHt0KPUsRzWuQ3bi3Tpo6r+JRlIrp9HMe
         DTpA==
X-Gm-Message-State: AOAM531VFo0qk/xNGgxLwyqKprInSx6t44BlmYgvyho++sc7kSqejD2o
        OG7FLuTNAx/YuzSaBFWYltCWNbBI11SOZnuroh0=
X-Google-Smtp-Source: ABdhPJyEm8ZXH8oUFycHepCgXT9D8TBIr3eyl6qUP3LGr3Xa1nEcGTaSc0jV1QTVzAH4aKWFyXGXoQ==
X-Received: by 2002:a05:651c:1989:b0:247:deaa:4e5a with SMTP id bx9-20020a05651c198900b00247deaa4e5amr3524483ljb.274.1646591989862;
        Sun, 06 Mar 2022 10:39:49 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id y22-20020a05651c021600b0024608599f1esm2578261ljn.86.2022.03.06.10.39.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 10:39:46 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id b11so22723454lfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 10:39:44 -0800 (PST)
X-Received: by 2002:a05:6512:6c6:b0:447:ca34:b157 with SMTP id
 u6-20020a05651206c600b00447ca34b157mr5678695lff.435.1646591984685; Sun, 06
 Mar 2022 10:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20220306175034.3084609-1-jakobkoschel@gmail.com> <20220306175034.3084609-2-jakobkoschel@gmail.com>
In-Reply-To: <20220306175034.3084609-2-jakobkoschel@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Mar 2022 10:39:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wheru6rEfzC2wuO9k03PRF6s3nhxryCAnwR5bzKwPV2ww@mail.gmail.com>
Message-ID: <CAHk-=wheru6rEfzC2wuO9k03PRF6s3nhxryCAnwR5bzKwPV2ww@mail.gmail.com>
Subject: Re: [PATCH 01/26] usb: gadget: fsl: remove usage of list iterator
 past the loop body
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 6, 2022 at 9:51 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
>         /* make sure it's actually queued on this endpoint */
> -       list_for_each_entry(req, &ep->queue, queue) {
> -               if (&req->req == _req)
> +       list_for_each_entry(tmp, &ep->queue, queue) {
> +               if (&tmp->req == _req) {
> +                       req = tmp;
>                         break;
> +               }
>         }

Honestly, I think many (most?) of these would be a lot cleaner as

        list_for_each_entry(tmp, &ep->queue, queue) {
                if (&tmp->req != _req)
                        continue;
                req = tmp;
                break;
        }

and in fact maybe that 'tmp' would be better named 'iter' or similar
(maybe 'pos', which is what the list.h macros themselves use for the
iterator naming), just from a naming standpoint.

Because it's not really some temporary variable, it has a real use.

           Linus
