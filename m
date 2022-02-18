Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D94BC044
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiBRT2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:28:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiBRT2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:28:07 -0500
X-Greylist: delayed 1188 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Feb 2022 11:27:49 PST
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841ED35865
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:27:48 -0800 (PST)
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21IFaoKW031328;
        Fri, 18 Feb 2022 19:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=MwzwUpADy1DJ0zEwQALBZYdoSIdroLaoM5tAqzLBFz8=;
 b=E8Fle8VIjzOaWGe8z8sKiw1j//WJkb7bBgT+dlMDE6B4exWVnDMT73687oi5ph+MWeyi
 rWuSeMngIrsUPOA8i5yNRnfWvJ23m98NLLJovrd6JoLnHKBf8SQzvKyG+TAPITVQBoJY
 LuE0qyuTtrtJSE6DTJLpvq4It1yaOSGNQO6I0iK4+O3g8DEJhx5iPTB9XXk16gOPG1G5
 VSHXL3B3H4GwXTnlhgR6xzpdgWMypgg1MY7lEgbKesQsnzLszFyXS+xd3GKkJVQznZnK
 IDUKIrK6CjUauagdlJL2K1uDQSGAF4qtV5gv9fzMh6ScRrBCDdRX4EFOF4JSrSOBXJYe KQ== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3eaa6fswbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 19:07:27 +0000
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 21IJ6xOM030163;
        Fri, 18 Feb 2022 11:07:27 -0800
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint5.akamai.com with ESMTP id 3e9sc01wmf-1;
        Fri, 18 Feb 2022 11:07:26 -0800
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id B7B9C290AF;
        Fri, 18 Feb 2022 19:07:26 +0000 (GMT)
Message-ID: <c65fa908-72a6-bad9-613b-fb33a6e0359c@akamai.com>
Date:   Fri, 18 Feb 2022 14:07:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] jump_label: refactor #ifdef of struct static_key
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220213165717.2354046-1-masahiroy@kernel.org>
 <20220213165717.2354046-2-masahiroy@kernel.org>
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <20220213165717.2354046-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-18_08:2022-02-17,2022-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180117
X-Proofpoint-GUID: SfOo22aqjg_lZVKwlG-BV-_6tw_2yIm7
X-Proofpoint-ORIG-GUID: SfOo22aqjg_lZVKwlG-BV-_6tw_2yIm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_08,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180117
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/22 11:57, Masahiro Yamada wrote:
> Move #ifdef CONFIG_JUMP_LABEL inside the struct static_key.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  include/linux/jump_label.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 6924e6837e6d..107751cc047b 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -82,10 +82,9 @@ extern bool static_key_initialized;
>  				    "%s(): static key '%pS' used before call to jump_label_init()", \
>  				    __func__, (key))
>  
> -#ifdef CONFIG_JUMP_LABEL
> -
>  struct static_key {
>  	atomic_t enabled;
> +#ifdef CONFIG_JUMP_LABEL
>  /*
>   * Note:
>   *   To make anonymous unions work with old compilers, the static
> @@ -104,13 +103,9 @@ struct static_key {
>  		struct jump_entry *entries;
>  		struct static_key_mod *next;
>  	};
> +#endif	/* CONFIG_JUMP_LABEL */
>  };
>  
> -#else
> -struct static_key {
> -	atomic_t enabled;
> -};
> -#endif	/* CONFIG_JUMP_LABEL */
>  #endif /* __ASSEMBLY__ */
>  
>  #ifdef CONFIG_JUMP_LABEL


These two cleanups look fine to me.

Acked-by: Jason Baron <jbaron@akamai.com>>

Thanks,

-Jason
