Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5D855FF31
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiF2MAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiF2MAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:00:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6461C3F8AE;
        Wed, 29 Jun 2022 05:00:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q6so32019744eji.13;
        Wed, 29 Jun 2022 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=sTKSvmVJgHL+kk11gbOgnsoG5Ap89tTp12M6SLk9RRk=;
        b=jc29pOELtAijL/e6YGadOP4bEWJw+xqeGDq/AT49k1EfunnpVNt42V1A5G5N0Ow6fj
         P/Ukwqw1Yw8AUY9UiAim79hcv2pKzzYxBEM20A0qkHo6SBzQe/SizENPzBPYxc3kXjIT
         bEvf4YE0ZdJVpGCpf3IY3/Qz1QABgOzzN96AaS9H4i2lhHRMfRMMK84DHkH3GDF/yNtb
         jb6CgJBRB07UOzrpaMPDtqjemFr76w6PQun6DZl3IuQxdmYXUkhquGerl0hDBFyj1Mn/
         +eFA5cFwZsOOjAvZfgxTFt9InrbKvyhNatS8Pml3gSIRG6Jk74VU1vmwifZ+02eoI1q+
         uwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=sTKSvmVJgHL+kk11gbOgnsoG5Ap89tTp12M6SLk9RRk=;
        b=XZnBCkrTMdLLWvz1uvbfWQkIrxjUtDF0/Ws9FXz23PnLjeVP0KOm01tszSCzGlc6NB
         nVccE2iF9mr2M6qvB+nAnggD4+FH6EvSw5+viFzeY8a8eQcGDKHrpNTL4cYR+gxTEi8v
         9Ix1LIhJAAqF1ILWNCwPdyyAK0rNPWWRkGLwxaSn2vUqciVzWL2yWFxKwwaiqzJNXTuJ
         WMqKGmeJhF6aEmJgNsvpyfFEEttsyAv4lrJ6eAtCsDJF708Q77cGAxv/+Wrma6h4fBGU
         0OcssxpxYp4cmDoJpMb+KT40an0OmbTT0xpxKiTFD++aaQL9y3KlJcN8gJvKxLey20fH
         37Jg==
X-Gm-Message-State: AJIora8ZcOM1iw4NbYFZcag48j87L6Nngf2u8TytXV2HasjidrSNk+W7
        wr6U2hNjHS8Q2jxcBh1Y3qQ=
X-Google-Smtp-Source: AGRyM1vLRjTblxwGdLCUo4A+gmq5aFOXeRLZNbRGAo7Su++pSc82k89UUoo8hCcoXWy2wJS1/m1HhA==
X-Received: by 2002:a17:906:7cc5:b0:726:38e0:4e80 with SMTP id h5-20020a1709067cc500b0072638e04e80mr3018159ejp.664.1656504018833;
        Wed, 29 Jun 2022 05:00:18 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id i21-20020a508715000000b004357558a243sm11308904edb.55.2022.06.29.05.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:00:18 -0700 (PDT)
Message-ID: <62bc3ed2.1c69fb81.c8439.4982@mx.google.com>
X-Google-Original-Message-ID: <Yrw+2+7FwaLFVEJZ@Ansuel-xps.>
Date:   Wed, 29 Jun 2022 14:00:27 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
References: <20220628184137.21678-1-ansuelsmth@gmail.com>
 <20220628184137.21678-3-ansuelsmth@gmail.com>
 <e625e2c9-7321-51fa-b9bb-40ed9742ffcc@linaro.org>
 <62bc2c1d.1c69fb81.09d2.e244@mx.google.com>
 <3ad4876b-1efa-c4c4-2139-3823cf80ff68@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad4876b-1efa-c4c4-2139-3823cf80ff68@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 01:12:37PM +0200, Krzysztof Kozlowski wrote:
> On 29/06/2022 12:40, Christian Marangi wrote:
> > On Wed, Jun 29, 2022 at 08:14:12AM +0200, Krzysztof Kozlowski wrote:
> >> On 28/06/2022 20:41, Christian Marangi wrote:
> >>> Convert kpss-acc driver Documentation to yaml.
> >>> The original Documentation was wrong all along. Fix it while we are
> >>> converting it.
> >>> The example was wrong as kpss-acc-v2 should only expose the regs but we
> >>> don't have any driver that expose additional clocks. The kpss-acc driver
> >>> is only specific to v1. For this exact reason, limit all the additional
> >>> bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> >>> v1 and also flag that these bindings should NOT be used for v2.
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>
> >> This is still not fixed and not tested. Since 4 versions of this
> >> patchset (previously was part of other set).
> >>
> >> I retract my review. Please test the bindings.
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > Thing is that I tested them and on my side I don't have such errors.
> 
> Then maybe update your dtschema because I can easily see them.
>

You are totally right. I didn't had the problem as I was updating the
dtschema with sudo pip3... and it wasn't updating the dtschema local to
the linux repo. Didn't know that and I could't understand why I didn't
had the error.

> > 
> > I'm using the linux-next branch. Should I use something else that have
> > newer schema files?
> > 
> > Also on other patch there are some error reported that are unrelated to
> > my change and that looks strange.
> 
> The other might be not be relevant, but this one is real and reproducible.
> 
> Best regards,
> Krzysztof

-- 
	Ansuel
