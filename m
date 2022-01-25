Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAEC49BDA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiAYVDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiAYVDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:03:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27DC06173B;
        Tue, 25 Jan 2022 13:03:04 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id j2so33254937ejk.6;
        Tue, 25 Jan 2022 13:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=srVj70rDHaEW3JWXtpfQ2abF7yDsyKokjCcp0C9aBtA=;
        b=AD6LUjVVP2fLn9T604tZDX8EWEC5T5t8WXyyGj60N2VGZBUdM+Yh2HFL3AyXMIi7rH
         +3SjQfG48jnxjjANgq6UITK4mxXyiEblf3dEoAdX0rkTrWz2vGd0a9CEinak1beW6+Ma
         446/95kDBEerqko6HTrQ6IJiv70cIG3Nu0d/PNzACdqV4YyfTu+Vr8HGtvTq2RNLIDrP
         O2PjjYrLJC+0SAr8k8KlEbCSLtme+eFDB0D2wvhT4udgmcfkvk4ytLa5aXnuHO/McLdG
         5YeH5BdhVMOGVGrP0BAIB+I71IpxWfXetLHl//gZqPfHp1PZfbriQKbs0MieLUmCQJ2Y
         JRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=srVj70rDHaEW3JWXtpfQ2abF7yDsyKokjCcp0C9aBtA=;
        b=6XcWhUv9Nn7dAaX1mQk/uS5nkXmpJOBX/ONgyXdYzm1whxGB+lc5ERJYnhMntJAiFV
         H2eGMPL8eD/GNdLoIqqrqzOtHMZQLO26GlNAcabDUi7pwUyEc3AEkoCQLf/+80cBf3Rs
         aht+D6JawDv3R+iSl8uHvfImEd/1gim9xSF/s9vcS4WWXK1Cq5t5wuDr4aR8oT5hjbz1
         0hYFqCCk8QimOv14kZ3Ol4+YvTT2Thp4/qjWtPEQaghVQg9ReeFuUkBeFF8gvb+f8G/l
         PJEFvc4QWiaKFdVydo8Kk83BdUNzvTmUbmepFi4gKxg8N0tnKFz4TE4bXYFjPkXe5Us0
         GVqg==
X-Gm-Message-State: AOAM532gJMJ0cqBVk8b9HRnTywGRVfSeTjwZ27Bwyk0aQHL8nYaFmpuC
        bfovGmds5miezYYEKH0WmdM=
X-Google-Smtp-Source: ABdhPJwHdFjgTS2R26fopXuL1ehXrliiJkTklVrWO9ZKFPL87zHDDXv16FhUR1eTZd8p81lmw+xy2w==
X-Received: by 2002:a17:907:6d15:: with SMTP id sa21mr14117869ejc.182.1643144583281;
        Tue, 25 Jan 2022 13:03:03 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id c25sm8822444edt.0.2022.01.25.13.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:03:02 -0800 (PST)
Message-ID: <61f06586.1c69fb81.890c7.4462@mx.google.com>
X-Google-Original-Message-ID: <YfBlg1KxzSW3q7s4@Ansuel-xps.>
Date:   Tue, 25 Jan 2022 22:02:59 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/15] dt-bindings: clock: add ipq8064 ce5 clk define
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
 <20220121210340.32362-12-ansuelsmth@gmail.com>
 <20220125204727.D3BC8C340E0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125204727.D3BC8C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:47:26PM -0800, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-01-21 13:03:36)
> > Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  include/dt-bindings/clock/qcom,gcc-ipq806x.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/dt-bindings/clock/qcom,gcc-ipq806x.h b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> > index 7deec14a6dee..02262d2ac899 100644
> > --- a/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> > +++ b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> > @@ -240,7 +240,7 @@
> >  #define PLL14                                  232
> >  #define PLL14_VOTE                             233
> >  #define PLL18                                  234
> > -#define CE5_SRC                                        235
> > +#define CE5_A_CLK                              235
> 
> Technically this is ABI and changing it is bad. I see that CE5_SRC isn't
> used though so I guess it's OK.
>

Consider that this naming comes directly from qsdk so I really don't
know why it was called SRC from the start.

> >  #define CE5_H_CLK                              236
> >  #define CE5_CORE_CLK                           237
> >  #define CE3_SLEEP_CLK                          238
> > @@ -283,5 +283,8 @@
> >  #define EBI2_AON_CLK                           281
> >  #define NSSTCM_CLK_SRC                         282
> >  #define NSSTCM_CLK                             283
> > +#define CE5_A_CLK_SRC                          285
> > +#define CE5_H_CLK_SRC                          286
> > +#define CE5_CORE_CLK_SRC                       287

-- 
	Ansuel
