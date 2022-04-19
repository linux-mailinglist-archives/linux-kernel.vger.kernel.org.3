Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D150645F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348762AbiDSG0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348055AbiDSG0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:26:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FBC21265
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:24:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o5so14952058pjr.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HcOm58iTm0VxH3c2zlAplu3ZQMbf9aIp/+cejmaeHyI=;
        b=Dnyhh0NtgNw4iqSxEAh8EFGl3vpQRI+53TPg03N/0kNEMI4lxmK+gHgYXFksRh2lJ+
         R9ZeebLpM/29twY5Dk273cwcDTP6bXpK2m8TMY6LY2CQakgcELYbZevqxvqI6c1bYVlQ
         R2G62Cq2ZLnZ4URP++fpZCHVMxHfftsY4wuJUCDqmIUpI3I86QvvppKDc6OwquHsRjh+
         10+sd+aud+oxLTKqw3H6EeJtj4tjw3296T7LZkE6YPHur22ET0HSE1+DQZgBWecrv2z8
         0dn/wdDCIShvwFg7hxsnyt22mUxouahIXdxt0P4Q0igA+IHsVYCYFNH4ouw9voDf9LZt
         17MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HcOm58iTm0VxH3c2zlAplu3ZQMbf9aIp/+cejmaeHyI=;
        b=bfBmAA96ShRWDmAfDcF9q6yE24OBmC8nnLK2KswXuuS/hvJstVPQwpI0twIl7+sNet
         MDmz7/SgI/EiZeZp2L7ye7rTlsgzkXVKepaSdAGF84E6Yl31noA/PA9lRCtdNP4etJO4
         vE0hndaUb0kRX+2ycCcp35uFJN3moYO0FEqMMFtgAG4Rvf1ceR4oZyC3u1NxTyT9P313
         cgOGQvDCqk2bdtzjxP4/4Ow8XsnMnvY6aatKgszwCRMP7LEl9ohXpVigumHvaCnkE9Na
         I/LdvGWsnn+8fNTZYOHYP/zCXDYXSZ/C8rmfjdoeDT1sUTh88MxtpvFIVr1MjjhfEBZY
         /QDw==
X-Gm-Message-State: AOAM5300q37bG7hcpcZjw+fhDovcRra1QNuAn4mOnYYniDwC5ykrWUDN
        NL0BZYtplEh4UOUwcCNu+6PlDQ==
X-Google-Smtp-Source: ABdhPJzuga1jVkb36XA3IQbXLRjDomJ9OVFusCa5i5OWfpyfmH7OiSRCHdD4WQbuooR9m4UrxEc9IQ==
X-Received: by 2002:a17:90b:255:b0:1cf:39e7:a7aa with SMTP id fz21-20020a17090b025500b001cf39e7a7aamr16924592pjb.137.1650349441107;
        Mon, 18 Apr 2022 23:24:01 -0700 (PDT)
Received: from localhost ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id 35-20020a631763000000b0039d93f8c2f0sm14874164pgx.24.2022.04.18.23.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 23:24:00 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:23:56 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v8 1/4] mm: hugetlb_vmemmap: introduce
 CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP
Message-ID: <Yl5VfI1h6nUd8s8q@FVFYT0MHHV2J.usts.net>
References: <20220413144748.84106-1-songmuchun@bytedance.com>
 <20220413144748.84106-2-songmuchun@bytedance.com>
 <20220413120804.3570dc230a958f4923e3f3c3@linux-foundation.org>
 <YleQiQW7gFTO7SMk@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YleQiQW7gFTO7SMk@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:10:01AM +0800, Muchun Song wrote:
> On Wed, Apr 13, 2022 at 12:08:04PM -0700, Andrew Morton wrote:
> > On Wed, 13 Apr 2022 22:47:45 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> > 
> > > If the size of "struct page" is not the power of two but with the feature
> > > of minimizing overhead of struct page associated with each HugeTLB is
> > > enabled, then the vmemmap pages of HugeTLB will be corrupted after
> > > remapping (panic is about to happen in theory).  But this only exists when
> > > !CONFIG_MEMCG && !CONFIG_SLUB on x86_64.  However, it is not a conventional
> > > configuration nowadays.  So it is not a real word issue, just the result
> > > of a code review.
> > 
> > The patch does add a whole bunch of tricky junk to address something
> > which won't happen.  How about we simply disable
> > CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP if (!CONFIG_MEMCG &&
> > !CONFIG_SLUB)?
> >
>  
> I'm afraid not. The size of 'struct page' also depends on
> LAST_CPUPID_NOT_IN_PAGE_FLAGS which could be defined
> when CONFIG_NODES_SHIFT or CONFIG_KASAN_SW_TAGS
> or CONFIG_NR_CPUS is configured with a large value.  Then
> the size would be more than 64 bytes.
> 
> Seems like the approach [1] is more simple and feasible,

Sorry, forgot to post the Link.

[1] https://lore.kernel.org/all/20220323125523.79254-2-songmuchun@bytedance.com/

> which also could prevent the users from doing unexpected
> configurations, however, it is objected by Masahiro.
> Shall we look back at the approach again?
>

Hi all,

Friendly ping.

I have implemented 3 approaches to address this issue.

  1) V8 has added a lot of tricky code.
  2) V5 has added a feadback from Kbuild to Kconfig, as Masahiro
     said, it is terrible.
  3) V1 [2] has added a check of is_power_of_2() into hugetlb_vmemmap.c.

Iterated and explored through 8 versions, v1 seems to be the easiest way
to address this.  I think reusing v1 may be the best choice now.
What do you think?

[2] https://lore.kernel.org/all/20220228071022.26143-2-songmuchun@bytedance.com/

Thanks.

