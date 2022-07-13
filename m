Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF066573AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiGMQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGMQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8CCE3F31B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657728608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALptCerQqkMffu36Xn3Y1CRPKREEsyyCZnU0VjkcIA8=;
        b=ZISh9QhRqp1JgccRy7rKUQCryB8fpJ495DxYYk6FRtmiKWWVZYuLNA/6AZLsz5DQPRTjrG
        Rb3F0LwBj3xYszvhbQtC4073FnnIJHsZLqToruzGcKfGG16ROpePDC0YWh9R1OOq1bMapw
        eZL9OgXCIqKklFg2sCU7Da1oGPIyhuI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-h811g9xnPcSRc82RxScVSQ-1; Wed, 13 Jul 2022 12:10:07 -0400
X-MC-Unique: h811g9xnPcSRc82RxScVSQ-1
Received: by mail-qk1-f199.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so10313906qkp.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ALptCerQqkMffu36Xn3Y1CRPKREEsyyCZnU0VjkcIA8=;
        b=DrPWtTX4LfN/GB5kmugRPZyWz3Tsz3lcfZ4T5brBefY5yMo4eofomDofyzay6cT26T
         LTmmqHQr6/IsTw8onXuIC3CDZ6+qjcPf8SuQJcIRXkhado2gxMao0C1n9d3HKPtPd6a7
         9pIM3Vx97ZzNeiJyaBwJgz2zlgWgoovcdkOhlp3IKhlBw9w8pZUe82+A+bNfgRKDj1qy
         odO4a9PqmpDNNXkiw4vD7nOUCb+5EHwMCBrpKJfpsXHdy0Q7A1u+BOAoqN/JwrDktuLw
         XAG14/LQACwdJ0e2o6Czc7wjB+aARgQ3b65Ppl35hLPLakreR+CiCi8dSZmjX4My7OrU
         L71A==
X-Gm-Message-State: AJIora+oA2fSMIgWe+vYxBQ/cOW7DBGa1SwCsdNe5q9fPb7D3QTRJEuA
        ByR8nzMgEDnZxah9m0UfktNMJcBOl5rWBKFY5ve0ndm5LJ74X5fqGeTdbmtmSVGnJD3NHoJPNGm
        ug2g3aceNfokx37gyvIP+0nRV
X-Received: by 2002:a05:6214:c25:b0:473:2d88:f5ff with SMTP id a5-20020a0562140c2500b004732d88f5ffmr3632131qvd.101.1657728606568;
        Wed, 13 Jul 2022 09:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ul8BHSr77/iJFk9nlXeEoWmuR1sG3gYIi/uhiQ+9E69TxeU4UQI0JQyBlX4q1QqaFd6aVA6Q==
X-Received: by 2002:a05:6214:c25:b0:473:2d88:f5ff with SMTP id a5-20020a0562140c2500b004732d88f5ffmr3632091qvd.101.1657728606154;
        Wed, 13 Jul 2022 09:10:06 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006af20edff0csm12064402qko.58.2022.07.13.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 09:10:05 -0700 (PDT)
Date:   Wed, 13 Jul 2022 12:10:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <Ys7uXHdzzFezUub5@xz-m1.local>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <Ys2xyCUnqpJt0eIo@monkey>
 <Ys7ViSsOxLaQJIfy@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ys7ViSsOxLaQJIfy@xz-m1.local>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:24:09AM -0400, Peter Xu wrote:
> On Tue, Jul 12, 2022 at 10:39:20AM -0700, Mike Kravetz wrote:
> > On 07/12/22 21:05, Miaohe Lin wrote:
> > > In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> > > cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> > > for them mistakenly because they're not vm_shared. This will corrupt the
> > > page->mapping used by page cache code.
> > > 
> > > Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
> > > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > > ---
> > >  mm/hugetlb.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > This looks correct to me.
> > 
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > However, I am having a hard time wrapping my head around how UFFDIO_CONTINUE
> > should work on non-anon private mappings.  For example, a private mapping of
> > a hugetlbfs file.  I think we just map the page in the file/cache and do not
> > set the write bit in the pte.  So, yes we would want page_dup_file_rmap()
> > in this case as shown below.
> > 
> > Adding Axel and Peter on Cc: as they were more involved in adding that code
> > and the design of UFFDIO_CONTINUE.
> 
> Yes the change makes sense to me too.  There's just one thing to check on
> whether minor mode should support private mappings at all as it's probably
> not in the major goal of when it's proposed.
> 
> I don't see why it can't logically, but I think we should have failed the
> uffdio-register already somewhere before when the vma was private and
> registered with minor mode.  It's just that I cannot quickly find it in the
> code anywhere..  ideally it should be checked in vma_can_userfault() but it
> seems not.
> 
> Axel?
> 
> PS: the minor mode man page update seems to be still missing.

Oh I should have done a pull first on the man-page repo..

From the man page indeed I didn't see anything mentioned on not allowing
private mappings.  There's the example given on using two mappings for
modifying pages but logically that applies to private mappings too - we
could have mapped the uffd region with private mappings but the other one
shared, then we can modify page caches but later after pte installed it'll
trigger cow for writes.

So I think we need to confirm whether private mappings are supported. If
no, we should be crystal clear in both the code and man page (we probably
want a follow up patch to man-page to mention that too?).  If yes, we'll
need Miaohe's patch and also make sure they're enabled in the current code
path.  We'll also want to set test_uffdio_minor=1 for "hugetlb" test case
in the userfaultfd kselftest (currently it's not there).

-- 
Peter Xu

