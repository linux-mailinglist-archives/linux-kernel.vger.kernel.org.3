Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA558EAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiHJK6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiHJK5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:57:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D396C5A3C8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:57:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so17301255wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=sxO6pBYMFyCO8T9Rpok+/sK67wCwRESAbANsHwqKpSI=;
        b=K7Y8Tm9kITFF/BFyTFH0V6bfW4oaN3MI/h6E4kW+InWiIm1nIsbbfRLTAqsB5YeH+z
         NRHoXt8Tuw1tXRC9lH7jT7SbSl8ocfduH217oNtUuKrmdDCuLxf/0+N83TQSUPBKfe+J
         iFQG4Lg4u+zKrovIfuojKYkendOtYj1tjxnAbXMNwucP4L3t6Yk1csEjg/0jSLwQgRP0
         VqLAplSd0rKICVrRA1mqsUoBw39p16tnGFglFUBBmHMiIliGbIEIcWbAa2npPuBnA+nG
         enwxwP8ED2TMFPAvskKOxGom0Ltbsm74wsjywsswptWAVOK6G/s33PrTfb0ok0lsgXpy
         b3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=sxO6pBYMFyCO8T9Rpok+/sK67wCwRESAbANsHwqKpSI=;
        b=XwPq8BLyusy2qwp0u5WN1PNQTo7AJGc2a59pMdYOfTrV0WCLkvHDkKPyv7O/mBJX23
         W8/XVY2hc1vLL/8G+dcGcs5Wgv384BV2xBbz/3sJiBJmXOuYJsIzPh6j6Nju2OQm1BLU
         DPQUjN/GLtbbv/1tNF/U+iScPRPIfPL9h0mSPtZHgjj6C7gzMUjJlpr2zUsJMF5fRkWO
         RCzIXfw/khwliJRTzyCJNkQDPqBWJyVbsN/Ftq5Ic0MeVEItZZvzPmlOxo4ZiJ7x93vD
         HgY1VlgLrahdBJiByJnZ5V7mujtPZ1Mpijs4jln10JamL9fKGTOc3blDJ4l2kkyrk5pR
         s5rg==
X-Gm-Message-State: ACgBeo3kvclFcG353jEOIAAU5FHKD7A35Ece4v94Cgvuk1uPiJVPaXPF
        LV5JZsFRFsPwkuWYycR3X7/yqyKy/VzOMQ==
X-Google-Smtp-Source: AA6agR4xTdof6Q0yg3dmcZLmnb1tj/648aGhpZ33nJUTW6ltxt5UMrIJl1FFK6j9lsHxVBnEXwDWsw==
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id p11-20020a5d638b000000b002206e1a8794mr17165169wru.193.1660129067349;
        Wed, 10 Aug 2022 03:57:47 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id j14-20020adfe50e000000b0021e4829d359sm15892580wrm.39.2022.08.10.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 03:57:46 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:57:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Message-ID: <YvOPKKw60F4qEKM6@google.com>
References: <20220626191630.176835-1-david@ixit.cz>
 <20220809235625.GA2775377-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809235625.GA2775377-robh@kernel.org>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Aug 2022, Rob Herring wrote:

> On Sun, 26 Jun 2022 21:16:30 +0200, David Heidelberg wrote:
> > Convert Qualcomm SPMI PMIC binding to yaml format.
> > 
> > Additional changes:
> >  - filled many missing compatibles
> > 
> > Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> > v3:
> >  - added subnodes, there are two not converted to YAML yet, but it works
> >  - now it prints milion directly unrelated warning to this binding
> >    (it's related to the included subnodes bindings, can be merged,
> >     but it'll generate more warnings and preferably anyone can takeover
> >     from here)
> >  - add qcom,pmx65
> > 
> > v2:
> >  - changed author to myself, kept Caleb as co-author
> >  - moved nodename to properties
> >  - add nodenames for pm* with deprecated property
> >  - add ^$ to pattern properties
> >  - dropped interrupt-names property
> >  - added reg prop. to the nodes which have register in nodename
> >  - added compatible pmx55
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
> >  .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
> >  2 files changed, 191 insertions(+), 94 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> >  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > 
> 
> As this hasn't been picked up, I applied it. Thanks!

I'd prefer to take it via MFD if it's all the same to you.

In case there are additional fix-ups required during the next cycle.

-- 
DEPRECATED: Please use lee@kernel.org
