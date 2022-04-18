Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6204505D39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiDRRDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiDRRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:03:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C371CB31;
        Mon, 18 Apr 2022 10:01:08 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23IF3chh007549;
        Mon, 18 Apr 2022 17:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=FL3zNX7ORY2U/0LFBD8/RdrYIHzgYNqvN+ETkc+/j2Y=;
 b=aI3H/+uHjIXusoLj/aCVwpUFA8B8FZjh8E6kmOuIIOM7Olgudvz/jRtf1U6IYwn0r/r/
 e1v4Ub3surhCLT8NkFCQGiKQifaqAEWYuF7+9qG22IxxrbfazxPk9AvR4PvDNIVvc8+B
 T2dcOBajKXy3cvpYPV97XdFvq1lk6Fyj8Fv76+zv8sUb3W9tlqtYPKm5oko19pQY5SLE
 W9LuDXFKDcihj+LpWO1hY8BLXeGG9VgQYKxM9I1GRQWHZjQUoeATiwZiDgZvkgEW5I9C
 uM9Jan1PSKB+h9cOCpLLPAwjzl26H8EvHxXhwd4OTvbXW/sttY5I2G7BMZLQ3doBzSus bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7cshdd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 17:01:08 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23IGdoN2018966;
        Mon, 18 Apr 2022 17:01:07 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7cshdc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 17:01:07 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23IGwxGD031143;
        Mon, 18 Apr 2022 17:01:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3ffne92d5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 17:01:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23IH11i447382894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 17:01:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76160A4055;
        Mon, 18 Apr 2022 17:01:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01362A4051;
        Mon, 18 Apr 2022 17:01:01 +0000 (GMT)
Received: from osiris (unknown [9.145.50.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Apr 2022 17:01:00 +0000 (GMT)
Date:   Mon, 18 Apr 2022 19:00:59 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: vfio-ap: Remove the superfluous
 MODULE_DEVICE_TABLE declaration
Message-ID: <Yl2ZS7lyzyit9lbk@osiris>
References: <20220413094416.412114-1-thuth@redhat.com>
 <2440b3f3-6961-4091-438f-7120b9177164@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2440b3f3-6961-4091-438f-7120b9177164@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8bLREk_6SrKyhrgG76-ng5n46aKYmpBL
X-Proofpoint-ORIG-GUID: OfQwYNTHlYKBLGOWzykv_SpB6f8_4VHf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=769 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204180101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 10:23:38AM -0400, Tony Krowiak wrote:
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> On 4/13/22 5:44 AM, Thomas Huth wrote:
> > The vfio_ap module tries to register for the vfio_ap bus - but that's
> > the interface that it provides itself, so this does not make much sense,
> > thus let's simply drop this statement now.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   See also my previous patch to register it for the "ap" bus instead:
> >   https://lore.kernel.org/linux-s390/20211201141110.94636-1-thuth@redhat.com/
> >   ... but since it has been decided to not auto-load the module uncondi-
> >   tionally, I'd like to suggest to rather drop this line now instead.
> > 
> >   drivers/s390/crypto/vfio_ap_drv.c | 2 --
> >   1 file changed, 2 deletions(-)

...

Applied, thanks.
