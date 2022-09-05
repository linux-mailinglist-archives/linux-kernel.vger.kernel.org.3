Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2A15ACFDE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiIEKUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiIEKTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:19:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F8F45F5D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:19:16 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285ACLot024394;
        Mon, 5 Sep 2022 10:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=btaVH9OQcx7BCrtzm3XydRFhyIlKk41EWfxdYrOinOo=;
 b=r2RzpUecMzlz6CG2DBR+DKXveeZPMAi5jFQmmMBZCxDOvJkhHY9TT3JwX9rRjrzTImJR
 ImGEh8S7rsloQXXN18iL6dpJot+XQh5tG1RPHRIYxFu/qalEMTujeGzpvH/cyY657xuO
 /uFX+eFNgaCSQa5oE8VW0wvWuZmcteKHVvsE356sAU24Y/jz9F+E/rACTZcOQBuR/7YV
 GyH0NFZyX4qnHnXL/Nll2WvsHJkOk8qmNOggS4NuYWKOCN9Lrf+MudszAXQURcTEroJf
 wcAB8my5k6+gNiFmhTaqhuthr3QHUceCI1VTRXVoU6EXFhhEYprAh5ZnxylrxlzkNCDf /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdf5a0757-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:18:38 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 285AFRu3011957;
        Mon, 5 Sep 2022 10:18:38 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdf5a073m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:18:38 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 285A64bd007209;
        Mon, 5 Sep 2022 10:18:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3jbxj8sp38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:18:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 285AIXMq35258628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 10:18:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11E9E11C04C;
        Mon,  5 Sep 2022 10:18:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C2BD11C04A;
        Mon,  5 Sep 2022 10:18:32 +0000 (GMT)
Received: from localhost (unknown [9.43.114.209])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 10:18:32 +0000 (GMT)
Date:   Mon, 05 Sep 2022 15:48:31 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 01/16] powerpc: Replace unreachable() with it's builtin
 variant in __WARN_FLAGS()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
References: <20220829055223.24767-1-sv@linux.ibm.com>
        <20220829055223.24767-2-sv@linux.ibm.com>
        <a3fc4685-9e8d-ebf6-62ca-2e9028753ce8@csgroup.eu>
In-Reply-To: <a3fc4685-9e8d-ebf6-62ca-2e9028753ce8@csgroup.eu>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1662371888.dwl4kym6qm.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SzWtnuS6KRkJ1NEfHqdw-fEnbxjV4Fnk
X-Proofpoint-ORIG-GUID: _tw5pt4nqnGPDZXar8khWp2o4RTJj_oQ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_07,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 29/08/2022 =C3=A0 07:52, Sathvika Vasireddy a =C3=A9crit=C2=A0:
>> objtool is throwing *unannotated intra-function call* warnings in
>> .c files with a few instructions that are marked unreachable. The
>> problem comes from the annotate_unreachable() macro that is
>> called by unreachable(). This annotation is adding a call to a
>> function with size 0, and objtool does not add such symbols
>> to the rbtree. Due to this reason, find_call_destination() function
>> is not able to find the destination symbol for that call.
>>=20
>> With the annotation (annotate_unreachable()), gcc seems to
>> generate a 'bl' to unreachable symbol with size 0. But with
>> the builtin variant of unreachable (__builtin_unreachable()),
>> gcc does not emit calls to such symbols and the warnings
>> go away. Given that the codegen remains same, and that
>> there are no 'bl' instructions to such symbols emitted, fix
>> these warnings by replacing unreachable() with it's builtin
>> variant in __WARN_FLAGS().
>=20
> How can you say that the codegen remains the same if with the original=20
> you get stale 'bl' instructions and with the alternative you don't ?

I guess the reference to codegen remaining the same is more to do with=20
unreachable vs. __builtin_unreachable() in the absence of=20
CONFIG_OBJTOOL. But yeah, the changelog needs to be reworked to clarify=20
that.

>=20
>>=20
>> Also, add barrier_before_unreachable() before __builtin_unreachable()
>> to work around a gcc bug [1], for the problem reported at [2].
>=20
> Here my comment was not related to the gcc bug [1] but to gcc bug=20
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D82365 , which was worked=20
> around by commit 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()")
>=20
> By chance it also solve the problem [1] as you mention.

That's a good commit to reference, but please also retain a link to the=20
new PR.


- Naveen

