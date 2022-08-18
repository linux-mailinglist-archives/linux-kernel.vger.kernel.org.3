Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7647E598330
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbiHRM33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244528AbiHRM31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:29:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E7248C472
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:29:27 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id DF7B0210924B; Thu, 18 Aug 2022 05:29:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF7B0210924B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660825765;
        bh=N0KtEpoBu3th64oZcAZTDMjWHKbXWYEYW8YhIfYFUrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M08rrkPuCAid237xUFj2fYP6FZmsUPt/pBxVVKZy24w0fkEd3RFu9jQz3Yl072uoW
         yDTWQqqnwTwRuSvI+MVb6SMxS1KLFZhtd+hP0GfSyM9fJuws5sGfu6vl3itiRvO73S
         Oq7kHwstvTzamswUrWEgr1GuPGpvUo7JtH2l0IeM=
Date:   Thu, 18 Aug 2022 05:29:25 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     ssengar@microsoft.com, mikelley@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, tim.c.chen@linux.intel.com,
        will@kernel.org, song.bao.hua@hisilicon.com,
        suravee.suthikulpanit@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cacheinfo: Don't use cpu_llc_shared_map for
 !CONFIG_SMP
Message-ID: <20220818122925.GA8507@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1660148115-302-1-git-send-email-ssengar@linux.microsoft.com>
 <Yv1ELaWHbRfvdt/p@zn.tnic>
 <20220818045225.GA9054@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Yv4pOz01nAkafiwd@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv4pOz01nAkafiwd@zn.tnic>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 01:57:47PM +0200, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 09:52:25PM -0700, Saurabh Singh Sengar wrote:
> > Shall I mention here "Non-SMP AMD processor" instead ?
> 
> You should explain what that is.
> 
> Is that a CONFIG_SMP=n kernel which you boot on a AMD CPU?

Yes, thats correct.

> 
> IOW, how do I reproduce the issue you're describing below, here locally?

Boot latest linux kernel on AMD CPU, having CONGIG_SMP=n.
Once booted execute lscpu (just lscpu without any argument ), this will cause segfault.
Please make a note issue is observed with 2.34 version (default lscpu version with
Ubuntu 20.04.4) of lscpu.

Also, if for the above test we take linux kernel code before below commit,
shared_cpu_map file gets created and lscpu just works fine.
b81dce77ced ("cpumask: Fix invalid uniprocessor mask assumption")

> 
> Send dmesg pls.
> 

dmesg :
We get only 2 lines of dmesg for this segfault.
Step 1: dmesg -c
Step 2: lscpu
Step 3: dmesg
below is the output of step 3.

Dmesg:
[ 6951.530138] lscpu[99034]: segfault at 0 ip 00005557bc9c35ba sp 00007ffced2681c8 error 4 in lscpu[5557bc9c0000+e000]
[ 6951.530145] Code: 4d 39 c2 76 33 48 c1 e9 06 49 89 c8 4c 8d 2c cd 00 00 00 00 44 89 c9 4f 8b 04 c3 83 e1 3f 4d 0f a3 c8 73 14 4c 8b 02 4d 8b 00 <4f> 8b 04 28 49 d3 e8 41 83 e0 01 44 01 c3 48 89 c1 49 39 c4 74 38

> Also, what is the use case?
> 

Explained above, putting here more precise steps:
Step 1: Build linux kernel for AMD processor supporting L3 cache with CONFIG_SMP=n.
Step 2: Boot this kernel.
Step 3: Once in command prompt, enter lscpu

If lspu is version 2.34 like the one I have (default with Ubuntu 20.04.4),
segfault will be observed.


> Why would you even build with SMP off?

This is caught in our testing.

> 
> Feel free to explain more verbosely what you're trying to accomplish.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Please let me know if any thing is unclear or need more info reproducing the scenario.

- Saurabh
