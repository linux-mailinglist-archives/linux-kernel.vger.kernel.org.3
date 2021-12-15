Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA44755C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbhLOKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:05:42 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41936 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236515AbhLOKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:05:39 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF8xctf015267;
        Wed, 15 Dec 2021 11:05:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=3BmR+IunfXlXTt4gyyNN854tdQIgeq49/tg0NzOw1sQ=;
 b=l2jYnSVWXey8pRiDuQw4YH4DuQVxXo3jqJkwJcbVK37Le0q8hwUdzuj+kUf96Jk/3LK1
 FvrSsXTIWQkMEneDrNoPNbFsj3hibP6w38qdfACestZ6GG37qqD4oL6D+MoBLbqzVvKH
 utgoDUvyMx6jeB2KOsjmxv7xsHcIwNk8UW2V7gPJngmAOEJevFFEMBkNdIuib4EJZxmA
 ZqnTKuMR5RnK0pcymYxpRuUKGMCLmQa42Jp+2bNRbWywQsRGw3wwal1vaK2DpMHmQfmm
 X6K+JWxk9845ZMqJ9HDWbQA8nKWM0QffWdZqUfNT+4peTTiS1e74aLaNnpKC9dlo3njN BA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cxrthxptn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 11:05:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B75B10002A;
        Wed, 15 Dec 2021 11:05:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BE06222682C;
        Wed, 15 Dec 2021 11:05:27 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec
 2021 11:05:27 +0100
Subject: Re: [PATCH v2] tty: rpmsg: Fix race condition releasing tty port
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20211214170646.25775-1-arnaud.pouliquen@foss.st.com>
 <3fc784f1-5985-1553-c39f-8472cb63b1af@kernel.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <250fd384-1dde-e800-2bac-ca37e53d50a2@foss.st.com>
Date:   Wed, 15 Dec 2021 11:05:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3fc784f1-5985-1553-c39f-8472cb63b1af@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_07,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/21 7:49 AM, Jiri Slaby wrote:
> Hi,
> 
> much better IMO.
> 
> On 14. 12. 21, 18:06, Arnaud Pouliquen wrote:
>> In current implementation the tty_port struct is part of the
>> rpmsg_tty_port structure.The issue is that the rpmsg_tty_port structure is
>> freed on rpmsg_tty_remove but also referenced in the tty_struct.
>> Its release is not predictable due to workqueues.
>>
>> For instance following ftrace shows that rpmsg_tty_close is called after
>> rpmsg_tty_release_cport:
> ...
>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
>> index dae2a4e44f38..69272ad92266 100644
>> --- a/drivers/tty/rpmsg_tty.c
>> +++ b/drivers/tty/rpmsg_tty.c
>> @@ -53,9 +53,19 @@ static int rpmsg_tty_install(struct tty_driver *driver,
>> struct tty_struct *tty)
>>         tty->driver_data = cport;
>>   +    tty_port_get(&cport->port);
> 
> Can't this fail? Like when racing with removal?
> 
>>       return tty_port_install(&cport->port, driver, tty);
>>   }
> ...
>>   static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
>> @@ -139,6 +156,8 @@ static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
>>     static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
>>   {
>> +    tty_port_destroy(&cport->port);
>> +
> 
> You should not call tty_port_destroy when you use refcounting. The port is
> already destroyed when ->destruct() is called. (It has currently no bad effect
> calling it twice on a port though.)
> 
>> @@ -146,7 +165,17 @@ static void rpmsg_tty_release_cport(struct rpmsg_tty_port
>> *cport)
>>       kfree(cport);
>>   }
>>   -static const struct tty_port_operations rpmsg_tty_port_ops = { };
>> +static void rpmsg_tty_destruct_port(struct tty_port *port)
>> +{
>> +    struct rpmsg_tty_port *cport = container_of(port, struct rpmsg_tty_port,
>> port);
>> +
>> +    rpmsg_tty_release_cport(cport);
>> +}
>> +
>> +static const struct tty_port_operations rpmsg_tty_port_ops = {
>> +    .destruct = rpmsg_tty_destruct_port,
>> +};
>> +
>>     static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
>>   {
>> @@ -179,7 +208,6 @@ static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
>>       return 0;
>>     err_destroy:
>> -    tty_port_destroy(&cport->port);
>>       rpmsg_tty_release_cport(cport);
> 
> Couldn't you just put the port here? And inline rpmsg_tty_release_cport into the
> new rpmsg_tty_destruct_port?
> 

Thanks for all the insightful comments, V3 is coming.

> thanks,
