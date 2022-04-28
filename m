Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0865135AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347692AbiD1NxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiD1NxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:53:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BC85B3C47
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:49:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E905D1477;
        Thu, 28 Apr 2022 06:49:51 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEB0A3F5A1;
        Thu, 28 Apr 2022 06:49:50 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:49:48 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 22/22] firmware: arm_scmi: Add SCMIv3.1
 PERFORMANCE_LIMITS_SET checks
Message-ID: <Ymqba5DZqELVRulS@e120937-lin>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-23-cristian.marussi@arm.com>
 <20220428131357.mbj5pksrnt5auotb@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428131357.mbj5pksrnt5auotb@bogus>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:13:57PM +0100, Sudeep Holla wrote:
> On Wed, Mar 30, 2022 at 04:05:51PM +0100, Cristian Marussi wrote:
> > Starting with SCMIv3.1, the PERFORMANCE_LIMITS_SET command allows a user
> > to request only one between max and min ranges to be changed, while leaving
> > the other untouched if set to zero in the request; anyway SCMIv3.1 states
> > also explicitly that you cannot leave both of those unchanged (zeroed) when
> > issuing such command: add a proper check for this condition.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/perf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > index 65ffda5495d6..8f4051aca220 100644
> > --- a/drivers/firmware/arm_scmi/perf.c
> > +++ b/drivers/firmware/arm_scmi/perf.c
> > @@ -423,6 +423,9 @@ static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
> >  	struct scmi_perf_info *pi = ph->get_priv(ph);
> >  	struct perf_dom_info *dom = pi->dom_info + domain;
> >  
> > +	if (PROTOCOL_REV_MAJOR(pi->version) >= 0x3 && !max_perf && !min_perf)
> > +		return -EINVAL;
> > +
> 
> Do we really need the version check here ? I agree it was explicitly added
> in v3.1, but it makes sense on any version really. No ?

Indeed seemed a silly patch also to me but given that only in v3.1 it is
explicitly stated that you cannot issue this command with both min and
max ZEROED I though this could have broken older fw that allowed
setting PERF_LIMITS_SET max=0 min=0

....maybe overthought ...

Thanks,
Cristian

