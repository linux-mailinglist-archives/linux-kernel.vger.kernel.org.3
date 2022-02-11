Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E844B29EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351016AbiBKQO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:14:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350520AbiBKQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:14:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED3021D;
        Fri, 11 Feb 2022 08:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644596092; x=1676132092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWbStBYrWNvjoowojkTzcClFVyUrdMqAa6rUIGP5GYk=;
  b=YfhjY0Itk7Qy8ZdLN7bomIuG5FfguhVSRHe+zAlXrokY9A3RvXuh4Ed4
   Sdcpl+JXLqXo2RGquuRybrk+axhKfUFRaP1uha8uxTKnldSSVV8AI+Nxj
   EddBGMo3P9LbKP1z+rmrB3AOBfYno3HqhPMdhuETS5CxpCKrDvoDk4Zju
   n3CrxUn58He29OEIbIclz6cDVAxTQ2uNhXTKaidoLMJ5Eur2UVudJmrSu
   lICAeAVghvJ3/4+uZ5kF0eeKxgq/ZeH5TAq3VA4mbn69+sWxXBy3cSVCq
   6Cgy7BlsqiVflhe25B6uVRdHs/ToCqmgGYORzEsYm6YLcTcjIDCSq5L3+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="313039538"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="313039538"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:14:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542143938"
Received: from chenyu-dev.sh.intel.com (HELO chenyu-dev) ([10.239.158.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:14:49 -0800
Date:   Sat, 12 Feb 2022 00:14:23 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Brown, Len" <len.brown@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tools/power turbostat: Support thermal throttle
 count print
Message-ID: <20220211161423.GA55414@chenyu-dev>
References: <20211112115159.725357-1-yu.c.chen@intel.com>
 <PH0PR11MB4887077D94A30A5F757F01B4E0309@PH0PR11MB4887.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB4887077D94A30A5F757F01B4E0309@PH0PR11MB4887.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,
On Fri, Feb 11, 2022 at 10:14:12AM +0800, Brown, Len wrote:
> What is the scope of this counter -- per-core or per-CPU?
>
The counter is read from
/sys/devices/system/cpu/cpu0/thermal_throttle/core_throttle_count,
which is calculated from MSR_IA32_THERM_STATUS (0x19c) in therm_throt.c.
According to sdm, this MSR is of core scope.

thanks,
Chenyu
> -----Original Message-----
> From: Chen, Yu C <yu.c.chen@intel.com>
> Sent: Friday, November 12, 2021 6:52 AM
> To: linux-pm@vger.kernel.org; Len Brown <lenb@kernel.org>
> Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>; Rafael J. Wysocki <rafael@kernel.org>; Brown, Len <len.brown@intel.com>; linux-kernel@vger.kernel.org; Chen, Yu C <yu.c.chen@intel.com>
> Subject: [PATCH 1/2] tools/power turbostat: Support thermal throttle count print
> 
> The turbostat data is collected by end user for power evaluationit. However it looks like we are missing enough thermal context there. Already a couple of time we found that power management developer asking something like this:
> grep -r . /sys/devices/system/cpu/cpu*/thermal_throttle/*
> 
> Print the per core thermal throttle count so as to get suffificent thermal context.
> 
> turbostat -i 5 -s Core,CPU,CoreThr
> Core    CPU     CoreThr
> -       -       104
> 0       0       61
> 0       4
> 1       1       0
> 1       5
> 2       2       104
> 2       6
> 3       3       7
> 3       7
> 
> Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
