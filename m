Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847FB517A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiEBXGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiEBXGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:06:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7522E08C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651532552; x=1683068552;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j303USipVxSvMHFwHqXEX3lsXm1sVh5NnGsTiMU8U6Y=;
  b=LYWV7UD1LzkHC/Y2pmxtfOskMxpvwS2spfvOu00wH7QEeC0vS0eHVYIy
   J5d+I3Xu1s/tTPg1Nd9cyJiScdezTucB0jRcPtuOcuxZ7A/UXB0N/mGf1
   sd3BHgC1y+5e4GF1V7DIbGPFivp3JNm+JaoTaFMRPVKeRHICo5f9tnClf
   v4A41gOTgfmGDKjTm2EJC3HnvJoMrUYazQ8BU2lHZQrtqP2SkK9vqmCf+
   lzdyzSiodp1ERBQKFKcSHVEKnE2723NbyC3WKTcXBIwtWpkQq2lKM+pLl
   k9R/ti4xsrnPySBuu7eNV5Tgm5P+LHxVozJTWOVc4BOxPpyvZru1yxt8M
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353789501"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="353789501"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 16:02:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="707807330"
Received: from chgan-mobl1.gar.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.60.238])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 16:02:28 -0700
Message-ID: <232da85c6d77c6875919abc486e0b25eac025bd6.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 May 2022 11:02:26 +1200
In-Reply-To: <aae6c58c-a89f-e24c-946b-c16b2415c77e@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <7daf429ffda2bf834c129899426e204fbbcbd0b0.camel@intel.com>
         <aae6c58c-a89f-e24c-946b-c16b2415c77e@linux.intel.com>
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

> 
> > 
> > Also, the  buffer may be still used by VMM when timeout (IN_FLIGHT), how can
> > this even work?
> 
> We will never reach here for IN_FLIGHT case. We will block in
> wait_for_completion_interruptible() till the status changes to success
> or failure.

But you still have 'timeout' in userspace ABI?

> 
> > 
> > > +	tdquote = NULL;
> > > +	mutex_unlock(&quote_lock);
> > > +	return ret;
> > > +}
> > > +
> > > +static void attestation_callback_handler(void)
> > > +{
> > > +	struct tdx_quote_hdr *quote_hdr;
> > > +
> > > +	quote_hdr = (struct tdx_quote_hdr *) tdquote;
> > > +
> > > +	/* Check for spurious callback IRQ case */
> > > +	if (!tdquote || quote_hdr->status == GET_QUOTE_IN_FLIGHT)
> > > +		return;
> > 
> > I don't get the logic.  Please explain.
> 
> I am trying to handle spurious IRQ case here. If we receive a callback
> IRQ from VMM before even we allocate tdquote or post the GetQuote
> request, accessing quote_hdr->status will lead to NULL pointer
> exception. So I have added check for valid quote buffer (tdquote !=
> NULL)

tdquote here isn't protected mutex, so even after you check tdquote != NULL, you
cannot guarantee it is still valid when you check quote_hdr. 

For instance, you receive two interrupts in very short time.  The first
interrupt gets you out from wait_for_completion_interruptible().  Then second
interrupt comes, and you can potentially have situation like below:

	cpu 0					cpu 1

	tdx_get_quote				attestation_callback_hander
						
						!tdquote
		...
		tdquote = NULL;

						quote_hdr->status == ...


And the 'quote_hdr' is even initialized at the beginning, and when it is used,
the actual tdquote may already been freed.

Or did I get it wrong?

> 
> Second condition (quote_hdr->status == GET_QUOTE_IN_FLIGHT)) makes
> sure we don't mark the current quote request complete until the
> Quote buffer status changes to GET_QUOTE_SUCCESS, GET_QUOTE_ERROR or
> GET_QUOTE_SERVICE_UNAVAILABLE.

I thought the GHCI spec says VMM will always inject intererupt after the Quote
is ready, so we can have assumption it won't inject when buffer is still
IN_FLIGHT.  But I am also not so sure.


Anyway, to me it seems there's ambiguities around GetQuote and
SetupEventNotifyInterrupt.  This is the reason that I suggested  you to split
the basic driver out and you can even upstream it first w/o GetQuote support.  I
think you may want to actually start to consider to upstream the basic driver
first.


-- 
Thanks,
-Kai


