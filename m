Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9447F238
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 06:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhLYFVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 00:21:12 -0500
Received: from regular1.263xmail.com ([211.150.70.197]:43094 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhLYFVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 00:21:11 -0500
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 61F3F1B85;
        Sat, 25 Dec 2021 13:21:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [192.168.1.10] (unknown [111.30.214.151])
        by smtp.263.net (postfix) whith ESMTP id P14038T140177747977984S1640409669296931_;
        Sat, 25 Dec 2021 13:21:09 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 2
X-LOCAL-RCPT-COUNT: 0
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.30.214.151
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <a2157fcba5714bbc0889f36a0a2aee01>
X-System-Flag: 0
Subject: Re: [PATCH] kernel: time: Return ENXIO instead of ENODEV when call
 smp_call_function_single fail in clockevents_unbind
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
References: <20211219152929.479876-1-gchen@itskywalker.com>
From:   Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <b198847b-557e-542f-a3a2-9cc7cab72d45@emindsoft.com.cn>
Date:   Sat, 25 Dec 2021 13:21:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211219152929.479876-1-gchen@itskywalker.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

The original mail was not sent successfully, so I send it again with
another mailbox.

Thanks.

On 12/19/21 11:29 PM, gchen@itskywalker.com wrote:
> From: Chen Gang <gchen@itskywalker.com>
> 
> smp_call_function_single will return -ENXIO for failure, so ENXIO needs
> to be as the default value of cu.res for return instead of ENODEV.
> 
> Signed-off-by: Chen Gang <gchen@itskywalker.com>
> ---
>  kernel/time/clockevents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index 003ccf338d20..59b83bee03e6 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -416,7 +416,7 @@ static void __clockevents_unbind(void *arg)
>   */
>  static int clockevents_unbind(struct clock_event_device *ced, int cpu)
>  {
> -	struct ce_unbind cu = { .ce = ced, .res = -ENODEV };
> +	struct ce_unbind cu = { .ce = ced, .res = -ENXIO };
>  
>  	smp_call_function_single(cpu, __clockevents_unbind, &cu, 1);
>  	return cu.res;
> 


