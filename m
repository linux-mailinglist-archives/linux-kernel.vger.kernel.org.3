Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0257D1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiGUQnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiGUQns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:43:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E63C88F3F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:43:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m13so2865587edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byBzIaJw6jMxBBYGES2u6HDi7WAW37rE0mMWKttg2Zc=;
        b=it5xCPZKQCQl6c1jVCxkdaH+yG26YTSb/lpXqb6q6fgSl0x7YMEpMf14eXRi6ao7os
         /zsUcI2CE7jlzahxkBdxxHKph9OyqFHjPfyqNsbe4FbgeCqrSoVqihsd2pqryuysX5VH
         RU/qEZN6Ox0sjaPT5kFUq/HRVAXq4F3bmfZjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byBzIaJw6jMxBBYGES2u6HDi7WAW37rE0mMWKttg2Zc=;
        b=AHwqfqq7cgNEYNJKtJ7hHz8/hat6pLLdihhjJMYed3eShPbacOBU7wdYlMOvHMYI/y
         azllY0PiaYBoQ5BG+ftDbOnTltRg+1Bra9iGbA/ShWKVQtWryEdiLYjMp/bBgm05mUKa
         NRmQuETM9zi7yiFog1bk4/KeKVCDD1Rv6Y6Z+wo5Ix0az3+vV7EdviJeIlkTJLAZejZx
         mz2oJU2MpzpDZPJSaex/WvtSCj/IIoj8rMnBtZstmPFVFSjMqMC0rMvBr9gz046dlnfk
         dQLGWkMaVU+uNyApyucfujoPL5V/OoB+rvsPjmXTyYqtFff2LSxG7tynFPzOBM9g277T
         ON7Q==
X-Gm-Message-State: AJIora+OxyTkJ7pw/e8z/B0U3HNymM9KxlpEc9o1pxZ8lPzpEnU77N8Z
        45jKjn994qJcRFZQhzF7prWfMmQFI/wu1ZDCT1U=
X-Google-Smtp-Source: AGRyM1ujdEGINjd1AQukjcUyXRgLvVUiqEft8dXf/X0v/WCH+rHLmXygxOxsi/sZ/2cdBvD40Gh4rg==
X-Received: by 2002:a05:6402:1d93:b0:43b:a38a:e335 with SMTP id dk19-20020a0564021d9300b0043ba38ae335mr16317442edb.337.1658421825600;
        Thu, 21 Jul 2022 09:43:45 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402032600b0043574d27ddasm1220871edw.16.2022.07.21.09.43.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:43:43 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id bk26so3057573wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:43:42 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr35363081wrr.583.1658421821756; Thu, 21
 Jul 2022 09:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
 <20220721033918.v3.2.I7ecbb7eeb58c5e6a33e32a3abf4d6874e6cb725c@changeid>
 <CAD=FV=WSBgupLFMCZgianck6uTkAyqrG0WK2ChSbNbJdhOPdLA@mail.gmail.com> <4b2fe9d0-f590-0fac-79fa-bb05da1d61df@linaro.org>
In-Reply-To: <4b2fe9d0-f590-0fac-79fa-bb05da1d61df@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Jul 2022 09:43:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmaNdc9k98vAwbcN-sm0w_WeqhRsK_AUm3h4LZ5-egmQ@mail.gmail.com>
Message-ID: <CAD=FV=XmaNdc9k98vAwbcN-sm0w_WeqhRsK_AUm3h4LZ5-egmQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: qcom: Document additional sku6
 for sc7180 pazquel
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 21, 2022 at 9:33 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/07/2022 15:37, Doug Anderson wrote:
> >
> > Not worth sending a new version for, but normally I expect the
> > bindings to be patch #1 and the dts change to be patch #2. In any
> > case:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I would say worth v4, because otherwise patches is not bisectable.

You're saying because `dtbs_check` will fail between the two? How does
flipping the order help? If `dtbs_check` needs to be bisectable then
these two need to be one patch, but I was always under the impression
that we wanted bindings patches separate from dts patches.

-Doug
