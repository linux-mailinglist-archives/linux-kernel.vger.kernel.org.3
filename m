Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6894A9434
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbiBDG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiBDG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:57:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D106C061714;
        Thu,  3 Feb 2022 22:57:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61C84B834D3;
        Fri,  4 Feb 2022 06:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381B0C004E1;
        Fri,  4 Feb 2022 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643957833;
        bh=qeK9dT4FXI5C3vIiQVnmjgZqRtE+CH15TMdc6HplHic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1009J1qMZ5CUuYCgqhTJ38Adj6dd6MNVRsqpXn/2DHAvTYyTVsKva24EXkR8gXoQ
         xYGawXJVcX5Pf7/g8eFsU6Kl6pXfYlPtRVkCmbH+0ugK42EYZGuYYmnMqCPt+Ak/YF
         X2ocT4T0q8992VzZno9/Ps7zX9JvHFc7Xh1EHFQ8=
Date:   Fri, 4 Feb 2022 07:57:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH V5 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YfzOPkZ+0XRxkbq/@kroah.com>
References: <20220204053046.2475671-1-david.e.box@linux.intel.com>
 <20220204053046.2475671-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204053046.2475671-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:30:44PM -0800, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> activating additional silicon features. Features are enabled through a
> license activation process.  The SDSi driver provides a per socket, sysfs
> attribute interface for applications to perform 3 main provisioning
> functions:
> 
> 1. Provision an Authentication Key Certificate (AKC), a key written to
>    internal NVRAM that is used to authenticate a capability specific
>    activation payload.
> 
> 2. Provision a Capability Activation Payload (CAP), a token authenticated
>    using the AKC and applied to the CPU configuration to activate a new
>    feature.
> 
> 3. Read the SDSi State Certificate, containing the CPU configuration
>    state.
> 
> The operations perform function specific mailbox commands that forward the
> requests to SDSi hardware to perform authentication of the payloads and
> enable the silicon configuration (to be made available after power
> cycling).
> 
> The SDSi device itself is enumerated as an auxiliary device from the
> intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.
> 
> Link: https://github.com/intel/intel-sdsi
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>
> ---
> V5
>   - Update kernel version to 5.18 in API doc and copyrights to 2022.
>   - Remove unneeded prototypes.
>   - In binary attribute handlers where ret is only used for errors,
>     replace,
>               return (ret < 0) ? ret : size;
>     with,
>               return ret ?: size;

That's horrible, please no.

Will you remember what this does in 5 years when you have to look at it
again?  Spell it out, this saves nothing in runtime or code size:
	if (ret < 0)
		return ret;
	return size;

There, obvious, simple, and can be read by anyone.

thanks,

greg k-h
