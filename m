Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF92557BAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiGTPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbiGTPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:44:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353976393D;
        Wed, 20 Jul 2022 08:44:26 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KFh70t003467;
        Wed, 20 Jul 2022 15:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+fgW7O7A9eh72ef0Y8CFoZPVktRyCYPIHrH3KxHis0E=;
 b=qqs05SXXSkv3alUs6WqnlbkFrOdTmYHsGSmiiHDPOvmdtQG5KloyZFp08q6pRg6Dgzm/
 DcdISgEYRe2dUzDzsBv6M0uwq9y20l1yre85kpcm6Vikt3MBU5KouXSOMKNoTad6ZI3f
 LUsjCTd0R1LawrLWJ7eC+7iuCfCDOv4XHcR83PO0h2XZsVTL6QJETimP6k9QGFmmfUZG
 d3wFaGmN4vHnbcmyE5/gm5D18DembkMVHguOiVOn357czde8NfxNyUfKUoStCC1Lcpeg
 o5V/CCmOkGxlpCTN9bwbfLJZ+0Hv+rG6Jy+THQ1o+/CjfmmeeDqO6Dta/sW2Y0p0aWya DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hemkg80mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 15:44:15 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26KFiEaa008545;
        Wed, 20 Jul 2022 15:44:14 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hemkg80me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 15:44:14 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26KFUkCf001808;
        Wed, 20 Jul 2022 15:44:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3hbmy8wshr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 15:44:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26KFiLDR32375182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 15:44:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 879714C046;
        Wed, 20 Jul 2022 15:44:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECFBC4C040;
        Wed, 20 Jul 2022 15:44:08 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.22.197])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Jul 2022 15:44:08 +0000 (GMT)
Date:   Wed, 20 Jul 2022 17:44:07 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 0/4] s390/crash: support multi-segment iterators
Message-ID: <Ytgix++fJp7mICzx@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <cover.1658206891.git.agordeev@linux.ibm.com>
 <YtdzwLXFMuv02JEA@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtdzwLXFMuv02JEA@ZenIV>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XyRC1RMs6Cde_5zRblVJzJhAQPAA3yQu
X-Proofpoint-GUID: Xg6EANwvGuDkM4oILuB8ITL3kdqUJBG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_09,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=917 adultscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:17:20AM +0100, Al Viro wrote:
> OK...  Do you prefer it to go through s390 tree?  The thing is, I've
> stuff in iov_iter tree that conflicts with it; I'll gladly drop that
> bit (vfs.git #fixes-s390) in favour of your series (and drop s390
> bits from "new iov_iter flavour - ITER_UBUF" in #work.iov_iter - they
> are not needed anymore).
> 
> I can put your series into replacement of #fixes-s390, or pull it
> from whatever static branch you put it into - up to you.
> Preferences?

Hi Al,

I am preparing a branch for you.
Will retest it and let you know once it is done.

Thanks!
