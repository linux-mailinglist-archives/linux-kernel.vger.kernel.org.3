Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647894C2198
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiBXCK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiBXCKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:10:55 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3E21CF0B3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:10:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s1so421164plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZnYyCAf+hdzZPaSLfbrxFcyypRq31HWt0QkCGBGFrL0=;
        b=h37je/lozqkhikqOTu3IGvHe+nLK0KNm8oY9hgpZZM5j8B6EkUFcaHMCGg7sas6KEP
         5OQmnC/Kmd4pFkA8nL5z90Tv1In8T53po07djNVrq4oRAQIdJ0/O025JwGnUn6NwUpO4
         BRo7mgX9IK6Z/zaBJWUDibiLcprRQq+KZq+2fBcD0NJvUNbKveqbtkWIetmy/zjiJOC3
         s5OznjvRYi91RQoX0drMOtVjoDiyIoojBDgaJTn/XfGupUBeS6fgD23coiiuCQMVtTwQ
         J12ea7XNE0K5fcwHtI4m63QNrparwJzIup8BbjyK8yQF4UJT+Iz8J32XWGx3Vkc1lAoh
         Byyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZnYyCAf+hdzZPaSLfbrxFcyypRq31HWt0QkCGBGFrL0=;
        b=qqT3D+R0roRB6kM+QyxocGuCPcJpl79VV0dTM91SQRzN22m9k0UUpOg6V/8G+FNxHz
         pQNYjHl6eSJNGem9fumQ4IewCcO5flNFimIOB38ltK00NxipmPnBjeLEmJIKUYXmLvtk
         uxuRC+BhqHhp+VDB4Ugp4t0NZ1MOp/ZtRtWcvfkL4N4gwZpF/R6bbNVtUgZg5F7S7q+4
         ox36f7QVBTYOYZHF5FIYLXpBKgVIpwwM50FqDW3aewAYt+ltfcXxd64ysUhycUZItfw6
         ysRZySHf4OFZAGLt8mb8qpKc/ru56YtmEeR1TpvLm2coeRcu/X/aw8y8tw8eOQXRbei2
         2K7w==
X-Gm-Message-State: AOAM5304FxslaGh9EXBXCCJjhqkpcFl4wngrI/L7jYt+az+ipjb0S/AN
        LvimDmAJDn7nbXmwbVQr4LDT1A==
X-Google-Smtp-Source: ABdhPJw2Rk8+ph45n2HaQvviEcQivEktRcnCj9JX+OTKugbwjD1rinTtyuEnbDe9efILwF8LiouLMw==
X-Received: by 2002:a17:90b:110a:b0:1b9:eb62:7c00 with SMTP id gi10-20020a17090b110a00b001b9eb627c00mr492851pjb.67.1645668625737;
        Wed, 23 Feb 2022 18:10:25 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id y23sm719167pgi.36.2022.02.23.18.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 18:10:25 -0800 (PST)
Date:   Thu, 24 Feb 2022 10:10:17 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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
Message-ID: <20220224021017.GA269879@dragon>
References: <20220223125536.230224-4-shawn.guo@linaro.org>
 <202202240730.8ES2LbM6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202240730.8ES2LbM6-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 07:43:21AM +0800, kernel test robot wrote:
> Hi Shawn,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/irq/core]
> [also build test WARNING on robh/for-next linus/master v5.17-rc5 next-20220222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Shawn-Guo/Add-Qualcomm-MPM-irqchip-driver-support/20220223-210123
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git d2206fcabdfaff3958ab67cc5b8f63257e57b889
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220224/202202240730.8ES2LbM6-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/17f8a23f57bf6d0177f6ef6f78237b37bd853e8d
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Shawn-Guo/Add-Qualcomm-MPM-irqchip-driver-support/20220223-210123
>         git checkout 17f8a23f57bf6d0177f6ef6f78237b37bd853e8d
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/irqchip/qcom-mpm.c:210:21: warning: no previous prototype for 'get_mpm_gic_map' [-Wmissing-prototypes]
>      210 | struct mpm_gic_map *get_mpm_gic_map(struct qcom_mpm_priv *priv, int pin)
>          |                     ^~~~~~~~~~~~~~~

Oops!  The 'static' declaration got lost.  Will fix in the next version.

Shawn
