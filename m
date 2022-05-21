Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7E52F837
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbiEUEDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiEUEDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:03:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9431900ED
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:03:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f10so9547366pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fw+9k+RnzUdOacTuaz/2j5XVrSJD0gKIR+hhJAPt2rA=;
        b=a7xYu2hI6iKpPF1XVlxTD+jspQwjfMuNseZfLel4/ieTzTjspooPD0zcJg7mO6AsK8
         yRzFNmVHi+PdtQ1YHNaLDhe07dQvIGp7b7DZ7DbulB4mZuvtrowtfzWCJt650uDYd9Tx
         CbHKBzCQ0XekpzIXOGbU0tozG99YJlajFJZ4nvHOJymtNdLj4UXV6qdZ2mFXt3ettilA
         WqBuE97cR/8I69YuMpVNPt3fpWV/4YUfKO8Lds1CQ23gv2vZgGVF/a0ly6IsjRrG/Ngx
         6BkBVCgJBCoAFQDS5Y5uGHTd+d2g3TxGmSeslDLaQ0sdNLmV2jc+TmasFRh9TASwRUr1
         9PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fw+9k+RnzUdOacTuaz/2j5XVrSJD0gKIR+hhJAPt2rA=;
        b=hwj14tRlsmQxMi5OCGVztotHOEsQgs92/95+mRf4aQq9/Qlu1xqGYk/Tid4EkYsOb4
         c3NYgfsYkQdwsKCAuzspgx5er6j6hBuyoSxrVncRgK4tEngz7zWvVGgGAYiZWJHQunE1
         CLWYOmTNZtLQNgUja1yeiwcyFKoui+zLPOV8CWyenCwHS2PIBovKQf/BGtWnImXj0xBb
         dUjMt5KMOwTDdKT5wt9+v4ws7vyWGD18a/GGQ52ojYU8bdrjoAl0wuH5Gb2eZ6QeHxz+
         zqJBCOIEiUqcR7BU2w7cKQemKYNX8Hs/e7eInWiwrc+3PtvwFQlNWB8z5o2+LMiMiNpS
         Jt9w==
X-Gm-Message-State: AOAM530UsQaAr9znWk6Hti4E/hVbOQw26L7A5j2iO+AoOrNVL0SWobBV
        KkbinPoRTNegNDGWdPZNEO4t1ORxWyYrlA==
X-Google-Smtp-Source: ABdhPJzUE7HriFIxZCxCeoULnMIHDteUO4LCsSJP/XwPtxwFSuD5CG82+usHSZqbUYzC/nCLhNaAdg==
X-Received: by 2002:a17:90b:1b03:b0:1dc:9dc9:2eec with SMTP id nu3-20020a17090b1b0300b001dc9dc92eecmr14495390pjb.37.1653105789578;
        Fri, 20 May 2022 21:03:09 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-15d4-84b3-8c62-a0b8-199e.dynamic-ip6.hinet.net. [2001:b011:20e0:15d4:84b3:8c62:a0b8:199e])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902760b00b0015eaa9aee50sm479287pll.202.2022.05.20.21.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 21:03:09 -0700 (PDT)
Date:   Sat, 21 May 2022 12:03:01 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 3/6] mm, pgtable: Add ownership for the PTE table
Message-ID: <20220521040301.GA1508050@strix-laptop>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <20220519183127.3909598-4-shiyn.lin@gmail.com>
 <0c997fad-ec93-7531-f1c6-29e33f310ebd@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c997fad-ec93-7531-f1c6-29e33f310ebd@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:15:12PM +0000, Christophe Leroy wrote:
> > +static inline bool cow_pte_owner_is_same(pmd_t *pmd, pmd_t *owner)
> > +{
> > +       return (smp_load_acquire(&pmd_page(*pmd)->cow_pte_owner) == owner) ?
> > +               true : false;

Why I wrote like this. ;-)

> 
> The above seems uggly, the following should be equivalent :
> 
> 	return smp_load_acquire(&pmd_page(*pmd)->cow_pte_owner) == owner;
> 

Thanks.
