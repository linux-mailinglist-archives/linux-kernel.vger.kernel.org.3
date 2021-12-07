Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874FA46BA06
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhLGLZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:25:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhLGLZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638876129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6jqPvKlLTCwMFzua8Uv5raqMLwMZefhpH/mdOhYylA=;
        b=eEbro6+rDPB6dmlh0jExlokHt1mAAkN5s0Soq6Ad83t0dwuVHuaEQkuK+yHUrhvQLcsyo+
        +GbEKXXXWFbgNUz++tloEFMG+7adOpHPk0ul9ttBiMcXd6xZykYL7m/WaWkJDDlzstSN7P
        aRvfjayxeCeHkssSRWYOC2VC9nNo++E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-iXJY1rzRPcCSoppfuICtig-1; Tue, 07 Dec 2021 06:22:08 -0500
X-MC-Unique: iXJY1rzRPcCSoppfuICtig-1
Received: by mail-ed1-f70.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so11137827edq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 03:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D6jqPvKlLTCwMFzua8Uv5raqMLwMZefhpH/mdOhYylA=;
        b=rfxBaQjlridlCD02O2lA6egIRPSLFDOj52mP621vQ2f4c8TAQPdnrOotPUiMmdfHq2
         F8bcukCPQZO922RNmPVhzpDKcSJ8ACsGEhUkDGwLWGlIeDiPLbppQi3V3SBJ+CmlA4o6
         2r53/ohNe9F250DSWtsbqGDaBYvccVcrB14JGB42P3KiBFQ5zvhDOqO4ocv4lsBQ4TnE
         kM92+0X+iZjAao387LvgK6/kfuWHPST/SnkpV3tx2XqnI7G9rDad+Rp53rEA29sLpKWE
         2UTjm7CJYYDX6jSkHqrv0iRvAaOdf7PTaXJiC4yGjYoTqXh/oAWN5p6uXHIt+fypJBZr
         OAfw==
X-Gm-Message-State: AOAM531FVML8HdwjLp1G8tYw0gHz6TlfAdvEPCl1GqYwBcicyWl+5CA6
        IvUWRX4vtU38bnxREnmODE8GHBHTaGOoGd1lazROoAz7yD9mNKJeT4lTzSE9fNHCbrYW+f9XjOC
        pTcmFWDN0H8BDFp2RJO+19aPj
X-Received: by 2002:a05:6402:42:: with SMTP id f2mr8382119edu.204.1638876127235;
        Tue, 07 Dec 2021 03:22:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxTAqlOndcRNmElmujaE8F9mmxRsgf1caiWPmGK2wdcYLAU1LoksP0iMK8UQoSqnXZwpoefg==
X-Received: by 2002:a05:6402:42:: with SMTP id f2mr8382098edu.204.1638876127039;
        Tue, 07 Dec 2021 03:22:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ch28sm9845067edb.72.2021.12.07.03.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 03:22:06 -0800 (PST)
Message-ID: <4255f5c1-6195-c85d-fd6b-9d95d3729852@redhat.com>
Date:   Tue, 7 Dec 2021 12:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [pdx86-platform-drivers-x86:review-hans 41/44]
 drivers/platform/x86/lenovo-yogabook-wmi.c:278:20: warning: no previous
 prototype for 'yogabook_wmi_suspend'
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202112070945.X05c2wgI-lkp@intel.com>
 <Ya85vcmiq+MI2Scc@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Ya85vcmiq+MI2Scc@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/21 11:38, Andy Shevchenko wrote:
> On Tue, Dec 07, 2021 at 09:42:46AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
>> head:   cb01df9ef827442739051c6457962a5c6bc85d99
>> commit: 4709e8b835ec25e8627844e9927804f814b64fd4 [41/44] platform/x86: lenovo-yogabook-wmi: Add driver for Lenovo Yoga Book
>> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211207/202112070945.X05c2wgI-lkp@intel.com/config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce (this is a W=1 build):
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=4709e8b835ec25e8627844e9927804f814b64fd4
>>         git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>>         git fetch --no-tags pdx86-platform-drivers-x86 review-hans
>>         git checkout 4709e8b835ec25e8627844e9927804f814b64fd4
>>         # save the config file to linux build tree
>>         mkdir build_dir
>>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/platform/x86/lenovo-yogabook-wmi.c:278:20: warning: no previous prototype for 'yogabook_wmi_suspend' [-Wmissing-prototypes]
>>      278 | __maybe_unused int yogabook_wmi_suspend(struct device *dev)
>>          |                    ^~~~~~~~~~~~~~~~~~~~
>>>> drivers/platform/x86/lenovo-yogabook-wmi.c:294:20: warning: no previous prototype for 'yogabook_wmi_resume' [-Wmissing-prototypes]
>>      294 | __maybe_unused int yogabook_wmi_resume(struct device *dev)
>>          |                    ^~~~~~~~~~~~~~~~~~~
> 
> Despite missed static, we usually put __maybe_unused between type and function
> name in this cases.

Right. I've just done a forced-push to review-hans fixing both issues.

Regards,

Hans

