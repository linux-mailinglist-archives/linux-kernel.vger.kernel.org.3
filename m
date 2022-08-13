Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF8591C1A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiHMRLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiHMRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:11:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103102637;
        Sat, 13 Aug 2022 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660410664; x=1691946664;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UB/HG76gAn+zrQXdjvwtxR+sGlTnn9ErzdyW2t0elws=;
  b=UKlKf/W0Gnnc5WxOOqjv30MvDMxck1Y91nks5ypYJj/pw5oYcCTFbwQl
   ErYfeaYpUUdxDafEg/dRAoYj1d8/rpJ/qQ8A6/oZkUfsEFjb98ZoNGMr7
   CLjqITaZByDXbYfhdDPayMfhA1yKDKYQgJE/o0La8gn+D27wX0ixVttN4
   HjNd1okucM8F51nlvHSak7LBAktKIDmslycjFyiYSKcbSqeTMquuDpvSy
   T2crTkMDJELI6Z/kddm75NeQsWq9R7PZQbugXCN2ccOcROp6vefObW7KD
   5gag0zQvU4D4SqTgzHQy0M7hnn83sAiP5Ddr5FJexxeJ4sAlLrV7OBVNx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291765171"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="291765171"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:11:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="851865651"
Received: from zhenghwe-mobl.gar.corp.intel.com ([10.214.145.151])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:10:58 -0700
Message-ID: <9a1063a26351f859376ffae747fa0c89d73bdbc4.camel@intel.com>
Subject: Re: [PATCH 0/7] x86/topology: Improve CPUID.1F handling
From:   Zhang Rui <rui.zhang@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Date:   Sun, 14 Aug 2022 01:10:51 +0800
In-Reply-To: <YveAp8W3zZliQXrq@gmail.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
         <YveAp8W3zZliQXrq@gmail.com>
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

Thanks for reviewing this patch series.

On Sat, 2022-08-13 at 12:44 +0200, Ingo Molnar wrote:
>=20
> * Zhang Rui <rui.zhang@intel.com> wrote:
>=20
> > On Intel AlderLake-N platforms where there are Ecores only, the
> > Ecore
> > Module topology is enumerated via CPUID.1F Module level, which has
> > not
> > been supported by Linux kernel yet.
> >=20
> > This exposes two issues in current CPUID.1F handling code.
> > 1. Linux interprets the Module id bits as package id and
> > erroneously
> > =C2=A0=C2=A0 reports a multi module system as a multi-package system.
> > 2. Linux excludes the unknown Module id bits from the core_id, and
> > results
> > =C2=A0=C2=A0 in duplicate core_id=E2=80=99s shown in a package after th=
e first issue
> > solved.
> >=20
> > Plus that, a third problem is observed on Intel Hybrid ADL-S/P
> > platforms.
> > The return value of CPUID.1F SMT level EBX (number of siblings)
> > differs on
> > Pcore CPUs and Ecore CPUs, and results in inconsistent
> > smp_num_siblings
> > value based on the Pcore/Ecore CPU enumeration order. This could
> > bring
> > some potential issues although we have not observed any
> > functionalities
> > issues so far.
> >=20
> > Patch 1/7 and 2/7 fix the first two issues. And at the same time,
> > it
> > reveals a reality that the core_id could be sparse on platforms
> > with
> > CPUID.1F support.
> > Patch 3/7 improves coretemp driver code to be able to handle sparse
> > core
> > id, which is the only driver that uses core_id as array index and
> > run on
> > platforms with CPUID.1F support.
> >=20
> > Patch 4/7 to 7/7 propose a fix for the third problem and update the
> > related Documents.
>=20
> Yeah, so patch 3/7 probably needs to come first - otherwise there's a
> window for bisection breakage.

Sure, I will re-arrange this.


thanks,
rui
