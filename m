Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E8581BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGZVWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZVWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 17:22:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F822E9EE;
        Tue, 26 Jul 2022 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658870528; x=1690406528;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Mf0Cjz40R2rmi8+GawNqJLKlYo6nbTWg+KJFfTbGugQ=;
  b=nKssvZeb4GnjiQTphy/Fo8YEr8Ar9PMNgpzxgeGrh0uGiqHoGtR0fWtL
   uAsIbV5W+HCrT/eKGa9FvWdnTaWsE3tcnDqEP7WGQ43Bt/QxxKsMGB2ck
   vmT55KmPEkouUg8w7wuXz2BpsrqEw1SLEWL9FKHj9/DHjV5eYTrYJ4M9l
   livZBFBZNq0GeivUcvvjYqhxN/9opPQRWWv3FuOrD8tZPOQ9X6SHo8MoN
   hDs8iqP0aeg4bMiNeOP//qGE9NkoPBLGjRb0EzumHH/j9KVndS1nZw/Q/
   Ji6dSFbUUDB+o2PuuO8toCn0tw5hL5xbMtF41+aR1pNvk0hoeq+Vi9uvX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="313835159"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="313835159"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 14:21:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="776451430"
Received: from rgevard-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.32.51])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 14:21:56 -0700
Message-ID: <c99078bf036b5bb175dd4c173790a90b77c6ef72.camel@intel.com>
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
From:   Kai Huang <kai.huang@intel.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Jul 2022 09:21:53 +1200
In-Reply-To: <op.1pw6lhz8wjvjmi@hhuan26-mobl1.mshome.net>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
         <ab467244dd03b5f94bafe9068b1c02790033c18c.camel@intel.com>
         <a82e840f-2030-7ab3-7160-f1b900ecdb7d@intel.com>
         <06a9fef8579e880b9b031f03911739d4d902dbe0.camel@intel.com>
         <op.1pwcs8btwjvjmi@hhuan26-mobl1.mshome.net>
         <4c614defad8e9ce2bccce8a062600212e4978113.camel@intel.com>
         <op.1pw6lhz8wjvjmi@hhuan26-mobl1.mshome.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-26 at 10:28 -0500, Haitao Huang wrote:
> On Tue, 26 Jul 2022 05:47:14 -0500, Kai Huang <kai.huang@intel.com> wrote=
:
>=20
> > On Tue, 2022-07-26 at 00:10 -0500, Haitao Huang wrote:
> > > On Mon, 25 Jul 2022 05:36:17 -0500, Kai Huang <kai.huang@intel.com> =
=20
> > > wrote:
> > >=20
> > > > On Fri, 2022-07-22 at 08:21 -0700, Dave Hansen wrote:
> > > > > On 7/22/22 06:26, Kai Huang wrote:
> > > > > > Did a quick look at the spec.  It appears ENCLU[EDECCSSA] shoul=
d =20
> > > be
> > > > > used
> > > > > > together with AEX-notify.  So besides advertising the new
> > > > > > SGX_ATTR_ASYNC_EXIT_NOTIFY bit to the KVM guest, I think we sho=
uld
> > > > > also
> > > > > > advertise the ENCLU[EDECCSSA] support in guest's CPUID, like be=
low
> > > > > (untested)?
> > > > >=20
> > > > > Sounds like a great follow-on patch!  It doesn't seem truly =20
> > > functionally
> > > > > required from the spec:
> > > > >=20
> > > > > > EDECCSSA is a new Intel SGX user leaf function
> > > > > > (ENCLU[EDECCSSA]) that can facilitate AEX notification handling=
...
> > > > >=20
> > > > > If that's wrong or imprecise, I'd love to hear more about it and =
=20
> > > also
> > > > > about how the spec will be updated.
> > > > >=20
> > > >=20
> > > > They are enumerated separately, but looks in practice the notify =
=20
> > > handler
> > > > will
> > > > use it to switch back to the correct/targeted CSSA to continue to r=
un
> > > > normally
> > > > after handling the exit notify.  This is my understanding of the
> > > > "facilitate"
> > > > mean in the spec.
> > > >=20
> > > > Btw, in real hardware I think the two should come together, meaning=
 no
> > > > real
> > > > hardware will only support one.
> > > >=20
> > > > Haitao, could you give us more information?
> > > >=20
> > > You are right. They are enumerated separately and HW should come with=
 =20
> > > both
> > > or neither.
> > > My understanding it is also possible for enclaves choose not to recei=
ve
> > > AEX notify
> > > but still use EDECCSSA.
> > >=20
> >=20
> > What is the use case of using EDECCSSA w/o using AEX notify? =20
> > If I understand correctly EDECCSSA effectively switches to another =20
> > thread (using
> > the previous SSA, which is the context of another TCS thread if I =20
> > understand
> > correctly).  Won't this cause problem?
>=20
> No. Decrementing CSSA is equivalent to popping stack frames, not switchin=
g =20
> threads.
> In some cases such as so-called "first stage" exception handling, one =
=20
> could pop CSSA back to the previous after resetting CPU context and stack=
 =20
> frame appropriate to the "second stage" or "real" exception handling =20
> routine, then jump to the handler directly. This could improve exception =
=20
> handling performance by saving an EEXIT/ERESUME trip.
>=20
>=20

Looking at the AEX-notify spec again, EDECCSSA does below:

(* At this point, the instruction is guaranteed to complete *)
CR_TCS_PA.CSSA :=3D CR_TCS_PA.CSSA - 1;
CR_GPR_PA :=3D Physical_Address(DS:TMP_GPR);

It doens't reset the RIP to CR_GPA_PA.RIP so looks yes you are right.  It o=
nly
"popping the stack frame" but doesn't switch thread.

But the pseudo code of EDECCSSA only updates the CR_TCS_PA and CR_GPR_PA
registers (forget about XSAVE not), but doesn't manually updating the actua=
l CPU
registers such as GPRs.  Are the actual CPU registers updated automatically=
 when
CR_xx are updated?

--=20
Thanks,
-Kai


