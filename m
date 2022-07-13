Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0531257323C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiGMJQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiGMJQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:16:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE46E5DE8;
        Wed, 13 Jul 2022 02:16:27 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26D8v43D009714;
        Wed, 13 Jul 2022 09:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=erJFkOohpbHECeHIavdOswACvtYQlnKdA0uc1MzG5AA=;
 b=JHug56owbByfziX1g7zSZ8BnIzSNcT88tp2WZecRbGm+3G7jOFpGZGXZAQOs+8NU0sCM
 CrHI32QBuGg1X+6oyhTuXUi54YEx7PPr+9S07K/7bY4XUcwXVVMQUP0g3HLQnNk0T+mW
 kL5croPDBmh53LOZkU/bGT0OwLXuz7yXnAQKWFuWqETfifP3yuhgzesKCF+jabV8PbXb
 /FRojc+B4T71ZsQKnrj0lvQRzQFo9bDo0NVOF9h02nJtF0e4qzo4gePhcYQ4vUTmRBgR
 uudzFma5PjLQawhyhjrQ9Tuj7oZuQCFamTBD0OI37pRh7jJZIiFwgkB0r7rZ4OdFttJS gg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9u078jab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 09:16:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26D9693Z023075;
        Wed, 13 Jul 2022 09:16:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xhwe8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 09:16:23 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26D9GKvl24183150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 09:16:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50F78A4054;
        Wed, 13 Jul 2022 09:16:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2B39A405B;
        Wed, 13 Jul 2022 09:16:19 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.0.75])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 09:16:19 +0000 (GMT)
Date:   Wed, 13 Jul 2022 11:16:17 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH 3/3] s390/uvdevice: autoload module based on CPU
 facility
Message-ID: <20220713111617.0c7dec70@p-imbrenda>
In-Reply-To: <02b6537d-97e6-c27b-7621-c5b116995a00@linux.ibm.com>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
        <20220712105220.325010-4-seiden@linux.ibm.com>
        <20220712184924.0d80c474@p-imbrenda>
        <02b6537d-97e6-c27b-7621-c5b116995a00@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NgSQi5gHLbG1kteJbvIalXW_B4h4Tsou
X-Proofpoint-ORIG-GUID: NgSQi5gHLbG1kteJbvIalXW_B4h4Tsou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207130038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 10:39:47 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> On 7/12/22 18:49, Claudio Imbrenda wrote:
> > On Tue, 12 Jul 2022 12:52:20 +0200
> > Steffen Eiden <seiden@linux.ibm.com> wrote:
> >   
> >> Make sure the uvdevice driver will be automatically loaded when
> >> facility 158 is available.
> >>
> >> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> >> -module_init(uvio_dev_init);
> >> +module_cpu_feature_match(S390_CPU_FEATURE_UV, uvio_dev_init);  
> > 
> > does this still prevent manual loading when the feature is not present?  
> yes.
> 
> Have a look at the macro definition at 'include/linux/cpufeature.h':
> 
> Use module_cpu_feature_match(feature, module_init_function) to 
> 
> declare that 
> 
> [snip]
> b) the module must not be loaded if CPU feature 'feature' is not present 
> 
>     (not even by manual insmod).

that is what I needed to see :)

> 
> The test 'facility(158)' just moved to cpu_have_feature() in 
> '/arch/s390/kernel/cpufeature.c'.
> >   
> >>   module_exit(uvio_dev_exit);
> >>   
> >>   MODULE_AUTHOR("IBM Corporation");  
> >   

