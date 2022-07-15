Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9024B575E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiGOJcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:32:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A771147B;
        Fri, 15 Jul 2022 02:32:16 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F9SS4K013095;
        Fri, 15 Jul 2022 09:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EZQGAGOk2zu+sYqsKw5vPpal+rn07Q1rm98HBuqU3XM=;
 b=eUE93XybX6JekCymAT1tXIfpGNx7xcgHAugFBMXhl5KMXmHzgAIgE2DBOXJ5ZJ5wKtVQ
 tUEfmAUlZ4jJVNhCDe7iT4QLroIayz8qOOuzMeQSsulJnZtHMdcGUBWDHrR/Qo9ddLfI
 v5fkWCe6L2crfBDsH2yrUxxh+xScOCxKpLgjGSwNhE8Xe/c8TuEr4wn+mRfgHtOjXz95
 AbmJNfwITuwiEcC/hOVafGDYZZWhUh35yJyH5Tn3BBX+RFhOuU9KlmNrZvtMuhRngyb0
 KpjCvV9TP+8nKrab11o/j/T+kC2GTEtF1/IyEXq40KxIQqOGy39qBkDuFnNH5z0kEWBV 8w== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb5mq81g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 09:32:13 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26F9MBDn019258;
        Fri, 15 Jul 2022 09:32:11 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3h99s7b0s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 09:32:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26F9UX3A24248750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 09:30:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A02DD5204F;
        Fri, 15 Jul 2022 09:32:08 +0000 (GMT)
Received: from osiris (unknown [9.145.167.129])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 33FFB5204E;
        Fri, 15 Jul 2022 09:32:08 +0000 (GMT)
Date:   Fri, 15 Jul 2022 11:32:06 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Hendrik Brueckner <brueckner@linux.ibm.com>
Cc:     Steffen Eiden <seiden@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH v2 1/3] s390/cpufeature: rework to allow more than only
 hwcap bits
Message-ID: <YtE0FmnL9iDMMA9n@osiris>
References: <20220713125644.16121-1-seiden@linux.ibm.com>
 <20220713125644.16121-2-seiden@linux.ibm.com>
 <YtEedTrWv3Wc+cZQ@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtEedTrWv3Wc+cZQ@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uxpusP8BxJnU9AAzIWUty2EOtDTXQsTT
X-Proofpoint-ORIG-GUID: uxpusP8BxJnU9AAzIWUty2EOtDTXQsTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_03,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=719 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 09:59:49AM +0200, Hendrik Brueckner wrote:
> Regarding facility bits for cpu features:  Initially, I used
> MSA hwcap to cover all ciphers among all hw generations. With facility bit
> checks, it makes more sense to fine-tune and load based on respective
> MSA level or CPACF functions that is required for ciphers/hashes.
...
> > -module_cpu_feature_match(MSA, init);
> > +module_cpu_feature_match(S390_CPU_FEATURE_MSA, init);
> >  module_exit(fini);
> 
> which becomes automatically loaded if (any) MSA is available and then
> performs this check:
> 
> 	cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_512
> 
> which in the worst case would fail.
> 
> This might be a very useful follow-up patch to remove those mod init checks
> into the cpu feature.

Yes, that makes a lot of sense. Thanks for suggesting this!
