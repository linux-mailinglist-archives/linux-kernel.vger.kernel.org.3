Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B94DB4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbiCPPfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbiCPPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:35:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAA028E3C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647444853; x=1678980853;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=boYCnh6qWuwCAj1Sjfgi0rW0Z9re8P6EPX8iN50WXOw=;
  b=ihESAcpMJIFO5STBtHDfzvXBuOo1mwgMSmJv6/BbUJzTpVi7YsRR5duV
   HpAuACApYDYRc31sLYDRP9fgGUrh4XUwcAM7b/n7a+ie8Kg/OY/bDibFa
   q/H7wo0/a0mfidXqGLUyMI7ss9kQyw3BjwRx5PYCKP/zybv5wdLkHnqXs
   pbv4Y9rXOvNUmDHtBGzdv448PfsOTNF9RebtivVXEZF6CDycmoZnhFwrV
   OIILpSczrAJzvPiUYCKlC8mGRyUeZlZbR5BHjFpBzqZocWA9TlvyCaAmF
   KTKy+6heFcvnWfDi2KZI96sCWJdFcVYj0lttA0ziRk4wNBznwpTrAU4wE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256822706"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256822706"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:34:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="557502057"
Received: from jdwaldem-mobl.amr.corp.intel.com (HELO [10.255.228.230]) ([10.255.228.230])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:34:12 -0700
Message-ID: <aa3ffe77-8066-adab-80f0-27568ad8f2f6@intel.com>
Date:   Wed, 16 Mar 2022 08:34:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: system locks up with CONFIG_SLS=Y; 5.17.0-rc
In-Reply-To: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 02:51, Jamie Heilman wrote:
> I've been (somewhat unsuccessfully) trying to bisect a hard lock-up
> of my workstation that occurs when I'm running 5.17 rc kernels a few
> seconds after I start a kvm guest instance.  There is no output to
> any log, everything locks up completely, sysrq doesn't even work
> anymore.  As bisection progressed closer and closer to the branch
> where straight-line-speculation mitigation was enabled, and as bisect
> landing me between 9cdbeec40968 ("x86/entry_32: Fix segment exceptions")
> and 3411506550b1 ("x86/csum: Rewrite/optimize csum_partial()") wasn't
> resulting in clear results (my system definately starts Oopsing and
> gets so hosed up that I'm forced to reboot, but it isn't quite as dire
> as sysrq continues to function) I decided to just try a build with
> CONFIG_SLS disabled, and it turns out that works just fine.  Sooo...
> 
> This system uses a Intel Core2 Duo E8400 processor.
> working config (CONFIG_SLS=N) and dmesg at:
> http://audible.transient.net/~jamie/k/sls.config-5.17.0-rc8
> http://audible.transient.net/~jamie/k/sls.dmesg
> 
> (I don't think the dmesg of CONFIG_SLS=Y is really any different.)

If you get really ambitious, you could try to see if any of the
individual things that change based on the CONFIG_SLS #ifdef trigger
this.  Basically, turn off the config option and then go manually
enabling each of the sites.

The odd thing is that it isn't touching anything really KVM-specific.
It probably influences some KVM-specific assembly, but it's hard to see
how that might break anything.

The worrying part is:

ifdef CONFIG_SLS
  KBUILD_CFLAGS += -mharden-sls=all
endif

That's presumably a shiny, new compiler option, also known as a
relatively lightly tested compiler option.
