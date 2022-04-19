Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27400506360
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbiDSEm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346851AbiDSEm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:42:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6513CF1;
        Mon, 18 Apr 2022 21:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650343215; x=1681879215;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSHnPcmQDr2m67I3IEDFZsS8yQFjGEY+tSnrmofTQkc=;
  b=hDEQUwMA1MU6/kkN7WB8CVkogvHV29fznrqxn70Q74/PGji4MStzE3v9
   6+MBLc9KB2lpyRnTc7KjzBDjrwA23ykQYuP5L6tbDeVwn5dlZUkP4aeQ/
   sDZVo+UhFAppak0ML2KmUoMtZVdMl2SELPEtMIecFvARA+iE3r1XNM/dz
   9gsdvHLjOfxbEbB68J8P5n9kIy5JJo0D5fTXUAwygK7oZnOIwX2+aukOr
   vKIZMoDrzlUV3CRvNFK4nPzR1uS8kwcPcoaQvJ0rbt217QUFuijF97IQV
   V7vbKWpTaUrP/d4CxrVtLeGXw6wdKYxfqzHNC81DtIkIJC+foTENDkCeb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262533069"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="262533069"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:40:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="860605759"
Received: from csambran-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.58.20])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:40:11 -0700
Message-ID: <7f6f73aeb37aeb4339059ad9a139a0d24458affc.camel@intel.com>
Subject: Re: [PATCH v3 2/4] x86/tdx: Add tdx_hcall_get_quote() API support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Tue, 19 Apr 2022 16:40:09 +1200
In-Reply-To: <0a49a4f1-637a-fa92-555f-485b529e6811@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <4ad97e6118688faf35e96ade46690c84f6c729f4.camel@intel.com>
         <0a49a4f1-637a-fa92-555f-485b529e6811@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-18 at 21:04 -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 4/18/22 7:59 PM, Kai Huang wrote:
> > On Fri, 2022-04-15 at 15:01 -0700, Kuppuswamy Sathyanarayanan wrote:
> > > Attestation is the process used by two un-trusted entities to prove to
> > > each other that it can be trusted.
> > > 
> > 
> > I don't think this is accurate.  TDX attestation is used to attest a TD is
> > genuine and runs on genuine Intel platforms to any challenger who wants to
> > verify this.  Theoretically, the TD guest doesn't necessarily need to verify the
> > trustworthiness of the challenger.
> 
> Above is a generic explanation for attestation (not TDX specific).

Even for generic, it seems it's not accurate.  As I said it's not "two un-
trusted entities to prove to each other".

> 
> > 
> > > In TDX guest, attestation is mainly
> > > used to verify the trustworthiness of a TD to the 3rd party key
> > > servers.
> > 
> > And "key servers" is only one potential use case of using the attestation
> > service.  I don't think it's right to say attestation is mainly used for this.
> 
> Agree. I will change it to,
> 
> Attestation is used to verify the trustworthiness of a TD to the other
> 3rd party entities before exchanging sensitive information.

Fine to me.

> 
> > 
> > > 
> > > First step in the attestation process is to generate the TDREPORT data.
> > > This support is added using tdx_mcall_tdreport() API. The second stage
> > > in the attestation process is for the guest to request the VMM generate
> > > and sign a quote based on the TDREPORT acquired earlier.
> > > 
> > 
> > This is not accurate.  The VMM cannot generate and sign the Quote.  Only Quoting
> > enclave (QE) can do that.  The VMM is just a bridge which helps to send the
> > TDREPORT to the QE and then give the Quote back to TD guest when it receives it.
> > 
> > For instance, theoretically GetQuote TDVMCALL isn't absolutely necessarily for
> > attestation.  The TD attestation agent (runs in TD guest userspace) can choose
> > to connect to QE directly if feasible (i.e. via vsock, tcp/ip, ..) and then send
> > the TDREPORT to QE and receive the Quote directly.
> 
> Yes, since guest does not get involved with how VMM facilities the
> Quote Generation, I did not elaborate on Quoting Enclave part.
> 
> How about following change?
> 
> The second stage in the attestation process is for the guest to pass the
> TDREPORT data (generated by TDREPORT TDCALL) to the VMM and
> request it to trigger Quote generation via a Quoting enclave (QE).
> 
> Also note that GetQuote is an asynchronous request. So this API does not
> block till Quote is generated. VMM will notify the TD guest about the
> quote generation completion via interrupt (configured by
> SetupEventNotifyInterrupt hypercall). This support will be added by
> follow on patches in this series.

Fine to me.

Btw, if I recall correctly, it seems we don't need to say "xxx will be done in
later patches", etc.  I can be wrong.  Will leave to others.

[...]


> > > +/*
> > > + * tdx_hcall_get_quote() - Generate TDQUOTE using TDREPORT_STRUCT.
> > > + *
> > > + * @data        : Address of 8KB GPA memory which contains
> > > + *                TDREPORT_STRUCT.
> > > + * @len		: Length of the GPA in bytes.
> > 
> > It seems GetQuote definitions in public GHCI 1.0 and GHCI 1.5 are different.  In
> > GHCI 1.5, R13 is used to specify the shared memory size.
> > 
> > I think it is because the public GHCI 1.0 hasn't been updated yet?
> 
> Please check the latest 1.0 specification (updated on Feb 2022). It has
> details about R13 register.

Thanks.  So it seems GHCI 1.0 has also been updated and it is consistent with
GHCI 1.5 now.  In this case, why do we still assume 8K shared memory?  Are you
going to update the driver?


