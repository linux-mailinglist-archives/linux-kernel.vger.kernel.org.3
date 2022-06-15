Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF5254C3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiFOIx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiFOIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440F12085
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C36B061976
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E71C34115;
        Wed, 15 Jun 2022 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655283235;
        bh=2nPPSVGZHcu+cNkg9BTNypk51Gwnzl3wSf0DXtYRlRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sng/P/z+Z9T8pkPrzl0gwASUr17lQI8Nzd0g5ur7HPXXOa6DcJbGNlLOk1NWfl7hR
         hzXlaJ85TUMmjDQBaBy7rTYAXDU5CgDEQ5sSu3TzbZk4BOZQB/dJR3B7Dv9hrrfN/5
         5hCpOeO253VgT+sJQQMgsOJYV2Iro62qRdGXuC9GvQQ+peK2k1aTOy2WltGnw2ifWi
         Od8m/REztUqOu2pYb65RqN8IHIjXYscOb72NnGgL+Xec8MqrvzxBJLD7u0zcihsY0D
         uIkNDAO8j6LUjqgyx4gL0O06k8pmJ1YcSBGy1qF85JETRKBm1x0gOL1xVYzMLhkXwI
         nawQ/b3qFby9w==
Date:   Wed, 15 Jun 2022 10:53:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] fs/exec: allow to unshare a time namespace on
 vfork+exec
Message-ID: <20220615085350.theicffhehgbmfep@wittgenstein>
References: <20220613060723.197407-1-avagin@gmail.com>
 <202206141412.2B0732FF6C@keescook>
 <874k0mqs5i.fsf@oldenburg.str.redhat.com>
 <20220615080000.qtxeosohhyfabzmg@wittgenstein>
 <87zgiepcmc.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zgiepcmc.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:14:19AM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> > For pid namespaces one problem would be that it could end up confusing a
> > process about its own pid. This was a more serious problem when the pid
> > cache was still active in glibc; but fwiw systemd still has a pid cache
> > afair.
> 
> Right.  glibc still has a TID cache, mainly for use with recursive
> mutexes (where we need a 32-bit thread identifier and can't perform a
> system call on every locking operation for performance reasons).
> Assuming that a non-delayed CLONE_NEWPID would also change the TID
> underneath us, we'd have subtly broken recursive mutexes.

Fwiw, you can't call CLONE_NEWPID with CLONE_THREAD. This guarantees
that threads can send signals to each other and all threads within the
same threadgroup can be reached via proc. It'd be awkward if you'd have
a thread whose thread-group leader lives in an ancestor pidns.

Even if you'd make whole threadgroup change pid namespaces immediately
it would mean allocating new TGID and TIDs in the new pid namespaces -
unless they are accidently not already allocated.

> 
> vfork gets away with not updating the TID cache (which is shared with
> the parent process) because the parent process is suspended while the
> new subprocess is still running and has not execve'ed yet.
> 
> Now one could argue that calling unshare automatically means that you
> must not call any glibc functions afterwards (similar to thread-creating
> clone), or at least that you cannot call any functions which are not
> async-signal-safe, but that does not match existing application
> practice.  And I think we actually prefer that file servers call chroot

Yeah, that'd be a rather subtle and risky change for pid namespaces.
