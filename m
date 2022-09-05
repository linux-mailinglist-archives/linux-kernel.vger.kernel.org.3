Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EC25AD098
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbiIEKsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiIEKsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:48:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32064C63C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:48:03 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285AdB2T007177;
        Mon, 5 Sep 2022 10:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=ufZB2BKxpQ8P5gYnBIYIG6KMKiIGNOURP18jVUHN2Vs=;
 b=DLUA+3Cax17gkGdimcZ+YWz0pUDXnmEb5EgRCUZhTActjT4aP94Easf6l023LfECe0IX
 PG+cqjzF3x9ihaPYFk8rRhflt2MgEa+HXpPGivALb2l88yCNrtEG3QVVy8Y/uK1o2tpa
 V8nnayIZC6TagPqhhhwFd84wyzJV5F5I6KQ5gadb1CV25/HdFX2/zNkG/ETU1E5sJG5w
 +xNUHf41yhdw94NRzuxagqgBtyHiQm3/BacJEsllRpzYwmMeBuTW+Yn33y13QVt8HVAC
 1ioZkHL3ezM0pKRZ1uQLIJEc+e8tdpO0BMu/IhK3eWoRYDq1Jxm82g362Vikwc+n5d0i UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdf83rmcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:47:47 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 285AeVMe012284;
        Mon, 5 Sep 2022 10:47:46 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdf83rmbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:47:46 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 285AaH86008999;
        Mon, 5 Sep 2022 10:47:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3jbxj8hpsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:47:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 285AlfLO41156988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 10:47:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FB204C040;
        Mon,  5 Sep 2022 10:47:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA3174C044;
        Mon,  5 Sep 2022 10:47:40 +0000 (GMT)
Received: from localhost (unknown [9.43.114.209])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 10:47:40 +0000 (GMT)
Date:   Mon, 05 Sep 2022 16:17:39 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 05/16] powerpc: Skip objtool from running on
 drivers/crypto/vmx/aesp8-ppc.o
To:     Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     aik@ozlabs.ru, chenzhongjin@huawei.com,
        christophe.leroy@csgroup.eu, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mbenes@suse.cz, mingo@redhat.com, mpe@ellerman.id.au,
        npiggin@gmail.com, rostedt@goodmis.org
References: <20220829055223.24767-1-sv@linux.ibm.com>
        <20220829055223.24767-6-sv@linux.ibm.com>
        <YxEFZXCnCH7F8yku@hirez.programming.kicks-ass.net>
In-Reply-To: <YxEFZXCnCH7F8yku@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1662374747.rv53oucl9s.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F8bGJIR7Ki-Y9FWBQDt-pGVTaYsOi46T
X-Proofpoint-GUID: TFqjrs-Opq1fXXMxyqL7Q0Ss9lsud2r0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_07,2022-09-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Mon, Aug 29, 2022 at 11:22:12AM +0530, Sathvika Vasireddy wrote:
>> With objtool enabled, below warnings are seen when trying to build:
>>=20
>> drivers/crypto/vmx/aesp8-ppc.o: warning: objtool: aes_p8_set_encrypt_key=
+0x44: unannotated intra-function call
>>=20
>> drivers/crypto/vmx/aesp8-ppc.o: warning: objtool: .text+0x2448: unannota=
ted intra-function call
>>=20
>> drivers/crypto/vmx/aesp8-ppc.o: warning: objtool: .text+0x2d68: unannota=
ted intra-function call
>>=20
>> Skip objtool from running on this file, for two main reasons:
>>=20
>> Since this file comes from OpenSSL, and since it is a perl file
>> which generates a .S file, it may not be the best choice to
>> make too many code changes to such files, unless absolutely
>> necessary.
>>=20
>> Second reason is that, at least as far as the objtool --mcount
>> functionality is concerned, we do not have to run objtool on
>> that file because that file does not have any calls to _mcount.
>>=20
>> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
>> ---
>>  drivers/crypto/vmx/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
>> index 2560cfea1dec..7b41f0da6807 100644
>> --- a/drivers/crypto/vmx/Makefile
>> +++ b/drivers/crypto/vmx/Makefile
>> @@ -9,3 +9,5 @@ targets +=3D aesp8-ppc.S ghashp8-ppc.S
>> =20
>>  $(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S: $(obj)/%.S: $(src)/%.pl FORCE
>>  	$(call if_changed,perl)
>> +
>> +OBJECT_FILES_NON_STANDARD_aesp8-ppc.o :=3D y
>=20
> Just be aware that the moment you start to run objtool on vmlinux.o this
> annotation becomes unstuck.
>=20
> Specifically things like LTO builds require this because there simply
> isn't an object file before that.

Good point. LTO isn't supported today with ftrace on powerpc, so I guess=20
we are ok with this patch for now.

To add LTO support, I guess we will need to add some annotations to this=20
file later on.


- Naveen
