Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71855B0E9C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIGUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGUwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:52:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8935D7E808
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:52:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o4so15699915pjp.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=961bjcJb8RZkBe//4EJ/jouBr4+ihtNtsy9cWq/UKK4=;
        b=JHdCiZoOhb0lTlqvYN/LPVhqxZwmpc8tgmDHCmCPi8qK/q3XDmaM2jIVFDIiP2ruOl
         lDrd78lC/N2jfQnXKm2v3j81YdhYtLA5hjE3ZZrqZgJ9i4Nrn78XryEVgegmNEF6RLR+
         qyTMVXTVvEB3bQWZbcuvIjHiIUK69vC6cU8dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=961bjcJb8RZkBe//4EJ/jouBr4+ihtNtsy9cWq/UKK4=;
        b=gCysCx2qfccJmKLG9doPpEpINffcWB2JS/xwbWWqYjig5trnWNcwBNWvUGugUycJmn
         4O+hiRT7VkA3qCHrNpBbHrqFRawd3gmzJG84Tt9Y2gqe6c2oYFbaEa1mzMJc0HooI1Yn
         yhSO91mB/O8QW5MHRzAfy9u8c548AQj53GCziBu+pgNPGZpezW9kF/FcyodEtde5619Q
         +lPIoit+B86bS5Exz/iBwWWWCbneyRGhtP6wyKrSk79ui2x/PCGLksIUSibCDqjqALw1
         UMCQMykSj2JcHgBPZRzqRGG2/C/wXcB363wSz9n6rnE0EjMlQVrVIlCPL+pr2s3JYhW7
         vK+Q==
X-Gm-Message-State: ACgBeo1pDgwmJzTYoXQmwXtcbUjeoUb63yIeIOXN8w4kHO+7c8K3hoaq
        w0iOn/LHPJolvl1gK8+efKSK1KuTv/BBrA==
X-Google-Smtp-Source: AA6agR5xQ4U5ksu1Yv0DD/tWF2DnB705zTjv3ljSQ42PNxjEI4Ir4sJ8yhnyqHUWy6fxxFz2hnLwTg==
X-Received: by 2002:a17:90a:e7c2:b0:1f5:85ab:938c with SMTP id kb2-20020a17090ae7c200b001f585ab938cmr349043pjb.133.1662583938848;
        Wed, 07 Sep 2022 13:52:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5ec9:e2a6:c584:3a7b])
        by smtp.gmail.com with ESMTPSA id d22-20020a656b96000000b0041c35462316sm11028192pgw.26.2022.09.07.13.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:52:17 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:52:15 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracefs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <YxkEfzVusTXj9JST@google.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
 <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
 <20220907074443.3376c766@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907074443.3376c766@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Wed, Sep 07, 2022 at 07:44:43AM -0400, Steven Rostedt wrote:
> On Fri, 26 Aug 2022 17:44:17 -0700
> Brian Norris <briannorris@chromium.org> wrote:
> 
> > Users may have explicitly configured their tracefs permissions; we
> > shouldn't overwrite those just because a second mount appeared.
> > 
> > Only clobber if the options were provided at mount time.
> > 
> > Note: the previous behavior was especially surprising in the presence of
> > automounted /sys/kernel/debug/tracing/.
> > 
> >   # Don't change /sys/kernel/tracing/ permissions on automount.
> >   umount /sys/kernel/debug/tracing/
> >   stat /sys/kernel/debug/tracing/.
> > 
> >   # Don't change /sys/kernel/tracing/ permissions.
> >   mount -t tracefs none /mnt/foo
> > 
> >   # Change /sys/kernel/tracing/ mode and uid, but not gid.
> >   mount -t tracefs -o uid=bar,mode=0750 none /mnt/baz
> > 
> 
> The above text doesn't make sense. Is the comments what you are doing or
> what the system is doing? If it is what the system is doing, please show
> the output of the stat command and how it is doing something unexpected.

Sorry, I do see how the text as-is is unclear. The intention is to
describe the new, intended behavior, and I only left the existing
behavior as implied.

> Can you show the example of what is wrong, and what you expected to happen.
> The above is just a bunch of commands, but does not display anything that
> is incorrect.

Sure, here's a narrower description of old (unexpected) and new
(expected) behavior, in case you were wanting to update the changelog on
your own:

---

Existing behavior:

  ## Pre-existing status: tracefs is 0755.
  # stat -c '%A' /sys/kernel/tracing/
  drwxr-xr-x

  ## (Re)trigger the automount.
  # umount /sys/kernel/debug/tracing
  # stat -c '%A' /sys/kernel/debug/tracing/.
  drwx------

  ## Unexpected: the automount changed mode for other mount instances.
  # stat -c '%A' /sys/kernel/tracing/
  drwx------

New behavior:

  ## Pre-existing status: tracefs is 0755.
  # stat -c '%A' /sys/kernel/tracing/
  drwxr-xr-x

  ## (Re)trigger the automount.
  # umount /sys/kernel/debug/tracing
  # stat -c '%A' /sys/kernel/debug/tracing/.
  drwxr-xr-x

  ## Expected: the automount does not change other mount instances.
  # stat -c '%A' /sys/kernel/tracing/
  drwxr-xr-x

---

There are other variations of old/new behavior (e.g., if using various
mount options), but those are not the main reason for this patch.

> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > I'm open to writing an LTP test case for this, if that seems like a good
> > idea.
> 
> Yes, please add a test :-)

Sure, I'm dusting off my LTP VM now. But in case you'd like the patch
as-is, feel free to splice the above into the commit description.
Otherwise, I may resend as Greg requested for patch 1, after I've got a
test patch going.

Brian
