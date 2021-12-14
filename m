Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B48474699
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhLNPiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:38:25 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36524 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234470AbhLNPiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:38:20 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEE7ZFO021142;
        Tue, 14 Dec 2021 16:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=55TRlyPa1csvltjFSGJc7MC8zSTcqi9KhSJ8TqVGvPo=;
 b=n4+2qguQFrO2LYPE3fxelbRizl65JB5BEn63gFRrVQmTMRUTJDZ66gtp4iEFhwdVz7X7
 fbajk/6aI96BMvzNELKmpPIJsB/of0mFT88fv5jJus/KUlRFl9a3ydTEsQlI9XAdz4Gb
 mHuUm+7sk3df/dZ1fARuuxutN8fI0F7nusZKlc2kyd/LoatRFmwBrtHyxBFyVQC3iVH7
 j4aI1G4Na2zhfKFP+w1JAe8IDFA/zVS3ShfCa8w131v2mTZIdwI0IZJlnxrwxDgygerf
 oJI8FqZW8myIDqstxY4mGQ2bFaXnMAIZUmoWVzjGcURYbUX7P05yZWigPjE0rAd96fx5 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cxr8rabpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 16:38:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B8A910002A;
        Tue, 14 Dec 2021 16:38:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E662231DEF;
        Tue, 14 Dec 2021 16:38:08 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 14 Dec
 2021 16:38:07 +0100
Subject: Re: [PATCH] tty: rpmsg: Fix race condition releasing tty port
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20211213195346.12894-1-arnaud.pouliquen@foss.st.com>
 <8bbd1a77-5f88-bb97-db88-6842df2e3e3c@kernel.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <2008dd33-5d23-961c-ca61-53ff3e34479a@foss.st.com>
Date:   Tue, 14 Dec 2021 16:38:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8bbd1a77-5f88-bb97-db88-6842df2e3e3c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiri,

On 12/14/21 7:43 AM, Jiri Slaby wrote:
> Hi,
> 
> On 13. 12. 21, 20:53, Arnaud Pouliquen wrote:
>> In current implementation the tty_port struct is part of the
>> rpmsg_tty_port structure.The issue is that the rpmsg_tty_port structure is
>> freed on rpmsg_tty_remove but also referenced in the tty_struct.
>> Its release is not predictable due to workqueues.
>>
>> For instance following ftrace shows that rpmsg_tty_close is called after
>> rpmsg_tty_release_cport:
>>
>>       nr_test.sh-389     [000] .....   212.093752: rpmsg_tty_remove <-rpmsg_dev_
>> remove
>>               cat-1191    [001] .....   212.095697: tty_release <-__fput
>>        nr_test.sh-389     [000] .....   212.099166: rpmsg_tty_release_cport <-rpm
>> sg_tty_remove
>>               cat-1191    [001] .....   212.115352: rpmsg_tty_close <-tty_release
>>               cat-1191    [001] .....   212.115371: release_tty <-tty_release_str
>>
>> As consequence, the port must be free only when user has released the TTY
>> interface.
>>
>> This path (inspired from vcc.c):
>> - moves the management of the port in the install and clean-up tty ops,
>> - allocates the tty_port struct independently of the rpmsg_tty_port structure,
> 
> This looks rather wrong. Why not to use tty_port refcounting?

Please could you detail what seems rather wrong for you? Everything or do the
tty_port port struct independently of the rpmsg_tty_port structure?

Concerning the tty_port refcounting:
Yes it also an option that I have already tried without success, before
implementing this patch.
That said, as you pointed it out, I reimplemented it today in another way, and
this time it seems that it works without any runtime warning or error.
I need to perform more test to confirm, then I will propose a V2 based on
tty_port refcountingt and the .destruct tty_port_operations.

> 
>> - uses tty_vhangup and tty_port_hangup.
> 
> OK, but don't store a tty pointer as it looks racy. You should use
> tty_port_tty_get instead.
> 
> Hm, we look we need tty_port_tty_vhangup (aside from tty_port_tty_hangup). There
> are plenty of drivers doing:
>     tty = tty_port_tty_get(port);
>     if (tty) {
>             tty_vhangup(port->tty);
>             tty_kref_put(tty);

I would like to first fix the issue in rpmsg_tty.c in separate thread.
But yes this should not take me too much time to propose this helper next.

Thanks,
Arnaud

> 
> 
>> Fixes: 7c0408d80579 ("tty: add rpmsg driver")
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> 
> thanks,
