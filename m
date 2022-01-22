Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2356496B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiAVJRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:17:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231895AbiAVJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:17:41 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20M9Bgkf007078;
        Sat, 22 Jan 2022 09:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Q7VvnvE5MhJQ+AWMk6InaAk4oMHjaVevK214V+6F6G4=;
 b=T//+29+QkdgnFrxwFh6OQEDAOR0ud2v5tPeZt4RHj87lywHqNN6uC9c/JN/06UkMSnor
 0vPoUMLxwV2xqpa6er8jC9qwv0uroaPbyHHDx0KlJvu88sz+Qhr9ueP5mXOqV4RBBDEG
 u2Op/KCxPirGiulQDyylprzbJTvLIEZAApxNPSjqDtREZJRGc7+4R3ItMUv1RqoanLS0
 Vfy0+lRB9FMbe5TZ7BUjlJWVE6CrvfRuxjDsoOTLVMeVTIflmMPukpvZMUjf90NFoZKt
 zEtMddSW4Z5WCvEYgZjf8gvM/QWwZdCVL878J1jwDZ0X21KeWahDvOa7Kj6hV4ehNjaG ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3drf2t820h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jan 2022 09:17:20 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20M9HJGS022644;
        Sat, 22 Jan 2022 09:17:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3drf2t8204-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jan 2022 09:17:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20M9C38o000397;
        Sat, 22 Jan 2022 09:17:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j8h9em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jan 2022 09:17:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20M9HEb537028312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 09:17:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7028A405B;
        Sat, 22 Jan 2022 09:17:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67AFCA4053;
        Sat, 22 Jan 2022 09:17:14 +0000 (GMT)
Received: from osiris (unknown [9.145.25.22])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 22 Jan 2022 09:17:14 +0000 (GMT)
Date:   Sat, 22 Jan 2022 10:17:12 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Yinan Liu <yinan@linux.alibaba.com>, peterz@infradead.org,
        mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v8] scripts: ftrace - move the sort-processing in
 ftrace_init
Message-ID: <YevLmJd48FPx9XcT@osiris>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211212113358.34208-1-yinan@linux.alibaba.com>
 <20211212113358.34208-2-yinan@linux.alibaba.com>
 <yt9dee51ctfn.fsf@linux.ibm.com>
 <YeqOFHNfxKcNXNrn@osiris>
 <20220121131148.2025bc5b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121131148.2025bc5b@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VeA7NAn_I-eHAM94W-ob5PJS08bjBQ5m
X-Proofpoint-ORIG-GUID: 8SoNnnmkyAY1FnkhczCnpfZEOC2w91Rm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-22_03,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=894 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201220060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:11:48PM -0500, Steven Rostedt wrote:
> On Fri, 21 Jan 2022 11:42:28 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > This really should be addressed before rc1 is out, otherwise s390 is
> > broken if somebody enables ftrace.
> > Where "broken" translates to random crashes as soon as ftrace is
> > enabled, which again is nowadays quite common.
> 
> Instead of reverting, should we just add this patch?

That would work as well.

Tested-by: Heiko Carstens <hca@linux.ibm.com>
