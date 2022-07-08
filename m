Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0A56C2B5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiGHWXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbiGHWXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:23:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497EDA2E75;
        Fri,  8 Jul 2022 15:23:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a15so187374pfv.13;
        Fri, 08 Jul 2022 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=awbCX6D8TgaWVx4PaHvXISepNRKwfSLcno0uruq5CMU=;
        b=Y8CUlZJ8uGgqajYbhGJtxEivYuxYsKb1Nj281kx9qT1nJmU8DzYGUmM+zXemnfOkL+
         XickPc13iKeqjkDpzqC16OUWhXELLUqqaZoSujZfd0GGWBChnkX6Bkg6Xjo6TEuIYjpb
         bPZ+GbqF16Zq5Xt8+ofsYrX6dYqD0wCK3JRvy9+bSSpZ4RWAeMrL/a3b8EphT+ksNKP2
         TAAK3k2eQWC3ix0Sje6Hw3Dxin2bY2x86pe7pJzHEq9smxnMTPFC5PMhnKH4Amkp5Hn5
         O0WRdYBIWjJ4MP2iqNMDVtJKbxVQgyxOQy/LbROys0upoP4SQNkHosHcq12tGGB9/PQl
         iCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=awbCX6D8TgaWVx4PaHvXISepNRKwfSLcno0uruq5CMU=;
        b=1Hwd9daKeTSS4CInLBFTdqn5rciu9F0AMR8696unWwGZn1L4AEh0QVeqHnr2TDpcQu
         e8CN5GgTR20PI/vNDwOU+0Gi7cSmbCmH7qBD3HClCIFXYWQnuVK20TkppkWUcx8+Rj+m
         mwhtJjt0c2pa1sO6CM/rDYvR8Xn2pvG3A75x//qEnbKe0ehEyLGJQ8Lmhdz/D7RcCeQ0
         6pnRE2DhYS0pBVyb5oPRVZFR4jCNrVvRVIbeh4Eort6hi8Y2b6IppN2qt3oITJXUvAVC
         5K799LnKhV8LPkcqyw739EetU1ldO2uCMElwquKBmK+IMyoMH5ILUQq+clCQghN7tGgY
         S7Kg==
X-Gm-Message-State: AJIora+27mU1jbKVBSRU/IUr3XVvsB/2syZSMZRgSKeS1TrH1bk7X2qB
        Xw3Y6RPsy3zaHyBEdvJguj7MTsM4UwQ=
X-Google-Smtp-Source: AGRyM1siGJ1E9EAcQp1E2pold0DZlvsAKWPVZoikBzkCUpfVLjSu2NIH2s73fV+oSiW7yuDW/gsXYQ==
X-Received: by 2002:a05:6a02:18b:b0:415:c9d:4e3c with SMTP id bj11-20020a056a02018b00b004150c9d4e3cmr5000142pgb.580.1657318984741;
        Fri, 08 Jul 2022 15:23:04 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9707:b37:49b0:77c2])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b0016a33177d3csm21891pls.160.2022.07.08.15.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:23:03 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:23:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 0/3] dt-bindings: input: gpio-keys: apply via
 DT tree
Message-ID: <YsiuRbaFMa683H1Z@google.com>
References: <20220705120356.94876-1-krzysztof.kozlowski@linaro.org>
 <CAL_Jsq+LepF_67SJUqQ5mUO-TZAd-46LB+aYE5rZmnmmwMg=bw@mail.gmail.com>
 <352f27e7-0da1-4a4a-83a4-ded370dfbd7f@linaro.org>
 <YsiVH41gCLeIMyd6@google.com>
 <20220708220507.GA1557227-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708220507.GA1557227-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:05:07PM -0600, Rob Herring wrote:
> On Fri, Jul 08, 2022 at 01:35:43PM -0700, Dmitry Torokhov wrote:
> > Hi,
> > 
> > On Wed, Jul 06, 2022 at 08:30:54AM +0200, Krzysztof Kozlowski wrote:
> > > On 05/07/2022 21:11, Rob Herring wrote:
> > > > On Tue, Jul 5, 2022 at 6:04 AM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> Hi Rob,
> > > >>
> > > >> Can you apply these directly? You already reviewed them, but I dropped
> > > >> the tag so you will see them in Patchwork. It seems these won't go in
> > > >> through input [1].
> > > >>
> > > >> [1] https://lore.kernel.org/all/c2c1cf0c-9462-9ba5-a297-70d13a063de1@linaro.org/
> > > > 
> > > > Will give Dmitry a few more days first before I take both series.
> > > 
> > > Then let's keep your Rb for entire patchset:
> > > 
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > I am sorry but what series/branch this series is based on? I tried
> > applying but there are conflicts. The latest I have that is touching
> > gpio-keys.yaml is:
> > 
> > 4fda8a2df83a dt-bindings: input: use generic node names
> 
> This one from me:
> 
> https://lore.kernel.org/all/20220608211207.2058487-1-robh@kernel.org/

Ah, I see, thank you. Applied the lot.


-- 
Dmitry
