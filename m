Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5649B593
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386314AbiAYOCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386886AbiAYN6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:58:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DD9C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:58:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x23so9973454lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4t35tkSfhawZj3YdmXeypgJh5HQgRVLYdhSyxfOKLTU=;
        b=u85tLHy1j+MBDPRG6pUcVnt8usiu3geVBkYlAX+KvLLDhkRuW5txGMJrgl8RWApWVP
         KsiHdEUru6gtGc69w3lWx4SAB3F+RML896b2tUaoAFAmE+qkQF30hxUt37HhargEVIIi
         fDaimZ6yC1KFgz8LhshXO3L1/ngUK7PpOSdGnbNnBJsjRrZUJgT1vJ8weuOBsl3UY12G
         KhtPYvAIvqv9xYEQ+d4FNHFZAU4F9YICgzW+LqM4A4QkRKDnbRW0UPcHwjLT91Kk4MIX
         DL5upOIhDvPBINtxHsq/X/rCkpHIKm/rSJzpiYFB3ldyKBA5eaXL5KwIEp2aXqA++WDJ
         T/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4t35tkSfhawZj3YdmXeypgJh5HQgRVLYdhSyxfOKLTU=;
        b=VH+wrE+H/x7qFYjnRwuztGTqEo6TW7LDDBfML0neidKx7Yc77YjNOhqIFrEnMhQ/Sq
         aRXcOzRykNv5BMlQSxriZtjPsYUhjsXWL+wQnLdu9sVmUOCY15nDToGlJFUoLtPp6fa8
         RAjohbwUEMSNfm8TcOk4zuCr+luAhGdMK202pAkFA+ItElV0nKK7RfZ0WDWqs4UKrALd
         QQLK9TdBOwnNVJ8x6qQjpeICy9vWwOjkiYvxoUb7y4Hh9rX9zPY0X/2s9BOO+Bg3xfC7
         ISxehZY7L1M1En1onytKUuFFZXLMsIdAMeiKS6/WnE+O1dIw6JusA8FwB/RBP/VgyJXw
         NUiQ==
X-Gm-Message-State: AOAM530wobzkymLYmgDlxfMLjJTQgjXWRIKo233+OyBfye13mJ9oSMr/
        5Q0gkrZxFExJKH8yh37CbG2KzQ==
X-Google-Smtp-Source: ABdhPJzS/I+6lscy9Eg1GYbSwvsvywkknT8P6cHPDwk98dijkuNaRB7GfDzGKtrG0LQtwkz7qNGUgQ==
X-Received: by 2002:a05:6512:785:: with SMTP id x5mr15447646lfr.614.1643119124417;
        Tue, 25 Jan 2022 05:58:44 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a4sm1500028lfg.31.2022.01.25.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 05:58:43 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 355B7103C0E; Tue, 25 Jan 2022 16:59:17 +0300 (+03)
Date:   Tue, 25 Jan 2022 16:59:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye/5yUyEqO0ws0G5@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:23:21PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 25, 2022 at 02:42:12PM +0300, Kirill A. Shutemov wrote:
> > I wounder if we can get away with zero-API here: we can transparently
> > create/use shared page tables for any inode on mmap(MAP_SHARED) as long as
> > size and alignment is sutiable. Page tables will be linked to the inode
> > and will be freed when the last of such mapping will go away. I don't see
> > a need in new syscalls of flags to existing one.
> 
> That's how HugeTLBfs works today, right?  Would you want that mechanism
> hoisted into the real MM?  Because my plan was the opposite -- remove it
> from the shadow MM once mshare() is established.

I hate HugeTLBfs because it is a special place with own rules. mshare() as
it proposed creates a new special place. I don't like this.

It's better to find a way to integrate the feature natively into core-mm
and make as much users as possible to benefit from it.

I think zero-API approach (plus madvise() hints to tweak it) is worth
considering.

-- 
 Kirill A. Shutemov
