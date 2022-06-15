Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE85654CEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbiFOQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiFOQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:29:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 356023A721
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:29:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E47B153B;
        Wed, 15 Jun 2022 09:29:45 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFE0A3F7F5;
        Wed, 15 Jun 2022 09:29:43 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:29:41 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 11/22] firmware: arm_scmi: Add SCMIv3.1 extended names
 protocols support
Message-ID: <YqoI5hYa97nZwUjl@e120937-lin>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-12-cristian.marussi@arm.com>
 <6f865d7f-fde8-d923-3c7e-d12bfbc370a6@gmail.com>
 <YqmVsMGgxKuIT5rx@e120937-lin>
 <Yqmo/BiIR4gku0Y+@e120937-lin>
 <c787dfe6-9639-8797-d07a-048c5ec69ddf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c787dfe6-9639-8797-d07a-048c5ec69ddf@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 09:10:03AM -0700, Florian Fainelli wrote:
> On 6/15/22 02:40, Cristian Marussi wrote:
> > On Wed, Jun 15, 2022 at 09:18:03AM +0100, Cristian Marussi wrote:
> > > On Wed, Jun 15, 2022 at 05:45:11AM +0200, Florian Fainelli wrote:
> > > > 
> > > > 
> > > > On 3/30/2022 5:05 PM, Cristian Marussi wrote:
> > > > > Using the common protocol helper implementation add support for all new
> > > > > SCMIv3.1 extended names commands related to all protocols with the
> > > > > exception of SENSOR_AXIS_GET_NAME.
> > > > > 
> > > > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > > 
> > > > This causes the following splat on a platform where regulators fail to
> > > > initialize:
> > > > 
> > > 
> > > Hi Florian,
> > > 
> > > thanks for the report.
> > > 
> > > It seems a memory error while allocating so it was not meant to be
> > > solved by the fixes, anyway, I've never seen this splat in my testing
> > > and at first sight I cannot see anything wrong in the devm_k* calls
> > > inside scmi_voltage_protocol_init...is there any particular config in
> > > your setup ?
> > > 
> > > Moreover, the WARNING line 5402 seems to match v5.19-rc1 and it has
> > > slightly changed with -rc-1, so I'll try rebasing on that at first and
> > > see if I can reproduce the issue locally.
> > > 
> > 
> > I just re-tested the series rebased on v519-rc1 plus fixes and I cannot
> > reproduce in my setup with a few (~9) good and bad voltage domains.
> > 
> > How many voltage domains are advertised by the platform in your setup ?
> 
> There are 11 voltage regulators on this platform, and of course, now that I
> am trying to reproduce the splat I reported I just cannot anymore... I will
> let you know if there is anything that needs to be done. Thanks for being
> responsive as usual!

... you're welcome...

I'm trying to figure out where an abnormal mem request could happen...

can you try adding this (for brutal debugging) when you try ?
(...just to rule out funny fw replies.... :D)

Thanks,
Cristian

--->8----

diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 895741b66f5a..fd841292df5c 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -108,6 +108,9 @@ static int scmi_init_voltage_levels(struct device *dev,
                return -EINVAL;
        }
 
+       dev_info(dev, "num_returned:%d  num_remaining:%d\n",
+                num_returned, num_remaining);
+
        v->levels_uv = devm_kcalloc(dev, num_levels, sizeof(u32), GFP_KERNEL);
        if (!v->levels_uv)
                return -ENOMEM;


> -- 
> Florian
