Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC7475BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbhLOPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:40:06 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:51860 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243796AbhLOPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639582805; x=1671118805;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vPTxXWtyQPQZHHx15OGOUNr+WYx9qR2s8gHmDJ1KQ10=;
  b=qHPhkwB1omofGoGZ27onDPtjXUQ1IoMM3iTlu6HjTTpIAXQQN9k73mmu
   7d1Qe3/9XH9MuL/2s17HVNbojBnwHTr+nYjiYcb5csvi6ZWLWAcwXO8K6
   NGiU/bjBS7IKMl6ME+f14Ihwp0IT82PBc+/RORIE7WidSo3JAhoK6eXic
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Dec 2021 07:40:04 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 07:40:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 07:40:04 -0800
Received: from [10.216.54.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 15 Dec
 2021 07:40:01 -0800
Subject: Re: [PATCH] mm/madvise: elevate page refcount while isolating in
 process_madvise()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <surenb@google.com>, <vbabka@suse.cz>, <rientjes@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1639571019-30043-1-git-send-email-quic_charante@quicinc.com>
 <Ybnz1+Ljn38cZAlA@casper.infradead.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
Message-ID: <297f6c6b-657c-451f-1458-bff96f803c36@quicinc.com>
Date:   Wed, 15 Dec 2021 21:09:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ybnz1+Ljn38cZAlA@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/2021 7:25 PM, Matthew Wilcox wrote:
> On Wed, Dec 15, 2021 at 05:53:39PM +0530, Charan Teja Reddy wrote:
>> The documentation of isolate_lru_page() says that, "it must be called
>> with an elevated refcount on the page", which is not followed while
>> isolating pages in process_madvise() system call with advise
>> MADV_PAGEOUT. Fix it.
> 
> We hold the mmap_lock over the call to this function, so the reference
> to the page from the page tables cannot go away.  There's no need to
> grab an extra reference here.

Thanks Matthew for clearing such fundamentals.

> 
