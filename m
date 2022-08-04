Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C0589E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiHDPDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiHDPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 023245142C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659625387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pekLGGTwGU134kB3IB43TJmHr3pL+ZOzWfhqhMa54MU=;
        b=Nli4dPZJ5Lao3yQu51XIMf2TEf/jx4S8wZLfpvwhRcXTus/myWQ4VZhysU4MxLMDfAvNOb
        F20YgKGXqmeefIgDOKaCB+jWTa6tJcS/9hQ+sgAqkgIlfcGTzS9CeNppi377U5CK6yYt5A
        0UBEPDpXiM/CMty0K8tgbrU2uj1rMAw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-Bji1SXFpMz2v8r-2KkZFnQ-1; Thu, 04 Aug 2022 11:03:03 -0400
X-MC-Unique: Bji1SXFpMz2v8r-2KkZFnQ-1
Received: by mail-qv1-f69.google.com with SMTP id p13-20020ad45f4d000000b0044399a9bb4cso12004585qvg.15
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pekLGGTwGU134kB3IB43TJmHr3pL+ZOzWfhqhMa54MU=;
        b=J0asbNE4CmFmjHm7zvQOJBwF2rBGLrmK0Rk997j6boTjxB+SS2yZ7MX9Mkdxx8eync
         f9FKSUqk+L79JpBdPXdBUqI9AtUEKqwcTohj2/zNUQsFcHAC+uFyJWbofGoEZlsCnX53
         VR2+fnjzyQp6QXWtt7AkZpwz7iseT93QqU5JXTgjoH1ZeH9Zj3WPi5+4Ob5ZihM1W0wL
         slK3Ec6ylGl7xBm3uN7E+YDNP7AYq0pHNLRWS7Hn1kr87JIoOjuXvdQeTLSnGaeGCYDO
         jKIng1cZTVvNcnIEEnmFvno+emy1eJU5isbtX5tvMztbpn5+tTNPWHzuLddfC3Vv9YVo
         bwfA==
X-Gm-Message-State: ACgBeo361HGRmfZQ6S3b0xLiEnHseejFiabNE1Y3lJYht3dJpSR7jJOG
        H/ofmV/fTNgc+e07BHlekX3J5U5O+C/Ph2aJAobyai04/zGAtTOvDAUhHA78jIlNVq16iFMbgEz
        5zHXrKTNDp6w+omRMEarDvRFo
X-Received: by 2002:a05:620a:4154:b0:6b6:145:6c28 with SMTP id k20-20020a05620a415400b006b601456c28mr1624631qko.573.1659625381900;
        Thu, 04 Aug 2022 08:03:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4SnRw3zx1frfS9MHDCpUTfs75xGTCUxzJocWdjVHyndB+Ww02uUX4aInm8ap5i4tebIDZbDg==
X-Received: by 2002:a05:620a:4154:b0:6b6:145:6c28 with SMTP id k20-20020a05620a415400b006b601456c28mr1624591qko.573.1659625381443;
        Thu, 04 Aug 2022 08:03:01 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id u13-20020a37ab0d000000b006b90c318dfdsm491961qke.88.2022.08.04.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 08:03:00 -0700 (PDT)
Date:   Thu, 4 Aug 2022 11:02:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] WARNING in hugetlb_change_protection
Message-ID: <Yuvfox48yeQxQVmm@xz-m1.local>
References: <000000000000098a0105e557f130@google.com>
 <YuqqLfu1E62PqnKS@monkey>
 <YuriiFpv/enJW1oE@xz-m1.local>
 <CACT4Y+ZpLmRLouc+q0vMskPQ0-d5LKKwCoKw-twZ8E9W0vqETg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZpLmRLouc+q0vMskPQ0-d5LKKwCoKw-twZ8E9W0vqETg@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 07:29:56AM +0200, Dmitry Vyukov wrote:
> ,On Wed, 3 Aug 2022 at 23:03, Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Mike,
> >
> > Thanks for forwarding.
> >
> > On Wed, Aug 03, 2022 at 10:02:37AM -0700, Mike Kravetz wrote:
> > > I'll start looking at this, but adding Peter this may be related to his
> > > recent changes.
> > > --
> > > Mike Kravetz
> > >
> > > On 08/03/22 08:32, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    e65c6a46df94 Merge tag 'drm-fixes-2022-07-30' of git://ano..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=139cc282080000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=26034e6fe0075dad
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=824e71311e757a9689ff
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > userspace arch: i386
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 make_pte_marker_entry include/linux/swapops.h:319 [inline]
> >
> > This is the warning code I added to make sure pte marker won't be created
> > if not configured at all:
> >
> > static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> > {
> >         /* This should never be called if !CONFIG_PTE_MARKER */
> >         WARN_ON_ONCE(1);
> >         return swp_entry(0, 0);
> > }
> >
> > The stack below comes from a UFFDIO_WRITEPROTECT, however logically it
> > shouldn't really reach there - if with !PTE_MARKER then it must be with
> > !PTE_MARKER_UFFD_WP, then we should have returned "false" if hugetlb wanted
> > to register with uffd-wp:
> >
> > static inline bool vma_can_userfault(struct vm_area_struct *vma,
> >                                      unsigned long vm_flags)
> > {
> >         if (vm_flags & VM_UFFD_MINOR)
> >                 return is_vm_hugetlb_page(vma) || vma_is_shmem(vma);
> >
> > #ifndef CONFIG_PTE_MARKER_UFFD_WP
> >         /*
> >          * If user requested uffd-wp but not enabled pte markers for
> >          * uffd-wp, then shmem & hugetlbfs are not supported but only
> >          * anonymous.
> >          */
> >         if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
> >                 return false;
> > #endif
> >         return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
> >             vma_is_shmem(vma);
> > }
> >
> > Then the UFFDIO_WRITEPROTECT should have failed already.. at:
> >
> >         if (!userfaultfd_wp(dst_vma))
> >                 goto out_unlock;
> >
> > in mwriteprotect_range().
> >
> > I still have no idea how the bot managed to trigger a real wr-protect upon
> > this vma (which I don't think should have registered with uffd-wp but maybe
> > it can be worked around somehow..).  However to make this even safer we can
> > also guard the pte marker callers with CONFIG_PTE_MARKER_UFFD_WP. Patch
> > attached for that, but since this seems to have no reproducer yet maybe no
> > easy way to verify it.
> >
> > At the meantime, I'd also like to double check the kernel config to make
> > sure CONFIG_PTE_MARKER_UFFD_WP will always be unset when CONFIG_PTE_MARKER=n.
> > Anyone knows where I can fetch the config somewhere?
> 
> Hi Peter,
> 
> If you mean the kernel config for the kernel that produces the
> WARNING, it's in the report above under the "kernel config" link.

Thanks Dmitry. That was a stupid question and Mike helped me to figure it
out..  Somehow I had an impression that config was normally attached to the
end of the email so I didn't try looking upwards. :(

> 
> Note that so far it was triggered only once:
> https://syzkaller.appspot.com/bug?extid=824e71311e757a9689ff
> which may suggest a very narrow race condition.

I found that the config is as expected (PTE_MARKER_UFFD_WP not defined), so
far I still don't know how the race has happened, so maybe the patch
attachd can at least help avoid the warning.  It'll be interesting to know
the race if hopefully it can have a reproducer somehow.

Thanks,

-- 
Peter Xu

