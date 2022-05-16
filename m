Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093ED5282EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbiEPLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiEPLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:12:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234F2DD2;
        Mon, 16 May 2022 04:12:02 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GB13MD039771;
        Mon, 16 May 2022 11:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wS0srYXEmxGor3ycWjDx9735YvM7Pkqu66LHyu1C2Zo=;
 b=N0/JpVTOOnQJxfsgu/OjyJyGQ+25O7a1MAIOQZDHSaB1XCntK0oxR6+rd4zXJddcIGWZ
 a8e5zqn2W56RKcKorE84JEO3axjVEMfUSYTtwEJ4Stf6ShRTWbMtkNZFtChRJfg8jiZ3
 r34NIfNXMG44cvzzqKve8057I38vW8iA8AFDgoR92V/WKRN0J9T3v3Sodw9PN5JhyJpP
 NgUoF3taGzx5KE9vQew/r1UkVXrD5XE4hrf28RUS8Qd3Y2bfcM9D6VsPOi8rp/fQUedZ
 BdZp1VnYY5Jsp08UOFfFYwJFO9r/kWwCNmTnsxyUPDylTblS2AUZRzA03ydijdrDX8MQ NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3ncb86ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 11:11:58 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24GB35d6005691;
        Mon, 16 May 2022 11:11:57 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3ncb86hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 11:11:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GB8fp9024019;
        Mon, 16 May 2022 11:11:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429ahh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 11:11:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GBBKnE25886980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 11:11:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61B38AE04D;
        Mon, 16 May 2022 11:11:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F356DAE045;
        Mon, 16 May 2022 11:11:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 May 2022 11:11:49 +0000 (GMT)
Date:   Mon, 16 May 2022 13:11:48 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/8] s390/entry: workaround llvm's IAS limitations
Message-ID: <YoIxdMNJjt9rxoeZ@tuxmaker.boeblingen.de.ibm.com>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-5-hca@linux.ibm.com>
 <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X>
 <Yn1CyTcrZk1Kgvoq@osiris>
 <YoIUX864ULCwu4pz@tuxmaker.boeblingen.de.ibm.com>
 <YoIlQaWNy1wu39ak@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoIlQaWNy1wu39ak@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ah_uCgCogIc6033dF8zDRplK3hk-zIq3
X-Proofpoint-ORIG-GUID: 1y6NPgZ1evu3eDCAvQMH8h0HpMJw65OI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_07,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 12:19:45PM +0200, Heiko Carstens wrote:
> On Mon, May 16, 2022 at 11:07:43AM +0200, Alexander Gordeev wrote:
> > Isn't the machine check handler refers to this memory before checking
> > unrecoverable storage errors (with CHKSTG macro) as result of this change?
> 
> Yes, indeed. However implementing this without another register will
> be quite of a challenge. So what I would prefer in any case: just
> assume that this minimal set of memory accesses work. Actually I'd
> seriously like to go a bit further, and even move the checks for
> storage errors back to C for two reasons:
> 
> - this would make the machine check handler entry code easier again
> - it would also allow to enter the machine check handler with DAT on
> 
> After all we rely anyway on the fact that at least the local lowcore +
> the page(s) which contain text are still accessible. Assuming that a
> couple of page tables also work won't make this much worse, but the
> code much easier.
> 
> So I'd suggest: leave this code as is, and at some later point move
> "rework" the early machine check handler code.
> 
> What do you think?

Sounds very reasonable. Please, find my:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>


Also, how such a follow-up looks to you?

	lgr	%r14,\reg
#ifdef CONFIG_AS_IS_LLVM
	larl	%r13,\start
	slgr	%r14,%r13
	clgfrl	%r14,.Lrange_size\@
#else
	slgfi	%r14,\start
	clgfi	%r14,\end - \start
#endif
