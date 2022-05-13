Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991F95261DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380248AbiEMM3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380245AbiEMM31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:29:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976EF4249A;
        Fri, 13 May 2022 05:29:26 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DAkdj2005157;
        Fri, 13 May 2022 12:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=IzPP9L+REaBixKO9Nlnb2NfMZQ3wq0sMMzgLB4g7Sr0=;
 b=o8wSAD8QmpO/wu3Oyd6Pu+ZKNqDqasBph5Zmdtd4HZE3+FEv7RYY7gyk9Wt+enIHTrzu
 6nd7JjzKBKrfC/ri5afU/YOxu0M6KGePH08tuKb0ljjl6Pqme0CtOEyguY/nbikmo8aL
 fsHoLZ4sTjNZiw4k3ekeoYTIA4xdhAfykJ0m9VFRf/Oi5gUSdCNIYVv1wimwyPh8pn2d
 vaJaxfvtOwbk/ub9ASU22Omnmg8j8bSIAucmOlw2YhznCm93fxlWm7iuBBzXOpNCARJV
 vvJPQSj+SLqsH2XG82AC9uaBAytCLBxbEXv41uNKJxNIXS5FNsugDN8eIOIYEGpU21tJ 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1nvjsvpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 12:29:17 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24DCSMOV000747;
        Fri, 13 May 2022 12:29:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1nvjsvpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 12:29:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DCMmVX006302;
        Fri, 13 May 2022 12:29:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd90ngn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 12:29:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DCTAEx17170758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 12:29:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E2F42042;
        Fri, 13 May 2022 12:29:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60AB74203F;
        Fri, 13 May 2022 12:29:10 +0000 (GMT)
Received: from osiris (unknown [9.145.14.167])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 13 May 2022 12:29:10 +0000 (GMT)
Date:   Fri, 13 May 2022 14:29:09 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/8] s390/entry: shorten OUTSIDE macro
Message-ID: <Yn5PFSoZGuuUFvy7@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-4-hca@linux.ibm.com>
 <Yn1CLcsu9I0M8IEM@osiris>
 <CAKwvOdmSBNsA7C2ZCGDEmuxCituSQ=HPJx=9+AsBAOYfkSZRPA@mail.gmail.com>
 <Yn1ctPDjPaU2wsor@osiris>
 <CAKwvOdkwamvuCFkj-uFA_uT+gLNr8-v-zuGYLYb-pV8TOTxDSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkwamvuCFkj-uFA_uT+gLNr8-v-zuGYLYb-pV8TOTxDSw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uVKBI8XRbtrImnTJvnNQoMwtJn-wntEi
X-Proofpoint-GUID: L8HiSV1-QsCZ_KGTRTroToBL6eEqhUom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:25:01PM -0700, Nick Desaulniers wrote:
> Interesting! Thanks for the links.
> I'm guessing in our CI that we should probably pursue testing some of
> the newer revisions. Wasn't defconfig updated from z10 to z12 not too
> long ago?

Yes, that was 1.5 years ago (commit ac94a2911e84 ("s390: update defconfigs")).

> So probably
> CONFIG_MARCH_Z13
> CONFIG_MARCH_Z14
> CONFIG_MARCH_Z15
> CONFIG_MARCH_Z16
> 
> All look like they're still "supported" (and I'm guessing
> CONFIG_MARCH_Z10 and CONFIG_MARCH_Z196 are not too much burden to
> continue to maintain kernel support for), with a higher emphasis
> perhaps on z15+z16?

That makes sense. However for the kernel it doesn't make a difference
if compiled for z15 or z16 - there were no general instructions added
with z16 that would make any difference for the kernel.
All new instructions that came with z16 are either only relevant for
user space, or used via .insn notation in the kernel, and only used if
some hardware feature is present.
