Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402C34FFC13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiDMRLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiDMRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:11:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95406AA54
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:08:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t13so2362019pgn.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gb2pwnJxQCeX1p5Gf89t6OOnZOca+zkoLeUQmGIHLHg=;
        b=CPs3vqLTF09CMgTab8x9Ri+G24uOHBXWWWEAUkRO1S+OWraBkrJq2shwEm9GPg7RQp
         8SpZhaUK+5lZROHq9Jucju2hEkLgBcW3G5Vbuyt9DLVRH+PjXVq8DsL7XoKIo1Lcc9Qn
         1K7Hk+G232f2zSFp6O3WQ6xXFiYd1k8EIa1X8azyZZCMcC4P+3rfDVaHoeZrXBXBSM7v
         yhgHkCKe0hV1xvZ8DIkS1+lNs5vPd979sU8m/1Wj/4MoycAgiiRL8pAcIzlLHHLj0HcZ
         t6w2AWyS8gAbuL9gdsnH44PEZaHMXqwEmARFEgff+m8boc/1sys19LTAxZKNKS0NWSPh
         LLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gb2pwnJxQCeX1p5Gf89t6OOnZOca+zkoLeUQmGIHLHg=;
        b=USlpKSxgcjH3i2rwUX2IBxb7sxdkJBo6j9ET8D6iUiybxMnHWjRqMHb6QaukSpAVDf
         OYEdFctL/6CsvHUWCSYjm+m7kvHitNlXg+/t4Wgtz8u8LiVfONoInLY279bxUQx7v0TO
         RwyO4XaAU93HX9S1/2hJQg1g2IYT43nyloNETV+vcXGstLk4p6iRnxx8u/Qhh3EzqpiW
         UgB7FUSDl5u/xALVfSbF6zQzOzs4fbWRt0E2xsLP2TMtMwOs47sQF1zHT41cGamirdk5
         /NS19J0MB6Soav3IZkCwfbFZHHhU6YCHR+6fGRtStTepRaE9OxtLZgXpt6KYbs47F2V1
         OltQ==
X-Gm-Message-State: AOAM530ek73/3yg/4esw5xANC+btBqBoMX3X3LDYi8wPFaJUzvl1g2el
        oZndSyrMUV9EyaVQY/SpNEFKumy7DzCeig==
X-Google-Smtp-Source: ABdhPJzmyeNTjT8payfffo2e+zvZZNQy61/OLXQEWbtTcsIzOAYNKWCGTLx3Omt4qhWj92tC0Y7utw==
X-Received: by 2002:a05:6a00:1a01:b0:505:b3e5:b5fc with SMTP id g1-20020a056a001a0100b00505b3e5b5fcmr18828315pfv.53.1649869728158;
        Wed, 13 Apr 2022 10:08:48 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id rj13-20020a17090b3e8d00b001c77bc09541sm3618780pjb.51.2022.04.13.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:08:46 -0700 (PDT)
Date:   Wed, 13 Apr 2022 11:08:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Make ETM register accesses consistent with
 sysreg.h
Message-ID: <20220413170844.GA547134@p14s>
References: <20220304171913.2292458-1-james.clark@arm.com>
 <20220323162257.GC3248686@p14s>
 <4ef77445-b58d-a71a-0ddc-70e308ea99c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef77445-b58d-a71a-0ddc-70e308ea99c8@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:41:48AM +0100, James Clark wrote:
> 
> 
> On 23/03/2022 16:22, Mathieu Poirier wrote:
> > On Fri, Mar 04, 2022 at 05:18:57PM +0000, James Clark wrote:
> >> Changes since v2:
> >>  * Implement Mike's suggestion of not having _SHIFT and using the existing
> >>    FIELD_GET and FIELD_PREP methods.
> >>  * Dropped the change to add the new REG_VAL macro because of the above.
> >>  * FIELD_PREP could be used in some trivial cases, but in some cases the
> >>    shift is still required but can be calculated with __bf_shf
> >>  * Improved the commit messages.
> >>  * The change is still binary equivalent, but requires an extra step 
> >>    mentioned at the end of this cover letter.
> >>
> >> Applies to coresight/next 3619ee28488
> >> Also available at https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-cs-register-refactor-v3
> >>
> >> To check for binary equivalence follow the same steps in the cover letter
> >> of v2, but apply the following change to coresight-priv.h. This is because
> >> the existing version of the macros wrap the expression in a new scope {}
> >> that flips something in the compiler:
> >>
> >>   #undef FIELD_GET
> >>   #define FIELD_GET(_mask, _reg) (((_reg) & (_mask)) >> __bf_shf(_mask))
> >>   #undef FIELD_PREP
> >>   #define FIELD_PREP(_mask, _val) (((_val) << __bf_shf(_mask)) & (_mask))
> >>
> >> Thanks
> >> James
> >>
> >> James Clark (15):
> >>   coresight: etm4x: Cleanup TRCIDR0 register accesses
> >>   coresight: etm4x: Cleanup TRCIDR2 register accesses
> >>   coresight: etm4x: Cleanup TRCIDR3 register accesses
> >>   coresight: etm4x: Cleanup TRCIDR4 register accesses
> >>   coresight: etm4x: Cleanup TRCIDR5 register accesses
> >>   coresight: etm4x: Cleanup TRCCONFIGR register accesses
> >>   coresight: etm4x: Cleanup TRCEVENTCTL1R register accesses
> >>   coresight: etm4x: Cleanup TRCSTALLCTLR register accesses
> >>   coresight: etm4x: Cleanup TRCVICTLR register accesses
> >>   coresight: etm3x: Cleanup ETMTECR1 register accesses
> >>   coresight: etm4x: Cleanup TRCACATRn register accesses
> >>   coresight: etm4x: Cleanup TRCSSCCRn and TRCSSCSRn register accesses
> >>   coresight: etm4x: Cleanup TRCSSPCICRn register accesses
> >>   coresight: etm4x: Cleanup TRCBBCTLR register accesses
> >>   coresight: etm4x: Cleanup TRCRSCTLRn register accesses
> >>
> >>  .../coresight/coresight-etm3x-core.c          |   2 +-
> >>  .../coresight/coresight-etm3x-sysfs.c         |   2 +-
> >>  .../coresight/coresight-etm4x-core.c          | 136 +++++--------
> >>  .../coresight/coresight-etm4x-sysfs.c         | 180 +++++++++---------
> >>  drivers/hwtracing/coresight/coresight-etm4x.h | 122 ++++++++++--
> >>  5 files changed, 244 insertions(+), 198 deletions(-)
> > 
> > I am done reviewing this set.  I will wait until rc1 or rc2 before moving
> > forward.  If there are other comments needing a respin then I will wait for the
> > next revision.  Otherwise I will apply this one after correcting the extra lines
> > at the end of patch 15.
> >  
> 
> Thanks for the review!
>

I have applied this set.

> > Thanks,
> > Mathieu
> > 
> >>
> >> -- 
> >> 2.28.0
> >>
