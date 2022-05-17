Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA77C529BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbiEQIK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiEQIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:10:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1B33C73E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:10:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so1257437pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CXzcoF7uGQa7GHZsoGZF5yhHmI1X2MWtHl4LQhGP75I=;
        b=uxzHIswcUIBZjJjtgwN8EZvrVmcOw1mvBk3nZIj3ytVkC/DJX39aOVXFUmMR1pzvrD
         MwVpKjHY+vD0HkINX4zDunv46HZwmZeiEgK72lOssnPMkv39GgXdrkTG1B6CXRQn0fre
         C/lzNiijUh1ASi8Sou3AoO6nxZX6IgVqKNgtKrq4AqV1BiKPuAOu99AJI0SN4/oaED/6
         k/5lEDLzfyVgJdkB2IKunNt1Y1NxoEU7a2eJamggcAGRk1Zi3gHoWXFu50SyI+YI/UyF
         RZLxdXzYPXavqQrosZAIik9wjJcEEYrtqotkz575IA3HKImjMxhi7h/IehlEU5t3xnkO
         Qs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CXzcoF7uGQa7GHZsoGZF5yhHmI1X2MWtHl4LQhGP75I=;
        b=P3jqj2tgShbg1D+KC0+SzwGrC112a3SErkhA8mwDr617655hdkotJZo6NKs6aoV/5I
         vt760F5IQNoPFkXVEdaUvMOn/2r2mSYoibw6l0z/D/NR4yhEZNwWXHlhwV/VO8iZpKXV
         qUC24+YmtkphoJYRhY3GEJ2i56LpbjQmsXM1rXboAKiR4RBC13wSmEirNT+S9GAvoJ/y
         L9iVYiwQl2RkV4sHvFT8/fxLpsguOPUtzuaVBCkvnELwLOC6LgKtFugVzADkPDBkemxe
         e1eFIELEvopC5ErCWa7B6FcDF5aYMCuWILuJ9RlWKa7VgTeGRU1UYfaqWawAmohs2Jh/
         778A==
X-Gm-Message-State: AOAM533yo5T6/TWBAb/T8ffg7PaDwzJiTadm+Mx258m45L/2PIrtARZP
        rv/lTdGH0IAOHf/8Pt5YETgvXA==
X-Google-Smtp-Source: ABdhPJzQiIHxbzey1EBFjyDjrpOLNbUL2EEf7wQ5kLnpJUVSAqcTqPkFIcf7jRVxmo1/O44Wql6QUA==
X-Received: by 2002:a17:903:40d2:b0:161:a2d9:3230 with SMTP id t18-20020a17090340d200b00161a2d93230mr2911147pld.57.1652775023946;
        Tue, 17 May 2022 01:10:23 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id m24-20020a62a218000000b005107da0f34csm8149530pff.20.2022.05.17.01.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 01:10:23 -0700 (PDT)
Date:   Tue, 17 May 2022 16:10:20 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 4/7] mm: hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YoNYbLWvUDzJomWu@FVFYT0MHHV2J.usts.net>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
 <20220516102211.41557-5-songmuchun@bytedance.com>
 <YoIptjs65NgT1/ed@localhost.localdomain>
 <YoI9pdLzB/V9Kw1y@FVFYT0MHHV2J.usts.net>
 <YoNURLcKtffT+5BH@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoNURLcKtffT+5BH@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:52:36AM +0200, Oscar Salvador wrote:
> On Mon, May 16, 2022 at 08:03:49PM +0800, Muchun Song wrote:
> > On Mon, May 16, 2022 at 12:38:46PM +0200, Oscar Salvador wrote:
> > > On Mon, May 16, 2022 at 06:22:08PM +0800, Muchun Song wrote:
> > > > --- a/mm/sparse.c
> > > > +++ b/mm/sparse.c
> > > > @@ -913,6 +913,13 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> > > >  	ms = __nr_to_section(section_nr);
> > > >  	set_section_nid(section_nr, nid);
> > > >  	__section_mark_present(ms, section_nr);
> > > > +	/*
> > > > +	 * Mark whole section as non-optimizable once there is a subsection
> > > > +	 * whose vmemmap pages are allocated from alternative allocator. The
> > > > +	 * early section is always optimizable.
> > > > +	 */
> > > > +	if (!early_section(ms) && altmap)
> > > > +		section_mark_cannot_optimize_vmemmap(ms);
> > > 
> > > Because no one expects those sections to be removed?
> > > IIRC, early_section + altmap only happened in case of sub-section pmem
> > > scenario?
> > 
> > Right. The commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > has more information.
> > 
> > > I guess my question is: can we really have early_sections coming
> > > from alternative allocator?
> > >
> > 
> > We can't. The early section does not consider partially being
> > populated currently.
> 
> Then, IIUC, we can forget about the early_section() check?
>

Sorry for the confusing. I mean early_section() should be checked.
I could find a comment in section_activate, that says:

	/*
	 * The early init code does not consider partially populated
	 * initial sections, it simply assumes that memory will never be
	 * referenced.  If we hot-add memory into such a section then we
	 * do not need to populate the memmap and can simply reuse what
	 * is already there.
	 */
	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
		return pfn_to_page(pfn);
 
We can see that we could hot-add a sub-section within a early section.
So I think early_section + altmap could happened in this case, then
we could not drop that check. Right?

Thanks.

