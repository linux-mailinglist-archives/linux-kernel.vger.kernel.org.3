Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1780453BBE2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbiFBPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiFBPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:52:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D471153;
        Thu,  2 Jun 2022 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654185172; x=1685721172;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=stX6Gbo8Um10A6pAxqR7sGPejpzsxUNu9FxYx00Kap4=;
  b=cmmH804WMCgdWqBbGi9PAHWdewtf0Acbsc2AHjOKjIGGj/F7TeDz9RCa
   eiqNBYEukIPoPtDnxHV+UxihmGF+OOx4pe08hDffANZNqVpdHT64iddu1
   qNA+dICQlk/lnUXQLRuCTJH+16qkXo5UUDgaarP4lXf6lZDrqTjB/f/yh
   VrNuLlAc90M8uQ+ccS+HLCgjCkXYMsH+azoK2H8Hh8VwiaKMnxdjiV1zz
   Qz/j7TsMgNAdMkO2+O0otoooXk8/ApKUNdHFkE+RcrNB7prdbG2M1Ycsh
   Gx0vwnVvO/GNdfL2VpMTTnh4j2ipH+tjbCggvHr9CK5du1imrWmo4mv8S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="256468521"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="256468521"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 08:52:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="606908627"
Received: from bcappucc-mobl3.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.183.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 08:52:49 -0700
Message-ID: <6caf53e059758234ee12a236f967412f1df1f8a0.camel@linux.intel.com>
Subject: Re: x86/mce/therm_throt incorrect THERM_STATUS_CLEAR_CORE_MASK?
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>, Len Brown <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Jun 2022 08:52:49 -0700
In-Reply-To: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
References: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 11:19 +0200, Arnd Bergmann wrote:
> I have a Xeon W-2265 (family 6, model 85, stepping 7) that started
> constantly spewing messages from the therm_throt driver after one
> core overheated:
> 
I think this is a Cascade Lake system. Have you tried the latest micro-
code?

Thanks,
Srinivas


> May 31 13:57:54 kernel: [15512.209474] unchecked MSR access error:
> WRMSR to 0x19c (tried to write 0x0000000000002a80) at rIP:
> 0xffffffff9f67f974 (native_write_msr+0x4/0x20)
> May 31 13:57:54 kernel: [15512.209486] Call Trace:
> May 31 13:57:54 kernel: [15512.209488]  <TASK>
> May 31 13:57:54 kernel: [15512.209489]  ?
> throttle_active_work+0xea/0x1f0
> May 31 13:57:54 kernel: [15512.209498]  process_one_work+0x21d/0x3c0
> May 31 13:57:54 kernel: [15512.209502]  worker_thread+0x4d/0x3f0
> May 31 13:57:54 kernel: [15512.209505]  ?
> process_one_work+0x3c0/0x3c0
> May 31 13:57:54 kernel: [15512.209508]  kthread+0x127/0x150
> May 31 13:57:54 kernel: [15512.209510]  ?
> set_kthread_struct+0x40/0x40
> May 31 13:57:54 kernel: [15512.209513]  ret_from_fork+0x1f/0x30
> ...
> May 31 13:57:59 kernel: [15517.333445] CPU11: Core temperature is
> above threshold, cpu clock is throttled (total events = 3)
> 
> I could not find CPU model specific documentation for this register,
> but I see that in [1], the bits 13 through 15 are marked as reserved
> in some cases but not others. Manually writing the value 0xa80
> instead of 0x2a80 from user space makes the warnings stop, so
> my guess is that this CPU does not support the 0x2000 bit:
> 
> $ sudo  wrmsr -p 11 0x19c 0xa80 ; dmesg
> [177764.874555] msr: Write to unrecognized MSR 0x19c by wrmsr (pid:
> 142969).
> [177764.874560] msr: See
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about for
> details.
> [177765.371180] CPU11: Core temperature/speed normal (total events =
> 42)
> [177765.371180] CPU23: Core temperature/speed normal (total events =
> 42)
> 
> I have not tried the patch below, but I think this would address it
> on my
> system, while likely breaking other machines. Any ideas what the
> correct fix is?
> 
>       Arnd
> 
> diff --git a/drivers/thermal/intel/therm_throt.c
> b/drivers/thermal/intel/therm_throt.c
> index 8352083b87c7..620d7f4c013e 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -196,7 +196,7 @@ static const struct attribute_group
> thermal_attr_group = {
>  #define THERM_THROT_POLL_INTERVAL      HZ
>  #define THERM_STATUS_PROCHOT_LOG       BIT(1)
> 
> -#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) |
> BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
> +#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) |
> BIT(7) | BIT(9) | BIT(11))
>  #define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) |
> BIT(7) | BIT(9) | BIT(11))
> 
>  static void clear_therm_status_log(int level)
> 
> [1]
> https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3b-part-2-manual.pdf

