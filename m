Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75755B0670
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiIGOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiIGOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:24:11 -0400
X-Greylist: delayed 804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 07:23:53 PDT
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61D67C1FA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:23:53 -0700 (PDT)
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287Ae2DX004867;
        Wed, 7 Sep 2022 15:10:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=dTrQ7MrhUOBXmD1FAoFV49SHQ23WQ+8G8Ues2Ac95vs=;
 b=JrTmxYf8FWbfxHDr5DJ5YHcUij8SHTIOJDAFlUrfwypriOmW2XL0P6e3wf45O9BK2fpG
 Y5vF+kcnO9Vgff0crQGjxBn/hc5m/tGtl8147D/Ym+8kCX7CtBASFizUECnyAVh77Wyl
 nFizkgO/bj/7zwhRIUS/KxL9iUIazsB9ndUM1v+hUCLq4sSASSNP1hl7FTI9L8Fx2aSq
 LRn/7iAZq/fNajbU+51Q/1d8BL+BZgUMGF+yCZ2r+mWjwbkhTcdJ7LlppuonlfcKzTMS
 hb+jbhdLZigm7yYKA8SGm4R7N3xjf9kU2UjaSCDEzpL03o8teUMeil0jg2hlEi2Z2QeR EQ== 
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
        by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3je9sdyb4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 15:10:24 +0100
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.17.1.5/8.17.1.5) with ESMTP id 287BTrkx021728;
        Wed, 7 Sep 2022 10:10:07 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
        by prod-mail-ppoint7.akamai.com (PPS) with ESMTP id 3jc28xwut6-1;
        Wed, 07 Sep 2022 10:10:07 -0400
Received: from [0.0.0.0] (unknown [172.27.119.138])
        by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id 5EA52118;
        Wed,  7 Sep 2022 14:10:06 +0000 (GMT)
Message-ID: <92e3c2c4-4384-04ae-2016-ad9be8a3fc9b@akamai.com>
Date:   Wed, 7 Sep 2022 10:10:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 10/57] dyndbg: cleanup auto vars in dynamic_debug_init
Content-Language: en-US
To:     Jim Cromie <jim.cromie@gmail.com>, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
References: <20220904214134.408619-1-jim.cromie@gmail.com>
 <20220904214134.408619-11-jim.cromie@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <20220904214134.408619-11-jim.cromie@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_08,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070055
X-Proofpoint-GUID: pQRCw3hmNV4Dnf3MrVmGF2JyV-FKuiJr
X-Proofpoint-ORIG-GUID: pQRCw3hmNV4Dnf3MrVmGF2JyV-FKuiJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_08,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070056
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/22 17:40, Jim Cromie wrote:
> rework var-names for clarity, regularity
> rename variables
>   - n to mod_sites - it counts sites-per-module
>   - entries to i - display only
>   - iter_start to iter_mod_start - marks start of each module's subrange
>   - modct to mod_ct - stylistic
> 
> new iterator var:
>   - site - cursor parallel to iter
>     1st step towards 'demotion' of iter->site, for removal later
> 
> treat vars as iters:
>   - drop init at top
>     init just above for-loop, in a textual block
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index e96dc216463b..2e8ebef3bd0d 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -1059,11 +1059,10 @@ static int __init dynamic_debug_init_control(void)
>  
>  static int __init dynamic_debug_init(void)
>  {
> -	struct _ddebug *iter, *iter_start;
> -	const char *modname = NULL;
> +	struct _ddebug *iter, *iter_mod_start;
> +	int ret, i, mod_sites, mod_ct;
> +	const char *modname;
>  	char *cmdline;
> -	int ret = 0;
> -	int n = 0, entries = 0, modct = 0;
>  
>  	if (&__start___dyndbg == &__stop___dyndbg) {
>  		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
> @@ -1074,30 +1073,32 @@ static int __init dynamic_debug_init(void)
>  		ddebug_init_success = 1;
>  		return 0;
>  	}
> -	iter = __start___dyndbg;
> +
> +	iter = iter_mod_start = __start___dyndbg;
>  	modname = iter->modname;
> -	iter_start = iter;
> -	for (; iter < __stop___dyndbg; iter++) {
> -		entries++;
> +	i = mod_sites = mod_ct = 0;
> +
> +	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
> +

Just a small nit here - not sure why there's an extra blank line here?
But either way:

Acked-by: Jason Baron <jbaron@akamai.com>


>  		if (strcmp(modname, iter->modname)) {
> -			modct++;
> -			ret = ddebug_add_module(iter_start, n, modname);
> +			mod_ct++;
> +			ret = ddebug_add_module(iter_mod_start, mod_sites, modname);
>  			if (ret)
>  				goto out_err;
> -			n = 0;
> +
> +			mod_sites = 0;
>  			modname = iter->modname;
> -			iter_start = iter;
> +			iter_mod_start = iter;
>  		}
> -		n++;
>  	}
> -	ret = ddebug_add_module(iter_start, n, modname);
> +	ret = ddebug_add_module(iter_mod_start, mod_sites, modname);
>  	if (ret)
>  		goto out_err;
>  
>  	ddebug_init_success = 1;
>  	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg section\n",
> -		 entries, modct, (int)((modct * sizeof(struct ddebug_table)) >> 10),
> -		 (int)((entries * sizeof(struct _ddebug)) >> 10));
> +		 i, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
> +		 (int)((i * sizeof(struct _ddebug)) >> 10));
>  
>  	/* now that ddebug tables are loaded, process all boot args
>  	 * again to find and activate queries given in dyndbg params.
