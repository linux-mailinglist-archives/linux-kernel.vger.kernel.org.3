Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805F551526D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379725AbiD2RnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379210AbiD2RnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:43:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B55728997
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:39:42 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TGw0cJ011947;
        Fri, 29 Apr 2022 17:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=YoHa0fLQEkgm+3Igrqs1u82fd0eKrL3cNPKS8q/AGcs=;
 b=bh6pzVLD+JALzZUxG9/IYtCYv8tb0e7wZUDHzxVGH637nt81PrchE5i2K3rY6nqvuNE3
 vxfMkDFLMqdtShueEkai+pgunIfMy+c6T3QBRJB3hjmQ/xC0kzYtXu7NiHU3Rrk+ObKb
 Z1CoxBLs0LxC/mVa4dQVos5kCs3S8WAI4+fVBIjWLMvomjbtHWvUnVC1cEmd/Vhjllxk
 50Tv3C/tVS5ayUgm2iTM+DiKYpmMftBTCrbkDKbVdokiYn7MfxsvnELk+DF9CyWGbFhI
 cvAy5SE/Evzpd15aVS0eNLFjqhqEpYPrtHxKlTdphWUYgryupNAkhtElIMm/3nvYCLXi iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqt9efudn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 17:39:26 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23THVGSR002413;
        Fri, 29 Apr 2022 17:39:26 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqt9efucs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 17:39:26 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23THbqX0031260;
        Fri, 29 Apr 2022 17:39:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3fm938ygfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 17:39:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23THdLdl48365836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:39:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4078511C04C;
        Fri, 29 Apr 2022 17:39:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C675B11C04A;
        Fri, 29 Apr 2022 17:39:20 +0000 (GMT)
Received: from localhost (unknown [9.43.18.217])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 17:39:20 +0000 (GMT)
Date:   Fri, 29 Apr 2022 23:09:19 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] ftrace: recordmcount: Handle sections with no
 non-weak symbols
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <cover.1651166001.git.naveen.n.rao@linux.vnet.ibm.com>
        <126aca34935cf1c7168e17970c706e36577094e7.1651166001.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220428184212.18fbf438@gandalf.local.home>
In-Reply-To: <20220428184212.18fbf438@gandalf.local.home>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1651252324.js9790ngjg.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XjwigIEeW3HSn-VRBEuRqpTuXxv62pyz
X-Proofpoint-ORIG-GUID: ed5zTfg3vACJAC1QySK7bIsb5o0AfjqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_08,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=783
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 28 Apr 2022 22:49:52 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> But, with ppc64 elf abi v1 which only supports the old -pg flag, mcount
>> location can differ between the weak and non-weak variants of a
>> function. In such scenarios, one of the two mcount entries will be
>> invalid. Such architectures need to validate mcount locations by
>> ensuring that the instruction(s) at those locations are as expected. On
>> powerpc, this can be a simple check to ensure that the instruction is a
>> 'bl'. This check can be further tightened as necessary.
>=20
> I was thinking about this more, and I was thinking that we could create
> another section; Perhaps __mcount_loc_weak. And place these in that
> section. That way, we could check if these symbols to see if there's
> already a symbol for it, and if there is, then drop it.

If I'm understanding your suggestion right:
- we now create a new section in each object file: __mcount_loc_weak,=20
  and capture such relocations using weak symbols there.
- we then ask the linker to put these separately between, say,=20
  __start_mcount_loc_weak and __stop_mcount_loc_weak
- on ftrace init, we go through entries in this range, but discard those=20
  that belong to functions that also have an entry between=20
  __start_mcount_loc and __stop_mcount loc.

The primary issue I see here is that the mcount locations within the new=20
weak section will end up being offsets from a different function in=20
vmlinux, since the linker does not create a symbol for the weak=20
functions that were over-ridden.

As an example, in the issue described in this patch set, if powerpc=20
starts over-riding kexec_arch_apply_relocations(), then the current weak=20
implementation in kexec_file.o gets carried over to the final vmlinux,=20
but the instructions will instead appear under the previous function in=20
kexec_file.o: crash_prepare_elf64_headers(). This function may or may=20
not be traced to begin with, so we won't be able to figure out if this=20
is valid or not.


- Naveen
