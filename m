Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25052A549
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349402AbiEQOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349369AbiEQOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:52:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2092.outbound.protection.outlook.com [40.92.53.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390491C938;
        Tue, 17 May 2022 07:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUthbXVfCpgJnM2t5ebc564BbudaqyzaHK4dA55PrmwvFYbbW3ZNES7OqETYwT3cT68GeLhSQAlklnYj38VuO4gHQ1xl0BAHWgJynDmhpVe7/0RfuRwjiccSpoGts3JGfhiyCl+Ssc21IrHWf2ig2e2gANd3tlAGDtORFi+oXLrE/jml5UteFQ3n+491qB+/9O5wHamOeFEHNlj1n28RiMB9t/FaHTC0tGzP6zHXuxsWLGD7SO+0ksMIshgVZM4Gzvx8Tup7nEbvOcvRXCGpTQ2U2RtlswsdKJOijKbvTsSymb/kDsIVXaxPXgVr4wGvplXoHHvfdCDdysHCj6PlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzdJcKQnDHRdoxS4xxSp6waXehKWM1lccJZFMNxaEKo=;
 b=evz9VFAr52U857/2EtS1eBeYUv23kGXFMO0Azuuh8ArH/M9LOnnFvpcSDcFlu/3HZDZ1H9d0DBF0mNisyofyNgA9n2UPsU52FvbDZfGan3Ig/nT6VOntw7zdMB4GNZni7tiYUG3IPHwZNTFpvwEWVVG3sHFYIZvXjws2EydmVHqwgn8vMM8BVnVyJoYECT1hIA55+YKmCM182/IXCMJWLpvi5/06XIYvJ3ou3vTm9ZOvT9S8a3I6VAI5SgTeiDgxnYMlIH2TBWPRC+2gOCSgIR+KnjJ8TxjC3FpAmgQQhKpWmowsRMOi1r6wCCbccEOMrKlCRQy8gj7jHAHRGEhCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzdJcKQnDHRdoxS4xxSp6waXehKWM1lccJZFMNxaEKo=;
 b=Fv7jC/qtlvPAHfXEap+ArmFgpCF9/APexvZ5fZOGv1kumz58wHds392AXKNKa8XLRdTx4awb/nJUkN4DMs5hAQWgDJF+PdQ/goAOawFvfVc4ctHauUNH1uJ4AHhn6xSvyN6k+P59GdHcMbYx6wHZmMN9MB2yFeXdrmaQ5FalVla5YGjxML4hPU1MeRLjvVDDlOaR4nbkH421joMdgW6B3FiiX+4PPbtHMSUSuerW7BaJfoE5WNP++R8tpUr+nzKjFpsGHpFrTCeuWy29mUetvDano+PEmrtVyGkDT4B3ZbUZch7kmFQ56rPSVRf3DYe6TTl52zXT1PxnE9sv+NiTuQ==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by HK2PR01MB3091.apcprd01.prod.exchangelabs.com
 (2603:1096:202:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 14:52:08 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 14:52:07 +0000
Message-ID: <HK0PR01MB280106E1D78EF51A5B8ED8BFF8CE9@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Subject: [PATCH] USB / dwc3: remove the use of -ENOSYS from core.c
From:   Kushagra Verma <kushagra765@outlook.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 May 2022 20:22:00 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
X-TMN:  [tQ+eBkWD1xFk7Zca0II0XH9use+8XikXrU8n4mOkzya74Mj5yLIR0WY9RbdHku/RlbRdw7HMhzs=]
X-ClientProxiedBy: PN0PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::9) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <dbe157d7f63997b7a38c5360904d36dcca9b0238.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1e5a1c2-9f08-4318-4fc1-08da3814d001
X-MS-TrafficTypeDiagnostic: HK2PR01MB3091:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ww2IhS5HoQrZY6vfpKm1Iwe/TorP31uZv9xL1eDjAk7TSXekDMGJLGeVa1nBzE9ENYUNGpEGa/6+duhgZlA0wvlpIzRnay3pxKV51hNoTgZG9xIbT1hxmxq3uMA5M5QSN5ey4rz/binnDenxbHCvPf8cz/nwuOHmaMOAp2C9X7jEU+0KBV7P7MgeIGPhE/BfK5sfuUs5OUPHaNyPIkGoSrLqW6key8D0Ue+JIW0pO6unrPh4hd20Y/47O+IPjrb4txQPHmxaWnHEoVt6mQm28qq591152HuoIkMNapXSfXhVyFC7ETg7HHtE8/L/204OsXAJ3aGM/z4Zr1nXqsFHo58aUvxM+BCkG7tNchG0U60UXW79CqFZ/CdxsJxMfZb0Z3pTnLVivSMjW1oVTF65NGGOyjAyBR1Z6NgEVqB0KqUAIMF6tPwzSwZV4k+LLijU3Ov6b2c+9goahzh0XWz4KNgdvK8W2322yqyHLAb18J5U/E4v4h33i32nhtsGXKuXCEDTJAKgSqHMgxpm7PTdjsFlw5hxYNCuqUChiTOKF5tdAJLAle5ASx/nSdrPDqDbmgYgFaYQKCVIgo4fZXe5YA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEEzMWNDMXBTRmhaMkZNR0dmUm13Nk1ZeTFVK0J5WWZ5TTNhbVBzM01zVkFl?=
 =?utf-8?B?SDF1b0NsRDJyTDVZT0YrbVp2ZnVLeHZRTEpkQmFPeTFnYlp3ZnRxOVlLUUl6?=
 =?utf-8?B?QXh0L1BzcWUvZGtFaDE4MmhpOEtTc0xtUFVwQUlhVEVySjFZdmdqN1hJQnlv?=
 =?utf-8?B?OUhUVHJBUi9vYjhRY0N6TDFQV2FrMkZvd3oxVzF5eUVySndwaFMrZ3BOYUdN?=
 =?utf-8?B?Y0lDV3RlMEZkeW9mTGJ1d0E2cEh1NSt0M3JkWG94ZWpqaHZTTWZqeTBWeHZN?=
 =?utf-8?B?ckE4OXlIMEZtV2FuMWNkUE5MY05UYlBzUUxVV3dCZGhld3oxQmJGcE0vVS9K?=
 =?utf-8?B?aGRadGtGZEtGZUt5MGtEdXhEWU1YMWFiRGU3WnZvRzVxZEpqMFdTMWlzTDVC?=
 =?utf-8?B?QytCc3RKRlZXRi96MzlGbURWSWdWbE01VG1FL1hIRStjOFZLeHlWQ0Y0M3ky?=
 =?utf-8?B?cGxqaE4rRS9MYUlidlcvSk9vRHc5dVN1M3A2Nnp1Rit4S2dwVVFhZ2Y3VDUw?=
 =?utf-8?B?Yk0zYlM2ZGU4ZjFQQ3FRa2lNVC8vK2ZqaHhiTC9EekNTdVpKNytUeU5VSmZE?=
 =?utf-8?B?QlZlQ3RrQ3paazBxM3hHZU8wTUduYjF3U0JHb1FON2o0U2pWWWUyQytIelV4?=
 =?utf-8?B?RXl6djFIMEhHK2dVdWVwMDR3STNiV3BISkp4NkdwUzVGZUVPSjY5Z2dwRk9y?=
 =?utf-8?B?S2lrYUV3L0VFYlJyMEVIa0RJYTY1WFNLN0N5QnBRd0kzOXhKUXJKNzE4UE0w?=
 =?utf-8?B?cW1ScS9RaDFQSVdPUG1JZFpSb1hkL3h3bFFVTHp5NW1Eb3dqRy9ydHQ2ZXJD?=
 =?utf-8?B?cldEeUFaU3JESmdKNkZwUmhsWWZ1bTBoY3FvMGs0eGt3Y1RTMmp2dzlEbWZZ?=
 =?utf-8?B?NHlKUGhsc1ZzSUd2M1ExbFJLQnBRVWpkd0NteVdTYVFYVEZRaXI3T0dIb3RQ?=
 =?utf-8?B?UHhWUnh1MnFmcGNvQUtmVU9aUk9zazZGbFloMmVzQkZvc1NPa3NrYllrQVZB?=
 =?utf-8?B?MWE4cnFQYzV0Wk9hWmErWG9CTklaOGFuVUJ5eWtrcDhyVERSUGZ6cUxyTXl6?=
 =?utf-8?B?dCtBcHNSLzVhT2pLZUtuaktwOURWeUMxZjJLZU1DTGZBSGFoUGRHa0xmYXBO?=
 =?utf-8?B?WnduWjc5cVA5cFpHU3hMNmMzNTZ4RWQyUlpZNVdxQzJiR0J0TmVISGpmMHBh?=
 =?utf-8?B?anpHamxoTlZmZlUxcTZaaFcxOW9WRzdKUlhpYTF5N0VRSHp4b2NKZm1jNUQ4?=
 =?utf-8?B?ajRKTnh0SDlCdFdvRmVrcjV0TExBbkQ1MVdvSWNaYUtVRXR5L2p6ZkZZOVUv?=
 =?utf-8?B?N29rekxHSTJRb3NONkUvNUEwck1NZEZFU0JOdkw3WUEzWUlkOGJQM1FpeHUw?=
 =?utf-8?B?dENJaVoySmNiekcvWThsYUVqSERmN1ZYMzBKTU9EMWZ3Z0hhcU04dFU2Z1or?=
 =?utf-8?B?T1JGd0xjOUx3WS9oa0V3VkVra21NbWNrQkRMaDlhbWJvYzNWeUV1WlJCR0Ft?=
 =?utf-8?B?bys1a0VmMmxGclo0RGRyTlRGVDUzbFhJdm1lYk5sN3BUOFZuVFFUaklHYU9R?=
 =?utf-8?B?clc2TXkwMzhDVExiWXNORFR4ZHJUMHNRc3BCMlBELzlybVgralZ4dVRmMW01?=
 =?utf-8?B?NE0zNjQrMHlnWGZYQlV6RGVWM0JBNlJNSXorZEs4RDFueVkycTNXN2poSk81?=
 =?utf-8?B?WkN6K3UwWFNjdVp3OENxNnFidUE5NUlZbUhjWEZ6d2pYYVlpSVd2bUNKZVJ1?=
 =?utf-8?B?TytmZ0llQTBxbW1MY1pFYXYrZ2hlQ3hnT3ZIc2RZVktpZHVaakp6cGwzQW1R?=
 =?utf-8?B?MnZkV0RLK1VaaUFiYjJPQ2dJWGN2UzZtcThWZ01FZmFqM3VybGZwZVdaNFY3?=
 =?utf-8?B?MTRNYjNIVGNLU2RyVFdjVmtUZm96MHNST3VQMXUrZ0FJVUJMU2xhZnFjSm90?=
 =?utf-8?B?bDR5eDd3ZCtDSGhDTlk0Zm9ZMldHSHpmcjBVV0pnS2tidWp4OXo4N0FvN3Zv?=
 =?utf-8?B?VXY0aXZwSjhJYVBOWmVaM2RlRHkzU05nVmhCYWJrbzFMTk5NMUcrR0RrNkpD?=
 =?utf-8?Q?l34u0z?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e5a1c2-9f08-4318-4fc1-08da3814d001
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 14:52:07.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3091
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the use of -ENOSYS as it is used when users try to call =
a
syscall that doesn't exist. So, we don't need to check if 'ret =3D=3D -ENOS=
YS'.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c78205c5e19f..3c1a877d5183 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1283,7 +1283,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	dwc->usb2_generic_phy =3D devm_phy_get(dev, "usb2-phy");
 	if (IS_ERR(dwc->usb2_generic_phy)) {
 		ret =3D PTR_ERR(dwc->usb2_generic_phy);
-		if (ret =3D=3D -ENOSYS || ret =3D=3D -ENODEV)
+		if (ret =3D=3D -ENODEV)
 			dwc->usb2_generic_phy =3D NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
@@ -1292,7 +1292,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	dwc->usb3_generic_phy =3D devm_phy_get(dev, "usb3-phy");
 	if (IS_ERR(dwc->usb3_generic_phy)) {
 		ret =3D PTR_ERR(dwc->usb3_generic_phy);
-		if (ret =3D=3D -ENOSYS || ret =3D=3D -ENODEV)
+		if (ret =3D=3D -ENODEV)
 			dwc->usb3_generic_phy =3D NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
--=20
2.36.1


