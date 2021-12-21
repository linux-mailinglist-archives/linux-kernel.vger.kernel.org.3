Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6347C155
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhLUOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:19:10 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58708 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235448AbhLUOTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:19:08 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BL9m9ri031016;
        Tue, 21 Dec 2021 15:19:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Ne4xZt4WaaOmRccD8H/aG3fcyOqrhCzBoBiBiz/kLxU=;
 b=WP82BkSGcyUjqemKGD/sOdvZqJuYhvXi7BzeXSSyMD6fbdk/6/BdYJAeHgFt7WZnMyU1
 iXwbkoD3GowWXvX5IbCx+KuasiFvB+eVEoPm7mAnUKXoTQHLox/yD2dUaQW6lrhHy3up
 3+dTfiSIZFpGFM6YyMrkUYqqnyXrUjwMdfjoLWPFHfldoDeIjWdyqgqcfajRZsll4evJ
 25vuuXUlh4MxnuvKTm5+/V8KiMnxEjA/5EuX58Uxg3l2XNwObpe/zFkjaoEO6hm3tht6
 9qcb5L/u3iWHadCGm4lCqdxhKO9Vy5xUjeyRcV6DmrAvrjvnaHgMXFC9npnzvdow91en iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d37emu4q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 15:19:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D12010002A;
        Tue, 21 Dec 2021 15:18:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60D7E20B85E;
        Tue, 21 Dec 2021 15:18:59 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 21 Dec
 2021 15:18:58 +0100
Subject: Re: [PATCH v3] tty: rpmsg: Fix race condition releasing tty port
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20211215153121.30010-1-arnaud.pouliquen@foss.st.com>
 <YcGN0fDn2hqAdrP9@kroah.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <318a02fe-0317-d27e-06bc-61bdb8feec79@foss.st.com>
Date:   Tue, 21 Dec 2021 15:18:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcGN0fDn2hqAdrP9@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,


On 12/21/21 9:18 AM, Greg Kroah-Hartman wrote:
> On Wed, Dec 15, 2021 at 04:31:21PM +0100, Arnaud Pouliquen wrote:
>> The tty_port struct is part of the rpmsg_tty_port structure.
>> The issue is that the rpmsg_tty_port structure is freed on
>> rpmsg_tty_remove while it is still referenced in the tty_struct.
>> Its release is not predictable due to workqueues.
>>
>> For instance following ftrace shows that rpmsg_tty_close is called after
>> rpmsg_tty_release_cport:
>>
>>      nr_test.sh-389     [000] .....   212.093752: rpmsg_tty_remove <-rpmsg_dev_
>> remove
>>              cat-1191    [001] .....   212.095697: tty_release <-__fput
>>       nr_test.sh-389     [000] .....   212.099166: rpmsg_tty_release_cport <-rpm
>> sg_tty_remove
>>              cat-1191    [001] .....   212.115352: rpmsg_tty_close <-tty_release
>>              cat-1191    [001] .....   212.115371: release_tty <-tty_release_str
>>
>> As consequence, the port must be free only when user has released the TTY
>> interface.
>>
>> This path :
>> - Introduce the .destruct port ops function to release the allocated
>>   rpmsg_tty_port structure.
>> - Manages the tty port refcounting to trig the .destruct port ops,
>> - Introduces the rpmsg_tty_cleanup function to ensure that the TTY is
>>   removed before decreasing the port refcount.
>> - Uses tty_vhangup and tty_port_hangup instead of tty_port_tty_hangup.
> 
> Shouldn't this hangup change be a separate change?

Thanks for pointing this!

My first answer was that this is part of the fix to make the hangup synchronous.
But making more tests I'm not able to reproduce the reproduce the race issue
using tty_port_tty_hangup.

I don't master enough the TTY framework to know if using tty_vhangup is safer...
The difference between tty_vhangup and tty_hangup seems only that __tty_hangup
is directly called in tty_vhangup while a work is created in tty_hangup.

But after that tty_kref_put calls queue_release_one_tty making the rest of the
release asynchronous. And this last part of the release is the cause of the race
condition i observed.

So i propose to just drop this part and keep the use of tty_port_tty_hangup.

The alternative is to add it in a separate patch as you propose. But from now I
have not more rational.

Any advice is welcome!

> 
>>
>> Fixes: 7c0408d80579 ("tty: add rpmsg driver")
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> delta vs V2: taking into account Jiri Slaby's comments:
>>  - Inline rpmsg_tty_release_cport in rpmsg_tty_destruct_port,
>>  - call tty_port_put in case of error in rpmsg_tty_probe,
>>  - use tty_port_get port return in rpmsg_tty_install to take into account
>>    NULL port return case.
>>
>> Applied and tested on fa55b7dcdc43 ("Linux 5.16-rc1", 2021-11-14)
>> ---
>>  drivers/tty/rpmsg_tty.c | 49 +++++++++++++++++++++++++++++------------
>>  1 file changed, 35 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
>> index dae2a4e44f38..cdc590c63f03 100644
>> --- a/drivers/tty/rpmsg_tty.c
>> +++ b/drivers/tty/rpmsg_tty.c
>> @@ -50,10 +50,21 @@ static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len, void *p
>>  static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>>  {
>>  	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
>> +	struct tty_port *port = tty->port;
>>  
>>  	tty->driver_data = cport;
>>  
>> -	return tty_port_install(&cport->port, driver, tty);
>> +	port = tty_port_get(&cport->port);
>> +	return tty_port_install(port, driver, tty);
>> +}
>> +
>> +static void rpmsg_tty_cleanup(struct tty_struct *tty)
>> +{
>> +	struct tty_port *port = tty->port;
>> +
>> +	WARN_ON(!port);
> 
> How can this ever trigger?  Shouldn't you do something if it can?

Over-protection i will suppress it.

Thanks and Regards,
Arnaud

> 
> thanks,
> 
> greg k-h
> 
