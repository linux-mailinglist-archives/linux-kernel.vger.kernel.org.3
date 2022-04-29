Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC86B514EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378100AbiD2PMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377609AbiD2PMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:12:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854F1D3DBB;
        Fri, 29 Apr 2022 08:08:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k23so16041214ejd.3;
        Fri, 29 Apr 2022 08:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=YIbyjT2r8wxH+pr14y5kI8od4cD/5ycplR/r+25iEl8=;
        b=K3Y+8q27h7ihuxGrjMIxMcJ/S+nNEulEnI0sV5WSPp2LcCV/WklX+FRXv+wJRUKgiu
         7r6R7gaFUxTNnDkaPnbGCqDRNWBFgl+J6cLEnA1+dtae2nKecCdQ4F0xEu919rv3AWV2
         GnL9ZDK3OMEg12DbidXjINsmf8mGJ/t2vKSdbDIl9bzHw/rJQ9LnmXrqaQIQkwnMymAi
         mYeiSlbLFpY0+uXxeID+C7H7VwwGj03I6VyjZvILZqY1v7ig6NfpLPWzMtm/l+r+C53I
         6mtYQFy7UiBlrbn3vWFECKMSnSp5JyJf9oHv9GgvFAbCM126cZ7I3W0SZCKuf4Cioxew
         kWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=YIbyjT2r8wxH+pr14y5kI8od4cD/5ycplR/r+25iEl8=;
        b=YaZdxb/+zLxlpfbUxtt8y5M9cFWHN5rKwzUS9bkW2/UeGuSx6SHpCX4vk1kU4DP2y3
         MJnmrojmqnHDgrc7cfysxORNhLGEkkA8gvX1ficvU7r9l4PyUgIGH1qZYsD8jMspiBk6
         kLOowVvPg1jTHnRDwU3jvf4Bjw7B+o6g8/DAvc/ogM7njK21azB6QJ/DXEUT2202eWBn
         Z8vh2IrZRefZCfN4jB84o+CDf/2y8uDC7Xn7blXGeHMC4ewSTmkGFhgZLnUUWaVbudNY
         7bLtWG8ESfS16fWvpw5USse7Mmzc9wyPLTS+5QoR1OxnLTlDiRCbHMD6F3wmzWP6gtiv
         Cg/Q==
X-Gm-Message-State: AOAM532vvVTrZxuAXaL4CjvANKKChUjl++xNobCrWJTPr8SmokjTKqPi
        gViA+aeiB9V8iwt+YhU0HNI=
X-Google-Smtp-Source: ABdhPJxbo2NZJ6x8JvhZu+IyZH+PQVEUqNSClptl9EFVeswh4NnNBZ+1BT0dCnE5Jtmv5bQELzkJvQ==
X-Received: by 2002:a17:907:3f0f:b0:6f3:8e24:e9e6 with SMTP id hq15-20020a1709073f0f00b006f38e24e9e6mr26322806ejc.128.1651244926786;
        Fri, 29 Apr 2022 08:08:46 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id jz24-20020a17090775f800b006f3ef214de1sm715201ejc.71.2022.04.29.08.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:08:46 -0700 (PDT)
Message-ID: <626bff7e.1c69fb81.bdf89.4da7@mx.google.com>
X-Google-Original-Message-ID: <Ymv+6382seBj563N@Ansuel-xps.>
Date:   Fri, 29 Apr 2022 17:06:19 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clk: qcom: clk-krait: add hw_parent check for
 div2_round_rate
References: <20220429120108.9396-1-ansuelsmth@gmail.com>
 <20220429120108.9396-4-ansuelsmth@gmail.com>
 <b7de49e0-c0cf-5062-8426-dcb54272d350@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7de49e0-c0cf-5062-8426-dcb54272d350@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:53:32PM +0300, Dmitry Baryshkov wrote:
> On 29/04/2022 15:01, Ansuel Smith wrote:
> > Check if hw_parent is present before calculating the round_rate to
> > prevent kernel panic. On error -EINVAL is reported.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> 
> I see that other clock drivers do not perform this check. Which path leads
> to this oops?
>

This comes from qsdk patches so I apologize in advance about this.

Anyway I'm checking the code and krait-cc is the only user of
krait_div2_clk_ops. That user have as parent only hfpll_something that
is declared by gcc. Now hfpll can also be declared in dts with a
dedicated driver so I wonder if the problem is there in the case when
hfpll is declared in dts and is probed after krait-cc. This is not the
case for ipq8064 but I wonder if qsdk have other krait based device that
have a configuration with hfpll declared in dts.

In short you are right and in our current code the check is uselss and
I'm positive about dropping this patch but I do wonder if downstream
there is an actual use of this. Don't know how to proceed. Any hint?

> > ---
> >   drivers/clk/qcom/clk-krait.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
> > index 90046428693c..6c367ad6506a 100644
> > --- a/drivers/clk/qcom/clk-krait.c
> > +++ b/drivers/clk/qcom/clk-krait.c
> > @@ -84,7 +84,12 @@ EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
> >   static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
> >   				  unsigned long *parent_rate)
> >   {
> > -	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
> > +	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
> > +
> > +	if (!hw_parent)
> > +		return -EINVAL;
> > +
> > +	*parent_rate = clk_hw_round_rate(hw_parent, rate * 2);
> >   	return DIV_ROUND_UP(*parent_rate, 2);
> >   }
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
