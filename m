Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD653CE1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbiFCRe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiFCRe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94A4C52E57
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654277664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3rRFPIEgRYgx1slpwsuoO6sNR3Uwd/3DP3MxRYw77U=;
        b=PsGEHxomBt7yV0ZXWmoTV5SupXflFUxyLxCjxhb+AzO3kr4bJTb7qOke7bnRpvsEGHhnmV
        vEYVBPzXT0fx/1shb6PdMmtzZTq3y57uTq68fyImb0e8Du708a3Olx4ilmj2fTb54twfSX
        KN7+t17Js3ZHaeXOhLsBsR0Db8NAvrY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-dUg4mIVIPBmuN8uXrGet6Q-1; Fri, 03 Jun 2022 13:34:23 -0400
X-MC-Unique: dUg4mIVIPBmuN8uXrGet6Q-1
Received: by mail-il1-f200.google.com with SMTP id w7-20020a056e021c8700b002d3bc8e95cbso6684180ill.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 10:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o3rRFPIEgRYgx1slpwsuoO6sNR3Uwd/3DP3MxRYw77U=;
        b=XW1l/a5X4+WtaoCFpoRa8Y1OD7Udiyqf42XvEKrBFGodcflIQOC7xSmimMIeD2Q6oM
         vl/ZrYt6Yai4bgg/nmanVc9kfx6BIh/RR0EEzQbjcU5l5CmobpBdWrmVHnh3g4jHbMnF
         ycLXF3W0OsFdi82xUa8JeeXGhfgrrEahnJmMCrlcm2N9+tTAApbFf0dq1YN8Fo13gzSq
         434L3+A8mTOPUeqZD4vvoG0FpIuy/yMxE3YIxbzm4ZuVqr5kB0oC4m/fTh9PBVJUwwoq
         EC0Y2PvF9DeibLWCKES75cUlesKj4yuGuI5COdFz1+GB4E90v0107ciFPQRbLx3njvN3
         0N8Q==
X-Gm-Message-State: AOAM531Fk70fvxCWEZcxXHXysFcs5Mg/iszMQiqhYaNYrE7s+qRjfXQH
        EStNfi3NLvr8LdQKDCcw2/DP2h7ZmbzsgaK74nJqK9Vm1DhoWShJ4lGSS7krIvMjOi40DqVeFLc
        6GXiwaJ4ztzgvTWJdbfKO4QYl
X-Received: by 2002:a05:6e02:158b:b0:2cf:e058:8ecc with SMTP id m11-20020a056e02158b00b002cfe0588eccmr6676650ilu.30.1654277662250;
        Fri, 03 Jun 2022 10:34:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPlXB8JiVzS7AfyRx7LCWWt4OshvqVBJJDX+iF3FaY1a6dnwRCvBVQs9qUi5geaaA8ZWLSpA==
X-Received: by 2002:a05:6e02:158b:b0:2cf:e058:8ecc with SMTP id m11-20020a056e02158b00b002cfe0588eccmr6676629ilu.30.1654277661946;
        Fri, 03 Jun 2022 10:34:21 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id d13-20020a5d964d000000b00665714766a2sm2677998ios.47.2022.06.03.10.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 10:34:21 -0700 (PDT)
Date:   Fri, 3 Jun 2022 13:34:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] userfaultfd.2: Add section for UFFD_USER_MODE_ONLY
Message-ID: <YppGGxdz7m7vyb85@xz-m1.local>
References: <20220531011157.46868-1-peterx@redhat.com>
 <20220531011157.46868-2-peterx@redhat.com>
 <ce05bd8d-087d-cfa8-6aca-02fd1f3aebb7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce05bd8d-087d-cfa8-6aca-02fd1f3aebb7@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 07:11:05PM +0200, Alejandro Colomar wrote:
> Hi Peter,
> 
> On 5/31/22 03:11, Peter Xu wrote:
> > Add a paragraph for UFFD_USER_MODE_ONLY flag that was introduced in
> > Linux 5.11.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> See some minor comments below.
> 
> Cheers,
> 
> Alex
> 
> > ---
> >   man2/userfaultfd.2 | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> > index cee7c01d2..0928a76d2 100644
> > --- a/man2/userfaultfd.2
> > +++ b/man2/userfaultfd.2
> > @@ -29,8 +29,9 @@
> >   userfaultfd \- create a file descriptor for handling page faults in user space
> >   .SH SYNOPSIS
> >   .nf
> > -.BR "#include <fcntl.h>" "            /* Definition of " O_* " constants */"
> > -.BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
> > +.BR "#include <fcntl.h>" "             /* Definition of " O_* " constants */"
> > +.BR "#include <sys/syscall.h>" "       /* Definition of " SYS_* " constants */"
> > +.BR "#include <linux/userfaultfd.h>" " /* Definition of " UFFD_* " constants */"
> >   .B #include <unistd.h>
> >   .PP
> >   .BI "int syscall(SYS_userfaultfd, int " flags );
> > @@ -76,6 +77,15 @@ See the description of the
> >   .BR O_NONBLOCK
> >   flag in
> >   .BR open (2).
> > +.TP
> > +.BR UFFD_USER_MODE_ONLY
> 
> 
> s/BR/B/
> 
> see groff_man(7):
> 
> [
> 	[...]
> 
>        .B [text]
>               Set text in bold.  If the macro is given no  argu‐
>               ments,  the  text of the next input line is set in
>               bold.
> 
> 	[...]
> 
>        .BR bold‐text roman‐text ...
>               Set each argument in bold and roman, alternately.
> ]
> 
> > +This is an userfaultfd specific flag that was introduced since Linux 5.11.
> > +When set, the userfaultfd object will only be able to handle page faults
> > +originated from the userspace on the registered regions.
> > +When a kernel originated fault was triggered on the registered range with
> > +this userfaultfd, a
> > +.BR SIGBUS
> 
> s/BR/B/

Thanks Alex, I'll fix and repost the patchset soon.

-- 
Peter Xu

