Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2F4AB3F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbiBGFvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243704AbiBGERT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:17:19 -0500
X-Greylist: delayed 160 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 20:17:18 PST
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA57C061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 20:17:17 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220207041716epoutp04fbc6f5862685fda51924984207ce3f78~RZfO1fs951312013120epoutp04S
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:17:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220207041716epoutp04fbc6f5862685fda51924984207ce3f78~RZfO1fs951312013120epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644207436;
        bh=4ck6lVtCBpeaSDrwhLqPIKiZExfSF7Tyk9gaU04baw0=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=Mu7kLaL68nGzaQwoRPSf6t5owqSaq7cjE2tIaIxcLg/gf+UTApeAeCi3nLV5ILxB0
         nf37CzVsk3iDp6YEAWIwAKrI3UZLwt9RdwxxNtwAlQt+nNRAuvH5+xTFy+8fpaoyzz
         va+gCC13T08MW+zZxOwpjsSnlGzXPMmq7l7/ogIo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220207041715epcas5p1033fb80b16399411885fc73428746e1c~RZfOZKyRT0984509845epcas5p1o;
        Mon,  7 Feb 2022 04:17:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JsXsf5DFYz4x9Q9; Mon,  7 Feb
        2022 04:17:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.44.46822.AAC90026; Mon,  7 Feb 2022 13:14:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220207041708epcas5p3a8e7483fc69e7e6019e48e9f05d56806~RZfHsio_42307023070epcas5p39;
        Mon,  7 Feb 2022 04:17:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220207041708epsmtrp15c172bd6db2f1756f2b748c4cf0ef0b4~RZfHrrGjq0897108971epsmtrp1e;
        Mon,  7 Feb 2022 04:17:08 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-97-62009caa640c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.9B.08738.44D90026; Mon,  7 Feb 2022 13:17:08 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220207041701epsmtip15f07fd6355d1db162219b38209f85dc9~RZfBBFTso3211932119epsmtip1C;
        Mon,  7 Feb 2022 04:17:00 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Lukasz Luba'" <lukasz.luba@arm.com>,
        "'Dmitry Osipenko'" <digetx@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20220206135807.211767-8-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v3 7/8] memory: of: parse max-freq property
Date:   Mon, 7 Feb 2022 09:46:55 +0530
Message-ID: <0a7201d81bd9$9251fed0$b6f5fc70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGyHe1yAVlgrWkusZTYpz8Cv3vw/AIE77dMAizDPX+ssekcMA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmpu6qOQxJBttf6lvMP3KO1WL1x8eM
        Fhvf/mCy2PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaL1r1H2B04PdbMW8PoMauhl81j56y7
        7B6bVnWyeWxeUu/xeZNcAFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi
        0rx0vbzUEitDAwMjU6DChOyMGWtWsRQs4KtYc7SRuYFxCU8XIyeHhICJxK1Tn9i7GLk4hAR2
        M0qcX3CKGcL5xCix6u9rFpAqIYHPjBI770vAdDx+sA2qaBejxLcrOxghnJeMEp0v7rODVLEJ
        6ErsWNzGBpIQEXjMJDHx/FZGkASngIfE7zXvgcZycAgL2Eu87bUECbMIqEis+3OQGcTmFbCU
        uNW0kwnCFpQ4OfMJ2BXMAvIS29/OYYa4QkHi59NlrCC2iICTxPRPfYwQNeISL48eAftHQmAh
        h8Tf951MEA0uEgd/vWWDsIUlXh3fwg5hS0m87G9jB7lHQiBbomeXMUS4RmLpvGMsELa9xIEr
        c8BOZhbQlFi/Sx9iFZ9E7+8nTBCdvBIdbUIQ1aoSze+uQnVKS0zs7maFKPGQ+DlXDBJSNxkl
        Zp7fwTiBUWEWkidnIXlyFpJnZiEsXsDIsopRMrWgODc9tdi0wCgvtRwe3cn5uZsYwSlWy2sH
        48MHH/QOMTJxMB5ilOBgVhLhlen+nyjEm5JYWZValB9fVJqTWnyI0RQY8hOZpUST84FJPq8k
        3tDE0sDEzMzMxNLYzFBJnPd0+oZEIYH0xJLU7NTUgtQimD4mDk6pBqaiqfztqqeOr1D/O1lE
        tiLy4pYAkQPdsUz/Nu6IE3/2/vDreneWt8rBO8PPSnk9OV+7rJnLL/lJX6/L6sr8l61BHctu
        bDyn4l55veIUk5CwV4pRVWYte+3r+sP3trN6Wcrn2R1fvWC7hK25gL+Lsbgpo73XN4v68qQT
        QT9XT46MM1LSnxpU/phpb4apk8fkfIkap8vtX4urohjtnC/JHPHuuBWUXp9Qsdl7V8W6RTWy
        Lpc2/Txpx9+bmmVypDWr8d3ePRc+LejJOLTeY/d8jqPCx9uYXduXt1/78EL/ycWcwxtCFSLl
        yuU/Xrv1jZ2dYZ79/V+r6l9ov7p81yb4HX/V2qJL5+ccfHL3xDbhMiWW4oxEQy3mouJEAEiG
        5MY6BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTtdlLkOSwadGRYv5R86xWqz++JjR
        YuPbH0wWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWNjUwm7RuvcIuwOnx5p5axg9ZjX0snnsnHWX
        3WPTqk42j81L6j0+b5ILYIvisklJzcksSy3St0vgypixZhVLwQK+ijVHG5kbGJfwdDFyckgI
        mEg8frCNGcQWEtjBKLF9PjtEXFri+sYJULawxMp/z4FsLqCa54wSu3bPYwNJsAnoSuxY3MYG
        khAReM0k8aBpKQtE1VVGieVbrzCBVHEKeEj8XvMeKMHBISxgL/G21xIkzCKgIrHuz0GwzbwC
        lhK3mnYyQdiCEidnPgErZxbQk2jbyAgSZhaQl9j+dg4zxEEKEj+fLmMFsUUEnCSmf+qDqhGX
        eHn0CPsERqFZSCbNQpg0C8mkWUg6FjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93E
        CI4nLa0djHtWfdA7xMjEwXiIUYKDWUmEV6b7f6IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtd
        J+OFBNITS1KzU1MLUotgskwcnFINTKt/OZuvvKmSW7A6Kyn66921hom7eX6d2MU5IWrO9fe9
        Eyf+VbFozk6bWi4uULLjvcyUTV9r+te4CHOf2pt/xzDBgCXSxfJNtfURycNdTGsm2dhd+/9j
        +l/e/QYcP4IPVE53t5J7qrZR+KTYucNOAueLbtUvzd5wfMZ0G6f++ke2fXO8z0k6y6bWLhST
        XL8udfsLfu5js0+v+MO5dnduMMP9V/kX77ptLgw6zFUaqfxsf/el/5qXuS7tF7r//bHTs6Ym
        FrUMl0/fahkD7NIuFHavevV1xWObz03TOm7HOCucYo2+eU3o+7y7QL99Xtsm63ywcX6Y6s60
        ssUvmGKd/ScWT5lXf3uT4pNN0v+WbFdiKc5INNRiLipOBABd+X+FFgMAAA==
X-CMS-MailID: 20220207041708epcas5p3a8e7483fc69e7e6019e48e9f05d56806
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220206135826epcas5p23b773aa6d7a4483d8b91015d200d975f
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
        <CGME20220206135826epcas5p23b773aa6d7a4483d8b91015d200d975f@epcas5p2.samsung.com>
        <20220206135807.211767-8-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Sunday, February 6, 2022 7:28 PM
>To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Rob Herring
><robh+dt@kernel.org>; Lukasz Luba <lukasz.luba@arm.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Dmitry Osipenko <digetx@gmail.com>; linux-
>kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
>pm@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org
>Subject: [PATCH v3 7/8] memory: of: parse max-freq property
>
>Passing the memory timings maximum frequency as an unit address was a
>workaround and instead 'max-freq' is preferred.  Look for 'max-freq'
>first and then fallback to 'reg'.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.ahtar@samsung.com>


> drivers/memory/of_memory.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
>index b94408954d85..bac5c7f34936 100644
>--- a/drivers/memory/of_memory.c
>+++ b/drivers/memory/of_memory.c
>@@ -212,8 +212,10 @@ static int of_lpddr3_do_get_timings(struct
>device_node *np,  {
> 	int ret;
>
>-	/* The 'reg' param required since DT has changed, used as 'max-freq'
>*/
>-	ret = of_property_read_u32(np, "reg", &tim->max_freq);
>+	ret = of_property_read_u32(np, "max-freq", &tim->max_freq);
>+	if (ret)
>+		/* Deprecated way of passing max-freq as 'reg' */
>+		ret = of_property_read_u32(np, "reg", &tim->max_freq);
> 	ret |= of_property_read_u32(np, "min-freq", &tim->min_freq);
> 	ret |= of_property_read_u32(np, "tRFC", &tim->tRFC);
> 	ret |= of_property_read_u32(np, "tRRD", &tim->tRRD);
>--
>2.32.0


