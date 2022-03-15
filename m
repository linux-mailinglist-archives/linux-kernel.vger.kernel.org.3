Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409414D9766
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbiCOJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiCOJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:17:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165DC4E396;
        Tue, 15 Mar 2022 02:16:02 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F8b9Kq020661;
        Tue, 15 Mar 2022 09:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CUQJIGhA6jTCd3463PpT2X++aO6WPZ0JbiIs1TWx4ms=;
 b=mkM6Dym40IUtJZfxk10lacp8UPkCCsZ18JhYsWjGhq+ehC33gLNEAqjfgDNnf4gEIt3m
 jWWPugcYXmRsiU2rk9DNWrkwplrMNFU87ThtojjLOa2LRkPpE8BgUa4fbQ5WkFyeKmT+
 +HydXab4GtCJRwVtCBY4sYi6+ENCjinfSl+1TW6+6zn2/zJeOzmPA6EO8gieJp6zKg94
 ofyYxXHk/3D1YD9XDnx7/Y31q2Boqk3qc6xWrmeElJi0DnDGir628xgOrAbKIehYFt9C
 ZADjJYljAgBKf/9GwulFipby7QN3jhy2Dwpgcqx13MqMaUSPviblDzp9Y+dhUNy5wlXd jA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3etmvfbncd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 09:15:58 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22F97NDY028741;
        Tue, 15 Mar 2022 09:15:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3erk58x5a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 09:15:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22F9Frq840698328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 09:15:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F27911C052;
        Tue, 15 Mar 2022 09:15:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBD4611C050;
        Tue, 15 Mar 2022 09:15:52 +0000 (GMT)
Received: from osiris (unknown [9.145.19.59])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Mar 2022 09:15:52 +0000 (GMT)
Date:   Tue, 15 Mar 2022 10:15:51 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     freude@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390: crypto: Use min() instead of doing it manually
Message-ID: <YjBZR6WoHYj6fvzm@osiris>
References: <1647331264-13853-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647331264-13853-1-git-send-email-baihaowen@meizu.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WXtEqCEocwJY-LL0wEXdsyqrvIEngjTd
X-Proofpoint-ORIG-GUID: WXtEqCEocwJY-LL0wEXdsyqrvIEngjTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_14,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=903 bulkscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:01:04PM +0800, Haowen Bai wrote:
> Fix following coccicheck warning:
> drivers/s390/crypto/zcrypt_ep11misc.c:1112:25-26: WARNING opportunity for min()
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index 9ce5a71..bb2a527 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> @@ -1109,7 +1109,7 @@ static int ep11_wrapkey(u16 card, u16 domain,
>  	if (kb->head.type == TOKTYPE_NON_CCA &&
>  	    kb->head.version == TOKVER_EP11_AES) {
>  		has_header = true;
> -		keysize = kb->head.len < keysize ? kb->head.len : keysize;
> +		keysize = min((size_t)kb->head.len, keysize);

I would assume that checkpatch will now warn that this is an
opportunity to use min_t()...
Anyway, it is up to Harald to decide what do with this.
