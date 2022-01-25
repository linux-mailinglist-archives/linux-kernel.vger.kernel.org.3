Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6811049BBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiAYS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiAYS4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:56:38 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98798C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:56:34 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id c15so12439484ljf.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fTIC0KYcAU7y+7wUnGRMhkBW/04VGMWDeVkUkSJAGmQ=;
        b=uawUMPNcPHv5iyPo4LsdD2z5I1KWjd80mTQkfdi//xbsOLnUlx37kKYhxJQ36Ugdtv
         qTwb9l8FSud2YC9Rqhe1fgqVPtyKMrzh8AKP57x+/Y9FP+KjtdFESmnvaWarog81y0Nu
         6RMAqUDIiwZvsVpks0rr1orKwCgm6grx5NYKG4OtsL3ijkniCzLjXTKvkkQv6IgiMXrb
         peOfUymNCHOENVp77E7Cq8Ou+TSDA756j5mkZBpNlxGJ9xNmmvZaSFCpc96OCnp20KLf
         LKTa+X5ze94gjndZXK1u9CC5l1rkhiBxnpZsByIgo/6ptgdlhYLMKYlOpOhIharThM1+
         JLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fTIC0KYcAU7y+7wUnGRMhkBW/04VGMWDeVkUkSJAGmQ=;
        b=2H2cMAAtll5uLxNTgAYAGgqqnmlBHP0ZjFkLss3yJ0moEr/bEMYk3eI8d1VbGHLR/k
         dMJpJ1/lLavEXpGqt0acdO5mjZ8hUtkNcP6Sf8ORfpfsu25lmDxHfj0ClU/7K5duiZjh
         6n4GVu5mM2Ccgw5th7SHXjT3geuhssLec7OJOUjrXkkwPqAIDiz1xtbP4AtnRsBqwOEm
         iamOfJLfdf7/ogyX47nZWAA4Fh0C1GIT4CzVGY9qcYUpGvI6/UwWKcedfLMTuTLVxHdk
         pEKYjMKDPuwMKFZd62TvoBGr5Bdaj7/igR5FMhe25iVRHRDsBDpn9eY1G9qYPbUc4MAt
         xd5w==
X-Gm-Message-State: AOAM532xyc5s05Z4hDOZH2xVSZnydkPn9iP/DGYgBwUytAQ9QYgYLrrt
        OE9cVSZoLOrzqJQCAGt8xlbNgQ==
X-Google-Smtp-Source: ABdhPJw8URkiYeFKqQFgbfsxeh5R2XmdcNoDAY7XJpAG5VI3oM9BQ2Z5+KLqSd/PqRHV/HXOzV6XDQ==
X-Received: by 2002:a2e:b744:: with SMTP id k4mr3107981ljo.351.1643136993000;
        Tue, 25 Jan 2022 10:56:33 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y11sm1228113ljj.69.2022.01.25.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:56:32 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 65C4E103C0E; Tue, 25 Jan 2022 21:57:05 +0300 (+03)
Date:   Tue, 25 Jan 2022 21:57:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfAEqzTeBJSIOKcA@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:09:47PM +0000, Matthew Wilcox wrote:
> > I think zero-API approach (plus madvise() hints to tweak it) is worth
> > considering.
> 
> I think the zero-API approach actually misses out on a lot of
> possibilities that the mshare() approach offers.  For example, mshare()
> allows you to mmap() many small files in the shared region -- you
> can't do that with zeroAPI.

Do you consider a use-case for many small files to be common? I would
think that the main consumer of the feature to be mmap of huge files.
And in this case zero enabling burden on userspace side sounds like a
sweet deal.

-- 
 Kirill A. Shutemov
