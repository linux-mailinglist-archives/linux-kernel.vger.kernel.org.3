Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5235355F907
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiF2H3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiF2H3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:29:37 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6368F248C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:29:36 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-101b4f9e825so20318311fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=QZQW7+X7qAeWQ0JA11J+Y8+6HrDMvj4CxUzkjuBhZk4=;
        b=cVHuYXoUBBcO77yyhDnn9dRsLS4jjH7jJT7wBlYKn1PkKTKNe3bZHOH6+8Iz3fG+1s
         6qvW56SRXka8ShlfNVZhhy9EhuAwPIQBwY0aS6tcz4GMKflhio6xYYKNoesvFk6SOqqu
         U91f8Mzs5sZidos4K4DovB9CapAukJ/QfoGS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=QZQW7+X7qAeWQ0JA11J+Y8+6HrDMvj4CxUzkjuBhZk4=;
        b=MIPYQm/a8NiFZTBPbAOd5XxpAAwKbfTyrW2n4uEbtpQlfS7EUf81YDVwB+fL4QyANH
         ODnMFfDAhcxYd+OYkMPoV3Xiq0lJeHskrH2Kbed5AURiUN+yPM4m8KEvKUrctq2IAgOv
         6wJZWDXaWEU8mdC48M2zg3G2HHJjmkPZIVAy2FVAU2o6gP7cOR2S+wP7Cj/4ed2p4J5W
         ixrzqkwKbd8paLUlv/mIIQhO7YPDL1PiE+F3nNr8hMHIxZSdVJWXmjQ6PbnqOnBYOt0I
         0jXRAZfSgRfqAvBedsMDviqbUPjuE+H6URf3k0m+5WAW89nWYon5sSm46xLOwhyySDFt
         sP/A==
X-Gm-Message-State: AJIora93lLYKmO5UJwhoJSeHcMXLF7qi2FQ0dh9Jil/z/QBd9vMysXMA
        DBdvYDgvK51uVIE4vxTlJipEDdubKK2YGMv6q2QdtQ==
X-Google-Smtp-Source: AGRyM1vaywAXGT5aAjMk6AmlxtgNGPiL57UiTFsOz2mBPdyZOB/WeFYD1oj5i+TmFEv+OrgHcLCr65PRFFZJmJ+4AQU=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr1151175oap.63.1656487775750; Wed, 29 Jun
 2022 00:29:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jun 2022 02:29:35 -0500
MIME-Version: 1.0
In-Reply-To: <20220627215720.GA3004792-robh@kernel.org>
References: <20220614195144.2794796-1-swboyd@chromium.org> <20220614195144.2794796-3-swboyd@chromium.org>
 <CAD=FV=UU-AENyChCvVAKH709E4hFtgo4Txa8zFDY=JM1UifA0g@mail.gmail.com> <20220627215720.GA3004792-robh@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 29 Jun 2022 02:29:35 -0500
Message-ID: <CAE-0n53SJbnvyCXhgVWATSs0pKwGqNj9AeVLfNfUUvzR-UxRuA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: cros-ec: Add ChromeOS fingerprint binding
To:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
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

Quoting Rob Herring (2022-06-27 14:57:20)
>
> If we were starting from scratch, I would say you should just drop
> 'google,cros-ec-spi' from this binding. But I guess you want to preserve
> compatibility here. In that case, I think all this should be added to
> the existing doc with an if/then schema for conditional parts. That also
> avoids defining the common properties twice or moving them to a common,
> shared schema.
>

I had it all combined in a previous version. Let me see if I can merge
the two together (again) and fix the bugs.
