Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261874B4200
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbiBNGdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:33:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiBNGdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:33:02 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3325623D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:32:55 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 4so16342645oil.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=h0JP709O9eQRvYaHcZW5ywH5vkUoeEc9HEo34GT5kVU=;
        b=KM16yQHt1UQm3xp/rwQu+bJ+52ngVLufsAiYc2dhsQKBY+q32Fs12Vvrev/hiKkPCj
         yXJ/TWaG3C9z2O58D2cbi4+5wsJNFbflgCcSkMJeTyopITHZJXlKDNAvTy+0ZwxJPgwh
         J6LNq1E/USRp5cbW2XOAhcIjmIMumYGISzsMsEoKHi6t5Mt3LsPUwMcleFYJCHHS+cuC
         4LoL0+A+shY1VtADWU6Vl6k3EmusJcOwANaUxeZTV+rkHBHnVjmFfLW276bwqaLNowbN
         GLh0oOqfHJaw6NpjDcRdnl24ka7nsy57bn/CtNJ7/vFAXdGt0X0aRGT+IlFrj7tSf8Fm
         T6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=h0JP709O9eQRvYaHcZW5ywH5vkUoeEc9HEo34GT5kVU=;
        b=pO6W0u0Zr0Un465MnXLBkUe/WXypIF5e+bUJXPkZ0SsBYBU4UtzC/qiFoavTUaV2H5
         LMNYLjFdAA7srvNKiEhHDGxgTnD9N6D6Nxme79bsu1ciPIhonURl+5QCGY5bHwEVrFJL
         GuT0jEVxP3sG7TLu9im5ExJnKfcQceICCYu3BWuY4+WyxlAMFd305LXwfe8jwzJLv1Mw
         e6dtxbdhm/QmrOislL7JinVnrCw+d5jpB40lvibfof9NiDflX7GcHc6Xl1ihCo+Vjn/p
         wUR9dmh63Fa7VuQzlQAKwqQAeLuhTnXYL3ZZ+9bJg6IVhyHO2Ok57lamMkV2TlGzfF4B
         CIZA==
X-Gm-Message-State: AOAM533ZaBIsQSlxHeN3KD7bV+Al2vJoK+GH6krXz6oRuAo5AgIAjhBT
        pKHKyZ25hVri2SjLl0hbOxPYHA==
X-Google-Smtp-Source: ABdhPJzFXzAHk9ZZwaynAWPuynoSFRSx1RsMS+pBEAuMQDYHuypZzfpc3gGQx4JMklT3Je0tfBl5Vw==
X-Received: by 2002:a05:6808:2112:: with SMTP id r18mr4983152oiw.20.1644820374805;
        Sun, 13 Feb 2022 22:32:54 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x17sm12066099oop.1.2022.02.13.22.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 22:32:53 -0800 (PST)
Date:   Sun, 13 Feb 2022 22:32:41 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/13] mm/munlock: mlock_pte_range() when mlocking or
 munlocking
In-Reply-To: <2ec49f65-fe4e-26a0-4059-c18e6dab0af4@suse.cz>
Message-ID: <ccca189-ce74-7e31-e025-332bb556578a@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <8bc3ee8c-7f1-d812-7f22-4f9f6d436bc@google.com> <2ec49f65-fe4e-26a0-4059-c18e6dab0af4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, Vlastimil Babka wrote:
> On 2/6/22 22:42, Hugh Dickins wrote:
> > @@ -162,8 +230,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
> >  	pgoff_t pgoff;
> >  	int nr_pages;
> >  	int ret = 0;
> > -	int lock = !!(newflags & VM_LOCKED);
> > -	vm_flags_t old_flags = vma->vm_flags;
> > +	vm_flags_t oldflags = vma->vm_flags;
> >  
> >  	if (newflags == vma->vm_flags || (vma->vm_flags & VM_SPECIAL) ||
> 
> Nit: can use oldflags instead of vma->vm_flags above?

Yes thanks, that is nicer, I'm making that change now.

Hugh
