Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E136358EB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiHJLwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHJLwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:52:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A8A6CD1E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:52:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so17544277wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=I2x3ZVwIcbRfDNIirW1rKMcyyDiEh9RJlXsoOM/0eyo=;
        b=hgkp2qTfYjHRjkkd1UjGgjwMz7OnoTbuhCBfCC6DqBS4n4p4OpIicXHt8TyarFulol
         HWhzLqz2S9xJTzg4+1IY7NKFol2RmKg9lXSAvegbdbHRVMzkLR0uR+AmUll3E95ryG2s
         40ifPvd1RidRVQTKs+rBf7pZEMN9b1847Lq/muZ+Muu2CvmxoDwN6b107L8oA6gEtxKI
         kch11MMiA6YiP6xM8ainU067ZGYFKfgRfmk8Taz7eO+YktM+JCJBs41u+jeLAqekoEu5
         cEaRyim8rzyUjXOrEQFWDpF1QV+hbKpTE1ShOyjg2NrJh5EOKVdj0Whjta8lCP2PWNG9
         fgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=I2x3ZVwIcbRfDNIirW1rKMcyyDiEh9RJlXsoOM/0eyo=;
        b=wVqiY+FjeDrY2tcSANnVUxrHFNNyLZepR5HEUjeuiPDWjgdpz8KDGvjdK34GTsCLBI
         9ywpiAwzAAAiC88vdbn8sFi6UYT1LZXrZ8Cs60xIN3F9cbCzBd/7ZSXYC/u6RHgRYz/I
         lIMBimzpGt4irpozpv1rEqrShU7QjN/jdB+qurmtm20I1avUlte0K4ZfIMH8G2QLziHM
         KN3LaGbNph2fC16NzaOrTGpulK+hxGsBCZwgJ08vXWqCbywScUPJLMsFWrptJWGpqRIx
         Ll9pEynd7gs5OvZJCVInjAvXzJ4P63YeGiOhnmE7ieC0R6C/1epnHhVZ3w9MQEYnRJ5/
         QjRg==
X-Gm-Message-State: ACgBeo2PeEZ4173GZrxjHlKL8Ra16L4Wb6bDNcxaA9T+7Es8qjVzYyeg
        jlW7TMpap6BtTj7Q4x30MsZmag==
X-Google-Smtp-Source: AA6agR7JaL0PCcBdq5EqxJR6VyAq+/DtP4OTrNwjvP2bxPS/i2YoBWwRA3MrOYAxMN6NcQAL3uZdsw==
X-Received: by 2002:a05:6000:2cc:b0:21e:e8c1:2704 with SMTP id o12-20020a05600002cc00b0021ee8c12704mr18351637wry.378.1660132349829;
        Wed, 10 Aug 2022 04:52:29 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c350500b0039db31f6372sm2561749wmq.2.2022.08.10.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:52:29 -0700 (PDT)
Date:   Wed, 10 Aug 2022 12:52:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Message-ID: <YvOb+6PUT1lPBOnJ@google.com>
References: <20220626191630.176835-1-david@ixit.cz>
 <20220809235625.GA2775377-robh@kernel.org>
 <YvOPKKw60F4qEKM6@google.com>
 <1768ffde-fc99-29c5-d9fe-ce41db052c7a@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1768ffde-fc99-29c5-d9fe-ce41db052c7a@ixit.cz>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022, David Heidelberg wrote:

> On 10/08/2022 12:57, Lee Jones wrote:
> > On Tue, 09 Aug 2022, Rob Herring wrote:
> > 
> > > On Sun, 26 Jun 2022 21:16:30 +0200, David Heidelberg wrote:
> > > > Convert Qualcomm SPMI PMIC binding to yaml format.
> > > > 
> > > > Additional changes:
> > > >   - filled many missing compatibles
> > > > 
> > > > Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> > > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > > ---
> > > > v3:
> > > >   - added subnodes, there are two not converted to YAML yet, but it works
> > > >   - now it prints milion directly unrelated warning to this binding
> > > >     (it's related to the included subnodes bindings, can be merged,
> > > >      but it'll generate more warnings and preferably anyone can takeover
> > > >      from here)
> > > >   - add qcom,pmx65
> > > > 
> > > > v2:
> > > >   - changed author to myself, kept Caleb as co-author
> > > >   - moved nodename to properties
> > > >   - add nodenames for pm* with deprecated property
> > > >   - add ^$ to pattern properties
> > > >   - dropped interrupt-names property
> > > >   - added reg prop. to the nodes which have register in nodename
> > > >   - added compatible pmx55
> > > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > > ---
> > > >   .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
> > > >   .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
> > > >   2 files changed, 191 insertions(+), 94 deletions(-)
> > > >   delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> > > >   create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > > > 
> > > As this hasn't been picked up, I applied it. Thanks!
> > I'd prefer to take it via MFD if it's all the same to you.
> > 
> > In case there are additional fix-ups required during the next cycle.
> 
> I can rebase it against MFD if it's more convenient.

*Shouldn't* be required.  I suspect it'll just apply.

-- 
DEPRECATED: Please use lee@kernel.org
