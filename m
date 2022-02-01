Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44ABD4A58BE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiBAIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiBAIpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:45:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42EDC061714;
        Tue,  1 Feb 2022 00:45:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85327B82D1F;
        Tue,  1 Feb 2022 08:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C633DC340EB;
        Tue,  1 Feb 2022 08:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643705108;
        bh=gFhm/BFBQlv4U+vaVcLdvui/cZ1mokaM8Hgc2Bg0WOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skLRUmJfhkZD8O4AVT7dQxBhkomnIsz8pHNGA8O3h24Dn797AcCLipDtccau6Nwq8
         VAzOp8i9CbJV9JuXxvdNi+ae5R+AVKwSg/yBF/Ns+EEsw/oKy+i2v1kTrgJOeDDE0K
         3Lus+HTBOpMR/aG8EFQeI6fxc/XcMR30iIoJwnFE=
Date:   Tue, 1 Feb 2022 09:45:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YfjzEQnvpH7hUZYa@kroah.com>
References: <20220201030424.1068816-1-david.e.box@linux.intel.com>
 <20220201030424.1068816-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201030424.1068816-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 07:04:22PM -0800, David E. Box wrote:
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
>  .../ABI/testing/sysfs-driver-intel_sdsi       |  77 +++
>  MAINTAINERS                                   |   5 +
>  drivers/platform/x86/intel/Kconfig            |  12 +
>  drivers/platform/x86/intel/Makefile           |   2 +
>  drivers/platform/x86/intel/sdsi.c             | 571 ++++++++++++++++++
>  drivers/platform/x86/intel/vsec.c             |  12 +-
>  6 files changed, 678 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
>  create mode 100644 drivers/platform/x86/intel/sdsi.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel_sdsi b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> new file mode 100644
> index 000000000000..126978647e9b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> @@ -0,0 +1,77 @@
> +What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X
> +Date:		Dec 2021
> +KernelVersion:	5.17

5.17 merge window is long gone now.

Please be more careful.

