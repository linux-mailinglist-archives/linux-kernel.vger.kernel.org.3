Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6365AD077
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiIEKpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiIEKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:45:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7948CB4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:45:39 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285ACOXd024607;
        Mon, 5 Sep 2022 10:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=hsEqYXYozBFki59VxB0JOwy/pXo0nUvqVI5a/CKBHLc=;
 b=Wk/PdXZQnsVhmCeSihV43GpwnY+qiQYY7CdwQj3dkUfBwAipvn5iGbGtjniqBrxqjn80
 s8pObKCKWsY582SZdZkdR6q8RAcAl+FG49V8Myev8kaATGqBoLPAcjoaIJJEjRHyiLbn
 uRy9VOUgzPbKhMR2/H0+bG+F1owu8NLaNG2TrNxw3HbBppWJsaydx7yIuP2kUCmuTluG
 fiVMWM4DbvIYxU4a0TXsqTpTG1ZrVlSP+IvbEPz+i+XE9gaufNwnhTB0BwfVwHiOHSxr
 armsBZChGl4SmW1cD3/jfzxpqs2XbQQ4uOqDLVogz/kyyK5BDlKl2L4WgWW2Z7X4k+Qh mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdf5a10as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:45:14 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 285AaojN017948;
        Mon, 5 Sep 2022 10:45:14 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdf5a109q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:45:13 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 285AYTSY003083;
        Mon, 5 Sep 2022 10:45:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3jbxj8sq47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:45:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 285Aj85Y37749096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 10:45:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B693442045;
        Mon,  5 Sep 2022 10:45:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D81C42042;
        Mon,  5 Sep 2022 10:45:08 +0000 (GMT)
Received: from localhost (unknown [9.43.114.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 10:45:08 +0000 (GMT)
Date:   Mon, 05 Sep 2022 16:15:07 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 16/16] objtool/powerpc: Add --mcount specific
 implementation
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <20220829055223.24767-1-sv@linux.ibm.com>
        <20220829055223.24767-17-sv@linux.ibm.com>
        <5da86617-53f1-d899-336a-53fe691e76ae@csgroup.eu>
        <20220831175100.GS25951@gate.crashing.org>
In-Reply-To: <20220831175100.GS25951@gate.crashing.org>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1662374555.7eoowv9twf.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pci5B8yIr6t-GG208DxYCozmG78g4Uae
X-Proofpoint-ORIG-GUID: skE3UL6uvpeUC6OrMnVkcV6rUxXUTHBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_07,2022-09-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=853 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool wrote:
> On Wed, Aug 31, 2022 at 12:50:07PM +0000, Christophe Leroy wrote:
>> Le 29/08/2022 =C3=A0 07:52, Sathvika Vasireddy a =C3=A9crit=C2=A0:
>> > +	opcode =3D insn >> 26;
>> > +
>> > +	switch (opcode) {
>> > +	case 18: /* bl */
>>=20
>> case 18 is more than 'bl', it includes also 'b'.
>> In both cases, the calculation of *immediate is the same.
>=20
> It also is "ba" and "bla", sometimes written as "b[l][a]".
>=20
>> It would therefore be more correct to perform the calculation and setup=20
>> of *immediate outside the 'if ((insn & 3) =3D=3D 1)', that would avoid=20
>> unnecessary churn the day we add support for branches without link.

Yeah, and probably move the comments around:

+	case 18: /* b[l][a] */
+		if ((insn & 3) =3D=3D 1) { /* bl */

>>=20
>> > +		if ((insn & 3) =3D=3D 1) {
>> > +			*type =3D INSN_CALL;
>> > +			*immediate =3D insn & 0x3fffffc;
>> > +			if (*immediate & 0x2000000)
>> > +				*immediate -=3D 0x4000000;
>> > +		}
>> > +		break;
>> > +	}
>=20
> Does this handle AA=3D1 correctly at all?  That is valid both with and
> without relocations, just like AA=3D0.  Same for AA=3D1 LK=3D0 btw.
>=20
> If you only handle AA=3D0, the code should explicitly test for that.

The code does test for AA=3D0 LK=3D1 with the if statement there?


- Naveen
