Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AEB4C93AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiCAS7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiCAS7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:59:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C3610D2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:58:25 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221HclHi005259;
        Tue, 1 Mar 2022 18:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=fyULgp2edHxAGxvr7DKJSreIgvcHKCLbb/3axRl6veE=;
 b=sNfThad2MLaBU5h7Ijzs8ptCV0xvlF6KXIsYkv1DPu2DWg/v/OrE6EDfC1O05bzHU7bg
 keNqJPj/3l6cQbsUouU8gbiLhnzDvGQUSB53nwg5Ad0IOrLYOJPvIKGJlfa1mEyMZSII
 zE4VwhH7r0OsLdji2XvGmIhAikjeYHz1pOGbZcqFRUpSFtTueEBiecZLICln8rag+Acu
 qb+XHokQaDX+cxrlRUvX5r3EBg8PD/irJYVqF4Ajfqey+ODGdfv3ahiGtW0AX/glQEKu
 FyybKEH4rCwzAjaaNbJOSxH4sL+X5BUxERfrxaNuXV3oHpoBlecZIg6ozZT4hft7/3zU dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehpd4vp52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 18:57:58 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 221HfOsc011595;
        Tue, 1 Mar 2022 18:57:57 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehpd4vp49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 18:57:57 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221IsLdZ023428;
        Tue, 1 Mar 2022 18:57:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3efbu9bc4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 18:57:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221Ivr3147776002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 18:57:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C1124C046;
        Tue,  1 Mar 2022 18:57:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D18084C044;
        Tue,  1 Mar 2022 18:57:52 +0000 (GMT)
Received: from localhost (unknown [9.43.110.204])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Mar 2022 18:57:52 +0000 (GMT)
Date:   Wed, 02 Mar 2022 00:27:51 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz, ndesaulniers@google.com,
        Peter Zijlstra <peterz@infradead.org>, samitolvanen@google.com,
        x86@kernel.org
References: <20220224145138.952963315@infradead.org>
        <20220224151322.714815604@infradead.org>
        <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
        <20220224105847.5c899324@gandalf.local.home>
        <20220225103449.6084e5314273556f35107cd9@kernel.org>
        <20220224211919.0612a3f6@rorschach.local.home>
        <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
        <20220225083647.12ceb54b@gandalf.local.home>
In-Reply-To: <20220225083647.12ceb54b@gandalf.local.home>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646159447.ngbqgzj71t.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yGE9LF1sgFzLdfgxi2aBJzwv6M19TYgW
X-Proofpoint-GUID: wcgWHILmLsAtH_0yXZOtMNtRoAV_lwQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 25 Feb 2022 19:20:08 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>=20
>> > No. It only acts like ftrace_location_range(sym, sym_end) if the passe=
d
>> > in argument is the ip of the function (kallsyms returns offset =3D 0) =
=20
>>=20
>> Got it. So now ftrace_location() will return the ftrace address
>> when the ip =3D=3D func or ip =3D=3D mcount-call.

Won't this cause issues with ftrace_set_filter_ip() and others? If the=20
passed-in ip points to func+0 when the actual ftrace location is at some=20
offset, the ftrace location check in ftrace_match_addr() will now pass,=20
resulting in adding func+0 to the hash. Should we also update=20
ftrace_match_addr() to use the ip returned by ftrace_location()?


- Naveen
