Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815D65AA319
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiIAWcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiIAWcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:32:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86419DCF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:32:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w2so205823pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nI0O5+zQ8HWP182DwztRp9AcWFwHvszk1/UIBwWMnac=;
        b=N68UBGOmR89tCG6m8eSgzeqNygNBEclM2VqFewtBiT45Yf/k/e+1YJPm2JfAwXP0EA
         BcWCNUmZXBaMlzY4R8EQAn+uhv5QxZkth/IE3b/aTKinPUpui37gjPRdz3BYpbtPQ+ps
         k2pdmJyzQj7lQ3uLoTNlXY7LcXuNGnzjmqBZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nI0O5+zQ8HWP182DwztRp9AcWFwHvszk1/UIBwWMnac=;
        b=q3xpW+aB8PYCjFVefWAzmigcPltk6y+vmWRCZQaRY3ULu6YJcouBew7+NBnh55Ks5N
         RU6bBTVGM2bG0ZQBYaAkpMVK42LsDpdyAK+ioZokeoEW/0aiTlagP0Erq/UakEIEN3uq
         PdwVmFhjXCSNUZ7rtwDZt/jVXBhyKvZgWAIC30wJsRqH5ymnOu3EDkS04TVoo1pZ7rg7
         kIYbvHJ7Mnoy+qEAS4W+z3mTSDOf7RahQ3eswS0NDN/ppeXzng8QyKs2mIysyGw9MUOj
         EiVF0KnLjEZFxvLINfYa2t5pXPxxxmDzvw6aZicCy9XZinfT25GMmtnO0Y7AUIRYfqjK
         E78A==
X-Gm-Message-State: ACgBeo17xwyh/sALjTVhN6OiBWC4Q1AVhcAMpdlOhdRCVxiIjh3K4cb0
        bbc1HtjZ62cBsIywbkVzkoveMA==
X-Google-Smtp-Source: AA6agR4w5ZjpdAXAbWdllXBFoNEK9uKXvYlzHIe+Ll/0Hh/lHq8S8Gn3/ZEKhc+dpRVHZSnbdjcocQ==
X-Received: by 2002:a17:902:ab5d:b0:175:5e44:1619 with SMTP id ij29-20020a170902ab5d00b001755e441619mr4649179plb.21.1662071541039;
        Thu, 01 Sep 2022 15:32:21 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8eef:b938:ebed:b93d])
        by smtp.gmail.com with ESMTPSA id mz23-20020a17090b379700b001eee8998f2esm3835469pjb.17.2022.09.01.15.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:32:20 -0700 (PDT)
Date:   Thu, 1 Sep 2022 15:32:18 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] debugfs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <YxEy8mTO1nZ1sxHV@google.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
 <YxDWlgulBijTzj3y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDWlgulBijTzj3y@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:58:14PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 26, 2022 at 05:44:16PM -0700, Brian Norris wrote:
> > Users may have explicitly configured their debugfs permissions; we
> > shouldn't overwrite those just because a second mount appeared.
> 
> What userspace mounts debugfs twice?

I'll admit, my particular userspace in question (Chrom{e,ium}OS) does
not. There are several debugfs mounts, but they are bind mounts, which
don't hit this problem.

But Steven hits the nail on the head for most of my reasoning; my main
motivation is for tracefs (patch 2), whose automount makes this very
surprising. I included patch 1 for consistency (tracefs essentially
copy/pasted debugfs). I could drop patch 1 if that helps somehow, but
I'd still like to consider the automount difficulties in patch 2.

> > Only clobber if the options were provided at mount time.
> > 
> >   # Don't change /sys/kernel/debug/ permissions.
> >   mount -t debugfs none /mnt/foo
> > 
> >   # Change /sys/kernel/debug/ mode and uid, but not gid.
> >   mount -t debugfs -o uid=bar,mode=0750 none /mnt/baz
> 
> So what happens today with this change?  Without it?

Sorry, this was probably a bit too implied -- the gid changes to its
default (0 if we never set it in a mount option before; or it will reset
to any previous gid= mount setting).

# ls -ld /sys/kernel/debug/.
drwxr-x---. 45 root debugfs-access 0 Dec 31  1969 /sys/kernel/debug/.
# chown root:power /sys/kernel/debug/
# ls -ld /sys/kernel/debug/.
drwxr-x---. 45 root power 0 Dec 31  1969 /sys/kernel/debug/.
# mount -t debugfs -o uid=power,mode=0750 none /tmp/mnt
# ls -ld /sys/kernel/debug/.
drwxr-x---. 45 power debugfs-access 0 Dec 31  1969 /sys/kernel/debug/.
# mount | grep '\/sys\/kernel\/debug '
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime,seclabel,uid=228,gid=605,mode=750)

I can include more before/after examples in the commit message if you
want. Honestly, that's kind of why I offered to write test cases; test
cases show what's happening better than narrative descriptions.

> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > I'm open to writing an LTP test case for this, if that seems like a good
> > idea.
> 
> If it's really needed, again, why would debugfs be ever mounted more
> than once?

Steven gave examples. Again, my particular use is more for patch 2. But
I think the current behavior is pretty surprising, if anybody ever
*does* try to mount more than once.

Brian
