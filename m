Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516A15626A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiF3XPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiF3XPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:15:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5318D1E3D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:15:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cf14so798405edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWJlfnOUvt/FFKbUgKl5hHMb12qmVk1doHERyZfesTg=;
        b=Wn+P6bik2DjG8VTAjP17LBoHzLWqHSFvUMIQbK+3Uny2jIXyxPR0eFPIGOGrzNwMtB
         PAkulFML0VeMMt7xAv/O9qGy3I49Rc4Omb5bXscaWalVPes1iOEFJP2+gkxUtmVmSOP2
         zg36Q/CMHN4JD0aaRUSYAEmDlrr2+k44vFPKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWJlfnOUvt/FFKbUgKl5hHMb12qmVk1doHERyZfesTg=;
        b=lIPPax7EM8jfh6Z+401kdi57vif941ig7ApFvxr9g7aSGsIpph4bGD2PAYSgroERx1
         EBAZ6Uf/7QBLquv2W22yxulPKcakOQQDZX2Ly3R5wtVWsy3SsZT83F4uTvkSoMPgVkmW
         3lAeGnIP2j0xWrYPNFaSTluDuRdsG5IoIUHARJTGkXM1TyoamyS1WjL65iCUNh96Pzmb
         s4zEqWS9AbINDh9hTkwAxcXOzJu5ohzqlYvD95z3Xoyjih0Fyf4OdCxY3K1cfh6FUCY9
         ybKl18/sQcfzcPJygMS3TzBByumiMLFZRZEnklyghgazSz48fdIkyx6O8G44DTp9lPno
         nPGQ==
X-Gm-Message-State: AJIora+jJIlkm+4aXOZxOoXxoFRx6YJ/oGhDsl73Nt+oSZ0jBaAFsbit
        MtF0NGzsAB8njLflPNqzF8CxPk0YANU2a2JMIik=
X-Google-Smtp-Source: AGRyM1ssc2HzUWPJS5EVjhPf/8iGbNn9coxhr3YjdLqWtU6QNGdFuERXFRUlnSKL6b0FlHQZrT75vQ==
X-Received: by 2002:a05:6402:2404:b0:437:d11f:b9c7 with SMTP id t4-20020a056402240400b00437d11fb9c7mr14883943eda.176.1656630945648;
        Thu, 30 Jun 2022 16:15:45 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906500f00b00722dceb3f8bsm9694528ejj.151.2022.06.30.16.15.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 16:15:44 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so498668wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:15:43 -0700 (PDT)
X-Received: by 2002:a05:600c:5107:b0:3a0:4342:ed75 with SMTP id
 o7-20020a05600c510700b003a04342ed75mr12367143wms.93.1656630943574; Thu, 30
 Jun 2022 16:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220630193530.2608178-1-mka@chromium.org> <20220630123445.v24.2.Ie2bbbd3f690826404b8f1059d24edcab33ed898f@changeid>
In-Reply-To: <20220630123445.v24.2.Ie2bbbd3f690826404b8f1059d24edcab33ed898f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Jun 2022 16:15:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xj3ejpZ4y3D9gip=rr2jKx9bA1jJWtHVaKv9TYZdQ2BA@mail.gmail.com>
Message-ID: <CAD=FV=Xj3ejpZ4y3D9gip=rr2jKx9bA1jJWtHVaKv9TYZdQ2BA@mail.gmail.com>
Subject: Re: [PATCH v24 2/4] dt-bindings: usb: rts5411: Rename property
 'companion-hub' to 'peer-hub'
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 30, 2022 at 12:35 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> In the context of USB the term 'companion-hub' is misleading, change the
> name of the property to 'peer-hub'.
>
> There are no upstream users of the 'companion-hub' property, neither in
> the device tree, nor on the driver side, so renaming it shouldn't cause
> any compatibility issues with existing device trees.
>
> Changes in v24:
> - patch added to the series
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> (no changes since v1)
>
>  .../devicetree/bindings/usb/realtek,rts5411.yaml       | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Matches what Alan said...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
