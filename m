Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF45488449
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 16:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiAHPpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 10:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiAHPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 10:45:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A88C06173F;
        Sat,  8 Jan 2022 07:45:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 958E7B80259;
        Sat,  8 Jan 2022 15:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C7EC36AE3;
        Sat,  8 Jan 2022 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641656750;
        bh=1paZYEVtT19xm+lguuMbu/mMdfS7w78Iwwv0Yl0bEuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfUY+h4C3UJDL/3LWw4zULjQAG3wiCsloaYoFIt6fGWTir1xvlQh9dB2bU6OIYrIQ
         q607/tIYKhTihj01oyOyi9OzrkpxYyZbkoDaftIjKQ+m6OxK8VV+DFtB/QiL/7nQ3r
         KVR0PuytGckBbm+DaR6/PS3AYRBk0lnacgTqkxHU9lsNmyfaecTZRsUPtxtx3OSgoJ
         O3AXdX7nKvAuNwX1WbbZwKvQo4qXTgHDUWk9fS5NfGFoteBcsMfYB4SRTtEfSItVyO
         +p8V0CcYpSxDULVcRR2OHaJbcEFHsa6EMSfHJ1LJKjcvMsrwmJyKgPgQg/k80J0gox
         jbeka9ig/poDw==
Date:   Sat, 8 Jan 2022 17:45:41 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <YdmxpTVM1JG8nxQ3@iki.fi>
References: <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
 <YawAWmodeNaUbzV8@iki.fi>
 <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
 <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
 <f6a55943-13ef-41ef-609a-6406cffef513@intel.com>
 <YcsklLw1uFyppSji@iki.fi>
 <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com>
 <YdgvFTIRboHwTgRT@iki.fi>
 <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
> > > > OK, so the question is: do we need both or would a mechanism just
> > > to extend
> > > > permissions be sufficient?
> > > 
> > > I do believe that we need both in order to support pages having only
> > > the permissions required to support their intended use during the
> > > time the
> > > particular access is required. While technically it is possible to grant
> > > pages all permissions they may need during their lifetime it is safer to
> > > remove permissions when no longer required.
> > 
> > So if we imagine a run-time: how EMODPR would be useful, and how using it
> > would make things safer?
> > 
> In scenarios of JIT compilers, once code is generated into RW pages,
> modifying both PTE and EPCM permissions to RX would be a good defensive
> measure. In that case, EMODPR is useful.

What is the exact threat we are talking about?

/Jarkko
