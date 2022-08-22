Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E259BEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiHVLv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiHVLuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:50:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5556AC37;
        Mon, 22 Aug 2022 04:50:06 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MBgJrd025518;
        Mon, 22 Aug 2022 11:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=EJtCA0irv05cuYA2BS3dRUiVscSRxR9tDrHKcT5vAHc=;
 b=jKpepvc/2u/8wwwhO8TUOj4e3V5VkmMo00LPKz5g5zYc3zp4ycUjCmBjQcxWRurotVzn
 YdJCUaU9V/OcflBQ2jpjD5QCwZayOGbaFtlsxndG4mf/dc6Tbckimfu9O7NCCNhQAtxz
 UeU5OmaRbUyImHmFPNlv2XlmrqnTFOZqIs/wWiNI4eW5H5NOh+jnVjuUCqXPnypNZLID
 a6Mfw8ZDibQVb915MLcbjvQKy6OdsaGKQ38CeaDjNp3eq3pc9hijdgSlU6DSx4t/8kMX
 RzxIQNoPGv9TqoGK1XaeC66eI3zC7mlZWeq6ztLr2bv8kJqrOJlfipn/ZgFjRvTjgv0q wA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j495eg5s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 11:50:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27MBR6JJ032246;
        Mon, 22 Aug 2022 11:50:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3j2pvj2csd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 11:50:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27MBnv3K31195550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 11:49:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 689B14C04E;
        Mon, 22 Aug 2022 11:49:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7AF84C040;
        Mon, 22 Aug 2022 11:49:56 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.17.18])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 22 Aug 2022 11:49:56 +0000 (GMT)
Date:   Mon, 22 Aug 2022 13:49:55 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: move from strlcpy with unused retval to strscpy
Message-ID: <YwNtYw3zwGTGvMlO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220818205948.6360-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818205948.6360-1-wsa+renesas@sang-engineering.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vAnC3OTU5hHN-HF0xfwHZa59Tug0Kc7t
X-Proofpoint-ORIG-GUID: vAnC3OTU5hHN-HF0xfwHZa59Tug0Kc7t
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_06,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:59:47PM +0200, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/s390/kernel/debug.c | 2 +-
>  arch/s390/kernel/early.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
> index 4331c7e6e1c0..d7a82066a638 100644
> --- a/arch/s390/kernel/debug.c
> +++ b/arch/s390/kernel/debug.c
> @@ -250,7 +250,7 @@ static debug_info_t *debug_info_alloc(const char *name, int pages_per_area,
>  	rc->level	   = level;
>  	rc->buf_size	   = buf_size;
>  	rc->entry_size	   = sizeof(debug_entry_t) + buf_size;
> -	strlcpy(rc->name, name, sizeof(rc->name));
> +	strscpy(rc->name, name, sizeof(rc->name));
>  	memset(rc->views, 0, DEBUG_MAX_VIEWS * sizeof(struct debug_view *));
>  	memset(rc->debugfs_entries, 0, DEBUG_MAX_VIEWS * sizeof(struct dentry *));
>  	refcount_set(&(rc->ref_count), 0);
> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> index 432c8c987256..6030fdd6997b 100644
> --- a/arch/s390/kernel/early.c
> +++ b/arch/s390/kernel/early.c
> @@ -267,7 +267,7 @@ char __bootdata(early_command_line)[COMMAND_LINE_SIZE];
>  static void __init setup_boot_command_line(void)
>  {
>  	/* copy arch command line */
> -	strlcpy(boot_command_line, early_command_line, COMMAND_LINE_SIZE);
> +	strscpy(boot_command_line, early_command_line, COMMAND_LINE_SIZE);
>  }
>  
>  static void __init check_image_bootable(void)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
