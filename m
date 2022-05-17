Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3BE52A6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349855AbiEQPgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350280AbiEQPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:35:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4185005B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:35:20 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HFGYnk032564;
        Tue, 17 May 2022 15:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=ZEvjJejiz2ASi5QVdyD0zjeKQVsGiVKnV7cFfqntoFc=;
 b=Znivp8sjP5eVxgYkFQUEP2EgYrAFVkTOlTIAtj9Iwvcjx5KXUwXkgbrizunuRqEXj7kS
 5rCjHgvgbwL7rM7ZX0TSwIWRanrnySCUfrCdatHuoWCS+Y2HcItTxMoDOb+0Zfc7SiyB
 DZTOYlRL3TgFTtzbt2W7OO9Tyb96kGGYXVYTHtY3Cea2GO+9AgIDWdG2Wc6KlCUKumtz
 42qrnCha2XhD2fOx9BG3RhPz6V/Uj21eFTCS4T/eiE0kRO8fK360u+4lxp3tEP4GOa95
 xxcJ4u7uE9T7/3h10Xio6cVI/zRQ1Z+fv30qdy07xlUxPMUrW1SvFEmjB+F6cUYhZplM cQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4dv7h8yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 15:35:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HFRu9o031127;
        Tue, 17 May 2022 15:35:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjcekh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 15:35:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HFYx6L54984974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 15:34:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DB0DAE051;
        Tue, 17 May 2022 15:34:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E2C7AE045;
        Tue, 17 May 2022 15:34:59 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 17 May 2022 15:34:59 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Fix mas_next() when already on the last
 node entry
References: <20220517145913.3480729-1-Liam.Howlett@oracle.com>
Date:   Tue, 17 May 2022 17:34:58 +0200
In-Reply-To: <20220517145913.3480729-1-Liam.Howlett@oracle.com> (Liam
        Howlett's message of "Tue, 17 May 2022 14:59:22 +0000")
Message-ID: <yt9dee0s41gd.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lCWJGAHmWlx5L8whc4bPSmCTS75gflvh
X-Proofpoint-ORIG-GUID: lCWJGAHmWlx5L8whc4bPSmCTS75gflvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 clxscore=1011 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Howlett <liam.howlett@oracle.com> writes:

> It is possible to return the metadata as the next entry if the last node
> entry is already in the maple state and the limit is not reached.  Check
> for this condition in mas_next_nentry() where the node end is returned.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks, that matches my observation from the initial report that we're
returing metadata. I just applied the patch to next-20220516 and i'm no
longer able to trigger the crash. So feel free to add my:

Tested-by: Sven Schnelle <svens@linux.ibm.com>

However, as Heiko already wrote in another mail i would also like to
request that the maple tree code isn't merged with the next merge
window. These patches touch a lot of critical infrastructure, and i would like
to have it in next for at least one development cycle, so we can be sure
that we've seen and fixed most of the issues.

Thanks,
Sven
> ---
>  lib/maple_tree.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 967631055210..751aafd01c42 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4547,6 +4547,9 @@ static inline void *mas_next_nentry(struct ma_state *mas,
>  		return NULL;
>  
>  	count = ma_data_end(node, type, pivots, mas->max);
> +	if (mas->offset > count)
> +		return NULL;
> +
>  	while (mas->offset < count) {
>  		pivot = pivots[mas->offset];
>  		entry = mas_slot(mas, slots, mas->offset);
