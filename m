Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04285536E92
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiE1VXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 17:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiE1VXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 17:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F6DC5AED2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653772989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kE+5xG8jcmXULJ9dKwJxu9sTJadmTdzBiQn8/DuDpEQ=;
        b=GX39E/GJ3b/aH+37v57p/JO3W1mUdF8iNqXJwohnoU2hVmbTQY979G7llZRIO7k4EhOKxd
        Hr8qFeBJMuY8a28DoHiHeufKvwdZ/qiRCepROTGBY18/6lcGNDMfRIbAkemZRiyne0G5oN
        UagL0N2b7Sf+S5zuSTI0Z1is/1OabOA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-SaXuwEUyMDii6qqwQ-FwAQ-1; Sat, 28 May 2022 17:23:08 -0400
X-MC-Unique: SaXuwEUyMDii6qqwQ-FwAQ-1
Received: by mail-wm1-f70.google.com with SMTP id m10-20020a05600c3b0a00b003948b870a8dso7017985wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kE+5xG8jcmXULJ9dKwJxu9sTJadmTdzBiQn8/DuDpEQ=;
        b=60NpRpkhqMTIR7mwEigPhglZNnBc6WsMke+Ka0HQTKD9WRZbjzz1XOB9SUqyXzPoUK
         GdHRDyQJGyRq0NgcRJHMrg28o1yS/NSQrkX9BUbQ1DSFwUPHulULHjVNZrNMn6bBGveW
         dp4lLdNcXBDb6K8ZWiD9DtGPP/lC/2j7ZGJeHIkeg4uaBINBMwhMM9f1ShVphZjrJ8rP
         rpqx1yjl6B6pB+82sIgugMbALzxWz/7lSUbCWJFhAGNEwfWI8pTkQleuymCIpEnPkx79
         AUEaNt/IEVNBGDemtvovogMDTBljYzdRceUsPdDPNO9PcOZq8KeTgNY4aMLN9K9WVICI
         XmUA==
X-Gm-Message-State: AOAM533y9Vh2ra3CQQ/+iDYhYP57ZRnu10yoIPfLZ7ho6qNskOGRBXVQ
        CMQLkpYniz8XoZWmqL4JUxaVY1S7CxR3AwRZoHY4j0UPbDfaSd2S8X4HIKXn8jU6bUZIZ0E4Z50
        sqaoSCGPGcYUJx7JZANuZhKWH
X-Received: by 2002:a05:600c:3ac3:b0:399:323:3a8d with SMTP id d3-20020a05600c3ac300b0039903233a8dmr4225465wms.101.1653772986551;
        Sat, 28 May 2022 14:23:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVsSyOb0XnZ6URggw11kE8MM0LpxnqIgbC4pGmvn1ihhE65XG3cF1k/hqeHqV6T9b9R7rRuA==
X-Received: by 2002:a05:600c:3ac3:b0:399:323:3a8d with SMTP id d3-20020a05600c3ac300b0039903233a8dmr4225455wms.101.1653772986199;
        Sat, 28 May 2022 14:23:06 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b0020fded972c0sm6055347wrr.45.2022.05.28.14.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 14:23:05 -0700 (PDT)
Message-ID: <607265eb-bfbf-4134-f2fe-d66cacd7bfbb@redhat.com>
Date:   Sat, 28 May 2022 23:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: drivers/gpu/drm/solomon/ssd130x-spi.c:154:35: warning: unused
 variable 'ssd130x_spi_table'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <202205290422.eoxGqDMR-lkp@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <202205290422.eoxGqDMR-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 5/28/22 22:58, kernel test robot wrote:
> Hi Javier,
> 
> FYI, the error/warning still remains.
>

Yes, but in my opinion is a false positive.
 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
> commit: 74373977d2ca26e5735377f8874be70bc2f030f5 drm/solomon: Add SSD130x OLED displays SPI support
> date:   5 weeks ago
> config: hexagon-randconfig-r033-20220529 (https://download.01.org/0day-ci/archive/20220529/202205290422.eoxGqDMR-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74373977d2ca26e5735377f8874be70bc2f030f5
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 74373977d2ca26e5735377f8874be70bc2f030f5
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/solomon/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/gpu/drm/solomon/ssd130x-spi.c:154:35: warning: unused variable 'ssd130x_spi_table' [-Wunused-const-variable]
>    static const struct spi_device_id ssd130x_spi_table[] = {
>                                      ^
>    1 warning generated.
> 
> 
> vim +/ssd130x_spi_table +154 drivers/gpu/drm/solomon/ssd130x-spi.c
> 
>    145	
>    146	/*
>    147	 * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
>    148	 * if the device was registered via OF. This means that the module will not be
>    149	 * auto loaded, unless it contains an alias that matches the MODALIAS reported.
>    150	 *
>    151	 * To workaround this issue, add a SPI device ID table. Even when this should
>    152	 * not be needed for this driver to match the registered SPI devices.
>    153	 */
>  > 154	static const struct spi_device_id ssd130x_spi_table[] = {

This comment is quite clear about it, the table only exists due a limitation in how
the SPI subsystem reports the module aliases. It always report a "spi:<device> even
if it was registered by OF, and that's the only reason why we need it.

Setting the struct spi_driver .id field just to make this warning go away would be
the wrong thing to do IMO, since always the struct of_device_id should be used.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

