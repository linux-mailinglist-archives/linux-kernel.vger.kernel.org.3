Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B4252538A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357019AbiELR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357012AbiELR0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:26:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B40F61C1;
        Thu, 12 May 2022 10:26:51 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CHOaZU013167;
        Thu, 12 May 2022 17:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=Y1/6uFfp3yWu69cBpG/b34aTugBLfs+8ovXVNB3HJqQ=;
 b=ljFmyJOH7e4WhKZvxGtQLjbBtU4Nl8OXCxmrREL2JcIfeBraxpP/r3wqw/HBhQOu9SOF
 jI4gA6znmCQ8Yv+r1aZ+Kxih+PXZLEAB00zIbJAvUz7cbnqOEI+w/tQDehxFtUpiwlm2
 DGI/M+JpVSxb7ZZax4I5Muo2AmL3yQWaOEUyZ1Nc0IWoqciXSEVxwrv49BnKMgkwhk5W
 p30TX4Jly7z0uXJ30D7FIbpgogQUxk0fOOQiHzi6eucHs2pFygfLiDtIXOgrNTokIg5/
 5qxc3xfiMtbYbCv/oW1wZVV/o0HoM/x3G9CymTRG+oKcYFF0fOUxepotzrN8iKqT90wB sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g154nhxw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:26:48 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CHPS8d015858;
        Thu, 12 May 2022 17:26:47 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g154nhxvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:26:47 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CHHagR014690;
        Thu, 12 May 2022 17:26:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3fwgd8ns0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:26:45 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CHQf5Y44564754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:26:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C64452050;
        Thu, 12 May 2022 17:26:41 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C6A695204E;
        Thu, 12 May 2022 17:26:40 +0000 (GMT)
Date:   Thu, 12 May 2022 19:26:39 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 5/8] s390/purgatory: workaround llvm's IAS limitations
Message-ID: <Yn1DT3zHNM9MMQJL@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-6-hca@linux.ibm.com>
 <CAKwvOdm3P+c0W+oZ9wtgMyxcP3KYX0UkYxO4o=7DLLyMdKdnPg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm3P+c0W+oZ9wtgMyxcP3KYX0UkYxO4o=7DLLyMdKdnPg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5DySOv71Pi7kL41QWeBBArV-ddrnFPWc
X-Proofpoint-GUID: Sp5cbfkUzo5mRNNnJalFX618Jd-IWIkc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_14,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=497 clxscore=1015 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:54:41PM -0700, Nick Desaulniers wrote:
> On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > llvm's integrated assembler cannot handle immediate values which are
> > calculated with two local labels:
> >
> > arch/s390/purgatory/head.S:139:11: error: invalid operand for instruction
> >  aghi %r8,-(.base_crash-purgatory_start)
> 
> I thought this was fixed in
> https://github.com/ClangBuiltLinux/linux/issues/1420
> https://reviews.llvm.org/D113341
> (clang-14)
> ?

Looks like the referenced fix only works for displacements, bit not
for immediates.
