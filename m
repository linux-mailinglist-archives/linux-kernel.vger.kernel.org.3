Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33FA525599
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358023AbiELTQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357993AbiELTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:16:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2603473B8;
        Thu, 12 May 2022 12:16:35 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CJDFc8004218;
        Thu, 12 May 2022 19:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1CsN5ivk3D2z8QbP7u8AezAtPxEkf8owO72EbSkHfTY=;
 b=nvmWl+t9m+SmPEuC0nN96gOPIWC5EMidPLSBlGo2UYBSvenpRoy/GqGSAz5zHvI3oPIL
 VBw/Gpeni1MWltWW8f0v98Ei/qECrE/ZIhltTzR7/y6j9NwvU+bFcuNA0XqwC1FTF4I2
 Cf2LJJjfKo7TfQtVhb4LMAxc5YCzE19BWhpXPVU+fbaQmkujl7dWna+2LoDq74rsGH9v
 Zjet7t3xfj95RRpzV2rzR8oviADqgjFEmIGK3rsJ8YrDwosi/92EAg64f+aYRjPSxorU
 RtgTeh90oWhzvuMw6LNR1UdcP+KY2Qq+SazKZzKFRgzqzy+i1XwzafheWoPTYGwOzUuX bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g186w01pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:16:32 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CJGWEF021122;
        Thu, 12 May 2022 19:16:32 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g186w01p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:16:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CIvs1M009635;
        Thu, 12 May 2022 19:16:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3g0ma1h6d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:16:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CJGQwG48366018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 19:16:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0EA74C040;
        Thu, 12 May 2022 19:16:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C1A84C044;
        Thu, 12 May 2022 19:16:25 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 May 2022 19:16:25 +0000 (GMT)
Date:   Thu, 12 May 2022 21:16:24 +0200
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
Subject: Re: [PATCH 4/8] s390/entry: workaround llvm's IAS limitations
Message-ID: <Yn1dCMwbtgujD/in@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-5-hca@linux.ibm.com>
 <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X>
 <Yn1CyTcrZk1Kgvoq@osiris>
 <Yn1a01xhijM5MH1o@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn1a01xhijM5MH1o@dev-arch.thelio-3990X>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G49Nm5BRHv8hd9WeydFxCdflDYgLhb9H
X-Proofpoint-GUID: pWw6xIi0_NXjY_7y2CBK4pHcO-XjLHkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_16,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=734 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:06:59PM -0700, Nathan Chancellor wrote:
> > +#ifdef CONFIG_AS_IS_LLVM
> > +	clgfrl	%r14,.Lrange_size\@
> > +#else
> > +	clgfi	%r14,\end - \start
> > +#endif
> >  	jhe	\outside_label
> > +#ifdef CONFIG_CC_IS_CLANG
> 
> I think this one also wants to be CONFIG_AS_IS_LLVM, right?

Yes, of course.

> Other than that, seems fine to me, although I have no knowledge of s390
> assembly so that statement probably means next to nothing :)

Thanks for having a look! :)
