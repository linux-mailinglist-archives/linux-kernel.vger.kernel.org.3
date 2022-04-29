Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C678515615
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381057AbiD2Uu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiD2Uu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:50:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F01C84EFA;
        Fri, 29 Apr 2022 13:47:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id be20so10329225edb.12;
        Fri, 29 Apr 2022 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=w2mSwMGTVQIhPwit27Nc58ZWfW+X0vro/Zsk4lAnHxg=;
        b=W9c74T45EQ3BYFz1/j3y0kDNKShmbYYo5/Sj54PkEk0Uc+yy02t4RudR4mndAucjyo
         ahc5fgsHbmTUqfVP1nYd1Gv0m48mtjQJTfB4o2imt9kdPI64rtYdXs/Ao8EN+i+jcT5s
         zkDQ40rZO2qBvenXKUl9r1oiTTPtPmbE0J4YnTHM9KzcPbyuMxENw291t17YjS+37Bmd
         G6eA18wVlw5DeUaf/L7PVaGNZMGo+MUSr0ejq7hjDB89/WUKR8oMbPZoCPe/tmFiHFdP
         QbHbnt5GUpjVh1r4yUrsQtTQAZb6kg5KPpyaGlzVGuYPJbCz1dSDuNwrWAV6fGBZe1B3
         nxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=w2mSwMGTVQIhPwit27Nc58ZWfW+X0vro/Zsk4lAnHxg=;
        b=7aP0jl73EUU6M9rgPNHSDEDW4e4cwxEp8F7Sz1BUzYarEtrvpiEjU5acitZAcG+ein
         00lJ4fN+ua1crdN6BjW6fuD7xcA9Cq6RrJa1A2EElGPe7coenGvCv9N+SuvyOy2pxtsk
         d0bmBOoSNOyTr5ETvLs8SskI6DUF33gn6A4JQs8WUIoACjjGDWcUQUz9OFh7TQL7CMz7
         ZZEnQhAB/O+FsN0OkrPqkbd7uQFvFT+SGr+h+LNdUEkSDVOlqoXEziYhPO1lmrYbrsXM
         XYMqmSDfJjIJYshUYnHPESsU2K5BEHKkqwlGnyOJI9C2zonj3omRtQU46L7kAzdWfTfg
         l3Xw==
X-Gm-Message-State: AOAM5307i3NfFW8HvnGGxmKn0aseBr90cGA8k+9can8T+XAMLdn4Todv
        hrgWFSwPs5vQpX2EIP7gD6Q=
X-Google-Smtp-Source: ABdhPJx4xpAzOPivPzLqutzUWV6igihWN/NO9008Jp540tqeA7zCMyJbaadUOR9O/fFMs1jkSG75iA==
X-Received: by 2002:a05:6402:26c8:b0:426:2c8b:a2c6 with SMTP id x8-20020a05640226c800b004262c8ba2c6mr1102618edd.61.1651265256581;
        Fri, 29 Apr 2022 13:47:36 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id g14-20020a056402180e00b0042617ba6389sm3293275edy.19.2022.04.29.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:47:36 -0700 (PDT)
Message-ID: <626c4ee8.1c69fb81.74b06.15c4@mx.google.com>
X-Google-Original-Message-ID: <YmxOVWDMjh1xZA+P@Ansuel-xps.>
Date:   Fri, 29 Apr 2022 22:45:09 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
References: <20220429121739.28584-1-ansuelsmth@gmail.com>
 <20220429121739.28584-4-ansuelsmth@gmail.com>
 <1651247596.124069.2344494.nullmailer@robh.at.kernel.org>
 <626c0b64.1c69fb81.1b1e9.4fe6@mx.google.com>
 <5127b3b5-ad27-fd06-42b7-fdf96d0a10ea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5127b3b5-ad27-fd06-42b7-fdf96d0a10ea@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:43:21PM +0200, Krzysztof Kozlowski wrote:
> On 29/04/2022 17:57, Ansuel Smith wrote:
> > On Fri, Apr 29, 2022 at 10:53:16AM -0500, Rob Herring wrote:
> >> On Fri, 29 Apr 2022 14:17:39 +0200, Ansuel Smith wrote:
> >>> Convert kpss-gcc driver Documentation to yaml.
> >>>
> >>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> >>> ---
> >>>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 -------------
> >>>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 63 +++++++++++++++++++
> >>>  2 files changed, 63 insertions(+), 44 deletions(-)
> >>>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> >>>
> >>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>
> >> yamllint warnings/errors:
> >>
> >> dtschema/dtc warnings/errors:
> >> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml: properties: '#clock-cells' is a dependency of 'clock-output-names'
> > 
> 
> The patches were previously sent (even as v6) and somehow the history,
> changelog and references disappeared...
> 

Mhh with split how this should be handled? Putting the relevant changes
in the cover letter?

> > Erm how to fix this? I can't do a 1:1 conversion if the source was
> > wrong and also have no bot warning.
> > Or I should just push an additional patch to fix this error after the
> > conversion?
> 
> Didn't we agree that original bindings were not in good shape? Yet the
> questions raised with your v6 remain actually not answered, till the bot
> complains.
> 
> Please do not send the bindings which do not pass dt_binding_check.
> 
> Best regards,
> Krzysztof

In v6 the last mail were with the idea of sending separate series with
minimal changes and it was mention that it was a good idea to send only
conversion and then send the changes with the conversion series.

Finally got the message. I should NEVER send patch with warning from
dt_binding_check.

-- 
	Ansuel
