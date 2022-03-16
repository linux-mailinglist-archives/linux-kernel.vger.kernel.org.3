Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7704DB6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbiCPQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348702AbiCPQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:50:22 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0EE38191
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:49:02 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2dbd97f9bfcso29961827b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGKNOPcI723TyAogmId3EJCTD7xrrfL6vBjTUbZDdwc=;
        b=G1Avxqp075V/9Rmuzp4slph4/avGCXKnP8LchL4LUG/V64EgwSFnLab3q6+4YIkxv/
         LQSWzAZSb6/Lqcmld7Ei1qvl59sQ+lT8CGGUqpkO+ckyRhgofGe28NlAXCnHL2tt4aPA
         yiWKgQdxAXZwV5YEs7ayjia/zBXfR+kuuoO1qw7jeTVMduslYyXkS3XjSQ0AotVOk0SD
         ooSt22jJRXxyMMSJmsVJ4B67onUQUU6aT48ldKLhhbH8KeAGYw+P+B0jEBuqPzBOJ249
         KB+N4rI/+W7vfjSRAZ/lvIyfFOjFk9uUF3AXKg5njzylee+rtqyh43p17G8sq840SO2W
         tt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGKNOPcI723TyAogmId3EJCTD7xrrfL6vBjTUbZDdwc=;
        b=h+cLWyt/+Qrm2NNUGOIr/pcsLkekA67VHzy8HaPkGXM0sP0oE/cY4N0Z9/9mjTkox0
         VkK4UJj76WPE6dohl/957Yq43lL3wW04fNH/cBDx3be6EoAAPcWvnpDJT1QJe/UWUWyF
         EQuEeMK+57flNhn9S2YqIBy27V4N7hPtuKSIA95V51hgKjAmT+S9Mox04Gbg7zbO67GE
         XDIyNBnvdTJQuEf5h32q74IAyNDRyCyGpbqv0XcDKuDKfoHEVNBrEpsJpyrsJaa1D7Tc
         M3dgebE/Bht2/PPo8Egux9CQ+mc1yjzziB6bQUqbU6RnKNYhhCGRihJbs14XUQ8fzIph
         lI1Q==
X-Gm-Message-State: AOAM533f5cFB3OKMZ4mVI8IjznHUlJmMkFYnci1BYz9LE+q8xWs6n4Nx
        ZBBiqi63SUmuLAEHmflVAG+gtxgY7aDI3mDZw5o00uFLXaP7sQ==
X-Google-Smtp-Source: ABdhPJyqD+jo4FVl00CMSuG5hHRTuUsEcIvkPgQyLahY+UHwiKfm0bQ9wYg3iLgEtmJMNve1sVrjCB58dzPFMrMfkD8=
X-Received: by 2002:a81:9842:0:b0:2e5:9e00:288 with SMTP id
 p63-20020a819842000000b002e59e000288mr1032295ywg.369.1647449341525; Wed, 16
 Mar 2022 09:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220315073949.7541-1-jiangshanlai@gmail.com> <20220315073949.7541-7-jiangshanlai@gmail.com>
 <YjH9qCkeCXZ4XjLx@hirez.programming.kicks-ass.net>
In-Reply-To: <YjH9qCkeCXZ4XjLx@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 17 Mar 2022 00:48:50 +0800
Message-ID: <CAJhGHyCP8V=tPmBknchgau9DCVGZXdrQZgzG0G=n=G38+qp7-g@mail.gmail.com>
Subject: Re: [PATCH V3 6/7] x86/entry: Don't call error_entry for XENPV
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 15, 2022 at 03:39:48PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > When in XENPV, it is already in the task stack, and it can't fault
> > for native_iret() nor native_load_gs_index() since XENPV uses its own
> > pvops for iret and load_gs_index().  And it doesn't need to switch CR3.
> > So there is no reason to call error_entry() in XENPV.
> >
> > Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > ---
> >  arch/x86/entry/entry_64.S | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index e4a07276fd1c..ec885c2107de 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -328,8 +328,17 @@ SYM_CODE_END(ret_from_fork)
> >       PUSH_AND_CLEAR_REGS
> >       ENCODE_FRAME_POINTER
> >
> > -     call    error_entry
> > -     movq    %rax, %rsp                      /* switch stack settled by sync_regs() */
> > +     /*
> > +      * Call error_entry and switch stack settled by sync_regs().
> > +      *
> > +      * When in XENPV, it is already in the task stack, and it can't fault
> > +      * for native_iret() nor native_load_gs_index() since XENPV uses its
> > +      * own pvops for iret and load_gs_index().  And it doesn't need to
> > +      * switch CR3.  So it can skip invoking error_entry().
> > +      */
> > +     ALTERNATIVE "call error_entry; movq %rax, %rsp", \
> > +             "", X86_FEATURE_XENPV
> > +
> >       ENCODE_FRAME_POINTER
> >       UNWIND_HINT_REGS
> >
>
> Oooh, here we go, this is the answer to my question for patch #1, a note
> in the changelog might be nice. Something like:
>
> "This looses a Xen PV optimization, which will be restored in a later
> patch. The superfluous stack switch is just that."


In V2, the change of int80 thing is after this patch.  Maybe that order
of patches is more natural.  I'm sorry to reorder them.
