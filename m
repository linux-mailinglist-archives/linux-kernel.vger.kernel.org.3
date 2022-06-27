Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588FD55DB82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiF0QSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiF0QSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:18:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE661025;
        Mon, 27 Jun 2022 09:18:18 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RFsbDN006833;
        Mon, 27 Jun 2022 16:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MJ7JgmQeaf0NWBCP66YkXoDpeI0ijF+m62QKhIfAnHg=;
 b=fYub/yOjaDQ9Ty7yCt9mpagft9iEo/e46t0vXUNcMIjGB8d4jZNS9KM4VkHFHNtpL6Aq
 o/sMZByD7nEleS2iLYPaUIGBDi7zEwytVFasDI79SXskWYpif6xVR18ucvVrOfw/ECp5
 846AjzAyASyle6cyBo9Zp1qhO34pm5KeKKbRIH/ZLAMO2TZ3mGveCNK962paPlg4Bzxj
 Yiw25SvA7AaaOQKnUAQ8o9v8ZBVENf2M7P0FLN1xWJ2qhDq8WYptBHUj/h8s1RTCX9c4
 iPDL3Ev+zdpJ+XmCFXcCT8TKgEyyCjqF0OthjC+C4PXywjBIzDM46fIVaAW/MzFkJGzf BA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gyfkwrwea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 16:18:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25RG4sxS007197;
        Mon, 27 Jun 2022 16:18:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj37va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 16:18:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25RGI8kp24576468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 16:18:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F95AE04D;
        Mon, 27 Jun 2022 16:18:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FEF5AE045;
        Mon, 27 Jun 2022 16:18:08 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.152.212.237])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Jun 2022 16:18:08 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.94.2)
        (envelope-from <bblock@linux.ibm.com>)
        id 1o5rRC-001mmC-Sr; Mon, 27 Jun 2022 18:18:10 +0200
Date:   Mon, 27 Jun 2022 16:18:10 +0000
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Zhang Jiaming <jiaming@nfschina.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
Subject: Re: [PATCH] s390/qdio: Fix spelling mistake
Message-ID: <YrnYQtO2Zuae06OP@t480-pf1aa2c2.fritz.box>
References: <20220623060543.12870-1-jiaming@nfschina.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220623060543.12870-1-jiaming@nfschina.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jiDO5YKv2NP7h6Q00vVXyYx8iGfEH9Yq
X-Proofpoint-GUID: jiDO5YKv2NP7h6Q00vVXyYx8iGfEH9Yq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:05:43PM +0800, Zhang Jiaming wrote:
> Change 'defineable' to 'definable'.
> Change 'paramater' to 'parameter'.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  arch/s390/include/asm/qdio.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/qdio.h b/arch/s390/include/asm/qdio.h
> index 54ae2dc65e3b..2f983e0b95e0 100644
> --- a/arch/s390/include/asm/qdio.h
> +++ b/arch/s390/include/asm/qdio.h
> @@ -133,9 +133,9 @@ struct slibe {
>   * @sb_count: number of storage blocks
>   * @sba: storage block element addresses
>   * @dcount: size of storage block elements
> - * @user0: user defineable value
> - * @res4: reserved paramater
> - * @user1: user defineable value
> + * @user0: user definable value
> + * @res4: reserved parameter
> + * @user1: user definable value

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

Heiko, Alexander, can you queue this please? Don't think we need any
more reviews here.

>   */
>  struct qaob {
>  	u64 res0[6];
> -- 
> 2.25.1
> 

-- 
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Systems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/privacy
Vorsitz. AufsR.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294
