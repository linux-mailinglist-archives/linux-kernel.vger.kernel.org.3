Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94880545A13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245520AbiFJC17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346007AbiFJC14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:27:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28DE96F1;
        Thu,  9 Jun 2022 19:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erVJa4YLjGH3g4YpTP/hCF2tFppPHhJlpU8C0oIkDQz19q0gRhyBQJPnlfw9Exz1+pnFKx6uHwDMpfQ/8Ur7tEh1bE7NHGoe7ZY9csTtrhdLZSUbBAjSa3CgAq4DeA7DFIQz1lOwR+H4M19xGPehFMmec3uqZKk2rDsd3yQR+JZRPif+WxTDOPXRA+T4Quzg1niE6eBTW9sxQSgtO9YtEBp7/Vxwo9oiimfrg9M4JWPxSgO//fhvZm8PYSZwbUhtbLwfp48gsjOCzRgKVNWuTFgdOVaWldHdQJM6CEkIcV89DCoOWYOnyRiG62HkgQDtSyhC8p3sti4xvtCJ3Lcu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu50Bu7J4EGdTftpeeH2ZGrVbfF2ZUYoVnK75iymYso=;
 b=diX0kJ+GqqTo4hiN/QJulcDiOrvMq6g1rkd1Tc6YvFmW9DCcUsR/YZMVJF1PFif1hLEYH7dicbqgvtNWYVecbya43RioeiNd+D8EVrVGdWapxwpA+GXQRELdYzW//SdCv7BUJlcme93RTHnRRsmczNrF2l8545fAyf+G+B3TduEEsfHSXYIFNW36zoe7/ro1b09ZMD2p5gDQ9WKpOe+QT1MYrXIFauS1Z8mpzKGdGUzA9a+feRqBgUPEwoj7zWimPmtLTY1Y0OIECk0BcXBqfhOR7bHGM3lGmp1SGIRAmttRYd6jslx1OC1Ijn8N3BEXrv+5xf3Jp/QFeNZ88xqfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu50Bu7J4EGdTftpeeH2ZGrVbfF2ZUYoVnK75iymYso=;
 b=pmjbgoelhf5p1d8+UgR99F3s0qw1oe/PRd06ZeqkBPVnFi84CNALwWOb/m39gbBPoo1nfcq/Gobp78etPihu8Z4vY77+zq6UfS87oLyjvk6Rvrngxw+Njw6SsSVzbZBzwCnYb2CZFGELdIb1RSky+SYyzbyjQXFbZ+lcSli17ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB6PR0401MB2359.eurprd04.prod.outlook.com (2603:10a6:4:4c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 02:27:47 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%7]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 02:27:47 +0000
Message-ID: <c96522a1ebfe79d7a0cb8bf6311c59d92b015c5c.camel@nxp.com>
Subject: Re: [PATCH v8 00/14] Add some DRM bridge drivers support for
 i.MX8qm/qxp SoCs
From:   Liu Ying <victor.liu@nxp.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, lee.jones@linaro.org,
        mchehab@kernel.org, marcel.ziswiler@toradex.com
Date:   Fri, 10 Jun 2022 10:27:36 +0800
In-Reply-To: <YqG+Hxswo5ON1MX0@pendragon.ideasonboard.com>
References: <20220609064931.3068601-1-victor.liu@nxp.com>
         <YqG+Hxswo5ON1MX0@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d02e4dfb-55fc-41b1-cf17-08da4a88cf06
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2359:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2359D4C24CA1B4F94A6C2C7098A69@DB6PR0401MB2359.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1wMW0CUHqst4T+uvn1CeRNUFLxeoMfQL8o/cKq9B0yP54wiUByIDz0B0GC8I35z7EL/fjY9LiTN9gYzQ02RWm82eKnVfgGbfRPPDfPrCZNOAjy4/m0rdoC3BH8DokPZ8S8UO+Nb97lxRo4v9q+pzN7MxgPwr51mLVevKfg77YnNuuKyggkXFxt3bcgiHuhlKmhqkJr9m5r5VcK1aCpJnLprL63VJOS8jn8ROvc/ZO/oGkOLsG8O4NFhBTd0kFcmwTK6tysWnlRf+UPg1DQGySzG1WB7sfe2g8pctIHNM8o6pAuvLdOpV06/4xiYR/qHuxJ3qzIUvOGLddBDLAkbSI2m5ZP/voCzznRij5urEascBx9TKK6VnodiR7AisnRBxXbShCAh3Q+hPikZfkmxaI4wMsdK7VVPzNSrYWPa11JKB9Mrl0kOEphHJ3kFi1Yyu+RottfRgrPLpfS71iWyQ85C/vVDy1a2oxsGC9WyUQUhQGCQ0f5UfSsdOLeJU4nGpwdmkpK3gtPF0RAvshk/TF4mhh1KhQLKcFkQafPaav7lim7U6sZXfCrO2wWgiIu/k9KUTz37GTH5cgTqNr86pHpfozadmd/Jks8gLtNZBLRXhBdOMrQDw/F9ZD4MDnN4wM2cn7yo9bXfWLnooyYQBETgCaEkbMWxtH/sfXAuMoWjuc4nF24Ofv4+YjWsMYMvEFq4vz8jarFXU9wqYsC8nx4CWh/Stgnjkp47qhrQxGerRhZD5UV5ULQpDT14VBoNjcuIovDZV5wsHWdUx8Pyo2A8027Hc3CGAO+g5rS0f8Z8F7kjbLz/Py+gKcOeB+ez
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(6512007)(508600001)(26005)(7416002)(6486002)(8936002)(966005)(186003)(5660300002)(6506007)(52116002)(2616005)(86362001)(45080400002)(2906002)(8676002)(66556008)(66476007)(83380400001)(36756003)(6916009)(4326008)(66946007)(38350700002)(38100700002)(6666004)(316002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pUNkxUaE1ZdnBkRWJDMnlNTVZ3TUFmTDlQb0tFQVE5Q1Vuc3paWmNqcFhy?=
 =?utf-8?B?YmpKTjFqc0JFUEJ6MVRKSHhvdDNOY0FENWVhV1FkTDRsTExRYnhMQksreDZ3?=
 =?utf-8?B?RHoyOGZuUC9KcUUybU15d0E0dy93YWtza1NpSG9nWjBEeXQ5RTM3dDVqWmpO?=
 =?utf-8?B?eTVNMStNRUFra1pHNDVrRDU0TXkxa1gzSU9vckpMUlhIUWhwbVlrWW03dW9E?=
 =?utf-8?B?UTV4c2tGckJZYmZzRmQvRERKN2RNTjdaOUNtd21qYTYyV2VLdzc4TFhHc3JW?=
 =?utf-8?B?TzIrNXJZdVZwV1VkeXQ1cHk1My95aFp5NlB2YUdHOGs2THZyV0N6ZWZqUytp?=
 =?utf-8?B?UFdqMFk1bm1RdTlpTjh2UWlHYXVXc2Z5WDJUNmpOZ3lBY2xWTkZaeE9Kc1RD?=
 =?utf-8?B?WWVDb3ZGOFBBOTI0S2FtOVR6cHd3R3ovNkoxVG5YWEhlZHc3RG95ekRKeHRY?=
 =?utf-8?B?TFhycmlJTjlqRjlRYWp0cW42cTNvSngzQ095WjEvRmFDQWdxQUlFd0laWkVL?=
 =?utf-8?B?Ni9KWHN2OWpKamRKYXBlZ3I2UjhDVlZha0paRU9yOEltYVZBd0xsZ2FkV1JS?=
 =?utf-8?B?cWRTdVNvTkd2NFgrdGdMQlluWHpaZmptNXRXckF0STIvZm51OXB1Y0FWekJK?=
 =?utf-8?B?OG9aZUxPRFdFOExHTUdUMWsyY1ZwRHlJQ3lLYnl3bTJucERqOUxUT0w0cXIw?=
 =?utf-8?B?UjU0d0lvMDZ2TGM4RGNubklINVo5SVRCRm04eUtSRUJWTEdzNHQrbnY3TzJs?=
 =?utf-8?B?aGZvOHQ4NzROeVpVdDcrc2o0aDBXd05zenFnUVJKVnVkRmh1bllxUmhKSXcw?=
 =?utf-8?B?N2JubG9VSVNIUGMyUHpnemFMaTVUdGFqSHdaOU9Pczg0ckVacFkvTk1hN0Mx?=
 =?utf-8?B?YkV3V0dDMGs2MUcyZU56Y1I5Vnc1Z0RFakthaXcwR3ZUejlLd1ByTXN0bDYx?=
 =?utf-8?B?dWQwM0RRcm5ORHFFd3RkNWxiVFhBMW8xMVhtdnJCRFdOV2IxWlFGUmFtZ0RI?=
 =?utf-8?B?YmljSjFIcFFQcGhGRCtoWHVzSFNkbjFPdit0Rnp0UDRuSUluSXhlMlVEUTVx?=
 =?utf-8?B?Nm1tem1TbVlIQnU1bDZiMUNkWWo4U1NlVEE0VzRzZXEwZkdxMUZnNVFVUjB5?=
 =?utf-8?B?bVpLdW5lT3QvWVJmQWtibllZS1IwVXJnekZ2eFk0SUlLc1Urd3FCcU92NlhT?=
 =?utf-8?B?Q1kxWUhYMDhJZ01DMjU5K2huaUNzOHVtU0p5ZlAzSTFSOWlRQ2NlQk1uZUxW?=
 =?utf-8?B?a2EyczNxU1FyNFBCckFDTWZud1ZlTmw1Mk9ZenZyZHBUMFFEa0pEaVhlMnBU?=
 =?utf-8?B?am0xeFUyWWV3UTQyeGxvbzdDbFZFY1B2dHpEWXF4T1FndmN5STlONjRNekkv?=
 =?utf-8?B?V3J6VWVNU090Z1B0Y1F4QVpNQzVEVU8vc1pZa1RoZFdyMjFOYXpFby8yL2pz?=
 =?utf-8?B?YlVwbldlM2lCdEgrbVJkMjVVK0JYM21VSlhqMG9YbXZvT21ZekNqYjFOOUZE?=
 =?utf-8?B?dlRkSk85T2J5Z01jajJpemtWODJJNk12b2xmUmJMd05lU1dZWm1MRXpsYmZM?=
 =?utf-8?B?WTJEN0tMNmZDOXc1VVlmUXNRelVYZEM1c3NKZUF4ZGtaNDZaVmVkYjRQcE1q?=
 =?utf-8?B?N3FuN00veXhNZHp2Slp0ZkdFem5UbjhJaEYwM1ZLRXpOSC9JeUd6MlozcStZ?=
 =?utf-8?B?aXh5eVIyV2pHd0FXeUhHbjhIV2M5VnVGdm1oUXIyZ3FjQjdURTJVVE5LRTNT?=
 =?utf-8?B?L2lZQUlOM1VaV2QxNHZqM3h0Y0tXRHFIN0lZN0xzK2cxa0V4V3NIUnZmajhE?=
 =?utf-8?B?Q1BPTzY5clZUVDNuK1pMOHFHM0YzNWVMZCtWeDA5blkxVEQwYjZzRjRlU0E1?=
 =?utf-8?B?SmMyTzdsWmMxb2Rjb243WXU1QjlUaWs2S056aEVpc3lSakxNK2VQMHFuZThl?=
 =?utf-8?B?M1F4dFNlYmdjNFc3Tll1TVFKT3FGL1FWN1FyNUdoL29iaWxscnBoMkVOa1o2?=
 =?utf-8?B?UVhWTkp1RlM2QjFYVUlvMGowbXp2eHhpd1FGR3M2RDlMNzlkcjd3V1hGQUNV?=
 =?utf-8?B?SGZLYzA2TGZzQURWVzBwazVFc01RL0FpVWlhK2VTTVk5Z0hDT3FHZEg1WnFv?=
 =?utf-8?B?M2NvN2RuQW1SQy9yeTNuenFSNWpyN3VtSnZZNnM4cDFJTXFERk9idkRPRFEr?=
 =?utf-8?B?dzVFR3psc1QwWjRvYTZvektwQUlBRFA1MnljbWl6eXZnUE9OODdPOWFhWlc2?=
 =?utf-8?B?Yi9VT2J5ZnlZNlE4OGdaeDEwSDA3ME5QUHJPMTdiaFd1dmk2ZTBpZkU4ZTJk?=
 =?utf-8?B?SU1OMWpGUDExSmtQbWdrTWVXanhwRlJ2MUVjV2tmTkFXQTdRdzhvZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02e4dfb-55fc-41b1-cf17-08da4a88cf06
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 02:27:47.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nq3zNFgs1g+rNcampXPziqo02o+uCwrFCpv7Bzu4Ys6vgdF57dNEvF6jc21K2E9Uo+tlcxWCenhYOt3PlxDfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, 2022-06-09 at 12:32 +0300, Laurent Pinchart wrote:
> Hi Liu,
> 
> On Thu, Jun 09, 2022 at 02:49:17PM +0800, Liu Ying wrote:
> > Hi,
> > 
> > This is the v8 series to add some DRM bridge drivers support
> > for i.MX8qm/qxp SoCs.
> > 
> > The bridges may chain one by one to form display pipes to support
> > LVDS displays.  The relevant display controller is DPU embedded in
> > i.MX8qm/qxp SoCs.
> > 
> > The DPU KMS driver can be found at:
> > 
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Fdri-devel%2Flist%2F%3Fseries%3D629908%26state%3D%252A%26archive%3Dboth&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C52bc453b59654345591f08da49faf477%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637903639438033239%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&amp;sdata=ciw5SX%2FdUHu5z6tVpY383LBxkWmEoFu03ljhrkKsj%2FQ%3D&amp;reserved=0
> > 
> > This series supports the following display pipes:
> > 1) i.MX8qxp:
> > prefetch eng -> DPU -> pixel combiner -> pixel link ->
> > pixel link to DPI(PXL2DPI) -> LVDS display bridge(LDB)
> > 
> > 2) i.MX8qm:
> > prefetch eng -> DPU -> pixel combiner -> pixel link -> LVDS display
> > bridge(LDB)
> > 
> > 
> > Patch 1/14 and 2/14 add bus formats used by pixel combiner.
> > 
> > Patch 9/14 adds a helper for LDB bridge drivers.
> > 
> > Patch 3/14 ~ 8/14 and 10/14 ~ 12/14 add drm bridge drivers and
> > dt-bindings support for the bridges.
> > 
> > Patch 13/14 adds dt-binding for Control and Status Registers
> > module(a syscon
> > used by PXL2DPI and LDB), which references the PXL2DPI and LDB
> > schemas.
> > 
> > Patch 14/14 updates MAINTAINERS.
> > 
> > 
> > I've tested this series with a koe,tx26d202vm0bwa dual link LVDS
> > panel and
> > a LVDS to HDMI bridge(with a downstream drm bridge driver).
> > 
> > Marcel Ziswiler has tested v6 with two LVDS panels(single link
> > LT170410-2WHC
> > and dual link LP156WF1) on Toradex Colibri iMX8X.
> > 
> > 
> > Welcome comments, thanks.
> 
> I'm not sure if this comment will be welcome, but what's the reason
> to
> handle the pixel combiner and pixel link (DPL) as bridges ? They seem
> very tightly couple with the display controller, wouldn't it be
> better
> to handle them in the display controller driver ?

i.MX8qxp display controller, pixel combiner and pixel link are
standalone IPs. i.MX8qxp reference manual has separate chapters for
them.  Not sure if pixel combiner and/or pixel link will be used to
work with other display controllers in future SoCs. So, it looks
appropriate to take them as separate bridges. 

Regards,
Liu Ying

