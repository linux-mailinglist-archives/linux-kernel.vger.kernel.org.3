Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A385E543AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiFHSBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiFHR7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:59:32 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB315AB11
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:59:30 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0DF752E4BB7;
        Wed,  8 Jun 2022 19:59:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654711167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vyTeB1JzZD9fmF558GD2qgS4Kq5QrIO/iFm0srgpPl0=;
        b=lxAvNswjnRftM23DfjCpgOhPgHLrjEyrvLCPka6PDjTjRusJoRjKIsHCQfRVl2W3NEOWhk
        73bQt63OxjIkg16LwpCk4QKTZCeqhWxQhmeYVcswxxRikc2dwukxvJGBh5llwjPaiDidze
        i5+LpiyVE9uNuUr2ayLww0+HjGnl3UlxuWnsr6rcjFaFD3r66uSSVH0tKqkHctdR863ROp
        u1/HPmp/Rai8AlzS4hBJNZci1BxyHx5HjzxAJnaGO6UuVm6NtjHMvlPNMpnqiUWhvDNExQ
        rA92Im/RgrJ95lYi2PyXe5j2JAcwBgOoBKK0QGPp6fcYIKJCeBDygfOFntkC5w==
Message-ID: <99cf531fb8c7e8155edbad56817c8c0208e793c2.camel@svanheule.net>
Subject: Re: [PATCH v3 1/4] cpumask: Fix invalid uniprocessor mask assumption
From:   Sander Vanheule <sander@svanheule.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Jun 2022 19:59:24 +0200
In-Reply-To: <Yp3ZsoPV0yx2TKo3@smile.fi.intel.com>
References: <cc1f7d3334348cccbf9fde091015a802f379a9be.1654410109.git.sander@svanheule.net>
         <202206060858.wA0FOzRy-lkp@intel.com> <Yp3ZsoPV0yx2TKo3@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 13:40 +0300, Andy Shevchenko wrote:
> On Mon, Jun 06, 2022 at 08:48:05AM +0800, kernel test robot wrote:
> > Hi Sander,
> >=20
> > I love your patch! Yet something to improve:
> >=20
> > [auto build test ERROR on akpm-mm/mm-everything]
> > [also build test ERROR on linus/master v5.18 next-20220603]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >=20
> > url:=C2=A0=C2=A0=C2=A0
> > https://github.com/intel-lab-lkp/linux/commits/Sander-Vanheule/cpumask-=
Fix-invalid-uniprocessor-assumptions/20220606-004959
> > base:=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/akpm/=
mm.git=C2=A0mm-everything
> > config: i386-randconfig-a009
> > (https://download.01.org/0day-ci/archive/20220606/202206060858.wA0FOzRy=
-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
> > reproduce (this is a W=3D1 build):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # https://github.com/intel-l=
ab-lkp/linux/commit/37b3f10c4604ea299b454f39ac5ba3cad903ae16
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git remote add linux-review =
https://github.com/intel-lab-lkp/linux
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git fetch --no-tags linux-re=
view Sander-Vanheule/cpumask-Fix-invalid-uniprocessor-
> > assumptions/20220606-004959
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git checkout 37b3f10c4604ea2=
99b454f39ac5ba3cad903ae16
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # save the config file
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir build_dir && cp config=
 build_dir/.config
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 make W=3D1 O=3Dbuild_dir ARC=
H=3Di386 SHELL=3D/bin/bash
> >=20
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> > =C2=A0=C2=A0 ld: arch/x86/kernel/cpu/cacheinfo.o: in function `__cache_=
amd_cpumap_setup':
> > =C2=A0=C2=A0 arch/x86/kernel/cpu/cacheinfo.c:890: undefined reference t=
o `cpu_llc_shared_map'
> > > > ld: arch/x86/kernel/cpu/cacheinfo.c:895: undefined reference to `cp=
u_llc_shared_map'
>=20
> Seems like somewhere we need stubs for UP builds for those cache related =
functions.
>=20

I think I finally figured out what's going on here.

cpu_llc_shared_map is always declared with DECLARE_PER_CPU_READ_MOSTLY, but=
 defined in
arch/x86/kernel/smpboot.c which only builds on CONFIG_SMP=3Dy.

cpu_llc_shared_map is accessed in a for_each_cpu loop:
for_each_cpu(i, cpu_llc_shared_mask(cpu))

The old (wrong) UP implementation would ignore the mask, so cpu_llc_shared_=
map access was optimised
out and the linker would never see that symbol.

Adding a stub for the two inline functions in arch/x86/include/smp.h won't =
be sufficient I'm afraid.
But I think we can safely make the following assumptions (nobody complained=
 before):
 * anything using cpumask_first_zero(), cpumask_next_zero(), and for_each_c=
pu_not() was expecting an
   empty mask on UP builds,
 * anything else would have expected a filled mask on UP builds.

I'll think about how to identify all the possible cases, but may not be abl=
e to spend a lot of time
on this in the two coming weeks. Any suggestions, or alternative solutions,=
 are of course welcome.

Best,
Sander
