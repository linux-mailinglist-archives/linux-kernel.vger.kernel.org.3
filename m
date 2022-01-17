Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE7F491134
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbiAQVAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbiAQVAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:00:32 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619EDC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:00:31 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x7so62353218lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QdXHGenv3tZIOnYPfCA1iCRPfis03+iHQr5vhZDRmzE=;
        b=LHCrYpBn/smiTJofppxDrX+ObncdoQHEUbtlu7Uv8G9dvP69Qbsxn1Zd8Npqatpqgn
         V/+c1uEyFCqjxVX8KFt4LnZvrRJ9IpXUHupdXbi4Y4EtgbS0hk95vFQWV1xYNHzk0eDz
         cifHShq1ecjEPg/13qDD/r3F6WOXCCGJtXcmJX41XoCwt0atbYn9NZeIyJLtjpNaUGFZ
         jYHi+5tF/8g+r697NSHleOOlNMAPrhK+CNlU6yXI21P+N3wYvwuJc5udF519uNScPBIp
         VcG5hLejYUs/hq2PnxOVpiwqwUoh4fWBfzAsNzrgrefvDSxxVjPYn0NQXkszk587E9DI
         a26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QdXHGenv3tZIOnYPfCA1iCRPfis03+iHQr5vhZDRmzE=;
        b=ItMVtR/KYDpVHWhdKvE9qGXe8CkxvMuCSrEp5dF3Wz6aWx6hftZakJwbl5uX6fuqxk
         pbIMXAye1O3F4TZ28O34iyncbgN9M6URi2VGd+fR5F6bwtSJT+Fk7wuDE125fdOJ8aPa
         UOlJD4OAjwbq0aV5BMOQ4uwgw0mx4EoNRpPH2TUDfmfjzaSYMYZ9R8a5nSTUrLNOSfmm
         fuv51vEiV0FsWkdc8OKIsUTDL5LgANosLUrSW09fc9Uwg2eJdxzgCYvJVslJgaDNauk/
         6vZ6M4Wtz5SOstbxExWiye3mLNz17TJE88qeLWGaL/DqEsFfDMnKrADZ82uT8WPUFBXj
         e4oA==
X-Gm-Message-State: AOAM531lgdPVHCLrTsrk5i5YDcDYT/yR2PF/hxRcz581wHmXW7HQTfG5
        iNo0SCt6s90dpyDSkWJE3JMYcQ==
X-Google-Smtp-Source: ABdhPJwo88Lo7R6WVD9bXds5DI6nWc0dJtRADfIjRocxWhl6taT1Sq4djYHIrDbA3yWrii1W/rWEKA==
X-Received: by 2002:a2e:b70a:: with SMTP id j10mr13657179ljo.376.1642453229685;
        Mon, 17 Jan 2022 13:00:29 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k9sm1037129lfg.121.2022.01.17.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 13:00:28 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 49E4D10387E; Tue, 18 Jan 2022 00:00:57 +0300 (+03)
Date:   Tue, 18 Jan 2022 00:00:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/12] mm/vmscan: Free non-shmem folios without splitting
 them
Message-ID: <20220117210057.o2aug2unmovufrdz@box.shutemov.name>
References: <20220116121822.1727633-1-willy@infradead.org>
 <20220116121822.1727633-5-willy@infradead.org>
 <20220117160625.oofpzl7tqm5udwaj@box.shutemov.name>
 <YeWVBkgYMp4MctTW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeWVBkgYMp4MctTW@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 04:10:46PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 17, 2022 at 07:06:25PM +0300, Kirill A. Shutemov wrote:
> > On Sun, Jan 16, 2022 at 12:18:14PM +0000, Matthew Wilcox (Oracle) wrote:
> > > We have to allocate memory in order to split a file-backed folio, so
> > > it's not a good idea to split them in the memory freeing path.
> > 
> > Could elaborate on why split a file-backed folio requires memory
> > allocation?
> 
> In the commit message or explain it to you now?
> 
> We need to allocate xarray nodes to store all the newly-independent
> pages.  With a folio that's more than 64 entries in size (current
> implementation), we elide the lowest layer of the radix tree.  But
> with any data structure that tracks folios, we'll need to create
> space in it to track N folios instead of 1.

Looks good.

> > > It also
> > > doesn't work for XFS because pages have an extra reference count from
> > > page_has_private() and split_huge_page() expects that reference to have
> > > already been removed.
> > 
> > Need to adjust can_split_huge_page()?
> 
> no?

I meant we can make can_split_huge_page() expect extra pin if
page_has_private() is true. If it is the only thing that stops
split_huge_page() from handling XFS pages.

-- 
 Kirill A. Shutemov
