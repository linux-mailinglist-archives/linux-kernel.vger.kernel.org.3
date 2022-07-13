Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B564F5738B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiGMOY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiGMOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59E343120A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657722255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qU+KHYCrnvvC8T5bF7a/9GP4ChOrSrmP53V18b7bwkk=;
        b=Dw6Sg9FbpbrLxgRlKTmpLgG2S6xaaNMe0HXXuDNIeMD+cywWsFrgOVdIzYMKJ5Fs5/Qpz1
        BsJN879gbKskI7XFGxMpu0voRw6dPXOzeLyKP3yFTrENrKOP/YFCpR7wEqG2FoJK9C8COc
        LE1LU8PPl9yh2BXrsXChgjRosmOFkTw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-jKJIcsfCNoyAbaS9erDE-Q-1; Wed, 13 Jul 2022 10:24:13 -0400
X-MC-Unique: jKJIcsfCNoyAbaS9erDE-Q-1
Received: by mail-qv1-f71.google.com with SMTP id ok7-20020a0562143c8700b00472f0b33853so3835410qvb.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qU+KHYCrnvvC8T5bF7a/9GP4ChOrSrmP53V18b7bwkk=;
        b=Xr431p7bxvj3cqKvfcKcL3MlsO4WNdUAup9scG+NmBlSvJVqsVNv4kZ95NBYJ9Q+HU
         ppAEuw222WpNaL3kIF4l54MP2vbSILlqgdqDmIvKJ/aDGR+VmVi9LRbmjrm03BaWblrU
         sCI+k+dNH1KWCcQbSwakyLPFjkrsPcTrTH3wYWBJFhCErW72FzxFbEIAnkiLx2erU+KB
         U9QdMH/Ij6Tgdx+UHpwn4En2DNhaydomSHBWU3+GynIiWpGQsRe06nPPKAkPmg5om9si
         Gukzrskz7G/2jDtWQQGnpbTm9eI19ECXckvvgMXBvfd7fPx7PkDJoALhV37wH1xs/eIY
         P7gQ==
X-Gm-Message-State: AJIora+HiFyhQkSjVQU1XKJOKu+L6WoiGXujGJY5vYscnkCwkyzbYcHM
        s/YVXQaJjD5n9su4YF+rWFssX1YlKP6lMO0wlNrGQ47vurUHVxilC3li3ewYkPgkP7jZ7t++3lR
        GquXi5ukZZDnRWOJEfUBVR3f3
X-Received: by 2002:a05:620a:1404:b0:6b5:a44b:80f8 with SMTP id d4-20020a05620a140400b006b5a44b80f8mr2541021qkj.380.1657722252468;
        Wed, 13 Jul 2022 07:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tGBes8AqdSXg08o3SbPXKt7aSXWfqI0biomEA3nNuTESP6sI6rucDtPB/jonvg9ke07JhCfA==
X-Received: by 2002:a05:620a:1404:b0:6b5:a44b:80f8 with SMTP id d4-20020a05620a140400b006b5a44b80f8mr2541005qkj.380.1657722252224;
        Wed, 13 Jul 2022 07:24:12 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id az30-20020a05620a171e00b006b14b303b37sm11601253qkb.102.2022.07.13.07.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:24:11 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:24:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        songmuchun@bytedance.com,
        Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <Ys7ViSsOxLaQJIfy@xz-m1.local>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <Ys2xyCUnqpJt0eIo@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ys2xyCUnqpJt0eIo@monkey>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 10:39:20AM -0700, Mike Kravetz wrote:
> On 07/12/22 21:05, Miaohe Lin wrote:
> > In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> > cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> > for them mistakenly because they're not vm_shared. This will corrupt the
> > page->mapping used by page cache code.
> > 
> > Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/hugetlb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This looks correct to me.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> However, I am having a hard time wrapping my head around how UFFDIO_CONTINUE
> should work on non-anon private mappings.  For example, a private mapping of
> a hugetlbfs file.  I think we just map the page in the file/cache and do not
> set the write bit in the pte.  So, yes we would want page_dup_file_rmap()
> in this case as shown below.
> 
> Adding Axel and Peter on Cc: as they were more involved in adding that code
> and the design of UFFDIO_CONTINUE.

Yes the change makes sense to me too.  There's just one thing to check on
whether minor mode should support private mappings at all as it's probably
not in the major goal of when it's proposed.

I don't see why it can't logically, but I think we should have failed the
uffdio-register already somewhere before when the vma was private and
registered with minor mode.  It's just that I cannot quickly find it in the
code anywhere..  ideally it should be checked in vma_can_userfault() but it
seems not.

Axel?

PS: the minor mode man page update seems to be still missing.

-- 
Peter Xu

