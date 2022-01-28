Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906B749FDD7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349998AbiA1QSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:18:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235638AbiA1QSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:18:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SFofX8030052;
        Fri, 28 Jan 2022 16:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=WIIEnY4LQjNNxPmo8R0V8UME5jMvyPgAX65kRzl76DE=;
 b=sEpNqsY6iohNXVKa0ENno++Xz7TAgntaSy7RompeOswHByMidzv92b8BM+VSPiDR1xDz
 RJ3H5z4cfbfgNeIv9lK0ghlCl84ejUfU3u7NiULdzdCiMz7D53tKz9bEFQKYCt9DSezV
 GoGP1UqUdPipIJ51tro+Te7VsYUWr0wlL75m0GkFYw8mNouM60cd5P6EBctcZx82csYM
 Z5B9+JFxJY1VS6X5uqPJ2G6cxIZzfJhQuyqzZcVjOr4ik9/s0qwO+IS8gETrUwPt2hja
 YHWp5lpZOuwxXttWbCZA7dmRbRAHzH/YscyzJzHsjgjoUy4MDeMCsuA6n/DEqGLmcnaR KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvh61up2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:17:42 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20SFrJSh018510;
        Fri, 28 Jan 2022 16:17:41 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvh61up1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:17:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20SGEC6U032075;
        Fri, 28 Jan 2022 16:17:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3dr9ja373e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:17:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20SGHX7n38011174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 16:17:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1525AE055;
        Fri, 28 Jan 2022 16:17:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D677AE045;
        Fri, 28 Jan 2022 16:17:33 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Jan 2022 16:17:33 +0000 (GMT)
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
        <YfQCohKWJg9H+uID@FVFF77S0Q05N> <yt9dee4rn8q7.fsf@linux.ibm.com>
        <YfQVzba5thVs+qap@FVFF77S0Q05N>
Date:   Fri, 28 Jan 2022 17:17:32 +0100
In-Reply-To: <YfQVzba5thVs+qap@FVFF77S0Q05N> (Mark Rutland's message of "Fri,
        28 Jan 2022 16:11:57 +0000")
Message-ID: <yt9da6ffn8bn.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u8O8FusVp6nn3H4y_5Ekm_czzhxm816Q
X-Proofpoint-ORIG-GUID: jYcgQy5HdrGbbLk3NI1FNR-A0FeeLH0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_05,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=948
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Mark Rutland <mark.rutland@arm.com> writes:

> On Fri, Jan 28, 2022 at 05:08:48PM +0100, Sven Schnelle wrote:
>> We noticed the PR from Paul and are currently testing the fix. So far
>> it's looking good. The configuration where we have seen the hang is a
>> bit unusual:
>> 
>> - 16 physical CPUs on the kvm host
>> - 248 logical CPUs inside kvm
>
> Aha! 248 is notably *NOT* a power of two, and in this case the shift would be
> wrong (ilog2() would give 7, when we need a shift of 8).
>
> So I suspect you're hitting the same issue as I was.

Argh, indeed! I somehow changed 'power of two' to 'odd number' in my
head. I guess it's time for the weekend. :-)

Thanks!
