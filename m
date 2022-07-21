Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E96A57C6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiGUIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiGUIqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:46:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A98183B8;
        Thu, 21 Jul 2022 01:46:32 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L8FdGB027725;
        Thu, 21 Jul 2022 08:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=x80jC0+vqrPicCD5sQzIJ9uqpCvdD5695j7ali2vEaw=;
 b=sZyVunw2rBZG7DHqi0blHbs8eTAtBHIxO7GaKTR0VLNhUr0OqjELSVllUr2Gkb3G+spd
 Zg2i1fNEgnbjQHkJj9l3qaAO9CHTUj74NpUEak3++fWX2N8Hd635ae0UI/tCISkKIX5R
 ZQyQwBt6KoT12m8VVi78DkQbOBH0k2mQVURr/jE96LOgUlshbNs7Y5qhTqsv0TIQOyge
 XO0EJ9fbstL8PvP8lie1YoN9UYxB6XkVWYVp4JHch+MfOhxDE+epz4Fw/hWmmr6irWzA
 dTzWmgCuBZQfLnUmI6SsXsMdbkbmW0eYu6wOz7NrAsoseb7LnbpNf4to5bLt/DZ9iUv/ UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hf34srunj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 08:46:24 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26L8ItWm009789;
        Thu, 21 Jul 2022 08:46:24 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hf34sruky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 08:46:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26L8Kued012338;
        Thu, 21 Jul 2022 08:46:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3hbmkj6nrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 08:46:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26L8kIw516187772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 08:46:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5E4C11C050;
        Thu, 21 Jul 2022 08:46:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C06A11C04C;
        Thu, 21 Jul 2022 08:46:18 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.22.197])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Jul 2022 08:46:18 +0000 (GMT)
Date:   Thu, 21 Jul 2022 10:46:16 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 0/4] s390/crash: support multi-segment iterators
Message-ID: <YtkSWBPpUe8CqNxV@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <cover.1658206891.git.agordeev@linux.ibm.com>
 <YtdzwLXFMuv02JEA@ZenIV>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtdzwLXFMuv02JEA@ZenIV>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wirt8CpA_AQCfHEZ0HCuATCAMHvigZiN
X-Proofpoint-ORIG-GUID: tJF6N95NuLGFjDOGt52sD8BrlBw7IVwZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:17:20AM +0100, Al Viro wrote:
> I can put your series into replacement of #fixes-s390, or pull it
> from whatever static branch you put it into - up to you.
> Preferences?

Hi Al,

Please find the changes since commit af2debd58bd769e38f538143f0d332e15d753396:

  s390/crash: make copy_oldmem_page() return number of bytes copied

up to ebbc9570169147740aa39aee1d61b4cc5a631644:

  s390/crash: support multi-segment iterators

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git	vmcore-iov_iter

Please, note three (rather trivial) prereq commits to pull along:

  f6749da17a34 s390/crash: fix incorrect number of bytes to copy to user space
  86caa4b67895 s390/crash: remove redundant panic() on save area allocation failure
  7190d84966b3 s390/mm: remove unused tprot() function

Thanks!
