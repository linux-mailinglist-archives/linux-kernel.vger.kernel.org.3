Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3744049F574
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbiA1IlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:41:23 -0500
Received: from relay036.a.hostedemail.com ([64.99.140.36]:62202 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231660AbiA1IlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:41:22 -0500
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 3A86E12033B;
        Fri, 28 Jan 2022 08:41:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id AF44C80014;
        Fri, 28 Jan 2022 08:40:52 +0000 (UTC)
Message-ID: <7bff2de309384b7c9ee71ad90881d1e0bbe0a781.camel@perches.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Fri, 28 Jan 2022 00:41:10 -0800
In-Reply-To: <c801989d-5f3e-84d2-24a0-7022be70da98@redhat.com>
References: <20220127151945.1244439-1-trix@redhat.com>
         <953eb015-4b78-f7b-5dc1-6491c6bf27e@linux-m68k.org>
         <CAKwvOdnWHVV+3s8SO=Q8FfZ7hVekRVDL5q+7CwAk_z44xaex8w@mail.gmail.com>
         <fb308f51-f16b-3d9b-80c2-180940236b00@redhat.com>
         <5554a75f65fddab4de60d61fd503fe73773dafbb.camel@perches.com>
         <c801989d-5f3e-84d2-24a0-7022be70da98@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.90
X-Stat-Signature: ee1qasspf45yao75rasduwrdbsym8kor
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: AF44C80014
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/s1CB6P0Qi+bndabNk32vMkM+MW6PtAhg=
X-HE-Tag: 1643359252-762821
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 21:31 -0800, Tom Rix wrote:
> On 1/27/22 6:43 PM, Joe Perches wrote:
> > On Thu, 2022-01-27 at 16:32 -0800, Tom Rix wrote:
> > > On 1/27/22 2:47 PM, Nick Desaulniers wrote:
> > > > + Miguel (the clang-format maintainer), Joe (checkpatch maintainer)
> > > > These criticisms are worth reviewing.
> > > > 
> > > > On Thu, Jan 27, 2022 at 2:38 PM Finn Thain <fthain@linux-m68k.org> wrote:
> > > > > On Thu, 27 Jan 2022, trix@redhat.com wrote:
> > > > > 
> > > > > > From: Tom Rix <trix@redhat.com>
> > > > > > 
> > > > > > checkpatch reports several hundred formatting errors. Run these files
> > > > > > through clang-format and knock off some of them.
> > > > > > 
> > > > > That method seems like a good recipe for endless churn unless checkpatch
> > > > > and clang-format really agree about these style rules.
> > > > > 
> > > > > Why use checkpatch to assess code style, if we could simply diff the
> > > > > existing source with the output from clang-format... but it seems that
> > > > > clang-format harms readability, makes indentation errors and uses
> > > > > inconsistent style rules. Some examples:
> > > Problems with clang-format should be fixed, I'll take a look.
> > > 
> > > I was reviewing this file for another isseue and could not get past how
> > > horredously bad it was and really did not want to manually fix the 400+
> > > formatting errors.  I will drop this patch and use the use these files
> > > to verify the .clang-format .
> > I think this is more an issue with clang-format than with checkpatch.
> > 
> > If you have specific issues with what checkpatch reports for this
> > file (or any other file), let me know.
> 
> Yes, I agree. Its a clang-format problem.
> 
> I will be looking to minimize the .clang-format settings to only those 
> that agree with checkpatch.
> 
> Then add settings back in later if their problems can be worked out.

Another option would be to use:

	./scripts/checkpatch.pl -f --fix[-inplace] [--types=<list>] <files>

where types is an optional list of specific things to change

see:
	./scripts/checkpatch.pl --list-types --verbose

to show the possible types.

Only some of these types can be changed with --fix or --fix-inplace

If using checkpatch to change formatting, it sometimes can be useful
to run checkpatch --fix multiple times on the same file as a
checkpatch --fix can create a change than checkpatch will suggest
should itself be fixed.

Of course another option is to do nothing as many will complain,
sometimes senselessly, about 'churn'.



