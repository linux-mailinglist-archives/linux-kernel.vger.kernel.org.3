Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084C25727A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiGLUsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiGLUsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:48:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E4B1B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657658912; x=1689194912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nKWuUZL0vVOwmZ4EvjGoPC+cBdsZAAfucO9FK3vKz4k=;
  b=G0eGuq8lFmnV87xrEgywiiD2oxQwK7FFWbEmAije5T54tbrmpSBeXPcQ
   92T2U4Ayr0Mc6Dt0gfmELtl+q3Y73aX3+7Nx30x3tBcuiseyzynISEBHA
   gyoclOVN4nUKMCWiVc5D8j9maXlbHj5+GndkaG5UHaMkk4khSWClJ0Ead
   DKXLfeyQ/RaGuwEGJKay4pWxC/jYRTj9lfxM+TkZi3/TF1BUWnuZHwNmC
   rKVadcaK+7azyGo4evvmoZmcIsc4wIvNAh0+XE0QV6QhC3t4HEOpqU5JO
   tNmrVJUpO5EzIBfpN/y83YehDGnr0ZBpYk+99IvTLcK6uEIS2Glv7w8+a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285066430"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="285066430"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 13:48:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="922353916"
Received: from guptapa-desk.jf.intel.com (HELO guptapa-desk) ([10.24.8.127])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 13:48:32 -0700
Date:   Tue, 12 Jul 2022 13:48:30 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x689 in
 intel_pmu_lbr_restore
Message-ID: <20220712204830.kvblayj37s3udt4b@guptapa-desk>
References: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu>
 <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu>
 <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com>
 <20220711221658.4gpkizopmftpnav6@guptapa-desk>
 <32ccdda1-63bf-746e-48fb-935fa58285b1@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <32ccdda1-63bf-746e-48fb-935fa58285b1@maine.edu>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:39:56PM -0400, Vince Weaver wrote:
>On Mon, 11 Jul 2022, Pawan Gupta wrote:
>
>> Output of below would be helpful:
>>
>> # grep "rtm\|hle" /proc/cpuinfo
>
>no results
>
>> ARCH_CAP
>> # rdmsr 0x10a
>
>rdmsr: CPU 0 cannot read MSR 0x0000010a
>
>> TSX_CTRL
>> # rdmsr 0x122
>
>rdmsr: CPU 0 cannot read MSR 0x00000122
>
>> MCU_OPT_CTRL
>> # rdmsr 0x123
>
>0
>
>> TSX_FORCE_ABORT
>> # rdmsr 0x10f
>
>rdmsr: CPU 0 cannot read MSR 0x0000010f

It appears this CPU does not support TSX feature (or disabling TSX). If
the bug is easy to reproduce, bisecting can help.

Thanks,
Pawan
