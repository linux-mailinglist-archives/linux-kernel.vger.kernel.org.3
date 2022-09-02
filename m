Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDCC5AB69A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiIBQck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbiIBQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:32:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07DE3C11
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:32:36 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282FdtSl031873;
        Fri, 2 Sep 2022 15:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0mvmDMVhyGMIVvf5BMrTUAWm3XE+DsGJspCi2lHjows=;
 b=qSOI7PIxu6ap7Exf64mUAMArl1f/x/GZaRD1eVOM5yc8GL2iEoZWZx50N+jx6dfS/MQE
 KcyZz7VDQ96+a+xXj6VGNtxs8B3p3Td6AQfVCMQl34Qz/zDj7Dt2wFuJdzRfHI8V71SC
 YZXa22Adrf28xXVFTr2DT1XqpeLX2uDVdjjH27U5u/y3Q1Ktl1df2dQcdKE92BwlPCt0
 3X8sIdVu4X8+J25h0BK0zZsiFywIBDJv2bxTRtFeLWXyzg9dsZeMPjZ6zVc0mIQx/tqw
 xHrqpVbDtfYWrZZSOqXhqBb4VBtO3R0wc+gHk9XpjJdsr8mugqa5y368YCsfszWXYvg+ Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbktna4kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 15:57:31 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 282FfvnQ039252;
        Fri, 2 Sep 2022 15:57:31 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbktna4jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 15:57:31 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282FpMDZ014946;
        Fri, 2 Sep 2022 15:57:30 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3j7awak35v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 15:57:30 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282FvTrI2228842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 15:57:29 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00E636E04E;
        Fri,  2 Sep 2022 15:57:29 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 557866E052;
        Fri,  2 Sep 2022 15:57:28 +0000 (GMT)
Received: from [9.160.4.32] (unknown [9.160.4.32])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 15:57:28 +0000 (GMT)
Message-ID: <bd00d8c2-663d-cb35-c1c3-4fa9bd4cb4ad@linux.ibm.com>
Date:   Fri, 2 Sep 2022 10:57:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2] powerpc: Fix irq_soft_mask_set() and
 irq_soft_mask_return() with sanitizer
Content-Language: en-US
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
References: <c0b486e782b6695092dcdb2cd340a3d44c8c266d.1661272738.git.christophe.leroy@csgroup.eu>
 <CMJ3VICKD1CI.SVFJOKYJPKZQ@bobo>
 <e022754d-b4d3-bc9f-cc79-2cf556180459@csgroup.eu>
 <CMJ8P06JA9OY.1S8VDV2XRU3W5@bobo>
 <7c11b659-5b8e-256c-508e-39395041fccb@csgroup.eu>
 <20220831224522.GX25951@gate.crashing.org>
From:   Peter Bergner <bergner@linux.ibm.com>
In-Reply-To: <20220831224522.GX25951@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _rSV0gIVuPIbtjpJ7Du-bHcjWwQ7uKN0
X-Proofpoint-GUID: UBGcX1hz4BlM_pnzF4WS-nu94GRexmLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 5:45 PM, Segher Boessenkool wrote:
> On Tue, Aug 30, 2022 at 09:10:02AM +0000, Christophe Leroy wrote:
>> Le 30/08/2022 à 11:01, Nicholas Piggin a écrit :
>>> On Tue Aug 30, 2022 at 3:24 PM AEST, Christophe Leroy wrote:
>>>>> This is still slightly concerning to me. Is there any guarantee that the
>>>>> compiler would not use a different sequence for the address here?
>>>>>
>>>>> Maybe explicit r13 is required.
>>>>>
>>>>
>>>> local_paca is defined as:
>>>>
>>>> 	register struct paca_struct *local_paca asm("r13");
> 
> And this is in global scope, making it a global register variable.
> 
>>>> Why would the compiler use another register ?
>>>
>>> Hopefully it doesn't. Is it guaranteed that it won't?
> 
> Yes, this is guaranteed.

Agree with Segher here.  That said, there was a gcc bug a looooong time
ago where gcc copied r13 into a temporary register and used it from there.
That's ok (correctness wise, but not ideal) from user land standpoint,
but we took a context switch after the reg copy and it was restarted on
a different cpu, so differnt local_paca and r13 value.  We went boom
because the copy wasn't pointing to the correct local_paca anymore.
So it is very important the compiler always use r13 when accessing
the local_paca.

Peter



