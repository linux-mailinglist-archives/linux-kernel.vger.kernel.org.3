Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D08532D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiEXPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbiEXPXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:23:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCF69E9CF;
        Tue, 24 May 2022 08:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19B76B8198C;
        Tue, 24 May 2022 15:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA47EC34113;
        Tue, 24 May 2022 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653405760;
        bh=Zavzl0EUlZlFuUnnulu91af2QlQ6Gvei0hqhIXk6Wjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=to3yzRafvciUEnSb39LYNBe/xWkqQtoh1rmu/hFlMGci2JbBXauyj76DC9AMEfxzS
         ffO+lAl6i2S9Zz1l5owGqBHPe22GTPYHHiIeU9rUsR0jU3xGyzbZ9D2q3OEnI4W8wp
         nIM6Axb4zHKmMDEhsP4hb9W6LE17upO5Ats4LCpry32oe5WDbyzX1OFVzIiBGFKP2z
         FrA6N6I6/BIJE/MsTDD0pQGMSCrcSHpEmE7iK+94QeldEb3H64qKLPGJlm82NgWy16
         6epR8L9e+ryAf6/GrttwejgG2mPbZkMXbziYxjvbeyyyijvWgH12jR5BQ+3Tqt8Kvm
         R4Tjnx4n5E88Q==
Date:   Tue, 24 May 2022 08:22:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     kernel test robot <lkp@intel.com>, axboe@kernel.dk, hch@lst.de,
        snitzer@redhat.com, damien.lemoal@opensource.wdc.com, hare@suse.de,
        Johannes.Thumshirn@wdc.com, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 5/7] null_blk: allow non power of 2 zoned devices
Message-ID: <Yoz4PsQjWzVxz+YO@dev-arch.thelio-3990X>
References: <20220523161601.58078-6-p.raghav@samsung.com>
 <CGME20220524024108eucas1p26a6384cd77f143bb0fa628f01866e0a0@eucas1p2.samsung.com>
 <202205241034.izkLMTcH-lkp@intel.com>
 <7656fdc2-0511-722e-de6a-c2a2460cb048@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7656fdc2-0511-722e-de6a-c2a2460cb048@samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 09:30:41AM +0200, Pankaj Raghav wrote:
> On 5/24/22 04:40, kernel test robot wrote:
> > Hi Pankaj,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on axboe-block/for-next]
> > [also build test ERROR on device-mapper-dm/for-next linus/master hch-configfs/for-next v5.18 next-20220523]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://protect2.fireeye.com/v1/url?k=8acc50e6-d557681b-8acddba9-000babff317b-0ca211d60a57a8c6&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FPankaj-Raghav%2Fblock-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze%2F20220524-011616
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> > config: hexagon-randconfig-r045-20220523 (https://protect2.fireeye.com/v1/url?k=0dc32741-52581fbc-0dc2ac0e-000babff317b-fb6f258f0c80ebb9&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220524%2F202205241034.izkLMTcH-lkp%40intel.com%2Fconfig)
> > compiler: clang version 15.0.0 (https://protect2.fireeye.com/v1/url?k=afbb4f4f-f02077b2-afbac400-000babff317b-a4413fa4cefe1877&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
> > reproduce (this is a W=1 build):
> >         wget https://protect2.fireeye.com/v1/url?k=718573dc-2e1e4b21-7184f893-000babff317b-b6c06a1c569b0d77&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://protect2.fireeye.com/v1/url?k=247d070f-7be63ff2-247c8c40-000babff317b-6fd7f2f6a5a5bc60&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommit%2F3d3c81da0adbd40eb0d2125327b7e227582b2a37
> >         git remote add linux-review https://protect2.fireeye.com/v1/url?k=081be8db-5780d026-081a6394-000babff317b-d12fdca0fccd0493&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux
> >         git fetch --no-tags linux-review Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220524-011616
> >         git checkout 3d3c81da0adbd40eb0d2125327b7e227582b2a37
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> >>> ERROR: modpost: "__hexagon_umoddi3" [drivers/block/null_blk/null_blk.ko] undefined!
> 
> I am able to apply my patches cleanly against next-20220523, build it
> without any errors with GCC and boot into it in my x86_64 machine. Not
> sure why this error is popping up.

Do a 32-bit build and you'll see it. With GCC 12.1.0, ARCH=i386
defconfig + CONFIG_BLK_DEV_NULL_BLK=y + CONFIG_BLK_DEV_ZONED=y
reproduces it for me:

$ make -skj"$(nproc)" ARCH=i386 defconfig menuconfig all
ld: drivers/block/null_blk/zoned.o: in function `null_init_zoned_dev':
zoned.c:(.text+0x112e): undefined reference to `__umoddi3'
...

roundup() does a plain division with a 64-bit dividend, which will cause
issues with 32-bit architectures. I suspect that you should really be
using DIV_ROUND_UP_SECTOR_T() for the nr_zones calculation or maybe one
of the other rounding macros in include/linux/math.h but I am not sure.

Cheers,
Nathan
