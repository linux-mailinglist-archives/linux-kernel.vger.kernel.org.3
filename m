Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364D659A585
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349856AbiHSS2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349931AbiHSS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:28:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD703343A;
        Fri, 19 Aug 2022 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660933708; x=1692469708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YDdzNwGuarY0Qqw69S3P1mgYyWI4ffMOknFPoo+F9Ek=;
  b=HrgXQtD3EyNUXQ2xUL2/m8Ht7O3TpEYowAb//YyluRLi4RzDAH23BBEO
   mxRhgg0j4R3jQlWYey5+MVGjET6ZKlvETPzmz5+PxIu5OuW4EFUZoYrJZ
   5hhLdNc1zhTRF/embTLAHLoMVLOoP0v01c53Vr/2ZLWDq7uuC6i9FNTB1
   K1dqfK7ZoMNcUi2S7HQ/BpwKhp+gsduFTB0q31jPL0S75HA1pqX4Nj+ar
   L86EO780el/xdxcGdTzg/nRDSWD1ZruXOy1HGQyMU/z4yvZR7/X38hQqz
   DAdDLl0dfvPzs0GzNH5umZTG+PvhXbGX2twzgZZ/RmcCtXM2mp371Iuk7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="280034867"
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="280034867"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 11:28:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="936313396"
Received: from mupton-mobl.amr.corp.intel.com (HELO [10.209.5.45]) ([10.209.5.45])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 11:28:26 -0700
Message-ID: <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
Date:   Fri, 19 Aug 2022 11:28:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Chatre, Reinette" <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 09:02, Paul Menzel wrote:
> On the Dell XPS 13 9370, Linux 5.18.16 prints the warning below:
> 
> ```
> [    0.000000] Linux version 5.18.0-4-amd64
> (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU
> ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC
> Debian 5.18.16-1 (2022-08-10)
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64
> root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> […]
> [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
> […]
> [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff

Hi Paul,

Would you be able to send the entire dmesg, along with:

	cat /proc/iomem # (as root)
and
	cpuid -1 --raw

I'm suspecting either a BIOS problem.  Reinette (cc'd) also thought this
might be a case of the SGX initialization getting a bit too far along
when it should have been disabled.

We had some bugs where we didn't stop fast enough after spitting out the
"SGX Launch Control is locked..." errors.
