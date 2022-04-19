Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71529506F83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352937AbiDSN5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiDSN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:57:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F64FC8;
        Tue, 19 Apr 2022 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650376471; x=1681912471;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h8Z+PjLHQQIwzYm6YM3AVAlGFVl+kGFKlyja/ixPPxE=;
  b=hIkUnG6wwIcFi/al60jF5Tty1sxeD+PbF1oWUEeXbJGKEoBfUsDLJGM0
   TfVsxrFikWom4mia0cYNm8KmVEsoDm6nzRh7xCn4UDL13ogvc+LrVA1m8
   TPtxnGEJKxw7L3ZVo4Z34bV37lxZEFkDNG8T3fl+QKJx0S4Ktt7lOw1/g
   WheJesiBGws8rxIWFWyI2O7+0fsehWMo/w6ccaOkEIUWPxW8VPC9Om2yk
   IrVU/6WUsnuxnaQoi3Axi5/rfbH2c0d4TDSO8W5/+A0p1PD8RuR5vWHvi
   Z0JgWUJIWwNQ3H01EozqlURbNHvF74QM32Df+I22LIujCeMTbXZ0o0YQC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288866668"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="288866668"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 06:54:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="576109589"
Received: from majiangy-mobl.ccr.corp.intel.com ([10.249.173.141])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 06:54:28 -0700
Message-ID: <df7e04d86dd64dc85125d536434d93bab3d6314d.camel@intel.com>
Subject: Re: [PATCH v1] thermal/core: change mm alloc method to avoid kernel
 warning
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Junwen Wu <wudaemon@163.com>, rafael@kernel.org,
        amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 19 Apr 2022 21:54:26 +0800
In-Reply-To: <01f72a07-6adc-4854-eae2-286786d33aab@linaro.org>
References: <20220417125601.18535-1-wudaemon@163.com>
         <a7861e9a6a311f09c03b2e6e47dd4d3283cb58e2.camel@intel.com>
         <01f72a07-6adc-4854-eae2-286786d33aab@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Viresh.

On Tue, 2022-04-19 at 11:14 +0200, Daniel Lezcano wrote:
> On 19/04/2022 10:48, Zhang Rui wrote:
> > On Sun, 2022-04-17 at 12:56 +0000, Junwen Wu wrote:
> > > Very high cooling device max state value makes cooling device
> > > stats
> > > buffer allocation fails,like below.Using kzvalloc instead of
> > > kzalloc
> > > can avoid this issue.
> > 
> > When a cooling device has big max_state, this patch can get ride of
> > the
> > warning here, but still we end up with the read failure of the
> > trans_table in sysfs because it is larger than PAGE_SIZE.
> > 
> > $ cat /sys/class/thermal/cooling_device8/stats/trans_table
> > cat: /sys/class/thermal/cooling_device8/stats/trans_table: File too
> > large
> > 
> > IMO, unless we can fix both places, I'd suggest we skip allocating
> > and
> > creating the broken trans_table attr. Like a prototype patch below
> 
> Why not create a thermal debugfs with real useful information and
> get 
> rid of this broken code ?

The idea looks good to me.

thanks,
rui

