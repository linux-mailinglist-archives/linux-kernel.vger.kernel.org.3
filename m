Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABC4C40BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiBYIy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbiBYIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:54:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ECC225013;
        Fri, 25 Feb 2022 00:54:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA523B82BAA;
        Fri, 25 Feb 2022 08:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D09C340E7;
        Fri, 25 Feb 2022 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645779253;
        bh=qDoHRAR0vvt/ZOgxnKgt3lhWxvnrIion7K3HBk+YVgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KYzzVltmm5KxJGNhO3xtIbnoMqZ00TL9l7j9vGQUcukoE65EhBB7jbSswWNYflDDa
         UJ3Vezwm3/28LBomN8KcuIiNKBFdX3rquABxCk5Juur3dkVQdrf+U88Hiup2AZuBee
         kDenJRgqW0Xf4TCldYRIBnzB13PJqihMKKIiIXS4lW9iB0zfYebP0XJQjjkA8+DbqJ
         p3xFo5uFvo2c9K8CFsV4ZJZ9CMibOFDZCgdhhBwyWX6mSntijigViaz1yjjFEMdJS6
         eHl2rxXnQ8fwFMsbFhuf0zNhEuzXArFw6ABZV3X5ulb96VzfuD7VzO4GCANuTeEtMF
         6xhLQNBdy/2bg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nNWMc-00ASxv-Or; Fri, 25 Feb 2022 08:54:10 +0000
MIME-Version: 1.0
Date:   Fri, 25 Feb 2022 08:54:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     kernel test robot <lkp@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, kbuild-all@lists.01.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] irqchip: Add Qualcomm MPM controller driver
In-Reply-To: <20220224021017.GA269879@dragon>
References: <20220223125536.230224-4-shawn.guo@linaro.org>
 <202202240730.8ES2LbM6-lkp@intel.com> <20220224021017.GA269879@dragon>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8eff0caf8a8a10f0e8bf99bc9f949c5d@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: shawn.guo@linaro.org, lkp@intel.com, rafael@kernel.org, kbuild-all@lists.01.org, valentin.schneider@arm.com, bigeasy@linutronix.de, tglx@linutronix.de, quic_mkshah@quicinc.com, bjorn.andersson@linaro.org, sudeep.holla@arm.com, ulf.hansson@linaro.org, daniel.lezcano@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-24 02:10, Shawn Guo wrote:
> On Thu, Feb 24, 2022 at 07:43:21AM +0800, kernel test robot wrote:
>> Hi Shawn,
>> 
>> I love your patch! Perhaps something to improve:
>> 
>> [auto build test WARNING on tip/irq/core]
>> [also build test WARNING on robh/for-next linus/master v5.17-rc5 
>> next-20220222]
>> [If your patch is applied to the wrong git tree, kindly drop us a 
>> note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>> 
>> url:    
>> https://github.com/0day-ci/linux/commits/Shawn-Guo/Add-Qualcomm-MPM-irqchip-driver-support/20220223-210123
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 
>> d2206fcabdfaff3958ab67cc5b8f63257e57b889
>> config: arm64-allyesconfig 
>> (https://download.01.org/0day-ci/archive/20220224/202202240730.8ES2LbM6-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>         wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # 
>> https://github.com/0day-ci/linux/commit/17f8a23f57bf6d0177f6ef6f78237b37bd853e8d
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review 
>> Shawn-Guo/Add-Qualcomm-MPM-irqchip-driver-support/20220223-210123
>>         git checkout 17f8a23f57bf6d0177f6ef6f78237b37bd853e8d
>>         # save the config file to linux build tree
>>         mkdir build_dir
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 
>> make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/
>> 
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>> 
>> All warnings (new ones prefixed by >>):
>> 
>> >> drivers/irqchip/qcom-mpm.c:210:21: warning: no previous prototype for 'get_mpm_gic_map' [-Wmissing-prototypes]
>>      210 | struct mpm_gic_map *get_mpm_gic_map(struct qcom_mpm_priv 
>> *priv, int pin)
>>          |                     ^~~~~~~~~~~~~~~
> 
> Oops!  The 'static' declaration got lost.  Will fix in the next 
> version.

While you're at it, please rename this driver to irq-qcom-mpm.c
in order to match the rest of the drivers. I have no idea
why the QC stuff is named differently...

         M.
-- 
Jazz is not dead. It just smells funny...
