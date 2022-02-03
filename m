Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED244A837F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiBCMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:05:48 -0500
Received: from foss.arm.com ([217.140.110.172]:42394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235558AbiBCMFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:05:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9967311D4;
        Thu,  3 Feb 2022 04:05:44 -0800 (PST)
Received: from bogus (unknown [10.57.41.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BCAD3F774;
        Thu,  3 Feb 2022 04:05:43 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:04:56 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org
Subject: Re: [PATCH] coresight: trbe: Move check for kernelspace unmapped at
 EL0 to probe
Message-ID: <20220203101111.mx3o5kmo2bkjirn4@bogus>
References: <20220201122212.3009461-1-sudeep.holla@arm.com>
 <01a43ba2-a633-f215-a688-2bda293b5a47@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a43ba2-a633-f215-a688-2bda293b5a47@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 11:55:58AM +0530, Anshuman Khandual wrote:
> 
> 
> On 2/1/22 5:52 PM, Sudeep Holla wrote:
> > Currently with the check present in the module initialisation, it shouts
> > on all the systems irrespective of presence of coresight trace buffer
> > extensions.
> 
> IIUC a system with CONFIG_CORESIGHT_TRBE enabled but without a TRBE DT
> i.e "arm,trace-buffer-extension" complains about kernel space unmapping
> at EL0 (even though it does not even really have TRBE HW to initialize).


Correct. Basically, this error will be seen on all systems(DT and ACPI) when
the module is compiled. It really doesn't matter if the system supports TRBE.

> > 
> > Similar to Arm SPE perf driver, move the check for kernelspace unmapping
> > when running at EL0 to the device probe instead of module initialisation.
> 
> Makes sense.
>

Thanks.

> > 
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: coresight@lists.linaro.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-trbe.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> > index 276862c07e32..3fe2ce1ba5bf 100644
> > --- a/drivers/hwtracing/coresight/coresight-trbe.c
> > +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> > @@ -1423,6 +1423,11 @@ static int arm_trbe_device_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	int ret;
> >  
> 
> Could you please add a similar comment like SPE driver regarding how
> the TRBE buffer will be inaccessible, if kernel gets unmapped at EL0
> and trace capture will terminate.
>

Sure I can add that. But if the device probe fails, will you be able to even
start the trace capture, sorry I didn't get what you mean by "trace capture
will terminate". I assume it must be "trace capture is not possible or not
allowed" IIUC.

-- 
Regards,
Sudeep
