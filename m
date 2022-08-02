Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A4587B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiHBL3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiHBL3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:29:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA445313AD
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659439774; x=1690975774;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2W0p4AOerrYk2hF7PCF4DyJlk0QZ7/ldfaGLcxCA7fM=;
  b=cJpO2O0BBFs6JKzanEO+k1TaTH2EYIUinhe1dyLbTRhzQZwQu2tA27kX
   j1A2h5ti+th1Xl6WkibbMzD7sgmPDgpVEHxSJqiPoh65vheP6obwCXPdH
   YsN1DPQlFGiyzwFGb0GcEsB1rzFXiyF26b7v3vhI/9V/9EsSln+26walw
   /bpRKlgqnC9IPWd7Po8JNvcV18E8X63NFXQ3h4foPVPSXo8x7zsZJQHCP
   UuzCVV6x+nkcOOFcOq9HML+bi7JR12+Ar+DjvP56dbbtuopSbdTXz2qfb
   ik9YQnwi+BJaR0rkb2zePWARtV1YAXRowGZ/DTHbE4PLYxunOYqClu0yP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="315226398"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="315226398"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 04:29:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="661585782"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.249.174.172]) ([10.249.174.172])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 04:29:32 -0700
Message-ID: <897aa91c-9d45-e16a-9b09-849fab588cd7@intel.com>
Date:   Tue, 2 Aug 2022 19:29:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RESEND] x86/bus_lock: Don't assume the init value of
 DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20220802033206.21333-1-chenyi.qiang@intel.com>
 <YukBz6t1n3aMbznT@gmail.com>
From:   Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <YukBz6t1n3aMbznT@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2022 6:51 PM, Ingo Molnar wrote:
> 
> * Chenyi Qiang <chenyi.qiang@intel.com> wrote:
> 
>> It's possible that BIOS/firmware has set DEBUGCTLMSR_BUS_LOCK_DETECT, or
>> this kernel has been kexec'd from a kernel that enabled bus lock
>> detection.
>>
>> Disable bus lock detection explicitly if not wanted.
> 
> Makes sense.
> 
> Just curious: in what circumstances does the BIOS/firmware set
> DEBUGCTLMSR_BUS_LOCK_DETECT? Does it use it, or does it enable it for some
> spurious reason, without really using the feature? (Assuming you are aware
> of instances where this happened - or was this simply a hypothetical?)

Yes, It's just a hypothetical for BIOS/firmware. Kexec is the real case 
I met with this problem.

> 
> Thanks,
> 
> 	Ingo
