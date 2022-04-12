Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF9F4FDED4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbiDLMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbiDLL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:57:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216DF60D97
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:43:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r13so27057792wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGX8X6X2Ehyp3CB08h/jWEXGYSF3Q3LC7G8ldUitLiM=;
        b=R69XYZdaN1fd0yX4ETYXrlNIRY+BKYM261TzoPKETPWm7a7i/ST4cFceKSap4+uNwt
         uxyHYviRWbmqpO4BvXCyJxpYhkFJ3ptQ0VcdHt1oUYGldOmfK6TIf5JzzXe1sfDrFIyA
         FFY7nLYK+C+ZtIaTWAFzxItJs9od63dK+PoFRUrqXL/z3P8X5isDP++2KnW5shLnzver
         DQ3AP65YWYaxU4VkINbS15I6h8n1WnJbSy7AmfUVboU8wA1m8Ij+Oz9xZppHjLlku2xM
         /LsijyaP/VKUFpDkFTI/MLWmp6JQbmBzEuIs8G7oCe+RH9nb/kaNlse0qx2N6b6K5eiI
         cwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGX8X6X2Ehyp3CB08h/jWEXGYSF3Q3LC7G8ldUitLiM=;
        b=0T17pWv5Lo4MZaXRWCGx1UH5r9NiISLnedzHD/6anfcX8BU0Vi0UIEnesf8MTKTdNB
         /KVf329HhhPYhV1+ePm7w4e/SICKu4AqQxdUIzPX4bXyj9m+P/1qwcQSH1TfooqhJp0y
         bVSXM2dJKSy4Qx9wREuyaidNbQqsMfNBTE2W3WzmAD6CYclm8xe8Aft+SQwJbjh+lVZF
         TPjTUryeJoJgJJNY7Zz6zaS0fbRuKjrzqYPQ0RzJVYhDlFVB3AF+acoD36e8/Em37ivn
         jDZRSY/zaudRRyeCjAseBB6jYirrF4lQ+qPnlqxZJCFC/2z9uyERYO2xDzOHZ24HF5K3
         rA8w==
X-Gm-Message-State: AOAM531sAEuwzRNECAcLVM3+WWDbC2vvo9Hwiy0aYd5X7d6faUKZJ+r0
        um12hfK1O92+SYVh112J39XlbHqjKj7R7iScotdS8A==
X-Google-Smtp-Source: ABdhPJw7rEWfTOIl4mDZMzJ2mNI+aKo3nVbKFc3SXjzJYxpDy0fNrpaaT25RlgSiRjfHPnCzoifKDgOP4kpDwdBwtrs=
X-Received: by 2002:adf:e108:0:b0:1ef:97ad:5372 with SMTP id
 t8-20020adfe108000000b001ef97ad5372mr27808945wrz.658.1649760179725; Tue, 12
 Apr 2022 03:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-16-james.clark@arm.com>
 <20220323161551.GB3248686@p14s>
In-Reply-To: <20220323161551.GB3248686@p14s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 11:42:48 +0100
Message-ID: <CAJ9a7VhiJiRS77MvQg9XirvniwJ9GXD7Z-CzrWfg7T+NBRM+Bw@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] coresight: etm4x: Cleanup TRCRSCTLRn register accesses
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     James Clark <James.Clark@arm.com>, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, Anshuman.Khandual@arm.com,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
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

On Wed, 23 Mar 2022 at 16:15, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Fri, Mar 04, 2022 at 05:19:12PM +0000, James Clark wrote:
> > This is a no-op change for style and consistency and has no effect on
> > the binary output by the compiler. In sysreg.h fields are defined as
> > the register name followed by the field name and then _MASK. This
> > allows for grepping for fields by name rather than using magic numbers.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 7 +++++--
> >  drivers/hwtracing/coresight/coresight-etm4x.h       | 7 +++++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > index 3ae6f4432646..6ea8181816fc 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -1726,8 +1726,11 @@ static ssize_t res_ctrl_store(struct device *dev,
> >       /* For odd idx pair inversal bit is RES0 */
> >       if (idx % 2 != 0)
> >               /* PAIRINV, bit[21] */
> > -             val &= ~BIT(21);
> > -     config->res_ctrl[idx] = val & GENMASK(21, 0);
> > +             val &= ~TRCRSCTLRn_PAIRINV;
> > +     config->res_ctrl[idx] = val & (TRCRSCTLRn_PAIRINV |
> > +                                    TRCRSCTLRn_INV |
> > +                                    TRCRSCTLRn_GROUP_MASK |
> > +                                    TRCRSCTLRn_SELECT_MASK);
> >       spin_unlock(&drvdata->spinlock);
> >       return size;
> >  }
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> > index 15704982357f..2c412841b126 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> > @@ -223,6 +223,13 @@
> >  #define TRCBBCTLR_MODE                               BIT(8)
> >  #define TRCBBCTLR_RANGE_MASK                 GENMASK(7, 0)
> >
> > +#define TRCRSCTLRn_PAIRINV                   BIT(21)
> > +#define TRCRSCTLRn_INV                               BIT(20)
> > +#define TRCRSCTLRn_GROUP_MASK                        GENMASK(19, 16)
> > +#define TRCRSCTLRn_SELECT_MASK                       GENMASK(15, 0)
> > +
> > +
> > +
>
> Two extra lines.
>
> >  /*
> >   * System instructions to access ETM registers.
> >   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> > --
> > 2.28.0
> >


Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
