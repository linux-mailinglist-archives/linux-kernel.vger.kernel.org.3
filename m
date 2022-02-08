Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBE34ADE48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383113AbiBHQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352165AbiBHQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:23:32 -0500
X-Greylist: delayed 2318 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 08:23:31 PST
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509BAC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:23:30 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218AXaZg001203;
        Tue, 8 Feb 2022 16:44:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ddNKQeBNsufwtCR82T3hW0VvpqNHVS9IOC40mmH+H4Y=;
 b=r7xz+kjguAgrfwFsWKvHgj8PszyLfubCiP0Sm9Ix80tW1MFjXbvTFgXLqOTb7v6CwgdB
 oCSg34AYk0aNVKnfP3wIlIM/vbiYxBTIcgevTazRr8y0P7jh7PskiqSjKQF6l8KlR0Ql
 kxt9VIzRQQ7jN3sKzPe7AUgjqcslVHx5lRerGl5Pxj8YS61QlE242zVsdyTSOss2myJT
 dtgjyEKvMhFwkjXAU1wgO9oVMLqUNPJ+trprw16r+NFf9dMrnoRu46SDsNsYIwQrXTMh
 c3gAdRYfYxom5aFLtg00gc4BeWUM9ZXD9CU3X82sAI1lDAI4UVzjr9PJTwK40GKW0vQo +g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e37nk5n3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 16:44:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E317F10002A;
        Tue,  8 Feb 2022 16:44:17 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D584E221778;
        Tue,  8 Feb 2022 16:44:17 +0100 (CET)
Received: from [10.129.7.146] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 8 Feb
 2022 16:44:17 +0100
Message-ID: <aea58d59-9b1c-608b-7212-1d64ce2f07db@foss.st.com>
Date:   Tue, 8 Feb 2022 16:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/stm: Avoid using val uninitialized in
 ltdc_set_ycbcr_config()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20220207165304.1046867-1-nathan@kernel.org>
From:   yannick Fertre <yannick.fertre@foss.st.com>
In-Reply-To: <20220207165304.1046867-1-nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_05,2022-02-07_02,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,
Thenks for the patch.

Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>

Best regards

On 2/7/22 17:53, Nathan Chancellor wrote:
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
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 5eeb32c9c9ce..447ddde1786c 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -624,7 +624,8 @@ static inline void ltdc_set_ycbcr_config(struct drm_plane *plane, u32 drm_pix_fm
>   		break;
>   	default:
>   		/* RGB or not a YCbCr supported format */
> -		break;
> +		drm_err(plane->dev, "Unsupported pixel format: %u\n", drm_pix_fmt);
> +		return;
>   	}
>   
>   	/* Enable limited range */
> 
> base-commit: 542898c5aa5c6a3179dffb1d1606884a63f75fed
