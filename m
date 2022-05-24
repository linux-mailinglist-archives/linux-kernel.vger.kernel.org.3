Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B175322C2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiEXF6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiEXF5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:57:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BC838BFA;
        Mon, 23 May 2022 22:57:44 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24O4CJTw032065;
        Tue, 24 May 2022 05:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=D1DtUDGWfuNdFdg7fjIR1LZYjhPONpcSa2JnaFoJ6Fo=;
 b=Iejd1T8ZXmDb8lXRSEKO0glQAZWRR6BoU7+YCnhBSOxUmjD/QmOL+idY6Rry+KbrGKBh
 Y0uYgPjPBvTGtI0I83SYHVcKUABJpDBYBsLczxphkMHhzXKi2r+3DB/XWMmbkGfvXvZz
 P8bX8KTKOLjPjeu0vezT8D4G6vzVlenSqjaib996MsJphHrublayAGjO0wnJy9ekK42F
 Nc6f9qeQrqbx6/Mzk1af+xtPy8SQ6+BYyWQCAVKsngXYpMnJw6LdbbKvin1HCCLE39FJ
 JO2Fhxy6AvLt6VMS0diImjiQ0kP+qex71+zX5vR+wteSkuskV4YdboHItz9qBlgyt43s Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8r4d1qt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 05:57:36 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24O5TXC6004772;
        Tue, 24 May 2022 05:57:35 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8r4d1qsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 05:57:35 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24O5mD7h027174;
        Tue, 24 May 2022 05:57:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3g6qq8u5ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 05:57:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24O5vTnW58720712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 05:57:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D221411C052;
        Tue, 24 May 2022 05:57:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 160B311C04C;
        Tue, 24 May 2022 05:57:26 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.16.48])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 24 May 2022 05:57:25 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Tue, 24 May 2022 11:27:24 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linuxppc-dev@lists.ozlabs.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] powerpc: check previous kernel's ima-kexec-buffer
 against memory bounds
In-Reply-To: <87fsl0na5m.fsf@mpe.ellerman.id.au>
References: <20220518200547.655788-1-vaibhav@linux.ibm.com>
 <20220520223025.GA359803-robh@kernel.org>
 <87wnedfaey.fsf@vajain21.in.ibm.com> <87fsl0na5m.fsf@mpe.ellerman.id.au>
Date:   Tue, 24 May 2022 11:27:24 +0530
Message-ID: <87tu9ffp6j.fsf@vajain21.in.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BPud39TvyDTqXrLAhrsqD4PNh6KJ-K1x
X-Proofpoint-ORIG-GUID: TXG_-lEDlS3sr2fwUoBYevw6vX2bWQIg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_01,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=933
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Ellerman <mpe@ellerman.id.au> writes:

<snip>
>
> Rob's point is that commit fee3ff99bc67 only moved existing code, the
> bug already existed.
>
> The function was introduced in:
>
>   467d27824920 ("powerpc: ima: get the kexec buffer passed by the previous kernel")
>
> So that's where the Fixes tag should point.

Thanks Mpe for explaining and apologies Rob as I initially didnt get the
point you made. I wrongly assumed that since the patch can only be
applied on top of commit fee3ff99bc67 hence fixes should point to
fee3ff99bc67.

I have sent out a v2 with the updated Fixes tag and also changes as
suggested by Mpe and Rob at
https://lore.kernel.org/all/20220524055042.1527968-1-vaibhav@linux.ibm.com/

-- 
Cheers
~ Vaibhav
