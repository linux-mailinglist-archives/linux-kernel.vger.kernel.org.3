Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B67487784
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbiAGMQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:16:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52116 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbiAGMQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:16:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D193D61E29;
        Fri,  7 Jan 2022 12:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2786C36AE0;
        Fri,  7 Jan 2022 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641557786;
        bh=OEzm5MxALJhNyOsku6yeW8tVG6buBywhtCNcnD3+YQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/O0s2vskaTBSjzYQm5b8+ZRXYYMIKuIAle6eknlF7nl0dryrHI05pKeRnttJ3cgD
         3jOFCyhW7Ujlt3qz599IH1LN9jvKA4XPwEYg8XeuG7XHJnVlBz+KDIXoINUAYlsDf3
         eSCZgqnyJhgy0byAdZYXjazOosp6qy+Xq2jNfp19bTDDpw55nlRAhy5sJz0hIoZxsu
         +++oRMOlvtyU26P9VxTmO/iHnJoR/zIm8Dy3snPuETP51PYJFnOaEk06VQCLYU/gUh
         i5m/KbkRAM+SjfypyJ6vdGd8yymDc6r1GIJSXNJgRrdCI5BtRht6Zhp8UgEaiZmS68
         YoFUDg+rO4uRw==
Date:   Fri, 7 Jan 2022 14:16:21 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <YdgvFTIRboHwTgRT@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
 <YawAWmodeNaUbzV8@iki.fi>
 <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
 <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
 <f6a55943-13ef-41ef-609a-6406cffef513@intel.com>
 <YcsklLw1uFyppSji@iki.fi>
 <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 09:46:06AM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 12/28/2021 6:52 AM, Jarkko Sakkinen wrote:
> > On Mon, Dec 13, 2021 at 02:10:17PM -0800, Reinette Chatre wrote:
> >> Hi Jarkko,
> >>
> >> On 12/10/2021 11:42 PM, Jarkko Sakkinen wrote:
> >>> On Mon, 2021-12-06 at 13:20 -0800, Reinette Chatre wrote:
> >>>>> This is a valid question. Since EMODPE exists why not just make things for
> >>>>> EMODPE, and ignore EMODPR altogether?
> >>>>>
> >>>>
> >>>> I believe that we should support the best practice of principle of least
> >>>> privilege - once a page no longer needs a particular permission there
> >>>> should be a way to remove it (the unneeded permission).
> >>>
> >>> What if EMODPR was not used at all, since EMODPE is there anyway?
> >>
> >> EMODPR and EMODPE are not equivalent.
> >>
> >> EMODPE can only be used to "extend"/relax permissions while EMODPR can only
> >> be used to restrict permissions.
> >>
> >> Notice in the EMODPE instruction reference of the SDM:
> >>
> >> (* Update EPCM permissions *)
> >> EPCM(DS:RCX).R := EPCM(DS:RCX).R | SCRATCH_SECINFO.FLAGS.R;
> >> EPCM(DS:RCX).W := EPCM(DS:RCX).W | SCRATCH_SECINFO.FLAGS.W;
> >> EPCM(DS:RCX).X := EPCM(DS:RCX).X | SCRATCH_SECINFO.FLAGS.X;
> >>
> >> So, when using EMODPE it is only possible to add permissions, not remove
> >> permissions.
> >>
> >> If a user wants to remove permissions from an EPCM page it is only possible
> >> when using EMODPR. Notice in its instruction reference found in the SDM how
> >> it in turn can only be used to restrict permissions:
> >>
> >> (* Update EPCM permissions *)
> >> EPCM(DS:RCX).R := EPCM(DS:RCX).R & SCRATCH_SECINFO.FLAGS.R;
> >> EPCM(DS:RCX).W := EPCM(DS:RCX).W & SCRATCH_SECINFO.FLAGS.W;
> >> EPCM(DS:RCX).X := EPCM(DS:RCX).X & SCRATCH_SECINFO.FLAGS.X;
> > 
> > OK, so the question is: do we need both or would a mechanism just to extend
> > permissions be sufficient?
> 
> I do believe that we need both in order to support pages having only
> the permissions required to support their intended use during the time the
> particular access is required. While technically it is possible to grant
> pages all permissions they may need during their lifetime it is safer to
> remove permissions when no longer required.

So if we imagine a run-time: how EMODPR would be useful, and how using it
would make things safer?

/Jarkko
