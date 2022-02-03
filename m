Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A584A90FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 00:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355925AbiBCXGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 18:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiBCXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:06:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120EC061714;
        Thu,  3 Feb 2022 15:06:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33EA161842;
        Thu,  3 Feb 2022 23:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D384C340E8;
        Thu,  3 Feb 2022 23:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643929606;
        bh=bfNOqPpr4dR8k/kHvXYao8BTyZwKIW3jBgPse6WBk1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nMN3VxyIQB60qDyNNZFur24lNBAaNNC/ra/hsl2MO7ogMFDtaB0q5wj/M8EKrNCEI
         zNhU83ihqSCu1wVWjV+kGfzl4bf8GQmyR3NwdV0RG4IoDIR3oEfDrrZL1cQNZ5/MNC
         /lUysxSM6H6DMHZkUz9tzj7+F3hAs9Ktzl7Nh3X0=
Date:   Thu, 3 Feb 2022 15:06:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Huang Ying <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-Id: <20220203150645.9e41e470422eed26d4d77790@linux-foundation.org>
In-Reply-To: <20220202145437.2dd20b71@canb.auug.org.au>
References: <20220202145437.2dd20b71@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 14:54:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/admin-guide/sysctl/kernel.rst:603: WARNING: Malformed table.
> Text in column margin in table line 2.
> 
> = =================================
> 0x0 NUMA_BALANCING_DISABLED
> 0x1 NUMA_BALANCING_NORMAL
> 0x2 NUMA_BALANCING_MEMORY_TIERING
> = =================================
> 
> Introduced by commit
> 
>   49ec6eb41c49 ("NUMA balancing: optimize page placement for memory tiering system")

I assume this fixes?  (With gratuitous grammar fixes)

--- a/Documentation/admin-guide/sysctl/kernel.rst~numa-balancing-optimize-page-placement-for-memory-tiering-system-fix
+++ a/Documentation/admin-guide/sysctl/kernel.rst
@@ -595,14 +595,14 @@ Documentation/admin-guide/kernel-paramet
 numa_balancing
 ==============
 
-Enables/disables and configure automatic page fault based NUMA memory
-balancing.  Memory is moved automatically to nodes that access it
-often.  The value to set can be the result to OR the following,
+Enables/disables and configures automatic page fault based NUMA memory
+balancing.  Memory is moved automatically to nodes that access it often. 
+The value to set can be the result of ORing the following,
 
 = =================================
-0x0 NUMA_BALANCING_DISABLED
-0x1 NUMA_BALANCING_NORMAL
-0x2 NUMA_BALANCING_MEMORY_TIERING
+0 NUMA_BALANCING_DISABLED
+1 NUMA_BALANCING_NORMAL
+2 NUMA_BALANCING_MEMORY_TIERING
 = =================================
 
 Or NUMA_BALANCING_NORMAL to optimize page placement among different
_

