Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9E5AE89A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiIFMme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiIFMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:42:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2025.outbound.protection.outlook.com [40.92.23.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D852B24C;
        Tue,  6 Sep 2022 05:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuonpoPXDtoaXGnYuziM/scEg7WAyiOQ1yD1egH/B1C6VGW1rUo5FIbcwACbxSVcchzKVz3AiqUfQYOfbVlbe1UG0He14iat3Z8nv2GtI4uYJI3+sNVbstNqjITJ1Cp/IHoH5tRohox1IIH8CC7DTqTscp9KMjT6HCmXqdJwGlvooOKN01cw+zl5TRqHvUnw4mVA/gLi1C4UO4iHALywR1lVNxqU3lxCgraYX+Y0RAgTSvzeyJR1miMP222eB08E9NeNLkCz7Dg0pESz9PkJ/j5+blKfYkdrmIH79d4vlkMM+Q80hUiPdMSTrzr2pTNlVxrrW4Qoc8KHd8PhY/lPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7pkm4mBFHOPPPmNyYB2X447q8oqVqHuE/+nMqyxagw=;
 b=TRNzgJ9E0bcB6y80W1BRnGJR0FP+i3Yv3AOfHuIlPC8jRRU7p7H9KqGjgX7sa26NIuoUMGTl+SI1U+fYxMxr7RGo+jOmT/DV3I5hjIXSXMZyh+oGkcayc+1QL0HrOZhGU4cgTELLmpYd+sGQtD7sD9Y5+NHgY+2dpMpkZJgFjOeG2/smUpGwZaxBYAVvzor0u77wxNdV0AtGoE9jdrdNJp+BEWcAGiSrBKtP/qdYP5dZKZkGI5Bd63WDUL6ehLJGg6daqR04hHQuOZ+p6qesR7LXaz9ZFRjuRdJ9zFITQW+FRdlkMwmCu0bwuh4LNsKgeFbGU8GeeYb/YnJ5waFRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7pkm4mBFHOPPPmNyYB2X447q8oqVqHuE/+nMqyxagw=;
 b=IAon1a82Vwbd/3vX+GlpPwPSie6+2b0RjaWzYGnALw9GNGrMHizAoP7iZINUJSJ7Yo7egONiCnLHWNhP7fdjzJVKEPCxyEtk0MWsKwXogb6l/SR/7ET5GrsxWM3zmQvlT/Bw1bTnM4sAdppffOZIAkBD/0NBy5eDj71N1pTJuZI3NVYIAozJNb8Nl5XAewbYbmtzRXu6WZPM5/Vom1W9vdrOMqF9wzPIBJfUEn+BdqWii5FY6+cv0oL6nwDGxZ9rqpfZoA2pi/1jJViJrrDiRF0ZRgfwsZjhSvUAKVsuhZGjDMZcMEHUejPgb9CiTnrwXeCkVwKvZNMEv5+IIrcj0A==
Received: from SJ0PR20MB4337.namprd20.prod.outlook.com (2603:10b6:a03:427::7)
 by MW3PR20MB3356.namprd20.prod.outlook.com (2603:10b6:303:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 12:42:30 +0000
Received: from SJ0PR20MB4337.namprd20.prod.outlook.com
 ([fe80::89f6:e10e:9818:dec2]) by SJ0PR20MB4337.namprd20.prod.outlook.com
 ([fe80::89f6:e10e:9818:dec2%4]) with mapi id 15.20.5588.012; Tue, 6 Sep 2022
 12:42:30 +0000
From:   Whye <whye314@outlook.com>
To:     alexs@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Whye <whye314@outlook.com>
Subject: [PATCH] docs: zh_CN: Fix typo in process/howto.rst
Date:   Tue,  6 Sep 2022 05:42:15 -0700
Message-ID: <SJ0PR20MB433741383E64BA84B372BE0DE97E9@SJ0PR20MB4337.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [sl6Xo3aXEEm9A5oThNB5lXyB9zMz1smK]
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To SJ0PR20MB4337.namprd20.prod.outlook.com
 (2603:10b6:a03:427::7)
X-Microsoft-Original-Message-ID: <20220906124215.9168-1-whye314@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0198628c-d410-4412-57ed-08da900542ed
X-MS-Exchange-SLBlob-MailProps: /UmSaZDmfYBt0ihbs49qwhvz49CYdyimtV/nMFGef1GcW2mtoe54Am2bEKqo8GzrCBIrXSuin3neozhquhSgQzHyigeS8vsHkVj5JCpCe1xV1E7gKPYv+VouK8/FuuFK4fhCJRDh4B7XkDqTFOWL+ppypC3/pmdH50HRhogaMObEG454bf5NyZggxICUy4nI7xaw0wtFNCbhwtKYqFjw2Y8AvqrYVPU0+hQzSlASgZsTE4lVxuPLdBQ5N0OHIxBuGoZMSu6EMd7+xxPuBNgBnU2VhiA/FjkU160jcW/GlnMsZipaVUQg0X9Eh8WMFK5GO9hsxcTX1KwurcFIf2OpQtAgHziXCuK2TcF+d9XKKrayf4NKhBiHb1+FR8Z81LmzgcPtuYBxfajPMniInhqyrjKVeC6JLguCWVj07s25mGim93CW5D6xRD76PG6kZNnJA/0t780Nc50yJc0IAog5Xs+nYgLqwhdu6AoW9R+1lYqMlvSIpD54KyC85hCUmUuqPsifnHq/H8GWsxFtHyUiC24JO2nAlfJjCBzdWYhwXfOCiQSZUgzDH7wkm4m8hyGaRGYTLKg9xeXjmzCl3I6xURXAlujHqnh/Ji3fA8OU5+G0FajrlSfb3eQr+/L/JfgE83j4PFTrqcKUray9kozzqZvDVJHz1aYayu/TQksauRzgUVGM/N1HKZaIGVw40lxF3fBBBYGz437eZHUbu5LoHThX3Sjw7lypfY9pI76oMYWSG5elqN1h2v73pZryryTw1d+aYxxrfkAPwABQhuhlVIyMXjlKFdyaSE9YmvFhzDAkmT9XDv0tL2NDOLusXCNT0LKc0k48V07Z3voGqis55w==
X-MS-TrafficTypeDiagnostic: MW3PR20MB3356:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPBaWvjvMtF624anC5TdXmDCZHZvZlMlln+WzgAoG7ZugzleEUSUp6VCPCu5cnvfmWLNRkUnmmQS7bmI6bHNDvvZuq2rBSiG8/O+rJJpgx5RQGySVnXZ6duYezVmrMX5Jof7UnO3zmPzFHBTVIjImCMnEVhmm3waHVcr+5sn1i2cfMY1QNs0shjbLdYwhmaeH/9T0NbPviyViwZD45cCjYCCn4eYovjKON58YpLyrZhkS7ZdwLdSs45cHgllGOpMQMKzmzaVhE4z732y0gnnaBcfjt2ivo87VY97r1dXaPKCwkh3OMz1LDMeIZwub+a0NkZKK0MKQnXPgflALJvYeJR0xtZAbsVkDRISHgBJabtbx+2UphrkmKQo+iF90iIG1gmWcRkP/Ns6i+gLE2Qze8Uovy+H1GiFdRh9nOS7Y4nXZ50G96wQfzX1ma/j4c1BrP4PDNzTADaJwcbV26Fadbt2pYegioH8aFUmEDL1VnRfcMBDVcjIKp7HnDXwDSA3ohtYa+ZwgjiLh/TfYjX2C0XD41scKSaIHAk/dbcqD1BZoJ+5b0Bv0FKFgiH8IrQASQGhqYFyIvIM00I52ZH1zqtPCtXvMDB5MSAJixko4W99NqwRcv9wrjFCq4uvmZIx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU10SVpTQTc0TlFFT2FBc25xdkZSRE1VSm1USndTN1hsTWhLWEEvWVNMVHZO?=
 =?utf-8?B?RXBLelh0ZUQ5SGtQajhjUEVRRHZDaWFObWlnNHRudlU4YjlDcDU3T1JtRXZv?=
 =?utf-8?B?V1YzSXc2amFwb3BYbGgvMGlZME15M01lY3lvSCtQTEhVdm1mNjVzUXE2LzJO?=
 =?utf-8?B?cmZudU92WHdnaHpHUHlGQmNhdnJQeUpJK0ZvWjFQbWlTSTJYaGVnY0pYcXpn?=
 =?utf-8?B?OFFBNkhhd2xjR1pQREFvYnpaKzVCNXorcElPeXlCRWZHaHM1UFV4YlREWDMr?=
 =?utf-8?B?dEtMQ2UrWGtlNmhVb20yZGd0SnBTRFJ2TlUwcEVBc08vYXhnMGdsWVQxODVh?=
 =?utf-8?B?NzFUL3FvMWFCVlNadXNOdzFpZUl2Vll4NHlVc1R4UVNZc3UyT00yajduQ1Ft?=
 =?utf-8?B?RUd5Wno5Q3AwZ280clJsNWYzb3hYa2ZNU0VuMUUxNU5kZ3Q3UkFtYkwrTldV?=
 =?utf-8?B?bmE0RTdFR2wvUldoeWw4am5La3BHZEZCb0NBNERlQmRXbmVvSU4wOXpJeTdt?=
 =?utf-8?B?aU5XZlFHekJEVGQ3amxxK0luY0thT1JYZmd4WGx3eTJhZEl4Z2FVZTdob1Na?=
 =?utf-8?B?bzRlQ24raWpvRW43OVZ5clRRY0tEYkJnVGFDaWJzbXgrclV5bzQzRlBRQkNq?=
 =?utf-8?B?M0FhTDN4dHNCWDVnVUxLMTRjYUQvdUdDUWQ4cHl2TTM0QVcrMWtLOE40K1k0?=
 =?utf-8?B?c1I4L1c1Sys3V29JM1Ywa0dQMnUxbmxoWGZVS2NsdkJPTjZzb1FJaFlLeGpz?=
 =?utf-8?B?UzM1ZWxmcUFONUplS1FrTHR1SkphNk1wV1U5SU92WSszT0hodXNpQVVocXl1?=
 =?utf-8?B?d3RZS0pvWFFvcmU1RStvSENhdHZweWFCUEZlVjRTdHZWNUdGNFQza3d1VlRk?=
 =?utf-8?B?NlBaWmVDVG94WHpyNE53eDNmUDduUVBJTHRqaWw1c1hwejNPSEs4VVVvdlRL?=
 =?utf-8?B?WDFMcUxkanRSclBOeEtmN0hTb29kM2tEbXE1ZEIwM01Jek9NUUsxZndlY0pp?=
 =?utf-8?B?RTNlRGtnSW0yUS90ZU5TRmJ2elZzM1BvQmlXem1ZdEdtU05NR1UwVkdyaTVi?=
 =?utf-8?B?aGRBbmRtMGNtbSt4VldzYXIwWExENXdIcDV6Vm40RDBsUlJyVXI2bUJYTkNX?=
 =?utf-8?B?SkdwZm9XM2RKRTQ2QVVpTkF2U0VTTExGaGRlSmxwdDVWZmpWL0RTOWs2M2hH?=
 =?utf-8?B?YVJJTFpLV3ZHY2VBUEU0Qjd3UzAwTmhwRkgvRTFGZk1jUDVZZTFpTklMMHlm?=
 =?utf-8?B?NkdmbGlERzcwSlAzdUl4SjR3c3dOdGw2MVhIbk9vZDNnbVRiblJVSVYyamY1?=
 =?utf-8?B?UDhBaTdZWHlUaWtaKzZmc05CYURoMTBEeWJ2NU1LM3RtbytlU3RIOGtCMWI1?=
 =?utf-8?B?czdLdEo1RmhHajMvV3BaVFM2ZGtNVy9FVzB4ZUduNS9OOXlPUm5IVjdGdCtX?=
 =?utf-8?B?SXU2YTdWd3NLbTNRNjRFTk1XL2JpajdCNU03TjF6L0JYVGxqdVVaTXk3aVB4?=
 =?utf-8?B?aFh3MlQ0cWhOQ2VnYWh2aEtBRTVhdjlORGt4OTMyM1h1YVBpU2grdmVSVXFP?=
 =?utf-8?B?a0RHUURTNzVuQXRoblVqWFFzU2QyMG9aQlZrQUpRUHBqQXd1ZEtKOFNBVXNC?=
 =?utf-8?B?WDZLREtwS1RMbWlzbXBFNStzbEZWbkp1empMaUtpcldGRStUMUNpTVdkYkxu?=
 =?utf-8?B?QTFwZlJXd3d4ZGRiNjZ0S28zZktpRU1IRkdHRW51YlZDd0FJamtKOGpnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0198628c-d410-4412-57ed-08da900542ed
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB4337.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 12:42:30.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR20MB3356
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct a wrong word

Signed-off-by: Whye <whye314@outlook.com>
---
 Documentation/translations/zh_CN/process/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 1455190dc087..4f12f99e0464 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -254,7 +254,7 @@ Linux-next 集成测试树
         https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
 
 通过这种方式，Linux-next 对下一个合并阶段将进入主线内核的内容给出了一个概要
-展望。非常欢冒险的测试者运行测试Linux-next。
+展望。非常欢迎冒险的测试者运行测试Linux-next。
 
 多个主要版本的稳定版内核树
 -----------------------------------
-- 
2.25.1

