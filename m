Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2D4C9237
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiCARyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiCARyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:54:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73E9E29B;
        Tue,  1 Mar 2022 09:53:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F7A1042;
        Tue,  1 Mar 2022 09:53:27 -0800 (PST)
Received: from [10.57.20.71] (unknown [10.57.20.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92F3B3F73D;
        Tue,  1 Mar 2022 09:53:25 -0800 (PST)
Message-ID: <79fa792f-adb4-8c98-507d-55dc2a6273ea@arm.com>
Date:   Tue, 1 Mar 2022 17:53:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220301093524.8870-4-lukasz.luba@arm.com>
 <202203020012.g7rYUP7M-lkp@intel.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <202203020012.g7rYUP7M-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/22 16:58, kernel test robot wrote:
> Hi Lukasz,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on linux/master rafael-pm/linux-next linus/master v5.17-rc6 next-20220301]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Lukasz-Luba/Introduce-opp-microwatt-and-Energy-Model-from-DT/20220301-173700
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arc-randconfig-r014-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020012.g7rYUP7M-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/e1e83de9bf2f261cb3e5eb9f53bde3c83c6e0647
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Lukasz-Luba/Introduce-opp-microwatt-and-Energy-Model-from-DT/20220301-173700
>          git checkout e1e83de9bf2f261cb3e5eb9f53bde3c83c6e0647
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/opp/of.c: In function 'dev_pm_opp_of_register_em':
>>> drivers/opp/of.c:1572:22: error: 'struct em_data_callback' has no member named 'active_power'
>      1572 |                 em_cb.active_power = _get_dt_power;
>           |                      ^
> 

Indeed, this structure is an empty definition for !EM kernels.
Let me create a fix for that.
