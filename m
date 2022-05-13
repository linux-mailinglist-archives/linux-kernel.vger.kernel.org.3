Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F5525E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378954AbiEMJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244743AbiEMJR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:17:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CD15839C;
        Fri, 13 May 2022 02:17:54 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24D7UpbE006378;
        Fri, 13 May 2022 09:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RpvtUyPNiw1aQg2SmTBc2vBT2Ws1bAemQygkKbaCNiQ=;
 b=E6fDHfuUrIPtXY9G22j32o0yeV7eykAwJh37wliKggkgWtXHCMnIxTt0ZJug0Ghfg37N
 ve4ab+PYaEkfPWRDvPLGSy6u9ZoFKeDFk6ZtBvFfqNAP2Wb171jFPC3T2PO89DPFipTw
 N8UnT391bTjYfU362P/Tb7PwFBfqMNLQVAEOJ0CfrXK5LgOFJPw0Ih97JuKgefpsOgck
 aPvfEXMDgod4ejLkFxoJr5ytI1Q7pqpflRaG9J70afqeP3s6RNAxvk+DVRU4ommCMOXM
 9SKnxHGI3Z5Fe+McP2TdBgM9/q6q511HMalHPq+Qj0r8jUDz10cRk6YOLroAf0lwPU+W fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1k0s1xj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 09:17:51 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24D97VFA023250;
        Fri, 13 May 2022 09:17:51 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1k0s1xhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 09:17:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24D98k0s008224;
        Fri, 13 May 2022 09:17:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd90ayy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 09:17:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24D9HhNt53739902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 09:17:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FE6E5204E;
        Fri, 13 May 2022 09:17:43 +0000 (GMT)
Received: from localhost (unknown [9.171.34.99])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id A33DA5204F;
        Fri, 13 May 2022 09:17:42 +0000 (GMT)
Date:   Fri, 13 May 2022 11:17:41 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/8] s390/alternatives: provide identical sized
 orginal/alternative sequences
Message-ID: <your-ad-here.call-01652433461-ext-0634@work.hours>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-2-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220511120532.2228616-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ikj6y5DDvEKklrQMT47845eaupOnF8CQ
X-Proofpoint-ORIG-GUID: pjZpJuddCSOivDYQSSPmqDnE3sMMJrfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=4 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 spamscore=4 bulkscore=0 clxscore=1011 impostorscore=0 mlxlogscore=135
 mlxscore=4 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:05:25PM +0200, Heiko Carstens wrote:
> Explicitly provide identical sized original/alternative instruction
> sequences. This way there is no need for the s390 specific alternatives
> infrastructure to generate padding sequences.
> The code which generates such sequences will be removed with a follow on
> patch.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/spinlock.h |  2 +-
>  arch/s390/kernel/entry.S         | 20 ++++++++++----------
>  arch/s390/lib/spinlock.c         |  4 ++--
>  3 files changed, 13 insertions(+), 13 deletions(-)

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
