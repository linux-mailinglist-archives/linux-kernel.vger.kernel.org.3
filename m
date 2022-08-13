Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCE591C27
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbiHMR3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiHMR3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:29:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0C212600;
        Sat, 13 Aug 2022 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660411785; x=1691947785;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6Xw2/z1zsnTRRBBcfa/hlj7wwo+Ed84nrD4IBqhA9Sg=;
  b=XrIVYRzD7Jr30yVrcVReZys0tvPuxWt4MNUzN0S/34g0FuJMyLeURL8s
   pADNhoMZdfgo2zr6ZNk7fhxgGj7oLgvrAfubBG5ZZW0oZ9MRjs6gRdbdx
   PtSQDW5SVLy2cElKgYEta/HMzza9vh9x4P9G/T3cUYGkjsKkk1LwX1wUY
   sNyvz7klVgXPwOAfilVgd+9N/+60G+15NnJeQ+dSfzn63oS8Crx7NQTTA
   ZJgrE8CNoIoHRqaFCoU3LKgJriUDFlZicSh3IYpWec/ECiHkRljYrLoPm
   vPPNxz4YdVf0NBcBMdbXAi5PzZ8gvsH2gp6GSYIj+8chKY2Q1i8NpaUKd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291766198"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="291766198"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:29:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="732530537"
Received: from zhenghwe-mobl.gar.corp.intel.com ([10.214.145.151])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:29:39 -0700
Message-ID: <132858ae66f1cffeb32cc39b788647f52957fd5e.camel@intel.com>
Subject: Re: [PATCH 7/7] perf/x86/intel/P4: Fix smp_num_siblings usage
From:   Zhang Rui <rui.zhang@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Date:   Sun, 14 Aug 2022 01:29:31 +0800
In-Reply-To: <YveCBx/X/YyoccI0@gmail.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
         <20220812164144.30829-8-rui.zhang@intel.com> <YveCBx/X/YyoccI0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ingo,

On Sat, 2022-08-13 at 12:50 +0200, Ingo Molnar wrote:
>=20
> * Zhang Rui <rui.zhang@intel.com> wrote:
>=20
> > smp_num_siblings can be larger than 2.
> >=20
> > Any value larger than 1 suggests HT is supported.
> >=20
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> > =C2=A0arch/x86/include/asm/perf_event_p4.h | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/include/asm/perf_event_p4.h
> > b/arch/x86/include/asm/perf_event_p4.h
> > index 94de1a05aeba..b14e9a20a7c0 100644
> > --- a/arch/x86/include/asm/perf_event_p4.h
> > +++ b/arch/x86/include/asm/perf_event_p4.h
> > @@ -189,7 +189,7 @@ static inline int p4_ht_active(void)
> > =C2=A0static inline int p4_ht_thread(int cpu)
> > =C2=A0{
> > =C2=A0#ifdef CONFIG_SMP
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (smp_num_siblings =3D=3D =
2)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (smp_num_siblings > 1)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return cpu !=3D
> > cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));
>=20
> This fix too should probably come before all the other changes.
>=20
> (Not that Pentium 4 code is expected to ever see such SMT thread
> values.)
>=20
Do you mean that this is a clean fix, and there is no reason for this
patch to be blocked by any of the other patches in this series?

thanks,
rui
