Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFBA4CA9BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbiCBQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCBQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:00:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B35749935
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:59:43 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222Dn9hn015167;
        Wed, 2 Mar 2022 15:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=fn8PREjURTpghn1F9WFEr6MGljlMas5uHe2iDMalPfg=;
 b=BBPgZPGwXmRk2B8yfFuZVwd3kLu+MGGWP/XolMgmxO3Y8VvoKBGbB20WYlRAXKEwQHxj
 xzWux8NEu2IV+OO62TbSemGcluh0OQLR2JpwBinJlIImJICGd4FxBE2mKCXsJwM4m3Rp
 qdZ6kazhEVr3+RS1MjinDbmIZo8fcmGjnNM8C4i5z2B8yQlXeSWkUs9Vdpr0bWfd05BD
 Ne20DQvF57jr2sG/+PtqYTU6E6j4RaTWVe4wd3j0uGG5u4wHdNL/T9sUSurGXD5EhtNA
 +3lxJBLnRdNaze+tqLCJq2rPpWOIBI4r/nCzLKjIdSgrYNP3XiB9aIgKcAKGpjV8N2BK pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej9ssb437-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 15:59:12 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222F8aSg008611;
        Wed, 2 Mar 2022 15:59:11 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej9ssb42b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 15:59:11 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222FqhtU029703;
        Wed, 2 Mar 2022 15:59:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3efbu9fa0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 15:59:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Fx6eu49545488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 15:59:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 592FA5204F;
        Wed,  2 Mar 2022 15:59:06 +0000 (GMT)
Received: from localhost (unknown [9.43.109.149])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D52F352050;
        Wed,  2 Mar 2022 15:59:05 +0000 (GMT)
Date:   Wed, 02 Mar 2022 21:29:04 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, rostedt@goodmis.org,
        samitolvanen@google.com, x86@kernel.org
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220228150705.aab2d654b973109bab070ffe@kernel.org>
        <20220228232513.GH11184@worktop.programming.kicks-ass.net>
        <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
        <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
        <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
        <20220301191245.GI11184@worktop.programming.kicks-ass.net>
        <20220301200547.GK11184@worktop.programming.kicks-ass.net>
In-Reply-To: <20220301200547.GK11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646236571.m56yc0kmzw.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F9eSvP7ZQOwr-b1w8dxU4p3lDBeCfBjZ
X-Proofpoint-ORIG-GUID: yuAjbp7usWWFQdDwgeH5y0sfWKFvC8e2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
>=20
> How does this look?

I gave this a quick test on powerpc and this looks good to me.

> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -265,7 +265,6 @@ extern int arch_init_kprobes(void);
>  extern void kprobes_inc_nmissed_count(struct kprobe *p);
>  extern bool arch_within_kprobe_blacklist(unsigned long addr);
>  extern int arch_populate_kprobe_blacklist(void);
> -extern bool arch_kprobe_on_func_entry(unsigned long offset);

There is a __weak definition of this function in kernel/kprobes.c which=20
should also be removed.


Thanks,
Naveen

