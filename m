Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25C514F46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378362AbiD2P2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347700AbiD2P2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:28:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727022715F;
        Fri, 29 Apr 2022 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651245923; x=1682781923;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eeKyhOBRUI1IcGJ5XnaC/aIAFeT6U3CIYVyZUOAV/xE=;
  b=BY5hlhBwP2ZZLFlBclrAmAaYTbyFTlkEOjyb8u4W2+aNoUqp0x3U8suQ
   DdYs7nDuexKlimjwOMiS+/i8wctoBrXCvgJgO6RmMJaopO/tST98viDQr
   ePWCMAf4zHM9qpLuJ0qekNsxTbNQ5mvWBytNNVpu9u73vldDrCfQYp/y2
   DucShAs9omB5yADO3cWgpa6h69TGc4G8sV9H/cuabSYV14GbrejSORYYU
   g0CG5crf4D+t3j8cQl8RsS0ZdsCyQrohKpbZztBlIxelM7OVdwP8qQTu4
   h72f5ZgO11AYhdkePHDS4H+GNGDoyp+9RsE2RPx3rQn97e3lL/TPZRlgi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266828092"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="266828092"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 08:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="514868754"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Apr 2022 08:25:23 -0700
Received: from ketineni-MOBL1.amr.corp.intel.com (unknown [10.255.231.214])
        by linux.intel.com (Postfix) with ESMTP id DB842580279;
        Fri, 29 Apr 2022 08:25:22 -0700 (PDT)
Message-ID: <8bca3baf599ed202e71127ed2fa1b3a120a96010.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel: Fix 'rmmod pmt_telemetry' panic
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        David Arcari <darcari@redhat.com>
Date:   Fri, 29 Apr 2022 08:25:22 -0700
In-Reply-To: <20220429122322.2550003-1-prarit@redhat.com>
References: <20220429122322.2550003-1-prarit@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-29 at 08:23 -0400, Prarit Bhargava wrote:
> 'rmmod pmt_telemetry' panics with:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000040
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 4 PID: 1697 Comm: rmmod Tainted: G S      W        --------  
> ---  5.18.0-rc4 #3
>  Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P DDR5
> RVP, BIOS ADLPFWI1.R00.3056.B00.2201310233 01/31/2022
>  RIP: 0010:device_del+0x1b/0x3d0
>  Code: e8 1a d9 e9 ff e9 58 ff ff ff 48 8b 08 eb dc 0f 1f 44 00 00 41 56 41 55
> 41 54 55 48 8d af 80 00 00 00 53 48 89 fb 48 83 ec 18 <4c> 8b 67 40 48 89 ef
> 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31
>  RSP: 0018:ffffb520415cfd60 EFLAGS: 00010286
>  RAX: 0000000000000070 RBX: 0000000000000000 RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000080 R08: ffffffffffffffff R09: ffffb520415cfd78
>  R10: 0000000000000002 R11: ffffb520415cfd78 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  FS:  00007f7e198e5740(0000) GS:ffff905c9f700000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000040 CR3: 000000010782a005 CR4: 0000000000770ee0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __xa_erase+0x53/0xb0
>   device_unregister+0x13/0x50
>   intel_pmt_dev_destroy+0x34/0x60 [pmt_class]
>   pmt_telem_remove+0x40/0x50 [pmt_telemetry]
>   auxiliary_bus_remove+0x18/0x30
>   device_release_driver_internal+0xc1/0x150
>   driver_detach+0x44/0x90
>   bus_remove_driver+0x74/0xd0
>   auxiliary_driver_unregister+0x12/0x20
>   pmt_telem_exit+0xc/0xe4a [pmt_telemetry]
>   __x64_sys_delete_module+0x13a/0x250
>   ? syscall_trace_enter.isra.19+0x11e/0x1a0
>   do_syscall_64+0x58/0x80
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x67/0x80
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x67/0x80
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x67/0x80
>   ? exc_page_fault+0x64/0x140
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f7e1803a05b
>  Code: 73 01 c3 48 8b 0d 2d 4e 38 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73
> 01 c3 48 8b 0d fd 4d 38 00 f7 d8 64 89 01 48
> 
> The probe function, pmt_telem_probe(), adds an entry for devices even if
> they have not been initialized.  This results in the array of initialized
> devices containing both initialized and uninitialized entries.  This
> causes a panic in the remove function, pmt_telem_remove() which expects
> the array to only contain initialized entries.
> 
> Only use an entry when a device is initialized.
> 
> Cc: "David E. Box" <david.e.box@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: David Arcari <darcari@redhat.com>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  drivers/platform/x86/intel/pmt/telemetry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c
> b/drivers/platform/x86/intel/pmt/telemetry.c
> index 6b6f3e2a617a..f73ecfd4a309 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.c
> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> @@ -103,7 +103,7 @@ static int pmt_telem_probe(struct auxiliary_device
> *auxdev, const struct auxilia
>  	auxiliary_set_drvdata(auxdev, priv);
>  
>  	for (i = 0; i < intel_vsec_dev->num_resources; i++) {
> -		struct intel_pmt_entry *entry = &priv->entry[i];
> +		struct intel_pmt_entry *entry = &priv->entry[priv->num_entries];
>  
>  		ret = intel_pmt_dev_create(entry, &pmt_telem_ns, intel_vsec_dev,
> i);
>  		if (ret < 0)

The unused entries are at the end of the array on Tiger Lake, so we missed
catching this. Thanks for the fix.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>



