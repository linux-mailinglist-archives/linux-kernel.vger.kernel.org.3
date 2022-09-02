Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B715AB520
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiIBP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiIBP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B44D11170
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9262861EA0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D80C433C1;
        Fri,  2 Sep 2022 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662130943;
        bh=fjq5s3JQ2Tmnv1qbYlny3IuIn2WM1CPEyrlgYcbbBxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DddFvVo+kuaiJE65wFuxkgBXSlmKxa8DWfUzx7m4FW98w0JsWTwP8aRM0c4m5AWj2
         qDJwpSrozEtkHMIDYpw1tnBTxjwfawwaQ1SDnLrR7NtApMSH/kXxN6HB3d5M5WiGLQ
         B2woUAnz07aV+1TbgqHGjiytZomkYxydSMYyYgzyyjuasRPPq5KRev5b74NOMM+5Ft
         gzMK7ujhaauTC7RLXrGb3lS3MxvHJ14xpHa87LU/nwfqM1dnbaQNCK4D3B8BR3kSOm
         /4wDllByVD4gpKS/0m2BjeX8AZPslrumRy+4wvq+NYj+Z9a5hh+GpCihTFa+dUuEr5
         AhN0P76+LY/tg==
Date:   Fri, 2 Sep 2022 08:02:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: cti-sysfs: Mark coresight_cti_reg_store() as
 __maybe_unused
Message-ID: <YxIa/Chdh5L0wrYp@dev-arch.thelio-3990X>
References: <20220901195055.1932340-1-nathan@kernel.org>
 <54e034aa-4012-e6f1-c0f3-325d8fe0f4c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e034aa-4012-e6f1-c0f3-325d8fe0f4c1@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:03:07PM +0100, James Clark wrote:
> 
> 
> On 01/09/2022 20:50, Nathan Chancellor wrote:
> > When building without CONFIG_CORESIGHT_CTI_INTEGRATION_REGS, there is a
> > warning about coresight_cti_reg_store() being unused in the file:
> > 
> >   drivers/hwtracing/coresight/coresight-cti-sysfs.c:184:16: warning: 'coresight_cti_reg_store' defined but not used [-Wunused-function]
> >     184 | static ssize_t coresight_cti_reg_store(struct device *dev,
> >         |                ^~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This is expected as coresight_cti_reg_store() is only used in the
> > coresight_cti_reg_rw macro, which is only used in a block guarded by
> > CONFIG_CORESIGHT_CTI_INTEGRATION_REGS. Mark coresight_cti_reg_store() as
> > __maybe_unused to clearly indicate that the function may be unused
> > depending on the configuration.
> 
> It would also be possible to fix this by wrapping the definitions in
> #ifdef CONFIG_CORESIGHT_CTI_INTEGRATION_REGS. That way the maybe_unused
> isn't needed and it's a bit cleaner.

Right, I do not have a preference either. I only did this way first
because most maintainers do not like ifdef's in .c files. I am happy to
change the solution if you all prefer!

> Either way, thanks for the fix.
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks for the review!

Cheers,
Nathan

> > Fixes: fbca79e55429 ("coresight: cti-sysfs: Re-use same functions for similar sysfs register accessors")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-cti-sysfs.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > index 478b8d38b744..6d59c815ecf5 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > @@ -181,9 +181,9 @@ static ssize_t coresight_cti_reg_show(struct device *dev,
> >  }
> >  
> >  /* Write registers with power check only (no enable check). */
> > -static ssize_t coresight_cti_reg_store(struct device *dev,
> > -				       struct device_attribute *attr,
> > -				       const char *buf, size_t size)
> > +static __maybe_unused ssize_t coresight_cti_reg_store(struct device *dev,
> > +						      struct device_attribute *attr,
> > +						      const char *buf, size_t size)
> >  {
> >  	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
> >  	struct cs_off_attribute *cti_attr = container_of(attr, struct cs_off_attribute, attr);
> > 
> > base-commit: 0a98181f805058773961c5ab3172ecf1bf1ed0e1
