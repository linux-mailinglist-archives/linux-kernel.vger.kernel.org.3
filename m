Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94D84F5286
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiDFCyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839754AbiDFBFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 21:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18EF122C8D9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649199756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJmB3NyGHJPctZ5Tp6VQA6j7TxUED1zTYueXlEtvASc=;
        b=Pr+WOuJpeivT/mrGIod9jIPKj950xIQds6vH7Q7Kgd0EXV834PoE4nJHKJ0Bbi3F9zWgMW
        2Hr9elWZ4yIJr/s7aTsGE6DZ9R4sM3oPz8uWQ+OLHuhqMAu+xq8ZuIcXyXhdcJ3NM1OBOe
        ZEdVgcVqkVRJArdf6ucTfiaNgs2E5pE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-9s39xV1AP6GmXI42-iS1pw-1; Tue, 05 Apr 2022 19:02:35 -0400
X-MC-Unique: 9s39xV1AP6GmXI42-iS1pw-1
Received: by mail-il1-f198.google.com with SMTP id y19-20020a056e02119300b002c2d3ef05bfso557162ili.18
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 16:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJmB3NyGHJPctZ5Tp6VQA6j7TxUED1zTYueXlEtvASc=;
        b=0vfAqBw0czs+SRIZW7WINjBNDn8VemTeaZHyF+uM3ImC6L4uaEGJ7y3z/6AT6h8oWg
         9do/o6lSAIXG1+5B+8ajiqFS0d+FuZHB7WO7noHYRhv7BMmNyyLPKqhBdPgmJlEJKGOS
         iSseX80oYFESmlAnJLlYWrZ4rb2jihJOQOaN+YlqQvL8h1URjULO07F7cBhb6JIUqvEe
         QUxDrZX+eBQP8slr/W45c1Hk8r/c99/DiKiF7vftO3W96oH27tNSTmM7EFahCxNAVUHH
         pz441Gdr7tGjSazfVDAZZlmXIlAFD412wSsGmvzGGbiX7tETi/XMueaKe5NTe0k6AgKS
         BO9g==
X-Gm-Message-State: AOAM531+ZuEUaC1HCRCoEeTzULRR8gW5ODKhoQ0xNuoipzpN6nQYWeck
        +8JiMtcqOoMjI5Ur998+ExXoVjV8X3wGx6cQTF4BadAFTDYEMHU2myV9y8VD6xL30/Z9/prT+le
        5zMLyzTV4MuG9BsMlGMnjVVnD
X-Received: by 2002:a02:cb4a:0:b0:323:5e9a:255c with SMTP id k10-20020a02cb4a000000b003235e9a255cmr3038732jap.12.1649199754967;
        Tue, 05 Apr 2022 16:02:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+9hSCp/2bZlP91Ebv6INEUuSFgp3H+pRfrTy0zNtLnQiDSpakgEIaIy1Up1k16a9mCzdMNw==
X-Received: by 2002:a02:cb4a:0:b0:323:5e9a:255c with SMTP id k10-20020a02cb4a000000b003235e9a255cmr3038706jap.12.1649199754675;
        Tue, 05 Apr 2022 16:02:34 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id r9-20020a6b6009000000b006412abddbbbsm9285044iog.24.2022.04.05.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 16:02:34 -0700 (PDT)
Date:   Tue, 5 Apr 2022 19:02:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <YkzKiM8tI4+qOfXF@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405151616.bf25fa4aad55536cd031e1ab@linux-foundation.org>
 <YkzF4/e86qwcuXiA@xz-m1.local>
 <20220405154912.4cda03c2cc5d801d25d5c2dd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3ob9n8+f6vq4lAWQ"
Content-Disposition: inline
In-Reply-To: <20220405154912.4cda03c2cc5d801d25d5c2dd@linux-foundation.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ob9n8+f6vq4lAWQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Apr 05, 2022 at 03:49:12PM -0700, Andrew Morton wrote:
> On Tue, 5 Apr 2022 18:42:43 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > On Tue, Apr 05, 2022 at 03:16:16PM -0700, Andrew Morton wrote:
> > > On Mon,  4 Apr 2022 21:46:23 -0400 Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > > This is v8 of the series to add shmem+hugetlbfs support for userfaultfd
> > > > write protection. 
> > > 
> > > Various compilation catastrophes with x86_64 allnoconfig.  I poked at
> > > the include ordering for a while but other things quickly became more
> > > attractive ;)
> > 
> > Sorry about that.  I still don't know what's the problem, but I'll give it
> > a shot soon.
> > 
> > I think I only tried out with the new configs but not all the rest configs.
> > I thought there're some bot looking after that one, from which I used to
> > receive build reports. And IIRC I fixed some build issues in early versions
> > from those reports.  Maybe I was wrong..
> > 
> > Any more hints on the latter?
> 
> `make allnoconfig'?
> 

Ah!  I thought when you mentioned "other things" you meant there're other
more severe issues... :)

For the allnoconfig, could you try with the attached quick fixup (upon
patch "mm/uffd: PTE_MARKER_UFFD_WP")?

That works for me on x86/arm, but I'm still trying out some other configs.

Thanks,

-- 
Peter Xu

--3ob9n8+f6vq4lAWQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-mm-uffd-PTE_MARKER_UFFD_WP.patch"

From 83dbc502eeaba12071413691374474c09e9f24bb Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 5 Apr 2022 19:00:37 -0400
Subject: [PATCH] fixup! mm/uffd: PTE_MARKER_UFFD_WP

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ea11bed9bb7e..732b522bacb7 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -277,8 +277,12 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
 
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
 {
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 	return is_pte_marker_entry(entry) &&
 	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
+#else
+	return false;
+#endif
 }
 
 static inline bool pte_marker_uffd_wp(pte_t pte)
-- 
2.32.0


--3ob9n8+f6vq4lAWQ--

