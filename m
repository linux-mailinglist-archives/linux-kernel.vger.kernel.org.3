Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBAE528675
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbiEPOGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbiEPOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:06:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE61005;
        Mon, 16 May 2022 07:06:04 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GE1DMa026110;
        Mon, 16 May 2022 14:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=W803J69EJm++pLOaEqlDhxYyTXafFWrijwjpdrcMKo8=;
 b=iKaLOhN1dTu6t59/hv8zv1ruxO4uf4ukHP/NDSO5TfyO5hmLz4IKwH8J1Zuako7YWwnb
 elySCI1bGLKuMxsquP/jwwmZzFuHdCVdE/nqJ1+dju+IDoB0RMxq7sxvcBREgnrUjDDu
 KGG2LoWYryn82T5GhD9GHR1H9PjrEFHMF/3U3HYJ0T6ck+Cac4CHQZkDXMH4DIcv289R
 PCBpXhws16uXoHDt+5mddrmgS79rQ32/hdM5R8HdD5SpxFViydAGTb7gmrKQRR3SbcOh
 HFI/FunlKXd9B1eF20fwD7grHTVsJ7IpETpP1VsMEIYnQpjAjriy7Nr8GqBCbtMNZqVL hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3r0rr49n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 14:05:54 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24GE2BLe029905;
        Mon, 16 May 2022 14:05:54 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3r0rr495-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 14:05:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GE5WM2006927;
        Mon, 16 May 2022 14:05:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429asxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 14:05:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GE5l8H53739802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 14:05:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CEA84203F;
        Mon, 16 May 2022 14:05:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B6E142041;
        Mon, 16 May 2022 14:05:47 +0000 (GMT)
Received: from osiris (unknown [9.145.19.162])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 May 2022 14:05:46 +0000 (GMT)
Date:   Mon, 16 May 2022 16:05:45 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
Message-ID: <YoJaOYv5gTl/oByX@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-5-hca@linux.ibm.com>
 <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X>
 <Yn1CyTcrZk1Kgvoq@osiris>
 <YoIUX864ULCwu4pz@tuxmaker.boeblingen.de.ibm.com>
 <YoIlQaWNy1wu39ak@osiris>
 <YoIxdMNJjt9rxoeZ@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoIxdMNJjt9rxoeZ@tuxmaker.boeblingen.de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zpQWR8E7h5U77uCLMRiqi3KxRiwx8tfv
X-Proofpoint-GUID: H96rlpMFX1dp-jNvtaIBkRT8NdEChY8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_13,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=685
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205160079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 01:11:48PM +0200, Alexander Gordeev wrote:
> > So I'd suggest: leave this code as is, and at some later point move
> > "rework" the early machine check handler code.
> > 
> > What do you think?
> 
> Sounds very reasonable. Please, find my:
> 
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

> Also, how such a follow-up looks to you?
...
> 	slgfi	%r14,\start
> 	clgfi	%r14,\end - \start

I think using an address as an immediate value is a step in the wrong
direction, since I'd like to have all code pc-relative. And as far as
I can tell this new construct would only work as long as \start has an
absolute address that is low enough so that it would work / fit with
slgfi.
Of course this will likely always be the case, but I still think this
is not the way we should go.
