Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9364E982C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbiC1Nae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbiC1Nac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:30:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A11101E;
        Mon, 28 Mar 2022 06:28:51 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22SD0E2B000855;
        Mon, 28 Mar 2022 13:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vvZGLAWXj9Vsm5PCd/I7qSTH8xxl4DBoEq0P1gwT4kQ=;
 b=bmMy8U4Nidd/U+QyVZbgyGww4XGPziiohDKg2CQRNOpeY1B1O6xJI9mJHMrqxSlCn29D
 0pWZfU63irTz8MxervHoA++j8bbW/uaPpviF7hxe/I1iRjqF+/AUXNJlSe2lmobFElwO
 PM9F+CoKqvULP196cJGD4G+n6nH7VLuduZxG50HiBw3qKPQ6DPrAmY4tYuv2s6360gIp
 J0H7D0H8x9UF9TzucrNCBlM75/PIkecIkyUOvfmKnJ7mAkJxImn+Rz1CcRpY1VWzLuJP
 0/MgktlevIdQXsGfUF16vS6b5l86TaIMfDq3Y/fkH8H5q/8QHnCJK49BTY2XbBpltJhM /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f3dh6rkp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 13:28:29 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22SD1HMY005677;
        Mon, 28 Mar 2022 13:28:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f3dh6rknu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 13:28:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22SDHxTN019470;
        Mon, 28 Mar 2022 13:28:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3f1t3jc34h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 13:28:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22SDSNk438338950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 13:28:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51E2FA4057;
        Mon, 28 Mar 2022 13:28:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D99BEA404D;
        Mon, 28 Mar 2022 13:28:19 +0000 (GMT)
Received: from sig-9-65-77-40.ibm.com (unknown [9.65.77.40])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Mar 2022 13:28:19 +0000 (GMT)
Message-ID: <7265798627defd6111af4e3a863b8525b07c511d.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     joeyli <jlee@suse.com>
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
        stable@kernel.org, Eric Snowberg <eric.snowberg@oracle.com>,
        Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Date:   Mon, 28 Mar 2022 09:28:14 -0400
In-Reply-To: <20220328101557.GA11641@linux-l9pv.suse>
References: <cover.1644953683.git.msuchanek@suse.de>
         <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
         <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
         <20220215204730.GQ3113@kunlun.suse.cz>
         <20220328101557.GA11641@linux-l9pv.suse>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DC6vyws2hcln-0gu8_3y6klTLscRxQxS
X-Proofpoint-ORIG-GUID: vNlgst4S3PzK7_DdstPNFXKb5e37f6w9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_05,2022-03-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203280075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-28 at 18:15 +0800, joeyli wrote:

Hi Joey,

> Hi Mimi,
> 
> Sorry for bother you for this old topic.

Cc'ing Luis the kernel modules maintainer.

> 
> On Tue, Feb 15, 2022 at 09:47:30PM +0100, Michal Suchánek wrote:
> > Hello,
> > 
> > On Tue, Feb 15, 2022 at 03:08:18PM -0500, Mimi Zohar wrote:
> > > [Cc'ing Eric Snowberg]
> > > 
> > > Hi Michal,
> > > 
> > > On Tue, 2022-02-15 at 20:39 +0100, Michal Suchanek wrote:
> > > > Commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
> > > > adds support for use of platform keyring in kexec verification but
> > > > support for modules is missing.
> > > > 
> > > > Add support for verification of modules with keys from platform keyring
> > > > as well.
> > > 
> > > Permission for loading the pre-OS keys onto the "platform" keyring and
> > > using them is limited to verifying the kexec kernel image, nothing
> > > else.
> > 
> > Why is the platform keyring limited to kexec, and nothing else?
> > 
> > It should either be used for everything or for nothing. You have the
> > option to compile it in and then it should be used, and the option to
> > not compile it in and then it cannot be used.
> > 
> > There are two basic use cases:
> > 
> > (1) there is a vendor key which is very hard to use so you sign
> > something small and simple like shim with the vendor key, and sign your
> > kernel and modules with your own key that's typically enrolled with shim
> > MOK, and built into the kernel.
> > 
> > (2) you import your key into the firmware, and possibly disable the
> > vendor key. You can load the kernel directly without shim, and then your
> > signing key is typically in the platform keyring and built into the
> > kernel.
> >
> 
> In the second use case, if user can enroll their own key to db either before
> or after hardware shipping. And they don't need shim because they removed
> Microsoft or OEM/ODM keys.  Why kernel can not provide a Kconfig option to
> them for trusting db keys for verifying kernel module, or for IMA (using CA
> in db)?
>  
> In the above use case for distro, partner doesn't need to re-compiler distro
> kernel. They just need to re-sign distro kernel and modules. Which means
> that the partner trusted distro. Then the partner's key in db can be used to
> verify kernel image and also kernel module without shim involve.

From what I understand, distros don't want customers resigning their
kernels.  If they did, then they could have enabled the
CONFIG_SYSTEM_EXTRA_CERTIFICATE, which would load the keys onto the
"builtin" keyring, and anything signed by those keys could be loaded
onto the secondary keyring.  (Of course CONFIG_SYSTEM_EXTRA_CERTIFICATE
would need to be fixed/updated.)

We've gone through "what if" scenarios before.  My response then, as
now, is post it as a patch with the real motivation for such a change.

thanks,

Mimi

