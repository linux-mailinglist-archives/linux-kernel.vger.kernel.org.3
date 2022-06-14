Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3554AE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbiFNKNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiFNKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:13:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439F23DDE7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:13:17 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E9r3Pt001868;
        Tue, 14 Jun 2022 10:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=r4ovlHpgokjajuVjg0b4TmtD/s1dqH+HimeeeMcuaJI=;
 b=X+c+EcjObBA/becTecgp6uety8MP1LpiOigDQ7Qmq8xIawFx3Bcq51KaI8ZPJPeEUqBd
 McTgpTglRxckaAdsUL3vaMSrrRDQPeEYTnEfLYKX6V141+df0IcMiBBQdFFW+K7sTkUD
 Az8EMHlteYyC0P7BHFnal5rCq+mSrgYHsStfqEZ8sCdAbpoHUvNEN51IqDxipQXy59Pu
 tbw9x5oRPUgsDs5hTGMquao+N1U4U5QBBnHlj6NFFEgA04Gqgk6XaMF7chkkp4gWQgp7
 0KLfm4SBb2PZQQZRgMO3IGB5WYq/PK/0KR+FFloUuXWdfzJJwSbQc7sLn4p91t96JzNo nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpr3f0f1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 10:13:05 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25EA7BbL019154;
        Tue, 14 Jun 2022 10:13:05 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpr3f0f12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 10:13:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25EA6c9i024881;
        Tue, 14 Jun 2022 10:13:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3gmjp9c67w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 10:13:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25EAD0gX19202458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 10:13:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E087842049;
        Tue, 14 Jun 2022 10:13:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B20942042;
        Tue, 14 Jun 2022 10:13:00 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jun 2022 10:13:00 +0000 (GMT)
Received: from [9.43.232.226] (unknown [9.43.232.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C757E600B4;
        Tue, 14 Jun 2022 20:12:53 +1000 (AEST)
Message-ID: <269ecf828ebaa4212a5be6310619aba6d8cfe41d.camel@linux.ibm.com>
Subject: Re: [PATCH] cxl: Fix refcount leak in cxl_calc_capp_routing
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Lombard <clombard@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jun 2022 20:12:48 +1000
In-Reply-To: <20220605060038.62217-1-linmq006@gmail.com>
References: <20220605060038.62217-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fwTu15Na8Suf3BZQk5RnP5sMvIgpE5_F
X-Proofpoint-GUID: 5itWkOXL3wwUOFWlG2l8XAMaXCELVMMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_02,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-05 at 10:00 +0400, Miaoqian Lin wrote:
> of_get_next_parent() returns a node pointer with refcount
> incremented,
> we should use of_node_put() on it when not need anymore.
> This function only calls of_node_put() in normal path,
> missing it in the error path.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: f24be42aab37 ("cxl: Add psl9 specific code")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks!

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
>  drivers/misc/cxl/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 3de0aea62ade..62385a529d86 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -387,6 +387,7 @@ int cxl_calc_capp_routing(struct pci_dev *dev,
> u64 *chipid,
>         rc = get_phb_index(np, phb_index);
>         if (rc) {
>                 pr_err("cxl: invalid phb index\n");
> +               of_node_put(np);
>                 return rc;
>         }
>  


