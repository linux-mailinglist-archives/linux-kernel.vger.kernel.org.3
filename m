Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89326513149
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbiD1KbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiD1Kax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:30:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A18049F2B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:27:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A51091474;
        Thu, 28 Apr 2022 03:27:37 -0700 (PDT)
Received: from bogus (unknown [10.57.11.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EC483F774;
        Thu, 28 Apr 2022 03:27:35 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:27:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 05/22] firmware: arm_scmi: Dynamically allocate protocols
 array
Message-ID: <20220428102730.n65fsfvei7pbwetp@bogus>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330150551.2573938-6-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:05:34PM +0100, Cristian Marussi wrote:
> Move away from a statically allocated array for holding the current set of
> protocols implemented by the platform in favour of allocating it
> dynamically based on the number of protocols effectively advertised by the
> platform via BASE protocol exchanges.
> 
> While at that, rectify the BASE_DISCOVER_LIST_PROTOCOLS loop iterations to
> terminate only when a number of protocols equal to the advertised ones has
> been received, instead of looping till the platform returns no more
> protocols descriptors: this new behaviour is better compliant with the
> specification and it has been tested to work equally well against an SCMI
> stack running on top of an official SCP firmware on a JUNO board.
>

Nice, no idea why I forgot that we have num_protocols from the another
command when I originally wrote this. I may be carried away with the way
OPP or even the clock rate list works I guess.

-- 
Regards,
Sudeep
