Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7134662F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357527AbhLBMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:02:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346568AbhLBMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638446368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/fWLM+m+hPO38F8qC/8sqVHrKmIQFc8WG/cL2phRpI=;
        b=Beh/totpOF9ExM2eU/WW+YnqN1j5jB9OEY+1PE8iSJl3pP3Hg5eNsPQmEYfaXNQOdqZKIE
        RGq1OsUhuOJR0OAc7pIOo5nW/MUPsgjvCQuEnrEMx/Kp7iTmspQaaOUzIybeqdglzpOnHn
        P1SOCe57cWE7gL0Sp8VhstkZ27jWBuc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-oT7V3x9sMUCS2pT_iCw4SQ-1; Thu, 02 Dec 2021 06:59:27 -0500
X-MC-Unique: oT7V3x9sMUCS2pT_iCw4SQ-1
Received: by mail-ed1-f71.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso23257542edb.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q/fWLM+m+hPO38F8qC/8sqVHrKmIQFc8WG/cL2phRpI=;
        b=MdpiMwiUiCQMX99o1xNKUa9nyiiQ3lwcjkcz/hOoqiJjpi051oobLA6trnlTXieliU
         zVfiYi2zoXgrF9KyR/UiawLZtIrhp4+ejprOGZkrDz7dsst3zBUMyIoCvzRx0Gk9Lmjz
         esq1xBvjkIQ3nlwCsXp5ckgkmoNKIVXdPBAoosTjXhP3hRNoMky946PuVAFN59mktYBq
         nI4EAJh5AD08jWrje79JbB4YZRFS29fRU7W8KmUlpd4VfMF6Nm7FtxxGEsta++DebwaV
         iyE8L08SgW23kPTnPOZ+ku/+/NbhFu6+0xRV5fvre6OPpCrhMl4f7tApIYrnbk30TIl0
         qAIA==
X-Gm-Message-State: AOAM53073aZMp3y3zIiGSXUOnQV4wPbPuSjqaxnAC+GiEbxDXNDSvm7c
        /fpmmHO8Orx+VJlcuuzPE6TGbWZb/fdpT8r+2joVFnGyXQX5ndYpvK5yHIHfPRlZufHcSxG2vX2
        eE5uvM77/aHXN046M5uvc0BTy
X-Received: by 2002:a05:6402:3551:: with SMTP id f17mr16672619edd.129.1638446366067;
        Thu, 02 Dec 2021 03:59:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrAplphwf9xAtwsvRKQ6kAb6quIqmfJ1o3IBoXmnKiLxCWYRIKqTZRCw/Jj6j/guA/LPwt+w==
X-Received: by 2002:a05:6402:3551:: with SMTP id f17mr16672599edd.129.1638446365899;
        Thu, 02 Dec 2021 03:59:25 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dm6sm1793762ejc.89.2021.12.02.03.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 03:59:25 -0800 (PST)
Message-ID: <67b58b41-d5d4-5158-0da1-4a81b604172a@redhat.com>
Date:   Thu, 2 Dec 2021 12:59:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [pdx86-platform-drivers-x86:for-next 31/36]
 drivers/platform/x86/thinkpad_acpi.c:11154 thinkpad_acpi_module_exit() error:
 don't call input_free_device() after input_unregister_device()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <202111292341.pt8nIc7T-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202111292341.pt8nIc7T-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 11/30/21 09:05, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git for-next
> head:   e9ff190973df2c417c2a97a8b70e709e0bdc2716
> commit: 67e7d50d13e94abeaf82e9945dce929352771b94 [31/36] platform/x86: thinkpad_acpi: Move input_unregister_device() to the top of thinkpad_acpi_module_exit()
> config: i386-randconfig-m021-20211129 (https://download.01.org/0day-ci/archive/20211129/202111292341.pt8nIc7T-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/platform/x86/thinkpad_acpi.c:11154 thinkpad_acpi_module_exit() error: don't call input_free_device() after input_unregister_device()
> 
> vim +11154 drivers/platform/x86/thinkpad_acpi.c
> 
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11130  static void thinkpad_acpi_module_exit(void)
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11131  {
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11132  	struct ibm_struct *ibm, *itmp;
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11133  
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11134  	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11135  
> 67e7d50d13e94ab drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11136  	if (tp_features.input_device_registered)
> 67e7d50d13e94ab drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11137  		input_unregister_device(tpacpi_inputdev);
>                                                                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 526ac103dbc6729 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11138  	if (tpacpi_hwmon)
> 526ac103dbc6729 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11139  		hwmon_device_unregister(tpacpi_hwmon);
> 2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11140  	if (tp_features.sensors_pdrv_registered)
> 2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11141  		platform_driver_unregister(&tpacpi_hwmon_pdriver);
> 2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11142  	if (tp_features.platform_drv_registered)
> 2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11143  		platform_driver_unregister(&tpacpi_pdriver);
> 2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11144  
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11145  	list_for_each_entry_safe_reverse(ibm, itmp,
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11146  					 &tpacpi_all_drivers,
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11147  					 all_drivers) {
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11148  		ibm_exit(ibm);
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11149  	}
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11150  
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11151  	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11152  
> 67e7d50d13e94ab drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11153  	if (tpacpi_inputdev)
> b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08 @11154  		input_free_device(tpacpi_inputdev);
>                                                                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> I haven't seen this warning in a long time, so I forget why it exists.
> But apparently it's against the rules.  :P

Yes, this is my bad. I've dropped this cleanup patch from the pdx86 for-next branch now,
since clearly this is a bad idea.

Thank you for catching this.

Regards,

Hans

