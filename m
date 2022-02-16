Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317034B873E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiBPL7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:59:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiBPL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:59:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370BD15A35;
        Wed, 16 Feb 2022 03:59:21 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GBBoDx023238;
        Wed, 16 Feb 2022 11:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=imTy3iAZV/BrTutWiw5e9IZWKaqWO+g/gDhLp/ZA5hE=;
 b=nPQiq8wRb4pA64wajPATltpSwwbZ4dDk9BhMZ/5UU3mpUNShImI0lKgDxHrdAd2eJJw0
 PNIgku1Ak3zmkh/mEF0lYZ6VuYhMDX/+DxVdmE6uzvmv44vB+tt6AH6BPCn1iHZCV+Eo
 PbdOz8ssDquMlFU6H9RCmHUuu7T42iF6SHrH1/fzuV8PrdJ8PNO/f0HBE5dxtCW32Pdf
 ADTUOxt0hR/s1eImm3WQCdo5V8F5unTQDkeHmuNUr1dHDVyicHOO0qoqNc/PtRB2Q5v9
 Rbbj+MfhRANknyVhKLdPHkR8Rmt4Z7T12gUu1TCfsyeR5DJa8k8U6uuBO5obnB4iVTqr Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9064rwsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 11:59:04 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21GBLnG1023932;
        Wed, 16 Feb 2022 11:59:04 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9064rwrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 11:59:04 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GBw9Wu004660;
        Wed, 16 Feb 2022 11:59:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3e64h9x84t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 11:59:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GBwtea47120706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 11:58:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA48852054;
        Wed, 16 Feb 2022 11:58:55 +0000 (GMT)
Received: from sig-9-65-92-254.ibm.com (unknown [9.65.92.254])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EAF9552050;
        Wed, 16 Feb 2022 11:58:51 +0000 (GMT)
Message-ID: <edb305079c28e49021166423af0378f8d218f269.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-modules@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Eric Snowberg <eric.snowberg@oracle.com>
Date:   Wed, 16 Feb 2022 06:58:51 -0500
In-Reply-To: <20220216105645.GS3113@kunlun.suse.cz>
References: <cover.1644953683.git.msuchanek@suse.de>
         <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
         <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
         <20220215204730.GQ3113@kunlun.suse.cz>
         <c3f6f6c8a9db34cc1cdc1000f9272c2b36445e15.camel@linux.ibm.com>
         <20220216105645.GS3113@kunlun.suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oxD1ke81_15pnba0xxgXqRWgPmuHVTK0
X-Proofpoint-ORIG-GUID: sdO0kj556d5oRcvtjN5ziuRg_9LeMzsz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_05,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-16 at 11:56 +0100, Michal Suchánek wrote:
> On Tue, Feb 15, 2022 at 05:12:32PM -0500, Mimi Zohar wrote:
> > On Tue, 2022-02-15 at 21:47 +0100, Michal Suchánek wrote:
> > > Hello,
> > > 
> > > On Tue, Feb 15, 2022 at 03:08:18PM -0500, Mimi Zohar wrote:
> > > > [Cc'ing Eric Snowberg]
> > > > 
> > > > Hi Michal,
> > > > 
> > > > On Tue, 2022-02-15 at 20:39 +0100, Michal Suchanek wrote:
> > > > > Commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
> > > > > adds support for use of platform keyring in kexec verification but
> > > > > support for modules is missing.
> > > > > 
> > > > > Add support for verification of modules with keys from platform keyring
> > > > > as well.
> > > > 
> > > > Permission for loading the pre-OS keys onto the "platform" keyring and
> > > > using them is limited to verifying the kexec kernel image, nothing
> > > > else.
> > > 
> > > Why is the platform keyring limited to kexec, and nothing else?
> > > 
> > > It should either be used for everything or for nothing. You have the
> > > option to compile it in and then it should be used, and the option to
> > > not compile it in and then it cannot be used.
> > > 
> > > There are two basic use cases:
> > > 
> > > (1) there is a vendor key which is very hard to use so you sign
> > > something small and simple like shim with the vendor key, and sign your
> > > kernel and modules with your own key that's typically enrolled with shim
> > > MOK, and built into the kernel.
> > > 
> > > (2) you import your key into the firmware, and possibly disable the
> > > vendor key. You can load the kernel directly without shim, and then your
> > > signing key is typically in the platform keyring and built into the
> > > kernel.
> > > 
> > > In neither case do I see any reason to use some keyrings for kexec and
> > > other keyrings for modules.
> > 
> > When building your own kernel there isn't a problem.  Additional keys
> > may be built into the kernel image, which are loaded onto the
> > ".builtin_trusted_keys" keyring, and may be stored in MOK.  Normally
> > different keys are used for signing the kernel image and kernel
> 
> That's actually not normal.
> 
> > modules.  Kernel modules can be signed by the build time ephemeral
> > kernel module signing key, which is built into the kernel and
> > automatically loaded onto the ".builtin_trusted_keys" keyring.
> 
> Right, there is this advice to use ephemeral key to sign modules.
> 
> I don't think that's a sound advice in general. It covers only the
> special case when you build the kernel once, only rebuild the whole
> kernel and never just one module, don't use any 3rd party module, don't
> bother signing firmware (I am not sure that is supported right now but
> if you are into integrity and stuff you can see that it makes sense to
> sign it, too).
> 
> And you need to manage the key you use for the kernel signing, anyway.
> Sure, you could use the same ephemeral key as for the modules, enroll
> it, and shred it but then it is NOT a key different from the one you use
> for modules.
> 
> Or you could maintain a long-lived key for the kernel, but if you do I
> do NOT see any reason to not use it also for modules, in-tree and
> out-of-tree.

If signing ALL kernel modules, in-tree and out-of-tree, with the same
key as the kernel image, is your real intention, then by all means
write a complete patch description with the motivation for why kernel
module signatures need to be verified against this one pre-OS key
stored only in the platform keyring.  Such a major change like this
shouldn't be buried here.

Otherwise, I suggest looking at Eric Snowberg's "Enroll kernel keys
thru MOK patch set" patch set [1], as previously mentioned, which is
queued to be upstreamed by Jarkko.  It loads MOK keys onto the
'.machine' keyring, which is linked to the '.secondary_trusted_keys"
keyring.  A subsequent patch set will enable IMA support.

[1] 
https://lore.kernel.org/lkml/20220126025834.255493-1-eric.snowberg@oracle.com/
-- 
thanks,

Mimi

