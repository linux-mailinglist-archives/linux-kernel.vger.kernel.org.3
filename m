Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6818A51039B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353016AbiDZQjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiDZQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:39:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18BBC9B;
        Tue, 26 Apr 2022 09:36:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="253019521"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="253019521"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="595840747"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2022 09:30:00 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.79])
        by linux.intel.com (Postfix) with ESMTP id 56DA7580689;
        Tue, 26 Apr 2022 09:29:58 -0700 (PDT)
Message-ID: <47cbbe94b061d8d7b7c222a42fa80b7b4cd4b7e5.camel@gmail.com>
Subject: Re: [RFC PATCH v3 2/5] cpuidle: Add Cpufreq Active Stats calls
 tracking idle entry/exit
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, amit.kachhap@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 26 Apr 2022 19:29:57 +0300
In-Reply-To: <36852629-f803-5ac9-bef5-bcfae3ed947d@arm.com>
References: <20220406220809.22555-1-lukasz.luba@arm.com>
         <20220406220809.22555-3-lukasz.luba@arm.com>
         <97e7e3f5110702fab727b4df7d53511aef5c60b1.camel@gmail.com>
         <36852629-f803-5ac9-bef5-bcfae3ed947d@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 16:01 +0100, Lukasz Luba wrote:
> > I am worried about adding more stuff here.
> > 
> > Please, consider getting the stats after interrupts are re-enabled. You may
> > lose
> > some "precision" because of that, but it is probably overall better that
> > adding
> > to idle interrupt latency.
> 
> Definitely. I don't need such precision, so later when interrupts are
> re-enabled is OK for me.

Thanks. That is preferable in general: we do not do things with interrupts
disabled unless there is a very good reason to.

> 
> This new call might be empty for your x86 kernels, since probably
> you set the CONFIG_CPU_FREQ_STAT.I can add additional config
> so platforms might still have CONFIG_CPU_FREQ_STAT but avoid this
> new feature and additional overhead in idle exit when e.g.
> CONFIG_CPU_FREQ_ACTIVE_STAT is not set.
> 
> The x86 platforms won't use IPA governor, so it's reasonable to
> do this way.
> 
> Does this sounds good?

I did not thoroughly read your patches so can't comment on the details.

Just pointing that in general idle path is to be considered the critical path,
especially the part before interrupts are re-enabled. Not only on x86,
but on all platforms using cpuidle. This does not mean we can't read more
statistics there, but it does mean that we should be very careful about added
overhead, keep it under control, etc.

Thank you!

