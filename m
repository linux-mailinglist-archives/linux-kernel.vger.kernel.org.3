Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9E953DCF5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351151AbiFEQXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbiFEQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:23:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE441473B8;
        Sun,  5 Jun 2022 09:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EROrj6cBAywr0SD5fVM9+EwPOtamarlQJT8jv+hRPG7/9Rmt+ukZbQC5fwcfkzm2YEPBIlsmDUbX67EvrCwMX/cTxff6iaesGv/+Yl5eON/1BPMyJcWX2XX5OXL6HIQNfd+cWQvIIHKe3tcnq3te1SHLaN7cXU0ayWRwJgqCdbzQ4liQYC2qnp+3hCqOk2ze1O2lgbDxa0y/EdKaWnwMfQEih4w7cNJmX1IWS/3/c8A67z+mAxt3xjwIRTKQBb6o/TndR8tbL+Oh0vdqusVnx7s3qVKODqbem8AK3bdst99LueioVAvTqy3Uq+ndvMyRKWU4RQ5ywHASd5QNv3GjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7M3h/s79MfEgDeRtIetRMeoeAiN0vVCqW7jZ88/5Js=;
 b=mxh0tM64j9ppi177QFHyA+fHKTu8QsNIZ1FYmawKA0LfCWk2N/ZkuFJOG9fBjxbUvuPGFtAsjUUtkJryunjttIlxyunn7Iz6G/R7cZCch9BsmEEcjVrf8hc02lbhacxbsfstdZo8m6bX8ZhhDeE4wlb3H6ZQ5lHSsi7fcX2nidSdI5PTLeXCXKqg/M877tLns7Tc3BA7GXow105Yn3ufIjuGIKWvYDtapHVdXVs3Z7FwjWUW5iV4XQnd2o6fUh42g4/Ii7iKLNbNs+aE1K4w7OtW8ytyVV4HVgDIOSNEaRI0U5iwfWvCD0Czo2EJFteYlHFo3ySiSeOVMVjYSY0i2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7M3h/s79MfEgDeRtIetRMeoeAiN0vVCqW7jZ88/5Js=;
 b=V6NCJrX/X42HFsy1DPGPr2MaBYwfG9PfMVG5cgReF8vVebK9z77IU8pWAaRrI4jT2d/88byRVOLdWMdI7gJ4PtdnQ3Ay3sTraMNdykiC6FakjeJvVJiBMMJN0++6BFE29PAYGW2aAVIeQhKvYS6srrnMcNS5LnzBdjAbgREaau8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AM6PR04MB6104.eurprd04.prod.outlook.com (2603:10a6:20b:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Sun, 5 Jun
 2022 16:23:21 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f%8]) with mapi id 15.20.5314.015; Sun, 5 Jun 2022
 16:23:21 +0000
Message-ID: <7ba5f29f-4454-f2e1-c4bb-329fc3f11516@oss.nxp.com>
Date:   Sun, 5 Jun 2022 19:23:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] media: imx-jpeg: Correct some definition according
 specification
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220530074731.14252-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220530074731.14252-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0052.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::10) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca645600-4fa4-4664-fee3-08da470fb496
X-MS-TrafficTypeDiagnostic: AM6PR04MB6104:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6104CD9CC858A2100768955BCEA39@AM6PR04MB6104.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xycwGDXbzmK2o4Kb6GEgOeFLkFzcZGs8mXznBAv+ajeO0AiY/SOH4Wwz7hmG6v5vhcAmABy5zrj/JRWNRYJQrQvlWx47AKXiGet86Nd2EaehI76WSYViw7Wk+e1JPFpoQ6XIbcuRkXwE4S22csUXanVKTwLkyJ6SmaOEKIvB2tA7vWdMC+nYKr2qDTmClPDKd8M1tISU1LXi4+Bla5TpQkpAfJ/MOcARbO/P+1IFb62R4pdZB4t01abEeZVCbHfdoolAQYzXOevusxu+mVHi9JCIWLQ+4nVo7r4Uq+Buwkf0Z/ruuNwFznzI+tvtL8CKaktSvpxsHniJBRmqcBL6ya/lYHkDjmCMZfZVS33Z5VKpwCo+PwSmCmmP/KTriG1VSl56CXDMUmyoV++7sLqT033sk6nCWnB0HicuKevp6l3h2C0bTsyfqb+8dlSCmmqYkf+CPjfF25VwMjnhr733qi325nCPaH935mL8jDmUVeQdwO9ImBY/QyIMRqlZGLop9iUrcqJMffIN7eh3ktZ7OozCH3r06KyMgwRpeVaRhseT84fG/jop7lajorZJsLhEAirycWCOuUfXUANNSHfXCU8nXhwZdGt8nhfSrKXuAI886SX3GIchzQaxSV6Sg9z2O+qDOfkBuQ3rVRpKZPXTTnDPgw9RTyzAcPUvMQbnYzupTq6jqO4oKL0ib+PwPMkpnfF4TY1FHST4x2u82T+qX0UwwAuMa8nEwhNTNRDedEq8EGC/nvuFioavs1DKExTuXHBdWETcv278UY0YJEj+UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6486002)(31696002)(7416002)(5660300002)(38100700002)(38350700002)(2616005)(53546011)(86362001)(186003)(2906002)(6506007)(83380400001)(8936002)(8676002)(4326008)(66476007)(66556008)(31686004)(66946007)(6666004)(508600001)(52116002)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZtT1M5SWtGT3E4RkthbWdYSDIvOHp5d0JGbFdQdDZ2L2I4Mm5TQ3M3dFlo?=
 =?utf-8?B?QmtGek1hMEpFbzRNTTFQSDJPWFQ3MVJpQ3UyM2dPTkl3VzVhd3g2a21uaS9h?=
 =?utf-8?B?ZFBYeTJiMUpHamFaNWhDN1I3NGFheFRoN1JRdmxiMW9aenlpeWg2TVdXcmo2?=
 =?utf-8?B?anhrdXBsUXBDRW5OTVdZSkJvZi9Mc3NhY05PNGQvT242OVBhOHRKYnBkM3JJ?=
 =?utf-8?B?K2hXaWNlQkVvSmt5aEhEb2xPdzVSZmIxRWgvamxNSGM2OVVRd042UHNlQlBO?=
 =?utf-8?B?bzM5R3MzMDJKbTVrUGVpVlBEdkFhSEs4dFJCSHdwMUNmK0d6VUJ2azFYTEZF?=
 =?utf-8?B?UkZxVktqQllRdlJSOVdITFU0QWZRZ045RTJ6a3JLemhVUUtCcXh6Y0c0d1ZX?=
 =?utf-8?B?UXI4ZHhzUDErMVA4UFJjdmNvRU81NUhIejhyMkxVL3RmRkRnWVdNQXlrTnlu?=
 =?utf-8?B?Nks5blo5SXRsUHlnQ09RNWtzd1E0WEtaU3lycXhtQ2lTMnFkeGtlWUtGdFps?=
 =?utf-8?B?eDFwSTYreEM3cWV0Tml1ek9xclJuMm9raHkxa2pyWWVqRTB4QjlRMGdyNkY5?=
 =?utf-8?B?aklicmNneWRMeEN5b2oybE03WXNvS0xoZ1RqODJiNnFTMTFMOVIzVSt6UVlp?=
 =?utf-8?B?dmRYeDBHVUJMV09GZG9wNm04U1orT0tsM1dkNFcxRllLTm9KVElMdlV0MFBv?=
 =?utf-8?B?M1NYSXF4SFpNbU9OaDZSMmRWNlJYTm9DaUdyMk01QjRHU0NjZ1NrUUE1SWNT?=
 =?utf-8?B?Y0Rob1BwcE41NjNZZmNCdlVVTk5YbUYwbG9TK2VZQ0kxWmxtYjllMVNWL3R3?=
 =?utf-8?B?NUpCaHVEMEdBNnJUNTlUaktKeTdQRjJLWVBkYnhoVC8rMWtaVWVQaThaMVVv?=
 =?utf-8?B?b1cxdSt0d3VKNy9pZDRrMHlwdEFiYTZnc0hWZldRb0tDcHdjanhHdWdYUGRU?=
 =?utf-8?B?VXZSaEN1eUx4Z3ljZUJnaGtKTTlUQml1VWsveUhPalUrOEo2VVZ4d05mMCtK?=
 =?utf-8?B?eVZrQk82T2NhME5ZQmVKNVplbVFOTlpjZXM0Z0J0amhidEpxaHRad3dxeG53?=
 =?utf-8?B?T01yOUtuNGJNT1dtNVpiTXBCdUIvT0pLY3dLMTRLdTJHNWtUTVdsbC9rN1Yv?=
 =?utf-8?B?bWNwbFQ4UjhGWHRWVnM4RFJwYzNHV1dzTUxBYW9zOWZOeGVncDhqZUpaYlU2?=
 =?utf-8?B?ZzNtOS81OU1rcy9FL21SSHI0clgrK0VBaHllb1k0aVJpaXhvUlZaYzdvZVh2?=
 =?utf-8?B?ajYzU1NrWU1aYllaaXpYeFhIeWxVZXpWT1krWXZjV21PeEc4bmU3RUxiODFU?=
 =?utf-8?B?YU1DMHVjMXkxVTVRb0FrMHBIUjNQaE0zR2prZDFQMmdzNTllOHYycGlENWlY?=
 =?utf-8?B?Yys2ODVmQzFlSnVXK1FPV010dGE2V2hBYWxrOHJQQkhUUlhEN3dLdWJ4T0Q4?=
 =?utf-8?B?NWxxNXJVSklMWW1CcmIrQlBTYnhkTHRtVnBmYThBNm9RWGxuZnVjS1FKcW5L?=
 =?utf-8?B?OEY5UDBJWTV5anpiZ3NXSE5sVVpNbFhHektCV0dDc21GMkJIMGFnYUlVU24w?=
 =?utf-8?B?Tm0rUldCaVpya1FvT25zUFFNZWdOcGFqN2dGQVVCelpyL0hLSWptQ2M3Uy9M?=
 =?utf-8?B?YmhqelhFS2VRQTFmdVpNVGtZMExZY1I3VncxMiszckJGalozTjBTdjVVbjBo?=
 =?utf-8?B?OXp0NkNVWlN6bjY1QlNDM2hldHAwWGF3djNCQXo1MnRBZ2tmWUdzYTNsL1Ex?=
 =?utf-8?B?VWpvRWtTTjI2SkhqTmZXYjdEVzB3ejhwRmpydGd4K0IzSmlmdzB5S29nTStG?=
 =?utf-8?B?d2p5N201ZDMrKzIwbXpFblY0VG1pYnRvV2hrK3hsL0dncU45NXlGZUk2NWhY?=
 =?utf-8?B?Ky91WFA0Y2pCU2VDcGg5OFpGaTFQMkF4NzVBRWZBY2tQUkI4TWtlOHlLVUh5?=
 =?utf-8?B?QWpBbS8yRHZQdVhNWkt4SXBtRWR0V2RoaW42QXFvVSs0dUtaMkNzUEg2Zi9K?=
 =?utf-8?B?eU9lWTJsZENCQTlFZm9yKzRiMnhNRjVXWWdpaEJIRGNaRnluV0k5VGFoSU9o?=
 =?utf-8?B?c2gxZGFPNGZVS0tLYnRsVGgyVm9WSy9oL1d3YVdaRmNSeXRrV050dUY3RHI4?=
 =?utf-8?B?QWVSSGZCL2dqbi9MYkdIUjR3QWl0OXJjOEc3S3JZWVNuTk5tS2FadzU0SGY4?=
 =?utf-8?B?TjF3bG11VXJHTlVVUmZmK1A5WWp0VEJMeHBRVlNERTJZZC9XbDQzRFg0Ylo2?=
 =?utf-8?B?cWVGK2NxSVhFMldTUkJ1MDY0Wko3N2EraHRzWG9sdE5IZ0F2OVVhTGh5UXlm?=
 =?utf-8?B?Q2Y5WFQ1RUIxeEpWUG4wWkkvbXE4ME5tcWtDTTl0VHFPYW1YQ2lWOWZHNHNP?=
 =?utf-8?Q?1rtQJtL9Ovf4QeBA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca645600-4fa4-4664-fee3-08da470fb496
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 16:23:20.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2578kMC/QO5Q5LXHC76WmhMK7e/+QOAwUOLyWlJdmFt+vMVyJ8qmT6x57x29FfE/K3wm9AEsFxIYU8glUTmhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6104
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.05.2022 10:47, Ming Qian wrote:
> the register CAST_NOMFRSIZE_LO should be equal to CAST_STATUS16
> the register CAST_NOMFRSIZE_HI should be equal to CAST_STATUS17
> the register CAST_OFBSIZE_LO should be equal to CAST_STATUS18
> the register CAST_OFBSIZE_HI should be equal to CAST_STATUS19
> 
> Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> ---
> v2
> - add Fixes tag
>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> index e7e8954754b1..07655502f4bd 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> @@ -53,10 +53,10 @@
>   #define CAST_REC_REGS_SEL		CAST_STATUS4
>   #define CAST_LUMTH			CAST_STATUS5
>   #define CAST_CHRTH			CAST_STATUS6
> -#define CAST_NOMFRSIZE_LO		CAST_STATUS7
> -#define CAST_NOMFRSIZE_HI		CAST_STATUS8
> -#define CAST_OFBSIZE_LO			CAST_STATUS9
> -#define CAST_OFBSIZE_HI			CAST_STATUS10
> +#define CAST_NOMFRSIZE_LO		CAST_STATUS16
> +#define CAST_NOMFRSIZE_HI		CAST_STATUS17
> +#define CAST_OFBSIZE_LO			CAST_STATUS18
> +#define CAST_OFBSIZE_HI			CAST_STATUS19
>   
>   #define MXC_MAX_SLOTS	1 /* TODO use all 4 slots*/
>   /* JPEG-Decoder Wrapper Slot Registers 0..3 */
