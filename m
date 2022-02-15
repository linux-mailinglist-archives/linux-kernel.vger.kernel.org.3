Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFA4B7A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbiBOWNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:13:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244212AbiBOWNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:13:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00BE27CC3;
        Tue, 15 Feb 2022 14:12:57 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FMCD6A010478;
        Tue, 15 Feb 2022 22:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/cHHipy2Vrf9DNNqEWGyjkLiea6SsZVNuOOjBxjrCp8=;
 b=j4xmLzvTx/oD+6UhdbP9yHye6S8y4DqnnfA+ocCaun/sTfdtGSUn3OzGe01rIKDXMJxr
 m+IQnLJrye3iO49GLeSttLyYMWGnEzWRua+aohPWJYlsh6KMDAQ1aiFe5Aw5xFyMyNtT
 CKsCLQUf/l/XB6zRvYtyJgoivn7wwVBwZEvwQ3TypUcXM9SEIs9FgLT/6Go2Wo3Q8POw
 y7lLMm78W0lw6bCj3B94/E7sxT1laqr3zP+u22oRTXr72QdvJ2302Pv8Bo334ribwvXK
 JyE05+8BwtI3sKQESO1ECSydSGCX0AayuHmbApvZ2UPL/bWqporQUJ1mdNchkAGvQ7HD Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8mrjr06p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 22:12:42 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21FMCguW011036;
        Tue, 15 Feb 2022 22:12:42 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8mrjr06c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 22:12:41 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FM81qo005730;
        Tue, 15 Feb 2022 22:12:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3e64ha1spe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 22:12:39 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FMCZvR40108478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 22:12:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 975044C046;
        Tue, 15 Feb 2022 22:12:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 088C44C040;
        Tue, 15 Feb 2022 22:12:33 +0000 (GMT)
Received: from sig-9-65-88-149.ibm.com (unknown [9.65.88.149])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 22:12:32 +0000 (GMT)
Message-ID: <c3f6f6c8a9db34cc1cdc1000f9272c2b36445e15.camel@linux.ibm.com>
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
Date:   Tue, 15 Feb 2022 17:12:32 -0500
In-Reply-To: <20220215204730.GQ3113@kunlun.suse.cz>
References: <cover.1644953683.git.msuchanek@suse.de>
         <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
         <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
         <20220215204730.GQ3113@kunlun.suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lfgs039T7NiW0yrKmn-MSn9TZGi34WFG
X-Proofpoint-GUID: BGuDujqa9oRYPvZ-QlR_Ad2lgoH2nzLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_07,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202150126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-15 at 21:47 +0100, Michal Suchánek wrote:
> Hello,
> 
> On Tue, Feb 15, 2022 at 03:08:18PM -0500, Mimi Zohar wrote:
> > [Cc'ing Eric Snowberg]
> > 
> > Hi Michal,
> > 
> > On Tue, 2022-02-15 at 20:39 +0100, Michal Suchanek wrote:
> > > Commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
> > > adds support for use of platform keyring in kexec verification but
> > > support for modules is missing.
> > > 
> > > Add support for verification of modules with keys from platform keyring
> > > as well.
> > 
> > Permission for loading the pre-OS keys onto the "platform" keyring and
> > using them is limited to verifying the kexec kernel image, nothing
> > else.
> 
> Why is the platform keyring limited to kexec, and nothing else?
> 
> It should either be used for everything or for nothing. You have the
> option to compile it in and then it should be used, and the option to
> not compile it in and then it cannot be used.
> 
> There are two basic use cases:
> 
> (1) there is a vendor key which is very hard to use so you sign
> something small and simple like shim with the vendor key, and sign your
> kernel and modules with your own key that's typically enrolled with shim
> MOK, and built into the kernel.
> 
> (2) you import your key into the firmware, and possibly disable the
> vendor key. You can load the kernel directly without shim, and then your
> signing key is typically in the platform keyring and built into the
> kernel.
> 
> In neither case do I see any reason to use some keyrings for kexec and
> other keyrings for modules.

When building your own kernel there isn't a problem.  Additional keys
may be built into the kernel image, which are loaded onto the
".builtin_trusted_keys" keyring, and may be stored in MOK.  Normally
different keys are used for signing the kernel image and kernel
modules.  Kernel modules can be signed by the build time ephemeral
kernel module signing key, which is built into the kernel and
automatically loaded onto the ".builtin_trusted_keys" keyring.
 
Similarly distros build the kernel module signing key into the kernel,
which is built into the kernel and loaded onto the
".builtin_trusted_keys" keyring.  By loading the pre-OS keys onto the
".platform" keyring,  kexec may verify the distro or other signed
kernel images.

-- 
thanks,

Mimi

