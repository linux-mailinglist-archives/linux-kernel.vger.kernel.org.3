Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7298857E31C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiGVOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVOhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 252529CE36
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658500672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ohc3kb+5sh97VKjw963CFQ/bL+NxbyXfHznntP09rEk=;
        b=duZXX0QauSCX3kCjs0MhGy36wYS0HGgP3RjVpYbe4rU5uEFUJJTZzQu9hr/3XZ98YQ8wKd
        yqmYpsGsLuWrijuLUeJhBaRINBwFB8PKRbidwUgEQOLV7InA2GWErM1zh724zidePUYv5G
        q2SUE2TDgg2EXJcpS01NyLzNHS/Jh5g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-QyOYE7KOOgO_JAzjEYeDcw-1; Fri, 22 Jul 2022 10:37:51 -0400
X-MC-Unique: QyOYE7KOOgO_JAzjEYeDcw-1
Received: by mail-qt1-f197.google.com with SMTP id cf20-20020a05622a401400b0031efad5abb9so2978910qtb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ohc3kb+5sh97VKjw963CFQ/bL+NxbyXfHznntP09rEk=;
        b=LO0scwPGqy0vZmJIoiy0FdI1YqlyxZ7gysGrb+P/To/qLctEV3e8izEDzEwO1ro+Y0
         wEE2KxDKIA3iVU5rd/FrtDFvChoy9fcQz7Y8jMAO1WJXE5JK1qWWf96QuHtqNkZjSPRv
         2lKxgkEh4IkfHX26kJWMkdY/mBGHxTSXKB8goJu78ZGeatr3yVqln0he5lgblzis4E5X
         1pDKSSxdls0zRQ4tjG0+V+Y2L4nVE6QqoX8w0kcE78cz998Tem8rNePiGJ8g6++X4OBy
         /RpkTZVtgkqjqXkbLj0JiMWRhakHKfFrXKE0dRYJ0gr0dxn8zFL5kE8c5pn8M54iZGgq
         WAfg==
X-Gm-Message-State: AJIora9IYIXjiVziT8zNu3VS2JdDRe531FuzIv3x+oDG0r2HU+Xn15Rr
        pFjxwe9Op9IW+cBeXjIxgc8ip/qWcXFKu4OMmBRNylYIH7RK1dIyrCLMWoDu06kuvTaGoYldAJc
        L7wHn05Eqd0ysZreDld5wqjic
X-Received: by 2002:a05:6214:2a8b:b0:474:12b7:cbd0 with SMTP id jr11-20020a0562142a8b00b0047412b7cbd0mr28544qvb.71.1658500670498;
        Fri, 22 Jul 2022 07:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tjxyA5msGHb80FzFz76BDJQcSuhv9BvR1xBTaQaopVX7yJzNRtqri01j3/12Fwzi/+ng4GWQ==
X-Received: by 2002:a05:6214:2a8b:b0:474:12b7:cbd0 with SMTP id jr11-20020a0562142a8b00b0047412b7cbd0mr28522qvb.71.1658500670279;
        Fri, 22 Jul 2022 07:37:50 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id y8-20020a05620a44c800b006b5c5987ff2sm3834567qkp.96.2022.07.22.07.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 07:37:49 -0700 (PDT)
Date:   Fri, 22 Jul 2022 10:37:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 2/3] selftests: soft-dirty: Add test for mprotect
Message-ID: <Ytq2PNY81igrSC/y@xz-m1.local>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-3-peterx@redhat.com>
 <8fbbd68f-267c-1e0d-a578-7da4551c4c19@redhat.com>
 <Ytqpz03yRq+DlAdq@xz-m1.local>
 <8fd4d9fa-7370-3d97-20d0-a4dfed914600@redhat.com>
 <5d6c745e-219c-3abf-a30d-b3fb8e8e752c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d6c745e-219c-3abf-a30d-b3fb8e8e752c@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 04:07:47PM +0200, David Hildenbrand wrote:
> On 22.07.22 16:00, David Hildenbrand wrote:
> > On 22.07.22 15:44, Peter Xu wrote:
> >> On Fri, Jul 22, 2022 at 09:17:34AM +0200, David Hildenbrand wrote:
> >>> On 21.07.22 20:33, Peter Xu wrote:
> >>>> Add two soft-diryt test cases for mprotect() on both anon or file.
> >>>
> >>> s/soft-diryt/soft-dirty/
> >>
> >> Fixed.
> >>
> >>>
> >>>>
> >>>> Signed-off-by: Peter Xu <peterx@redhat.com>
> >>>> ---
> >>>>  tools/testing/selftests/vm/soft-dirty.c | 69 ++++++++++++++++++++++++-
> >>>>  1 file changed, 68 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
> >>>> index 08ab62a4a9d0..7d93906aa43f 100644
> >>>> --- a/tools/testing/selftests/vm/soft-dirty.c
> >>>> +++ b/tools/testing/selftests/vm/soft-dirty.c
> >>>> @@ -121,13 +121,78 @@ static void test_hugepage(int pagemap_fd, int pagesize)
> >>>>  	free(map);
> >>>>  }
> >>>>  
> >>>> +static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
> >>>> +{
> >>>> +	const char *type[] = {"file", "anon"};
> >>>> +	const char *fname = "./soft-dirty-test-file";
> >>>> +	int test_fd;
> >>>> +	char *map;
> >>>
> >>> Instead of fname, unlink, open, close, unlink  you can use a tmpfile
> >>>
> >>> FILE *file;
> >>>
> >>> file = tmpfile();
> >>> if (!file) {
> >>> 	ksft_test_result_fail("tmpfile() failed\n");
> >>> 	return;
> >>> }
> >>> test_fd = fileno(file);
> >>
> >> Note that tmpfile() should by default fetch from /tmp which is very
> >> possibly a tmpfs afaict.  It's tricky in this special test case since I
> >> don't think tmpfs can trigger this bug (shmem doesn't define page_mkwrite).
> >>
> > 
> > I don't think we need that? SOFTDIRTY tracking enabled should be
> > sufficient, or what am I missing?
> > 
> 
> I think you're right that it doesn't work with tmpfile. I do wonder why,
> because I'd have thought that it's sufficient for
> vma_wants_writenotify() to return "1" due to the
> vma_soft_dirty_enabled() check.

I can't say I know the whole rational of this, but I think it's below that
will start to return 0 already before the soft-dirty check:

	if (pgprot_val(vm_page_prot) !=
	    pgprot_val(vm_pgprot_modify(vm_page_prot, vm_flags)))
		return 0;

in vma_wants_writenotify().

-- 
Peter Xu

