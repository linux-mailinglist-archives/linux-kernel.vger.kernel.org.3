Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A798657A592
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbiGSRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiGSRle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:41:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DD21929A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:41:34 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JHL3sE037471;
        Tue, 19 Jul 2022 17:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=I+EnxDpbKDgUP9CK0hvKo2Z36XDGJ3qr3sTbOeD878Q=;
 b=GdkJ50f0VxzGlW6SPr1UR/vX7gYgh7cJGkXqUzebV3FYzMq55/BKc+lFIgK/ukdpagDW
 IpsygQaKDkSe+WMgWJGgqdDr+MUPalDqM6zElRI1dLF9QoN+EBRgUlpe8kD4aFrnVc3m
 cUD3nlC16OfbZ5sPPAAI3IVTTkGf0C7Ue18L27rdWW+1uExgwqZWHGSXZwojcY3lJbLS
 0Ky37s80rqz8s5yk1BRlycW1sqCC2jsDNHcXB0kBQU1mDti0WX9QTX8+ltpCyR1Bgm8a
 3IHVuEjkHG1oi9ZiVnOHNB+mWiHGbFgcnC543fKTatV0yKS4NPKPfj+G7fBS4/nxeDXn Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he0xf8ug8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 17:41:25 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26JHL42a037494;
        Tue, 19 Jul 2022 17:40:31 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he0xf8qwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 17:40:30 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26JHcx8q001373;
        Tue, 19 Jul 2022 17:39:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3hbmy8vebg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 17:39:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26JHdfnJ23593406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:39:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B373AE055;
        Tue, 19 Jul 2022 17:39:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57E27AE053;
        Tue, 19 Jul 2022 17:39:41 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Jul 2022 17:39:41 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] maple_tree: Fix mas_empty_area() wrapping
References: <20220719170118.3296447-1-Liam.Howlett@oracle.com>
Date:   Tue, 19 Jul 2022 19:39:41 +0200
In-Reply-To: <20220719170118.3296447-1-Liam.Howlett@oracle.com> (Liam
        Howlett's message of "Tue, 19 Jul 2022 17:01:30 +0000")
Message-ID: <yt9dtu7dhuhu.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6szJFc1eY-Op8X9Q23JGefi_MkiVXlGF
X-Proofpoint-GUID: Lxh-I1gHtH4EF0kob8tkaIm8xwvG9E4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Howlett <liam.howlett@oracle.com> writes:

> Set the error code correctly when at the left most node and search has
> been exhausted.  This was an overflow bug.
>
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

That fixes it, thanks!

Tested-by: Sven Schnelle <svens@linux.ibm.com>

> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 1b8130f19c2e..0c0bda979693 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4994,7 +4994,7 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
>  		}
>  next_slot:
>  		min = pivot + 1;
> -		if (mas->last < min) {
> +		if (mas->last <= pivot) {
>  			mas_set_err(mas, -EBUSY);
>  			return true;
>  		}
