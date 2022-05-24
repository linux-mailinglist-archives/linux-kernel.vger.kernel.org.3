Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4955320EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiEXC1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiEXC1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:27:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47584694B5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:27:36 -0700 (PDT)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L6dLq1NYszQk8F;
        Tue, 24 May 2022 10:24:35 +0800 (CST)
Received: from kwepemm600018.china.huawei.com (7.193.23.140) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 10:27:34 +0800
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemm600018.china.huawei.com (7.193.23.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 10:27:33 +0800
Message-ID: <4e513db6-6b42-0b86-d0ed-fac762d9c746@huawei.com>
Date:   Tue, 24 May 2022 10:27:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next] drm/panel: Fix build error when
 CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m
To:     Doug Anderson <dianders@chromium.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>, <zhengbin13@huawei.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220523085745.276-1-gaochao49@huawei.com>
 <CAD=FV=VVZo+wsR0yPLvq-8jkZg12+Sw0NM0TkgQLHDCxCiFdGw@mail.gmail.com>
From:   "gaochao (L)" <gaochao49@huawei.com>
In-Reply-To: <CAD=FV=VVZo+wsR0yPLvq-8jkZg12+Sw0NM0TkgQLHDCxCiFdGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600018.china.huawei.com (7.193.23.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/24 0:47, Doug Anderson 写道:
> Hi,
> 
> On Mon, May 23, 2022 at 1:58 AM gaochao <gaochao49@huawei.com> wrote:
>>
>> If CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m,
>> bulding fails:
>>
>> drivers/gpu/drm/panel/panel-samsung-atna33xc20.o: In function `atana33xc20_probe':
>> panel-samsung-atna33xc20.c:(.text+0x744): undefined reference to
>>  `drm_panel_dp_aux_backlight'
>> make: *** [vmlinux] Error 1
>>
>> Let CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 select DRM_DISPLAY_DP_HELPER and
>> CONFIG_DRM_DISPLAY_HELPER to fix this error.
>>
>> Fixes: 32ce3b320343 ("drm/panel: atna33xc20: Introduce the Samsung ATNA33XC20 panel")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: gaochao <gaochao49@huawei.com>
> 
> I think the author / Signed-off-by are supposed to be real names. Is
> "gaochao" your legal name?
Thank you for the review.
Should be "Gao Chao", fixing in the second version.
> 
>> ---
>>  drivers/gpu/drm/panel/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Other than the Signed-off-by / Author issue:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> .
