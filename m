Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC25634A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiGANt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiGANt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:49:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4796127B32
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:49:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C89E113E;
        Fri,  1 Jul 2022 06:49:25 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB20A3F66F;
        Fri,  1 Jul 2022 06:49:23 -0700 (PDT)
Date:   Fri, 1 Jul 2022 14:49:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vincent.guittot@linaro.org, f.fainelli@gmail.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/5] Introduce SCMI System Power Control driver
Message-ID: <20220701134920.3elmh4bww3s63trr@bogus>
References: <20220623124742.2492164-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623124742.2492164-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:47:37PM +0100, Cristian Marussi wrote:
> Hi,
> 
> This series is a respin of an old series[0] parked for a while waiting for
> a required SCMI specification change to be published.
> 
> The series, building on top of the SCMI System Power Protocol, adds a new 
> SCMI driver which, registering for SystemPower notifications, takes care to
> satisfy SCMI plaform system-transitions graceful requests like shutdown or
> reboot involving userspace interactions as needed.
> 
> Interaction with userspace boils down to the same orderly_ Kernel methods
> used by ACPI to handle similar shutdown requests.
> 
> The latest SCMI v3.1 specification [1], which adds a new timeout field to
> the graceful notifications payload, let the platform advertise for how long
> it will possibly wait for the requested system state transition to happen
> before forcibly enforcing it.
> 
> As a part of the series, patch 2/3 enforces, at the SCMI core level, the
> creation of one single SCMI SystemPower device, to avoid promoting the
> design of systems in which multiple SCMI platforms can advertise the
> concurrent support of SystemPower protocol: when multiple SCMI platform
> are defined, only one of them should be in charge of SystemPower comms
> with the OSPM, so only one such SystemPower device across all platforms
> is allowed to be created.
> 

Other than the comment in 2/5, I am happy with the other changes.

-- 
Regards,
Sudeep
