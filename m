Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0137A4B2F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352794AbiBKVlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:41:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiBKVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:40:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2499BC66
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqI38sOGjQkk/kdw5sRYev4nCDxf01vz6fuBqsYp2pU=;
        b=a+M84+b+VrNg1HL5y007lLWz0QDRi0vWEMAZ0OJrktibSzn1mjNTBEJZAGeTli+YBEtNwM
        IEOaMzUqj+leG9PPz1eMIpm2Gcn8TpPpqEnNmM1uyDhhrVTXUwo3u+vGRFj8fa7EWQz+kS
        VN0X5Tb3WU3ckrOX+YMEe9inporRuUE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-o1z0L8UMPJ6nnHJWwl_VOw-1; Fri, 11 Feb 2022 16:40:54 -0500
X-MC-Unique: o1z0L8UMPJ6nnHJWwl_VOw-1
Received: by mail-wm1-f69.google.com with SMTP id i188-20020a1c3bc5000000b0037bb9f6feeeso434278wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqI38sOGjQkk/kdw5sRYev4nCDxf01vz6fuBqsYp2pU=;
        b=ZVc7xLp2xJ0gpm8uPDIssX+cydMntRLfUS4XSGyhNYREUzBJB1U/v4q+RdN8Tf6KT2
         ad9Cxg/i/wifZ92iycVOWEKIHMpM52Cb+g+MPhiRzE3lHhCKYuoZXcBrorK7tq63L3PC
         J2BvA4sjGtj3j+ccPGRh+rQOP+g499vLvVd3CIVDtC6VFu2UA9aIWzkMAoA9+WtDL7zw
         R6ynXragF/utvEI+zndzzLWQv2EnF8KantegA3a0TWK00Vf2D339GHdF/jPmxUEx7SkR
         52coOZv09Bw/G8ZEz0qX/Nzw04PaPKkFT9SbalErJZaI0zTa1sM/FvhaZIpqb/yuMZbH
         w0bA==
X-Gm-Message-State: AOAM531Tb7Qu8HuX9W5pirqY40XnHQWRPf/HsWRHoHKvc48fqvpAXvMK
        yHM1XUXllSJE/0maPL/XHbl5iopHmtmx7upX5No4TVDbFCEZsPnZ2Gg+RnwQzpW9/R7v3JlEfO6
        Fl4U6On0QPakVcXG+YLi3UApcOTBuQuZ/XtMaehaU
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr2805497wrz.467.1644615652998;
        Fri, 11 Feb 2022 13:40:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytKegG4uDbc7VzIalpGiz97r3Tl2ltFZoA4NB5ErmhhhrTxrr5fvHnN0bRc0eWbu1gFTg/xjMhuQKdmPWrAfM=
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr2805493wrz.467.1644615652820;
 Fri, 11 Feb 2022 13:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20220211170522.348999-1-agruenba@redhat.com> <CAHk-=wgURPnzwmWtgT-WSrpfFX9_wx_ZsY1XWp1MehrUuBuNiQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgURPnzwmWtgT-WSrpfFX9_wx_ZsY1XWp1MehrUuBuNiQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 11 Feb 2022 22:40:41 +0100
Message-ID: <CAHc6FU7rMvu=Wry=VOXRv1191xooo+r8Cnv4XwYQysAr1hRFYw@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 8:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Feb 11, 2022 at 9:05 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > * Revert debug commit that causes unexpected data corruption.
>
> Well, apparently not just unexpected, but unexplained too.
>
> That's a bit worrisome. It sounds like the corruption cause is still
> there, just hidden by the lack of __cond_resched()?

Yes, that's what it looks like. My initial suspicion was that we're
somewhere using gfs2_glock_dq() in non-sleepable context when we know
that we're not dropping the last reference and so gfs2_glock_dq()
won't sleep, but there's no such instance in the code, and testing
would also have revealed such cases. The corruption we've seen always
affects whole pages/blocks. Maybe it's an ordering / memory barrier
issue.

Thanks,
Andreas

