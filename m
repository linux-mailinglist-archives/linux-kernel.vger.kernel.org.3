Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA9C581169
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiGZKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGZKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:47:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B271D20F62;
        Tue, 26 Jul 2022 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658832440; x=1690368440;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZyuJfo1tH/pCiSj2o7MaBubPz2oOmRhAnvP+Jqwl3g0=;
  b=eOt7AC16YMH22SFiRRKYi/eM1fW8rHwpymrxFYBCxrBJ3DYYDNR88c7R
   YOae+gZK0vGoKEDEZw8reiXe4u/hs8FmAtZRUheYG+0VmsKLgCsO5TS8D
   GndhnPGx0n7afa9xgMBho6AFEfj7CpK+yAnVtsm7+5YgJXtS97ydp9GoJ
   oH2c27p+SkRyCFep8ocL3Iuy0FcBcrUla3a5Szc5+raKcBiTPHyIOK8t4
   LetfXXgnwQkCyKA8jtGxLdSEizuxMsTbFkQ/uexWcWayVHAQyMr+cW8vI
   Bq3qcSIjS+KBheqHy9PWYFi3tR+njZd0bAMmp9KCdib8xpr3QRdb1+A6q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="268311999"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="268311999"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 03:47:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="726495838"
Received: from rgevard-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.32.51])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 03:47:17 -0700
Message-ID: <4c614defad8e9ce2bccce8a062600212e4978113.camel@intel.com>
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
Date:   Tue, 26 Jul 2022 22:47:14 +1200
In-Reply-To: <op.1pwcs8btwjvjmi@hhuan26-mobl1.mshome.net>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
         <ab467244dd03b5f94bafe9068b1c02790033c18c.camel@intel.com>
         <a82e840f-2030-7ab3-7160-f1b900ecdb7d@intel.com>
         <06a9fef8579e880b9b031f03911739d4d902dbe0.camel@intel.com>
         <op.1pwcs8btwjvjmi@hhuan26-mobl1.mshome.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-26 at 00:10 -0500, Haitao Huang wrote:
> On Mon, 25 Jul 2022 05:36:17 -0500, Kai Huang <kai.huang@intel.com> wrote=
:
>=20
> > On Fri, 2022-07-22 at 08:21 -0700, Dave Hansen wrote:
> > > On 7/22/22 06:26, Kai Huang wrote:
> > > > Did a quick look at the spec.  It appears ENCLU[EDECCSSA] should be=
 =20
> > > used
> > > > together with AEX-notify.  So besides advertising the new
> > > > SGX_ATTR_ASYNC_EXIT_NOTIFY bit to the KVM guest, I think we should =
=20
> > > also
> > > > advertise the ENCLU[EDECCSSA] support in guest's CPUID, like below =
=20
> > > (untested)?
> > >=20
> > > Sounds like a great follow-on patch!  It doesn't seem truly functiona=
lly
> > > required from the spec:
> > >=20
> > > > EDECCSSA is a new Intel SGX user leaf function
> > > > (ENCLU[EDECCSSA]) that can facilitate AEX notification handling...
> > >=20
> > > If that's wrong or imprecise, I'd love to hear more about it and also
> > > about how the spec will be updated.
> > >=20
> >=20
> > They are enumerated separately, but looks in practice the notify handle=
r =20
> > will
> > use it to switch back to the correct/targeted CSSA to continue to run =
=20
> > normally
> > after handling the exit notify.  This is my understanding of the =20
> > "facilitate"
> > mean in the spec.
> >=20
> > Btw, in real hardware I think the two should come together, meaning no =
=20
> > real
> > hardware will only support one.
> >=20
> > Haitao, could you give us more information?
> >=20
> You are right. They are enumerated separately and HW should come with bot=
h =20
> or neither.
> My understanding it is also possible for enclaves choose not to receive =
=20
> AEX notify
> but still use EDECCSSA.
>=20

What is the use case of using EDECCSSA w/o using AEX notify? =C2=A0

If I understand correctly EDECCSSA effectively switches to another thread (=
using
the previous SSA, which is the context of another TCS thread if I understan=
d
correctly).  Won't this cause problem?

It probably makes sense to use only AEX notify w/o using EDECCSSA though, b=
ut
this should be the case that the enclave detects serious attack and don't w=
ant
to continue to run normally.  In another words, it is enclave's choice, but
hardware should always support both AEX notify and EDECCSSA.

--=20
Thanks,
-Kai


