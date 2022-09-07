Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A795B0C7D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIGS0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiIGS0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:26:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E99DBCC1F;
        Wed,  7 Sep 2022 11:26:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z20so16986861ljq.3;
        Wed, 07 Sep 2022 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Z9P17Yt0yBVUVeFH8T9sgH+GY3z+6mIu/hWAbTLi3gE=;
        b=bSBq6TrQEMMHQceNOwc7Uc3PucEeV7/m1nPzeUW8yOGLZNY+O3AMad8w93hHNktZr+
         7OFC0TAqOj3LanMxXMVzvbX9bca+jx8gsewboM9qLs8yLoty7khzGREqn6DR9vfyzNRQ
         tCuKV3S4qTixrgPar/hItGWEYMu8o3U166vRTALg83Jwk8QXg5ZODmWjswhzwFmZGssN
         Bi4Snob/0nesX+GoQA5PFNCvNia7V+v3Nmvw9BcdH6RDbhKBHxaCoILQLLHxbrp4kJN1
         BSXtGZfjDz/Be5gefJwsFaXAHZwXuwRsA1AQ2rkLURe0lLUEKe22kYlrhrHz5jzrUdwG
         +RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z9P17Yt0yBVUVeFH8T9sgH+GY3z+6mIu/hWAbTLi3gE=;
        b=yKoiG74mHUk26xCrXhH61e/yixEMPQ8sBpX/Ue7b5Yfsh2eLV03evOCZVvqN/a08ua
         oIE+yVAtg5stYIs4sMbTFOH6e2DuOTn49DZpLnTInDoD46RYWUdWWR1GiLAEdwXm3GGD
         UWFpa3Q2k9S054D/lDkzAo7IehVhqKxGjJKzZHJaCQAnZuDLkmDHgxJWbHJIhGY7UJFl
         czIWer2aosyqZipkd+0nO3PT4M90d+W8OR0b9Mf+YLbIJCs0pmQEgRnm/7PPr27b2INo
         1M4wuWmzqXWlf5Ns/yD3du81f8mqIlEtBOgmQvfmsPevvmGteECbK3c+nd/rhGttM2WA
         TryQ==
X-Gm-Message-State: ACgBeo0oai563s5JQbTKA6QSfA+chW+Xqw1TwSu3uUmLyLjpALJhN9zV
        L7nPYk5/rxsQx5Zl/Fu0GFC0RCaHlYGU4A==
X-Google-Smtp-Source: AA6agR7iwLntxAUMmySKwPm/4Mi+kVhw3ueG8RBFbNS7KyIQL4/zk+rTw2jYIU86FY1YZzQkN0C9Fg==
X-Received: by 2002:a2e:940d:0:b0:261:c5c8:3403 with SMTP id i13-20020a2e940d000000b00261c5c83403mr1488589ljh.86.1662575160567;
        Wed, 07 Sep 2022 11:26:00 -0700 (PDT)
Received: from mobilestation (89-109-51-230.dynamic.mts-nn.ru. [89.109.51.230])
        by smtp.gmail.com with ESMTPSA id 5-20020a2eb945000000b00267232d0652sm2817728ljs.46.2022.09.07.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:25:59 -0700 (PDT)
Date:   Wed, 7 Sep 2022 21:25:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        kbuild-all@lists.01.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 19/23] ata: ahci: Add DWC AHCI SATA controller support
Message-ID: <20220907182556.em57cl4g5nk2i4sc@mobilestation>
References: <20220822183728.24434-20-Sergey.Semin@baikalelectronics.ru>
 <202209040834.w5y0s1NR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209040834.w5y0s1NR-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 08:34:20AM +0800, kernel test robot wrote:
> Hi Serge,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on axboe-block/for-next linus/master v6.0-rc3 next-20220901]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220823-024133
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220904/202209040834.w5y0s1NR-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/e628913a210e29775bc995d1ed3ed58ab13416b8
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220823-024133
>         git checkout e628913a210e29775bc995d1ed3ed58ab13416b8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/ata/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/clk.h:13,
>                     from drivers/ata/ahci_dwc.c:11:
> >> drivers/ata/ahci_dwc.c:372:50: error: 'ahci_dwc_suspend' undeclared here (not in a function); did you mean 'ahci_dwc_probe'?
>      372 | static DEFINE_SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend,
>          |                                                  ^~~~~~~~~~~~~~~~
>    include/linux/kernel.h:57:44: note: in definition of macro 'PTR_IF'
>       57 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
>          |                                            ^~~
>    include/linux/pm.h:313:20: note: in expansion of macro 'pm_sleep_ptr'
>      313 |         .suspend = pm_sleep_ptr(suspend_fn), \
>          |                    ^~~~~~~~~~~~
>    include/linux/pm.h:373:9: note: in expansion of macro 'SYSTEM_SLEEP_PM_OPS'
>      373 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/pm.h:399:9: note: in expansion of macro '_DEFINE_DEV_PM_OPS'
>      399 |         _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
>          |         ^~~~~~~~~~~~~~~~~~
>    drivers/ata/ahci_dwc.c:372:8: note: in expansion of macro 'DEFINE_SIMPLE_DEV_PM_OPS'
>      372 | static DEFINE_SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend,
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/ata/ahci_dwc.c:373:33: error: 'ahci_dwc_resume' undeclared here (not in a function); did you mean 'ahci_port_resume'?
>      373 |                                 ahci_dwc_resume);
>          |                                 ^~~~~~~~~~~~~~~
>    include/linux/kernel.h:57:44: note: in definition of macro 'PTR_IF'
>       57 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
>          |                                            ^~~
>    include/linux/pm.h:314:19: note: in expansion of macro 'pm_sleep_ptr'
>      314 |         .resume = pm_sleep_ptr(resume_fn), \
>          |                   ^~~~~~~~~~~~
>    include/linux/pm.h:373:9: note: in expansion of macro 'SYSTEM_SLEEP_PM_OPS'
>      373 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/pm.h:399:9: note: in expansion of macro '_DEFINE_DEV_PM_OPS'
>      399 |         _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
>          |         ^~~~~~~~~~~~~~~~~~
>    drivers/ata/ahci_dwc.c:372:8: note: in expansion of macro 'DEFINE_SIMPLE_DEV_PM_OPS'
>      372 | static DEFINE_SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend,
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/ata/ahci_dwc.c:267:12: warning: 'ahci_dwc_reinit_host' defined but not used [-Wunused-function]
>      267 | static int ahci_dwc_reinit_host(struct ahci_host_priv *hpriv)
>          |            ^~~~~~~~~~~~~~~~~~~~

Right. The SYSTEM_SLEEP_PM_OPS macro doesn't imply ifdef'ing the sleep
action-methods. I'll drop the conditional compilation then.

-Sergey

> 
> 
> vim +372 drivers/ata/ahci_dwc.c
> 
>    371	
>  > 372	static DEFINE_SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend,
>  > 373					ahci_dwc_resume);
>    374	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
