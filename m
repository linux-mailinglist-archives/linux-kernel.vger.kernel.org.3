Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0036525553
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357851AbiELTD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiELTDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:03:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5161820F4EB;
        Thu, 12 May 2022 12:03:53 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIbjm4018232;
        Thu, 12 May 2022 19:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=qhb5EdS7Ah6FnpMCgiZxIqTWU6iB3Z4pxEjaBzyE5oU=;
 b=GGA1U5whjDKp9/s6k6RfD3z+0Y/oT9zwHt7KOM2hwUxopa+VLTxDbKD+b9P5CYlTY02V
 stB/nZUARjx7P3j70EbwPvFtZyA7yb5igqxnrIvLW991RISHfwVNrm5E+mnSQe41lW+x
 dLbmdVY93IiQRhDzV3Wjm9KH9xm2T2fLMNrTbIXsPx5+R5gDyZHPArAHYvyGeOf4+AYt
 rr1Vr6SujAuMSP2tTqYxsgP/SS6OB5sL3QP1ZAizJAfcPybuJQhJ/qPjkhGJw5DcT1GM
 +uSlFy64GUoJTxTtrSrmRf2bkLzTFau7xj3/q/b49Ng2nbdUX/eWTyGiZQ3qGQFcvqat 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g17p9rf1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:03:50 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CIrFjP024560;
        Thu, 12 May 2022 19:03:49 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g17p9rf1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:03:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CIwoYw030926;
        Thu, 12 May 2022 19:03:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8yfm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:03:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CIo4Ib44957982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 18:50:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D44CA404D;
        Thu, 12 May 2022 19:03:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C5D6A4040;
        Thu, 12 May 2022 19:03:42 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 May 2022 19:03:42 +0000 (GMT)
Date:   Thu, 12 May 2022 21:03:41 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/8] s390: allow to build with llvm's integrated assembler
Message-ID: <Yn1aDRKgB9zJIk21@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <Ynwh/Uk3IyiyRzO3@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynwh/Uk3IyiyRzO3@dev-arch.thelio-3990X>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SG9IGlokKTe0Jgn4P8cpBtE9A1oJ2ylA
X-Proofpoint-ORIG-GUID: S_IRG6k-WoOjFd9lZU-gUEyCpo285umZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_16,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=794 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:52:13PM -0700, Nathan Chancellor wrote:
> Hi Heiko,
> 
> On Wed, May 11, 2022 at 02:05:24PM +0200, Heiko Carstens wrote:
> > A couple of patches which in result make it finally possible to build the
> > kernel for s390 with llvm's integrated assembler. Several configs build
> > without errors or warnings, and the kernel also works as expected.
> > 
> > Note that patch 6 ("s390/boot: workaround llvm IAS bug") reveals a
> > miscompile. This looks like a bug in the instruction definitions of the mvc
> > and clc instructions(?). I'd like to ask people to look into this, since
> > this silently generated broken code.
> 
> I think it should be pretty simple to file a bug report for this since
> it occurs in a standalone assembly file? I agree with Nick that there
> should be a bug report filed and linked to in patch 6 so that we don't
> lose track of it.

https://github.com/llvm/llvm-project/issues/55411

> I applied this series to the latest s390 for-next branch (c4fb15578802)
> and built a few in-tree and distribution configurations with clang-14
> and clang-15 then boot tested them in QEMU with a simple buildroot
> userspace. I did not see any new warnings or errors. This is awesome, I
> am excited to get this wired up in our CI!
> 
> In case it is worthwhile:
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Yes, it is. Thanks a lot!
