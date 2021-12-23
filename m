Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7007547E3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348366AbhLWNLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhLWNLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:11:49 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0808C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:11:48 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v13so5263494pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:organization:subject:in-reply-to
         :content-transfer-encoding;
        bh=XdOqSkrp8/PeX/u/iXxam6AgB5kcVQtDVIniRYGDvZo=;
        b=Vk6uq3UhNeQFRDtq8dTy4zhS2lDQx1Dw165Oz03p76HjQlFBJC9Qaag7i/JAHQfLLI
         ZxatnRqwXtvmzUCIDE2vI9n9Pwp3i+TM2dIM9Om4t90DUbBxBwm6+frECbnC+yw+zEWC
         fnpy8H/tTbs2w/bueS3Qs78Xmaic1QbONcTEPt5ciKiVQl3BUccqDI5ept5nE4CvBwzp
         OCdMshg4Dgf6vTjIxJ2e1cFw5O5SPA8Lm1X47p5bna5edvcJ5EoBVYKaUogM+gA65GUb
         1SRlGv996uTQ1F8YkdwqnrPNL4B1W0K77OjEeCoREffiBzziqWF8w9xbFaO3rH80MPFo
         A8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=XdOqSkrp8/PeX/u/iXxam6AgB5kcVQtDVIniRYGDvZo=;
        b=KqtLFHmuLQchbHUljTSs1S4nyVMJSlw2Je6VuVpPbDlw0+R/+jXEYlrn6QCB1vnHsx
         0jQ2svvMBCWTyYeGruPLRPq5UG4BW8W07rQzONDmUI+9pg2kdigspeTWGR1mdbpV/JBE
         +1Zkl8lAbgxWJolvsS6RpRgOCEv5dhVl8I5YwhYqomcSKjjm1Mz0fYHtZ4NzMGBuQTwQ
         rw0P8XDzdDyeTzZzMbu1yEYh6Pk5NFnfYdPYWzIuoTdzfDtNRp1vID2VyQr17+4BVil/
         UDsZROAQ7GfchX49njdP7F3ep8YQW8A2duYe/u2y/3r24G/kcMSZ4eqGFDl+FOxOeuAX
         ScgQ==
X-Gm-Message-State: AOAM531PeyL1byeiPvq8g5P3HiBYkfWYEFXJFesbSTPZ0coZEBaKnHwk
        OswTxmtBy1qoCzkpfkeYFCQ=
X-Google-Smtp-Source: ABdhPJzChf6RI3u/ak3e9HiY3xel95h519tiRCVeRPVWMlcXJ3wq0zbAvy4V86Oy6RwncgtmdyUZbw==
X-Received: by 2002:a63:d34e:: with SMTP id u14mr2089950pgi.327.1640265107782;
        Thu, 23 Dec 2021 05:11:47 -0800 (PST)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id nn16sm9560215pjb.54.2021.12.23.05.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 05:11:47 -0800 (PST)
Message-ID: <da60370e-db29-9ea7-83d9-fba262d87a99@gmail.com>
Date:   Thu, 23 Dec 2021 21:11:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
Cc:     kbuild-all@lists.01.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, mpe@ellerman.id.au, maddy@linux.ibm.com,
        kernel test robot <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211210210229.2991238-9-eranian@google.com>
 <202112140636.UOuRtBxF-lkp@intel.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
Subject: Re: [PATCH v4 08/14] ACPI: add perf low power callback
In-Reply-To: <202112140636.UOuRtBxF-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 6:40 am, kernel test robot wrote:
> Hi Stephane,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on tip/x86/core v5.16-rc5]
> [cannot apply to rafael-pm/linux-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:https://github.com/0day-ci/linux/commits/Stephane-Eranian/perf-x86-amd-Add-AMD-Fam19h-Branch-Sampling-support/20211211-050541
> base:https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  a9f4a6e92b3b319296fb078da2615f618f6cd80c
> config: x86_64-randconfig-c002-20211210 (https://download.01.org/0day-ci/archive/20211214/202112140636.UOuRtBxF-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>          #https://github.com/0day-ci/linux/commit/9d928356688ed9c42e01fed16e59c1d6eda16647
>          git remote add linux-reviewhttps://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Stephane-Eranian/perf-x86-amd-Add-AMD-Fam19h-Branch-Sampling-support/20211211-050541
>          git checkout 9d928356688ed9c42e01fed16e59c1d6eda16647
>          # save the config file to linux build tree
>          mkdir build_dir
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot<lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/acpi/acpi_pad.c: In function 'power_saving_thread':
>>> drivers/acpi/acpi_pad.c:168:4: error: implicit declaration of function 'perf_lopwr_cb' [-Werror=implicit-function-declaration]
>       168 |    perf_lopwr_cb(true);
>           |    ^~~~~~~~~~~~~
>     cc1: some warnings being treated as errors

Hi Stephane,

does this snippet help to fix this issue ?

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index a306a07a6..fdb505305 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -18,6 +18,7 @@
  #include <linux/slab.h>
  #include <linux/acpi.h>
  #include <asm/mwait.h>
+#include <linux/perf_event.h>
  #include <xen/xen.h>

  #define ACPI_PROCESSOR_AGGREGATOR_CLASS        "acpi_pad"

What's more, it seems thet "CONFIG_ACPI_PROCESSOR_AGGREGATOR=y" is requested
for "CONFIG_PERF_EVENTS_AMD_BRS=y". Otherwise, we need to EXPORT_SYMBOL_GPL
for both perf_lopwr_needed and perf_amd_brs_lopwr_cb. Got a better idea?

Thanks,
Like Xu

> 
> 
> vim +/perf_lopwr_cb +168 drivers/acpi/acpi_pad.c
