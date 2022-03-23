Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAA54E5C41
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346769AbiCXASN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346965AbiCXASK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:18:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9157B271;
        Wed, 23 Mar 2022 17:16:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h23so4373575wrb.8;
        Wed, 23 Mar 2022 17:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=natHNZDL8CZ9WaP9Cr9II4XN3FO23Y20ExCvAU3XTrg=;
        b=q6SZ6TLiAU/ytjxnIlO9T8oYxvX4bJsfMshpdVHqelZJik8DV/ooiEyu93XnF2JZdk
         Ao6mtjzEN7IfgFcCxVQOnoSORuBCw43MdVX/KOF3HBFOUz3QZ4Ewhv2R+ZL99qO+iJtg
         XM5fFgPUgPHbAQboYWdws6/B75Mt4Em9d6twn29DMX6quTraIxA/ppgpUFxPOGL2t62g
         PMcpvVi+JzVx80fwVCJkVIVFwBDEINDl9XSHe2gg/EIlIM2dDSSRFIpYKlyf21XraC9P
         1WOY3OTF5g3mtXURPOj3avazd7B/dd8r9j0TJ67XrizV/prLlxD37q3RGb3o83bHJRc4
         TD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=natHNZDL8CZ9WaP9Cr9II4XN3FO23Y20ExCvAU3XTrg=;
        b=oatvXZrsuM9unq740PLLBSBH+Fq9KJKt71EKl5Yc7ztQOA1avlu8k2MuTr96pge0v4
         HY1yppuXLuOTP6YUIzZg5/TiJ76VTQTEiN4rVyeic0TRuN1go8rzb8xQpURWJqIJ4I1E
         vmZiisNIfdzxOrwL4Gxp1br07kMJgFjXqR3fYaT89+HFobZq15z0dwkmrjMZG4k4Bwb5
         X9mSDj5kaHWrE1lm71WfXB/E2KgAaSzrwPwAI+/UZo1/dWzOyNkwlVPqApvT9Hb7wrt4
         WNsP8bTB+g3/qPp5/bC0IFEVTGKyb4MLHDYB9ay+EiblseVMryaXrnkJcyDjyuhN/yMl
         ulCA==
X-Gm-Message-State: AOAM530Pjq5qpNiyELnm/UZOJ7OaClWS3MX/R0FUbQgiT8ojosgn2IJw
        UriCb3ForiLAHMJgGWWldsc=
X-Google-Smtp-Source: ABdhPJwjviwdFIZ4cE6Bb9jEfkwK8jjjTkyZR43ngrQFxViPtlKP2325Wc/JM2NSJsSfaIRmHkTrlA==
X-Received: by 2002:a5d:618c:0:b0:204:2f:2c1a with SMTP id j12-20020a5d618c000000b00204002f2c1amr2139009wru.709.1648080998003;
        Wed, 23 Mar 2022 17:16:38 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm1212660wmq.9.2022.03.23.17.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 17:16:37 -0700 (PDT)
Date:   Wed, 23 Mar 2022 20:47:15 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 01/15] dt-bindings: clock: split qcom,gcc.yaml to
 common and specific schema
Message-ID: <Yjt5QxZ4+kdwTtUH@Ansuel-xps.localdomain>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
 <20220224164831.21475-2-ansuelsmth@gmail.com>
 <CAL_JsqLduGK=CyAcgahswFfeA43vh+QPgRgcL4+=piOwWwvJRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLduGK=CyAcgahswFfeA43vh+QPgRgcL4+=piOwWwvJRQ@mail.gmail.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:55:30AM -0500, Rob Herring wrote:
> On Thu, Feb 24, 2022 at 10:48 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >
> > Split qcom,gcc.yaml to common and specific schema to use it as a
> > template for schema that needs to use the gcc bindings and require
> > to add additional bindings.
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/clock/qcom,gcc-other.yaml        | 76 +++++++++++++++++++
> 
> This now throws errors in linux-next:
> 
> Traceback (most recent call last):
>   File "/usr/local/lib/python3.8/dist-packages/jsonschema/validators.py",
> line 816, in resolve_from_url
>     document = self.resolve_remote(url)
>   File "/usr/local/lib/python3.8/dist-packages/jsonschema/validators.py",
> line 923, in resolve_remote
>     result = json.loads(url.read().decode("utf-8"))
>   File "/usr/lib/python3.8/json/__init__.py", line 357, in loads
>     return _default_decoder.decode(s)
>   File "/usr/lib/python3.8/json/decoder.py", line 337, in decode
>     obj, end = self.raw_decode(s, idx=_w(s, 0).end())
>   File "/usr/lib/python3.8/json/decoder.py", line 355, in raw_decode
>     raise JSONDecodeError("Expecting value", s, err.value) from None
> json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
> During handling of the above exception, another exception occurred:
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-doc-validate", line 70, in <module>
>     ret = check_doc(f)
>   File "/usr/local/bin/dt-doc-validate", line 36, in check_doc
>     for error in
> sorted(dtschema.DTValidator.iter_schema_errors(testtree), key=lambda
> e: e.linecol):
>   File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line
> 1016, in iter_schema_errors
>     meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
>   File "/usr/local/lib/python3.8/dist-packages/jsonschema/validators.py",
> line 818, in resolve_from_url
>     raise exceptions.RefResolutionError(exc)
> jsonschema.exceptions.RefResolutionError: Expecting value: line 1
> column 1 (char 0)
> ./Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml:
> mapping values are not allowed in this context
>   in "<unicode string>", line 17, column 11
> 
> >  .../devicetree/bindings/clock/qcom,gcc.yaml   | 59 +-------------
> >  2 files changed, 80 insertions(+), 55 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> > new file mode 100644
> > index 000000000000..4e5903bcd70d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,gcc-other.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Global Clock & Reset Controller Binding
> > +
> > +maintainers:
> > +  - Stephen Boyd <sboyd@kernel.org>
> > +  - Taniya Das <tdas@codeaurora.org>
> > +
> > +description:
> > +  Qualcomm global clock control module which supports the clocks, resets and
> > +  power domains.
> > +
> > +  See also:
> 
> I think the problem is here. You need a '|' after 'description' to
> preserve formatting and ignore what looks like a mapping.
>

Yes, I just sent a patch to fix this.
Out of curiosity, any idea why this wasn't flagged by an old run of
dt_binding_check? I totally remember running dt_binding_check on these
Documentation and I had no problem. There was a bug in the old version
and it does now correctly find these kind of errors?

> > +  - dt-bindings/clock/qcom,gcc-apq8084.h
> > +  - dt-bindings/reset/qcom,gcc-apq8084.h
> > +  - dt-bindings/clock/qcom,gcc-ipq4019.h
> > +  - dt-bindings/clock/qcom,gcc-ipq6018.h
> > +  - dt-bindings/reset/qcom,gcc-ipq6018.h
> > +  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> > +  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> > +  - dt-bindings/clock/qcom,gcc-msm8939.h
> > +  - dt-bindings/clock/qcom,gcc-msm8953.h
> > +  - dt-bindings/reset/qcom,gcc-msm8939.h
> > +  - dt-bindings/clock/qcom,gcc-msm8660.h
> > +  - dt-bindings/reset/qcom,gcc-msm8660.h
> > +  - dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
> > +  - dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
> > +  - dt-bindings/clock/qcom,gcc-mdm9607.h
> > +  - dt-bindings/clock/qcom,gcc-mdm9615.h
> > +  - dt-bindings/reset/qcom,gcc-mdm9615.h
> > +  - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)

-- 
	Ansuel
