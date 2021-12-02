Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEFF46667A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358980AbhLBPdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:33:24 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:58709 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238168AbhLBPdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:33:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638459000; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=XvbxBh2JCWUkbGt2tO3QixiLU8kC5/K2VeX/9wAH208=; b=FcRrTvtme1N9PY/bdmxr7gFun8gbFc1+xj8OCYp45ONPvo6CRTVGnrwFc2oRXWMl3QHUd8JL
 TNnyAWOqps8aihVlX+BguF6AIAQ84jm8vuHB5n+sEr7QW3Qp5/APgENzfFl/wNfpNtAhbwTt
 rhRmKD5ivxndHpUBkEWbhzAQrwQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61a8e677db3ac5552a0a9ac0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Dec 2021 15:29:59
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4803DC43635; Thu,  2 Dec 2021 15:29:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.157.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E430DC4360C;
        Thu,  2 Dec 2021 15:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E430DC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for
 shmem
To:     Matthew Wilcox <willy@infradead.org>,
        Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        rientjes@google.com, david@redhat.com, mhocko@suse.com,
        surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
 <YajJqY2ByC8uwa46@casper.infradead.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <a88a3708-cdb6-589c-5828-0a4721c683d7@codeaurora.org>
Date:   Thu, 2 Dec 2021 20:59:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YajJqY2ByC8uwa46@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Matthew for the comments!!

On 12/2/2021 6:57 PM, Matthew Wilcox wrote:
> On Thu, Dec 02, 2021 at 04:20:53PM +0530, Charan Teja Reddy wrote:
>> +static int shmem_fadvise_willneed(struct address_space *mapping,
>> +				 pgoff_t start, pgoff_t long end)
>> +{
>> +	XA_STATE(xas, &mapping->i_pages, start);
>> +	struct page *page;
>> +
>> +	rcu_read_lock();
>> +	page = xas_find(&xas, end);
>> +	rcu_read_unlock();
>> +
>> +	while (page) {
>> +		if (xa_is_value(page)) {
>> +			page = shmem_read_mapping_page(mapping, xas.xa_index);
>> +			if (!IS_ERR(page))
>> +				put_page(page);
>> +		}
>> +
>> +		if (need_resched()) {
>> +			xas_pause(&xas);
>> +			cond_resched();
>> +		}
>> +
>> +		rcu_read_lock();
>> +		page = xas_next_entry(&xas, end);
>> +		rcu_read_unlock();
>> +	}
>> +
>> +	return 0;
>> +}
> 
> What part of the XArray documentation led you to believe that this is a
> safe thing to do?  Because it needs to be rewritten immediately!

The above code changes made from my understanding of both the
Documentation and the implementation of xa_for_each(). The Locking
section of the document[1] says that xa_for_each() takes the rcu lock
thus can be used without any explicit locking and the "Advanced API"
section says that users need to take xa_lock/rcu lock as no locking done
for you.

Further I have looked at the xa_for_each() implementation details,
where, it is taking the rcu_lock just across xas_find() in both
xa_find() and xa_find_after() which made me to think that it just needs
to take the rcu lock just across the xas_find().

But a comment from you saying that this implementation is wrong making
me to think that I lack very trivial understanding about xarray usage.

[1] https://www.kernel.org/doc/html/latest/core-api/xarray.html

> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
