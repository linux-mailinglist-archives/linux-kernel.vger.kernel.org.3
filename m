Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB3B494E72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbiATM4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:56:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53342 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239164AbiATM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:56:48 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KBRXtV024652;
        Thu, 20 Jan 2022 12:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KH73oVikxkri0uwKyKzuWhsBpGn8CsgMCRrXIp6W2yM=;
 b=KeF+0oimV1cA2O5hzjnG101e0z2+yypuqyGxPsnMOt6YGpyMI3AUClhV8OD58CJaiuux
 AgrXaRGGOI1i4gKybJe+rzOBo8NjiESaULOLJL0V/8lyug+7q+MRXrc5XOrCtV9XQpQt
 NRPZp35395ibVPm+ZNwT2ve6xEMnEWV+TY+Z5T8SGsVANtiWvy/kbiwDvlGxfM2NCh0i
 7LgmlRbzS+qiH+mRzVBPEUTuPPD/buOlDc9ZFR6OvuXVHBbv8LZ0NE/tOBK6sMaPPXhX
 V+5sPX8W5XYpNO/b4JeBSgWhkV0KiHei83vEoSrSTRLBVYPwGuaEgWkoyrxZPxX+Ghm/ GA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq6vs1pb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 12:56:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KCq8Lw026414;
        Thu, 20 Jan 2022 12:56:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3dknwa9hqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 12:56:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KCugnT43516308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 12:56:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E87A11C050;
        Thu, 20 Jan 2022 12:56:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBF7211C052;
        Thu, 20 Jan 2022 12:56:41 +0000 (GMT)
Received: from osiris (unknown [9.145.49.221])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Jan 2022 12:56:41 +0000 (GMT)
Date:   Thu, 20 Jan 2022 13:56:40 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked
 access to user memory
Message-ID: <YelcCEuVbIg9ND90@osiris>
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com>
 <YefeakONMN4PLlml@osiris>
 <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
 <YegQCTqEsiFTUZ2R@osiris>
 <dbfec527-b995-e382-dafa-c3459e1e45ed@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfec527-b995-e382-dafa-c3459e1e45ed@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: De9Z8sc8iogId_IcQJ7QrioIeCIBkji-
X-Proofpoint-ORIG-GUID: De9Z8sc8iogId_IcQJ7QrioIeCIBkji-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_04,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=1 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=221
 clxscore=1015 spamscore=1 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201200065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:34:05AM +0100, Janis Schoetterl-Glausch wrote:
> On 1/19/22 14:20, Heiko Carstens wrote:
> > On Wed, Jan 19, 2022 at 12:02:34PM +0100, Janis Schoetterl-Glausch wrote:
> >>> That's a lot of code churn... I would have expected that the existing
> >>> functions will be renamed, get an additional key parameter, and the
> >>> current API is implemented by defines which map copy_to_user() &
> >>> friends to the new functions, and add a zero key.
> >>
> >> I don't think I understand you. I can implement raw_copy_from/to_user
> >> in terms of raw_copy_from/to_user_with_key, which does save a few lines,
> >> but that's it, isn't it?
> > 
> > Right you are. I only looked at your patch, and forgot about that all
> > the wrapping is nowadays done in common code.
> > 
> > So what I really don't like about this approach is that we get an arch
> > specific copy_to_user() implementation back. This means that all those
> > extra calls like might_fault(), instrument_copy_to_user(), and friends
> > now have to be kept in sync by us again, if new instrumentation or
> > security options are added to common code.
> > 
> > Given that this is manual work / monitoring I'm sure this will not
> > work in the mid or long term, like it has been proven several times in
> > the past for other features. We need something better, which works
> > out-of-the-box wrt common code changes / enhancements.
> 
> What are our options?
> 
> 1. Tooling
>    1.1 Automatic monitoring
>    1.2 ?

No tooling please.

> 2. Implementation changes
>    2.1 Modify common code

In general such changes are done in way that common code is or _may_ be
modified to fulfill our needs. Common code header file explicitely states
that architectures should get rid of private instances of
copy_{to,from}_user() and __copy_{to,from}_user{,_inatomic}().

So we should not add anything like that to arch code again, since nobody
would expect that.

>    2.2 Don't modify common code, pass key argument via well known location

This might also break, and adds complex code and dependencies which should
be avoided.

But maybe you find something else which is nice and easily maintainable.
