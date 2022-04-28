Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176D3512D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbiD1Ht0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbiD1Hs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:48:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D09E2AC70
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:45:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S6LsWf030667;
        Thu, 28 Apr 2022 07:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=2a2qnf85dZLG0wjLA1P68akEZ8qtEpjIISNNdWGejsE=;
 b=cnAO7dcKd8ACPVw3/k9vvdSONpztsPMY62GDMT8AQYx1dNrRMVOh2nfE2SmIJHcEqAW0
 0v5COD3OMBclGwvQ/oHSf/8T8Y/2+sfpQ+VCuILKd8wwwnqao165SgBMTi/ck2KmFsdc
 2fsEQYcqMq8qHPfypm1GbPvMyJ/UeEcgOmm+sgTbqa5nbynuvZLtHQ30IpKcacTBMmUy
 BtNdr/pLoGVCz/4/BTWQkE3NPq9mBpaJr7CS5V8MmfYKAA8A4dQEP6Ixn3Mh4uO64pdM
 zuIlYAQ2f3kDZvWJ1Hs6OBxPqZZ5fVHQ/BhDBSm3EqBs749IC0q3o09C9e4eGFKMxObj qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnkd1e5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 07:45:30 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23S7DPUL000441;
        Thu, 28 Apr 2022 07:45:29 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnkd1e4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 07:45:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23S7gdL3025874;
        Thu, 28 Apr 2022 07:45:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3fpuyg9jh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 07:45:27 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23S7jPWU51773828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 07:45:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E740252050;
        Thu, 28 Apr 2022 07:45:24 +0000 (GMT)
Received: from localhost (unknown [9.43.72.179])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 566455204E;
        Thu, 28 Apr 2022 07:45:24 +0000 (GMT)
Date:   Thu, 28 Apr 2022 13:15:22 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] recordmcount: Handle sections with no non-weak
 symbols
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
        <1b9566f0e7185fb8fd8ef2535add7a081501ccc8.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220427095415.594e5120@gandalf.local.home>
In-Reply-To: <20220427095415.594e5120@gandalf.local.home>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1651129169.fpixr00hgx.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v1C5Ow42GOdWULG5-pKCgFOsRicu5ma7
X-Proofpoint-GUID: r79zgnhln1Qj5M-PyjrND798Rs2ceafb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=766 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 27 Apr 2022 15:01:22 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> If one or both of these weak functions are overridden in future, in the
>> final vmlinux mcount table, references to these will change over to the
>> non-weak variant which has its own mcount location entry. As such, there
>> will now be two entries for these functions, both pointing to the same
>> non-weak location.
>=20
> But is that really true in all cases? x86 uses fentry these days, and oth=
er
> archs do things differently too. But the original mcount (-pg) call
> happened *after* the frame setup. That means the offset of the mcount cal=
l
> would be at different offsets wrt the start of the function. If you have
> one of these architectures that still use mcount, and the weak function
> doesn't have the same size frame setup as the overriding function, then t=
he
> addresses will not be the same.

Indeed, plain old -pg will be a problem. I'm not sure there is a generic=20
way to address this. I suppose architectures will have to validate the=20
mcount locations, something like this?

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/f=
trace.h
index d83758acd1c7c3..d8b104ed2fdf38 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -12,13 +12,7 @@
=20
 #ifndef __ASSEMBLY__
 extern void _mcount(void);
-
-static inline unsigned long ftrace_call_adjust(unsigned long addr)
-{
-       /* relocation of mcount call site is the same as the address */
-       return addr;
-}
-
+unsigned long ftrace_call_adjust(unsigned long addr);
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip=
,
                                    unsigned long sp);
=20
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace=
/ftrace.c
index 4ee04aacf9f13c..976c08cd0573f7 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -858,6 +858,17 @@ void arch_ftrace_update_code(int command)
        ftrace_modify_all_code(command);
 }
=20
+unsigned long ftrace_call_adjust(unsigned long addr)
+{
+       ppc_inst_t op =3D ppc_inst_read((u32 *)addr);
+
+       if (!is_bl_op(op))
+               return 0;
+
+       /* relocation of mcount call site is the same as the address */
+       return addr;
+}
+
 #ifdef CONFIG_PPC64
 #define PACATOC offsetof(struct paca_struct, kernel_toc)
=20

We can tighten those checks as necessary, but it will be upto the=20
architectures to validate the mcount locations. This all will have to be=20
opt-in so that only architectures doing necessary validation will allow=20
mcount relocations against weak symbols.


- Naveen
