Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83858CF35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiHHUeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244415AbiHHUdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 510451ADAC
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659990821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ea76KkDPy+XmKYbBY0DOWfRlSGynmdc1QDoDNUmZ0A=;
        b=Dr4+Pp+30T+9j2x7fUSFMbU6kmH4pNUCe5o3fsbeHc5uw7G7aS0vCd4B2comOjBv6M+Z7s
        bOdUMmBF5yYQFtnDZ71foNhQ+L/+wdL4JHoec5It1/pyvxQ7kZSNvXtNPOJ0ouQDcI0zK5
        GYS4K9loYlTTiEm212FOB+3XikYmIBc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-FlGcbQ-rNiGQRM_7LA-rKQ-1; Mon, 08 Aug 2022 16:33:40 -0400
X-MC-Unique: FlGcbQ-rNiGQRM_7LA-rKQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-32851d0f8beso86504687b3.22
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/Ea76KkDPy+XmKYbBY0DOWfRlSGynmdc1QDoDNUmZ0A=;
        b=p2VW4zzaSa273IumbfJabplQZSuwHjUhhXp+4/jA+z6hVZz8iM3r3BQ/EXzQN2cw+x
         ujgT+V0f3jksQxewQ3gPaKQ9nCnT4Gq8meEC7YV23yv2LXsr6N8rtD+mHb68uu/YPvBo
         lq3sAbUUFNpqiHrXjLou8ZHpHEOb4Z7DIo9rPYC6s2TIERc7ViK5xGgTgxRzyvTtzJFY
         psU8HpoomJfqar5anDLDHt6z6tb5dTdV0ImdJ9XKQ4OZtpS2V/SrZQSlqmweoVb8CCF3
         yXXAt7jJQl6qac+5l1ufdZtvt7Fne/eIy4t2ZsFRjw3ofptbhmVqnJzwVx89UD+nNk2L
         iOTA==
X-Gm-Message-State: ACgBeo3pe6FsgtMn6AfbM08LiUwSXkgEpH0RK6hPZN+xD3GDZ1B9undf
        DC63AeCE+9ZghsafzsB5DFTtaRm/cHwPYtFabARzdoIK2dva8aUPAkyhJ4V97XX7OR7HLAxm1Nm
        7Q9ypMaEqDn4YLyl4wieh6yC5mlOgLui4gXvI5nVS
X-Received: by 2002:a25:8892:0:b0:66e:fe43:5aa0 with SMTP id d18-20020a258892000000b0066efe435aa0mr17051935ybl.445.1659990819610;
        Mon, 08 Aug 2022 13:33:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ZXzN9+iHEgTC0x/lrkgV55nPFDHDX0tIkjkhxvIaG/iK1hmM0lCVP3TqfIGsjp8NRc1jxC2ODvgz+XkxrDzk=
X-Received: by 2002:a25:8892:0:b0:66e:fe43:5aa0 with SMTP id
 d18-20020a258892000000b0066efe435aa0mr17051918ybl.445.1659990819353; Mon, 08
 Aug 2022 13:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNtNjQLpzu4CFiMawfkKeVFULw4ti3MdZL1QejPrzeJv8Q@mail.gmail.com>
 <20220808150657.liop7yf5hsutbpp3@revolver> <20220808195146.im4diqaqnmxkzo5t@revolver>
In-Reply-To: <20220808195146.im4diqaqnmxkzo5t@revolver>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 8 Aug 2022 22:33:27 +0200
Message-ID: <CAFqZXNs6b=0tn9ghT985_wBBehG7uhRvrcFB_i9RXByuRjsa-g@mail.gmail.com>
Subject: Re: Binder regression caused by commit a43cfc87caaf
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 9:52 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [220808 11:07]:
> > * Ondrej Mosnacek <omosnace@redhat.com> [220808 06:13]:
> > > Hello,
> > >
> > > FYI, since commit a43cfc87caaf ("android: binder: stop saving a
> > > pointer to the VMA") (found by git bisect) the binder test in
> > > selinux-testsuite [1] started to trigger a lockdep assert BUG() in
> > > find_vma() - see the end of [2] for an example.
> > >
> > > A minimal reproducer is:
> > > ```
> > > git clone https://github.com/SELinuxProject/selinux-testsuite.git
> > > cd selinux-testsuite/tests/binder
> > > make
> > > setenforce 0  # if SELinux is enabled
> > > ./init_binder.sh || true
> > > ./manager -n -v & sleep 2
> > > ./service_provider -n -v
> > > ```
> > > Requires the equivalent of libselinux-devel, make, gcc, and git-core
> > > Fedora packages.
> > > The last command will trigger the BUG; on good kernels it will
> > > successfully enter the ioctl loop.
> > >
> > > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > > [2] https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/08/07/redhat:606549366/build_x86_64_redhat:606549366_x86_64/tests/5/results_0001/console.log/console.log
> > >
> >
> > Thanks.  It looks like binder has some paths that are not taking the
> > necessary mmap lock for using VMAs.  I'm looking into it now.
>
> This does not fail for me, are you sure this is the reproducer?  I see
> the manager and service_provider communicate.
>
> Looking at your trace and the code, the bug makes sense and I have
> something that will probably fix the issue, but I'd like to verify.

Hm... it seems it is necessary to have CONFIG_DEBUG_VM=y for the
particular debug check to be active. I guess you don't have that
turned on? It happens to be turned on in Fedora's release kernel, so I
didn't realize there was a specific config dependency.

Thank you for looking into it!

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

