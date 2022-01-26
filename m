Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AFE49CB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiAZNmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiAZNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:42:17 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE08C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:42:16 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a28so32973229lfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Alc8oEV5YDVD8wUXku55TL6Eo0GDfRno/HSGsO5a5G0=;
        b=ccIXkZTbmVbS5oHJZvDnte715BIEU630afKo6hLkstHyy76syUo+6c1PKybn7G0wgS
         8nTdLVy596xTsQurfMO3Cp1LqlQMuKeQYlWjaviNG3yhDmO/NjmKXSNl1lzKJ112cz0a
         114c5gNmTDhdvKNNfxPaZFh2An5EbGroo6Oay6AEL2BZKFzjI9wetSY7tCdBPrG+DC2g
         ntGdAiE6WJGZEI8tKaAXaNlFBEfKPIGxjX8TsV0e9PfSovYTObcHihO4pmlo0jDfJeBZ
         8N3lvagsb8RrTX+IHC/XO34LdBLqUMET3mgtxNCSNNtJvLuO1PcPOuerJfniBLkjebx9
         YRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Alc8oEV5YDVD8wUXku55TL6Eo0GDfRno/HSGsO5a5G0=;
        b=SBv3CSR3LZS0aTpDk1ytf4GLLDYUXf+mbNrRUxX8rIOl6qPsapyzRfWeX2u8a8Yt6t
         F4mkyRwX0J5A1T9yXiqcaDSv86n1W6+QRyk+tCJcL9xF//N8/gbYUJAZrW8tKpPnKQa1
         wpD2brnDZks7v0eU8SOfrt94MRxSoapBmboxLmrN/62bLs6gjqd0MH/5L7cxl+PDZxeR
         EfPztEoHzuO0QCpvloZQYRtFC3Sk9iMraNkYklXiytWfbCfF4cMUgnLiRFl2UDJlTgT3
         +DtvRbQdd0rSo/1+DFO7FrPSVVxPSErlCyq+OiXEyteHU9xrEt1DYQuN34UTtJqKKra0
         76WQ==
X-Gm-Message-State: AOAM532cw8XYF1o4+/hpz2Uf52orCZE+c+E5NKegJi5EcOiKE7rPNRIs
        bZLHFoWFvvo4vv9/zcfPc/G2oA==
X-Google-Smtp-Source: ABdhPJytZbSzXvdmITmfj9YLbyBXILQ/6yBAYZJlxO9L46JVZHO0xyL3H2Xktijp9xq98vZzaUD5+Q==
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr10659161lfg.229.1643204535314;
        Wed, 26 Jan 2022 05:42:15 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y22sm608299lji.129.2022.01.26.05.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:42:14 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 42AE1104818; Wed, 26 Jan 2022 16:42:47 +0300 (+03)
Date:   Wed, 26 Jan 2022 16:42:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <20220126134247.fadtwbvyknh3ejpe@box.shutemov.name>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
 <YfDIYKygRHX4RIri@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfDIYKygRHX4RIri@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:04:48AM +0000, Matthew Wilcox wrote:
> On Tue, Jan 25, 2022 at 06:59:50PM +0000, Matthew Wilcox wrote:
> > On Tue, Jan 25, 2022 at 09:57:05PM +0300, Kirill A. Shutemov wrote:
> > > On Tue, Jan 25, 2022 at 02:09:47PM +0000, Matthew Wilcox wrote:
> > > > > I think zero-API approach (plus madvise() hints to tweak it) is worth
> > > > > considering.
> > > > 
> > > > I think the zero-API approach actually misses out on a lot of
> > > > possibilities that the mshare() approach offers.  For example, mshare()
> > > > allows you to mmap() many small files in the shared region -- you
> > > > can't do that with zeroAPI.
> > > 
> > > Do you consider a use-case for many small files to be common? I would
> > > think that the main consumer of the feature to be mmap of huge files.
> > > And in this case zero enabling burden on userspace side sounds like a
> > > sweet deal.
> > 
> > mmap() of huge files is certainly the Oracle use-case.  With occasional
> > funny business like mprotect() of a single page in the middle of a 1GB
> > hugepage.
> 
> Bill and I were talking about this earlier and realised that this is
> the key point.  There's a requirement that when one process mprotects
> a page that it gets protected in all processes.  You can't do that
> without *some* API because that's different behaviour than any existing
> API would produce.

"hurr, durr, we are Oracle" :P

Sounds like a very niche requirement. I doubt there will more than single
digit user count for the feature. Maybe only the DB.

> So how about something like this ...
> 
> int mcreate(const char *name, int flags, mode_t mode);
> 
> creates a new mm_struct with a refcount of 2.  returns an fd (one
> of the two refcounts) and creates a name for it (inside msharefs,
> holds the other refcount).
> 
> You can then mmap() that fd to attach it to a chunk of your address
> space.  Once attached, you can start to populate it by calling
> mmap() and specifying an address inside the attached mm as the first
> argument to mmap().

That is not what mmap() would normally do to an existing mapping. So it
requires special treatment.

In general mmap() of a mm_struct scares me. I can't wrap my head around
implications.

Like how does it work on fork()?

How accounting works? What happens on OOM?

What prevents creating loops, like mapping a mm_struct inside itself?

What mremap()/munmap() do to such mapping? Will it affect mapping of
mm_struct or will it target mapping inside the mm_sturct?

Maybe it just didn't clicked for me, I donno.

> Maybe mcreate() is just a library call, and it's really a thin wrapper
> around open() that happens to know where msharefs is mounted.

-- 
 Kirill A. Shutemov
