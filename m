Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA674D8566
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbiCNMty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242119AbiCNMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:48:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDFE34BAA;
        Mon, 14 Mar 2022 05:43:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p15so33619141ejc.7;
        Mon, 14 Mar 2022 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2vlX4DbLKn7EsX9mBszyL4iwXvVb8LRGjvbGLc+VjE8=;
        b=bvPF8LFBpKtsqY0RirALI6zI9T/YQGwB6H5GhL9/NksMVHupuHBMRHdrfWHdsilUVQ
         BMV8PHtMBlai53snDNFFyTLhYbITIgnUPoBtL7LunC0mN9WilaVLL+bIsO3zepsudSqC
         /iquj6bcH67AFDbfE2DpEzQKbna6NnpG5xMqREd2wg+8nOxpgIqiMtfNtjx/sVl3Fk23
         mLJ66+WydlCGg+Rd/UkuQ9zg0wwY4E+XDhoxCzLPCLtJmgurctXsPqXVM8IVSNeb8IAY
         CGqElBSo2vK/PrrSC1fSx8+i37XM9c7m6ZikFRzIEnCR5+Bltan35ZLPq44yCYBMLjRN
         s8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2vlX4DbLKn7EsX9mBszyL4iwXvVb8LRGjvbGLc+VjE8=;
        b=A6sTZojNAEXwWXkrWqpqFRWUoVSYR4QXFrKM00N/IqxH7EOgzo0AeVwubqfDq0ZR3P
         5zQonEWjpdHeWYK7F7Vo2V15P5qCGI0s06Cf0BDG2uW/VJH8NlQPHWd83Nq4gsvYOaAq
         hqPnOfRuJZB81Vd/KMee43PmMM5et5ygykTQM+2ED02JY7m5WGjOEgpeF+xGeE5eLIEb
         FgfVDw1wlwiICBcq9ciZxLp9bUP5Gaimn2sHlVkSG1RqZ5ASfULZCqKn5Y95o+/YBMso
         5/uFU+MxSvpFrO2xNvRAWg3J7tkyjfIGRw1B3Ffubr2mP87EdfkfamjF/pzwTXlXj/Bc
         Xk7w==
X-Gm-Message-State: AOAM532I2qditlbgwZjvY0a+efknETpqjLf8oKLw+ixnj2LLdDzDSWbA
        Bc8aNI4IW8qtLm3Z4K12KjZn+1+/VDA=
X-Google-Smtp-Source: ABdhPJzaXnhoIJ/WRBIn60QfuleJTsJl8I0mtZFsE5YKOPQ10wKMUDesQjiWdn+mX0Vk1ByCTAOl1A==
X-Received: by 2002:a17:907:3f9e:b0:6da:842e:873e with SMTP id hr30-20020a1709073f9e00b006da842e873emr18566337ejc.383.1647261802390;
        Mon, 14 Mar 2022 05:43:22 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id ca21-20020aa7cd75000000b004188bc5712fsm1330334edb.73.2022.03.14.05.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 05:43:21 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:43:20 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 12/16] clk: qcom: clk-krait: add 8064 errata workaround
Message-ID: <Yi84aNrJ7p+3jy2A@Ansuel-xps.localdomain>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
 <20220313190419.2207-13-ansuelsmth@gmail.com>
 <169795c1-607e-ee60-7ac7-538ed888bedf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169795c1-607e-ee60-7ac7-538ed888bedf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:20:21AM +0300, Dmitry Baryshkov wrote:
> On 13/03/2022 22:04, Ansuel Smith wrote:
> > Add 8064 errata workaround where the sec_src clock gating needs to be
> 
> Could you please be more specific whether the errata applies only to the
> ipq8064 or to the apq8064 too? 8064 is not specific enough.
>

That's a good question... Problem is that we really don't know the
answer. This errata comes from qsdk on an old sourcecode. I assume this
is specific to ipq8064 and apq8064 have different mux configuration.

> > disabled during switching. To enable this set disable_sec_src_gating in
> > the mux struct.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >   drivers/clk/qcom/clk-krait.c | 16 ++++++++++++++++
> >   drivers/clk/qcom/clk-krait.h |  1 +
> >   drivers/clk/qcom/krait-cc.c  |  1 +
> >   3 files changed, 18 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
> > index d8af281eba0e..82fe7031e1f4 100644
> > --- a/drivers/clk/qcom/clk-krait.c
> > +++ b/drivers/clk/qcom/clk-krait.c
> > @@ -18,13 +18,23 @@
> >   static DEFINE_SPINLOCK(krait_clock_reg_lock);
> >   #define LPL_SHIFT	8
> > +#define SECCLKAGD	BIT(4)
> > +
> >   static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
> >   {
> >   	unsigned long flags;
> >   	u32 regval;
> >   	spin_lock_irqsave(&krait_clock_reg_lock, flags);
> > +
> >   	regval = krait_get_l2_indirect_reg(mux->offset);
> > +
> > +	/* 8064 Errata: disable sec_src clock gating during switch. */
> > +	if (mux->disable_sec_src_gating) {
> > +		regval |= SECCLKAGD;
> > +		krait_set_l2_indirect_reg(mux->offset, regval);
> > +	}
> > +
> >   	regval &= ~(mux->mask << mux->shift);
> >   	regval |= (sel & mux->mask) << mux->shift;
> >   	if (mux->lpl) {
> > @@ -33,6 +43,12 @@ static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
> >   	}
> >   	krait_set_l2_indirect_reg(mux->offset, regval);
> > +	/* 8064 Errata: re-enabled sec_src clock gating. */
> 
> And here too
> 
> > +	if (mux->disable_sec_src_gating) {
> > +		regval &= ~SECCLKAGD;
> > +		krait_set_l2_indirect_reg(mux->offset, regval);
> > +	}
> > +
> >   	/* Wait for switch to complete. */
> >   	mb();
> >   	udelay(1);
> > diff --git a/drivers/clk/qcom/clk-krait.h b/drivers/clk/qcom/clk-krait.h
> > index 9120bd2f5297..f930538c539e 100644
> > --- a/drivers/clk/qcom/clk-krait.h
> > +++ b/drivers/clk/qcom/clk-krait.h
> > @@ -15,6 +15,7 @@ struct krait_mux_clk {
> >   	u8		safe_sel;
> >   	u8		old_index;
> >   	bool		reparent;
> > +	bool		disable_sec_src_gating;
> >   	struct clk_hw	hw;
> >   	struct notifier_block   clk_nb;
> > diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
> > index 1bdc89c097e6..533a770332be 100644
> > --- a/drivers/clk/qcom/krait-cc.c
> > +++ b/drivers/clk/qcom/krait-cc.c
> > @@ -154,6 +154,7 @@ krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
> >   	mux->shift = 2;
> >   	mux->parent_map = sec_mux_map;
> >   	mux->hw.init = &init;
> > +	mux->disable_sec_src_gating = true;
> >   	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
> >   	if (!init.name)
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
