Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074465599D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiFXMqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiFXMqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:46:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671614AE24
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:46:11 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OCfutX015325;
        Fri, 24 Jun 2022 12:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U2/9YArPeR4A0exNf3XtNGgMv7CtlE/RHX3Ooijd5jE=;
 b=XxbyCBOU9YU9DSNeUTRQ4aFazwcyvTZWOOLHuM1lIJgRBALWd9TwxYtJ9ZwM6HP81sCo
 bDJXRZzeRYh2uF+Nihuys129rHGlDLt2FqENWOaevjzDnUZrW+laXEDt139svUwh8FHK
 Qyc0+tPmaQkVtggm4j0kukPEiBYp/6FCeJCUvdCUk5bp9WTgVozT41GeSMYo65p769H7
 AEvARL8GClYqq3nJojl6duOz/cxvfnVZwpfR3R2rAGZmBR2DLVf6UnjT1/KO9/eOFfhR
 R/CqMDJ/oToik8FvPQ//iLPTd/Bcl50JoOQLJDhz8EMBnyCpqLSCB2aCt/QkH0+2v7D7 KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwdgeg30u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 12:45:43 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25OCg7ee015690;
        Fri, 24 Jun 2022 12:45:43 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwdgeg2yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 12:45:43 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25OCJwGG009871;
        Fri, 24 Jun 2022 12:45:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3gv3mbahg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 12:45:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25OCilDZ21692714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 12:44:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 358CDA404D;
        Fri, 24 Jun 2022 12:45:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDC2EA4051;
        Fri, 24 Jun 2022 12:45:37 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jun 2022 12:45:37 +0000 (GMT)
Message-ID: <97ae3ac2-c0a8-d675-50a4-0daf960c7f05@linux.ibm.com>
Date:   Fri, 24 Jun 2022 14:45:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/4] watchdog: export watchdog_mutex and
 lockup_detector_reconfigure
Content-Language: fr
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, haren@linux.vnet.ibm.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220614135414.37746-1-ldufour@linux.ibm.com>
 <20220614135414.37746-3-ldufour@linux.ibm.com>
 <YrWF0w3mpYA//BX6@infradead.org>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <YrWF0w3mpYA//BX6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nSKlA-sfknZJQa0Ka38-SLnvKhTv4gFO
X-Proofpoint-GUID: vX6G5QeXuE40TcchbWa2XA4NgLHmUbJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_07,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022, 11:37:23, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 03:54:12PM +0200, Laurent Dufour wrote:
>> The watchdog_mutex is exported to allow some variable to be changed under
>> its protection and prevent any conflict.
>> The lockup_detector_reconfigure() function is exported and is expected to
>> be called under the protection of watchdog_mutex.
> 
> Please provide an actual function accessor instead of directly touching
> a global lock.

Thanks Christoph,

I'll try to not touch to that mutex, if that's not doable, I'll create
function accessor as you're suggesting.

