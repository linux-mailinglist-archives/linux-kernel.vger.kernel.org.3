Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355BC4676DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380624AbhLCL7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:59:16 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:44889 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhLCL7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:59:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638532547; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=bOt1H8z2j6YG1dWnvdF0egJwtTskF4YHLm3gfLlMM9o=; b=jvymMW5Y4hoZ0f12hL+477z5QKUTrgziIICdoim5kw/2wInp96oBqkxRilce+hSGC6HOJs1i
 a9hq1upUDCvGHtSh9VwLgN9HjLGaELT0Tgnxi7frVt+79/QM/1m8phZgwcICwtiQNwkydQYM
 C+Zr2RE7v/nWs9uZuqprWjx5bOk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 61aa05c3642caac318d661f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Dec 2021 11:55:47
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC36AC43618; Fri,  3 Dec 2021 11:55:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.157.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDF66C4360D;
        Fri,  3 Dec 2021 11:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CDF66C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for
 shmem
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Charan Teja Reddy <quic_charante@quicinc.com>, hughd@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        david@redhat.com, mhocko@suse.com, surenb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
 <YajJqY2ByC8uwa46@casper.infradead.org>
 <a88a3708-cdb6-589c-5828-0a4721c683d7@codeaurora.org>
 <YajsJSejHlx8n11U@casper.infradead.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <04ca54ad-0e03-84b1-bf5c-131a582137d4@codeaurora.org>
Date:   Fri, 3 Dec 2021 17:25:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YajsJSejHlx8n11U@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

()

On 12/2/2021 9:24 PM, Matthew Wilcox wrote:
> Would this change to the documentation have prevented you from making
> this mistake?
> 
>  The advanced API is based around the xa_state.  This is an opaque data
>  structure which you declare on the stack using the XA_STATE()
>  macro.  This macro initialises the xa_state ready to start walking
>  around the XArray.  It is used as a cursor to maintain the position
>  in the XArray and let you compose various operations together without
> -having to restart from the top every time.
> +having to restart from the top every time.  The contents of the xa_state
> +are protected by the rcu_read_lock() or the xas_lock().  If you need to
> +drop whichever of those locks is protecting your state and tree, you must
> +call xas_pause() so that future calls do not rely on the parts of the
> +state which were left unprotected.

Yes, this looks much clear to me.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
