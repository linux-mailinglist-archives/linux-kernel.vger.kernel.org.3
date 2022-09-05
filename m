Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0114C5AD0CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiIEK40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiIEK4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:56:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A3501A0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:56:16 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285Ad8wa028786;
        Mon, 5 Sep 2022 10:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=BLtgTU7RLqF4DIh4hpjso2OEbNRHLyA5WHWUcoN2Cxc=;
 b=NoWBDanezj0502lSFKu+OT1S2UeYFd9AJzSCEWZ/IwUQU9fWFgoyxhSBfJrYeBYoAnG4
 49iCPIxVZjqx33FTGPbib/ZsOQV4mUs6YO/jZnmVzjNAaS2ezZXh68wGsOrlV9d5T2N3
 uW37x+CBUUjKY3DenkOOPfdnk4tfw4swsfjFAJ1wLgdBX5/RmnT9Tunqmvnb4CK+QKvj
 BgyTMgetUGHkmEoBe60Yq61qCmBQxM0Z+yCSfTA4L+BzKvOzHGlEECzY/2W8GTMOgPoF
 Nv30ifBULWJiSXNhLmr3ijpluMDS0FePjuiN35kKcIo/WVsOUvqu6g0oUSaGohA88yIf BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jde1sbmwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:55:49 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2859a8Ya020031;
        Mon, 5 Sep 2022 10:55:49 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jde1sbmw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:55:48 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 285AqLSs010767;
        Mon, 5 Sep 2022 10:55:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3jbxj8tbbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 10:55:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 285AtioQ25428364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 10:55:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CD1211C050;
        Mon,  5 Sep 2022 10:55:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9AAA11C054;
        Mon,  5 Sep 2022 10:55:43 +0000 (GMT)
Received: from localhost (unknown [9.43.114.209])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 10:55:43 +0000 (GMT)
Date:   Mon, 05 Sep 2022 16:25:42 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 11/16] objtool: Add --mnop as an option to --mcount
To:     Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     aik@ozlabs.ru, chenzhongjin@huawei.com,
        christophe.leroy@csgroup.eu, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mbenes@suse.cz, mingo@redhat.com, mpe@ellerman.id.au,
        npiggin@gmail.com, rostedt@goodmis.org
References: <20220829055223.24767-1-sv@linux.ibm.com>
        <20220829055223.24767-12-sv@linux.ibm.com>
        <YxEHM8ZL1XAFsj4H@hirez.programming.kicks-ass.net>
In-Reply-To: <YxEHM8ZL1XAFsj4H@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1662374882.xll36f5qp9.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -ivhpHtwgOuKksI_EqLA-PE6EGqb9quV
X-Proofpoint-GUID: hQxC3vMDz6wa3zeQUJbX6AAjXuYDmZCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_07,2022-09-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=920
 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209050051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Mon, Aug 29, 2022 at 11:22:18AM +0530, Sathvika Vasireddy wrote:
>> Architectures can select HAVE_NOP_MCOUNT if they choose
>> to nop out mcount call sites. If that config option is
>> selected, then --mnop is passed as an option to objtool,
>> along with --mcount.
>>=20
>> Also, make sure that --mnop can be passed as an option
>> to objtool only when --mcount is passed.
>>=20
>> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
>=20
> IIRC you want to nop the things yourself because PLT entries or
> something?

For two reasons:
1. We want to maintain a pointer to 'struct module' as part of the=20
ftrace rec so that we can patch ftrace sites in modules to go to module=20
stubs.
2. We depend on compiler generated long branches to support large=20
kernels.

>=20
> Anyway, patch looks fine, even though the Changelog doesn't relaly
> justify the change.

Sure. We should add that powerpc kernel does not support nop'ed out=20
ftrace locations.

>=20
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>=20

Thanks,
Naveen
