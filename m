Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9149B5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451321AbiAYOEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiAYOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:00:50 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C0C06176C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:00:45 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a25so13035939lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jCE3Q9w0pYZdgf9y0akmYzNqAp0U6bL6oFF7qLl/HS4=;
        b=C80cnNOrbC/ii20I5s7FIzvQcERCV/9osEmLgdRKjY/XGh8q+JbuYn32GnnFQx3eMi
         jXQ7fNrTUQiNOrOQP8vCSxGLBbV6gdmCNdmNNY/v7NsMW6d5gn60uBIAmJohvxc/yRM9
         QcJiF+XA+Bvfj/vfqjJdk7ydzwymuvqknSTufiXApG7fxcyYKZNpeVM0uF1xWTT2A2c6
         K2w/rHWss33ijX+OKtsYvnNU6U4vt4L8wnX4+NFYCIB/J+BoQd2gedaBwyF3YoHGqRd/
         9EAuggep4kxiP7jdPVGKUgzNe4FRemYsuZYyDy5ksk2zvTqra+D4ny0UGcry7OTnBYRH
         HB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jCE3Q9w0pYZdgf9y0akmYzNqAp0U6bL6oFF7qLl/HS4=;
        b=TggXZ+tp2x/7uYMpT87AnA1BFyT8S9kt63r9knfLN6IxchcikR/y7oJBLet9uw/8MK
         SU/ekt/1gc6OksP4ZPnGGCgbW5XbhlqVzsgD1MuimIBw1TtIrsrwgMHhKArBnFS380Jg
         hwIR344QMN3Kb8cJCio2RfW33wlLFGCWuvwl1m93deX86SQd90i3+v7PEZVoaAEfnU6z
         O3Gqo7tfV/hhGgr2bZVVbRSBwIB7wb1duvoTeh22t8Ostx6RMz0vLTOAehr9OJ6hwhBp
         T0OyDXXnL46GXG254PnIRkFCOLnfxAL7umo9vwPI5y6IWsXXBfOj45ebib3LzbXXFMcI
         QCKg==
X-Gm-Message-State: AOAM532wfAsgk7KlnRSrjlI055OnbbmXJjbKT4H61cCkRiloAeHg4FPI
        ew5RtIHjy3xsajG/vQm0FikyJA==
X-Google-Smtp-Source: ABdhPJzwDU03/3/lYn+e29qN9G04dI/m9iuoAGuQYcq3nmcfKuiUkZoE86mXTsxivN3kWvmOPTYuSw==
X-Received: by 2002:a2e:878a:: with SMTP id n10mr3245940lji.400.1643119243345;
        Tue, 25 Jan 2022 06:00:43 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u1sm1222580lfc.98.2022.01.25.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:00:42 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 21B16103C0E; Tue, 25 Jan 2022 17:01:16 +0300 (+03)
Date:   Tue, 25 Jan 2022 17:01:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     William Kucharski <kucharsk@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        rppt@kernel.org, surenb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <20220125140116.db2lg6qmwlpdbgcg@box.shutemov.name>
References: <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <E44A9AB1-DBF0-4B8E-B049-293DD4DE6093@gmail.com>
 <fccf697d-919e-8e99-ea08-3ab991b610eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fccf697d-919e-8e99-ea08-3ab991b610eb@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:18:57PM +0100, David Hildenbrand wrote:
> On 25.01.22 13:09, William Kucharski wrote:
> > I would think this should be the case; certainly it seems to be a more effective approach than having to manually enable sharing via the API in every case or via changes to ld.so.
> > 
> > If anything it might be useful to have an API for shutting it off, though there are already multiple areas where the system shares resources in ways that cannot be shut off by user action.
> > 
> 
> I don't have time to look into details right now, but I see various
> possible hard-to-handle issues with sharing anon pages via this
> mechanism between processes.

Right. We should not break invariant that an anonymous page can only be
mapped into a process once. Otherwise may need to deal with new class of
security issues.

-- 
 Kirill A. Shutemov
