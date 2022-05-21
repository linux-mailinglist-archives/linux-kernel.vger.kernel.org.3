Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF9552F8D0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 07:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354544AbiEUFBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 01:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiEUFBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:01:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3180C47069
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:01:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso13059631pjj.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MKK5h4+s6saEKrnMUX0ULIBP9+nbNDeGA/d0ZU4yD2Y=;
        b=Rnhi6oydRp7HD3ytZVM3nFHvkOiEYMHx0uEo+RjuoVxIf+NbX07TyDmghNt/PAnfMq
         UGUrm5YOl41w0ZJ5Jtqe9ZMOqYSnYsqV6RyRgPYJfE2f9ulVD+UgwepgRS3x/JegdODS
         nnsVD/CMGWhon2QrAexQ4p18M3+xO3jDz3XkX3B1RO3aKzCLufQMffdi8ZpqvqTBo5mu
         q7M64MfAckjFSEchKy0OFStTs55r2Gm1wjad3mGfm+f97pbpSk/1QHIIK0vptA8gOmsk
         ypSQKzOnE4lDT/LYkyDNGEte+AwNFpw70eP2LMDtGu0UeXOs6IT8ippDufEbkMy8osbH
         PcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MKK5h4+s6saEKrnMUX0ULIBP9+nbNDeGA/d0ZU4yD2Y=;
        b=4AS70Jvw5Fe09PImHzKn0p34QNSRV0MOC9vcmEJw0XNv1khZUVekayOcZWityIooik
         kvFfdRGaFojHie+btaWxpgGXWeX2n+a7XLA9ETdxHzNFgP2tNxmL+UA4JbVqwSRzKnvq
         VuOKXp+l3eWa+xjjGzi/QFvnSS2rBMBZNNclyUQbxTlRISdZtRIHuL5cu1/tyaNuttyr
         N1kK0eHVtvUoChb4JvkPw3hisouAi1sciEKTThMxf80saM6zzjUrApjN3zq8UaEFzMGR
         nAQ9+qwQncIlgnmR4OYf8361kGguQUTBE9gI4VpgImkJ1oYpwSC4xzTL06aP50PBga9X
         sYsA==
X-Gm-Message-State: AOAM530cqraqBkyzlDR+YV+f718qTKkd0wfgsIfobE+NeBZvOxDOsQPK
        RuN+8BhrRZFHfTd+TP2PJWE=
X-Google-Smtp-Source: ABdhPJyNlR34rrPCT7lgQvYZ1DO0X2q6AaRwlKC2QYOi0cOioz3FUX5aj0i8eiYLdtybDDdJTSzxIg==
X-Received: by 2002:a17:90a:2a48:b0:1df:42e6:ff21 with SMTP id d8-20020a17090a2a4800b001df42e6ff21mr14501867pjg.209.1653109301637;
        Fri, 20 May 2022 22:01:41 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-15d4-84b3-8c62-a0b8-199e.dynamic-ip6.hinet.net. [2001:b011:20e0:15d4:84b3:8c62:a0b8:199e])
        by smtp.gmail.com with ESMTPSA id p25-20020a62b819000000b0050dc76281c9sm2602123pfe.163.2022.05.20.22.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 22:01:41 -0700 (PDT)
Date:   Sat, 21 May 2022 13:01:33 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
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
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 3/6] mm, pgtable: Add ownership for the PTE table
Message-ID: <20220521050133.GD1508515@strix-laptop>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <20220519183127.3909598-4-shiyn.lin@gmail.com>
 <YohkY75ekI6vhMYC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YohkY75ekI6vhMYC@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 05:02:43AM +0100, Matthew Wilcox wrote:
> On Fri, May 20, 2022 at 02:31:24AM +0800, Chih-En Lin wrote:
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 8834e38c06a4..5dcbd7f6c361 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -221,6 +221,7 @@ struct page {
> >  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> >  	int _last_cpupid;
> >  #endif
> > +	pmd_t *cow_pte_owner; /* cow pte: pmd */
> 
> This is definitely the wrong place.  I think it could replace _pt_pad_1,
> since it's a pointer to a PMD and so the bottom bit will definitely
> be clear.
>

I will figure out how to use _pt_pad_1.
It seems relative to the compound page (or folio?).

Thanks.
