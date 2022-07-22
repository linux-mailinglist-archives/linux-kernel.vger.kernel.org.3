Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6B57E280
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiGVNoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB7105A164
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658497490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWRpA1oxrDhiiXkeV9SXJ/F3tpuLhpf/KYwSClNmv+Q=;
        b=Uusg2UMZY1fOiOM3HjpP07qPeiB9sVa3K0WsCPdp5jCn0boeUXWBCBpNpY3JJgOG3in3P7
        9+ZR8yJQyozqfFZbxNp2gvx0tC8j11M9ljjFSmb5ZqyekNVD8vthnGXMc7XL7i/cu4CNaG
        4gwBeGv9T9+DuaA9tcmciUCRQ6xP2+E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-YKXp6rfQNpykicoH6ZEmUQ-1; Fri, 22 Jul 2022 09:44:49 -0400
X-MC-Unique: YKXp6rfQNpykicoH6ZEmUQ-1
Received: by mail-qv1-f69.google.com with SMTP id p6-20020a0c8c86000000b004731e63c75bso3060661qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dWRpA1oxrDhiiXkeV9SXJ/F3tpuLhpf/KYwSClNmv+Q=;
        b=R4qti0QSuT1fkyXjZosdPuYW5I103RXtiykTL+ivt8b1hQI4PM07IQ+nLeYn35eaTc
         x/lixE1dcidOtkUqw/mOGR+wcs1OSnWDf03zLz/JoLWWl1C6V60K+utX/cXOarxLItyl
         JPRDEXCsDJS6jFkthOz2yBtvmHZFnkJmG2z2l0vwJtFQ+ywtZk/c+jKr56yXjk34Bpcy
         EE1FC5ePC+AaEf8CLd2g8MGYR7U0O1TjpXIlHD/+SObU/mDQqdo6x/xvltYuCTev4htX
         G91KioprusStZ7HYDKzGawzDLkqVom+kcow1JGLw5H78/wQ7ih+8v0n63r7AAySAHmMz
         L6ZQ==
X-Gm-Message-State: AJIora+Y9F/tRQOfnRv5ihLZqCHuwxNy+PRem2ZrqLEsKT10p/UobSpB
        DLzQ0BAJ/PDkAqoI6wSkR7bp82JJLB7gNubuX83uxPdCDQxy+LjU/P3/GygEQI5uTDIU4/OlLGG
        wfF4CI7o/tUg5tuGG5sAZuyB1
X-Received: by 2002:a05:622a:1348:b0:31f:f43:7b0 with SMTP id w8-20020a05622a134800b0031f0f4307b0mr104023qtk.542.1658497489252;
        Fri, 22 Jul 2022 06:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vKzrn573LpWJtRxxYtx4oCk45bHJ2Ynw6wt+cSmM7wiFCel74/dsXZJXHafRdPD13PIVMvKg==
X-Received: by 2002:a05:622a:1348:b0:31f:f43:7b0 with SMTP id w8-20020a05622a134800b0031f0f4307b0mr104007qtk.542.1658497489026;
        Fri, 22 Jul 2022 06:44:49 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id m12-20020a05620a290c00b006b5d9a1d326sm3784492qkp.83.2022.07.22.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:44:48 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:44:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 2/3] selftests: soft-dirty: Add test for mprotect
Message-ID: <Ytqpz03yRq+DlAdq@xz-m1.local>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-3-peterx@redhat.com>
 <8fbbd68f-267c-1e0d-a578-7da4551c4c19@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fbbd68f-267c-1e0d-a578-7da4551c4c19@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 09:17:34AM +0200, David Hildenbrand wrote:
> On 21.07.22 20:33, Peter Xu wrote:
> > Add two soft-diryt test cases for mprotect() on both anon or file.
> 
> s/soft-diryt/soft-dirty/

Fixed.

> 
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tools/testing/selftests/vm/soft-dirty.c | 69 ++++++++++++++++++++++++-
> >  1 file changed, 68 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
> > index 08ab62a4a9d0..7d93906aa43f 100644
> > --- a/tools/testing/selftests/vm/soft-dirty.c
> > +++ b/tools/testing/selftests/vm/soft-dirty.c
> > @@ -121,13 +121,78 @@ static void test_hugepage(int pagemap_fd, int pagesize)
> >  	free(map);
> >  }
> >  
> > +static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
> > +{
> > +	const char *type[] = {"file", "anon"};
> > +	const char *fname = "./soft-dirty-test-file";
> > +	int test_fd;
> > +	char *map;
> 
> Instead of fname, unlink, open, close, unlink  you can use a tmpfile
> 
> FILE *file;
> 
> file = tmpfile();
> if (!file) {
> 	ksft_test_result_fail("tmpfile() failed\n");
> 	return;
> }
> test_fd = fileno(file);

Note that tmpfile() should by default fetch from /tmp which is very
possibly a tmpfs afaict.  It's tricky in this special test case since I
don't think tmpfs can trigger this bug (shmem doesn't define page_mkwrite).

I wanted to create under this dir to make the best possible bet to trigger
the bug. E.g. major fs will works like xfs, btrfs, extN.  It'll stop work
if someone clones the Linux repo under tmpfs but it's rare.

> 
> > +
> > +	if (anon) {
> > +		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
> > +			   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> > +		if (!map)
> > +			ksft_exit_fail_msg("anon mmap failed\n");
> > +	} else {
> > +		unlink(fname);
> > +		test_fd = open(fname, O_RDWR | O_CREAT);
> > +		if (test_fd < 0) {
> > +			ksft_test_result_skip("Test %s huge page allocation\n", __func__);
> 
> Wrong copy-paste I assume :)

Yeh :) I'll fix it.

> 
> > +			return;
> > +		}
> > +		ftruncate(test_fd, pagesize);
> > +		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
> > +			   MAP_SHARED, test_fd, 0);
> > +		if (!map)
> > +			ksft_exit_fail_msg("file mmap failed\n");
> > +	}
> > +
> 
> Apart from that LGTM.

Thanks,

-- 
Peter Xu

