Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C6757214B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiGLQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiGLQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:46:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFECC1177;
        Tue, 12 Jul 2022 09:46:31 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CGBV6S022585;
        Tue, 12 Jul 2022 16:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KPdO1hA9KLf7StAGWaBc5InbpwBKeKY4LPAGtGIxEAo=;
 b=QiJJaIQDrJrvol+WCR8O/g/mjZiKfP0yKOGObsLeJBF1Gj+PDKi0tOdzVN9S02FZiAF4
 9XqUrmM0UuFAim5T+wBGH8Xc3KxeIj5q8AtRw5164RVm7pBYy87R5wD2dPTOZNi3XTei
 KUKAk7U7itv82RQrwUd7Sz/+/Ab+RwdYuclZM0LFXXY4jMfXoyx3sYgzMDc0KWMhadrW
 9bsQICQzIkQ6jOFqrfdKRTV3UtqPWJSVR1HPOQhC8GFOsTAVd8PVwVlzGphknNtcx5Z7
 De+aiJeNdu7AJoRUkDNoZSYqqvSE9lPTUDpwdTuuJn5IkjWdwM8QYaKpapX7q63tu7T5 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9974xqpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:46:23 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26CGF7oi010647;
        Tue, 12 Jul 2022 16:46:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9974xqp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:46:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CGK0M5001145;
        Tue, 12 Jul 2022 16:46:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a8vewa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:46:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CGkSqS31261090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 16:46:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79A08A4059;
        Tue, 12 Jul 2022 16:46:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 227B3A4051;
        Tue, 12 Jul 2022 16:46:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 16:46:18 +0000 (GMT)
Received: from [9.43.200.237] (unknown [9.43.200.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 184D160307;
        Wed, 13 Jul 2022 02:46:12 +1000 (AEST)
Message-ID: <6883e31c38d42e23f7205b752a62788ca7d128d4.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] cxl: Fix a memory leak in an error handling path
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 13 Jul 2022 02:46:10 +1000
In-Reply-To: <ce5869418f5838187946eb6b11a52715a93ece3d.1657566849.git.christophe.jaillet@wanadoo.fr>
References: <59010cc7c62443030c69cb1ce0b2b62c5d47e064.1657566849.git.christophe.jaillet@wanadoo.fr>
         <ce5869418f5838187946eb6b11a52715a93ece3d.1657566849.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c_cWPawDFiOFIOcrLqXuC0bL4IhBKcj_
X-Proofpoint-ORIG-GUID: EDJ6PrgzeVnxGnjfGFEtmgJFC2Pcx7Ch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_10,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-11 at 21:14 +0200, Christophe JAILLET wrote:
> A bitmap_zalloc() must be balanced by a corresponding bitmap_free()
> in the
> error handling path of afu_allocate_irqs().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks for catching this.

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> The error handling path should be done in the reversed order but it
> should
> work as-is.
> ---
>  drivers/misc/cxl/irq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index 0ce91d99aead..b730e022a48e 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -349,6 +349,7 @@ int afu_allocate_irqs(struct cxl_context *ctx,
> u32 count)
>  
>  out:
>         cxl_ops->release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
> +       bitmap_free(ctx->irq_bitmap);
>         afu_irq_name_free(ctx);
>         return -ENOMEM;
>  }


