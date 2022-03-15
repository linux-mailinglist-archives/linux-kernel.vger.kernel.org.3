Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1224D9A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbiCOLLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiCOLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:11:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458A4C429
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:10:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r6so27969256wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6K23UjVYx8CDoSve9SilwO70F6QmU57lkW6EMzdPtH4=;
        b=pASCpeJpbdEbqtMdFz/LMDtOLUQPa+1SLdZdZFqouqWBEgo1UsWkoqRKyRExnrYi/j
         unsGxbVqZeqEYUf2dwqFptm8wPdDmnOVKIJ1HlxyAN7JPQ3iScbHAXrC1Y7rBvsLM2M6
         kTXyHJVcUnBWSagMQOKoIe/O3phe6V3F9lw/t4OUA8yByQZ2x5wusYYOzZl2oP7rcpwb
         v4X0lR0Cq7n+5ogn4ZrrUirRjzdDHBi/i4nfjknjg7Mwri3Hf5LF0CKtEvB2s56T2aDx
         /9+28IDP0p9KrvwIKlwnMu8jPTNu+NdTO63CyWQQ/lafWOGDz1hWxgOjPmOKf3kAina1
         XAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6K23UjVYx8CDoSve9SilwO70F6QmU57lkW6EMzdPtH4=;
        b=e3wO0LiXkxlodZasjWtm4vLu5oaVWJ+/P91YuOkIUknAaRHnEXd9hHlz8GrJIXCTrZ
         ZV37WBT/R2sBXHeqU48VoGxPDNGBlrqDNifDV3d0YCt7cCiqFWNACBEMbwvBr7PGlBPP
         tOU24hwbzWfOAKYpDJjiooBHAeE7oGs7GEAiDYhNp/YO7qEJWh0+pxH9iCKeewzpJ+Ua
         Dn6PAGTCq+jbn38SNaVIKY6HXrJy3YgGyeS4huqTYHD8M+2IhaE1fzrcoaTl8m5IRNfs
         7V6MFKZ6/s9HFcnGs+kQFpZ89MB3/gafJqj33PwSIXKtJicq+GCXveFwNejA1JCT+7c/
         8eMw==
X-Gm-Message-State: AOAM530ogLxOB08g8UnzZtsiDw7bd/eMfPn3eAT4VsWcn7yAd5XYKn9W
        suZa6L3jot8kmYTsU4DLXHJCvg==
X-Google-Smtp-Source: ABdhPJxyo8Tu+cI5LWcdBNsXhITp0l/mJqZADeSg6PkuOku8tvbq6f2IZzB1SrIHrs6Comls0FrYsw==
X-Received: by 2002:a05:6000:1376:b0:1f0:4966:8d16 with SMTP id q22-20020a056000137600b001f049668d16mr19827484wrz.553.1647342632132;
        Tue, 15 Mar 2022 04:10:32 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0020375f27a5asm16182941wri.4.2022.03.15.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 04:10:31 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:10:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ChromeOS fingerprint binding
Message-ID: <YjB0JOKysPpg2KGF@google.com>
References: <20220314232214.4183078-1-swboyd@chromium.org>
 <20220314232214.4183078-2-swboyd@chromium.org>
 <e7f9466e-03c9-7754-0dc6-a04823d1047a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7f9466e-03c9-7754-0dc6-a04823d1047a@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022, Krzysztof Kozlowski wrote:

> On 15/03/2022 00:22, Stephen Boyd wrote:
> > Add a binding to describe the fingerprint processor found on Chromeboks
> > with a fingerprint sensor.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: <devicetree@vger.kernel.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Craig Hesling <hesling@chromium.org>
> > Cc: Tom Hughes <tomhughes@chromium.org>
> > Cc: Alexandru M Stan <amstan@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../bindings/mfd/google,cros-ec-fp.yaml       | 89 +++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
> > new file mode 100644
> > index 000000000000..05d2b2b9b713
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
> > @@ -0,0 +1,89 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/google,cros-ec-fp.yaml#
> 
> Why is this in the MFD directory? Is it really a Multi Function Device?
> Description is rather opposite. You also did not CC MFD maintainer.

A lot of the ChromeOS Embedded Controller support used to be located
in MFD.  There are still remnants, but most was moved to
drivers/platform IIRC.

Please see: drivers/mfd/cros_ec_dev.c

However, yes, I should have been on the recipients list.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
