Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52A34EC5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346102AbiC3Ndt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346402AbiC3Ndn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:33:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE5639815;
        Wed, 30 Mar 2022 06:31:57 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UBvZZ8000482;
        Wed, 30 Mar 2022 13:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=g1QikRaT51sf2bD8gHaes+NTudAH6B1jPft7JhQdytM=;
 b=VC5lMyyIeeLHgdRqyRIjUX3ZZZVd4Zfa5KgTsmrxk2qjfJ0HWi72WGZbwtuv5lJMCFLH
 W8lV8OI/HZKEkAymJlYJj2uM8ettZJj1bcFJS9Vvuwr1KSQfObAT/3FBnvHDedbhI18E
 k/eXnE3/3fCwiKGABdXNmd9COIlms2Tj65i177Ovk/H9kHfADEy95Sdy/9cgNJ4mJDOo
 /YpYvHqDms6q8Key1nblogoaC/x4yuFSuqlO+x5rIKQrtOZlgEisrdj+DXL5dhXwfVn9
 AFPvVKHm4LMmMHu47gMYRrlFztZL6DO3pmY7skwprKOWMZ/Evz4FaktCepMsWTcaFJ2t eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f4psu23vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 13:31:39 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22UDNaVk002385;
        Wed, 30 Mar 2022 13:31:39 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f4psu23vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 13:31:39 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22UD9cQZ011208;
        Wed, 30 Mar 2022 13:31:38 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3f1tfa4qba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 13:31:38 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22UDVbYp15925550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 13:31:37 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FBD27806E;
        Wed, 30 Mar 2022 13:31:37 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57E077805E;
        Wed, 30 Mar 2022 13:31:36 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.163.9.79])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 30 Mar 2022 13:31:36 +0000 (GMT)
Message-ID: <263108383b1c01cf9237ff2fcd2e97a482eff83e.camel@linux.ibm.com>
Subject: Re: filesystem corruption with "scsi: core: Reallocate device's
 budget map on queue depth change"
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     John Garry <john.garry@huawei.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 09:31:35 -0400
In-Reply-To: <08717833-19bb-8aaa-4f24-2989a9f56cd3@huawei.com>
References: <YkQsumJ3lgGsagd2@arighi-desktop>
         <f7bacce8-b5e5-3ef1-e116-584c01533f69@huawei.com>
         <YkQ9KoKb+VK06zXi@arighi-desktop>
         <08717833-19bb-8aaa-4f24-2989a9f56cd3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mEDWZFt0bAoXSjZLHiUoRKNU1jH2t8BS
X-Proofpoint-GUID: AoMbdsKTo_B0dgPgfYNQkNM4N52Fqu_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_04,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=882
 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-30 at 13:59 +0100, John Garry wrote:
> On 30/03/2022 12:21, Andrea Righi wrote:
> > On Wed, Mar 30, 2022 at 11:38:02AM +0100, John Garry wrote:
> > > On 30/03/2022 11:11, Andrea Righi wrote:
> > > > Hello,
> > > > 
> > > > after this commit I'm experiencing some filesystem corruptions
> > > > at boot on a power9 box with an aacraid controller.
> > > > 
> > > > At the moment I'm running a 5.15.30 kernel; when the filesystem
> > > > is mounted at boot I see the following errors in the console:
> 
> About "scsi: core: Reallocate device's budget map on queue depth
> change" being added to a stable kernel, I am not sure if this was
> really a fix  or just a memory optimisation.

I can see how it becomes the problem: it frees and allocates a new
bitmap across a queue freeze, but bits in the old one might still be in
use.  This isn't a problem except when they return and we now possibly
see a tag greater than we think we can allocate coming back. 
Presumably we don't check this and we end up doing a write to
unallocated memory.

I think if you want to reallocate on queue depth reduction, you might
have to drain the queue as well as freeze it.

James


