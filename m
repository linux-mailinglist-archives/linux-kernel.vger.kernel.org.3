Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1B5913C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiHLQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHLQNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:13:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BE3A61EA;
        Fri, 12 Aug 2022 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660320827; x=1691856827;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yN56zwJK9FOJm6+kFY/WbOXx0AB78Epjxoy1F14ttr4=;
  b=agPNTz2QD7XeDchxQrBYX4LcPoIFX4hAMOrf2AtsPfOkJiwG2GqIiByB
   ixuqNKiagZG6fAKrm3QBjocNK8alkmdQUXh5fjVpsrWOUuH2jqbe79R7x
   tcc+3FUtfH9+5LY+NA5oqtxjBEhGG3rQf57h3/A6S3QZODtaG7Q4rtO9q
   vlKI1FPYPNHUxoFXQqiZ9hbHyxydftjCSN8N2CDj4GXTiDEUWWP2YMqK/
   jF6FPFnJhH3Po3kV3cH7JGMUy+X7eH7fgo/9XoeIh6loOVv641pmSTk9C
   xTcN5iZNcY36RxkxRmbBudS+nhMjv1OMw3jCGaovhiKOnQMtuJx56pSB7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355629712"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355629712"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:13:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="634690663"
Received: from kokhaulo-mobl.gar.corp.intel.com ([10.213.45.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:13:36 -0700
Message-ID: <0b10c4ddd940ebba67ef0a2a980a2dade7d6a89a.camel@intel.com>
Subject: Re: [PATCH 0/7] x86/topology: Improve CPUID.1F handling
From:   Zhang Rui <rui.zhang@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>, x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Len Brown <len.brown@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Date:   Sat, 13 Aug 2022 00:13:28 +0800
In-Reply-To: <57686aa5-b0bb-cd49-370c-ad1b376c48fd@roeck-us.net>
References: <41fc865a1e207ea03e15067c06856a92c58e18f6.camel@intel.com>
         <57686aa5-b0bb-cd49-370c-ad1b376c48fd@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-12 at 09:09 -0700, Guenter Roeck wrote:
> On 8/12/22 08:08, Zhang Rui wrote:
> > On Intel AlderLake-N platforms where there are Ecores only, the
> > Ecore
> > Module topology is enumerated via CPUID.1F Module level, which has
> > not
> > been supported by Linux kernel yet.
> >=20
> > This exposes two issues in current CPUID.1F handling code.
> > 1. Linux interprets the Module id bits as package id and
> > erroneously
> > reports a multi module system as a multi-package system.
> > 2. Linux excludes the unknown Module id bits from the core_id, and
> > results in duplicate core_id=E2=80=99s shown in a package after the fir=
st
> > issue
> > solved.
> >=20
> > Plus that, a third problem is observed on Intel Hybrid ADL-S/P
> > platforms. The return value of CPUID.1F SMT level EBX (number of
> > siblings) differs on Pcore CPUs and Ecore CPUs, and results in
> > inconsistent smp_num_siblings value based on the Pcore/Ecore CPU
> > enumeration order.
> >=20
> > Patch 1/7 and 2/7 fix the first two issues. And at the same time,
> > it
> > reveals a reality that the core_id could be sparse on platforms
> > with
> > CPUID.1F support.
> > Patch 3/7 improves coretemp driver code to be able to handle sparse
> > and
> > large core id, which is the only driver that uses core_id as array
> > index and run on platforms with CPUID.1F support.
> >=20
>=20
> So far I only got this e-mail (and I don't find any of the other
> patches
> elsewhere either), and it looks like the hwmon mailing list was not
> copied
> on any of the patches. Please copy the hwmon mailing list for all
> changes
> in hwmon code.

Hi, Guenter,

Thanks for the quick response.
Yeah, I'm checking this, it seems that all my patches sent with git
send-email is blocked, let me retry.

thanks,
rui
>=20
> Thanks,
> Guenter

