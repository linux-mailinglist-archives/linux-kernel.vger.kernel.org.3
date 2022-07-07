Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA156AA99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiGGS2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiGGS1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A266A5C94D;
        Thu,  7 Jul 2022 11:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B922B82340;
        Thu,  7 Jul 2022 18:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229ABC341C0;
        Thu,  7 Jul 2022 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657218464;
        bh=B+uxep6PweVxRcJ3aV3mrwVMFZ/KHHAHnsGu67uzWuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ea+K66kK0eEkpF5hCnIUBTo1ZqZPIsmwVsLsNoP+KJ/zaXPyCApzoiXavjG22qzmu
         QfrfD3WS6VrpiiWvFjH09LIYuxQ8nn1mHVp1vDa0iNf7ufiEKuMhIori2AJailQY8g
         vq05YvK+LI2Cj/QcLx8sR0fiF07NPXRZbkiALTGboNgEhV/vbhFjzO/ECU9S9orUyy
         ArLY2jfFrnJcUdxjxuiWYMwOSvw6zD7wefuzKdtP7fIADZOV0EdvEF7RkaudOkpKqP
         UgoSEt0up+J/nv7P7K/fb1RiajiXLMlgh45iwWgnhMmvcpxYTMWpxbkkZkxEphJ7ck
         IEv3byKAfRQhA==
Date:   Thu, 7 Jul 2022 19:27:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v10 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <20220707182737.GE4852@willie-the-truck>
References: <20220707154226.1478674-1-sebastianene@google.com>
 <20220707154226.1478674-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707154226.1478674-3-sebastianene@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, Jul 07, 2022 at 03:42:27PM +0000, Sebastian Ene wrote:
> This driver creates per-cpu hrtimers which are required to do the
> periodic 'pet' operation. On a conventional watchdog-core driver, the
> userspace is responsible for delivering the 'pet' events by writing to
> the particular /dev/watchdogN node. In this case we require a strong
> thread affinity to be able to account for lost time on a per vCPU.
> 
> This part of the driver is the 'frontend' which is reponsible for
> delivering the periodic 'pet' events, configuring the virtual peripheral
> and listening for cpu hotplug events. The other part of the driver is
> an emulated MMIO device which is part of the KVM virtual machine
> monitor and this part accounts for lost time by looking at the
> /proc/{}/task/{}/stat entries.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  drivers/misc/Kconfig               |  14 ++
>  drivers/misc/Makefile              |   1 +
>  drivers/misc/vcpu_stall_detector.c | 209 +++++++++++++++++++++++++++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 drivers/misc/vcpu_stall_detector.c

Thanks for addressing all of my feedback on v9 so promptly:

Reviewed-by: Will Deacon <will@kernel.org>

Just one question on this part:

> +static enum hrtimer_restart
> +vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
> +{
> +	u32 ticks, ping_timeout_ms;
> +
> +	/* Reload the stall detector counter register every
> +	 * `ping_timeout_ms` to prevent the virtual device
> +	 * from decrementing it to 0. The virtual device decrements this
> +	 * register at 'clock_freq_hz' frequency.
> +	 */
> +	ticks = vcpu_stall_config.clock_freq_hz *
> +		vcpu_stall_config.stall_timeout_sec;

It would be quite easy for this to overflow 32 bits, so perhaps it would
be best to check the values from the DT during probe and fallback to the
defaults (with a warning) if the result of the multiplication is out
of range for the 32-bit register.

What do you think? My review stands in any case, as this shouldn't happen
in practice with sensible values.

Will
