Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2DD466BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhLBWI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231365AbhLBWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638482701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPFqcEFuUD6RFSmQiRlOFobmywXdp7Z37Bs58rLmxbA=;
        b=dCcr1URyola45UY7uK58dMNoGCeZ7loVB4QkxSrIv4njlHZF+/2QYNJvxsM+A4TqqZ9NKS
        Chl6+aUEUyyu79XwaLDdylg3j9ea4S+8/L3wisGFGZZgKX+NZiBYf0Lre/9HqorWn5Q+8n
        Sv2v5AqYFwRAksCRT2XDCgBv0b+7fdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-bUoJJ271O92-EaUScCYELA-1; Thu, 02 Dec 2021 17:05:00 -0500
X-MC-Unique: bUoJJ271O92-EaUScCYELA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D8E1006AA3;
        Thu,  2 Dec 2021 22:04:59 +0000 (UTC)
Received: from rh (vpn2-54-226.bne.redhat.com [10.64.54.226])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C73D10023AA;
        Thu,  2 Dec 2021 22:04:58 +0000 (UTC)
Received: from [::1] (helo=rh)
        by rh with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <dchinner@redhat.com>)
        id 1msuCE-0007m0-Iv; Fri, 03 Dec 2021 09:04:54 +1100
Date:   Fri, 3 Dec 2021 09:04:51 +1100
From:   Dave Chinner <dchinner@redhat.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [LKP] Re: [xfs] bad77c375e: stress-ng.fallocate.ops_per_sec
 -10.0% regression
Message-ID: <20211202220451.GT2206@rh>
References: <20210902072704.GC8267@xsang-OptiPlex-9020>
 <36dc5f38-f8ec-591a-8efa-b3bd607ac06e@linux.intel.com>
 <96fa41bb-7e9f-ae47-bf34-accef5c36fa8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96fa41bb-7e9f-ae47-bf34-accef5c36fa8@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 02:46:06PM +0800, Xing Zhengjun wrote:
> Hi Dave,
> 
>    Do you have time to look at this? It still existed in v5.16-rc3. Thanks

AFAIC, it's a "don't care" issue.

The series of commits around this one:

> > > FYI, we noticed a -10.0% regression of
> > > stress-ng.fallocate.ops_per_sec due to commit:
> > > 
> > > 
> > > commit: bad77c375e8de6c776c848e443f7dc2d0d909be5 ("xfs: CIL
> > > checkpoint flushes caches unconditionally")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

changed how we manage FUA/cache flushes for the journal changed
performance across a wide range of workloads. Many went a lot
faster, some (like this one) went slightly slower. Overall it was a
net win, especially on storage stacks with really slow cache flushes
(e.g. dm-thinp) and workloads that do a lot of concurrent metadata
modification.

Overall, fallocate is not a performance critical path - it's a
slowpath because it serialises all IO to that file while the
fallocate call runs. Hence performance characteristics for fallocate
aren't really a major concern to begin with...

-Dave.
-- 
Dave Chinner
dchinner@redhat.com

