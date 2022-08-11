Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F9758FE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiHKOtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiHKOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:49:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED5A90805;
        Thu, 11 Aug 2022 07:49:17 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BEOmK8006288;
        Thu, 11 Aug 2022 14:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+GC9R7x1YfFeKd8lzcF4srU3IVSOeYic1WldiehWQdk=;
 b=j0x9mWGyXvjKypLdpErfH/BuoNHTS3rRsp/7eg8CmNVh+L5fjvU0RVprIiw08ciq/QFC
 Oiq75SZkhm5Axo5ovQA6k2863au2cGFDdFw7V4jWSFBCgP/ZSYVoFC8gblplO4d33iFz
 8yBKfKbiN43+Mr4KREEijJqDz3dyROp7eRYTY1ARXDjCyLSDdz4p96dt9LKEZdDarVYH
 Z11X2VW+aSAovzMeZhqwGrGz47gqNzO9xiY4rMYQ+xRD+Vlst5S/EXKTE39VyPxZXFjD
 /Gmdf8/Io5FJ9uvMmcDWZ8yzCN4aGrYp3QGZiI2DcZUOOyJ8ERMpiAPiwO30CiaNLuKe Fg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hw3gmrw9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 14:49:14 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27BEbDOS024223;
        Thu, 11 Aug 2022 14:49:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3huwvfsmf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 14:49:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27BEn9qJ32834018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 14:49:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EEDB52050;
        Thu, 11 Aug 2022 14:49:09 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.160.6.131])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1FE2D5204F;
        Thu, 11 Aug 2022 14:49:06 +0000 (GMT)
Date:   Thu, 11 Aug 2022 16:49:04 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2] s390/kvm: avoid hypfs error message
Message-ID: <YvUW4F4NHTF6DxBJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220620094534.18967-1-jgross@suse.com>
 <YrBarz+NVJmS+bBb@tuxmaker.boeblingen.de.ibm.com>
 <040024a3-77dd-8869-1e64-0a67a438d1f6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040024a3-77dd-8869-1e64-0a67a438d1f6@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IrLZtqPEP07CbpHTBtogYLZmcKiZWTam
X-Proofpoint-ORIG-GUID: IrLZtqPEP07CbpHTBtogYLZmcKiZWTam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_11,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=742
 spamscore=0 mlxscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:14:55AM +0200, Juergen Gross wrote:
> On 20.06.22 13:31, Alexander Gordeev wrote:
> > Applied, thanks!
> 
> Hmm, applied to which tree and branch?
> 
> I would have thought this patch should have reached upstream by now...

Hi Juergen,

This one is going to land in -rc2 or -rc3 most likely.

Thanks!

> Juergen





