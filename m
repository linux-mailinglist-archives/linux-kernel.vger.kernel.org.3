Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26F45B0F98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiIGVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiIGVxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:53:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4030BCCE3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:53:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 65so5705671pfx.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Z5GJrqjJQMYbMW7us5T23+B/aTeBU0CAzSlb/tOIIZc=;
        b=RP6d17fMasTft+5+iHsmeoCFsBlpbOjD3CH+Ezrhse/VNMNlmeP4PMRUux+/ZFJBoc
         0IJfvlQVQHt+KRKwJaQK6XEBx+JtTjsdAVjJmNBCentLGU0YoSI9oLGPAPUnFUFPLYk6
         lJ1Xp3X3YhF3oyJJ+wdQZP2W2ymoNYvOn91sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z5GJrqjJQMYbMW7us5T23+B/aTeBU0CAzSlb/tOIIZc=;
        b=UX/uu6Ss1OodNU7lC3wcMr4YZ5PBPQwwJq32kxPp8OWDUoq87x1aRBvcv/DALuZBVJ
         A5IPk+DfhQlaxyENVSs6Fb/X2Ibx40iyhi8c25WHoNVfMKPruDir+ZHNOwqqczrS6lpC
         obsvt9Z5s8GNPQsgvhOxU58qVPYKtSJFJS4VHywebdyM26eowowopSzM23jsVXd9Spde
         1RVTzJ0rfDEQBjYYuSnaQpU/6v3eiQzhKbOMR83qlGNY4UXZaYBvOtvMaxNiIVL9vw8Z
         BgRig9NgipubQzFXOyNtJi5Ge6EsIsfjvwBlh/RlNi8xiJ/J2eSO3w9qEiktfcPH00YM
         m/bA==
X-Gm-Message-State: ACgBeo3sp+a4JguSJ31uD90J/csOHS61/7Ows1lOMiYWzJxYPrdEctIf
        ZKMweKBBmIYWO6vMYovHaouVjQ==
X-Google-Smtp-Source: AA6agR5bFfTHNBI1uSgeprTXPkiWJ2QE6bLAczHhboivRL1uC9r105HF7q22cZE5HzFBdmicENI5rw==
X-Received: by 2002:a05:6a00:228a:b0:53e:a46d:aa38 with SMTP id f10-20020a056a00228a00b0053ea46daa38mr1864427pfe.79.1662587625394;
        Wed, 07 Sep 2022 14:53:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5ec9:e2a6:c584:3a7b])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b001768517f99esm10787677plg.244.2022.09.07.14.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:53:44 -0700 (PDT)
Date:   Wed, 7 Sep 2022 14:53:42 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracefs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <YxkS5uzouv2bn6ZB@google.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
 <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
 <20220907174604.06809ff2@gandalf.local.home>
 <20220907174813.182df339@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907174813.182df339@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 05:48:13PM -0400, Steven Rostedt wrote:
> On Wed, 7 Sep 2022 17:46:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > >   # Don't change /sys/kernel/tracing/ permissions on automount.
> > >   umount /sys/kernel/debug/tracing/  
> > 
> > BTW, I noticed that the above doesn't do anything. That is,
> > you cannot unmount tracefs from /sys/kernel/debug/tracing.

Actually, it does work, but it's hard to observe. See below.

> I just saw your new email. I guess that's just how you were triggering the
> automount, by unmounting it. Right?

You trimmed the important line:
  stat /sys/kernel/debug/tracing/.

It's hard to observe directly that /sys/kernel/debug/tracing is
unmounted, because traditional examination (stat(2), open(2), etc.)
methods will re-trigger the automount. The automount is *supposed* to
appear as if it is always there.

Try these:

  umount /sys/kernel/debug/tracing/
  grep tracefs /proc/mounts
  stat /sys/kernel/debug/tracing/.
  grep tracefs /proc/mounts

The first and the second grep will give you different results.

> A lot of assumptions about what people may know ;-)

Yes, I suppose. That's also why I figured I'd write a test case, because
test cases tell you exactly what is meant.

Brian
