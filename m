Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F200525E89
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378966AbiEMJSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378968AbiEMJS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:18:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFB85E74C;
        Fri, 13 May 2022 02:18:22 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24D9AHxC004372;
        Fri, 13 May 2022 09:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0G0uc882R6uqOeN60gm10guVSqUxvSgekLWSAu5MDwo=;
 b=NNzJZYG1uibOabBA8Mp4TpKgo4vPIe0woBkCl/IQoZ5r8dpkA+ZvcPeiIrtg/lWjsnd8
 QoF9/4s4KNnjwggIn0Cn5PNUVgzKGPFnTWPSPdiQyHWTJ/s/Z86YLRfoAiElLopF8qrR
 YZ3fTpGr6Lqd1OMm9thd8i9ze0MsrQ0aU1NUi0bbgPPeO1hmBVpG37GDPEP+T67RvLWh
 CumS/RxK6PsxlELbKJpG+BFIQD3X8HFDAcsakOwh1pYiYLnD2qNU3zqw+iqLbLkYsqjc
 3Qf8XNfbGmWCfOulK58vEB2pcoTjV/dKVrPS8Ai+dEB5OV2kZHzTfRBupf0VspAkh3fU bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1jstj3g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 09:18:18 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24D9EuAh024657;
        Fri, 13 May 2022 09:18:18 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1jstj3fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 09:18:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24D98jov008221;
        Fri, 13 May 2022 09:18:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd90b0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 09:18:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24D9Hlhn33030436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 09:17:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DF17A4054;
        Fri, 13 May 2022 09:18:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B9FA405B;
        Fri, 13 May 2022 09:18:09 +0000 (GMT)
Received: from localhost (unknown [9.171.34.99])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 13 May 2022 09:18:09 +0000 (GMT)
Date:   Fri, 13 May 2022 11:18:08 +0200
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
Subject: Re: [PATCH 2/8] s390/alternatives: remove padding generation code
Message-ID: <your-ad-here.call-01652433488-ext-2779@work.hours>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-3-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220511120532.2228616-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: knGTXHCeSMSjOP2SSu-bjWmoVSFGewq7
X-Proofpoint-GUID: QFLqUoIdtflvWUTF2tgMhuvq0wpsk0RO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=637 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:05:26PM +0200, Heiko Carstens wrote:
> clang fails to handle ".if" statements in inline assembly which are heavily
> used in the alternatives code.
> 
> To work around this remove this code, and enforce that users of
> alternatives must specify original and alternative instruction sequences
> which have identical sizes. Add a compile time check with two ".org"
> statements similar to arm64.
> 
> In result not only clang can handle this, but also quite a lot of code can
> be removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/alternative-asm.h | 76 +++-----------------
>  arch/s390/include/asm/alternative.h     | 93 ++++++-------------------
>  arch/s390/kernel/alternative.c          | 61 +---------------
>  3 files changed, 31 insertions(+), 199 deletions(-)

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
