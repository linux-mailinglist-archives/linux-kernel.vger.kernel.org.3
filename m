Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3113B4CAF85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbiCBUS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241242AbiCBUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:18:26 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD253A5F6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:17:41 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c4so2750587qtx.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=hcnRInHyT7AqsJ1AJbefJWd13NGYBwYyXEFZcHJATbY=;
        b=j0T2nJV0lnpbMZflp0bT2kBk63Dknl3cqydm9aqeygJbgE3IkKBjdC82QQ8nkvKXbY
         NTvZqdF1iUMksdrNCokctJXUXPglExlbh8OwW8bnSqP+Z5+mqofO2fM1lCDvMUXxGr8q
         xJfABQHw/+Fj79Nvn+cXKLnUfnvrzJznQGygzwYAnclvshXNEzUkwI0DUJPQsgO+yAih
         9BQ8yITfMIsOTTI4XrpgRXP9vAjgqh0UYxXUUNO4XOSPfbmiMCLJQwLQV83+Ke43m27C
         rjY2pw2TRMJbNg5phgYc2OcZYX9eI/JYFwmYmd9rlGscr1n/IZrZDojs5okmwwRsdvgY
         CQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=hcnRInHyT7AqsJ1AJbefJWd13NGYBwYyXEFZcHJATbY=;
        b=QHm+5WyLZTgXrD5dZv6YAjk7DaUAP2EoRgTdbSOdRGBP5K6yT/mukBLc5qRKSkX0ox
         8yyY4rtBtHLkxdBgYfxGdqAcxUcCtjiuf8ZD8+yA6g0+Kp0TsrXa2mDRleMQ5iiCqWUt
         4IG8MmN9/hqikwxuXSvx5ptritwf2BuT2IkGwF0ICag1QS8hI4OzFU5/Y/ksaUQAM5ro
         DU4P6aKWkJk47W5c9hXvvJYFNolpz9BxKy8zj1d4edOEezq7A6HyuXr7bZ4ZKp0DRAhN
         bUOfhKvmxjr36nTVqqZSwAs1uaZyHfsT7IK5Xb8GSTx1oqCfPEXB094WZk156awM38PL
         SEdQ==
X-Gm-Message-State: AOAM531/vxqSyIHgP8+Tj/Y5c0iFVvxrYnmCgKkDgOmedFO0hn0YlCql
        gHnbJdEKtaB7Owmb9co8k1JwU3LCWtAC6w==
X-Google-Smtp-Source: ABdhPJzwcHKRnLlbYa+DzMb5ldu29lVAc6Rg9+D/8Np1y8eHDZDZijeZOmxUYc5MWOGbFELaKiEoOQ==
X-Received: by 2002:a05:622a:1046:b0:2de:4c2b:96c8 with SMTP id f6-20020a05622a104600b002de4c2b96c8mr24656420qte.141.1646252260655;
        Wed, 02 Mar 2022 12:17:40 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y18-20020a05622a165200b002dda08f1371sm2317qtj.0.2022.03.02.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:17:39 -0800 (PST)
Date:   Wed, 2 Mar 2022 12:17:30 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Xavier Roche <xavier.roche@algolia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jean Delvare <jdelvare@suse.de>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v3] tmpfs: support for file creation time
In-Reply-To: <CAHk-=wh1oc0=YuMJCnjV_aY4FswtWk3OeO4-SEbCmAXGkAfDPA@mail.gmail.com>
Message-ID: <b925ce4f-e9a4-92e6-6a95-6c718cfcb134@google.com>
References: <20220211213628.GA1919658@xavier-xps> <20220211213628.GA1919658@xavier-xps> <CAHk-=wh1oc0=YuMJCnjV_aY4FswtWk3OeO4-SEbCmAXGkAfDPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022, Linus Torvalds wrote:
> On Mon, Feb 28, 2022 at 12:43 AM Xavier Roche <xavier.roche@algolia.com> wrote:
> >
> > Various filesystems (including ext4) now support file creation time.
> > This patch adds such support for tmpfs-based filesystems.

Please ignore this patch for now: I presume Xavier did not understand
the "from akpm to Linus in next merge window" flow, and thought he had
to resend the patch to you.

> 
> What's the odd huge-page noise in this patch?

That was one of the fixups I added, which akpm is holding in a -fix
patch to be merged in, and maybe he'll include my comment from it:

3. Using shmem_getattr() on other file types than regular requires that
   shmem_is_huge() check type, to stop incorrect HPAGE_PMD_SIZE blksize.

(shmem_getattr() was only on regular files before: Xavier's patch
added it to directories etc, to provide btime for them too; but
shmem_getattr() can also include a dubious adjustment to blksize.)

> 
> Other oddities:
> 
>     Reply-To: b954973a-b8d1-cab8-63bd-6ea8063de3@google.com
> 
> WHAT?

No comment from me.

> 
> And finally - if we really want to treat btime as a first-class entity
> and expect things like tmpfs to support it, then we should just bite
> the bullet and put it in 'struct inode' along with the other times.

I've no objection if someone does that later.  I've no investment
in btime myself (my instinctive reaction was, is this thing worth
another 16 bytes of inode space?), but Xavier thought it worth doing,
and Andrew worth taking, so go with the flow.

Ah, Andrew has replied meanwhile, I hope I'm not contradicting!

Hugh
