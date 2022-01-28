Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FBF49FDA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349777AbiA1QJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:09:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234788AbiA1QJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:09:27 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SFoldD027320;
        Fri, 28 Jan 2022 16:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=QuLXzDgjL9wnzbED3Nhc8cRtQ2KTEN03cmdeQI331YI=;
 b=KvhOshayGMTSXSGaeA4/I2ZeblH7U3fOIQzTE1m0wGbar/VSD3opcDl8nLE3BekGGnDm
 6jVnwWvHywZNTwvxjzKy/WF++mICRRobj3FDDlydD+twy/BwX+d+aYcgfHNvkuR0xcu6
 MjWinBsFlmyZopC3PRN3Zc7bOJl/ySFoUllVHP14WIg7S8GsRjVk9Z8wldzo3Q59vnfU
 Ifogc4f7yDExw/YnPT5qr5fHy0QC9aPzHaDhIBfr5wNH+qWiMnfNLark9BBWz2EQqBoK
 6KRQ8xCmRr+g6SJ9YBuvYa9/woAg/g9uUaA6Q+bkmoAqBN9eBlttO9ZKMEIg5s72yk0X oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dvjwus6pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:08:55 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20SFrXPj007396;
        Fri, 28 Jan 2022 16:08:55 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dvjwus6nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:08:55 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20SG2rDB030994;
        Fri, 28 Jan 2022 16:08:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3dr9ja8jqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:08:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20SG8n4X33948128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 16:08:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 865BB11C052;
        Fri, 28 Jan 2022 16:08:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1669111C058;
        Fri, 28 Jan 2022 16:08:49 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Jan 2022 16:08:49 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinan Liu <yinan@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, hca@linux.ibm.com,
        linux-s390@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: ftrace hangs waiting for rcu
References: <20220127114249.03b1b52b@gandalf.local.home>
        <YfLjIOlGfFmbh1Zv@FVFF77S0Q05N> <yt9dy231yq90.fsf_-_@linux.ibm.com>
        <YfQCohKWJg9H+uID@FVFF77S0Q05N>
Date:   Fri, 28 Jan 2022 17:08:48 +0100
In-Reply-To: <YfQCohKWJg9H+uID@FVFF77S0Q05N> (Mark Rutland's message of "Fri,
        28 Jan 2022 15:42:48 +0000")
Message-ID: <yt9dee4rn8q7.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HIA2iVl0ZRTGnPPvDah9uhzigmjhRZTE
X-Proofpoint-ORIG-GUID: 2MXkrPI1bRRT1QHJ7IkNsiOUGgkUm0bm
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_05,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201280101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Mark Rutland <mark.rutland@arm.com> writes:

> On arm64 I bisected this down to:
>
>   7a30871b6a27de1a ("rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic queue selection")
>
> Which was going wrong because ilog2() rounds down, and so the shift was wrong
> for any nr_cpus that was not a power-of-two. Paul had already fixed that in
> rcu-next, and just sent a pull request to Linus:
>
>   https://lore.kernel.org/lkml/20220128143251.GA2398275@paulmck-ThinkPad-P17-Gen-1/
>
> With that applied, I no longer see these hangs.
>
> Does your s390 test machine have a non-power-of-two nr_cpus, and does that fix
> the issue for you?

We noticed the PR from Paul and are currently testing the fix. So far
it's looking good. The configuration where we have seen the hang is a
bit unusual:

- 16 physical CPUs on the kvm host
- 248 logical CPUs inside kvm
- debug kernel both on the host and kvm guest

So things are likely a bit slow in the kvm guest. Interesting is that
the number of CPUs is even. But maybe RCU sees an odd number of CPUs
and gets confused before all cpus are brought up. Have to read code/test
to see whether that could be possible.

Thanks for investigating!
Sven
