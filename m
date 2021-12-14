Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5D4743DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhLNNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:51:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:42616 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhLNNvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:51:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238926066"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="238926066"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:51:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="604287738"
Received: from rtwoods-mobl.amr.corp.intel.com (HELO [10.213.169.152]) ([10.213.169.152])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:51:22 -0800
Subject: Re: linux-next: Tree for Dec 13 (SND_AMD_ACP_CONFIG)
To:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211214030215.3181149-1-broonie@kernel.org>
 <8ff9d4b2-1905-2efa-cb86-e8f6cef06ef2@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <15c3b6fe-b159-6cee-be67-11f2f2dd0d04@linux.intel.com>
Date:   Tue, 14 Dec 2021 07:51:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8ff9d4b2-1905-2efa-cb86-e8f6cef06ef2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> on i386 or x86_64:
> 
> when # CONFIG_ACPI is not set,
> so SND_SOC_ACPI is not set:
> 
> WARNING: unmet direct dependencies detected for SND_AMD_ACP_CONFIG
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_ACPI [=n]
>   Selected by [y]:
>   - SND_SOC_AMD_ACP_COMMON [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && X86 [=y] && PCI [=y]
> 
> 
> Full randconfig file is attached

It's probably triggered by my recent change to fix another problem.

d9b994cd7641 ASoC: AMD: acp-config: fix missing dependency on SND_SOC_ACPI

I didn't realize SND_AMD_ACP_CONFIG was selected by other configs.
Moving to a select seems to fix the issue reported by Randy, not sure if
it's the right thing to do though.


diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index bcfeb3fc2592..7a9e45094f37 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -98,7 +98,7 @@ config SND_SOC_AMD_YC_MACH

 config SND_AMD_ACP_CONFIG
        tristate "AMD ACP configuration selection"
-       depends on SND_SOC_ACPI
+       select SND_SOC_ACPI if ACPI
        help
         This option adds an auto detection to determine which ACP
         driver modules to use


