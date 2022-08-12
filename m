Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F92591195
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiHLNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbiHLNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:34:29 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D19D8F2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:34:26 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220812133424euoutp01645f9f99adfc86049544f9890d186acf~KnExHgfgu0486904869euoutp01h
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:34:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220812133424euoutp01645f9f99adfc86049544f9890d186acf~KnExHgfgu0486904869euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660311264;
        bh=MkZCuQgIsBVplYM2ulhejLrnFPkJHNJnFDJoU33mPJ8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Yx6Xucz9ZWkpLU+pFQPiG6b6rVip389ZRuFiVVBqkTzPEkP9Q79RTMHuPQr9OdXT+
         JsEj9aASenpLsjZUrUPPUdADeo9y/zM5M3Y73439bti9A/9Wt+T147NDTdDHEZ7xU0
         fEOf4QS5leHl7FVTZCQ/eicTSiyURcRg/vF2GNeI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220812133423eucas1p1e17293f1b6aac297dfd77de5132f5ea6~KnEw95x9c0120701207eucas1p1m;
        Fri, 12 Aug 2022 13:34:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 95.2C.09580.FD656F26; Fri, 12
        Aug 2022 14:34:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220812133423eucas1p132aea983a5c2d0d4fe62a10ef2ffc9b3~KnEwjXX0f0517605176eucas1p1Z;
        Fri, 12 Aug 2022 13:34:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220812133423eusmtrp217fb9ace3bb45a751196445fe7f4258f~KnEwikXNu0855308553eusmtrp2N;
        Fri, 12 Aug 2022 13:34:23 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-8e-62f656dfaf67
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.15.09095.FD656F26; Fri, 12
        Aug 2022 14:34:23 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220812133422eusmtip28344f0ba3a59afc6387c4871aa545fd2~KnEwBR17b2310523105eusmtip2I;
        Fri, 12 Aug 2022 13:34:22 +0000 (GMT)
Message-ID: <ab708272-efe0-343e-2dfc-299187126a2a@samsung.com>
Date:   Fri, 12 Aug 2022 15:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] thermal/core: Fix lockdep_assert() warning
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, krzk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitk@kernel.org, linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220812131202.1331238-1-daniel.lezcano@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7r3w74lGTx5Z2xxeH6FxbzPshbn
        z29gt7i8aw6bxefeI4wWM87vY7KY+2Uqs8WTh31sDhwei/e8ZPLYtKqTzePOtT1sHp83yQWw
        RHHZpKTmZJalFunbJXBl7D8zk71gNnfFuh8TmBsY53B2MXJySAiYSLzfsJupi5GLQ0hgBaPE
        4+6pbBDOF0aJ6123oTKfGSWWrNvEDNOy5eM6qMRyRom5pz6xQDgfGSX+nH7PAlLFK2Ancfps
        JyuIzSKgKtHa9IgJIi4ocXLmE7AaUYFkiWf/F7OD2MIC9hLbl+wGq2EWEJe49WQ+mC0ioCfR
        +L4NKr6GUaLxjSmIzSZgKNH1tosNxOYUcJTY+OAkI0SNvMT2t3OYQQ6SELjBIfGodQU7xNku
        Eou3XIWyhSVeHd8CZctI/N8JsowDyM6X+DvDGCJcIXHt9Rqoj60l7pz7xQZSwiygKbF+lz5E
        2FHi6Kp7jBCdfBI33gpCXMAnMWnbdGaIMK9ER5sQRLWaxKzj6+B2HrxwiXkCo9IspDCZheT3
        WUh+mYWwdwEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA5HP63/GvOxhXvPqod4iR
        iYPxEKMEB7OSCG/Zos9JQrwpiZVVqUX58UWlOanFhxilOViUxHmTMzckCgmkJ5akZqemFqQW
        wWSZODilGpisFuYlm7XP7f/QbzWxIOAjn8eduHeZZU4LdKT+7HwUM3Ub+06Xeat1cr7NztC8
        v/f3Q39HcZ1/D3Zybqn6dV7z98pHNRGXHZUCtr6UeGIqdDz0U6+k2n+F+MN7HYP91y5uvFDV
        UlP/YDbHxlmTrZyPzk468EbUxVnng/7KuesUk6fsbxOyn9hacmvjsVPPvn/o0TMIlV+TxlM+
        WeJAn9dh1rlu3Un/H26afdO8Z8upvbulZ3xzVH/btGRZjPv1lT2eKgaLpB/80/2bGqH28sf2
        i8fCDjgsX27HWF1bEcf99EnI5f3/J2xOPLfexfb+eu5sY7H1mfMbpq6NCj3Sc23x9oAZtR6s
        hZMm3uIt6tuqpMRSnJFoqMVcVJwIAF2eww6tAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7r3w74lGRzuFrY4PL/CYt5nWYvz
        5zewW1zeNYfN4nPvEUaLGef3MVnM/TKV2eLJwz42Bw6PxXteMnlsWtXJ5nHn2h42j8+b5AJY
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy9p+Z
        yV4wm7ti3Y8JzA2Mczi7GDk5JARMJLZ8XMfUxcjFISSwlFHi0s4X7BAJGYmT0xpYIWxhiT/X
        utggit4zSpy/PpkFJMErYCdx+mwnWBGLgKpEa9MjJoi4oMTJmU/AakQFkiUWHFoKZgsL2Ets
        X7IbrIZZQFzi1pP5YLaIgJ5E4/s2sCuYBdYwSnybOJsdYttJRonDM6ezgVSxCRhKdL3tArM5
        BRwlNj44yQgxyUyia2sXlC0vsf3tHOYJjEKzkBwyC8nCWUhaZiFpWcDIsopRJLW0ODc9t9hQ
        rzgxt7g0L10vOT93EyMw6rYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4S1b9DlJiDclsbIqtSg/
        vqg0J7X4EKMpMDQmMkuJJucD4z6vJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1
        CKaPiYNTqoEpKmUpw/Jn75xa23znzmlIYp55uCvtiv+J/vcHua+enaq9h0uzMDWDZ76fOk/5
        T/tl877e7djH13fy46d6vZVTFd6oKEqd3OrzxHgXbwdbwJwGB+U0Fvmc2EmFIf65VXbrVjx5
        2S96pmJXG++sbckbDnieuuRZf/72wpqQGbZ1M99c1Ej5fmtm9uPISy+7Ztkbf06cuMVR6bu9
        HJfgq41Sx5Y/E904698SixtMv29ufvYvhfuzaGStd6TRDruc25oy6k3WPYYba9azJbyfcb5K
        4NHBau5p8zlqHk/YZxGlvHrziVc9WSxiR755uXlIbOKy4Zy1+IXv3e2/dv0qX+rhuM96yf6t
        ssv1VJ6t35dXq8RSnJFoqMVcVJwIAGeOVq9DAwAA
X-CMS-MailID: 20220812133423eucas1p132aea983a5c2d0d4fe62a10ef2ffc9b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220812131216eucas1p266cfd4e51b59fc3cf8056474a6910094
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220812131216eucas1p266cfd4e51b59fc3cf8056474a6910094
References: <f1fb1d84-85de-f3c5-0212-fcf0e9c0ccd2@samsung.com>
        <CGME20220812131216eucas1p266cfd4e51b59fc3cf8056474a6910094@eucas1p2.samsung.com>
        <20220812131202.1331238-1-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.2022 15:12, Daniel Lezcano wrote:
> The function thermal_zone_device_is_enabled() must be called with the
> thermal zone lock held. In the resume path, it is called without.
>
> As the thermal_zone_device_is_enabled() is also checked in
> thermal_zone_device_update(), do the check in resume() function is
> pointless, except for saving an extra initialization which does not
> hurt if it is done in all the cases.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

This fixes the warning I've reported. Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/thermal/thermal_core.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 50814009339d..dc8ff6a84df1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1438,9 +1438,6 @@ static int thermal_pm_notify(struct notifier_block *nb,
>   	case PM_POST_SUSPEND:
>   		atomic_set(&in_suspend, 0);
>   		list_for_each_entry(tz, &thermal_tz_list, node) {
> -			if (!thermal_zone_device_is_enabled(tz))
> -				continue;
> -
>   			thermal_zone_device_init(tz);
>   			thermal_zone_device_update(tz,
>   						   THERMAL_EVENT_UNSPECIFIED);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

