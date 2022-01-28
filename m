Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7895149FEC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350512AbiA1RQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiA1RQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:16:51 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245FC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:16:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ah7so18168108ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3JH2uswymAsKpMUeWYj6Rrvu9IBeiXIZ4PRQpmFOBI=;
        b=IFOZ8SQ/4LRnLylIohKZy/v6LW7gUkwz17ky/+vepKc8ib+dXSfN0Ny3Qqx5elgK8v
         RR8JuJaOfAaVRo4NnYX3+sx2uPzu91PpBMPh2+LPuL18RwNZK3ycH9HrYjYn4hlaPnUl
         xrWvkTk3kNTmwhFk2HSQZFAFrkQb0lgCQvVmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3JH2uswymAsKpMUeWYj6Rrvu9IBeiXIZ4PRQpmFOBI=;
        b=dPbZoXhNqcs2aB12Ys+1CHesTQb41Tss3iHnSYo90aua6sCGZRwqxZheaSnB4fSBec
         MlbiURdrWSbM+lwJLwtOOYg3od+Q8I34aCxmNBy4CqpomWRibObSnhV00MvOVLPb7976
         RAp9xMYZ/QVHHs/QbSWCcyb9THIgfvwvUXKpbc+eyie1/xkcrRrMdGA3cEglm1x0O40c
         R9uWUaawSAq9dmKkNmuuhKL/6Xv9huJm4gcqCMTdsdxUEL+V9rAr0kwuWXxLCP4/PTkT
         HjG2fIkXTQb2YFek9ab4vl9ohF/CPddnod3N1DvJvpgbW5I7Cj8kjIbtB68+z/4AuWuR
         Q8Mg==
X-Gm-Message-State: AOAM5318i8im+iRCKjnoleAWVNmgNwP4JVvc4wc8gUWsXrq4cZVO8BSm
        2/xEykUfP0LZeg86u4P4gHG3RKznuFVmlsSf
X-Google-Smtp-Source: ABdhPJwzVlN4G5uBO63SDOLA3/YyUPFOrwT3nfCAuAADfi2HqtQmfLPuh9RLA+AGakY33H8FQwDf9w==
X-Received: by 2002:a17:907:3e1d:: with SMTP id hp29mr7577355ejc.701.1643390209127;
        Fri, 28 Jan 2022 09:16:49 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id gh14sm10058625ejb.126.2022.01.28.09.16.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:16:48 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id m26so2489715wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:16:48 -0800 (PST)
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr10914921wmr.26.1643390198229;
 Fri, 28 Jan 2022 09:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20220128065310.GF8421@xsang-OptiPlex-9020> <CAHk-=wgT6wuBB=pK2bGNQbioNCdJHT8Jnvs+4oT25jX1JFyhgg@mail.gmail.com>
 <20220128120421.kzo5iduigr7k55bs@quack3.lan> <87a6ffst4j.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87a6ffst4j.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jan 2022 19:16:21 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjzWVW1xvVLCOvw-MMoVK9kiRn5CUx2am8jPdo09mHgjA@mail.gmail.com>
Message-ID: <CAHk-=wjzWVW1xvVLCOvw-MMoVK9kiRn5CUx2am8jPdo09mHgjA@mail.gmail.com>
Subject: Re: [ocfs2] c42ff46f97: sysctl_table_check_failed
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Antti Palosaari <crope@iki.fi>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Kees Cook <keescook@chromium.org>,
        Lukas Middendorf <kernel@tuxforce.de>,
        Mark Fasheh <mark@fasheh.com>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Qing Wang <wangqing@vivo.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Kitt <steve@sk2.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jani Nikula <jani.nikula@intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 6:49 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Yes.  There is a register_sysctl_paths that can be used if you want/need
> the embedded directories.  That probably would have been a better
> choice for an automated conversion.
>
> But since this there is only the single file in a single directory
> register_sysctl() with the full path is perfectly fine in this case.
>
> Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

I was doing filesystem pull requests anyway, and as a result (I tend
to group things by topic if there's multiple things pending) I already
committed that patch of mine based on Jan's reviewed/tested-by, so
this reviewed-by ended up not in the tree.

But maybe somebody should check the other automated conversions for
the same issue? Hint hint.

Also, I'm somewhat unhappy about the fact that apparently the kernel
test robot already found this issue back in November of last year, yet
it made it to mainline several months later without being fixed.

It's hard to tell from this link:

  https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/KQ2F6TPJWMDVEXJM4WTUC4DU3EH3YJVT/

but it does look like that original report only made it to that lkp
list and not the actual people listed on the commit itself? That would
explain why the report was overlooked.

Kind of sad.

              Linus
