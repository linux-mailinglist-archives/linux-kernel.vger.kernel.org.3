Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FDC48CCDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357152AbiALUJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiALUI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:08:59 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA85FC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:08:58 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g5so5737343plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D645mgqW5zfoTP46+QhUw2O9sxzB2yEdYGETq2QYUIc=;
        b=DWIC6htSOV9vGcO0bRNecpulHUzTYmyXY3L2XoFR2hq5WiQzBtJAvbfLOlkpwvXTim
         1LCO/0Us67/M1pVffQgcYsfjnDXUVqrBThuM3GD7SWB5+jr5XFROeR/MFTG9G5WFTskB
         wWglScDHMcE2eojuLHM5kTZ1veb4rvfd7fjYy1VMmaMWpAADj4JEOaEZ2z3Aqwr1/I8G
         bUDb3JNVZ1La4XExNHDgfIsz0vAdAaENlP38Q7Sx3GQ/4Eg3gK+A3pObrY+xXPdhjhba
         QK8qekAcN1KJzd1P4BZhLBeSnonDtaLKPmBlav5SRehqMGrh9+Jn4nn//JdHKSOwUtW+
         NcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=D645mgqW5zfoTP46+QhUw2O9sxzB2yEdYGETq2QYUIc=;
        b=hcQWQpc8pjX7sSYlJDl9WA7kJwh3RG3Rkx7VnxP519iM3YtwfCtVUD69LRZzfpVT5F
         V3qLs/kZpLTccgW5rLD/2AIEqoYyrp9o8KSywq2qNngQit8BwXfT3pfZRNkjzZD3uf08
         mgIHL2U5q5wcNoKA0y64BTMwUJRFknNxzxB55tSEMFqhjhXV9TjuMX3hP3nGlnLshpac
         pOlC+qGoQb+E9kzD8dx+74yiw9OkoI7weuK7gPO5gc1ga6ZTf+NLlJvxm2BWuLd1VVal
         ip77xyxp11Bqh2flCghOt3ijZ4VgvkTHCGXSvIyGVYC1w5d3aIJoPyH8BcU3jrpHHMTC
         O/dw==
X-Gm-Message-State: AOAM5337irTEiEQ4py8BxRc3LlpJi8sI7KaSylJ8IOu1F6UiYKJiCQHy
        MvJBSt/l2mapr64oZwjujxk=
X-Google-Smtp-Source: ABdhPJzK21s0xf4uXp/UDCK5dJItxKDTNO5bdzvomlewiUyOtuWf33+4fuYshih6cG15DpH2muUIaw==
X-Received: by 2002:a62:ed06:0:b0:4bb:1152:2fbd with SMTP id u6-20020a62ed06000000b004bb11522fbdmr941473pfh.34.1642018138143;
        Wed, 12 Jan 2022 12:08:58 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x25sm430874pfu.8.2022.01.12.12.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:08:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 10:08:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Message-ID: <Yd81V5AYz/sMps9F@slm.duckdns.org>
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
 <YdP57ij4JxahpdnC@kroah.com>
 <YddRVH4r6uNHt3xa@slm.duckdns.org>
 <03cb9939-efbb-1ce8-42f5-c167ac5246da@oracle.com>
 <YdivuA12i3VU8zO/@slm.duckdns.org>
 <989749c4-bae9-8055-39b4-ffc1cb6fc20b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <989749c4-bae9-8055-39b4-ffc1cb6fc20b@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 11, 2022 at 10:42:31AM +1100, Imran Khan wrote:
> The database application has a health monitoring component which
> regularly collects stats from sysfs. With small number of databases this
> was not an issue but recently several customers did some consolidation
> and ended up having hundreds of databases, all running on the same
> server and in those setups the contention became more and more evident.
> As more and more customers are consolidating we have started to get more
> occurences of this issue and in this case it all depends on number of
> running databases on the server.
> 
> I will have to reach out to application team to get a list of all sysfs
> files being accessed but one of them is
> "/sys/class/infiniband/<device>/ports/<port number>/gids/<gid index>".

I can imagine a similar scenario w/ cgroups with heavy stacking - each
application fetches its own stat regularly which isn't a problem in
isolation but once you put thousands of them on a machine, the shared lock
can get pretty hot, and the cgroup scenario probably is more convincing in
that they'd be hitting different files but the lock gets hot it is shared
across them.

Greg, I think the call for better scalability for read operations is
reasonably justified especially for heavy workload stacking which is a valid
use case and likely to become more prevalent. Given the requirements, hashed
locking seems like the best solution here. It doesn't cause noticeable space
overhead and is pretty easy to scale. What do you think?

Thanks.

-- 
tejun
