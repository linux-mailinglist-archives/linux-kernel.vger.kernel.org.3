Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200065634E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiGAOJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGAOJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:09:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8027234659
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:09:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E60F113E;
        Fri,  1 Jul 2022 07:09:50 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 808383F792;
        Fri,  1 Jul 2022 07:09:48 -0700 (PDT)
Date:   Fri, 1 Jul 2022 15:09:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, adrian.slatineanu@arm.com,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        wbartczak@marvell.com
Subject: Re: [PATCH v3 8/9] firmware: arm_scmi: Add scmi_driver optional
 setup/teardown callbacks
Message-ID: <20220701140946.uar5ohadyjksf2ka@bogus>
References: <20220627123038.1427067-1-cristian.marussi@arm.com>
 <20220627123038.1427067-9-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627123038.1427067-9-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:30:37PM +0100, Cristian Marussi wrote:
> Add optional .setup and .teardown methods to the scmi_driver descriptor:
> such callbacks, if provided, will be called by the SCIM core at driver
> registration time, so that, an SCMI driver, registered as usual with the
> module_scmi_driver() helper macro, can provide custom callbacks to be
> run once for all at module load/unload time to perform specific setup
> or teardown operations before/after .probe and .remove steps.
>

What can't the driver call this setup/teardown on its own before/after
calling scmi_driver_register/unregister ?

Based on the usage in 9/9, I guess it is mainly to use the
module_scmi_driver ? If so, I would avoid using that or have another
macro to manage this setup/teardown(once there are multiple users for that).
IMO, it doesn't make sense to add callbacks to do things that are outside
the scope of scmi drivers. No ?

-- 
Regards,
Sudeep
