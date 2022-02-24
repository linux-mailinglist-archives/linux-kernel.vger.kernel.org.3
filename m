Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663C4C3077
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiBXP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiBXP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:56:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950F41C60D9;
        Thu, 24 Feb 2022 07:55:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n14so329029wrq.7;
        Thu, 24 Feb 2022 07:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iODWQjpfwDqE/Br8oYICu9NFEv90Of96XMHQf2viFYk=;
        b=BaYLGMDy19kCChj72sx+54gEnmCzKoIlx6L+PwJ5CIP+h4Fx3csRfKu0xmjT5kGZfG
         3KM05jWO1oGLjOdImPapWscAH9rAR3OlxSAiVC1T1PT3xqpEx74K7j1WxCFWIMTHeeRp
         JWZ/Mn9KKFWu/geN3u53JpUN1G+DZJ8wuH/ktcMoWwdinFYGDaRzFVSjp+L2PSpTzWij
         bR0QYr85BXT9n/2SyGmM/4mxkezupZuP8/r6noPXJn9gM7I1Z4uHW7ufzMXr0qk5OGKz
         ZK5GWsVxJExuDADqmXhbMVZgAB4EZp2QX1OkG93C2S+TGTkld8YBjIrStmlkR8PjpgSV
         ilLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iODWQjpfwDqE/Br8oYICu9NFEv90Of96XMHQf2viFYk=;
        b=PuOCFd+3CeQgas58Ke+rI+7gVBzpwf4mKAZ5ERYmhbV01PdByUWTHbfZxH3SyjESYO
         USv9wxFUw6a7HV40RQr4z0bmclyQzFsj095l5y09gXB0E2/GJBcLnDU6JszyW5O2gyY9
         rU011DXLFnQx9l0h9TeKy5AeuGGRCD5yJTvQAmZeKzypIx3v3PnZ/saV+Pl+oIHwaDd6
         oJEx9p+jC1EoOz/6/LXDRyIxNh/Rjs8LcMfqJ+RD2sXV63XmkCviaoR5Nuoqc0g3ORJI
         jvG8d0xinuEHRGcnJ+uh35YLE00M0TnYWmnNM2fHMib10p3cRITm1W/0QzX14xGCOTTU
         msYA==
X-Gm-Message-State: AOAM530/U/s5cNITvr/nO1icZLj6SF2WqPjlxGLMXtqDcwaAiVe0Mcoz
        7ybmu6QT8yZvkG9sTlu3Q4o=
X-Google-Smtp-Source: ABdhPJwWyrnXPCCtbgfwBkH7qs9CtFBC8t1MENopbNRBxP8vKQfIPJ00hnn8jHDBGhSdOM4kHa/jxQ==
X-Received: by 2002:adf:c00b:0:b0:1ed:a100:d62 with SMTP id z11-20020adfc00b000000b001eda1000d62mr2703962wre.266.1645718154901;
        Thu, 24 Feb 2022 07:55:54 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.gmail.com with ESMTPSA id b11sm4089713wrd.31.2022.02.24.07.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:55:54 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:55:17 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] clk: qcom: gcc-ipq806x: add additional freq nss
 cores
Message-ID: <YheqZag1q6U8Gx8Y@Ansuel-xps.localdomain>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-9-ansuelsmth@gmail.com>
 <YhcBpBflfTd5/BNF@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhcBpBflfTd5/BNF@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:55:16PM -0600, Bjorn Andersson wrote:
> On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:
> 
> > Ipq8065 SoC (an evolution of ipq8064 SoC) contains nss cores that can be
> > clocked to 800MHz. Add these missing freq to the gcc driver.
> > 
> 
> Do we somehow need to ensure that these new frequencies are only
> available on 8065?
> 
> Regards,
> Bjorn
>

In theory ipq8064 can run the nss cores to this freq. Do you have any
suggestion on how to limit these 2 clock to the different compatible?

> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq806x.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> > index a4bf78fe8678..53a61860063d 100644
> > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > @@ -232,7 +232,9 @@ static struct clk_regmap pll14_vote = {
> >  
> >  static struct pll_freq_tbl pll18_freq_tbl[] = {
> >  	NSS_PLL_RATE(550000000, 44, 0, 1, 0x01495625),
> > +	NSS_PLL_RATE(600000000, 48, 0, 1, 0x01495625),
> >  	NSS_PLL_RATE(733000000, 58, 16, 25, 0x014b5625),
> > +	NSS_PLL_RATE(800000000, 64, 0, 1, 0x01495625),
> >  };
> >  
> >  static struct clk_pll pll18 = {
> > @@ -2702,7 +2704,9 @@ static const struct freq_tbl clk_tbl_nss[] = {
> >  	{ 110000000, P_PLL18, 1, 1, 5 },
> >  	{ 275000000, P_PLL18, 2, 0, 0 },
> >  	{ 550000000, P_PLL18, 1, 0, 0 },
> > +	{ 600000000, P_PLL18, 1, 0, 0 },
> >  	{ 733000000, P_PLL18, 1, 0, 0 },
> > +	{ 800000000, P_PLL18, 1, 0, 0 },
> >  	{ }
> >  };
> >  
> > -- 
> > 2.34.1
> > 

-- 
	Ansuel
