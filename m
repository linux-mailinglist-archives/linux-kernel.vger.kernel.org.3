Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF052D745
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbiESPTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbiESPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:19:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2012.outbound.protection.outlook.com [40.92.52.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08344A5A8E;
        Thu, 19 May 2022 08:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVokG0O1O/roc4o0WKJPJdIswqCU/tKVUnbpe3LL0P/E9ANi0TqIf6nmVHa6BDQRBZZ0EvRoENH5EQh+ej4SNGgM67Hj7T6rrxjaSPUAp789SvSM07H7yagIcId16PzAEopu/BoV3h0CXKrql0amqGjnskmG1LniaYYzyCzezNZyvurqBU551a5Lg5gFud7cAAHoMEkzxcKtTcJBZDuOlZBZsa+wPdBvtzMIzoWiHsDEkxjHcwXxlngLGu0UpWZ+pDqgGKewnCX35NEIHCUfBswIMBUIlhSPjfrYUAarzvk9HM0qkvVjJw0tsEy4ivADKS06kS73KsoA9uCI6n3+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MUtIwCIPCoUNX+jtSOXjl/cJyjV632lf4bjJ7WHQvE=;
 b=f2MzDtRiyvL5raEirw3Bpn/2cKXBvyigNIcf7pyYt6L0lddcEPxgHAXsE6FloWSAlptPFkYIwhfbbFeTWzeU3s6sWwaE0aJfB1Lba/DEdz/pS5lAd29NywIX0inb5ubUz9m9nFcrhBQzQhu5d7DSRYx/rhLKrOTS2en57WLCWCF1xr+mAAJS69eiQJZOHx1X9st7A0WJ2BwAC/G9ze+/PIB7PFpAD/qB2hQBLOTRVzR2fTtkKJndLiaDUxSx5o9nY/ekUJixw5oR1hyI9T/0QNRko6A6Pw8CEK54cUJ7sTxvru+z+O6uLxWoNDmhtBiV1JECupeof5x0nWJuYZI3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MUtIwCIPCoUNX+jtSOXjl/cJyjV632lf4bjJ7WHQvE=;
 b=jKCVvCg6Co/OA+6uf2RTu7m20KA78CUudenimkPgt1U382svvssvUkVapVgXpIX7t/ztmLuZUHBmSMub5KTtu0DLwkc+pnC5dkC7qRV61FsJsUiD1Ygf8dNPhkuVhHl3BinTkFE1KF+ZKjAmcKo34LCkwI4Kth1C02mnvaQqqX+xZ12VL9pz9kimXxeMG9LK4Lkw8f38lZfF/JbjeJzIV4OrBHf0TbZaz47JK69QjlZ+F7h4JfmN/W4At6PC+M2Bq3xNw79NuxbRUd5vjMZ4PmR12Wj48Va1Rmb+zKlxsmRFUooGvMPsvjTFmOYyWoovXXYlL+1pzsbj5xu/gAEtJw==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by PSBPR01MB3733.apcprd01.prod.exchangelabs.com
 (2603:1096:301:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 15:18:59 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 15:18:59 +0000
Message-ID: <HK0PR01MB280126E9C323C8B4D0E60442F8D09@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Subject: [PATCH 2/3] USB / dwc3: Fix a repeated word in ep0.c
From:   Kushagra Verma <kushagra765@outlook.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 20:48:55 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
X-TMN:  [NxpPHcTLh30ANmkkINWqRtAj5a+eDemH04Ve7zpnvBXmPlyZz/cDimdgnFSztOyDFXlGX9sOK2c=]
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <798972dfe2868e4746bbe9cc0b4f47a44bfe193e.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83906c1c-fe5a-4654-779b-08da39aae623
X-MS-TrafficTypeDiagnostic: PSBPR01MB3733:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t31PCOkEgYr26llSHXL9aPU578mgHGTdNnrVFdsw1LJEMiZVq4D3PUuhOk80oVqpOVTfbbRGmEpR+gebcbt5w6z37JZX5FJemcBxve28tTV7YvxxoQoTQtR36JJfPEhhXk4CvlOOHRxN9Y8FM8YCwvUZ2UTsC2uTq1QnuSc3FCBt/ianYEM1z537F1zM84o3Iva1O7y+yohue8h2uPZMtAXVI6vJCRhpZ5aPaIGWMuHW3FMFZhs9IFSUs9IMc3rfvO0DOtVrE5PcuEynEvF0HXrvkFjCND/JetqFUc1LqgHfqcC9vNjEuwGoD0ARZ/FbTfLBVFPVGPg4l2ZDVY4v24XC6mrVcs1k2Z8TtgC0UxQC0pUT7OzxywH40Y1GmisoMZJc8kVaxqJTXPF0EXn8+VsAG06+dei4s/xHPPhimclA+h22qn4X6XH+MdHl+YKr3jLI+8FPzA+Om7oIW4vhn/dxwK2XMGeSAJVXTjMaszIa8Zj5DLSFhlfi/q8rQ1CQX7Bo1aa2+X/HvkrU/LfkZba/VABwLWEWhxN9bfGRYTWzHqbtEYv/vEFQeDmAI+mgBAtAybwV/2b77cwvPcjSXA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVFCMUtRTVI0SG5YTjZyNUxrcjAvTHJ2Y1hJT1VITXRBYTVnKzA5bVZlZTFh?=
 =?utf-8?B?SHZSSWE1TlNrVXhnM1FrMDFUd0NYTkUxb0xQNXlYeXdER0h0VjFRcGxLNk9s?=
 =?utf-8?B?V2U0eFY1MGVLTlNmZS8wZVl2MVRLWlM1NWlZVXEwTGQ4RnIwM2F1bGp0Y0Ez?=
 =?utf-8?B?M1BCRGJLWGlCSkEzbjFHNnp6Y1p1czZhYkxYQVhSREIvMHI2a0cxSW8zTHJ6?=
 =?utf-8?B?ZUZwZmlYeHZwYVQrNi9PSGw4aHBsaU1kRlhkVUpTSnAwSm9sU3ZtQ01xYTda?=
 =?utf-8?B?VzhpcVVheVV6dkRiRHRiWUJUdml1WnhRY0lZeklMZ0hsV045aExJSkJmdDBB?=
 =?utf-8?B?RmtLdkZVRnlDYnZYVTJTNU5ra2htNTVTcnh6LzlneUttd1F2Z1ljUUc4SkVw?=
 =?utf-8?B?b2xnUDRDUnk1RjR4NkFLOWtwZnN5YmF5S21hRGx6ZXpHUjBJRXQrSnJRTS80?=
 =?utf-8?B?ajVxT1Q4blIwd2podFVPRjlISkZ0U0FEbXVZbjBpbFI1SE5RZUY1NjZQVkc2?=
 =?utf-8?B?dTY1WkpYc2ExZHFqT1VHbHRWNE12Rk1BY3NmRCt4bXBzVERBSlVVSGV0NlhB?=
 =?utf-8?B?cUZFQmRLaEpMUGMwTWRwK215WUc3d0ZTUmdwUjhhU21td2NkRDFKL0M4RTdU?=
 =?utf-8?B?eThQTk5lVGdPOFIyTzhzM295NXBPb1gzelFDR2pyVUdxVUFXSURZS2lrT1JG?=
 =?utf-8?B?ajNoRlZFakN5R01KQlhQelloKzdHT2VzNHVwOU94Nm1xaVo3R2dSWW5DQ1Z2?=
 =?utf-8?B?dUI1VysxUzZDSGtSZXhhNlA1YkFHWi9CeFZZUUNxQkF6NTg0NFlMK0ZZS2xv?=
 =?utf-8?B?V1Q0dFNWbmdQQzBYd1lmMlZzY0xucUVROUtHSHVWZjlFU1IxcHBLSDJwS2Nm?=
 =?utf-8?B?YnZIbWlvQURqRTcwTXhTZEh5bHI2Z3lNOE5JUjI2TWx6MnF3U2t4bGVnVGk1?=
 =?utf-8?B?OFc1TG1CYUFCdit1aGFpcmFwdUg3b0xqTFVLbksrejByeUE4RlRCamdYYUlz?=
 =?utf-8?B?Tk1SSjFza2pHQVdGRmg3Vjh2SFlqczdBRTZCZkJlUmRyV1lya0tZdk91N3VW?=
 =?utf-8?B?V3pnT08weTN3S1lBcmM2STR2aFVqY2xIaDhxcFhLVzdxV0NnYVZTWnR6Rlhu?=
 =?utf-8?B?QWVLSzVvTWkvdVZUNVBKRXZxZnNwTU00U0JiY3FZRUI3Ym8ybnRYRE9zaWdx?=
 =?utf-8?B?VlNlVDBqYzFlRml3ODNlUloyNWswZC9QVE1zbmt4TmZQejdWVkV1cG5VRWt2?=
 =?utf-8?B?M0VkdzRRTnJNdHIxY29IRXdvczA3TTRlTmFvTWprcjVvTUwrTUJNbllxUG55?=
 =?utf-8?B?aGJ2dWpDYTVCVXlzaVJEV2srRkhZMW13bEV5d1piTXJwdkhmQWNUbTMyWDJu?=
 =?utf-8?B?bkN1T1JoZEJJMW55c2ljZHJiRDBleFNLSHhhTVB6cGhDNjlidlJYU3NOTnY2?=
 =?utf-8?B?VVVrVlpnczZRM2YrWW9xQ1puOTRGSG9QVElTNzN1UWRoM3l3MFNhOWlhRldP?=
 =?utf-8?B?RkxDV1pTTkVVNnphL2Z4MHBGdVNHU3NST1oxWlR5SUNZRVN0a0tBN3F5Tlhi?=
 =?utf-8?B?cXJzR2piZVFkVEZpN2FxZzIrRFB3U012QWc2V21ua1RhTHpleU0rdXdzOERw?=
 =?utf-8?B?Y2dGUDV0ei9JYzJHMlVjOGJ6MlZxY2tKRG1BRUFFUFVjYjlNRDU0aUVPeEh1?=
 =?utf-8?B?VkN0UzBRMjJWZEM3ZXYzQkoxekpUWE9ndmNWRTBFbjZzeHNBamxlVlBidk5D?=
 =?utf-8?B?Yi9hVkc3bTNLWVdKMTZTTjROYWRyYWFTWjFhSFVMc2J3Rkd4eHdqRXBmYkJ6?=
 =?utf-8?B?SWNzK3h0cEdVN1U0cTRtbWdzZEtrMTdrc0VUczJXYWVaQmtsSE9uSi9pQ2o5?=
 =?utf-8?B?cHhieUEyOEkrYURsd045dzU5Uld4aVdKcldFN0xGZ3k4R2V1clp4dHk1NEMw?=
 =?utf-8?B?NFdYeUFyUXc5bWQ4NjdybWRpakZ4QytHZmVpY2lBamI0U2lIekh0dHZlcW9h?=
 =?utf-8?B?djI4aERsY1pnem5VQ0ZHb0FlOFdLdXBYKzlsR3kwQ3dQaktXLzJBRWdzdEJm?=
 =?utf-8?Q?1cBsrk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83906c1c-fe5a-4654-779b-08da39aae623
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:18:59.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR01MB3733
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a repeated word checkpatch warning in ep0.c.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 6615f641b34f..25b16836164d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -473,7 +473,7 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 	case USB_DEVICE_REMOTE_WAKEUP:
 		break;
 	/*
-	 * 9.4.1 says only only for SS, in AddressState only for
+	 * 9.4.1 says only for SS, in AddressState only for
 	 * default control pipe
 	 */
 	case USB_DEVICE_U1_ENABLE:
--=20
2.36.1


