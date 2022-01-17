Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06B490B96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbiAQPlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbiAQPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:41:00 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:41:00 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id jr5so18672047qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gBcyXVUz23eSDu95s112gETkUIIOALqlxWlAfpuTh5Y=;
        b=YjeeIwOwkoONkWTasYStJjNI7NCtrIw7W0eO/PaogHGC3AWma/5ysHMOSUXyXN+ola
         nSW+yrgUvVA6YbTJRIKvqqaTIDawFfQ9n6Brv/8QJyiDZuP1sbdkI4Sd8hoyRDAsfDy2
         UinHYQOF0ofe59WYA3Kf2t5ukv5Rvm0WUmiPM/X0/XL7CoCLnNGOm/DfM4amqLwBfyxL
         hbg2E/JHM4jDXI2ldONWRG2RWmMLfDgqsGap7EZ3WUBh0KeLwoFxhSmVrUgvZ4LsLxwF
         YWDR/sElbRrOIJXc4BjfZDoR8oKNRTmd0zZzp6ipK/72bLcpWefnM9MLYSrCQNW0SdDc
         DVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gBcyXVUz23eSDu95s112gETkUIIOALqlxWlAfpuTh5Y=;
        b=noenFnPFdWVjiR+RVpxxJ3ByoNPCNVXUfUwV9JzEvySrBSaw/F7TLxvmxzySQv0ajj
         roGcLKc4mTXERfFRkWsqeJ1yM/ur59ljcu0SjogUzlTSjTKpit2XbLoo9BPgi2AEQ47W
         s6/QLWmkcysyvPpD0P0auJeCyJ3j7mCDh3x3N/NQ9J/yhnHB2IGTnVIzEut33Qzv0fc2
         Lmtpg69lXKvJ4A50Uz1lWcsYZga5L++4udR5w0/+DGCaMmMHk2fcW95b2Q76Y8kj91PA
         ZqtmIQayY97fPkcNBxUnSFY55zBEpeWA1WQ0ql/vz9MWLDAk6WQHIYoF/qnKDAcym/2X
         enhg==
X-Gm-Message-State: AOAM530Ln2NeXMJd3G80mNowH+R4jdl5hx/mWIHgqGEGQpzQqd9s376v
        l0sd+HII7gg1MWKQQpgyFLE=
X-Google-Smtp-Source: ABdhPJxZf5jKbGWoF2VQ1qBUqDEBxD3hufw/+mutn3HTEWTUTckH+UkaLR9G2MyERI9+57H7VEjrww==
X-Received: by 2002:a05:6214:27e9:: with SMTP id jt9mr19287528qvb.89.1642434059494;
        Mon, 17 Jan 2022 07:40:59 -0800 (PST)
Received: from mail.google.com ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id e15sm1617962qtp.48.2022.01.17.07.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:40:59 -0800 (PST)
Date:   Mon, 17 Jan 2022 23:40:51 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix missed initialization for
 folio_batch::percpu_pvec_drained
Message-ID: <20220117154051.xfocchuceoo5jzn3@mail.google.com>
References: <20220116070227.6854-1-changbin.du@gmail.com>
 <YeQEN8oOuC+QOWN1@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeQEN8oOuC+QOWN1@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 11:40:39AM +0000, Matthew Wilcox wrote:
> On Sun, Jan 16, 2022 at 03:02:27PM +0800, Changbin Du wrote:
> > The folio_batch_init() forgets to initinize folio_batch::percpu_pvec_drained.
> 
> Already reported by Randy three days ago; sitting in linux-next since
> then.  commit 6840f9094f2b.

Glade to know. Thank you.

-- 
Cheers,
Changbin Du
