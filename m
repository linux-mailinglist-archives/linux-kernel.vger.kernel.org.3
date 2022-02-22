Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95964BFF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiBVQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiBVQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:45:38 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0366B16922D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:45:09 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220222164504epoutp025c3e10ebe2323438c1bbb9c67831e6e2~WKXbskVBG3082730827epoutp02k
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:45:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220222164504epoutp025c3e10ebe2323438c1bbb9c67831e6e2~WKXbskVBG3082730827epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645548304;
        bh=89A9xGsLZgggriJk0T8FetbTt2DC2jUjiKY7gpqWiH8=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=JzPCcG2L2l4Get1gftRaX02K9aewZfT4g8OkoFxSt27VqVeWRNRJNMPwBjouVatXP
         WirM16tM4z4xmfDW4O8q+MvlIqDr43+kuiUv6ZRLi0+03IrmeozZVhyFuyHi0AiWE+
         zGqbVivFPt/Qtoou0rPEGv/EVIB24fHksJCd5XGs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220222164503epcas5p292e11954f8f24846d2222f448e2a9bb2~WKXa2fdwu2938929389epcas5p2V;
        Tue, 22 Feb 2022 16:45:03 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4K34lZ6RM3z4x9Pp; Tue, 22 Feb
        2022 16:44:58 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.0A.05590.A0315126; Wed, 23 Feb 2022 01:44:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220222164457epcas5p1168ed8f6910091e9ce6f707b6e577853~WKXVciNC_2018820188epcas5p1h;
        Tue, 22 Feb 2022 16:44:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220222164457epsmtrp2a5a861bc93f96f3e1b508184d27678cd~WKXVaSC0y1935419354epsmtrp2M;
        Tue, 22 Feb 2022 16:44:57 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-22-6215130a9c79
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.34.29871.90315126; Wed, 23 Feb 2022 01:44:57 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220222164454epsmtip10d83608980c13a56c198afb6a07b76e9~WKXSaPM1t1245612456epsmtip1K;
        Tue, 22 Feb 2022 16:44:54 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Wei Xu'" <xuwei5@hisilicon.com>, "'Nishanth Menon'" <nm@ti.com>,
        "'Vignesh Raghavendra'" <vigneshr@ti.com>,
        "'Tero Kristo'" <kristo@kernel.org>,
        "'James E.J. Bottomley'" <jejb@linux.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Jan Kotas'" <jank@cadence.com>, "'Li Wei'" <liwei213@huawei.com>,
        "'Stanley Chu'" <stanley.chu@mediatek.com>,
        "'Yaniv Gardi'" <ygardi@codeaurora.org>,
        <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
In-Reply-To: <20220222145854.358646-10-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 09/15] scsi: ufs: deprecate 'freq-table-hz' property
Date:   Tue, 22 Feb 2022 22:14:53 +0530
Message-ID: <0c8b01d8280b$868abc20$93a03460$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLp66nIdBfWENW71H4Q0TOw7Swh8QIFI3oQAXS0vvaqYGzvQA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxT3u73cW5jVu6LyiVGbZmRDR2kHlAvC5tC4u7AZ1IRsmgkXuCld
        6cO2SGUmsMBQeVncI1LZeDg04zGhc9IVurJaxnSgYVBkhTkjMEUeoiROBshaLm789zvn/H7f
        75zz5XA5fCMeyJWr9IxWRWcIMT/0ytXg4BA///Up4vxCMXljeA4lx2ZdGPmrfQolK503fMii
        TjlZM3AFIS/OnMPJ5smnCGke7vchy+zdONlrrcDI3rweQJ69+SNCFt2yYORChROQFzufIeTE
        026E/MTmxMna738H5GL3NE6OdHzGIRe6S/CdG6iGU+MIZcotwaje0hKEGv6yGafynZM+lLnu
        FEYN9bdhlLGmHVDffZ1D5V+zo9SjUTdKdQ60INSMeQt1or0ISVhzUBGTztBpjFbAqFLVaXKV
        LFYYfyBpV1KEVCwJkUSRkUKBilYyscLd7ySE7JFneIYXCo7SGZmeVAKt0wlDX4/RqjP1jCBd
        rdPHChlNWoYmXCPS0UpdpkomUjH6aIlY/FqEh5isSHf+cBvRuDcZnH1NaC64EFAIfLmQCIe1
        g3fRQuDH5ROtABqvNvuwwWMAbw06loMnABbPjoPnkgVTJe7FfMIG4Ll2f5Y0BqDDMcvxFjAi
        BFrOF2DewjriHwx2PSxfKvgSb8OOBSPixf5EPLxvtyzlUSIITn88j3kxj4iCraddOItfhNfK
        R1Av5hBbYctkBYftQgBnRy942uN6DOLgT6dFLCUAjnU4ca8vJFp9Yem4FWX5u2GbY86Hxf7w
        QedlnMWBcGbKhnnfgYQCFlvD2PRxWPvVz8vSN2B7XwXqpXCIYHjJGsparYElcyMIq+TBkwV8
        lh0E86Zcy8pNsKyoaNmUgkMDk8v7dANYMeHGjUBgWjGkacWQphXTmP53rgJoHdjIaHRKGaOL
        0ISpmKz//jtVrTSDpdPYFm8Bd+9MixwA4QIHgFyOcB1vCPdP4fPS6GPZjFadpM3MYHQOEOHZ
        fBkncH2q2nNbKn2SJDxKHC6VSsOjwqQSYQDvuqyJ5hMyWs8oGEbDaJ/rEK5vYC5SL1e7eYu3
        7wXlBJ7YnySzBm+J1q79S6kx3hTZuhrRBpUB7Yw5Yt78VvbWkccNC/xDkebE0Ufj5fzsZ5Yz
        f88ellvW/jKo3NuEfxH4pJbnevlOI76j/ZLkzfPv9dCje444s+XJn4pfOsi1lv75wYbtr07N
        9xjvne1RBBxtbqqOEWVFZp/JuT/3rV3Qv7pqRliMRifbji2GGHrrpvw29iobWz/67RXtqr37
        cM4+e0JBwR+CLp51s3tifFBBhyaussbZXK5D0sa4dw1o/Q6DG6+Ch/fDjpq2vqxk7uX3P69+
        2EI9oO1lRxNPFu488E369sqoxQ/r8evzhpQ83uqx+uMvaKqFqC6dlmzjaHX0v/IVeaqjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7bCSnC6nsGiSwbwOLYtzj3+zWLz8eZXN
        4vT+dywW84+cY7XoPp5psejGNiaL5Z9ns1tsfPuDyWLT42usFhP3n2W3uLxrDpvF5eaLjBYz
        zu9jsui+voPN4u+cI4wWy4//Y7J48+Msk0Xr3iPsFku33mS0+H/2A7vFk6NTmC3+nu1ldxDz
        WNP5msljVkMvm8flvl4mj8dzN7J7tBx5y+qxaVUnm8eda3vYPCYsOsDosXlJvUfLyf0sHh+f
        3mLxOH5jO5PH501yHu0HupkC+KK4bFJSczLLUov07RK4Mo7svMdUcEu64siVDSwNjMvEuxg5
        OSQETCT+zprP3sXIxSEksJtR4sTn98wQCWmJ6xsnsEPYwhIr/z2HKnrOKLFixW5WkASbgK7E
        jsVtbCAJEYEedokXN76yQFRdY5RYNms1G0gVp4CnxNG/E5hAbGEBb4kX+3eArWARUJX40PgH
        rIZXwFJid/9VdghbUOLkzCdAgzg4mAX0JNo2MoKEmQXkJba/nQN1nYLEz6fLWEFKRAScJA72
        60GUiEu8PHqEfQKj0Cwkg2YhDJqFZNAsJB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXr
        JefnbmIEJwgtzR2M21d90DvEyMTBeIhRgoNZSYT3DrtwkhBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MQpIiySX2kyN+2DYsYBE87fhvzQKPy18b74cp
        q9u90S7QYOD7srOpcf7psoMiO47Ku6Wufq96Z9lHuSVOmz9etpqQLhOyampu0kaHRVOF9dwl
        WZgYpP5tkZr8y3rhUs7rmy69vDnL7M6n1U9uMbt7N8Xs+qKWLcu3W0R3UraujLCixTTHhX9V
        j/O7iwuZ+0R3TrPnvTjPvMme9eOux5XKERd+SP36s93qSda0/bVWZfKlH5k2cOyyirwlxZF9
        OjJo/WKHp29eFfjfCeJ6Jzc5aeXy5Nkr3qVOX1211CzAsOaF+2ShFwVpbj5XHeLmq8+WnSzf
        JPUm++/fbyVnDgX6TJbf9f5F12b2vOMVa9MnK7EUZyQaajEXFScCACBkeAF/AwAA
X-CMS-MailID: 20220222164457epcas5p1168ed8f6910091e9ce6f707b6e577853
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220222150007epcas5p22f05e6c8e80a5ad18a9528cd0ead865d
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
        <CGME20220222150007epcas5p22f05e6c8e80a5ad18a9528cd0ead865d@epcas5p2.samsung.com>
        <20220222145854.358646-10-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Tuesday, February 22, 2022 8:29 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>; Avri Altman
><avri.altman@wdc.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski@canonical.com>; Andy Gross
><agross@kernel.org>; Bjorn Andersson <bjorn.andersson@linaro.org>; Wei
>Xu <xuwei5@hisilicon.com>; Nishanth Menon <nm@ti.com>; Vignesh
>Raghavendra <vigneshr@ti.com>; Tero Kristo <kristo@kernel.org>; James E.J.
>Bottomley <jejb@linux.ibm.com>; Martin K. Petersen
><martin.petersen@oracle.com>; Jan Kotas <jank@cadence.com>; Li Wei
><liwei213@huawei.com>; Stanley Chu <stanley.chu@mediatek.com>; Yaniv
>Gardi <ygardi@codeaurora.org>; linux-scsi@vger.kernel.org;
>devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>msm@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-
>soc@vger.kernel.org; linux-mediatek@lists.infradead.org
>Subject: [PATCH v2 09/15] scsi: ufs: deprecate 'freq-table-hz' property
>
>The 'freq-table-hz' is not correct in DT schema, because '-hz' suffix
defines
>uint32 type, not an array.  Therefore deprecate 'freq-table-hz'
>and use 'freq-table' instead.
>
May be once all the dts change migrate to using 'freq-table', just remove
'freq-table-hz' from driver.

>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---
> drivers/scsi/ufs/ufshcd-pltfrm.c | 21 +++++++++++++--------
> 1 file changed, 13 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c
b/drivers/scsi/ufs/ufshcd-pltfrm.c
>index 87975d1a21c8..2b192477d158 100644
>--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
>+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
>@@ -47,8 +47,9 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
> 	if (cnt <= 0)
> 		goto out;
>
>-	if (!of_get_property(np, "freq-table-hz", &len)) {
>-		dev_info(dev, "freq-table-hz property not specified\n");
>+	if (!of_get_property(np, "freq-table", &len) ||
>+	    !of_get_property(np, "freq-table-hz", &len)) {
>+		dev_info(dev, "freq-table property not specified\n");
> 		goto out;
> 	}
>
>@@ -57,7 +58,7 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>
> 	sz = len / sizeof(*clkfreq);
> 	if (sz != 2 * cnt) {
>-		dev_err(dev, "%s len mismatch\n", "freq-table-hz");
>+		dev_err(dev, "%s len mismatch\n", "freq-table");
> 		ret = -EINVAL;
> 		goto out;
> 	}
>@@ -69,12 +70,16 @@ static int ufshcd_parse_clock_info(struct ufs_hba
>*hba)
> 		goto out;
> 	}
>
>-	ret = of_property_read_u32_array(np, "freq-table-hz",
>+	ret = of_property_read_u32_array(np, "freq-table",
> 			clkfreq, sz);
> 	if (ret && (ret != -EINVAL)) {
>-		dev_err(dev, "%s: error reading array %d\n",
>-				"freq-table-hz", ret);
>-		return ret;
>+		ret = of_property_read_u32_array(np, "freq-table-hz",
>+						 clkfreq, sz);
>+		if (ret && (ret != -EINVAL)) {
>+			dev_err(dev, "%s: error reading array %d\n",
>+				"freq-table", ret);
>+			return ret;
>+		}
> 	}
>
> 	for (i = 0; i < sz; i += 2) {
>@@ -99,7 +104,7 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>
> 		if (!strcmp(name, "ref_clk"))
> 			clki->keep_link_active = true;
>-		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table-
>hz",
>+		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table",
> 				clki->min_freq, clki->max_freq, clki->name);
> 		list_add_tail(&clki->list, &hba->clk_list_head);
> 	}
>--
>2.32.0


