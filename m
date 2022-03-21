Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343294E2C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350404AbiCUPmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350396AbiCUPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:42:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0588174BAB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:40:41 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220321154037epoutp01cb75fd9f63713e24471324550836c1ce~eb53IIhkm1143611436epoutp01o
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:40:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220321154037epoutp01cb75fd9f63713e24471324550836c1ce~eb53IIhkm1143611436epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647877237;
        bh=H4iRtxP6C5+ANDGPqZZQuSeAZjGVh0tOl4ULnsl9gF4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ke6bNTERlh8w6kpV6W+/0kgFCjfd3XkfzYavaoLLpRyLtHeN04skK499xvd5SHCLo
         7VAdbwzpPVekCAw27eUi3CX1IjHCWWUoKkJJQtQMqSYM5hYipgxXMJxtBSZ8Cxzutc
         0KjlJRMtiC/TgXv59wBaWS0GoTc7GzBXFe0nF1AI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220321154035epcas5p4d39f34ca3d71432ae23165e81af8e0e6~eb51rIRzZ0673006730epcas5p4x;
        Mon, 21 Mar 2022 15:40:35 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KMf2k5MpQz4x9Pr; Mon, 21 Mar
        2022 15:40:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.BA.12523.E6C98326; Tue, 22 Mar 2022 00:40:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220321154030epcas5p4165b1c4926701e7489138fc879c1d153~eb5wsQJz80673006730epcas5p4v;
        Mon, 21 Mar 2022 15:40:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220321154030epsmtrp2cd58b657aabfffc0c1f1ba90deb3fa09~eb5wra_5M2183021830epsmtrp2o;
        Mon, 21 Mar 2022 15:40:30 +0000 (GMT)
X-AuditID: b6c32a4a-5a1ff700000030eb-d5-62389c6e571a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.E0.03370.D6C98326; Tue, 22 Mar 2022 00:40:30 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220321154028epsmtip27251cc62b8a265afbe155e8c0c0c9bdf~eb5u9bLVs2608826088epsmtip2V;
        Mon, 21 Mar 2022 15:40:28 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'James E.J. Bottomley'" <jejb@linux.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Amit Pundir'" <amit.pundir@linaro.org>,
        "'Luca Weiss'" <luca.weiss@fairphone.com>,
        "'Brian Masney'" <bmasney@redhat.com>
In-Reply-To: <20220321151853.24138-1-krzk@kernel.org>
Subject: RE: [PATCH v2] ufs: qcom: drop custom Android boot parameters
Date:   Mon, 21 Mar 2022 21:10:27 +0530
Message-ID: <004d01d83d39$fe7859c0$fb690d40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHm5rph065Vo85hpgWhCOFVvI1RFwHl86VRrJ12saA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmum7eHIskg7uTNCzOPf7NYvFhxSJG
        i5c/r7JZnN7/jsXixNkzLBaLbmxjsjh/fgO7xcT9Z9ktLu+aw2bRfX0Hm8XDFUYWy4//Y3Lg
        8WhresnqsWlVJ5vHnWt72DwmLDrA6PHx6S0Wj/f7rrJ5fN4k59F+oJspgCMq2yYjNTEltUgh
        NS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6FolhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG2yHNgpliFb/f
        LWNpYGwV7mLk5JAQMJFYMLmHqYuRi0NIYDejxIqrE5khnE+MEvPvPmOBcD4zSsz6tJQVpuXc
        7j5WiMQuRonXJz6zQTgvGSVO7TwMVsUmoCuxY3EbWEJE4DuTxNyeFrAWZoEGRonfLXeZQao4
        BUwlXh45AdYhLOAm0bZ4LhuIzSKgKtHWuheshlfAUuLJiflsELagxMmZT1hAbGYBeYntb+cw
        Q9ykIPHz6TKgORxA26wkTq1WhygRl3h59Ag7yF4JgSscEr9/HASrkRBwkThx3hGiVVji1fEt
        7BC2lMTnd3vZIEqyJXp2GUOEaySWzjvGAmHbSxy4MocFpIRZQFNi/S59iE18Er2/nzBBdPJK
        dLQJQVSrSjS/uwrVKS0xsbsbGoYeEqt2T2SawKg4C8lbs5C8NQvJ/bMQli1gZFnFKJlaUJyb
        nlpsWmCUl1oOj+7k/NxNjOCkrOW1g/Hhgw96hxiZOBgPMUpwMCuJ8C7+YJ4kxJuSWFmVWpQf
        X1Sak1p8iNEUGNYTmaVEk/OBeSGvJN7QxNLAxMzMzMTS2MxQSZz3dPqGRCGB9MSS1OzU1ILU
        Ipg+Jg5OqQamBJNlsj55O268SJka1i9wRX2SDYNHqBGnv3+l1F7F6ynvX29g+THr9YXJ7duS
        vSY1JFzQXB/2fmtNzTLfAL9lDKxTnjy9XcuxtTfAaV3EneBZFzaLx+ceiDubHDl93uG20qkF
        jZo8U5QikjS2y3kIz9t7eOGV9x6/GaSXr6vqqih+Gio+73oWk+B7pmOGjNddlrLJb55fWPu5
        ISv98C6pW4ExzyOKJeY5XbL6wM/3XUT29lYd+fvVXXdK97+R563XmvjxIZfvz6pLcv6FJtGB
        5zbLqzNPNUmLKvnvO/nJUbEfXpmCZS9Ot/NdXpHd3Xh69/KQhW6B4RG729c4zJM4wJhst2tP
        T3N1z7NWcz0lluKMREMt5qLiRAC+zJtXUwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvG7eHIskg1lvmSzOPf7NYvFhxSJG
        i5c/r7JZnN7/jsXixNkzLBaLbmxjsjh/fgO7xcT9Z9ktLu+aw2bRfX0Hm8XDFUYWy4//Y3Lg
        8WhresnqsWlVJ5vHnWt72DwmLDrA6PHx6S0Wj/f7rrJ5fN4k59F+oJspgCOKyyYlNSezLLVI
        3y6BK6PtkGbBTLGK3++WsTQwtgp3MXJySAiYSJzb3cfaxcjFISSwg1Fi75aHzBAJaYnrGyew
        Q9jCEiv/PWeHKHrOKLH442o2kASbgK7EjsVtbCAJEYG/TBLfL3eAVTELNDFKLG86zgLR0sYo
        sWjlDLAWTgFTiZdHTrCC2MICbhJti+eCxVkEVCXaWveC7eYVsJR4cmI+G4QtKHFy5hOgQRxA
        U/Uk2jYygoSZBeQltr+dA3WqgsTPp8tYQUpEBKwkTq1WhygRl3h59Aj7BEbhWUgGzUIYNAvJ
        oFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOTS2tHYx7Vn3QO8TIxMF4
        iFGCg1lJhHfxB/MkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
        ODilGphW1GX+MY0T2Jieeibr/KOUuOMJNrx2mj9fS3O2qlz9wL2mNe7P5tNOaWHTy4/ZygtM
        M1qutCvmtvJM87MHew0ndAvs23d1lX3U81Mm2TFrT7y5sbvp6f2jszq6W1Q2Pjh/8A2D95eD
        +9wn8RTIGTqsF5rOyP2vcsXCJy3MrGYzsuQeB9w/H/7j6OvGkBNJTS/LF+vyWvT0MG/XfOwY
        XlW+se6//J7G/Yw+O76d09wTL5q90FKqqLKHVbeivOXNm66GrYZfzge8XblGgeHo4eS+IIH5
        omoTzrVV5gYn9PnMr7coNwtTtNu1+VRPjcC8f+928Jdemr70b8jew9rsWraijyUf9m219fO2
        M77B9FyJpTgj0VCLuag4EQBrTr00PAMAAA==
X-CMS-MailID: 20220321154030epcas5p4165b1c4926701e7489138fc879c1d153
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321151913epcas5p45ad53c827e3c87633acd29443322d0b5
References: <CGME20220321151913epcas5p45ad53c827e3c87633acd29443322d0b5@epcas5p4.samsung.com>
        <20220321151853.24138-1-krzk@kernel.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
>Sent: Monday, March 21, 2022 8:49 PM
>To: Andy Gross <agross@kernel.org>; Bjorn Andersson
><bjorn.andersson@linaro.org>; Alim Akhtar <alim.akhtar@samsung.com>;
>Avri Altman <avri.altman@wdc.com>; James E.J. Bottomley
><jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>;
>linux-arm-msm@vger.kernel.org; linux-scsi@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzk@kernel.org>; Amit Pundir
><amit.pundir@linaro.org>; Luca Weiss <luca.weiss@fairphone.com>; Brian
>Masney <bmasney@redhat.com>
>Subject: [PATCH v2] ufs: qcom: drop custom Android boot parameters
>
>The QCOM UFS driver requires an androidboot.bootdevice command line
>argument matching the UFS device name.  If the name is different, it
refuses
>to probe.  This androidboot.bootdevice is provided by stock/vendor (from an
>Android-based device) bootloader.
>
>This does not make sense from Linux point of view.  Driver should be able
to
>boot regardless of bootloader.  Driver should not depend on some Android
>custom environment data.
>
>Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>Tested-by: Amit Pundir <amit.pundir@linaro.org>
>Tested-by: Luca Weiss <luca.weiss@fairphone.com>
>Reviewed-by: Brian Masney <bmasney@redhat.com>
>Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>---
>
>Changes since v1
>1. Fix commit msg typo (Alim).
>2. Add tags.
>
>See also:
>https://lore.kernel.org/linux-devicetree/f61abc2b-3ce8-7b1f-3d28-
>8a4a03ec58eb@kernel.org/T/#u
>---
> drivers/scsi/ufs/ufs-qcom.c | 15 ---------------
> 1 file changed, 15 deletions(-)
>
>diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index
>0d2e950d0865..586c0e567ff9 100644
>--- a/drivers/scsi/ufs/ufs-qcom.c
>+++ b/drivers/scsi/ufs/ufs-qcom.c
>@@ -957,18 +957,6 @@ static const struct reset_control_ops
>ufs_qcom_reset_ops = {
> 	.deassert = ufs_qcom_reset_deassert,
> };
>
>-#define	ANDROID_BOOT_DEV_MAX	30
>-static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
>-
>-#ifndef MODULE
>-static int __init get_android_boot_dev(char *str) -{
>-	strlcpy(android_boot_dev, str, ANDROID_BOOT_DEV_MAX);
>-	return 1;
>-}
>-__setup("androidboot.bootdevice=", get_android_boot_dev); -#endif
>-
> /**
>  * ufs_qcom_init - bind phy with controller
>  * @hba: host controller instance
>@@ -988,9 +976,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> 	struct resource *res;
> 	struct ufs_clk_info *clki;
>
>-	if (strlen(android_boot_dev) && strcmp(android_boot_dev,
>dev_name(dev)))
>-		return -ENODEV;
>-
> 	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
> 	if (!host) {
> 		err = -ENOMEM;
>--
>2.32.0


