Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91B3554BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357357AbiFVNtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245383AbiFVNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:49:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86B2DF4;
        Wed, 22 Jun 2022 06:49:04 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MDArmE024447;
        Wed, 22 Jun 2022 13:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yqoJqnd9xUomrOebKVypCVBPsGWc5ALg73aN0cSqt4s=;
 b=IU7kiSOkqGxcnlfPcPeiuN+q3LiZX8MYuvUIbyb4/ONq+V2lj2qTKJM56W6CdxvD6g79
 wGI6pjpFdZlyxNkIklIIF+/nwFsyVqB/2LTtPb5fEZi2LkoU0jRjrTUGDv+gJYOJxD+H
 8zfE9JbBicpLAX+m3w8oB1nuUwxDfxox+3tYzoldsr3o7Be5sioWT6LGyQQ3BNW0aGRs
 lmdax/NoyK8Mtm/9wBZhrv+WS8R/RJ3k7u+Mm218qdLI/vvOsaag5UMzPTwXxisAiLX8
 33xEAF4iqd0xveznR+mfrr7PBSNeFmLv88mchVHmZb07GK7cfX5nhgD757/iZg/bD/GW Dw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv30rjk2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 13:48:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MDZZdZ016870;
        Wed, 22 Jun 2022 13:48:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3gs6b8wqn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 13:48:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MDmp5J23396686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 13:48:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61E7211C050;
        Wed, 22 Jun 2022 13:48:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD9E811C04A;
        Wed, 22 Jun 2022 13:48:50 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.144.178])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Jun 2022 13:48:50 +0000 (GMT)
Date:   Wed, 22 Jun 2022 15:48:49 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] s390/purgatory: remove duplicated build rule of
 kexec-purgatory.o
Message-ID: <YrMdwXwHE0qLRZLC@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220613170902.1775211-1-masahiroy@kernel.org>
 <20220613170902.1775211-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613170902.1775211-3-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9COnH_cmQ2jsqsy_JhWizitY4xL8iNbE
X-Proofpoint-GUID: 9COnH_cmQ2jsqsy_JhWizitY4xL8iNbE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=884
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 02:09:02AM +0900, Masahiro Yamada wrote:
> This is equivalent to the pattern rule in scripts/Makefile.build.
> 
> Having the dependency on $(obj)/purgatory.ro is enough.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/purgatory/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index 3e2c17ba04de..d237bc6841cb 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -48,7 +48,6 @@ OBJCOPYFLAGS_purgatory.ro += --remove-section='.note.*'
>  $(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
>  		$(call if_changed,objcopy)
>  
> -$(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
> -	$(call if_changed_rule,as_o_S)
> +$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro
>  
>  obj-y += kexec-purgatory.o

Applied, thanks!

> -- 
> 2.32.0
> 
