Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6854C2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbiFOHwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiFOHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D8F55
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F31A61917
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED225C3411C;
        Wed, 15 Jun 2022 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655279544;
        bh=/Cq8JxWDGWPl1V210SZ7wqDAk1YugafyAPEyJX3tbh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbXfnxamMI9lriVQxFHGz+SDHAV/InUwRvxz9w+8yPYsVUbPEZC9X+nw40fofM1jP
         dNldOC17X30lLDafgiwlqAUgKqjfYVUwcJxgj9fpSlPBquLHfAvEWSENSW/MV/BnjW
         TbJmhDmNRRDEc7U0TuIMkgQqxdadP+3msiO+mwmn+BXhqQ253EIxokGRNJfD6QkNWV
         ieGANqzWz677uZiaLRBiahDa+Wz7y+gFcv+WF5gpf1dm6765hDMARgcG8e6N+1knT4
         wjMHUUPuVNfktVIJM/m3X0rHPSzaNb+xHMjnwkLQopi1DvZwS/Wc52y8HvzsUXiWLi
         LcsRhjzywnBnQ==
Date:   Wed, 15 Jun 2022 09:52:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] fs/exec: allow to unshare a time namespace on
 vfork+exec
Message-ID: <20220615075219.5cvoc3py3zdm74oo@wittgenstein>
References: <20220613060723.197407-1-avagin@gmail.com>
 <202206141412.2B0732FF6C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202206141412.2B0732FF6C@keescook>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 02:14:35PM -0700, Kees Cook wrote:
> On Sun, Jun 12, 2022 at 11:07:22PM -0700, Andrei Vagin wrote:
> > Right now, a new process can't be forked in another time namespace
> > if it shares mm with its parent. It is prohibited, because each time
> > namespace has its own vvar page that is mapped into a process address
> > space.
> > 
> > When a process calls exec, it gets a new mm and so it could be "legal"
> > to switch time namespace in that case. This was not implemented and
> > now if we want to do this, we need to add another clone flag to not
> > break backward compatibility.
> > 
> > We don't have any user requests to switch times on exec except the
> > vfork+exec combination, so there is no reason to add a new clone flag.
> > As for vfork+exec, this should be safe to allow switching timens with
> > the current clone flag. Right now, vfork (CLONE_VFORK | CLONE_VM) fails
> > if a child is forked into another time namespace. With this change,
> > vfork creates a new process in parent's timens, and the following exec
> > does the actual switch to the target time namespace.
> 
> This seems like a very special case. None of the other namespaces do
> this, do they?
> 
> How is CLONE_NEWTIME supposed to be used today?

Time namespaces are similar to pid namespaces. If a process calls
unshare(CLONE_NEWTIME) it will not change into a new time namespace.
Only the children of the process will.

You can also see this via /proc/<pid>/ns/time and
/proc/<pid>/ns/time_for_children. After an unshare(CLONE_NEWTIME)
/proc/<pid>/ns/time will be unchanged while
/proc/<pid>/ns/time_for_children will reference a new time namespace.

So if the process now calls fork() the child will be placed in a new
time namespace.

As Andrei correctly points out in the commit message each time namespace
gets it's own vvar page mapped into the process address space.
Consequently calls to clone*() with CLONE_VM will need to fail because
it would alter the parent's mm as well. That includes vfork() which is
roughly just CLONE_VM | CLONE_VFORK.

fork() remains unaffected. So anything that implements a process
launcher using vfork() needs to implement a fork() fallback after vfork
failure() in case the original process has unshared a new time
namespace.

As posix spawn is implemented using vfork() we would force glibc to
implement a fork() fallback and enforce the introducing of a lot of
complexity to work around this.

I think the proposal here makes sense and allows us to avoid introducing
yet another clone flag. For vfork() it also makes sense because the
calling process is suspended until exec or exit so the semantics between
fork() and clone*() are sufficiently distinct to justify this
difference. Iow, vfork() is distinctly targeted at enforcing an exec*
call already anyway.

Christian
