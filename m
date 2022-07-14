Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0E575235
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbiGNPwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGNPwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E661432BBA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657813942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QnSTyq0AylqMXq4K0qB4+ue2ifzFVZLJmilkj7YD2xE=;
        b=MNdcKSbmuNkb+paykaRWHEmgghrvRSq4sMVmkYabNzQ8AvMAarBbwFDnVgp8voavg1fUl/
        WvPvUf/YttgZlhdDrTuBqA0T3b6NwS6B+YJ0KchBwaiugwLWcUpYsYWK2c2Vo1twY5CaKW
        1E7T9i+rTtyn09rMIFe04IfsyM1qD1A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-laA4m1ukMpawWTwpxBDCCw-1; Thu, 14 Jul 2022 11:52:20 -0400
X-MC-Unique: laA4m1ukMpawWTwpxBDCCw-1
Received: by mail-qk1-f199.google.com with SMTP id bj26-20020a05620a191a00b006b5c4e2dc77so1112294qkb.16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QnSTyq0AylqMXq4K0qB4+ue2ifzFVZLJmilkj7YD2xE=;
        b=ZopzyfPicdBTnhCRWXFG/6ks30j9oIL3Q+++ZJVOSyeVtViv9+wKUx/PWSE3OnaTHr
         8Cv6owjfhKWlECXd/PX+jFEFccYAjmAlrRQq6cisDe1l4utA05JU5d10erpdrwYBcp08
         PhB0RVbliOggRNLvP9yZtv7hCCN3cBiV7yGnBCxexOnL+S7ttFBdpa5u9pSAT/33tAD9
         HBdLcht3GqgnFB2+Qo1I4i/N1EYwryi84l66R/qtlbsrF2/zxVNovP4glVjV6gcAtjfd
         Qr/AcUNvK81X7R0y0kPGEMCmc10pCCFzJ7Gh5BecDhTh3NYWn6TliEuK0j4LT1WfYIsC
         pgkA==
X-Gm-Message-State: AJIora8fdvmNK1+KwSRHrdUdR6Y7os3QmIx1967bMWtEC1tJNuqfYUCf
        oc/dQQnDkoKD5leityXxZGT6vrRhLd7onL/bEufHzfm7cGKKWIHEqBISTA74AoaQJSR4gVjX8HM
        3Bfn254840SM1PxkBiQoPeXRj
X-Received: by 2002:ac8:7e8f:0:b0:31e:a1fe:8155 with SMTP id w15-20020ac87e8f000000b0031ea1fe8155mr8770853qtj.220.1657813940129;
        Thu, 14 Jul 2022 08:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vscvtjLlw9+LwIcRwHiRW7/eS0T9+SZJaDkhtI4LvxGkVEj8NAm3X9xDVftNhWtS+fSLYEcg==
X-Received: by 2002:ac8:7e8f:0:b0:31e:a1fe:8155 with SMTP id w15-20020ac87e8f000000b0031ea1fe8155mr8770839qtj.220.1657813939920;
        Thu, 14 Jul 2022 08:52:19 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id j11-20020a05620a288b00b006b5ad8e5c3asm1566084qkp.68.2022.07.14.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:52:19 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:52:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <YtA7svbn4MtuT7qJ@xz-m1.local>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 05:59:53PM +0800, Miaohe Lin wrote:
> On 2022/7/14 1:23, Andrew Morton wrote:
> > On Tue, 12 Jul 2022 21:05:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> > 
> >> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> >> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> >> for them mistakenly because they're not vm_shared. This will corrupt the
> >> page->mapping used by page cache code.
> > 
> > Well that sounds bad.  And theories on why this has gone unnoticed for
> > over a year?  I assume this doesn't have coverage in our selftests?
> 
> As discussed in another thread, when minor fault handling is proposed, only
> VM_SHARED vma is expected to be supported. And the test case is also missing.

Yes, after this patch applied it'll be great to have the test case covering
private mappings too.

It's just that it'll be a bit more than setting test_uffdio_minor=1 for
"hugetlb" test.  In hugetlb_allocate_area() we'll need to setup the alias
too for !shared case, it'll be a bit challenging since currently we're
using anonymous hugetlb mappings for private tests, and I'm not sure
whether we'll need the hugetlb path back just like what we have with
"hugetlb_shared" tests.

-- 
Peter Xu

