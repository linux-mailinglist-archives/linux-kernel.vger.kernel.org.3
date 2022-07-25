Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F7557FE07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiGYLFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiGYLFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:05:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6B01208C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658747150; x=1690283150;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ixXvROZDu+Emrv/qHHT+UatmUz6QD6tkz4g3J0IDh4w=;
  b=V1C1msUDBDza5OLEhnWKxHEk0ZnlrmJkF6rELSvFzFztUb3f+r4NcWCr
   kRv8HmpSiEI/O1iYJb3arPQMJJQ/f+VbON6jVstaieriTyPNZgmuigEb4
   OLGxQS1wAGfo9j0U8WbZqOhlMu6RV1D1sTSoXmItfXpmRa4xl2pbKyCXs
   7N6BbgtIbq1fq4DcoFkPAdWw2ev1NBR1j3T7/y81ew52Ee9uaPQBQjtlA
   2sbVaByH0i/Zo3HcYCBexNqT+IDSqRBm7N6mIwJjDMdR/0Z70B2a34SvY
   PGE9XvfP0MEuL9uQQ/yV8M1CMXwMWP+Ca6DOwePunHMt6+Bj4CGo8PXFC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="268064251"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="268064251"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 04:05:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="667450151"
Received: from edere-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.168.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 04:05:46 -0700
Message-ID: <5905d2772ba3ba015f386787fa0b7a8fade69005.camel@intel.com>
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Jul 2022 23:05:44 +1200
In-Reply-To: <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
         <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
         <20220722190524.GA3299911@ls.amr.corp.intel.com>
         <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
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

On Fri, 2022-07-22 at 12:13 -0700, Dave Hansen wrote:
> On 7/22/22 12:05, Isaku Yamahata wrote:
> > > So, the quote portion of this is basically a bidirectional blob sende=
r.
> > >  It's to send a blob between guest userspace to host userspace.
> > >=20
> > > Do we *REALLY* need specific driver functionality for this?  For
> > > instance, is there no existing virtio device that can send blobs back
> > > and forth?
> > It's virtio-vsock.  If virtio-vsock is available, the communication wor=
ks.
> > However, some users would like to disable virtio-vsock on their environ=
ment for
> > some reasons.  Even virtio at all.  Especially for confidential computi=
ng use
> > case.  It's their choice.  It can't be assumed that virtio is available=
.
> >=20
> > The goal is VMM-agnostic (but TDX-specific) interface for that.
>=20
> You're basically saying that every confidential computing technology
> should have its own host user <-> guest kernel <-> guest user ABI.
> That's insanity.  If we do this, we need *one* interface that says "talk
> to the hypervisor" that's common for all hypervisors and hardware
> vendors, or at least more than *one*.
>=20
> We don't need a way to talk to hypervisors for Intel systems and another
> for AMD and yet another on whatever.

Maybe the GetQuote support can be a "Intel driver" with a dedicated Kconfig
option?  Not all customers want it anyway, so having a Kconfig option can a=
lso
reduce code size/attack window.

--=20
Thanks,
-Kai


