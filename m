Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7B3571906
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiGLLwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiGLLwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:52:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A9FB521C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:51:55 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CAhGsZ002251;
        Tue, 12 Jul 2022 11:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PM8YxtnQW4urLNhu7YRwUGznmdD080iWzOsO7fJQHx4=;
 b=AwFFlIDLG06YNqJp7wQ4A/biembLFgabyhDTH18bNh2Hc0h+tzI+8k8fN4dMVU4rs5Wv
 JtiSAa94xI8e4X1Ah9TPaE9S/l5VkFqZVjpmEFFoIq5lpWBJh69ioBta0lU+6dxCjbUG
 Z/AekU5yFoj1+x7dgj1rjLnlxWFZ8QtCbNCM5CZHl4p31weJ9459kGnw/s1pjuteeFqM
 vhttkqCGpN+gxvs6+Z1ApEhOqKsEaPkMU42ZaYqQioUFUNX0tpxCbvpbjilsYI8KBIgu
 OPxaRUysjesn81iKxyE8MRP4GWMEmC5TJFUJCqSANlFSpKMJjxE+kYRoZkakmvOMJ1ZW BA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h97erhsg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:51:46 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CBpINw000510;
        Tue, 12 Jul 2022 11:51:45 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3h71a8kcyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:51:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CBpgi925297248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 11:51:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 569AFA405C;
        Tue, 12 Jul 2022 11:51:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38C56A4054;
        Tue, 12 Jul 2022 11:51:40 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.47.210])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Jul 2022 11:51:40 +0000 (GMT)
Date:   Tue, 12 Jul 2022 13:51:37 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Fix mas_empty_area_rev() search exhaustion
 at root node
Message-ID: <Ys1gSRC3kTQQZ0Fr@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220712014957.4064879-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712014957.4064879-1-Liam.Howlett@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vi4hISKwgqvCy_ExUULpejYe0BtN_1R2
X-Proofpoint-ORIG-GUID: Vi4hISKwgqvCy_ExUULpejYe0BtN_1R2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 01:50:36AM +0000, Liam Howlett wrote:
> When the possibilities of finding a gap are exhausted at the root node,
> the error code was not returned which results in returning a range that
> is currently occupied.  Add the necessary check for the error code and
> return to the caller.
> 
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Fixes: d0aac5e48048 (Maple Tree: add new data structure)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  lib/maple_tree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 9dc4ffff18d0..14e9ab14c1da 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5287,6 +5287,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>  		}
>  	}
>  
> +	if (mas_is_err(mas))
> +		return xa_err(mas->node);
> +
>  	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
>  		return -EBUSY;

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!
