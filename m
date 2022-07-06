Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE6A5683AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiGFJgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGFJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:36:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2053.outbound.protection.outlook.com [40.92.107.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09DD23161;
        Wed,  6 Jul 2022 02:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU9BBYdIAJCjK61XNalH2zJUhh1g4xg2SMkXHF7SWQx+KG2Or3KvgVfSjJAVUAhAquieVsffECFYpK53HwXHZBY4Klxe2uae0Mv+DgiuhKtlHS3w1X5lzS6JrXPn0SJO+5zp8CDJuNkx68XT1LwiHxSqgHKh8zi2D6wR33JWtG+yn3LVYgAr2KobCFBj14YtAy4tYXTUF+FvVThoFjyTZW1KkzplcIRcuGHnhbwrIx31/vMp8/lk4uGvkhkgvM5HCUorQ6SA91xGXf7kNOOYd6eljxlu3zqT97/Gq0dQT+D3DBd/mkdHXWL8YfAoTzhWiIgZo5KkJy66mCaitYBMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir/z4wi4c+D8aO4po5uZyVmC7RqL1/VRjYElfvSBQTA=;
 b=eTAxRuHUjqhEpqmKJjosqUYtbIwh6gRF09mbq/HSemkcI5gKmHdk1pR28iXqnBBU0VgZ6IrohRZVikqMT3xbUJ4jrKwoIayYE5lqhJTfuTwbNd21GHXnCb5oBCRVTAzWgc63gmAXaRm8GJnaNG86anf4L0HWl5bBIed2ey0SKdlIZJqbt8s8yeSDMpwDyaz1GNri5sH/DbG0M0vaZZJYacPJ710a7O3z1XgARmxm4UcYAbjvkIXFfpy8slIU0zjci8SGmLtryq3A7TUKqSawHpO+UAKMqjvE31eFTqA5duN8wg8trppwm/RLPrLbluLh3ztQ0zFKzgbGKeXA7Nu2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir/z4wi4c+D8aO4po5uZyVmC7RqL1/VRjYElfvSBQTA=;
 b=iCidgjfpPSrSZIbx4ZW33niGxjQCuT5hAeFsB1rPuBoewBl5Wb2KZz45nNoF8lXsDBOptmVsGL5qM/juQho/dGPOrMJXxu+7pi+M2N9lpf94vQC+P2SrvbW8LZU1J4r4m/LzWqnIbcNouxZ5c9eG7B86/x19OPdQ/yYE96uqKEfR7+e4+1qeAGggh98Fq6cV4JJi3zQHLoh50SjoFvS6xDFv/IG/zyeVO5nsRQIR4uXV6xrf8EvM/HYhh2Ts3PzRrof1r4BJtfodVbfBv6HeZEGprroJK8m6BbquCR5v18yIvijcAjnHNImM2sPI0bwCQboRz1oOXvzWjct19fJ3Xg==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 TYZPR03MB6768.apcprd03.prod.outlook.com (2603:1096:400:200::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.13; Wed, 6 Jul 2022 09:36:32 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5417.015; Wed, 6 Jul 2022
 09:36:32 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, alan-huang@quanta.corp-partner.google.com,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        dianders@chromium.org, jinghung.chen3@hotmail.com,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] [V1,1/2] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Wed,  6 Jul 2022 17:36:20 +0800
Message-ID: <SG2PR03MB5006AB4C7E356CE321F628D9CC809@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cfc2c27a-444d-8bd8-84a7-b6b1f99258f9@linaro.org>
References: <cfc2c27a-444d-8bd8-84a7-b6b1f99258f9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [q8E7AV7uoFSJ56j6/2flkfHMJD362EjT]
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220706093620.176723-1-jinghung.chen3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b4c7b2b-36e5-45fa-2eb2-08da5f330273
X-MS-Exchange-SLBlob-MailProps: 24/Lm41Da9ktIBtCWjIRZYcjG45JR6BduYRU7ox7eO0TbaO/mWwzYzNutIh2Tclm1CviGUjn6sl4bQ+SGXxXLdWiDv2Xqno5z1CerF9F8hJXArKDp3wcNLCoThh0etUWCdRZ8WIOAa4o4T9DDKg2NH5EsrbiDaM79v8cRqz3IJUu4v21UJe7W+n9f62OYsyKkIhEkExHN2V9waSRFmJmxXbpeyJJYjZT2uchtZEB0PBz5K072T4LNR9ZY0vCpVY1gfd8rAt5L8SM69YxnY/YQ0E0qVeYAsFAfiSd84arNvVuMNQ256+iySH399+wJQKlk7nstI34coK5GbxeIFj+FO9X372pdMG7bloQ/uX9uIONDVzkXLapnZfrfZA6EIWD2zD/dscL4dYuNn9W8d40o7OjYsL8TXWRB6QDgKTEbs5pEb4LSvSr2VdG4aY3x+jJ6RTYnbnVPX48dk+KPxtB7Cgu5PZMdDtqgN5h+K1NVntRx4JzJCY7Yd27mOyszlfUAG9VT23+XaQNoity5J3uJSJsxIBjeJt13AlGLLRLiCQ2txHJNVpiOuY1QEEBKUoeE28II1LQKwFQe5F2pzdtHgDbQ2nZNwhDsQ9jsEN8k98IHVx4jQEQSFzpLABbsg5/ytYLyKPttXIGtphc/qM5+W5XoXMQzYbgRTffV3qbofbtKbxEVjqulQCfxCnjA0rDRq+3SEB9KtLYoHt/FYVS8rwSp4O8w5q6auPDkE/RRXdaf0QNR/s5YHi1ZtITKaVI5H5nP4/tBt5YxzujCD5N8iEFZ0pvpd60nk4aKC4fdVPymcmAU2iQkc3hsWbZwY5fp8Z6iBaSLJ0=
X-MS-TrafficTypeDiagnostic: TYZPR03MB6768:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZ+xTm0TkYzkelw85Df3luEiOdz9oD4XpAsMJVf4APuD7ALSEr1jq2fSQyV1NxvorumW9B6LBqaxz+28KJQcG7oalNQStWovMx6MHJ4lWhUjGDvmVqE7exudOejX02tl/wd98gXyXA3Ad8aGC5bQY6895iHO0Z/XbA7YEUvHPh8AVBPcL/40uP/olLw6tM+bzgqRZoa3GtfUC03fTCWNGtapenTf+U5HKamksvM+ZhMj1gZ6iekVLs734UWebYWG2aZ+YfxuH2NF7sBuLcOQqDQdKbWpZ1SPZUwNdrAN72t2Kw9Ft6aPKMQLI2n/JbzpqLpsFV+vUIezUG2wZFr+PGHwrleSWc/IyhxFdEvmehTJ5jKLtsjNI9hjnJ97yjxh+TFOXEAj7FPJu9NKviUvxofQRs3EUnd1dqFjgKeLl0CqDVKNLygj8ybg1plLu/sHCrDVnFwKge43eS5r1dv0M62mG35gJ2Rykk6nlEcJ7LbogbdLNs+yX7yFIlS7okGGCAM8YtG/WEF5eGQCqr13QcaHa6TMrYIZhJb2enGwnmmY2YfVTTEF8Uv7w/aRSrPQ1CGRJ31oy/TuCXBGbD++Kl8p6h7P7lYiwgcOfTQEOMXgQcttFvW2Ip5wEZpZeTNClX9mS+FQpeDF71JMJkZAUw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1NMUzlVcXBRYlZ3LzZibU1GbFFZaWdOTnRhM05rTCt4N1VqR2ZlNHd2TWtP?=
 =?utf-8?B?WThDUXZDeUtCaFpFdVdlSUVHVDNOdDRHa0pyKzNFNHdNK0N4aTlDbW82OEl1?=
 =?utf-8?B?OEo4SFdIeGhhMVpycnM4ZVJmNFFsNkNqNDBhNlkzTzlvd0c0MHFCMTl2S01I?=
 =?utf-8?B?QSs4UDMvWEUrekh0Vmd0MDNyQUg4V0FRbmJEalgvU0NYNlZXbVZzZTlRcW9H?=
 =?utf-8?B?MG8zajBIUlRHZG9leUkvSmVpT0UycWt3L1ZaWjlWNFczR0NaL0drdGVoMUtu?=
 =?utf-8?B?eXNjNDUzU1RJTldnNGlRQksyRlIyeU5JL1JTRStETWlhakc5ZStOUExvQVNG?=
 =?utf-8?B?NldVajVGdlRDajlEL2xVbXlRcVFsTytpK3EyT2MxZ1VvRWJjeEJWczBxT09u?=
 =?utf-8?B?Tk5EeGpmelVXS1R3aHhQcHpNT3RQbjEwSVNzcmtIQXdSMGtDVy85WTdoOGpM?=
 =?utf-8?B?M1d5bHVsVFJna1FJSWRGY1hpZ3VZR3BIRXVXSUgzLzZTakZic3c2MjRaUU04?=
 =?utf-8?B?b0pzOHBqblBVK1FWM1hlL2l0VEZxL3ZockVyZG5hTFg3VHlWdVc3ZWlGY1R5?=
 =?utf-8?B?RHBPSXBPYmxnYXJrSGJ2QlRXRndmTG9nOEd5QjRKTEQ1TTA0LzJGejR4RUVZ?=
 =?utf-8?B?elNlbkQvSjhnc2lhSm8vY1VhbGlaQUlVeGh6ZGlxanZDY081bDI1aHc5SWNG?=
 =?utf-8?B?TWZVSi92NW4vUzUya0VXbFYvWkdLODJSTXlUNUtUM2h3bExSS1VaU0Y0Qlgv?=
 =?utf-8?B?KzErSkNEeW5WczNkSmpBZGtkTWlDM28wN3F4SXdtajV0dTlZTXE5aFZrMXpY?=
 =?utf-8?B?anVON0xTK2huajJNYmM0ZWJFVnRpMW9MVHdaelUwaU83cDZZVUZVakZjWUps?=
 =?utf-8?B?ZThpM2V5T09oZ29QYW5rNUJnTFZWSVJTTXUveVZobTJmVm5pMjVSNUluRUJh?=
 =?utf-8?B?dC9nRlR3WDNySWFYRE5PSitweHA1R0YwUnBpSWFxUzc4WndHZU9XL2Q4NGov?=
 =?utf-8?B?YjR3STM1ZE03MGFmYng4KytONnozblI5OFdZdkFhVDhGdVZ6OFVtQm5DbGg4?=
 =?utf-8?B?Sk00d2wvN0xzYzN3dXpjTlFndXYzOEdWc0RDU1hWaDFPVmttYlpFV1lPcEhO?=
 =?utf-8?B?THJZSk1NMUVoK0F4VHg5WlVSaXlYOHI0elFyeUxVNE9nZUJxSk9kRHV3ck5L?=
 =?utf-8?B?aURXVVpvM0RldUdLNDh3MG9TeHJXYjFLbkFKZzZIUHF5UFJOeUdFTDJOU0JE?=
 =?utf-8?B?Mk1NL2E1V2JRaGp3azZmbjZTYVlwZTN1UjBwbVZMUWJUYnFqYkN3b0NqN3R0?=
 =?utf-8?B?Z3JZTmZHcGF2eU9vd094Q25HbjhZZ1lRT3NxWFpTQVlZd2N4ZG5XaVR5UFBN?=
 =?utf-8?B?UllXT1BUSXYvWElaUUFUQmI1MldpdzJ6T1kxdjliRjlqRnhLNHFwcEp4ZXF5?=
 =?utf-8?B?b0pEQnhxMlRXdHRRV0VWRUJ4M3hJanVTcmxLdVhPdHdiNnZFQzVrWmNibXhu?=
 =?utf-8?B?SlpnZHNuRjZqRFcySVFVZW5yNDE1c21sNURTQXMwdG5KNjN3S3BnUDNmVXlL?=
 =?utf-8?B?NkJGZm1RTmVHMDdDK0dJM25tdjVnRmNTaFEzKzV3dkprSjlPcTF3STQvRkR5?=
 =?utf-8?B?a2lpOC96Z3hPQ3lKWjN3aHJXNUU1UEM3Y0krTFd3ZHN0ZlpQUEdxaEh0aGtn?=
 =?utf-8?B?QW1zZU5Ga2svcjJ3VU8xNUt0bGxrSU5kZzdnQzM2MFRaTXJDQjM3NkdRPT0=?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4c7b2b-36e5-45fa-2eb2-08da5f330273
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 09:36:31.9326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6768
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To keep the consistency of the format for Chromebook items,
we basically add these items based on the rules discussed in the previous patch series here
https://lore.kernel.org/all/20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid/.

We are little configured with “one entry - one enum “. Do you mean something like below example?
We suggest keep items separated as it is more readable.

      - description: Google Villager
        items:
          - const: google,villager-rev0
          - const: google,villager
          - const: google,villager-rev0-sku0
          - const: google,villager-sku0
          - const: qcom,sc7280

Best regards,
Jimmy Chen
