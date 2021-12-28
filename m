Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E665C480A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhL1O5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:57:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40568 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhL1O5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:57:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F416122F;
        Tue, 28 Dec 2021 14:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDFFC36AE7;
        Tue, 28 Dec 2021 14:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640703421;
        bh=nMUfTt6GNtf97yL27tK96zd4QoSQd+3VZBBUwks/lnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xm5fBEUc12qoAlXBA9KPIRPUk1q0YoaHqPCBMEcTWS4Em7OT+7ISxVN09ne8xreei
         gEuXIE1lofDIwynm2uyUR+hyMVz+37Scqse24MNSMY2QzLvJLOOeuBuCC/VIdLb1RC
         2qFgpu//T52Siaprfp0vtZcRq1gBAN4sb1AKszAsz+kz5xwO4DWon7bAFw+oyAH313
         qJIxRMVXf9oP8Iu4KAABalLF3ngjrDB+9BIHFc5GwZrR1DcNrnQ3Ugx64aEqvRwNO7
         tVQ0KavCFTHnNt3heyS3I8Pb5v45jeMf7TO3ERs/hId1sBxZI9PbCdtGbX1zR1zoUg
         0hJdCVF0rTBOw==
Date:   Tue, 28 Dec 2021 16:57:03 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/25] x86/sgx: Support adding of pages to initialized
 enclave
Message-ID: <Ycslvzx4He2Ophqa@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
 <Yav1/ZRX68cECD7a@iki.fi>
 <cc6ecffd-7d4b-0b15-eaf1-6f585e8b31be@intel.com>
 <ce00226feaa02dbc0f66f3f8aa7a243f61e410aa.camel@kernel.org>
 <e934673b-8410-d3fe-f231-fef672050e2b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e934673b-8410-d3fe-f231-fef672050e2b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:12:57PM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 12/11/2021 12:00 AM, Jarkko Sakkinen wrote:
> > On Mon, 2021-12-06 at 13:44 -0800, Reinette Chatre wrote:
> > > On 12/4/2021 3:13 PM, Jarkko Sakkinen wrote:
> > > > On Wed, Dec 01, 2021 at 11:23:11AM -0800, Reinette Chatre wrote:
> 
> ...
> 
> > > > > Accessing an uninitialized address from outside the enclave also triggers
> > > > > this flow but the page will remain in PENDING state until accepted from
> > > > > within the enclave.
> > > > 
> > > > What does it mean being in PENDING state, and more imporantly, what is
> > > > PENDING state? What does a memory access within enclave cause when it
> > > > touch a page within this state?
> > > 
> > > The PENDING state is the enclave page state from the SGX hardware's
> > > perspective. The OS uses the ENCLS[EAUG] SGX2 function to add a new page
> > > to the enclave but from the SGX hardware's perspective it would be in a
> > > PENDING state until the enclave accepts the page. An access to the page
> > > in PENDING state would result in a page fault.
> > > 
> > > 
> > > > I see a lot of text in the commit message but zero mentions about EPCM
> > > > expect this one sudden mention about PENDING field without attaching
> > > > it to anything concrete.
> > > 
> > > My apologies - I will add this to this changelog. This matches your
> > > request to describe the __eaug() wrapper introduced in patch 02/25.
> > > Would you like me to duplicate this information here and in that patch
> > > (a new patch dedicated to the __eaug() wrapper) or would you be ok if I
> > > introduce the wrappers all together briefly as in the example you
> > > provide and then detail the flows where the wrappers are used - like
> > > this patch?
> > 
> > I think it would be a good place to describe these details in 02/25,
> > and skip them in rest of the patches.
> > 
> 
> Will do. I do think describing this amount of detail for the new SGX2
> functions would be too much for a single patch so I currently plan to split
> that (02/25) patch into a new patch per SGX2 instruction. Is that ok with
> you or would you like to keep it in a single patch?

It's ok for me.

/Jarkko
