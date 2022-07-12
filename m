Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD12570E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGLAIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGLAIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:08:19 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979A43AB0D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:08:18 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220712000816epoutp01620c31a66f32ad7a54532df1ee0431ae~A7FFBR4Rq2814628146epoutp01w
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:08:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220712000816epoutp01620c31a66f32ad7a54532df1ee0431ae~A7FFBR4Rq2814628146epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657584496;
        bh=vT9r9c+bDnpjTVLAS+8IHqgPizY369yt4SmfkxarQ2E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=F+sfaGKnw6hR9bB644tormLWgroHf7nvInp8FsKH0gZkRkrH4UMVgf/R9M1MFe8N2
         vPUwklj6zYwkctbdDedQfQkJETtogCjzAYA9fm5Huuh4hWJ7jo4ChentBhXJlTOFpV
         pYoiE382AOKW/4cG+dO0RAEc70UoY6+hHK+kOq2w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220712000815epcas1p253987f91a1f1c80bce45f53ed57e8a18~A7FES-Lwd0031700317epcas1p2X;
        Tue, 12 Jul 2022 00:08:15 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.223]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lhh0v3SyVz4x9Pv; Tue, 12 Jul
        2022 00:08:15 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.C1.10203.F6BBCC26; Tue, 12 Jul 2022 09:08:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220712000814epcas1p3e8db8a92f1571761fbbd2d0a69b6cddc~A7FDg2RMu3221032210epcas1p3O;
        Tue, 12 Jul 2022 00:08:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220712000814epsmtrp1a668e0da2d55c5d10dee796e2067d3d5~A7FDf9Mlr1758117581epsmtrp1X;
        Tue, 12 Jul 2022 00:08:14 +0000 (GMT)
X-AuditID: b6c32a38-597ff700000027db-ea-62ccbb6fc038
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.91.08802.E6BBCC26; Tue, 12 Jul 2022 09:08:14 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220712000814epsmtip2414a131b22ee74aef6a12f60d504eea1~A7FDPAq031597615976epsmtip2s;
        Tue, 12 Jul 2022 00:08:14 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     <ulf.hansson@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <linux@dominikbrodowski.net>,
        <alexandre.belloni@bootlin.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
        <dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
        <jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>,
        <seunghwan.hyun@samsung.com>
In-Reply-To: <20220705005035.14195-1-sh043.lee@samsung.com>
Subject: RE: [PATCH] mmc: print clock frequency with recognization
Date:   Tue, 12 Jul 2022 09:08:14 +0900
Message-ID: <013f01d89583$7b320640$719612c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGudEnl4+ePR7A4svMh0q0LRTjrCwLdAL9lrbc0OcA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmrm7+7jNJBr8vSFi0v1vGbjHjVBur
        xb5rJ9ktfv1dz27RvHg9m0XH1slMFjuen2G32PW3mcni8q45bBZH/vczWixo+cBqce7kJ1aL
        a2dOsFrcnjiZ0eL42nCLzZe+sTgIeMxbU+1xYSe3x51re9g89s9dw+7R/9fAo2/LKkaPz5vk
        Atijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgC5X
        UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFegVJ+YWl+al6+WlllgZGhgYmQIV
        JmRnrLt0l7lgk1DFhhPv2BsY1/B3MXJySAiYSPyfNompi5GLQ0hgB6PEzzu7mCGcT4wSl68u
        g3I+M0qcnnSfrYuRA6zlzwZ9iPguRokF526xQDgvGCWW7NrJBjKXTUBH4s2n/6wgtojAPUaJ
        zf2eIEXMAr8YJaZensMOkuAUsJb4su4fWJGwgJPErSvdzCAbWARUJdpmSIGEeQUsJTYeXcgG
        YQtKnJz5hAXEZhbQlli28DUzxA8KEj+fLmOFiItIzO5sY4bYayXxbPZ/sOMkBJ5wSOxdPYkV
        osFF4njTInYIW1ji1fEtULaUxMv+Nii7WKLt3z+oBRUSB/u+QNnGEp8+f2YEuZNZQFNi/S59
        iLCixM7fcxkhbuCTePe1hxUSWLwSHW1CECXKEi8fLWOCsCUllrTfYp7AqDQLyWezkHw2C8k3
        sxCWLWBkWcUollpQnJueWmxYYAKP7OT83E2M4EStZbGDce7bD3qHGJk4GA8xSnAwK4nw/jl7
        KkmINyWxsiq1KD++qDQntfgQoykwqCcyS4km5wNzRV5JvKGJpYGJmZGJhbGlsZmSOG/v1NOJ
        QgLpiSWp2ampBalFMH1MHJxSDUytx45O++3688rPRbeb+TdaVdROie6LqNdav+DJtN/C3IpH
        GBcVsHFeLNq6USXtas4uZZ+o4we/Pw5MtJF1fbfEZt4Xf+UC/f1tF55fjTj/hWf7k8/3tRek
        1haXn/z+I89M8IHRfjbvRKa3Kx2vi059mXe5uMDXPfWCkm9axu+kVd8MLC+dmhh/xPtE+PcZ
        /gfk6r6bhbW8smD7evzRn/enznWmSTzqqlSV6Eppi7IK/dyY/ZZhxc3p+WYpc6Ltii9Y87k0
        OK8z7y6Lnie+wbX8Mc8j8e5pqzkPvxDa+Ve+afL2Zue49dF3/+rHHLH4U5hQuFzMyGzdXeGs
        ZSvT2b4+zt2YqR//LGnpU0090zIlluKMREMt5qLiRACUAG8AXQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvG7e7jNJBgcWm1i0v1vGbjHjVBur
        xb5rJ9ktfv1dz27RvHg9m0XH1slMFjuen2G32PW3mcni8q45bBZH/vczWixo+cBqce7kJ1aL
        a2dOsFrcnjiZ0eL42nCLzZe+sTgIeMxbU+1xYSe3x51re9g89s9dw+7R/9fAo2/LKkaPz5vk
        AtijuGxSUnMyy1KL9O0SuDL27NjKVLBZsGJi+3PWBsb1fF2MHBwSAiYSfzbodzFycQgJ7GCU
        mH90GWsXIydQXFJi8aOHbBA1whKHDxdD1DxjlDh5+RAbSA2bgI7Em0//WUESIgJPGCUmXt3D
        BOIwCzQxSbzrewpWJSTQwyjRM8kPxOYUsJb4su4f2AZhASeJW1e6mUE2sAioSrTNkAIJ8wpY
        Smw8upANwhaUODnzCQuIzSygLdH7sJURxl628DUzxKEKEj+fQhzNLCAiMbuzDSwuImAl8Wz2
        f5YJjMKzkIyahWTULCSjZiFpX8DIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhm
        tbR2MO5Z9UHvECMTB+MhRgkOZiUR3j9nTyUJ8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJe
        SCA9sSQ1OzW1ILUIJsvEwSnVwORlsZCD/7m6gMie6t/JTJ+1okr1LF2fBx8p6t3wZN2sLe3/
        b811vVf2zbHisyCv4qP/Sctd2PxuFqy64NacxhCoriOY7Lj4pO9tiYAnHoGsgmGbGRIcY7av
        6jS9Efsh6MRBZ06WzyqNAYIZxsWc5dvuHep74Ttts/wF3b2zW+qDZlVfvrD4fPdNFvtzYf2z
        1kWoJl5INFVXfW7r9u7Dlq7NK2eG6CQ6fNTv8Xhu8XhWmptawTPPu1J5x1pOJno6C7sxCUw7
        zLCOpajf9sOe7UHlW7ymH3K6yntHfsntaU9ZJ36eHJZU8jPGS2ML+8+j9j8Y423vrSuxLz9z
        smjV7t0vbfqFi/VyP0WHFOhfVGIpzkg01GIuKk4EAIvYLMxIAwAA
X-CMS-MailID: 20220712000814epcas1p3e8db8a92f1571761fbbd2d0a69b6cddc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220705001814epcas1p40a4eadbf8429f01a98bdb56f00ba3310
References: <CGME20220705001814epcas1p40a4eadbf8429f01a98bdb56f00ba3310@epcas1p4.samsung.com>
        <20220705005035.14195-1-sh043.lee@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Seunghui Lee <sh043.lee=40samsung.com>
> Sent: Tuesday, July 5, 2022 9:51 AM
> To: ulf.hansson=40linaro.org; u.kleine-koenig=40pengutronix.de;
> gregkh=40linuxfoundation.org; linux=40dominikbrodowski.net;
> alexandre.belloni=40bootlin.com; linux-mmc=40vger.kernel.org; linux-
> kernel=40vger.kernel.org
> Cc: grant.jung=40samsung.com; jt77.jang=40samsung.com;
> dh0421.hwang=40samsung.com; junwoo80.lee=40samsung.com; jangsub.yi=40sams=
ung.com;
> cw9316.lee=40samsung.com; sh8267.baek=40samsung.com; wkon.kim=40samsung.c=
om;
> seunghwan.hyun=40samsung.com; Seunghui Lee <sh043.lee=40samsung.com>
> Subject: =5BPATCH=5D mmc: print clock frequency with recognization
>=20
> It's easy to figure out how fast frequency it has from the log.
> e.g. mmc0: new ultra high speed SDR104 SDXC card at address aaaa(clk
> 202000000)
>=20
> Signed-off-by: Seunghui Lee <sh043.lee=40samsung.com>
> ---
>  drivers/mmc/core/bus.c =7C 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
> 58a60afa650b..3623cc27a61c 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> =40=40 -348,7 +348,7 =40=40 int mmc_add_card(struct mmc_card *card)
>  			mmc_card_ddr52(card) ? =22DDR =22 : =22=22,
>  			type);
>  	=7D else =7B
> -		pr_info(=22%s: new %s%s%s%s%s%s card at address %04x=5Cn=22,
> +		pr_info(=22%s: new %s%s%s%s%s%s card at
> address %04x(clk %u)=5Cn=22,
>  			mmc_hostname(card->host),
>  			mmc_card_uhs(card) ? =22ultra high speed =22 :
>  			(mmc_card_hs(card) ? =22high speed =22 : =22=22), =40=40 -356,7
> +356,8 =40=40 int mmc_add_card(struct mmc_card *card)
>  			(mmc_card_hs200(card) ? =22HS200 =22 : =22=22),
>  			mmc_card_hs400es(card) ? =22Enhanced strobe =22 : =22=22,
>  			mmc_card_ddr52(card) ? =22DDR =22 : =22=22,
> -			uhs_bus_speed_mode, type, card->rca);
> +			uhs_bus_speed_mode, type, card->rca,
> +			card->host->ios.clock);
>  	=7D
>=20
>  =23ifdef CONFIG_DEBUG_FS
> --
> 2.29.0
Please give me any opinion or suggestion about this commit.
Normally, the SD card's bus speed depends on both host controller and inter=
nal PLL.
There are lots of host controller vendor in the market as well.
So, we can guess the exact clock speed from this commit.

