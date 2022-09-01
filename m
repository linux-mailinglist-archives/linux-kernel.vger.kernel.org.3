Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489FC5A99EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiIAORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiIAORe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:17:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398823DBD6;
        Thu,  1 Sep 2022 07:17:33 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281EH8LT011720;
        Thu, 1 Sep 2022 14:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=p7ZDu3mPXOlU/9s1CKVUVetagdXHlTMw09mAXBkZHNU=;
 b=TQD4B9YcXc520YJ0Mo2jPW7HtI6iNUDNqhDUTg8kY+j1rf9SLYvXHQ/KuToDz9a8BV1K
 IShROPMpP+ii48CtC/NXAKQjjSgM8Z3Ja5Yi6Kl1h7pLXO2p4CML1AWKGZaAnzkAhliP
 pDn5eXYUq1rs+01nwLAiEI6965O1aQ8T4wkx5uUonPGpuMJQkm/drZogy7N0ZAflEZAv
 t2cMLntfPH5B92oV8Vz1OX7zNHh1tXtD0bYBCm0Y6Xp1quGv80Qg+/9PSKumMQWoNd2A
 3FKfpv+vjt5qxRkDuRBxlonI75X5SLLeZSQPbVqPB7ZyyhUVs9PzUGAMKxRqEYmFmHo5 8A== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jax9xgdyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 14:17:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 281E5tsQ008824;
        Thu, 1 Sep 2022 14:17:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3j7ahj6wtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 14:17:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 281EDnfh41091538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 14:13:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B21B74C044;
        Thu,  1 Sep 2022 14:17:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36EB04C040;
        Thu,  1 Sep 2022 14:17:06 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 14:17:06 +0000 (GMT)
Message-ID: <ec7cbb9963f26c4462f58c25f2c17c99a45ad766.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Thu, 01 Sep 2022 16:17:05 +0200
In-Reply-To: <8b561ad3023fc146ba0779cbd8fff14d6409c6aa.camel@linux.ibm.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
         <20220831201236.77595-2-mjrosato@linux.ibm.com>
         <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
         <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
         <e01e6ef2-ba45-7433-5fe4-a6806dac3af9@arm.com>
         <8b561ad3023fc146ba0779cbd8fff14d6409c6aa.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sQFCEZB30ldWGh-98-6H9JCUfsEG-ni9
X-Proofpoint-GUID: sQFCEZB30ldWGh-98-6H9JCUfsEG-ni9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---8<---
> > > 
> > > I do have a working prototype of using the common implementation but
> > > the big problem that I'm still searching a solution for is its
> > > performance with a virtualized IOMMU where IOTLB flushes (RPCIT on
> > > s390) are used for shadowing and are expensive and serialized. The
> > > optimization we used so far for unmap, only doing one global IOTLB
> > > flush once we run out of IOVA space, is just too much better in that
> > > scenario to just ignore. As one data point, on an NVMe I get about
> > > _twice_ the IOPS when using our existing scheme compared to strict
> > > mode. Which makes sense as IOTLB flushes are known as the bottleneck
> > > and optimizing unmap like that reduces them by almost half. Queued
> > > flushing is still much worse likely due to serialization of the
> > > shadowing, though again it works great on LPAR. To make sure it's not
> > > due to some bug in the IOMMU driver I even tried converting our
> > > existing DMA driver to layer on top of the IOMMU driver with the same
> > > result.
> > 
> > FWIW, can you approximate the same behaviour by just making IOVA_FQ_SIZE 
> > and IOVA_FQ_TIMEOUT really big, and deferring your zpci_refresh_trans() 
> > hook from .unmap to .flush_iotlb_all when in non-strict mode?
> > 
> > I'm not against the idea of trying to support this mode of operation 
> > better in the common code, since it seems like it could potentially be 
> > useful for *any* virtualised scenario where trapping to invalidate is 
> > expensive and the user is happy to trade off the additional address 
> > space/memory overhead (and even greater loss of memory protection) 
> > against that.
> > 
> > Robin.
> 
> Ah thanks for reminding me. I had tried that earlier but quickly ran
> into the size limit of per-CPU allocations. This time I turned the
> "struct iova_fq_entry entries" member into a pointer and allocted that
> with vmalloc(). Also thankfully the ops->flush_iotlb_all(), iommu_iotlb_sync(), and iommu_iotlb_sync_map() already perfectly match
> our needs.
> 
> Okay, this is _very_ interesting. With the above cranking IOVA_FQ_SIZE
> all the way to 32768 and IOVA_FQ_TIMEOUT to 4000 ms, I can get to about
> 91% of the performance of our scheme (layered on the IOMMU API). That
> also seems to be the limit. I guess there is also more overhead than
> with our bitset IOVA allocation that doesn't need any bookkeeping
> besides a "lazily unmapped" bit per page. With a more sane IOVA_FQ_SIZE
> of 8192 and 100 ms timeout I still get about 76% of the performance.
> 
> Interestingly with the above changes but default values for
> IOVA_FQ_SIZE/IOVA_FQ_TIMEOUT things are much worse than even strict
> mode (~50%) and I get less than 8% the IOPS with this NVMe.
> 
> So yeah it seems you're right and one can largely emulate our scheme
> with this. I do wonder if we could go further and do a "flush on
> running out of IOVAs" domain type with acceptable changes. My rough
> idea would be to collect lazily freed IOVAs in the same data structure
> as the free IOVAs, then on running out of those one can simply do a
> global IOTLB flush and the lazily freed IOVAs become the new free
> IOVAs. With that the global reset would be even cheaper than with our
> bitmaps. 

Ok disregard the last part, that's obviously not how the IOVA
allocation works. Will have to take an actual look.

> For a generic case one would of course also need to track the
> gather->freelist that we don't use in s390 but e.g. virtio-iommu
> doesn't seem to use that either. What do you think?
> 



