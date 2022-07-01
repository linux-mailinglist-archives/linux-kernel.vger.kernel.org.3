Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E4F5632CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiGALnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGALnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:43:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0F6D56C;
        Fri,  1 Jul 2022 04:43:45 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261BLUcN039011;
        Fri, 1 Jul 2022 11:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=4Ig8q/zItxYk+yCgAqOsbU65m0EVzCGLXoaZt/UeboU=;
 b=kfeKbE50hY9clhvpQMfd5uaUYTIcFUO0jkP9wC8kXuD31EHpxfBwrAPVwbRTu/EllPjx
 FvW7OLh5uNO+6rwWOT4xaX4NZ5ltND542Oldisgku1fozR2ZVHd28T60GrjDJtNXJnQD
 3pwJ7xYlsk3J8k07nY8RDVAgwWJR+QyUywRFgDA02EaWftRwqAVzXcW/qpBNY/jVEggS
 yosDlQAJ2mHL4SMP28bJAOlgDSfmF130ovzJ2tUR1kgnHdaDYoQurJV241QguPs3B0a3
 IrEASsTfQPDu+oLYSBp5dGoGb8X2nXEgCdVEGapQTgRQfuMgOemPDxwhdNf1lyx6wtCE Cw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1yyngx4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 11:43:34 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 261BKGb9025460;
        Fri, 1 Jul 2022 11:43:33 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3gwt0a9crg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 11:43:33 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 261BhW1q22610252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 11:43:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73CF87805E;
        Fri,  1 Jul 2022 11:43:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8863A78063;
        Fri,  1 Jul 2022 11:43:31 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.163.6.8])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 11:43:31 +0000 (GMT)
Message-ID: <1338d1aed2e55c3107363a6b7e521d75f877db2f.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: bfa: use strscpy to replace strlcpy
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     XueBing Chen <chenxuebing@jari.cn>, martin.petersen@oracle.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Jul 2022 07:43:30 -0400
In-Reply-To: <2975fca0.d18.181b97a760e.Coremail.chenxuebing@jari.cn>
References: <2975fca0.d18.181b97a760e.Coremail.chenxuebing@jari.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VKWl1J7Nl0FG63qangoHSp7x6BFa4oCA
X-Proofpoint-ORIG-GUID: VKWl1J7Nl0FG63qangoHSp7x6BFa4oCA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=670 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1011 bulkscore=0 spamscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2207010043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-01 at 19:16 +0800, XueBing Chen wrote:
> The strlcpy should not be used

That's not true.

>  because it doesn't limit the source length. Preferred is strscpy.

And that's not the reason why strscpy is often a marginally better
choice.  In the case of what you change in bfa, none of the reasons why
strscpy might be marginally better actually apply.

James


