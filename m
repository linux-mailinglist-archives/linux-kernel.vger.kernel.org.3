Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45084C45EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiBYNU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbiBYNUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:20:54 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6651FED99
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:20:21 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21PD7oji031571;
        Fri, 25 Feb 2022 14:19:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=LkW62k1kez4onNz5WnO7tO0QIWuCB9ldqXvRsV6nPqw=;
 b=SVostm1nI+zn46O/FSyoSL038Zksrwu7/d4jbLLajBAFOENbSLEy0Zw6sdZKfZw176h/
 Nnhkow09gC+lg3WAIU8G9P6HQcm2JB/ODPSSlDAT6s3Tub1d7gZWUNZfLdQ7hRzlLY9w
 RSjv0jeFGgodwvwK9v3NxLcjmdSmSCOFSeQv63yqq+97kk9++aGrRb12Ygar49rNvbfq
 38WsZRvfD3pajWcRtcVtCzoAS0UGTqbimhDyOGCOkhAQWxax4zGWhWVlC6xTwtKwc2wv
 CflTeGvXaGthztqES4z/YjJnrqgvcqKO8shiPN6OQx4IYUge35CHdiC1UH6UBYuQ3zi4 Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3eetrf25hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 14:19:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4CDC010002A;
        Fri, 25 Feb 2022 14:19:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3F423226FB7;
        Fri, 25 Feb 2022 14:19:51 +0100 (CET)
Received: from [10.201.22.81] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 25 Feb
 2022 14:19:50 +0100
Message-ID: <c61d8a3f-6f19-48aa-ae69-e4f3670d4b16@foss.st.com>
Date:   Fri, 25 Feb 2022 14:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/stm: Avoid using val uninitialized in
 ltdc_set_ycbcr_config()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
References: <20220222152045.484610-1-nathan@kernel.org>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20220222152045.484610-1-nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_07,2022-02-25_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 16:20, Nathan Chancellor wrote:
> Clang warns:
> 
>    drivers/gpu/drm/stm/ltdc.c:625:2: warning: variable 'val' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
>            default:
>            ^~~~~~~
>    drivers/gpu/drm/stm/ltdc.c:635:2: note: uninitialized use occurs here
>            val |= LxPCR_YCEN;
>            ^~~
>    drivers/gpu/drm/stm/ltdc.c:600:9: note: initialize the variable 'val' to silence this warning
>            u32 val;
>                   ^
>                    = 0
>    1 warning generated.
> 
> Use a return instead of break in the default case to fix the warning.
> Add an error message so that this return is not silent, which could hide
> issues in the future.
> 
> Fixes: 484e72d3146b ("drm/stm: ltdc: add support of ycbcr pixel formats")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1575
> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> v1 -> v2: https://lore.kernel.org/r/20220207165304.1046867-1-nathan@kernel.org/
> 
> * Use DRM_ERROR() instead of drm_err() (Philippe).

Hi Nathan,

Applied on drm-misc-next.
Many thanks for your patch,
Philippe :-)

> 
> * Collect tags from v1, as nothing substantial has changed.
> 
>   drivers/gpu/drm/stm/ltdc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 5eeb32c9c9ce..c9bc4ccb6d43 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -624,7 +624,8 @@ static inline void ltdc_set_ycbcr_config(struct drm_plane *plane, u32 drm_pix_fm
>   		break;
>   	default:
>   		/* RGB or not a YCbCr supported format */
> -		break;
> +		DRM_ERROR("Unsupported pixel format: %u\n", drm_pix_fmt);
> +		return;
>   	}
>   
>   	/* Enable limited range */
> 
> base-commit: 542898c5aa5c6a3179dffb1d1606884a63f75fed
