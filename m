Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C8C58680F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiHALZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiHALZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:25:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B8654C;
        Mon,  1 Aug 2022 04:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkHe3Mb8lOxwnc5UOuz7mCBWrUlXTzqhjWJS2sN6FGOlXiV3D6fFRONqIrmqaxe588YCYMIn7wX1DpbMPcinomHCbsXNmvW1ZRKlx5nACTFEbpZC0aWK7369hvFFJIfEsI8sG6u42uEPO5S5pR2dnIKlJI+efWZPbxo96fmxOCbiS3HHmmm3esEZfh9giwDCf4aCPbZAfPT8q+vKMIjXN25mu2pE/05nSyMt/IDiXkEs+24/mpVZvSFMurTqaSXqcycOkXwRmZAAdoz9G9DcVCCD+cp4C/w5YJekCA4iGvNrnRboPu7PAglvNMX6N2zqZ+P6Rh8sfxPHoNN3nNkDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45uYJvmiFRRIkBZ6l3uwAVEuE4iqupuqMVQJO1I17po=;
 b=TnrNREdqWf1oqui5rYpMP01GSF3rZuVsfTSrN/Q680BekvLaaMfzI8bWNUtJD2MUCRa3Zh0/H9trH8XM4Nrq66L5FEo1d9bBkxSOGfF7YxRbn4URzU+dGFXIauc+IhABH7OcPFZSkD2tkgguE+a+xmWnyJExDGit8IY46F6C3zpTfyQIUGtcUsBz9PqMP+J6BFw0Mt67nymAnaTyxxPs94x2FL2OCeHGHM11SjBOwAXrFiKhegQhCy597N3i6DmMc8wzDVg7CzXDH0ngNueFfslDjSpC9O7RsoTHdtcpEftqUjLBNC/fSYI9FsNoB58fEf7bTSwgKXETkNV6clFVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45uYJvmiFRRIkBZ6l3uwAVEuE4iqupuqMVQJO1I17po=;
 b=jEM0O0wRpC81sGY1vFbXckzBibg6LIUDLocLcNtzgZHTTTGKuSWsn+ytWyVlwJRRw8IGeCGvrQKPUkDi6JcStAS1HquBA6KnN2oD977RezpwlDdaczPlxDRGeYadN+8CiDhvw9P1xhc+zBlw86DW1qVa3JX+CO1zXTiobF6UVNGXRwXgfL7D0XPC645xBDBz1tyIrVyXW7uIzFVzr5Q5kT7N87oags7yCQV8wOcN1veGEjcCD+4v2yPPXe4Cl+z2GfUAIyxwYs2Kr0wDNcmcEtaTLoZta6QRnt6cP7/BzhU1XDXDJjTS4A0O8NOdEMpjBfSCX8ILDi11FONGZG7lIQ==
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by BN8PR02MB6001.namprd02.prod.outlook.com (2603:10b6:408:b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 11:25:30 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%8]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 11:25:30 +0000
From:   Joel Selvaraj <joel.selvaraj@outlook.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joel.selvaraj@outlook.com>
Subject: [PATCH v2 0/3] Add support for Xiaomi Poco F1 EBBG variant
Date:   Mon,  1 Aug 2022 16:55:09 +0530
Message-ID: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wi8Yzz6Duke3jnotB4twD6+JVyuRaJtHwkDSawfFrpg/+SIjQgqywRYEueJo1M0N]
X-ClientProxiedBy: PN2PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::22) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220801112512.209047-1-joel.selvaraj@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3e08ebb-0462-459b-69d7-08da73b089bf
X-MS-Exchange-SLBlob-MailProps: EpEO96k6Wolu1z8CWDBHsiQHhdFlX8eT1MkAw907a6QDJlXAEIJ6tbQVOgjN3elvQoyypGAv6z1LkLirb5zJwZ61IiOCgbix0l2N0r6XiVqBztjlwneIgGs4XPN8LpzesKSe4sut5ocbIkkEC0nF3dJRYfJBirpCkiY89J1iPA/y6Q3v5v6f4+yHDhrkESGl6BAEennqV5j7uz44iRM4khDYYexDo7UD/CRVXDZ74FDaN3p+XDF2qkj68EqHdQoPCTE1Dbk0cSS+tzYQcHriO+yKqoL3lClpHIE8MESefuS0NZIenWeIZSANyuVcY2W8SV9K/RbpXISKlNTrKrhebMUu/fCFs8SHAleqf3Nhenkmx88ZtvCClbnR0FV3w+NTTYARWLJsvo/nt0cbnPH9+Udl8jKHDNHhmg+hmg5HgGgljxxMbXPBdRDagx8EVIgYpy92WCJlktDSlvAt9Is/fvr9kF9mFdTN0qIpO9pxY6PY/tDWFj5tFaraWE5lLCJA7vYlZUmJ7S6ydB6zAj+aV7xgn1BVySruJJrfS+NSkbVQfrQk1yOGTdc/2oZNtA2cL5NTIV1Fg84WX5e+/oM3E9pMU/cW1GKTZB0iSgc5yMM9T1CQEgVIrR5xrLmOIY8pkYego87jxeuUJasBeZLoajSPzNjZ6pl1M/XYrx1PloOHyxMeYJ9EUW2fVHtqx4qGancm6oA2OpN+Z8KXfFN8RdX77qI08J2rwolAfenOV4mVI2jjQA3M9HOje68wyrEM4hO1iRUX7ZY=
X-MS-TrafficTypeDiagnostic: BN8PR02MB6001:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fn96iTcjKExATj1xY2HQ5GaTNo29n8bPrzkM3AKeNxIy9y3Jq81FP2Ccfj8JQ0OtskgrGLzm+Dn2pCsWPPaikZqgy9GUcDkG0euiO7rXxSY9hH4IZtU0GV3Ssgvz0vzwEB2UQvQEpSOHvTLQ+TK2uu0N2eSmF8osRErf9qelkjUwZypTjr1f8itvDEmq0WALm64IVkMwnHSaLmotTJEmCuzHJD+7PaSFqjhoFZB8iYG6SOinLIXjgQ72ASGlFTFMJZDxKeWr5OCor5mDH/xVBBFui4KnLgWolUTFZTuVTSn3jnqYmX3bBwVed8daC5ySp0LI7g2xg0sQ2u05Yj7HycQZBCbNisr1K457UNbM8qOuxIoCBxv3VraZ2cx4EDcgvwKRzSR8EFTGNEr9CDW9TprW74iomaWa4B+9DpZpbUvw5dtzO88XpoYsG9/ScRX+IVUela/SV5rmyWffXmqORtq/LRfqPvg3TcELl8E20VAWmhEMKdTAt3Jvh9/Q6G5EspRIa68Tno5+AoY01P7wi0O2IQxoZFnESeQfzdI7+WHwHBfctF9vehgYmmkdaW+bVTirIfQxRCrEBKYYavNGt2JqgZf+f0DSmy3cV3hSMAc1F6bIBDCuSzoumHm4881D
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ismz2mJe46BaipwWjkZgy5SjG3bwtRMoruLwqvXJ14cLSXOma/ag6XfIDPUz?=
 =?us-ascii?Q?tgctoHUSExgin33EjfIF6E/NzgqJT3yRscgmPXee0zcy+k8+aWw+ExcsSJHT?=
 =?us-ascii?Q?ulkVML2f3EWrHdOLJAyDBO8M4m8pgq42m8VjV8x4RK7+PsGWSLLLEpSEYz7q?=
 =?us-ascii?Q?4AZPBMmKxRDu+FnN/Pu275VWPn3I1E2PDEvIoTxEVQbn5XNyhVN3yEaEqu+y?=
 =?us-ascii?Q?95lGu1y9CfYPi6GlDrvzXsdy6agaENRkmYOdZGTjtP64tuw2W665A+Vlc0C5?=
 =?us-ascii?Q?O4qW+jT/BMPIJ95sBqkx/n25dzH3T6oJ3C4wehdNoL4Yir0YCz8FGkDXhqJr?=
 =?us-ascii?Q?tRA1oybRIfmDSEhUnFxzl/QW0hvvNBxpOcVq6jRLZBlKANvXCY23OOQbNgVt?=
 =?us-ascii?Q?WlQjoGvOr5Viq4aaPTlR5Tp7osPgaJ9URDuomZMhwPPjxjfr7dKlXgdH97ZA?=
 =?us-ascii?Q?TsobLeQThk6IBH3XSOHQpD5+OfmbY47ddcyfPtB2cxHf+Gt32b9M4sr7UTG8?=
 =?us-ascii?Q?uLVEeCUo35BmYkgV52FvIOhUmWn5lgeaEGmnbxQBaNsc/SgfuOcZltW7krb4?=
 =?us-ascii?Q?iyp/dr4j0rbdncSUax/fdH/w7Fxsh67PxfueMMn13XF3auI/pP0hhkSModUt?=
 =?us-ascii?Q?DF5KT5pfuzsrfbxBCGUcSbNy+jw4XtM3qgBikyER8XHa1orF1sB8Z+0rtvKy?=
 =?us-ascii?Q?pouCKfwh97QWLJUK15qgfMCXaQKFTqt2bA4ht45gJLwHZbZPnHIDA4ryhGct?=
 =?us-ascii?Q?rVixt5VnK2qO3pfVI4XrUMfPQ+Vl/bAGR87hWhGwLK695kU7csdcKJBf73nY?=
 =?us-ascii?Q?rshQ2EpVXUL48+RqI1maMLU4dM7L2yqgIOTmvz/74iP4eRYwKpjS1WZX8gQX?=
 =?us-ascii?Q?+zDaU67Hi+cUaRL5S7xLOqsIq//iwILWHVD04gEuQRLlml8qvCH0yAMT+5x7?=
 =?us-ascii?Q?2OUKFa+4YNm6GsZyckk71lzBD1v+b6XVZ4YhDmDTZZnjccrPM7RYJPYrNzIC?=
 =?us-ascii?Q?o0zS77BYZrLOdBqJqq5dfvvQ3M9jy8p1qJxpIYIgLLjyvh28rYUD/XKG7Ep+?=
 =?us-ascii?Q?tcJQna3cv7XEfsB16IWhI3cyUr45RzXSDk5CKC2yENsygfiasr5Jy94RttIM?=
 =?us-ascii?Q?KOgiBgwuBWVXbJggl/YP2fjvPxtXUcakfgOyi1vHTkccleqeSB4g42ytgflf?=
 =?us-ascii?Q?f77pD4nr2kk59V+6QYwQZ/8R8u35QN9VSvEwrSJwQi/zen2Lk+4c1ke1y5+o?=
 =?us-ascii?Q?kj3YmxciNBWItstDtDu3Uj1eWK7/pNsv33fLjo7/Q4OQ3VwDx43UPgvRngrw?=
 =?us-ascii?Q?je+33lb6y3v2KAk6UuKEPaYJ3kHlcd7/tOmbvb5lJ5CiAA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e08ebb-0462-459b-69d7-08da73b089bf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 11:25:30.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB6001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two variants of Xiaomi Poco F1.
- Tianma variant with NOVATEK NT36672A panel + touchscreen manufactured
  by Tianma
- EBBG variant with Focaltech FT8719 panel + touchscreen manufactured
  by EBBG

The current sdm845-xiaomi-beryllium.dts represents Tianma panel variant.

To add support for the EBBG variant, let's
- Rename sdm845-xiaomi-beryllium.dts to sdm845-xiaomi-beryllium-tianma.dts
to be more specific.
- Move the common nodes from tianma variant into a new common dtsi.
- Create sdm845-xiaomi-beryllium-ebbg.dts for the EBBG variant.

Note:
-----
Both the panels are already upstreamed and the split is based on them.
There were patches earlier for both the touchscreens, but they are not
accepted in upstream yet. Once they are accepted, we will add them to
respective variants.

Joel Selvaraj (3):
  arm64: dts: qcom: sdm845-xiaomi-beryllium: rename to
    sdm845-xiaomi-beryllium-tianma.dts
  arm64: dts: qcom: sdm845-xiaomi-beryllium-common: move common nodes to
    a common dtsi
  arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco
    F1 EBBG variant

 arch/arm64/boot/dts/qcom/Makefile                      |  3 ++-
 ...ryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} |  9 +++++----
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 10 ++++++++++
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 10 ++++++++++
 4 files changed, 27 insertions(+), 5 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (98%)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts

-- 
2.37.1

