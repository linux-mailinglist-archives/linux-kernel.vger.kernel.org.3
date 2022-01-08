Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7E48847F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiAHQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:22:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42606 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAHQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:22:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4443D60AE3;
        Sat,  8 Jan 2022 16:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F852C36AE3;
        Sat,  8 Jan 2022 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641658958;
        bh=XqzsE+JFOq5fnyB0x4N0Be3JBWPwP+hKNc2NJzcQA2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTyzH7USUptPvgeSSZySTmqwNrRdRsZeRTvvQYXLGVnZVKbWFlbr6txNHiCINs/vS
         KiJC29nx7VBSe1so20I6t8YAXcUKvxtC/VZ2WMRF6GYxwYBrsJBlXc81l+mzrQPqFP
         c0fapbF3V0SVTHhtmvQtt+vE23x0O3m296AZA2uPEDBBi32lUzkqc3rs7cvw/h5XMI
         Mc8jdIqxa470rwvJZdH7/xmj2SQvFTiDjVp+qiQWPidtWMFoyAWIOhe0Y4Hj+YLNxY
         l6LHH7zissQZ/gDHhW+ekwGtwIz9afRbmQeaxSLe09xeBLGF7PBBnRwT9hb8xS81DI
         vxMTHObds9FZg==
Date:   Sat, 8 Jan 2022 18:22:30 +0200
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
Message-ID: <Ydm6RiIwuh3IspRI@iki.fi>
References: <YawAWmodeNaUbzV8@iki.fi>
 <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
 <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
 <f6a55943-13ef-41ef-609a-6406cffef513@intel.com>
 <YcsklLw1uFyppSji@iki.fi>
 <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com>
 <YdgvFTIRboHwTgRT@iki.fi>
 <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net>
 <YdmxpTVM1JG8nxQ3@iki.fi>
 <YdmzDy1BOHgh8CII@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdmzDy1BOHgh8CII@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
> On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
> > > > > > OK, so the question is: do we need both or would a mechanism just
> > > > > to extend
> > > > > > permissions be sufficient?
> > > > > 
> > > > > I do believe that we need both in order to support pages having only
> > > > > the permissions required to support their intended use during the
> > > > > time the
> > > > > particular access is required. While technically it is possible to grant
> > > > > pages all permissions they may need during their lifetime it is safer to
> > > > > remove permissions when no longer required.
> > > > 
> > > > So if we imagine a run-time: how EMODPR would be useful, and how using it
> > > > would make things safer?
> > > > 
> > > In scenarios of JIT compilers, once code is generated into RW pages,
> > > modifying both PTE and EPCM permissions to RX would be a good defensive
> > > measure. In that case, EMODPR is useful.
> > 
> > What is the exact threat we are talking about?
> 
> To add: it should be *significantly* critical thread, given that not
> supporting only EAUG would leave us only one complex call pattern with
> EACCEPT involvement.
> 
> I'd even go to suggest to leave EMODPR out of the patch set, and introduce
> it when there is PoC code for any of the existing run-time that
> demonstrates the demand for it. Right now this way too speculative.
> 
> Supporting EMODPE is IMHO by factors more critical.

At least it does not protected against enclave code because an enclave can
always choose not to EACCEPT any of the EMODPR requests. I'm not only
confused here about the actual threat but also the potential adversary and
target.

/Jarkko
