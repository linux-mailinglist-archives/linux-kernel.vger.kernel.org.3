Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8A48B906
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiAKU4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:56:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235721AbiAKU4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:56:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BJfXX4020890;
        Tue, 11 Jan 2022 20:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=svlmJbpUX2e8JK6OzGZT1TZV7gHvUC5eHWnRMvjIchs=;
 b=RtL1CKY6rLVARY5ItP9PL1klRLWhPNOk1J7pOBoyHYmEfDW0cmb6Be+0Oxo93ntIZVOs
 uvW7rSIIkF0RvCr+BhvG9YjS4kDfBe2C/ZBDATEkybSwqxWzRgGMfEPnFFbZYf8/4op9
 DhdpcBSJ0HU6NQs8ezTGLL0EfsME+8U36iewBMvN9VcItqDo6nw2Lq9/P9fFGegCTD70
 fZYzcndiOXhS0N3/J7TjI7TjLYYfq7kUh51yJ7KFr80nf565TCmigkjmnR31xkB+lQ3u
 pmq+vFY/e+jYcjZKE/BXw65rMqmCJUX0QWYTTfkeJyA8dfupTMIQ1XUzn1TJmjfpdGac fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dh79m7e0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 20:55:59 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20BKrpC2012606;
        Tue, 11 Jan 2022 20:55:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dh79m7e07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 20:55:58 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20BKYuik008572;
        Tue, 11 Jan 2022 20:55:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3df2893ppj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 20:55:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20BKtsHK39453182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 20:55:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FAC852051;
        Tue, 11 Jan 2022 20:55:54 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id B99A75204F;
        Tue, 11 Jan 2022 20:55:53 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Steven Rostedt'" <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, hca@linux.ibm.com,
        deller@gmx.de
Subject: Re: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <7a0fefb7ed3542b4a49dee1e78b1668b@AcuMS.aculab.com>
Date:   Tue, 11 Jan 2022 21:55:53 +0100
In-Reply-To: <7a0fefb7ed3542b4a49dee1e78b1668b@AcuMS.aculab.com> (David
        Laight's message of "Mon, 10 Jan 2022 21:58:33 +0000")
Message-ID: <yt9d8rvmt2jq.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: otBth3hfpkxLP2S9L--6Ygj5HsHcUx9P
X-Proofpoint-ORIG-GUID: zHr6rvdlcGGuk4moORQc2G2gCg4CZOaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxlogscore=940 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1011 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: Steven Rostedt
>> Sent: 10 January 2022 17:25
> ...
>> > ...
>> > > +	if (likely((unsigned long)str >= TASK_SIZE)) {
>> > > +		/* For safety, do not trust the string pointer */
>> > > +		if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
>> > > +			return NULL;
>> > > +	} else {
>> > > +		/* user space address? */
>> > > +		ustr = (char __user *)str;
>> > > +		if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
>> > > +			return NULL;
>> >
>> > Is that check against TASK_SIZE even correct for all architectures?
>> > copy_to/from_user() uses access_ok() - which is architecture dependant.
>> 
>> The problem with access_ok() (which I tried first) is that it can't be used
>> from interrupt context, and this check can happen in interrupt context.
>> Either way, if we pick the wrong one for the arch, the only thing bad that
>> can happen is that it returns "fault" and the filter fails, just like if
>> the pointer was to bad memory.
>
> Isn't there also at least one architecture where you can't differentiate
> between user and kernel pointers by looking at the address?
> (Something like sparc ASI is used for user accesses so both user
> and kernel get the full 4G address range. But it isn't sparc (or pdp/11))
> ISTR it causing issues with the code for kernel_setsockopt() and
> required a separate flag.

On s390 TASK_SIZE is defined as -PAGE_SIZE, so with the patch above the
kernel would always try to fetch it from user space. I think it would be
the same for parisc.

> Put that together with something that needs user_access_begin()
> to bracket user accesses and you probably fail big-time.
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
