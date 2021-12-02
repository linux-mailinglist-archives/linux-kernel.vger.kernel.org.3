Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09D846652B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbhLBOZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:25:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240661AbhLBOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:25:57 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2EGlrI022505;
        Thu, 2 Dec 2021 14:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=LigJoAsyjkUS2Od9a26ACC6GuOYoN8/UQjce2qAebvs=;
 b=a+Cj/seyF3yyTqxhwjwbrKeHMSx/fGXnj1o3PdmyiKN6qQWrYQIcke79yPzOZQwH4DpM
 oXcT668/9lDVzacnKltdFa9Bvc+IIm546P86cnWg1nxmeRacrNj2H7L420MLvOBpTmDw
 0/0zuGWobq4Pe8K6ktmYoaHp61gFcdPd0mcYMcdXiPmVzU/57nUkVbDS3s9eqJm0yDtR
 rb1R7/zXZn16fzF9Dw1iaZIc7cnlNCGcmqwjMrLvY+WfBiT62P54B3jRTfdCR4ae1nYY
 Kq1sNzxgspWbm0Amn/vOsAbRWcKmmAiv/c5OFbqAcuGw4qWvXjZP7CSKtMJFhK52qRVj jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpys2g30k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 14:22:13 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2EJuMk004813;
        Thu, 2 Dec 2021 14:22:12 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpys2g2yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 14:22:12 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2EJAkt007289;
        Thu, 2 Dec 2021 14:22:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3ckbxkatrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 14:22:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2EM7Tf27066712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 14:22:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFAA44204C;
        Thu,  2 Dec 2021 14:22:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E1FA42045;
        Thu,  2 Dec 2021 14:22:07 +0000 (GMT)
Received: from osiris (unknown [9.145.32.23])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Dec 2021 14:22:07 +0000 (GMT)
Date:   Thu, 2 Dec 2021 15:22:05 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
Message-ID: <YajWjasdqnibSRJm@osiris>
References: <20211129130309.3256168-1-hca@linux.ibm.com>
 <YaTdpsVCDQMlscON@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaTdpsVCDQMlscON@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CMoPkhQCvrhV1qM0Scb7LelJbCrMpaiF
X-Proofpoint-GUID: tWNBBNbwOyLDVXD09Pl01x3YvW6mNIZ0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_08,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=880 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 03:03:18PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 29, 2021 at 02:03:06PM +0100, Heiko Carstens wrote:
> > v2:
> > As requested by Greg KH: avoid negative logic and use uppercase defines.
> > 
> > v1:
> > Create die and cluster cpu topology sysfs attributes only if an
> > architecture makes uses of it, instead of creating them always for all
> > architectures with bogus default values.
> > Also change the book and drawer cpu topology macros so they match all
> > all other topology macros.
> > 
> > v1: https://lore.kernel.org/lkml/20211128212221.1069726-1-hca@linux.ibm.com/
> > 
> > Heiko Carstens (3):
> >   topology/sysfs: export die attributes only if an architectures has support
> >   topology/sysfs: export cluster attributes only if an architectures has support
> >   topology/sysfs: rework book and drawer topology ifdefery
> > 
> >  Documentation/admin-guide/cputopology.rst | 33 +++++++++++------------
> >  drivers/base/topology.c                   | 28 ++++++++++++++-----
> >  include/linux/topology.h                  | 25 +++++++++++++++++
> >  3 files changed, 62 insertions(+), 24 deletions(-)
> 
> Seems entirely reasonable to me,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Since there seem to be no objections, who should pick this up?
I'd assume the s390 tree would not be appropriate.

Andrew, Greg, Peter?
