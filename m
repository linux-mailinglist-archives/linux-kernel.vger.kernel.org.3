Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8C4DC70E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiCQNAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiCQM7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:59:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F24814752E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:58:24 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id h126so10094777ybc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elCXN/aHOy7vPjpH18ylJ1cP6WgAx65RKk7fRU7ojZc=;
        b=GrXcH3YkxDoDgi9fve1WKPFK7la+x9vkdTRO0op5C6EH2jHfAjBM+56Fd3CvmdBXLR
         qsLlIug6rIODldHVTUojqYGPpTXNbTAvrzk04RueHmokWCxZigGXfhBQmTz3FpeG0NFy
         qzgEB+pcquNbq3ZQ4HWPoUnQSr5Ry8KL4l+nz/saBiR4V3kUXOijDay3DgBoKGOw3T/f
         syzjCZgr9O1rB+Zobo+MEfaNWjUjy7Yh9AzHZ3bruEkhzc2SGiYUdWte0sJUi+J2GpJp
         tvQsXro/S4gKuAx/Pd967T+4V84Xt/Uhjk3P2EgKZIWm2ba0E48+j45xW2zKUXbuLzIx
         IyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elCXN/aHOy7vPjpH18ylJ1cP6WgAx65RKk7fRU7ojZc=;
        b=j3/GNyC4ihWWP/IXpvsp/d2Rz7N7uWfCRkTT/Ix8iv+nrvUY30Mzu651X6h4Br21Lz
         /t2U6hFje2qrIr/XckvJxQQyDG+up72uzg1ylKBegF8pwwcDWraWkqMVrjTh2FjQNsnA
         ITA+9AwQrbvRPUFBb1olUAv//08JlOXjL1omqXHokjR4h3CLWe2aoruj/ZrV9P7kY13j
         fQuP5f6pFBC14MOt3k6Ph5JnjANb6aV/jg1RDXDM72qPBYUD8H2k/j7qyU3gzpNMfXje
         1JD/MM7YWw/b/YmmoXPfh36ZxIvpbu9VOAgO8oexCp7FW1ZPYBvhZl16vCpczTQ8IsR3
         gHLA==
X-Gm-Message-State: AOAM532jofI2aIKhxdKkw9QRybUOuGuf+KN9JJN1TgTV+jqvGpqz+XIz
        sG88Uuiytq4s076MwILn/1tocb43XL38RCdlz9U=
X-Google-Smtp-Source: ABdhPJz1Ykr9LGD7q5P8uDMtLdaPy1Y+vDOsRPd9uK7+wdlC3B64z9irPK+tLnlndwYC4ruP0bohf1f0eFROT2CQsOs=
X-Received: by 2002:a25:d512:0:b0:61d:aded:1743 with SMTP id
 r18-20020a25d512000000b0061daded1743mr4517766ybe.526.1647521903702; Thu, 17
 Mar 2022 05:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220315073949.7541-1-jiangshanlai@gmail.com> <YjH+VdHIiHZM3maD@hirez.programming.kicks-ass.net>
 <YjH+fAaH5yHGrxRu@hirez.programming.kicks-ass.net>
In-Reply-To: <YjH+fAaH5yHGrxRu@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 17 Mar 2022 20:58:12 +0800
Message-ID: <CAJhGHyDpa5oR7+cNv-Tj81uPFNmSKOqN2npCxfbo_zLwasVQrg@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] x86/entry: Clean up entry code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
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

On Wed, Mar 16, 2022 at 11:13 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 16, 2022 at 04:12:21PM +0100, Peter Zijlstra wrote:
> > On Tue, Mar 15, 2022 at 03:39:42PM +0800, Lai Jiangshan wrote:
> >
> > > Lai Jiangshan (7):
> > >   x86/entry: Use idtentry macro for entry_INT80_compat
> > >   x86/traps: Move pt_regs only in fixup_bad_iret()
> > >   x86/entry: Switch the stack after error_entry() returns
> > >   x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
> > >   x86/entry: Move cld to the start of idtentry
> > >   x86/entry: Don't call error_entry for XENPV
> > >   x86/entry: Convert SWAPGS to swapgs and remove the definition of
> > >     SWAPGS
> >
> > So AFAICT these patches are indeed correct.
> >
> > I do however worry a little bit about the I$ impact of patch 4, and
> > there's a few niggles, but otherwise looks good.
> >
> > I'd love for some of the other x86 people to also look at this, but a
> > tentative ACK on this.
> >
>
> Also, I forgot to mention; they no longer apply cleanly because I
> sprinked ENDBR all over the place. Mostly trivial to fixup though.


They can still be applied to the newest tip/master which already has
sprinked ENDBR.  Is there a more proper branch for me to rebase the
patches onto?
