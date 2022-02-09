Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8114AEE30
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiBIJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:39:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiBIJdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:33:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD9AE05ADE1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:33:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q7so2861756wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vD+/Cmu1Qo/Y2K+tLoqBHl5G/I2HgHP3zBZQPgA76XU=;
        b=UE1ENqV54hus9qyKzyTo4+aJMKOa7Gfuj5kSXgr12/DrBx2E3f+/lze2MSXf19Wjr3
         s8mijdNdLwW25Xa22N6izIjsluhrnI5XXht8rmVNKK5DLUOOWNOI29aOv2bjZLXygexx
         buElQp7T1PBaDGMXsP6QWFJCDZgvONxxTfjuSTwMcC2HLVo7imZPJo5J2V12ryO75P/u
         wP/TgCVqbyZYT7RT4Q7ZHIcbPTduh6ZCRH/ClCb2u+Ma9e4f5GSpL2aZbtj2gGUdJjVE
         ZPVArEFUMRBFkgUXKh2DrS6usck0tziNMd7Kh+G+yUPzVEBs70/w/kGgKUwtQbfhIM3a
         j8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vD+/Cmu1Qo/Y2K+tLoqBHl5G/I2HgHP3zBZQPgA76XU=;
        b=76JfVLRoV2L6BR4Y0E8QdsnRlymBwpymqcOyD/1emttCU/uAzfnnX+KO1m/EgCsmOZ
         yNq4Me83saDCVwnM5q2RbgZiwTh3iHgpjFwjQoUVu5hbQeoJMBrHhC3fR6Zf3lpvIO1K
         XLb0fV/IGC7vBdgtelUnRLLgWhAvuh3UCLtLPAvaYqJlnUqzLTakKENwCcqseRgXzYCZ
         mLRxHVrw7oRhQUnrNQG77xaJLE+SykPl5dhC1JDSFyd6Ld64kL7Jrp4JOV4f9NthD1ag
         QQithrBQxc9dOD9EMTJjsFoAa6bPktzefNIU/JH8I5Tk5aGBfxM5HJF468EC+9U4YCpV
         D7Gw==
X-Gm-Message-State: AOAM533jgcE+y1SO0MiSOfKLKX1Gf6OUmpFjU7ZflRWMFOllTATcqhKx
        gBeryePwirIBWEiKuogxZDq+DqitDRPvlVh/WUeO3Q==
X-Google-Smtp-Source: ABdhPJyZDacMwjglnsU7XGk9iLjX9iJ0g23M7rUy18zgTzfpJeurAK8DrcUeBy/mGNKTxVFS4gz+ofK2DEhu8fUPJpc=
X-Received: by 2002:a5d:5850:: with SMTP id i16mr1298418wrf.519.1644399186067;
 Wed, 09 Feb 2022 01:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20220203120604.128396-1-james.clark@arm.com> <20220203120604.128396-2-james.clark@arm.com>
 <1b649955-cb45-1283-68cd-c82582cef60c@arm.com> <7ba34443-d76a-253d-d112-4100d5a57e21@arm.com>
In-Reply-To: <7ba34443-d76a-253d-d112-4100d5a57e21@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 9 Feb 2022 09:32:54 +0000
Message-ID: <CAJ9a7Vj4TRmxkiGi=OMx3iYxWjD0me7AS25BnyvBktHRCCb_GQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] coresight: Make ETM4x TRCIDR0 register accesses
 consistent with sysreg.h
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        James Clark <James.Clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

When reviewing another patch set I spotted that there is a FIELD_GET
macro already defined for the kernel in include/linux/bitfield.h

Advantage of this is that you only need to define a shifted mask for
each field and the macro handles the extraction and shifting
automatically.
It also ensures does a bunch of compile time sanity checks to ensure
that the masks are in range for the type.

i.e. - define the mask _with_ the shift
#define TRCIDR0_INSTP0_MASK                    GENMASK(2, 1)

then
drvdata->instrp0 = !!(FIELD_GET(TRCIDR0_INSTP0_MASK, etmidr0) == 0b11);

which means all the shift #defines can be dropped

Should we use this and drop the REG_VAL or whatever?

Regards

Mike

On Tue, 8 Feb 2022 at 15:04, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 07/02/2022 05:44, Anshuman Khandual wrote:
> > Hi James,
> >
> > These are all ETM4X specific changes. Something like this might be cleaner
> > and also more compact. Also would suggest to follow the same for subsequent
> > patches as well.
> >
> > coresight: etm4x: Cleanup TRCIDR0 register accesses
> >
> > Consistency with sysreg.h could be mentioned in the commit message itself.
> >
> > On 2/3/22 5:35 PM, James Clark wrote:
> >> This is a no-op change for style and consistency and has no effect on the
> >> binary produced by gcc-11.
> >
> > This patch adds register definitions, helper macros as well. Please expand
> > the commit message to add more details. This is too short, for the change
> > it creates. BTW why is it necessary to mention GCC version number here.
> >
> >>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>   .../coresight/coresight-etm4x-core.c          | 36 +++++--------------
> >>   drivers/hwtracing/coresight/coresight-etm4x.h | 17 +++++++++
> >>   drivers/hwtracing/coresight/coresight-priv.h  |  5 +++
> >>   3 files changed, 30 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> index e2eebd865241..107e81948f76 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> @@ -1091,41 +1091,21 @@ static void etm4_init_arch_data(void *info)
> >>      etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
> >>
> >>      /* INSTP0, bits[2:1] P0 tracing support field */
> >> -    if (BMVAL(etmidr0, 1, 2) == 0b11)
> >> -            drvdata->instrp0 = true;
> >> -    else
> >> -            drvdata->instrp0 = false;
> >> -
> >> +    drvdata->instrp0 = !!(REG_VAL(etmidr0, TRCIDR0_INSTP0) == 0b11);
> >>      /* TRCBB, bit[5] Branch broadcast tracing support bit */
> >> -    if (BMVAL(etmidr0, 5, 5))
> >> -            drvdata->trcbb = true;
> >> -    else
> >> -            drvdata->trcbb = false;
> >> -
> >> +    drvdata->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
> >>      /* TRCCOND, bit[6] Conditional instruction tracing support bit */
> >> -    if (BMVAL(etmidr0, 6, 6))
> >> -            drvdata->trccond = true;
> >> -    else
> >> -            drvdata->trccond = false;
> >> -
> >> +    drvdata->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
> >>      /* TRCCCI, bit[7] Cycle counting instruction bit */
> >> -    if (BMVAL(etmidr0, 7, 7))
> >> -            drvdata->trccci = true;
> >> -    else
> >> -            drvdata->trccci = false;
> >> -
> >> +    drvdata->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
> >>      /* RETSTACK, bit[9] Return stack bit */
> >> -    if (BMVAL(etmidr0, 9, 9))
> >> -            drvdata->retstack = true;
> >> -    else
> >> -            drvdata->retstack = false;
> >> -
> >> +    drvdata->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
> >>      /* NUMEVENT, bits[11:10] Number of events field */
> >> -    drvdata->nr_event = BMVAL(etmidr0, 10, 11);
> >> +    drvdata->nr_event = REG_VAL(etmidr0, TRCIDR0_NUMEVENT);
> >>      /* QSUPP, bits[16:15] Q element support field */
> >> -    drvdata->q_support = BMVAL(etmidr0, 15, 16);
> >> +    drvdata->q_support = REG_VAL(etmidr0, TRCIDR0_QSUPP);
> >>      /* TSSIZE, bits[28:24] Global timestamp size field */
> >> -    drvdata->ts_size = BMVAL(etmidr0, 24, 28);
> >> +    drvdata->ts_size = REG_VAL(etmidr0, TRCIDR0_TSSIZE);
> >>
> >>      /* maximum size of resources */
> >>      etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> >> index 3c4d69b096ca..2bd8ad953b8e 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> >> @@ -130,6 +130,23 @@
> >>
> >>   #define TRCRSR_TA                  BIT(12)
> >>
> >> +/*
> >> + * Bit positions of registers that are defined above, in the sysreg.h style
> >> + * of _MASK, _SHIFT and BIT().
> >> + */
> >
> > ^^^ not really necessary. Instead the format requirement for below mentioned
> > CORESIGHT_REG_VAL() macro might be relevant and should be mentioned.
> >
> >> +#define TRCIDR0_INSTP0_SHIFT                        1
> >> +#define TRCIDR0_INSTP0_MASK                 GENMASK(1, 0)
> >> +#define TRCIDR0_TRCBB                               BIT(5)
> >> +#define TRCIDR0_TRCCOND                             BIT(6)
> >> +#define TRCIDR0_TRCCCI                              BIT(7)
> >> +#define TRCIDR0_RETSTACK                    BIT(9)
> >> +#define TRCIDR0_NUMEVENT_SHIFT                      10
> >> +#define TRCIDR0_NUMEVENT_MASK                       GENMASK(1, 0)
> >> +#define TRCIDR0_QSUPP_SHIFT                 15
> >> +#define TRCIDR0_QSUPP_MASK                  GENMASK(1, 0)
> >> +#define TRCIDR0_TSSIZE_SHIFT                        24
> >> +#define TRCIDR0_TSSIZE_MASK                 GENMASK(4, 0)
> >> +
> >>   /*
> >>    * System instructions to access ETM registers.
> >>    * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> >> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> >> index ff1dd2092ac5..1452c6038421 100644
> >> --- a/drivers/hwtracing/coresight/coresight-priv.h
> >> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> >> @@ -36,6 +36,11 @@
> >>
> >>   #define TIMEOUT_US         100
> >>   #define BMVAL(val, lsb, msb)       ((val & GENMASK(msb, lsb)) >> lsb)
> >> +/*
> >> + * Extract a field from a register where field is #defined in the form
> >> + * <register_name>_<field_name>_MASK and <register_name>_<field_name>_SHIFT
> >> + */
> >
> > Looking at the usage, <register_name> is already embedded in <filed_name>. So
> > it requires <field_name>_SHIFT and <field_name>_MASK instead. Unless register
> > name should be passed as separate argument (which actually might be better).
> >
> > REG_VAL(etmidr0, TRCIDR0_TSSIZE) ----> REG_VAL(etmidr0, TRCIDR0, TSSIZE)
>
> I don't see much difference here. So I am fine either way.
>
> >
> > with some restructuring in the comment ..
> >
> > /*
> >   * Extract a field from a coresight register
> >   *
> >   * Required fields are defined as macros like the following
> >   *
> >   * <register_name>_<field_name>_MASK and <register_name>_<field_name>_SHIFT
> >   */
> >
> >> +#define REG_VAL(val, field) ((val & (field##_MASK << field##_SHIFT)) >> field##_SHIFT)
> >
> > This is too generic to be in a coresight header or it should just be
> > named CORESIGHT_REG_VAL() instead, making it more specific for here.
> >
> > The build should fail in case any required macro definition is absent.
> > I guess no more fortification is required in case macros are missing.
> >
> > However CORESIGHT_REG_VAL() is better placed in <coresight-etm4x.h>
> > just before all the dependent SHIFT/MASK register field definition
> > starts.
>
> Not necessarily. CORESIGHT_REG_VAL() is a generic function and doesn't
> have anything specific to do with etm4x. We could reuse that for
> cleaning up other drivers in CoreSight.
>
> Cheers
> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
