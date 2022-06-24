Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F9755A113
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiFXSrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiFXSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:47:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDB181517
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:47:11 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OISMin021675;
        Fri, 24 Jun 2022 18:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=a17ObSYsWh6tn4CWa+MosTekLvuw/eiyWyZit57N7os=;
 b=B264IqGvGGJwN3lTrBK3EYaDKqbCachL5/RpcxArXMxjd1uJQGnnP1etvz6MCJzNSgPT
 bDHU8+dY8HmfrhfV8K3BAmIOcBO5BhnaT3CjTvhjp+ZxcFyUL53x7UBNlmw/8FSQspAe
 QyfBJcjhbrxI6+/mOa9ZeKHCrdTZ6hWCSucRDNDbDLLbeYP4c6+lkJMUZ6Iee9jlFYuU
 YDkkYOTtVPBFMRv2s5np8AZgxmJ6lyVViZFsCA3HIge07XvitIsAjk0yrzDy84xhviLR
 LP67Nsk7jI2T3CJd7h2qiTPqjTETlEhEMZVROte3SlGJ3PVX/YCzQx1xc96plTfwBNOi +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwjjygeaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:44:39 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25OIYA1s010161;
        Fri, 24 Jun 2022 18:44:39 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwjjyge9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:44:39 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25OIa2Ho023599;
        Fri, 24 Jun 2022 18:44:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3gv3mbaw0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:44:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25OIiYB911338124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 18:44:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DED5A4040;
        Fri, 24 Jun 2022 18:44:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D165A4057;
        Fri, 24 Jun 2022 18:44:30 +0000 (GMT)
Received: from [9.43.0.85] (unknown [9.43.0.85])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jun 2022 18:44:30 +0000 (GMT)
Message-ID: <4f5f06da-c9eb-b36a-51c2-65e7e9845dd8@linux.vnet.ibm.com>
Date:   Sat, 25 Jun 2022 00:14:29 +0530
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
 <863b068d-e534-b377-c5d7-2f16fbb11977@linux.vnet.ibm.com>
 <23cd9412-30a4-e9f2-aaa1-eb3fc817711f@csgroup.eu>
From:   Sathvika Vasireddy <sv@linux.vnet.ibm.com>
In-Reply-To: <23cd9412-30a4-e9f2-aaa1-eb3fc817711f@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sDCEWhwosJ4-VKClu71Sat5_qdbG4zNw
X-Proofpoint-GUID: p2qvBdfzSL2egIKm10kwycRBWGF1UJ4x
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_08,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=741 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 24/06/22 12:38, Christophe Leroy wrote:
> Is everything going ok ? Don't hesitate if you need help.

Yeah, sure. Thanks!

I just posted RFC v3 here: 
https://patchwork.ozlabs.org/project/linuxppc-dev/cover/20220624183238.388144-1-sv@linux.ibm.com/

