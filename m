Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6289528278
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiEPKp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbiEPKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327725280;
        Mon, 16 May 2022 03:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB8D960F27;
        Mon, 16 May 2022 10:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA7DC34119;
        Mon, 16 May 2022 10:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652697898;
        bh=8e86Bl8VYKJuozeVnXgHNviEIwU1zooEoIg8B9aysS8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XNsx9Lp0Uyr3ubMiRW1dnbg/fR0pDdvuXh+0oYQBEMrDDUk7iAiW7GbC58D/yK3RE
         8umVVFbUErwYkcH5VZhcqI6Ao/CAv4o3Tw1+81cBW+guGBXn/TjW6grLmokZ5X4cs0
         EBfhCSbEvwKRrtNDDv41BtzLuySfmEZ+CXplj4sSzALvc9548rBa0Yqo/IodbscYA0
         WzFDgN7rAgWx/IsNO6OYBSy1wbc/oCJYoYlECO2QN1MM55/s6IsdY8vW1QBkM2QXmC
         enrtrJs8SXiTewhml8IOKlqFjFT11gu7bYe5S9TVetdtpO0oq/vxS/pWK4gZCJe8jc
         UKY0TS8MNdvtw==
Message-ID: <874f08d9-e67e-f7f3-4d98-89bdb8333ce5@kernel.org>
Date:   Mon, 16 May 2022 12:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 4/6] thermal: exynos: fixed the efuse min/max value for
 exynos5422
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
References: <20220515064126.1424-5-linux.amoon@gmail.com>
 <202205161820.8rHIcsvI-lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <202205161820.8rHIcsvI-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 12:42, kernel test robot wrote:
> Hi Anand,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on ec7f49619d8ee13e108740c82f942cd401b989e9]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/Exynos-Thermal-code-inprovement/20220515-144336
> base:   ec7f49619d8ee13e108740c82f942cd401b989e9
> config: hexagon-randconfig-r033-20220516 (https://download.01.org/0day-ci/archive/20220516/202205161820.8rHIcsvI-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/eb50b0c2100fabd6d09b87abd11f52c5295512e8
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Anand-Moon/Exynos-Thermal-code-inprovement/20220515-144336
>         git checkout eb50b0c2100fabd6d09b87abd11f52c5295512e8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/thermal/samsung/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/thermal/samsung/exynos_tmu.c:929:40: warning: overlapping comparisons always evaluate to false [-Wtautological-overlap-compare]
>                    if (data->soc == SOC_ARCH_EXYNOS5420 &&
>                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>    1 warning generated.

Ah, I did not notice it and it seems code was not compile-tested with W=1.

Anand, please be sure you compile your code with W=1...


Best regards,
Krzysztof
