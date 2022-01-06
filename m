Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A93C486B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbiAFUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243719AbiAFUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:30:15 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E4C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:30:15 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i30so3615781pgl.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 12:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1dYDq292X5AvCNhfISqHxRCZk5rNTqVWjLVXkC8P+XE=;
        b=RPOKSS2OwpHLKmLaka43HEcnkD3JnYseEF3zcqfNm+FemYU3qtPCRyaELkYSk/kO8T
         e8c6Aghz3i0nwAHFwRpJaYEihxJxJIsyKrzCiEDaknA7qaPanUvDdM5dXQDDUy8raTLm
         L9Mbem9IgA2KKk3xoI69GgEa+X8PBowYK2PJgiTH5P2Ze2wMdOarbdLKVOZcYWo0F4BF
         VBy7+oKB7NMuJtMmlquYrFWmkmo3nt9mY8YIUWGD0cRaH2LoZquMedy/ANFDEc4MMEOe
         JTKqyyvydFRIB/AdNFR9+LwJPmNHPEL3FPwvUtLeQPZjzt9M7VmvdyOQUhdkQs020NZU
         okmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1dYDq292X5AvCNhfISqHxRCZk5rNTqVWjLVXkC8P+XE=;
        b=i6slikRCXReLeMt4lTHa8ksMqEmmSSutrHG5q4xBprfOvaHyIBs8xn9i5tcLXRlgdg
         nDvWRCYXN+A2wSNDh99LhvDXvGEkKhAnG0N5AG5j3NKRJCCxkBqayIEJ4VOjBQnnMaUJ
         E7nv2x9iwX9FyASvPjBVIlt7vwJtNO23HY4lGwU2iyZ275ma6mtsSfgAwro9jf4g+qb0
         n3V9UBnZ/254fEuFcsQKMvi9lU9vXqPL5uLQar50lvqTnN1TlGBgivhUnO7DxXggddHi
         JhIsgVIFTEXijjRmPHQFFbzx/XNEn1L4jgwq9b2F6kssoieziwSYMkwwPDy+c7x/c6Rj
         CCAA==
X-Gm-Message-State: AOAM531ygL32reoHSS8uFlZOJe3qXxmRdsyHMXMIPebXgwdhHIUy6lAA
        c2kV53lWbPOEwipaw9GVVUw=
X-Google-Smtp-Source: ABdhPJyPiTLzyC5vvir92C94KqSMAd3WfsMnYXWMmoDUEPpHnIydy5LysotC3iNMKGDpNskEzIzt+g==
X-Received: by 2002:a63:9dc8:: with SMTP id i191mr5390358pgd.601.1641501014489;
        Thu, 06 Jan 2022 12:30:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o7sm3290500pfu.108.2022.01.06.12.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 12:30:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 6 Jan 2022 10:30:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Imran Khan <imran.f.khan@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Message-ID: <YddRVH4r6uNHt3xa@slm.duckdns.org>
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
 <YdP57ij4JxahpdnC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdP57ij4JxahpdnC@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 04, 2022 at 08:40:30AM +0100, Greg KH wrote:
> > We are seeing the launch time of some DB workloads adversely getting
> > affected with this contention.
> 
> What workloads?  sysfs should NEVER be in the fast-path of any normal
> operation, including booting.  What benchmark or real-work is having
> problems here?

In most systems, this shouldn't matter at all but sysfs and cgroupfs host a
lot of statistics files which may be read regularly. It is conceivable that
in large enough systems, the current locking scheme doesn't scale well
enough. We should definitely measure the overhead and gains tho.

If this is something necessary, I think one possible solution is using
hashed locks. I know that it isn't a popular choice but it makes sense given
the constraints.

Thanks.

-- 
tejun
