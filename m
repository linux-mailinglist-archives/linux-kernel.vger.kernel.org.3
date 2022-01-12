Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B008D48C30D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbiALLY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:24:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352841AbiALLYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:24:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CAuVkG006882;
        Wed, 12 Jan 2022 11:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BDpIW0U6GOzL0hPjy9A7jQvkzxX+o8BnOTG1KTONUDk=;
 b=VmnxEz5XODRzpHSYlqkVWSWo1JrBY6c0PkLOdTS4dzuUl060MW7r8PCcY7aCiHRcKU05
 s+MhSON7x2sTi5PgxNtnxFkCMFD9uWo+Cz1+q9dcoYKFsyxRF0FC8pOaUQKDKsVaB4ru
 miRuIYCobQj085K7W+LIqmdt/sL3NxZ/8893sNvEgpDbHyys+j1G+LiaPZ5B120ki05C
 Js6CTBD7Y3A83OEORGRopYKO7QF0afapWfe/jhjTRohc+Rf2fCq0pcdktYGkGNCnCUM4
 BJyNJh6GHGUoDKMLPSCIdkV0U1zqlG8IkDn3zikwz54ioRbSQzoeBghqGeQ88GV/JKVa +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhwp70yg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 11:24:02 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20CAvW6h011008;
        Wed, 12 Jan 2022 11:24:02 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhwp70ydw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 11:24:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20CBI0V5007138;
        Wed, 12 Jan 2022 11:23:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vj9vb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 11:23:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20CBNuxw39321942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 11:23:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89FDF42066;
        Wed, 12 Jan 2022 11:23:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E31DB42041;
        Wed, 12 Jan 2022 11:23:53 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.195.44.186])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jan 2022 11:23:53 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH v3 0/4]   sched/pelt: Relax the sync of *_sum with *_avg
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20220111134659.24961-1-vincent.guittot@linaro.org>
Date:   Wed, 12 Jan 2022 16:53:52 +0530
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al, naresh.kamboju@linaro.org
Message-Id: <1D84539C-994D-4156-B6C8-BED33EE387B5@linux.vnet.ibm.com>
References: <20220111134659.24961-1-vincent.guittot@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q0ePLwILtUDedh-N2642z0g1K94EaUCF
X-Proofpoint-ORIG-GUID: wAsdZzkD40zxauyiw5Re2VKp8DvfKMdd
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_03,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 11-Jan-2022, at 7:16 PM, Vincent Guittot <vincent.guittot@linaro.org> =
wrote:
>=20
> Rick reported performance regressions in bugzilla because of cpu
> frequency being lower than before:
>    https://bugzilla.kernel.org/show_bug.cgi?id=3D215045
>=20
> He bisected the problem to:
> commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consis=
tent")
>=20
> More details are available in commit message of patch 1.
>=20
> This patchset reverts the commit above and adds several checks when
> propagating the changes in the hierarchy to make sure that we still have
> coherent util_avg and util_sum.
>=20
> Dietmar found a simple way to reproduce the WARN fixed by=20
> commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consis=
tent")
> by looping on hackbench in several different sched group levels.
>=20
> This patchset as run on the reproducer with success but it probably needs
> more tests by people who faced the WARN before.
>=20

I ran scheduler regression tests(including cfg_bandwidth) from LTP
for about 6 hours. I did not observe any (new or previously reported)
kernel warn messages.

Based on this test result for ppc64le
Tested-by: Sachin Sant <sachinp@linux.ibm.com>

-Sachin=
