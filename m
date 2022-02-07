Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C585A4AC935
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiBGTIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbiBGTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:02:12 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E858EC0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:02:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id on2so5419480pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQnU4mgIWrBNoLV8jv6rFk8zS91iwdIqk2USeq5Mhxk=;
        b=yVhUjLEkQKlp3GP5S64o/vbONxt/pzG3kHpX1nlRL1yVJ0vnG0MUYNa2QrW6binj96
         AiVQztwurmDh1jc47Y6EdFO4p9sikXFJHvJIneMBNhKLB2Jk5/oW2ZK3dRUkIb1mnf3C
         KN30jwyv5RmVSeDuupSX6pa1rwtx9jHk5X0VfvEYfVGL6c0HrumRzx/lEGZalLyogh5s
         e8vfzQrHS1Jyo1KlFjZOJGHq40bf+sGGkp3+e7D4vfJgYujPN4UnPa+bCpBoXqydpRfq
         THpqHxymW48MJaGVU6Du7sEWWduGJPMM3dYIT352/C8zYSR5BizGsRF/uxl/wKPguwkN
         RBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQnU4mgIWrBNoLV8jv6rFk8zS91iwdIqk2USeq5Mhxk=;
        b=IwYmm9H0FyORkrx9PbULOPtLdWuvqB8gWq21+c+bub5wJfaZV0q9HxGXBtAsFgVhYP
         ZOgUTaODB8CRi4DCmgpLSywaeOEtx6IVOPyCxriTLSgR7LeG9KTFxkypDFpkZEcw430V
         FSkhzqISCJR2NtiXlTCRzAHCYX3k5+JDtJp0n1b7whYV+Rr0a4gJvlz+dUnwoAW+xMav
         g/7wnjVhiw9U3CRI0kf0GASH2VPBjSZ0I60Gl2cfPEDC9o638ay3zHN7G5t0bdXMft4y
         SruP6jcUbGWcc9eyv1KV20eCJCY1ejM0vjhdGICXrt0bitvLq3qQdWuM1+9m13kqTmKI
         HusQ==
X-Gm-Message-State: AOAM530YKzztHNFhb7ds0H7cFnb2XwmeWWnicZb5vEw7F7DTumJcR8xu
        LLLBoMcQPM77TwRwdrSneKJcLA==
X-Google-Smtp-Source: ABdhPJzDFBpb/xo1QLzfzyfXb6Z4kU7LnZJqaraM0ohpSMV4okAPEWVx5ZG0BGMefv35wACp1PZ2sQ==
X-Received: by 2002:a17:902:7603:: with SMTP id k3mr750552pll.160.1644260531041;
        Mon, 07 Feb 2022 11:02:11 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h11sm12149802pfe.214.2022.02.07.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:02:09 -0800 (PST)
Date:   Mon, 7 Feb 2022 12:02:07 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     James Clark <james.clark@arm.com>, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        mike.leach@linaro.org, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] coresight: Make ETM4x TRCIDR0 register accesses
 consistent with sysreg.h
Message-ID: <20220207190207.GB3355405@p14s>
References: <20220203120604.128396-1-james.clark@arm.com>
 <20220203120604.128396-2-james.clark@arm.com>
 <1b649955-cb45-1283-68cd-c82582cef60c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b649955-cb45-1283-68cd-c82582cef60c@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 11:14:50AM +0530, Anshuman Khandual wrote:
> Hi James,
> 
> These are all ETM4X specific changes. Something like this might be cleaner
> and also more compact. Also would suggest to follow the same for subsequent
> patches as well.
> 
> coresight: etm4x: Cleanup TRCIDR0 register accesses
> 
> Consistency with sysreg.h could be mentioned in the commit message itself.
>

I agree with the above two comments.

> On 2/3/22 5:35 PM, James Clark wrote:
> > This is a no-op change for style and consistency and has no effect on the
> > binary produced by gcc-11.
> 
> This patch adds register definitions, helper macros as well. Please expand
> the commit message to add more details. This is too short, for the change
> it creates. BTW why is it necessary to mention GCC version number here.
> 

Here too - I'm not sure adding gcc's version number helps in any way.

> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  .../coresight/coresight-etm4x-core.c          | 36 +++++--------------
> >  drivers/hwtracing/coresight/coresight-etm4x.h | 17 +++++++++
> >  drivers/hwtracing/coresight/coresight-priv.h  |  5 +++
> >  3 files changed, 30 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index e2eebd865241..107e81948f76 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -1091,41 +1091,21 @@ static void etm4_init_arch_data(void *info)
> >  	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
> >  
> >  	/* INSTP0, bits[2:1] P0 tracing support field */
> > -	if (BMVAL(etmidr0, 1, 2) == 0b11)
> > -		drvdata->instrp0 = true;
> > -	else
> > -		drvdata->instrp0 = false;
> > -
> > +	drvdata->instrp0 = !!(REG_VAL(etmidr0, TRCIDR0_INSTP0) == 0b11);
> >  	/* TRCBB, bit[5] Branch broadcast tracing support bit */
> > -	if (BMVAL(etmidr0, 5, 5))
> > -		drvdata->trcbb = true;
> > -	else
> > -		drvdata->trcbb = false;
> > -
> > +	drvdata->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
> >  	/* TRCCOND, bit[6] Conditional instruction tracing support bit */
> > -	if (BMVAL(etmidr0, 6, 6))
> > -		drvdata->trccond = true;
> > -	else
> > -		drvdata->trccond = false;
> > -
> > +	drvdata->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
> >  	/* TRCCCI, bit[7] Cycle counting instruction bit */
> > -	if (BMVAL(etmidr0, 7, 7))
> > -		drvdata->trccci = true;
> > -	else
> > -		drvdata->trccci = false;
> > -
> > +	drvdata->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
> >  	/* RETSTACK, bit[9] Return stack bit */
> > -	if (BMVAL(etmidr0, 9, 9))
> > -		drvdata->retstack = true;
> > -	else
> > -		drvdata->retstack = false;
> > -
> > +	drvdata->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
> >  	/* NUMEVENT, bits[11:10] Number of events field */
> > -	drvdata->nr_event = BMVAL(etmidr0, 10, 11);
> > +	drvdata->nr_event = REG_VAL(etmidr0, TRCIDR0_NUMEVENT);
> >  	/* QSUPP, bits[16:15] Q element support field */
> > -	drvdata->q_support = BMVAL(etmidr0, 15, 16);
> > +	drvdata->q_support = REG_VAL(etmidr0, TRCIDR0_QSUPP);
> >  	/* TSSIZE, bits[28:24] Global timestamp size field */
> > -	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
> > +	drvdata->ts_size = REG_VAL(etmidr0, TRCIDR0_TSSIZE);
> >  
> >  	/* maximum size of resources */
> >  	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> > index 3c4d69b096ca..2bd8ad953b8e 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> > @@ -130,6 +130,23 @@
> >  
> >  #define TRCRSR_TA			BIT(12)
> >  
> > +/*
> > + * Bit positions of registers that are defined above, in the sysreg.h style
> > + * of _MASK, _SHIFT and BIT().
> > + */
> 
> ^^^ not really necessary. Instead the format requirement for below mentioned
> CORESIGHT_REG_VAL() macro might be relevant and should be mentioned.

I'm not sure if you're asking to move the comment further below or remove it
altogether.  In any case more comments is always better than less.

> 
> > +#define TRCIDR0_INSTP0_SHIFT			1
> > +#define TRCIDR0_INSTP0_MASK			GENMASK(1, 0)
> > +#define TRCIDR0_TRCBB				BIT(5)
> > +#define TRCIDR0_TRCCOND				BIT(6)
> > +#define TRCIDR0_TRCCCI				BIT(7)
> > +#define TRCIDR0_RETSTACK			BIT(9)
> > +#define TRCIDR0_NUMEVENT_SHIFT			10
> > +#define TRCIDR0_NUMEVENT_MASK			GENMASK(1, 0)
> > +#define TRCIDR0_QSUPP_SHIFT			15
> > +#define TRCIDR0_QSUPP_MASK			GENMASK(1, 0)
> > +#define TRCIDR0_TSSIZE_SHIFT			24
> > +#define TRCIDR0_TSSIZE_MASK			GENMASK(4, 0)
> > +
> >  /*
> >   * System instructions to access ETM registers.
> >   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> > index ff1dd2092ac5..1452c6038421 100644
> > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> > @@ -36,6 +36,11 @@
> >  
> >  #define TIMEOUT_US		100
> >  #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
> > +/*
> > + * Extract a field from a register where field is #defined in the form
> > + * <register_name>_<field_name>_MASK and <register_name>_<field_name>_SHIFT
> > + */
> 
> Looking at the usage, <register_name> is already embedded in <filed_name>. So
> it requires <field_name>_SHIFT and <field_name>_MASK instead. Unless register
> name should be passed as separate argument (which actually might be better).
> 
> REG_VAL(etmidr0, TRCIDR0_TSSIZE) ----> REG_VAL(etmidr0, TRCIDR0, TSSIZE)

I don't have strong preference, I'm good either way.

> 
> with some restructuring in the comment ..
> 
> /*
>  * Extract a field from a coresight register
>  *
>  * Required fields are defined as macros like the following
>  *  
>  * <register_name>_<field_name>_MASK and <register_name>_<field_name>_SHIFT
>  */
> 
> > +#define REG_VAL(val, field)	((val & (field##_MASK << field##_SHIFT)) >> field##_SHIFT)
> 
> This is too generic to be in a coresight header or it should just be
> named CORESIGHT_REG_VAL() instead, making it more specific for here.
> 
> The build should fail in case any required macro definition is absent.
> I guess no more fortification is required in case macros are missing.
> 
> However CORESIGHT_REG_VAL() is better placed in <coresight-etm4x.h>
> just before all the dependent SHIFT/MASK register field definition
> starts.
> 

Not sure about this...  Someone might want to do the same for etmv3 and in that
case we'll end up moving the macro again.

Thanks,
Mathieu

> >  
> >  #define ETM_MODE_EXCL_KERN	BIT(30)
> >  #define ETM_MODE_EXCL_USER	BIT(31)
> > 
> 
> - Anshuman
