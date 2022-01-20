Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB20A49540C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbiATST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:19:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233332AbiATST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:19:27 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KGM1Zh001474;
        Thu, 20 Jan 2022 18:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WPFpWAdP7and+FKr6Wq+Q68wA2Yfmcy0zvGP+nmcYPU=;
 b=rAuq4hg18XaaZqnbUxpEI75F161TrQFsLe+QEoPiM8Z3Up5rgypdpSFfxYexSffsq9B9
 b3skQ/dgyv5lTQrCoDbeOVeRDwI1OSC9EazBe8Fbdkmzo/8r1F9y0vTSTF3VmFA7rxoo
 m8bXnDn+RzcwK1J4rSHDIa2uzvABlhyORJ8WlfNxAlzA/v7mmb8rieH2SrKKzNizyDM3
 A6ZPKd9bzZN41zlvw/Uq4ieGIXXiOfBr3HgXOq0zKUqG9RMmGFM/bDpo5rL4dtg2Oguk
 HV8+xVwNbtgxM2JJmNAhgh8pXof0m8yLHZ2egb/9ZHJJk+Aoib+sv/mSMZMM+/M1YL5D 8w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq60e2me4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 18:19:26 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KI4Kd2014630;
        Thu, 20 Jan 2022 18:19:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3dknwac4ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 18:19:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KIJKk338011292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 18:19:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8679A4C058;
        Thu, 20 Jan 2022 18:19:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25A874C040;
        Thu, 20 Jan 2022 18:19:20 +0000 (GMT)
Received: from osiris (unknown [9.145.85.126])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Jan 2022 18:19:20 +0000 (GMT)
Date:   Thu, 20 Jan 2022 19:19:18 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked
 access to user memory
Message-ID: <YemnprCIEjjGFeTn@osiris>
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com>
 <YefeakONMN4PLlml@osiris>
 <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
 <YegQCTqEsiFTUZ2R@osiris>
 <dbfec527-b995-e382-dafa-c3459e1e45ed@linux.ibm.com>
 <YelcCEuVbIg9ND90@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YelcCEuVbIg9ND90@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wO7_9hgtjWZi7Q1IkVvIssjmPN7AVpE6
X-Proofpoint-GUID: wO7_9hgtjWZi7Q1IkVvIssjmPN7AVpE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_07,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=729 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 01:56:40PM +0100, Heiko Carstens wrote:
> > 2. Implementation changes
> >    2.1 Modify common code
> 
> In general such changes are done in way that common code is or _may_ be
> modified to fulfill our needs. Common code header file explicitely states
> that architectures should get rid of private instances of
> copy_{to,from}_user() and __copy_{to,from}_user{,_inatomic}().
> 
> So we should not add anything like that to arch code again, since nobody
> would expect that.

Or to be more specific: I think the most simple solution would be to
try to get the new *key variants into include/linux/uaccess.h, and add
the raw variants in architecture code, similar to the rest of the
uaccess functions.
There is some (sort of) prior art with copy_mc_to_kernel() even,
though that can only partially be compared.
