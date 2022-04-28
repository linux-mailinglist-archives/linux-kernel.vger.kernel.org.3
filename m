Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E8E5135C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347783AbiD1Nz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347725AbiD1Nz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:55:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8CF2B42D9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:52:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AAAD1474;
        Thu, 28 Apr 2022 06:52:40 -0700 (PDT)
Received: from bogus (unknown [10.57.11.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637AF3F5A1;
        Thu, 28 Apr 2022 06:52:38 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:52:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 22/22] firmware: arm_scmi: Add SCMIv3.1
 PERFORMANCE_LIMITS_SET checks
Message-ID: <20220428135233.r2yzwgr5uxex7vox@bogus>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-23-cristian.marussi@arm.com>
 <20220428131357.mbj5pksrnt5auotb@bogus>
 <Ymqba5DZqELVRulS@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ymqba5DZqELVRulS@e120937-lin>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:49:48PM +0100, Cristian Marussi wrote:
> On Thu, Apr 28, 2022 at 02:13:57PM +0100, Sudeep Holla wrote:
> > On Wed, Mar 30, 2022 at 04:05:51PM +0100, Cristian Marussi wrote:
> > > Starting with SCMIv3.1, the PERFORMANCE_LIMITS_SET command allows a user
> > > to request only one between max and min ranges to be changed, while leaving
> > > the other untouched if set to zero in the request; anyway SCMIv3.1 states
> > > also explicitly that you cannot leave both of those unchanged (zeroed) when
> > > issuing such command: add a proper check for this condition.
> > > 
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > >  drivers/firmware/arm_scmi/perf.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > > index 65ffda5495d6..8f4051aca220 100644
> > > --- a/drivers/firmware/arm_scmi/perf.c
> > > +++ b/drivers/firmware/arm_scmi/perf.c
> > > @@ -423,6 +423,9 @@ static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
> > >  	struct scmi_perf_info *pi = ph->get_priv(ph);
> > >  	struct perf_dom_info *dom = pi->dom_info + domain;
> > >  
> > > +	if (PROTOCOL_REV_MAJOR(pi->version) >= 0x3 && !max_perf && !min_perf)
> > > +		return -EINVAL;
> > > +
> > 
> > Do we really need the version check here ? I agree it was explicitly added
> > in v3.1, but it makes sense on any version really. No ?
> 
> Indeed seemed a silly patch also to me but given that only in v3.1 it is
> explicitly stated that you cannot issue this command with both min and
> max ZEROED I though this could have broken older fw that allowed
> setting PERF_LIMITS_SET max=0 min=0
> 
> ....maybe overthought ...

Hmm, let's keep it unconditional for now. We can add if someone reports
broken firmware. BTW there are no users in the kernel 😄.

-- 
Regards,
Sudeep
