Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4891F467F07
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353782AbhLCVFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:05:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54246 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbhLCVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:05:39 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91CF7B82956
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 21:02:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC8E560E73;
        Fri,  3 Dec 2021 21:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638565333;
        bh=Aae9TRQcpxW4Yd/zp6n3Lm0pw3x2oan07wBnj/exvvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lMampx88aTxtbor/T9R7heUFlzc8mQaYeSKx12NonB7PAIBzqIin1zn6gBxNnAxM8
         WnmiSiaB3PJ4807w9faKlQ+SlYhy+wgsGnZSXL5rqjfvk3y34AGG6t4HjLqHqo0cRW
         SHRbyBQKSCbeDsif7YBNjHqXlvDkxr5hsedq2Huo=
Date:   Fri, 3 Dec 2021 13:02:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     yongw.pur@gmail.com
Cc:     bsingharora@gmail.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn
Subject: Re: [PATCH linux-next] delayacct: track delays from memory compact
Message-Id: <20211203130210.f34079f175f28bd1c5c26541@linux-foundation.org>
In-Reply-To: <1638542272-15187-1-git-send-email-wang.yong12@zte.com.cn>
References: <1638542272-15187-1-git-send-email-wang.yong12@zte.com.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Dec 2021 06:37:52 -0800 yongw.pur@gmail.com wrote:

> From: wangyong <wang.yong12@zte.com.cn>
> 
> Delay accounting does not track the delay of memory compact.
> When there is not enough free memory, tasks can spend
> a amount of their time waiting for memory compact.
> 
> To get the impact of tasks in direct memory compact, measure
> the delay when allocating memory through memory compact.
> 
> ...
>
> --- a/include/linux/delayacct.h
> +++ b/include/linux/delayacct.h
> @@ -42,8 +42,13 @@ struct task_delay_info {
>  	u64 thrashing_start;
>  	u64 thrashing_delay;	/* wait for thrashing page */
>  
> +	u64 compact_start;
> +	u64 compact_delay;	/* wait for memory compact */
> +
> +	u64 freepages_start;

task_delay_info already has a freepages_start, so it fails to compile.

Did you send the correct version?

