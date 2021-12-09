Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F9946F775
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhLIXfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:35:07 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53127 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229760AbhLIXfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:35:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V-5ZzRI_1639092689;
Received: from 192.168.2.97(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0V-5ZzRI_1639092689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 07:31:30 +0800
Message-ID: <bac7b124-9087-1712-c88a-fac54f3d2cc0@linux.alibaba.com>
Date:   Fri, 10 Dec 2021 07:31:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH 6/7] workqueue: Remove the cacheline_aligned for
 nr_running
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
 <20211207073543.61092-7-jiangshanlai@gmail.com>
 <YbJ+E+HB+UCYHxSi@slm.duckdns.org>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <YbJ+E+HB+UCYHxSi@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/10 06:07, Tejun Heo wrote:
> On Tue, Dec 07, 2021 at 03:35:42PM +0800, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> nr_running is never modified remotely after the schedule callback in
>> wakeup path is removed.
>>
>> Rather nr_running is often accessed with other fields in the pool
>> together, so the cacheline_aligned for nr_running isn't needed.
> 
> Does it even need to be atomic anymore?
> 

It doesn't need to be atomic, it is only modified in its associated CPU
in process context.
