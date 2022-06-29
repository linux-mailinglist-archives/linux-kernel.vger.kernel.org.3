Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D671055F542
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiF2E0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiF2E0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:26:41 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B529CA8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:26:39 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-101d2e81bceso19957479fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jnaawprXfmG6ArUjDmhbntHgFsVQlLxhTFgPAPSRwjg=;
        b=GbfLXMPepyfuSUDoSzl1hEaYhjHaRLXMoCmqqAF3K1GY1DSWqSXmtb//WQyA/ESPeq
         I6ljc58JDOAwNh6DRqz0RMZp4ezQst5fJ71hkHM8aWBD45yCd4P6xPVYpDGfpBnOxrwW
         6jyz+8L5KZb9SRFaVhvY5T0VQYAtlDGKU+ToSkA5w3WdtKVhQosMItn78LsshIYrXHyh
         yhIDw86IfqVJE2hsc6rb9ZXJqkPwT3nJr2pufzGS8MpwxlbSbOfIZ0cE4NSgOjDLwrxA
         a5h0gKCmtbpqrXuQGhHu/25uu43bX65zHrmyzZby60eq5fN/oD8kSfb/hcAtwHyv5d4p
         +XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jnaawprXfmG6ArUjDmhbntHgFsVQlLxhTFgPAPSRwjg=;
        b=PQEmTizh5VU7DXfpoefX0WyHZxPdpHnhvovsgg7xrhBAb3bbKfwC6VnkDGIZybj2Z+
         IALEf/aQPoa1EH9Go8iUCw10QYMp/bTTCWBat1jhYvfwy0Q2fnB4yVMb0Imii3UTfOj2
         EfgGGn/FQzXt2D/8j9ARtw+xtqvF/ixgHLtC2oTC8vwteg7uMo1c6WnaO6NYztrqYs7C
         c7JHVCG71cvp3Sb9Ju7nNp12B6pw96hKqHfx+ARIewqmEAx00daI1G6TQgJp66MJsf7Z
         8/Ojf0GJj6XdDVgk+zyfxYu19oaBzJpo+F0xZXBiXdQNx48fmyU6RKrtpmy2wSOyglVY
         oDYA==
X-Gm-Message-State: AJIora9s7s9e2PJK6aHKW+fLaPhFO5cvtA8qawTa+hcdjfZ3JMhl1Xap
        PVdoALxNV0J6aEla9qdlaXvcvw==
X-Google-Smtp-Source: AGRyM1s8YqDFd8J2y9RnBg6GTnJfH3L27GZjHUJC+HsVIpRGgrDooAqn71ss6MXkqOJtgPODQqEyhQ==
X-Received: by 2002:a05:6871:4599:b0:104:8a0a:acb9 with SMTP id nl25-20020a056871459900b001048a0aacb9mr1805588oab.127.1656476798990;
        Tue, 28 Jun 2022 21:26:38 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u5-20020a4a9705000000b0042568efdaccsm8739122ooi.15.2022.06.28.21.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 21:26:38 -0700 (PDT)
Date:   Tue, 28 Jun 2022 23:26:36 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Subject: Re: [PATCH v2 4/6] PM: domains: Store the closest hrtimer event of
 the domain CPUs
Message-ID: <YrvUfJMA3u8w+62v@builder.lan>
References: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
 <1652275016-13423-5-git-send-email-quic_mkshah@quicinc.com>
 <CAPDyKFp+38XR9osX91quAMG6CbLYaAcetgPqFM53rinfT4ar+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp+38XR9osX91quAMG6CbLYaAcetgPqFM53rinfT4ar+Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 May 07:56 CDT 2022, Ulf Hansson wrote:

> On Wed, 11 May 2022 at 15:17, Maulik Shah <quic_mkshah@quicinc.com> wrote:
> >
> > The arch timer can not wake up the Qualcomm Technologies, Inc. (QTI)
> > SoCs when the deepest CPUidle modes results in the SoC also to enter
> > the low power mode.
> >
> > RSC is part of CPU subsystem and APSS rsc device is attached to cluster
> > power domain. RSC has to setup next hrtimer wakeup in CONTROL_TCS which
> > can wakeup the SoC from deepest low power states. The CONTROL_TCS does
> > this by writing next wakeup in always on domain timer when the SoC is
> > entering the low power state.
> >
> > Add dev_pm_genpd_get_next_hrtimer() to get the genpd wakeup time.
> >
> > Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> > ---
> >  drivers/base/power/domain.c          | 24 ++++++++++++++++++++++++
> >  drivers/base/power/domain_governor.c |  1 +
> >  include/linux/pm_domain.h            |  7 +++++++
> >  3 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 18cd796..f0d70d0 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -487,6 +487,29 @@ void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
> >
> > +/**
> > + * dev_pm_genpd_get_next_hrtimer - Return genpd domain next_hrtimer.
> > + *
> > + * @dev: Device to handle
> > + *
> > + * Returns the aggregated domain wakeup time for CPU PM domain
> > + * when all the subdomains are off.
> 
> To further clarify when this function should be used, I think that we
> should state that it should typically be called from a consumer of a
> genpd on/off-notifier at GENPD_NOTIFY_PRE_OFF. This also means that
> the genpd's lock is being held across the function.
> 

Maulik, it seems the only things remaining for this series it resolve
these three comments. Looking forward to be able to merge the next
revision.

Regards,
Bjorn
