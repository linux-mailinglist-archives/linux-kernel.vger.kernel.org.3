Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107545502E0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 06:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiFRE5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 00:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFRE5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 00:57:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E2248F5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 21:57:07 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25I1wrNT013867;
        Sat, 18 Jun 2022 04:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rzAaIToneCB+BWv66tZQPX85QKk0kaZ7ejfpnjMCx7o=;
 b=TZ5iaaEhvS4/JSePoh7KmgpwaVoe17g3c4f/scYI5s+WJG2MaVypSPgOm1B8yATUgd9X
 ehUFsq2M7B81dSzZYW8vTfGXgBSUef1HigubW9wkghL4fSJ84bJ4bE2Lgf9BrpR0i1/w
 KLD6zGFmkMfPCXbvylL9/gtH4ohyTeW9M5GWo5BiYbgMW6HxRUgkfPtG3nAM5Vh7zfSC
 g/qhOLtgTNL47sUz6SzL3Mb2ZaMHz2yh0aNjmK995WvyVbazSpoN5+OD6rzFGOKiCHQJ
 t2jMQE1lij4yabp+b/dwHMEqBhrUP6d0Do5gPso2qoQ2Mj7TPxGB8o1QPfEm4fNVQtdx 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gs4wyawce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jun 2022 04:56:23 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25I4lopm032441;
        Sat, 18 Jun 2022 04:56:22 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gs4wyawc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jun 2022 04:56:22 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25I4orKN010326;
        Sat, 18 Jun 2022 04:56:20 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3gs6b8r2pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jun 2022 04:56:20 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25I4uHiY18481428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jun 2022 04:56:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5F714C04A;
        Sat, 18 Jun 2022 04:56:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB7314C040;
        Sat, 18 Jun 2022 04:56:13 +0000 (GMT)
Received: from [9.43.41.206] (unknown [9.43.41.206])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 18 Jun 2022 04:56:13 +0000 (GMT)
Message-ID: <863b068d-e534-b377-c5d7-2f16fbb11977@linux.vnet.ibm.com>
Date:   Sat, 18 Jun 2022 10:26:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 0/7] objtool: Enable and implement --mcount option
 on powerpc
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <cover.1653398233.git.christophe.leroy@csgroup.eu>
 <ac4e3ceb-7de8-2c3f-4689-1730d811bf3d@linux.vnet.ibm.com>
 <ea64b232-e002-9317-dca1-c5933fb94e03@csgroup.eu>
 <0d2a6ea3-71cc-a8e1-22eb-7b66f533b3bf@linux.vnet.ibm.com>
 <18d05edc-6669-0308-7e6a-acd1cccd4f20@csgroup.eu>
From:   Sathvika Vasireddy <sv@linux.vnet.ibm.com>
In-Reply-To: <18d05edc-6669-0308-7e6a-acd1cccd4f20@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o_gKlnWooEete_IYXwfWaVbnswCZMbBN
X-Proofpoint-ORIG-GUID: XhhseLmO8ObLsSwEkGkpV0hjb-T1OYOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-18_02,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=715 malwarescore=0 mlxscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206180021
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 15/06/22 21:33, Christophe Leroy wrote:
> Do you have any idea when you plan to send next revision ?
>
> I'm really looking forward to submitting the inline static calls on top
> of your series.

I'm planning to send RFC v3 next week.

- Sathvika

