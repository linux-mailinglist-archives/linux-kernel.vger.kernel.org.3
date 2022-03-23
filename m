Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F52F4E5BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbiCWXIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345429AbiCWXIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECABE9027B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648076827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AeE76UaTYeKfGTHUnXSHySwumYli4lVrVB6Ua4GUIIk=;
        b=LourY2NPk2YpJWHRyTbqdVFP4U20EGEXrq+fJZRLjY5Bq55kSRIiXSrfhCEViqsKAIrhkg
        6OIFuc0f4xiirqQWALIqFM1JKLp8S4IpBtlefxlDD6MwUVpOJJDWpEbElnWJ2yx2ajJKsQ
        r5WJOfzW9gdKj2xtso58k3cmrpZlXwg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-w5nYyYyrMXqxGIoYs3NVEA-1; Wed, 23 Mar 2022 19:07:05 -0400
X-MC-Unique: w5nYyYyrMXqxGIoYs3NVEA-1
Received: by mail-qt1-f198.google.com with SMTP id p6-20020a05622a00c600b002e1cb9508e8so2321551qtw.20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AeE76UaTYeKfGTHUnXSHySwumYli4lVrVB6Ua4GUIIk=;
        b=2YI7O2zW4TSw299H8R0NKktZnTr00AQDiW1SbH4+Ba/RPyX9Q7jh9zD1+4ApzsjnIe
         4KcM1UfiJ4b4XXY0XSC+e8IwiMQLzHcwbPe1H+9bow6m1hc8wRnifLYqsjpw/NZY4B9s
         3dKO+eUkk47gcze88ZpCIYwKx/P4jn2WZvmIZq4u7gPsOXgKAvycUvjKWl13aNrkGXlP
         zRttqgh9u8uTjD+mPuaV5C1uvBW0aeLMrDOVsRFIshIbSW3EO05Uvcmif6frX39r0UBc
         h0jbv1uG2hbM0vcO9YwD4t5ZWnxn7+6SqzVVhNHcc9nC5pimxYF10FCCqrWNWFI9RASk
         5wmQ==
X-Gm-Message-State: AOAM530T3BuhBxGyyvkttvQ99lCalw2di2kBup8Y+GQ3qSRmCCTj/LpV
        WV/XbltUkXi12jcytfJV12El1cS8cgyTzPY58Pt/41dO7G+KTrBhPh//9Hb7suca65vKJjpQqdM
        1MUGaTemXJG9NGDG8OGc8V5Q=
X-Received: by 2002:a05:620a:4554:b0:67d:6750:6a3 with SMTP id u20-20020a05620a455400b0067d675006a3mr1618760qkp.439.1648076824998;
        Wed, 23 Mar 2022 16:07:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4cizB/SoNIm4ab298xlavH6M9Ey73WflczZsQIKYfKAtTDPuv/lVMEGZ8IxLT/JR4E7epBA==
X-Received: by 2002:a05:620a:4554:b0:67d:6750:6a3 with SMTP id u20-20020a05620a455400b0067d675006a3mr1618743qkp.439.1648076824778;
        Wed, 23 Mar 2022 16:07:04 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b002e06e2623a7sm1025395qtg.0.2022.03.23.16.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 16:07:04 -0700 (PDT)
Date:   Wed, 23 Mar 2022 19:07:03 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, kbuild-all@lists.01.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [device-mapper-dm:dm-5.19 132/132] drivers/md/dm.c:1542:18:
 error: 'result' undeclared
Message-ID: <YjuoF88MzBALI+l8@redhat.com>
References: <202203240638.crXQjFY5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203240638.crXQjFY5-lkp@intel.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23 2022 at  6:57P -0400,
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git dm-5.19
> head:   7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
> commit: 7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe [132/132] dm: push error handling down to __split_and_process_bio
> config: s390-buildonly-randconfig-r005-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240638.crXQjFY5-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?id=7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
>         git remote add device-mapper-dm https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
>         git fetch --no-tags device-mapper-dm dm-5.19
>         git checkout 7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/md/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/md/dm.c: In function '__process_abnormal_io':
> >> drivers/md/dm.c:1542:18: error: 'result' undeclared (first use in this function)
>     1542 |                 *result = BLK_STS_NOTSUPP;
>          |                  ^~~~~~
>    drivers/md/dm.c:1542:18: note: each undeclared identifier is reported only once for each function it appears in
> 

Yeah, I pushed this too soon, fixed now.

But why are you even testing this branch? I didn't include dm-5.19 in
linux-next yet.

Given that it seems strange for the bot to just pick up some branch,
and then spam LKML, dm-devel, etc like it found a meaningful problem.

Mike

