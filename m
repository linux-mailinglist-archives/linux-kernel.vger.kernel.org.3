Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5264C7D33
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiB1WTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiB1WTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:19:34 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFA0E59
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:18:53 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id d3so15082819qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vHUXjjTOJUnOVh1KjSSIc8DhEaoa5c6bb68ulmkm40Y=;
        b=P7zhWVDCSnLZdcQ2e6MPj5NNLpPZLLEt8iJEHFp7I8u6/+H0vsWzzFJvFKyiiID++v
         krE9xYrleurtAkMLLo2huDhAb9UD0oVHwbIDY59bfh41YdKrZt/1teH8vej2w1uO/O+h
         XcQkww3P2wAE16mk5ej3juPjdW+k9gExxVaqhaBuxTf8EhboWRBhCWZbzpU0DrjOc8yN
         XdMPcXIaYlbDJs7+SNkVGe1B520xdgE1Viic+deWLHBlMBSds2Jd/wQSJ3h/Cl94IOKX
         UQgk5S7KKncvnYEBY1OcH1OysRKzBTRgB+DCDrbfCVlGZ0fQh5qVbNjgWysZM1rYG8YO
         8dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=vHUXjjTOJUnOVh1KjSSIc8DhEaoa5c6bb68ulmkm40Y=;
        b=Ngr3cS1vHbBYLl4WaiX39tZO6tO+lwohVIP1r6ZQ8OVKg23AIPSdhfnGDolnkhVvD5
         HB3fWeysFsyLwUaAXFadq+B/kAWp810DdOOe+2TBR8XtwVQZ/gX9mqOuU9MbKBGzvqII
         1EWAlRChJ9/seO6y/A0CVDB0PofESxCmgim9vW3iO/BoDphzMHJvtHNdVJfTm6l1WVjF
         yl4kCD3x+suYUzgsZ3WM4QqUgfelLi0rnynue7Snown6+s6jO58/kMpvcTqjyxIU8rLe
         ilg3gYs1M7VPf4gAQYUw/uZ49jlQgj2P88ORVLOPG1lk6eC4g+U7l4dsgF2bRDnMH1nL
         wavw==
X-Gm-Message-State: AOAM530uc2o+4UYezc2rrOiU9gDBtkt1p3VfhnYs5xHnaUgBG8hH+6Pz
        yvY6gVNi+/jG5dYS1vzTa1eG0w==
X-Google-Smtp-Source: ABdhPJyoVikr3UJTRFDWLmqDfQ88YTQLK4od5iytOTtG7b0JdZ15w6l9iemdwtmiLXnPEfiu6J3o8Q==
X-Received: by 2002:a0c:be89:0:b0:42c:38b2:9d17 with SMTP id n9-20020a0cbe89000000b0042c38b29d17mr15427630qvi.50.1646086732747;
        Mon, 28 Feb 2022 14:18:52 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h17-20020ac87d51000000b002de919e3187sm7965329qtb.28.2022.02.28.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:18:52 -0800 (PST)
Date:   Mon, 28 Feb 2022 14:18:39 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next] mm/migrate: fix remove_migration_pte() of hugetlb
 entry
In-Reply-To: <Yh01WH6CdHjpUFkZ@casper.infradead.org>
Message-ID: <561c5d85-93fa-3926-2d3d-30f83e99ab5c@google.com>
References: <bd28ebcf-4d42-7184-8189-ffed6fe7d4dc@google.com> <Yh01WH6CdHjpUFkZ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022, Matthew Wilcox wrote:
> On Sat, Feb 26, 2022 at 06:25:15PM -0800, Hugh Dickins wrote:
> > -		if (!folio_test_ksm(folio))
> > +		/* Skip call in common case, plus .pgoff is invalid for KSM */
> > +		if (pvmw.nr_pages != 1 && !folio_test_hugetlb(folio))
> >  			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
> 
> How do you feel about this instead?
> 
> -               if (!folio_test_ksm(folio))
> +               /* pgoff is invalid for ksm pages, but they are never large */
> +               if (folio_test_large(folio) && !folio_test_hugetlb(folio))
>                         idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
> 

That looks nicer to me too.  I'll assume that's what you will add
or squash in your tree, and no need for me to resend - thanks.

Hugh
