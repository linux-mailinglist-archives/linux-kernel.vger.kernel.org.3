Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5D75699CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiGGFWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGGFWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:22:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E81731235;
        Wed,  6 Jul 2022 22:22:12 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2675GvFU012386;
        Thu, 7 Jul 2022 05:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+1WB8LXMgfzVJPMaiZ9ErPb4Hm5qyRydXwOHGwyge80=;
 b=c/dSRJBz/6HN0DoBULnK8QqcgKEEt+7r3gmAlAHGoQ1J6qkAUWvp9KHQD2F79ctUXknf
 r4379Bt/Sn1Zq/j1mcilquud789K90lhBn0qy0VXna8h4MxrvEjRXOKwWfuTc46Qhbwc
 3pEJh5TzfytCiSsFTm94jtShdqVmHY221d7yPDSTBaljUsvCKfk4t+Ol1QeiomJZ4JhE
 JmvtpIkhJUGxk8nN78e/aDgowt4gveFGUfinQP48nSN/qygHUCuNRm5hwe9bUPgU8140
 hEsyO5/HILcgb5bEvsPEV2G+05GXBSPEXPCvtJgmmaP51p36BHeHcqcttGS++BJN+cYm lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5s6vg3g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 05:22:03 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2675IJt6016252;
        Thu, 7 Jul 2022 05:22:02 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5s6vg3fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 05:22:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2675M1Xo004196;
        Thu, 7 Jul 2022 05:22:01 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3h4usd21yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 05:22:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2675LvbQ24641846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 05:21:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85995AE045;
        Thu,  7 Jul 2022 05:21:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A700AE04D;
        Thu,  7 Jul 2022 05:21:57 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.48.113])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Jul 2022 05:21:57 +0000 (GMT)
Date:   Thu, 7 Jul 2022 07:21:55 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/crash: allow multi-segment iterators
Message-ID: <YsZtc9MV4buEfNKa@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <cover.1657049033.git.agordeev@linux.ibm.com>
 <3e713ce3865246766feca8397af2860cbe46854d.1657049033.git.agordeev@linux.ibm.com>
 <877d4q3b94.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d4q3b94.fsf@oc8242746057.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GBc8YupEPXwtRkZsnOsNhzGnc4Iph18j
X-Proofpoint-ORIG-GUID: o5kDKAlqg0Xp9dR6bve_wgoCzY4vUnFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_03,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=822 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:18:15AM +0200, Alexander Egorenkov wrote:
> > +	__iterate_and_advance(iter, csize, base, len, off,
> > +		({ copy_oldmem_user(base, src + off, len) < 0 ? csize : 0; }),
> > +		({ copy_oldmem_kernel(base, src + off, len) < 0 ? csize : 0; })
> 
> Question
> --------
> About return value of STEP in iterate_iovec().
> We return "csize" in case copy_oldmem_*() fails.
> If i'm not mistaken this could lead to an overflow in iterate_iovec():
> 
>   len -= (STEP);
> 
> Because len could be less than csize in case iovec consists of multiple
> segments, one of which is less than csize.
> 
> Better to return len ?

It certainly better. I'll post the fixed version.

> ({ copy_oldmem_user(base, src + off, len) < 0 ? len : 0; })
> 
> > +	)
> >  	return csize;
> >  }
> 
> Another thing is that now we never report any errors in contrast to
> the version before. This is OK ?

I think that is fine. It is consistent with other iterate_and_advance()
uses and actually converted by read_from_oldmem() to -EFAULT in case of
incomplete copy.

Thank you!
