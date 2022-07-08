Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9163456BC82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiGHOrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiGHOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06FB4951FA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657291493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7gwPwQNvjxO3Bj8nIdfFkxQi461VrQcUOHffMEDGSzY=;
        b=e1/XIHBqE4hWRIO2Nu2gscaUKhHq0lAooYvpSOfvspCFZtQBrx9xVbBHyNZFGYs3vZzbxO
        Irnqn9fAnpB25niV3dg4ywyYyB5YAPJFETxkSb/yEZLVZwOeMHILofcTwCsrrGthnkoKm0
        6vrzovYTbRHXfV84qZLYI9NRUkT9i60=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-3le5lRUPPaSXE-yAa-qcQg-1; Fri, 08 Jul 2022 10:44:50 -0400
X-MC-Unique: 3le5lRUPPaSXE-yAa-qcQg-1
Received: by mail-ed1-f69.google.com with SMTP id f13-20020a0564021e8d00b00437a2acb543so16188575edf.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 07:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7gwPwQNvjxO3Bj8nIdfFkxQi461VrQcUOHffMEDGSzY=;
        b=Kv1WAxuyQtFpWSC+iBZhkX0li1K8h1geXVkHFfeORCDkP6zXXK4V8oWZKNyfQKMOic
         DfndsWerqm1Ma9aiCSJrxMMbfnTjYColvbEInuDqR2ocydx6DNtnzbRGIV4DGY3fvljX
         10MQ9wOqwHeuGZJw7iCEDQ6qk9yUolMXaRZmEUYvoOFkrg0eATUNG023fo7er2BW1mMx
         gEtbIw7tyWt1YkgXnwk4te8b9WelTaVByzGkIURRcu7RMMG4/BYgL1/JJAsATM57UjZP
         +Q3sNXWkZFYdfYNjbWpeftcxbBzJgazMY3GLv2MzE4HoQ8dzY7SgOh6v2LDfAecsBj4a
         JtjA==
X-Gm-Message-State: AJIora8soPTVvVm1OCaW9VfUjWyrk6p9jnpaTgmqQJY7Vkn0KaOO9zL2
        qZlNX0nFnECqd5i6vaIGLX/wik7Ve7zOUydys2bI+MKZBdDXTa8aesztvAd7gW0m7U/DYf2XDLd
        K4AfnQfT9voANDyqBoTa5b2Qg
X-Received: by 2002:a17:907:1c09:b0:726:b834:1a21 with SMTP id nc9-20020a1709071c0900b00726b8341a21mr3876541ejc.518.1657291488797;
        Fri, 08 Jul 2022 07:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s9TxXscMbcKRhzhpgA/XWrUysFKkVTtZcKiai8Wm3X6gqXhXuQU1Sz6th3jP19yVUysnmcwA==
X-Received: by 2002:a17:907:1c09:b0:726:b834:1a21 with SMTP id nc9-20020a1709071c0900b00726b8341a21mr3876523ejc.518.1657291488518;
        Fri, 08 Jul 2022 07:44:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ew6-20020a056402538600b0043a6dc3c4b0sm10090897edb.41.2022.07.08.07.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 07:44:48 -0700 (PDT)
Message-ID: <c3982024-3351-956f-605f-ef8453848ff7@redhat.com>
Date:   Fri, 8 Jul 2022 16:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [pdx86-platform-drivers-x86:review-hans 66/68]
 drivers/platform/x86/intel/vsec.c:475:6: warning: no previous prototype for
 'intel_vsec_pci_resume'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <202207041814.S03OvoFK-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202207041814.S03OvoFK-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/4/22 12:51, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
> head:   530ef2a6e81c74c19f918713e519e85652e53a83
> commit: 1039bb2698ab299a1fc30a4fc2df237867c089e0 [66/68] platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220704/202207041814.S03OvoFK-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=1039bb2698ab299a1fc30a4fc2df237867c089e0
>         git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>         git fetch --no-tags pdx86-platform-drivers-x86 review-hans
>         git checkout 1039bb2698ab299a1fc30a4fc2df237867c089e0
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/intel/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/platform/x86/intel/vsec.c:475:6: warning: no previous prototype for 'intel_vsec_pci_resume' [-Wmissing-prototypes]
>      475 | void intel_vsec_pci_resume(struct pci_dev *pdev)
>          |      ^~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/intel_vsec_pci_resume +475 drivers/platform/x86/intel/vsec.c
> 
>    474	
>  > 475	void intel_vsec_pci_resume(struct pci_dev *pdev)
>    476	{
>    477		dev_info(&pdev->dev, "Done resuming PCI device\n");
>    478	}
>    479	
> 


I've squashed a patch marking intel_vsec_pci_resume() as static into my
review-hans branch.

Regards,

Hans

