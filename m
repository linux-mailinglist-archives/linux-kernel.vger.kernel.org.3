Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B452574472
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiGNFWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGNFWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:22:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CC71EED4;
        Wed, 13 Jul 2022 22:22:12 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E4vwAZ032275;
        Thu, 14 Jul 2022 05:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NkP6/TaGwATjr+2vsaWbX9IwYyVELWKQtaZF3PZCS6A=;
 b=FqWw7hZMXiZm9uiOCVC9Liyg9nArnsd7wvZtLV/5UWbDgUHtNfq4h9cksdHJXkZzNUGa
 wdsdACv0NKLkb4bcoB7xTea4InD1gwqx9pwOCfBwOsdwIAZpLZbOT5B4Fw4MIbEpMmEM
 3iKJr4LkOuGYSHMCauRM6pDeEABWRzyK1cmO3IqlUK4aYc2858pnFxMPAegKPsrBGzLY
 lKWTdp7uflEUPC6gZhFVboaGfMyN0vimqftBSZeV4aViBz2H6ctWNwWexOwcEF66AEbs
 pJv2sQZikaLQvdNEFjRriq9nnQeSos26qvN6+fbbmFp0xOUFtzR2tD1lOBA3O+s3g12+ Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hack20jb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 05:22:12 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26E559IH026392;
        Thu, 14 Jul 2022 05:22:11 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hack20jan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 05:22:11 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26E5KlmS012809;
        Thu, 14 Jul 2022 05:22:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3ha19s0g7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 05:22:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26E5M5Hv8323488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 05:22:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D170BA4054;
        Thu, 14 Jul 2022 05:22:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54242A405B;
        Thu, 14 Jul 2022 05:22:05 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.47.210])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Jul 2022 05:22:05 +0000 (GMT)
Date:   Thu, 14 Jul 2022 07:22:03 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/pci: Use the bitmap API to allocate bitmaps
Message-ID: <Ys+n+wU8GyQzR+xk@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <8d35e482f710889a45d46f808155738ef87d46c4.1657383052.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d35e482f710889a45d46f808155738ef87d46c4.1657383052.git.christophe.jaillet@wanadoo.fr>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OQJiWbFacoPO-GpP64fN_84b3r11AaBn
X-Proofpoint-GUID: 1xcfCk05vUKkzVngbdQN__0jLnYlpDrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_02,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1011 mlxscore=0 spamscore=0
 mlxlogscore=806 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207140022
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 06:11:28PM +0200, Christophe JAILLET wrote:
> I don't know why commit c506fff3d3a8 ("s390/pci: resize iomap") has turned
> this bitmap from a statically defined bitmap to a runtime-allocated one.

c506fff3d3a8 commit message:

    This reduces the size of the iomap from 256K to less than 4K
    (using the defconfig).
