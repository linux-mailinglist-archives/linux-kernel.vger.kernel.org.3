Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8134D357A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiCIQv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbiCIQgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:36:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F64B69CE4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:32:16 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u17so596388pfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gY50ygEuixJOL5+CoXoow1CeKmNwyNyKxbVe9LukYfQ=;
        b=PWj3A38TItrhsUjIRjWiaSik+i8qjhK1vVSzvImJ/IP/sBZ1SK16gd+4vLXNQJIbfz
         fq1MW9biuBNne5pe3fHiUnjTtyl3ymQBVPVACAAd0YvUvvBY80zbJXDXhDENAQEcfLCy
         w3cs3JW4i8Wm/1fIlJ8U/oZ/PDcWTWgkItkFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gY50ygEuixJOL5+CoXoow1CeKmNwyNyKxbVe9LukYfQ=;
        b=4OJHOb6VUNQZKx5I/A+koLpv9BjcIhtedRj9SbT3n2ALywVkuAuN9m9vxSglLoCVw6
         ZkMZIK8OlvsSsN+WotVMXfXQWMQ+PsrnTY699O4pX/yUiOKlt6D+l1H5sHkn7k8m/c1J
         IKihu848VjZjOPjKQH0akEfROgemHyOz3NwN6hrpVI3jRHFdhBji/IwyZwxrH0k7232y
         +/H51h1XQUQTAyEMJV54iOuHhFTjOhQ49pmMVWIs1w5IgmvQVHr1MBa1NRb67f0d603O
         FXdVSMpxu+dkWM8n9m3BqEw7AB0sUck2LnNI51gPJXVHTGU8ysJ9U5V4OQ4Hp2UY7y07
         aK7A==
X-Gm-Message-State: AOAM532vBJjxBQ2uLAHNEd39e+F/Qoo87jibY6AO/iUy2fhJruHC1Oa4
        61jHhRQkDIxEjOPZycC4dSXFHA==
X-Google-Smtp-Source: ABdhPJwXXZ86osX5c0II41H74ZTE2EneiajZEn1zrtqB/xvvBuaNxf78dej0GeYsUMxEOmzs8vYjZA==
X-Received: by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP id c16-20020a056a000ad000b004e12d962ab0mr549019pfl.3.1646843535989;
        Wed, 09 Mar 2022 08:32:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q24-20020aa79618000000b004e0e89985eesm3588763pfg.156.2022.03.09.08.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:32:15 -0800 (PST)
Date:   Wed, 9 Mar 2022 08:32:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org
Subject: Re: [GIT PULL] Fix fill_files_note
Message-ID: <202203090830.7E971BD6C@keescook>
References: <20220131153740.2396974-1-willy@infradead.org>
 <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org>
 <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org>
 <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
 <87h788fdaw.fsf_-_@email.froward.int.ebiederm.org>
 <202203081342.1924AD9@keescook>
 <877d93dr8p.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d93dr8p.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:29:10AM -0600, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Tue, Mar 08, 2022 at 01:35:03PM -0600, Eric W. Biederman wrote:
> >> 
> >> Kees,
> >> 
> >> Please pull the coredump-vma-snapshot-fix branch from the git tree:
> >> 
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git coredump-vma-snapshot-fix
> >> 
> >>   HEAD: 390031c942116d4733310f0684beb8db19885fe6 coredump: Use the vma snapshot in fill_files_note
> >> 
> >> Matthew Wilcox has reported that a missing mmap_lock in file_files_note,
> >> which could cause trouble.
> >> 
> >> Refactor the code and clean it up so that the vma snapshot makes
> >> it to fill_files_note, and then use the vma snapshot in fill_files_note.
> >> 
> >> Eric W. Biederman (5):
> >>       coredump: Move definition of struct coredump_params into coredump.h
> >>       coredump: Snapshot the vmas in do_coredump
> >>       coredump: Remove the WARN_ON in dump_vma_snapshot
> >>       coredump/elf: Pass coredump_params into fill_note_info
> >>       coredump: Use the vma snapshot in fill_files_note
> >> 
> >>  fs/binfmt_elf.c          | 66 ++++++++++++++++++++++--------------------------
> >>  fs/binfmt_elf_fdpic.c    | 18 +++++--------
> >>  fs/binfmt_flat.c         |  1 +
> >>  fs/coredump.c            | 59 ++++++++++++++++++++++++++++---------------
> >>  include/linux/binfmts.h  | 13 +---------
> >>  include/linux/coredump.h | 20 ++++++++++++---
> >>  6 files changed, 93 insertions(+), 84 deletions(-)
> >> 
> >> ---
> >> 
> >> Kees I realized I needed to rebase this on Jann Horn's commit
> >> 84158b7f6a06 ("coredump: Also dump first pages of non-executable ELF
> >> libraries").  Unfortunately before I got that done I got distracted and
> >> these changes have been sitting in limbo for most of the development
> >> cycle.  Since you are running a tree that is including changes like this
> >> including Jann's can you please pull these changes into your tree.
> >
> > Sure! Can you make a signed tag for this pull?
> 
> Not yet.
> 
> Hopefully I will get the time to set that up soon, but I am not at all
> setup to do signed tags at this point.

Okay, cool. Since I'd already review these before, I've pulled and it
should be in -next now.

> [...]
> Thanks.  That looks like a good place to start.

I will try to clean up that work-flow and stuff it into my kernel-tools
repo.

-- 
Kees Cook
