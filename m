Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB2461D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbhK2STv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:19:51 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:11796 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344823AbhK2SRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638209671; x=1669745671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F39v39L3voprfUnqtU9BVdYRaFEDQSbMeiIU98VHQTQ=;
  b=w7ELvVJHEx5YWd10A1n8qtFETQQoo+efTmcLdBI4wCkYKB+1Ddzg0/H/
   /NYnX2bLF9kyRXBW7BT2b3snMp6CC1ZiaM+GoHPibcQCLQJN+bkdi1cLE
   kHK6EdM2TWF2D2OBuZy2FwyNlx35FBEKg/Vpyi0hP6ESnzZQRhe5UDslL
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 29 Nov 2021 10:14:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 10:14:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 10:14:30 -0800
Received: from [10.48.241.137] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 29 Nov
 2021 10:14:29 -0800
Message-ID: <03299e9a-56aa-6ce2-f5a1-38b35ad11dec@quicinc.com>
Date:   Mon, 29 Nov 2021 10:14:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] clk: Fix children not voting entire parent chain during
 init
Content-Language: en-US
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211109043438.4639-1-quic_mdtipton@quicinc.com>
From:   Mike Tipton <quic_mdtipton@quicinc.com>
In-Reply-To: <20211109043438.4639-1-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2021 8:34 PM, Mike Tipton wrote:
> If a child's parent is set by calling __clk_init_parent() while the
> parent is still being registered in __clk_register(), then it can result
> in the child voting its direct parent without those votes propagating up
> the entire parent chain.
> 
> __clk_register() sets hw->core before grabbing the prepare_lock and
> before initializing hw->core->parent. Since hw->core is used indirectly
> by __clk_init_parent(), then children can find their parents before
> they're fully initialized. If children vote for their parents during
> this window, then those votes won't propagate past the direct parent.
> 
> This can happen when:
>      1. CRITICAL clocks are enabled in __clk_core_init().
>      2. Reparenting enabled orphans in clk_core_reparent_orphans_nolock().
> 
> Fix this by not setting hw->core until we've already grabbed the
> prepare_lock in __clk_core_init(). This prevents orphaned children from
> finding and voting their parents before the parents are fully
> initialized.
> 
> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---
> 
> This is very difficult to reproduce. We can't reproduce it at all
> internally, in fact. But some customers are able to reproduce it fairly
> easily and this patch fixes it for them.
> 
>   drivers/clk/clk.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 

Reminder. We've had more reports of this and in each case this patch 
fixes the problem.
