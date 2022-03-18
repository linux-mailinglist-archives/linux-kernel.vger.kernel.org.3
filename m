Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF914DE2CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbiCRUuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbiCRUul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:50:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0D105AB0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:49:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h13so11601534ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MSb82c7wemn5s39BmM23Oln72hevPicxsN1r5ivL6U=;
        b=CA1hCCYL0BQ05YK0J1CPDJmoLh2ESsCRnFcUnRyOfupdkOao9Ca/nbVo4HSzLXwCSI
         Vrqmw5nsHFAhl5WYnCZuOBc2nEZJef8k8cWy8urUgt3WrrA3POPVaETGqdFAxiq2WVwy
         Z6F8q64+iOK3GE3gc0n++Gw5aW3gmufktvl6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MSb82c7wemn5s39BmM23Oln72hevPicxsN1r5ivL6U=;
        b=8Bnixj1hSDVigppgjefepovT8WY9Lnmi+79g20bHTWaGRoDWHXypEbv9kfWsf694IV
         I/2oVoVcmuZq39k84bcz5WtlzKy8HvelYCqlRMssu7MOpWK4oGjlPIgJGLKU4c8n/daH
         r8M7PK+0UV7pVfUoy02GHYMU7d0M9OC3ojQcDk2wsORXoHFBIef2JdyvU5J+E0SaothL
         qikOaiphWWrF7Cj3D8uzzIU2MZyMmflGagTr9Mt4RnOHVPGlD/g23smJ7e1cqZSONrDf
         NIjdWo2zASsQYtMiuugLFYx3heXI+FqqsQtYwJBIOcUwd9AXIOx3Z5QVDfyH297kRjWS
         IYGw==
X-Gm-Message-State: AOAM531KTd/191LrcGf6+B7+2uXmh1DT0CLJVcvKOU+lWbMv8lj2+AMD
        rD8x8nxQbl1WwujRVoEZMbCbgVvLCQB1m7AN8NM=
X-Google-Smtp-Source: ABdhPJyAYZwljEXmSLpV2KKn/6RRTYo+ByK6/m92OJNbKTUTW4OJwqjXJqeOm6HldpGhL2kDWB7wgA==
X-Received: by 2002:a05:6402:d0e:b0:418:f011:275e with SMTP id eb14-20020a0564020d0e00b00418f011275emr11233919edb.323.1647636560123;
        Fri, 18 Mar 2022 13:49:20 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm2646366edb.27.2022.03.18.13.49.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 13:49:19 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso5361358wmz.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:49:19 -0700 (PDT)
X-Received: by 2002:a05:600c:19d1:b0:389:7772:b21b with SMTP id
 u17-20020a05600c19d100b003897772b21bmr17513788wmq.118.1647636558601; Fri, 18
 Mar 2022 13:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220318015451.2869388-1-swboyd@chromium.org> <20220318015451.2869388-2-swboyd@chromium.org>
In-Reply-To: <20220318015451.2869388-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Mar 2022 13:49:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WV+rssDpUdq0fVuVKf4b7DwTsFgodAX8wi-eLEoxTa3g@mail.gmail.com>
Message-ID: <CAD=FV=WV+rssDpUdq0fVuVKf4b7DwTsFgodAX8wi-eLEoxTa3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: chrome: Add ChromeOS fingerprint binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 17, 2022 at 6:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Add a binding to describe the fingerprint processor found on Chromebooks
> with a fingerprint sensor.

It might be worth mentioning that previously these fingerprint devices
were described using "google,cros-ec-spi" just to provide context?


> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/chrome/google,cros-ec-fp.yaml    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/

Reviewed-by: Douglas Anderson <dianders@chromium.org>
