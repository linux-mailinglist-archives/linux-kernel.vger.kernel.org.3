Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9524F11B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350435AbiDDJNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbiDDJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:13:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2A73B29D;
        Mon,  4 Apr 2022 02:11:09 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2348LQqK013681;
        Mon, 4 Apr 2022 09:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=2WywcuoGyiLhJ5Ccuo0nWNSC0B6ohCCLlv2NWnfdNDs=;
 b=Sl1BHhXCzs9QpcupNWVM2xteYTW59V+T1zsu5D+pFgjG4Y573ePv3dcGfzTKeULB4k1m
 7pR8sy79vZTD9NzIYhHFTrBnSDOeJmoWGJT7u1oWWaP4OXvQzlJ9GSCqB/vgzmTGmujL
 CmXkdcf1FfBLm1pV2aXf821U5Mj4H5JecXn21gD9M/WsLeiLNPiczx8gf4uwT7tNNKeY
 5sfEhNFbiS2PVWAIgbAyvVVgLf6y4WEbJ+mjR58Lf1HOZRC3qofSs3Wng4zuV52x5AnA
 cuKEiPJSe4S9SoMzhDNF+hkjIWPjt2HtImNxz8Ae/iBLabBsP6pdj5Lm5e96cveJ19xv eQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f701rd3u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 09:11:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23497Ohh013797;
        Mon, 4 Apr 2022 09:11:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhk8j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 09:11:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2348wkXE48759142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Apr 2022 08:58:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D860A4054;
        Mon,  4 Apr 2022 09:10:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA84A405B;
        Mon,  4 Apr 2022 09:10:56 +0000 (GMT)
Received: from osiris (unknown [9.145.2.177])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  4 Apr 2022 09:10:56 +0000 (GMT)
Date:   Mon, 4 Apr 2022 11:10:55 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Haowen Bai'" <baihaowen@meizu.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Subject: Re: [PATCH] s390: Simplify the calculation of variables
Message-ID: <Ykq2H+POaGs0GHVU@osiris>
References: <1648434982-28862-1-git-send-email-baihaowen@meizu.com>
 <9ab80e670fb341ddaba51a9cd78203fe@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab80e670fb341ddaba51a9cd78203fe@AcuMS.aculab.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pMYbc6J193IrfqjGGtT-XYMO4Sj59dKw
X-Proofpoint-ORIG-GUID: pMYbc6J193IrfqjGGtT-XYMO4Sj59dKw
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_03,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=927 clxscore=1015 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:15:49PM +0000, David Laight wrote:
> From: Haowen Bai
> > Sent: 28 March 2022 03:36
> > 
> > Fix the following coccicheck warnings:
> > ./arch/s390/include/asm/scsw.h:695:47-49: WARNING
> >  !A || A && B is equivalent to !A || B
> > 
> > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> > ---
> >  arch/s390/include/asm/scsw.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
> > index a7c3ccf..f2baac8 100644
> > --- a/arch/s390/include/asm/scsw.h
> > +++ b/arch/s390/include/asm/scsw.h
> > @@ -692,8 +692,7 @@ static inline int scsw_tm_is_valid_pno(union scsw *scsw)
> >  	return (scsw->tm.fctl != 0) &&
> >  	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
> >  	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
> > -		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
> > -		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
> > +	       (scsw->tm.actl & SCSW_ACTL_SUSPENDED))
> >  }
> 
> I'd split that impenetrable boolean expression up.
> 
> I think this is equivalent:
> 	if (!scsw->tm.fctl)
> 		return 0;
> 	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
> 		return 0;
> 	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
> 		return 1
> 	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
> 		return 1;
> 	return 0;
> 
> The generated code could even be the same.

Yes, we had the very same discussion here:
https://lore.kernel.org/linux-s390/20210820025159.11914-1-jing.yangyang@zte.com.cn/

Where the outcome also was that it doesn't make sense to replace one
unreadable version with another unreadable version just to get rid of
a warning.

Haowen, could you please resend with a proper readable version, or
alternatively, Vineeth, could you address this please, so this doesn't
come up again?

Thanks!
