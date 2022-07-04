Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DADD564CA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiGDE2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDE2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:28:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC01B38B9;
        Sun,  3 Jul 2022 21:28:39 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2643jHaL012941;
        Mon, 4 Jul 2022 04:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VMtwyktu+dJ4wzEnFU0hwQW3sEjaFjy4E0H7JQ9GIRE=;
 b=k4IDoj46aQAEJAJZRUqLNTIW+8j/+yHieq96vrozq+I2bci6oBgfp7O5Z62SvMLfsWxu
 Ypwjk9Uvdy0SzRIz3ESdDU7Aj01LBMV6kBlwOZVjFDZG8l1/EjTLJPveZwXbdsfdDGh/
 bq/hY1iwNAeHeg1NitHtFWuleUPUZKS8LD6IjxpOzl5TJxSpibqG+0X8+ORdzFoPoSP5
 TjlovfGhl/hxNCdicYMf4WfdQmpVmjwsrL2UXCNWtMc5763c4hfeM+3ztkfYETH9dRS0
 bb5DXJn+LxHPnoa716MRcpmg2Vp6gARE7juZY4vl7Ow2nQt0wiJeGqztDqrSkhN96oqv Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3rk1gn7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 04:28:30 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2644PL7g024924;
        Mon, 4 Jul 2022 04:28:30 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3rk1gn7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 04:28:30 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2644LRBF003174;
        Mon, 4 Jul 2022 04:28:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3h2dn924a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 04:28:27 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2644SOPL10092988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 04:28:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 897875204F;
        Mon,  4 Jul 2022 04:28:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 7680C5204E;
        Mon,  4 Jul 2022 04:28:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55398)
        id 30422E022D; Mon,  4 Jul 2022 06:28:24 +0200 (CEST)
Date:   Mon, 4 Jul 2022 06:28:24 +0200
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        oberpar@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, almaz.alexandrovich@paragon-software.com,
        yury.norov@gmail.com, linux@rasmusvillemoes.dk,
        linux-s390@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/4] s390/cio: Rename bitmap_size() as idset_bitmap_size()
Message-ID: <YsJsaLy5PDzMOvTo@tuxmaker.boeblingen.de.ibm.com>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <3f2ad7fb91948525f6c52e0d36ec223cd3049c88.1656785856.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2ad7fb91948525f6c52e0d36ec223cd3049c88.1656785856.git.christophe.jaillet@wanadoo.fr>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eAg0oUXfuRnB6456bOXSml23Gr8U_wzs
X-Proofpoint-GUID: qjZ0nfzdInS6KSnT9L43sDps6GYuPudN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_03,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=717 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040016
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 08:29:09PM +0200, Christophe JAILLET wrote:
> In order to introduce a bitmap_size() function in the bitmap API, we have
> to rename functions with a similar name.
> 
> Add a "idset_" prefix and change bitmap_size() into idset_bitmap_size().
> 
> No functional change.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/s390/cio/idset.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
> index 45f9c0736be4..e1e77fe080bf 100644
> --- a/drivers/s390/cio/idset.c
> +++ b/drivers/s390/cio/idset.c
> @@ -16,7 +16,7 @@ struct idset {
>  	unsigned long bitmap[];
>  };
>  
> -static inline unsigned long bitmap_size(int num_ssid, int num_id)
> +static inline unsigned long idset_bitmap_size(int num_ssid, int num_id)
>  {
>  	return BITS_TO_LONGS(num_ssid * num_id) * sizeof(unsigned long);
>  }
> @@ -25,11 +25,11 @@ static struct idset *idset_new(int num_ssid, int num_id)
>  {
>  	struct idset *set;
>  
> -	set = vmalloc(sizeof(struct idset) + bitmap_size(num_ssid, num_id));
> +	set = vmalloc(sizeof(struct idset) + idset_bitmap_size(num_ssid, num_id));
>  	if (set) {
>  		set->num_ssid = num_ssid;
>  		set->num_id = num_id;
> -		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
> +		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));
>  	}
>  	return set;
>  }

Thank you CJ for this patchset.
As pointed out by others, it would be great to directly use tthe
bitmap-APIs instead of having an intermediate patch, which renames the
functions. As you mentioned, it is minimal, but the otherway would be
better for maintainability.

> @@ -41,7 +41,7 @@ void idset_free(struct idset *set)
>  
>  void idset_fill(struct idset *set)
>  {
> -	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
> +	memset(set->bitmap, 0xff, idset_bitmap_size(set->num_ssid, set->num_id));
>  }
>  
>  static inline void idset_add(struct idset *set, int ssid, int id)
> -- 
> 2.34.1
> 
