Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7009D52CF14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiESJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiESJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:13:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2072.outbound.protection.outlook.com [40.92.52.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39B49C2DD;
        Thu, 19 May 2022 02:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc8w+MHAj/3WVhRtruIkR/FpUoxVO7kMxxUFqvrSCYLgKTtexWc6mMM/3pF9SHYR3AahaM7P1a4A4qFRQosZLFflMkLwIf5b8imUO37unZdzOfRT0Uc5DXvYS7y+tR2lXoo5+PYjIlJhiFa5nC1KLczoo2FA9+3e3F5BP2At6JNlE4yMaGmYqYLDGcv/tu9DnfmbmuFEMN+uo5mbnfVGS9saOhY8KCyUaJQSWxtj7fJ+JnYyfTa43SU2u0N4/FLrmBMZ2XkAa2NVfn90jS/85bhRv5yQUOmeCBkjJOKlXRfIs3wCATPSYElPSVV64LLTrEZMmQXlLaXJB8sItEnG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y91jKHRdcf/qxy+vZN6YQdvAga/P7j/fB6triLUFKro=;
 b=St8MJRYhqVf6SpOv/zAZxWYNWdtvK7Gegogvdxx9VNzEsLhG4si22ztnnKdrN+UdHBvm28LIAE6kC9+uxOcmXPQRoapMkzGM8ZvVnzpQtu/wSl+w+kcb1sRUGk1zB4UiMELp0f202RsP4i0ARf7jyx2icQmoMkhsQIdfnaeIOzIRlfknwsTQd40nbGrStPZJmN7UTn4aVXYYVAsqHIF6Bfr/Ip9xVGJEqDUWIu511leKM90khJIZHlb/z64gxBW852Ws8MAErPqFkrIqSruSITKJ+BKoIbB1u6A6lFIwQDlHpMhBs3ZUnwqMGoRDaY8B/BcnVQ7oX4AG5fGht/7ICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y91jKHRdcf/qxy+vZN6YQdvAga/P7j/fB6triLUFKro=;
 b=WoLcIRWnhYAG/hdPnqm3fEm12NXVO7+3WyOs8YCW8xRkQdfZleEN6DORu/mavEtohstAMnDxUOQ4QX40hfQ2A4kPTsnknCK0r9blYiUQxuH01hxNTuRf0PjOU8H63WNOuCTl624HUSd4ywWEgCeBk7I30ADf+Psw/bKA7DqadhznLMEu8nK4vhmmWAxHtzRicFxlmePP0FBqpdFT4JkLjY55rSbbrQZz1SQKZqZqSt/Rr87f/Bfj3SUfuLF7lU+QuFj40FeBTqWKOMQZdXADv9xciAaa6iv1ipBfQiDYhLmNEEDaZIuMQ4qtDRrDjzPQDtVjShy2pk450AsJn0BhFg==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by PS2PR01MB2327.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 09:12:40 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 09:12:40 +0000
Message-ID: <HK0PR01MB2801F1EE137B9A5196B225D1F8D09@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Subject: [PATCH] USB / image: Fix spacing issues in mdc800_endpoint_equals()
From:   Kushagra Verma <kushagra765@outlook.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 14:42:31 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
X-TMN:  [jYC5Kz3E54pDygz3BkTsL7ZelDS0Vg/BqGRevsQOK5/3fInd0TFUjt7S5Ch1egUSTwFrYs8vXcI=]
X-ClientProxiedBy: PN0PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::12) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <1937ee13a66a6aa656547526b8d44c75b580aa78.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb4182a9-2074-4de5-c6cc-08da3977b9ac
X-MS-TrafficTypeDiagnostic: PS2PR01MB2327:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pXIYQV9Gna2LCEIXHdSNmZTnyozydSNuUSo20TFBGlbX1idy/Ns59Xsqg2uJtyLklXibbqysPS5GxCd11cH9/iYmBFHAOg+gMuktHwuoOxJGL9G+Zhdzur2FYrrH9l/YMpoyBbUHM2MvvLtYm1qcVydD5UJ0qalxbuBNNCl6BgrPzgHpZUnqxlWMK4kR8KzyMoyNFlGZIfWsTSI7lq2Bo0fIEEG3W8JINYd1HlScgR/cireTb7tQ6z9OTS+EwIaZ6rkKJzxpAhXtW2wqnFC+g3/OoCeT9sy8gZYukhNDqdlsDmjJ3XfLvKJq0NSG5V9LvXr436g3lUGZtdYa+TKKhHBXrfuyk6AJ0fUzBWCVbyPTgNfoAN4D1b68GP9CRKgkQJbwf/5/YLGj15tUmJuHGfkj5UtR0mfr0hT1kkAqPrYu7U+F0pwB9rzyzAhd4mHT3IUJCP3yunZtvPnQXtE7ED4U1juYlCsIEUc98th649y8ryDB6Iq3uS9GyK6eb/SISOLRSlhOOTULly5t+YfGo58xSeOC0HQr8P7NBZez8g7jyuN3/7pC+GteizWmzVhyGnufCYCOvAXB9eXDCFZmQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHNLTENvNVNOVmJpNm0wVjVIak53eVJvMkhLRWdkbk1kYjJ1YldkbVJQSHI1?=
 =?utf-8?B?MVBudTBNelFRdnBUcVd4N0dQTDMwb3VPR3dYcWJvR1M2NUJOSXBDWjg5MzAy?=
 =?utf-8?B?UHR1WEJab1ppcUc4NFh3eUpvK3g1bHdSeDd1ZERzUzlvenc2K1E1Uk1WaDcz?=
 =?utf-8?B?NG5JdnRVVnN2UVU2U1hqY2RMcnc5L1Q0L3dMMldXK2VjYys3a1RhS1A3cnVt?=
 =?utf-8?B?MjdpVjUvM0RTcTJ2QlRXcFl6V0tUaXpSSkF2b0ZSK1lNWmFQa20xaTVVYmZ4?=
 =?utf-8?B?c0VCeExDa1BGVTQzaEkwb1kwUldBZmtiTmVjTFFJY2VNUHM3aGp6WXZ2eVRL?=
 =?utf-8?B?Z0JyL2p5cWFLSWZZRXJwemQ0WVNXaGdLVGlxdlYyOWVsSFNhemxJTlQ0NUsw?=
 =?utf-8?B?eGlLNWYxTEp0enhnbE9WMDR2NUNjRWdlekRSVXVhcjlRSEhTMkxISDBYckll?=
 =?utf-8?B?ZjloTWdzeFYwdm5XVzlYNVM2V0ZMK0pSMVJFTnhCK3EwTW9nbFg4blQ5SHNG?=
 =?utf-8?B?VFVsajRQNEpMckw1OVZwNUV1OW1zWUhjbmNreW44ZVEyNDc1MFJWaTY3S05H?=
 =?utf-8?B?UjRNRVg1WVJDOEdNdXloM2xPZy93MHF4R1ZmK1dTZnFla3VGZCtYci9RRTNv?=
 =?utf-8?B?dTRuL0FHRjRpVVRKbHd6dUtrZjdPTEdXcXZvanV3Z3RJLzhGd0Z4dmlORW43?=
 =?utf-8?B?b0p6UFZzME8wbFpYN3Nza0QyMlE2L2tqWG5ES2l1MDQ4blgzaXgvTzBUZGE2?=
 =?utf-8?B?azlWTCs4Um1lbXR4empXOExRTnlTMEErNWNxc0VtOVdQOGhnWWhUQ1pnSE5n?=
 =?utf-8?B?SlBsVUdLOVNHSjdkS0NDbVFtdXpSbjliWUE0MFVjQnc5ZkxaRGVQbTFWRFBJ?=
 =?utf-8?B?UkN1ZTFTQ3lrS3JRaUdkSmR4NG5ueUEzVmNPbTNCa1ZINC9iNlh3NHcrdUVx?=
 =?utf-8?B?TUk2bWh3eDZjaGtTbmY3TU8rbHRtdmNMaFNQUXY3UlJRNUNHWHRrWHR0RE5a?=
 =?utf-8?B?WGwyand1T0Nja0NPWFI1NTRwckU3WnhjT21sbWFOa2JmTnFEVXRRVVpnMGh6?=
 =?utf-8?B?cTRYRUZTbkg5VHE3L1lFTThFc056aHQ4Um1IV2VRTFN2NGpOenpUbWFXenZ0?=
 =?utf-8?B?aktjMzF0aWFnbS9ndlNBS3liczY5Nm1LK1VSVTN4d0o1Z203VEJORDgwVkFl?=
 =?utf-8?B?ejFqemtOTUJGUStKTjdqK25UVURWMTZ0ZTlWVWZpU3pzSTgrYUNlOWZleTh5?=
 =?utf-8?B?Ny9CZE5vTHVJZG8vajNtYjY0ZnlGSUlTVzY2Q1BJd0Q0S2U4RTVOdW5rZkR4?=
 =?utf-8?B?RjV6SEZwb2ZLZXl1VXNQU20vWkhQQlIwcFNXaEQ5dTVlaTZSSjNORmNGajZy?=
 =?utf-8?B?Wm9sS29FNVh6WXVzQ1c1TUw0WlNZNW5MaDFQUE1PdDcwY2JLWjBKQzNqMW03?=
 =?utf-8?B?VCsvbmUwcGZvakFIWlJWUUlnM3FTQm9zU2ZEYllLQjZwN3JialBOS1ZPNkR2?=
 =?utf-8?B?SEQzUFdQQWZvMFhPRERjY3YydmQ2eUlld0dsNmo3REF0elUrNFVUYS9McDE2?=
 =?utf-8?B?SUZhdS85Q2czYWtrRXcyTzlnVnR3OTh4bk5wY2c0dEFYaFRxYTJvbHJNanpN?=
 =?utf-8?B?TnBlb0s2TEpKWGRlMld1VEdxZlVvbllybS85b284MGxrRWd0bjlTR2JsQUJo?=
 =?utf-8?B?WUtlc2M5MDc3NXdsb25ORXluQXluNFNaa1pjY0JlWlUyUDg0d2dYa3Z0TElG?=
 =?utf-8?B?a2lKQzh1aTNzYm9Tam1BUFBLcEpCZElkcnBlN1p4SERmMDZZeERhRENJWDR1?=
 =?utf-8?B?THVZME83emxFZlFhSUNucFd5MFRkY0NlZDlJbVB5NkFHa3NrSUtBUlFIeXh1?=
 =?utf-8?B?S3QzZndSdlhTb0NFZS9MM2d0WVE2aU5LNHZkSHMwWE5zWU1lUVREcFVuVUZP?=
 =?utf-8?B?OXNXanhpVVkxMUF3SFVOalpUS3dWNXpZV3dlNEYrYkxaVjNCK2o1Y0lRZVo2?=
 =?utf-8?B?RUQzMDNMdFFRUyt0OWFSWEhjeWZjWkhNOXlubHZXc2Z2QkhUVVJGMzNab3Bz?=
 =?utf-8?Q?2ijNSG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4182a9-2074-4de5-c6cc-08da3977b9ac
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 09:12:40.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR01MB2327
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following spacing issues in mdc800_endpoint_equals():
	1. (Removed) Space between function name and opening parenthesis.
	2. (Removed) Space between variable and opening and closing
            parenthesis in the return statement.
	3. (Added) Space between 2 function arguments.

This fixes multiple checkpatch warnings for this function.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/image/mdc800.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/image/mdc800.c b/drivers/usb/image/mdc800.c
index fc0e22cc6fda..dc03e0e54fe0 100644
--- a/drivers/usb/image/mdc800.c
+++ b/drivers/usb/image/mdc800.c
@@ -220,12 +220,12 @@ static struct mdc800_data* mdc800;
 	The USB Part of the driver
 **************************************************************************=
**/
=20
-static int mdc800_endpoint_equals (struct usb_endpoint_descriptor *a,struc=
t usb_endpoint_descriptor *b)
+static int mdc800_endpoint_equals(struct usb_endpoint_descriptor *a, struc=
t usb_endpoint_descriptor *b)
 {
 	return (
-		   ( a->bEndpointAddress =3D=3D b->bEndpointAddress )
-		&& ( a->bmAttributes     =3D=3D b->bmAttributes     )
-		&& ( a->wMaxPacketSize   =3D=3D b->wMaxPacketSize   )
+		   (a->bEndpointAddress =3D=3D b->bEndpointAddress)
+		&& (a->bmAttributes     =3D=3D b->bmAttributes)
+		&& (a->wMaxPacketSize   =3D=3D b->wMaxPacketSize)
 	);
 }
=20
--=20
2.36.1


