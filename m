Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2D24704E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhLJPxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:53:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240348AbhLJPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:52:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAFhwgP002344;
        Fri, 10 Dec 2021 15:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CrjMQkLYkk8ex/dff8hOR3nKpVuHESm2QwXGYiLjoks=;
 b=q0M3nnDGawGlmoxjnJ+lZyWiXQqGE5u9DZCs3mxe+d6mCx242y4BRAhjatDNdHFx51XN
 AvpiQiUDD+zxetwA8Vb2Ml691vEiNc2q3KjmqH9sDoOlFuh9ECxcWiAcV4brvfOFVQqd
 V/WXte+BygfIJ8Z32XME1NRicUyQnG9PJePBylSyYbDST+d60hnx46QFV682bgGI8SY+
 FiFd4uQN824TFH3kYHbbKm/i0T23M7JURcA7N6okQaPhUUkRKwo22lNHi4y9hFDeyJ8u
 SvwwZB9WzqDjxFo20ZaNgc8Fxkzy1ztgQsJaswPQU7dawl4IAWE954NZLiAlzGFxR/nE 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv55je9gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 15:48:44 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAFhCnE015087;
        Fri, 10 Dec 2021 15:48:43 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv55je9g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 15:48:43 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAFlBdN003746;
        Fri, 10 Dec 2021 15:48:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3cqyyaa4th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 15:48:40 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAFmakb29622716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 15:48:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A374211C04A;
        Fri, 10 Dec 2021 15:48:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 408C911C052;
        Fri, 10 Dec 2021 15:48:34 +0000 (GMT)
Received: from sig-9-65-75-5.ibm.com (unknown [9.65.75.5])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 15:48:34 +0000 (GMT)
Message-ID: <70e68bb6fd8e70b32fa2404768a6240791546496.camel@linux.ibm.com>
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, jejb@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 10 Dec 2021 10:48:33 -0500
In-Reply-To: <9806a2ba-8b45-3bb8-22c5-797ab2affaac@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-16-stefanb@linux.ibm.com>
         <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
         <20211209143749.wk4agkynfqdzftbl@wittgenstein>
         <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
         <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
         <20211210114934.tacjnwryihrsx6ln@wittgenstein>
         <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
         <6de8d349-74f8-7be4-3854-5c4ac72860ad@linux.ibm.com>
         <d8a6a6827da17825c1aa011256b96d195b1ebf13.camel@linux.ibm.com>
         <66b377f6-40b4-77da-c02b-2650fa72d0b4@linux.ibm.com>
         <d6011a5a40c3c304f386a328385836ba9838baf9.camel@linux.ibm.com>
         <b8f3fe8de8788da92c3822912c11404a46531ac2.camel@linux.ibm.com>
         <9806a2ba-8b45-3bb8-22c5-797ab2affaac@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7TekR7o2b9Y_ID2BftZGhYCzPA7kHc__
X-Proofpoint-GUID: X-yYDes_XyijSdbg5BnK4ErQPL8TQQ64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_05,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-10 at 10:32 -0500, Stefan Berger wrote:
> On 12/10/21 10:26, Mimi Zohar wrote:
> > On Fri, 2021-12-10 at 09:26 -0500, James Bottomley wrote:
> >> On Fri, 2021-12-10 at 09:17 -0500, Stefan Berger wrote:
> >>> On 12/10/21 08:02, Mimi Zohar wrote:
> >>>> On Fri, 2021-12-10 at 07:40 -0500, Stefan Berger wrote:
> >>>>> On 12/10/21 07:09, Mimi Zohar wrote:
> >>>>>> On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
> >>>>>>>> There's still the problem that if you write the policy,
> >>>>>>>> making the file disappear then unmount and remount
> >>>>>>>> securityfs it will come back.  My guess for fixing this is
> >>>>>>>> that we only stash the policy file reference,
> >>>>>>>> create it if NULL but then set the pointer to PTR_ERR(-
> >>>>>>>> EINVAL) or something and refuse to create it for that
> >>>>>>>> value.
> >>>>>>> Some sort of indicator that gets stashed in struct ima_ns
> >>>>>>> that the file does not get recreated on consecutive mounts.
> >>>>>>> That shouldn't be hard to fix.
> >>>>>> The policy file disappearing is for backwards compatibility,
> >>>>>> prior to being able to extend the custom policy.  For embedded
> >>>>>> usecases, allowing the policy to be written exactly once might
> >>>>>> makes sense.  Do we really want/need to continue to support
> >>>>>> removing the policy in namespaces?
> >>>>> I don't have an answer but should the behavior for the same
> >>>>> #define in this case be different for host and namespaces? Or
> >>>>> should we just 'select IMA_WRITE_POLICY and IMA_READ_POLICY' when
> >>>>> IMA_NS is selected?
> >>>> The latter option sounds good.  Being able to analyze the namespace
> >>>> policy is really important.
> >>> Ok, I will adjust the Kconfig for this then. This then warrants the
> >>> question whether to move the dentry into the ima_namespace. The
> >>> current code looks like this.
> >>>
> >>> #if !defined(CONFIG_IMA_WRITE_POLICY) &&
> >>> !defined(CONFIG_IMA_READ_POLICY)
> >>>           securityfs_remove(ns->policy_dentry);
> >>>           ns->policy_dentry = NULL;
> >>>           ns->policy_dentry_removed = true;
> >>> #elif defined(CONFIG_IMA_WRITE_POLICY)
> >>>
> >>> With IMA_NS selecting IMA_WRITE_POLICY and IMA_READ_POLICY the above
> >>> wouldn't be necessary anymore but I find it 'cleaner' to still have
> >>> the dentry isolated rather than it being a global static as it was
> >>> before...
> >> This is really, really why you don't want the semantics inside the
> >> namespace to differ from those outside, because it creates confusion
> >> for the people reading the code, especially with magically forced
> >> config options like this.  I'd strongly suggest you either keep the
> >> semantic in the namespace or eliminate it entirely.
> >>
> >> If you really, really have to make the namespace behave differently,
> >> then use global variables and put a big comment on that code saying it
> >> can never be reached once CONFIG_IMA_NS is enabled.
> > The problem seems to be with removing the securityfs policy file.
> > Instead of removing it, just make it inacessible for the "if
> > !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)"
> > case.
> 
> So we would then leave it up to the one building the kernel to select 
> the proper compile time options (suggested ones being IMA_WRITE_POLICY 
> and IMA_READ_POLICY being enabled?) and behavior of host and IMA 
> namespace is then the same per those options? Removing the file didn't 
> seem the problem to me but more like whether the host should ever behave 
> differently from the namespace.

You proposed "select IMA_WRITE_POLICY and IMA_READ_POLICY'" when IMA_NS
is selected.  At least IMA_READ_POLICY should be enabled for
namespaces.

In addition, if removing the securityfs file after a custom policy is
loaded complicates namespacing, then don't remove it.

thanks,

Mimi

