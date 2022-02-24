Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E994C33FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiBXRs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBXRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:48:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716BB1B4012
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:48:24 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m14so5209793lfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V24rdVNExs0ytTjnUGhgxI/0/+mvlDmfxrFtfTJbU7k=;
        b=MqCTqeHdkuXEQpvlJXoh1OEtSmCm3/vJpMIdKfSRYxXCnRpR9JWvac/hzemxQZ3MD0
         Kzi9XUTdpnPdGHtDJfxWlY38lY9yU59vtizG+bwXlKZ2nQuR3bn/Qa98DqRJsct4Mv7/
         z9sDCGNQjAGR6Nt543jn58ZCWn14cODxguj6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V24rdVNExs0ytTjnUGhgxI/0/+mvlDmfxrFtfTJbU7k=;
        b=fd/Gg1XK9WBdQ0M3SL9D0UMKC8yvOemIcd5lFADT9BLtCTCvpSaYz12kAwL41H0xX7
         SUbChTzYQLRz6bqZ7ERCiqOPs2NSAESTDFA8jINTJaTOVxjivkqsJiUMRIJYmCMN97hi
         ZPQJQIOa/qRg38feT8CWNt23dYxlud+NLwdZIaDWpqY4Zo9sHjH2rNrygCUwt03N7rCr
         mdrByPn2BSpvkf/o2MmqWYv5PMxYhVYvzgy3h5nQJQ7uVfRHCC3mgD0sKHjOpE3Ys4uO
         hNyF3yNeXqE27buyM63cLEMED1ci1Um1eDSSQUVbaqhM2E2+sVWFbRo4aw3gEpkModq3
         uU2w==
X-Gm-Message-State: AOAM532+E4Li2vQxJ+dEEMnC7aF1ZueJ3DQkQGhtkY4ZysMmcuKpMlg3
        kJyL8nb5LiYQTC+PhfBp3YWQgTizPRwYklWKMhs=
X-Google-Smtp-Source: ABdhPJxUVYr1jS4Jwk+ZkNs05S6ghU386lbZBbZp9cVbofs1HI5h3VZqogR0cUcyLSXA+L4xZZaMOw==
X-Received: by 2002:a05:6512:1597:b0:443:bd68:6a70 with SMTP id bp23-20020a056512159700b00443bd686a70mr2470242lfb.548.1645724902523;
        Thu, 24 Feb 2022 09:48:22 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id r9sm257790lfp.84.2022.02.24.09.48.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 09:48:21 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id j7so5207000lfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:48:21 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr2497656lfb.687.1645724900775; Thu, 24
 Feb 2022 09:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20220224122614.94921-1-david@redhat.com> <20220224122614.94921-6-david@redhat.com>
 <CAHk-=wh+NxEVxeKc_o1xyVsJAQNqpN1zyCHN96gPEK+DzXaeLw@mail.gmail.com> <064ba776-e6c6-a430-7d74-0b691123e2a9@redhat.com>
In-Reply-To: <064ba776-e6c6-a430-7d74-0b691123e2a9@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Feb 2022 09:48:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkO8w6YFbn8YsvwxgDi_pyUeKTCEgncDAzV6_kcqRJMw@mail.gmail.com>
Message-ID: <CAHk-=whkO8w6YFbn8YsvwxgDi_pyUeKTCEgncDAzV6_kcqRJMw@mail.gmail.com>
Subject: Re: [PATCH RFC 05/13] mm/rmap: remove do_page_add_anon_rmap()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 9:41 AM David Hildenbrand <david@redhat.com> wrote:
>
> Actually, I thought about doing it similarly to what I did in
> page_alloc.c with fpi_t:
>
> typedef int __bitwise fpi_t;
>
> #define FPI_NONE                ((__force fpi_t)0)
>
> I can do something similar here.

Yeah, that looks good. And then the relevant function declarations and
definitions also have that explicit type there instead of 'int', which
adds a bit more documentation for people grepping for use.

Thanks,
               Linus
