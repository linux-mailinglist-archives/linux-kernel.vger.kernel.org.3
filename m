Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B409D4779A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhLPQuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhLPQuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:50:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5331EC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:50:04 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j18so2007939wrd.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vhmTL0KZO8xE1Q1ZtB8enyE8YIQf8VRnDYjk8oCQEbI=;
        b=x9x1R+hpjqWToV04byDktZCxaoqf3vIvvGK0kVWYSJhH1YmETUz7VAzd/khtHyGWqQ
         gPfbYfXMsfO7dJuxOVxNL3T5Jc7QQteRey9X2Dn7cXEJQlXeh1MY5AuQGzMS9E03wak6
         M8kxQs1NV14Hshv9ZJrLxSWSMiURcNbyu39JUIvWo7BDmPMcD/PGrZX9wKEHh8MO5vlX
         GR4A8mfRWUtEfDJzcKKh2MDffSAbvuagzqkv7bVEP+5RV5O21GKu5KnCunAGHdYgTyfw
         xB+WEeW1ydrbDsykzHiLtUU3gK4px44V//3eX8sE3r2xb61J/CVpkbo6WlMMsTYfKX9w
         8cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vhmTL0KZO8xE1Q1ZtB8enyE8YIQf8VRnDYjk8oCQEbI=;
        b=orZVEA0jx+P458bJ3p3DUfYHZ9q5M4fZElfSeN0x1aRB0Av4uQThUpFonjk+Xmbgkk
         5JSmbaInMDACrkxCsFSMxi2QRVoi28fq1ZBZqoRTMHHyLW5V39kh4qA7zG1EgMuiphOK
         PkxCdHxlh1dfGev//MC/TGhpVLtMENXVGgCILXbyRPfqcpW/Vg+/fW8OCB70izex0/9/
         kqeJfVIUwC6sc6TIm67CSDB2IS6y8gF8dHmDrtQ0hGxmG6QhwVm4wKX9jlTGwNJFDilc
         y2vW/EQyeFBs0BzZhpMIxK5rLb5gGCo3Ibp92CRYxFKJNBtr9JiVFxCdDyBRm86E4xhu
         WbLQ==
X-Gm-Message-State: AOAM532nAssYM+wPNaIC7E/2+VdfvjS06RaSoRgUCWMz3w9NcnzJlnj1
        NxQgN4TVm+EYBDST1VD0U5DuQw==
X-Google-Smtp-Source: ABdhPJzMz7Qf3P70HSBUowYpb4vvHhmtQGskdnpHrddYIGSWQ8UV22/MLXpL+8qlJ8Bu8mYFMMDPig==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr5673535wrm.653.1639673402819;
        Thu, 16 Dec 2021 08:50:02 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id p2sm8106752wmq.23.2021.12.16.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:50:02 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:49:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org, Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH V4 3/6] platform/x86/intel: Move intel_pmt from MFD to
 Auxiliary Bus
Message-ID: <YbtuMVoTbCUi82cm@google.com>
References: <20211216023146.2361174-1-david.e.box@linux.intel.com>
 <20211216023146.2361174-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211216023146.2361174-4-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021, David E. Box wrote:

> Intel Platform Monitoring Technology (PMT) support is indicated by presence
> of an Intel defined PCIe Designated Vendor Specific Extended Capabilities
> (DVSEC) structure with a PMT specific ID. The current MFD implementation
> creates child devices for each PMT feature, currently telemetry, watcher,
> and crashlog. However DVSEC structures may also be used by Intel to
> indicate support for other features. The Out Of Band Management Services
> Module (OOBMSM) uses DVSEC to enumerate several features, including PMT.
> In order to support them it is necessary to modify the intel_pmt driver to
> handle the creation of the child devices more generically. To that end,
> modify the driver to create child devices for any VSEC/DVSEC features on
> supported devices (indicated by PCI ID).  Additionally, move the
> implementation from MFD to the Auxiliary bus.  VSEC/DVSEC features are
> really multifunctional PCI devices, not platform devices as MFD was
> designed for. Auxiliary bus gives more flexibility by allowing the
> definition of custom structures that can be shared between associated
> auxiliary devices and the parent device. Also, rename the driver from
> intel_pmt to intel_vsec to better reflect the purpose.
> 
> This series also removes the current runtime pm support which was not
> complete to begin with. None of the current devices require runtime pm.
> However the support will be replaced when a device is added that requires
> it.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>
> ---
> V4
>   - Add intel_vsec_extract_vsec() to combine common code and simplify
>     the extended capability loops. Suggested by Andy.
> V3
>   - Add comment clarifying how driver cleanup is handled without remove().
> 
> V2
>   - Clarify status of missing pm support in commit message.
>   - Clarify why auxiliary bus is preferred in commit message.
> 
>  MAINTAINERS                                |  12 +-
>  drivers/mfd/Kconfig                        |  10 -
>  drivers/mfd/Makefile                       |   1 -
>  drivers/mfd/intel_pmt.c                    | 261 -------------

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/platform/x86/intel/Kconfig         |  11 +
>  drivers/platform/x86/intel/Makefile        |   2 +
>  drivers/platform/x86/intel/pmt/Kconfig     |   4 +-
>  drivers/platform/x86/intel/pmt/class.c     |  21 +-
>  drivers/platform/x86/intel/pmt/class.h     |   5 +-
>  drivers/platform/x86/intel/pmt/crashlog.c  |  47 +--
>  drivers/platform/x86/intel/pmt/telemetry.c |  46 +--
>  drivers/platform/x86/intel/vsec.c          | 405 +++++++++++++++++++++
>  drivers/platform/x86/intel/vsec.h          |  43 +++
>  13 files changed, 533 insertions(+), 335 deletions(-)
>  delete mode 100644 drivers/mfd/intel_pmt.c
>  create mode 100644 drivers/platform/x86/intel/vsec.c
>  create mode 100644 drivers/platform/x86/intel/vsec.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
