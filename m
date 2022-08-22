Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816C759BE64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiHVLYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiHVLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:24:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B6BA456;
        Mon, 22 Aug 2022 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661167471; x=1692703471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qOb/9v39lpBJY999yCqcnnw3i3syPgVwvp0QcceLLJM=;
  b=m/WQ4R2hn4yzRCOhT659Zf56gfaMEw4cEC/dA12nfOvRN7C7NuOvlZGY
   3tzQP/7UljK8GI4T3dBeAtjVUcNxnHVfVtoobYnAhgMDOaoy5qVsHAPC/
   ICKQkrh5fu6K2hqCJDajN9vzkXVv+ccf+2RQx7h7EQCRUszSJoc3qeDv7
   ruUuDkIo+dpgMEmGtZkXH7qnt639a/MS1iXCZRNHHWv4nM8QUQanqoMhO
   odVHFhs+THIkfCNW21nacAanTpFIcnyqcakT1blRFSWyZSCC8F1H8nD3L
   LLfVL3EqhTCOPVhF/bcJswBulc0gx3+TtCagRbBTOCmIhx6IbhFD7QjzU
   A==;
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="177209832"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2022 04:24:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 22 Aug 2022 04:24:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 22 Aug 2022 04:24:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNc9yNJ3N9/uMo5R4j6V5aCcPHweEm5FSxKscXdMcWMfVrx9jUf6A+ByPF9DPMtCjqrdxtU2RJGtIGWIQJu65JJ58xeVdJzF7Ts305qgOJ8Q1op8LLvodbxredEsswP4E7euWHpqMMDAsRPZ+KVp0KvoyVJO32wgStGxydKcq8E1Uz47LOIaF5ke+IKTRPBxfqhL/FFfmI4f65cof63lfHexKY3SJTtH/XH6w5E9fB/pMd4zjlkXwN0IYNEtLpD/rwaJ3W0YY3dhGn/UAmf5fNSPaTIQFGcesq4n/j0yAen3QzmwOLOq7GnwvN+NDvakOfJSyEbWsZXOJxSlOsx3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GA7oXNiaf9jGUS1WzjuOlD0PgIHoqVMG4Mg9PDoqg3Q=;
 b=QTUa1gtrZUiceFxp+LoIREBBefH8CI86/49V+i7WDjqQIemRx8wPromjsL1netrXBzu62LRIVXvAku2T2hmrFNfBOU4OqiqRM4ekEMQrqTUkUjDfqFT+GzMNtmex5/2xIMUuK98BRytUsg51Cya2pCE1VpXuWvkE9nWy8hBTKXyhzCQxya/3FkTKURh92DsQLacnyxoy8TpWN+xBnYeM88FSd5VK/gYvIJ2FV2Z3E2HvjVlCa7dxVxNOPj7FNKv4u6LD1ZdSI6rUcIcaJv4z/6rt0czNQg2y1QpqTzdB6PUPKihHc9ea5uNHyxNgmt6ioAxlQl3skSQn/BxzVfHMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA7oXNiaf9jGUS1WzjuOlD0PgIHoqVMG4Mg9PDoqg3Q=;
 b=dCBEKERdJM1LGeMSzI2kkzMjD5+8kz5+Z367Ws2SoMm/LgfQNYwHSHj59R451RkJZHdhzLE1himXMWDgtT7ShEKg/yoH2Wkhf88w6ccbN9DeCFiYI/Vpqb31kFzpCkFsccXiDBPvkw+Pqqv4XDxICzxol62jJMNlVGLDmnLu2k8=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by BL0PR11MB3009.namprd11.prod.outlook.com (2603:10b6:208:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 11:24:20 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::7c9d:aca0:3e96:9d31]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::7c9d:aca0:3e96:9d31%7]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 11:24:19 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Conor.Dooley@microchip.com>, <Prakash.Battu@microchip.com>,
        <Shravan.Chippa@microchip.com>
Subject: RE: [PATCH] media: i2c: imx334: support lower bandwidth mode
Thread-Topic: [PATCH] media: i2c: imx334: support lower bandwidth mode
Thread-Index: AQHYokuec/+v1WSzCEujSBRQqx3PWq267h0g
Date:   Mon, 22 Aug 2022 11:24:19 +0000
Message-ID: <PH0PR11MB56114A18924CAA6B9684129281719@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20220728063044.19276-1-shravan.chippa@microchip.com>
In-Reply-To: <20220728063044.19276-1-shravan.chippa@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f1ea95-e834-4283-96ea-08da8430db33
x-ms-traffictypediagnostic: BL0PR11MB3009:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJ9URnzZxnNwl6dFHf+w4oegOa+8wuyvCl5w4z1IBEyVovj6ICxTlOs/l/Ad05XaoN91EhXI+pQtuPFjs5RZVZn2qg9tIOJFldy6g1dWl54cqHYsPXPpuX6xmMWBeFEshI/sLgefFfEGQEStDlAuqIGLNbuzrCe0C0INWFTcvrSsZ1YWj9RVcF/+hxpL4sxgGrh7ONBVtX7UfW+mBG1HXcbK/nsnWU5PVoQPofCEtP4pQ+YAWLov9QQMh5WN1GiyRqSBfCaboRbQWfF8vfUoDPltcr7HEJqbOZLOGN3f6avoyAF/MdTgaSS2R/+iQLvj/VoH+cPOMISvRFZKxJmmR/8aDCIH0S01uf1xFsyN5if6l51FEFBpBjMBcjFt8x4L8iw6tdfrjjfAueyOglnSQLF4ErrsJ7kQNNFfA89gFrgsz+y+y0LWgGbPrhOZ+mcFd2Cc5Vw5vftT1JNV1XKjv/Hqnuq7t0OAWS/VQfa6Qf/jOjIbs5hJJy9lZep0TbgsWGRunCCVtHEdm8I7tpIBJ3l3rMRhG7oP/+ElDOAfIetgJCtT2nQh/DXRIlQF9PbUv+diBDWgdishXGg/wOnuGIZfxIXFojSankpGEN+EcLblsaUEiPtr0Y2riuVqvQ7P4YsLe9BRewktZvBzndTcs1hzVORc0punfL/RR8/6IjY4kPO1wV5Hp1T6lRmBuMjveBE8stR3UhNxaaOsITtbN9fO8YJv1Pn4WpPwTOPoZxdfUiLGjfCqCNoaNlzQ5EE9obW6g1yjdcfeCXhoghqhEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(136003)(39860400002)(376002)(38070700005)(83380400001)(55016003)(38100700002)(122000001)(64756008)(33656002)(66446008)(8676002)(4326008)(66946007)(66476007)(66556008)(76116006)(71200400001)(8936002)(26005)(5660300002)(30864003)(52536014)(7696005)(53546011)(9686003)(316002)(478600001)(54906003)(41300700001)(110136005)(86362001)(186003)(2906002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6VE56wKFHlaUx69nJ+t5ETbQ7Q79qJLbnz4RCGxM7pAi8hj1VA9/zp7Selo8?=
 =?us-ascii?Q?NOMBma4HQABb2dN8IiHYJ5AG4tEyMMBZFo8B4E//0EI2jfPI0cx2PU1w92Oz?=
 =?us-ascii?Q?lQdJoEZ2vRiXnbG7hMwsLabiecRDz+/q4eXCFQ68hZIdUwPfMjwvL9SaH9n/?=
 =?us-ascii?Q?1Sq2K63r5jDI9y/0boikBqqdTCfq5+JpzwSG+EZ9BMCJWbRjwgLwyyRFGx2M?=
 =?us-ascii?Q?59d6dSGmcFR6QXRuvPuSKAy6iJhPC42hAvWLL5Pp89HWETocB69abxI40XCH?=
 =?us-ascii?Q?X6U/m3sMZ3qThRATzkavxZMGekqIFURtCfVX1HfRh1ZkpTVbWpEQTxSepHoV?=
 =?us-ascii?Q?3HPhGZacna2jPLpQWvC51u60H5enszkx4RHB067IPpHBVkR/GjjO11XmAX99?=
 =?us-ascii?Q?EQTk9wmoKOm9Qqe5TECXZzeoUyFPx5KzYBo1Bmy2CP+CsbUH0wsdkO1799/L?=
 =?us-ascii?Q?sLhP606xZxFiuO7RKsl5ePFK3MyGk3hiuxbYPSWx097Cb8rPZoEkUO6AhDn2?=
 =?us-ascii?Q?cj3+fMUe3iXyT/nppnmyvcfWKHcR/rg3/H6WRLEiqnqph7BL1h85cRO93ux+?=
 =?us-ascii?Q?to3FQMri3zlMNnSHfK50EqcBWhzqI8kRr1JBLV3p+0eoJNNSO/iQqY/H82y2?=
 =?us-ascii?Q?wO3Ef3dSYePzg9oeFEIxrS3nvXEbeCJwsMkKcZ9xUeFfIkz3SebqBoBlaDIp?=
 =?us-ascii?Q?uoMJF6DLVkubGqv8uVYq5pxfkZDb8lf6HN8Iv7xjFu5E7pVbXuHWIxVXCYeB?=
 =?us-ascii?Q?rgLkez/YwWUzCn74U/o9gW8TeY6RyAmHuX8G2NMtGIvcLH8kJtxUuq3KAHvp?=
 =?us-ascii?Q?GDoA24YOK4UJUP80RIDpS9grlWS1zI6DrgUudyqLJ6RkBPe8obzAebQOylgp?=
 =?us-ascii?Q?PTSjSrHVqNxxxCaZNLLYr9giyiU0sy2m3uJ/0RXNSMnMxIvu2mWM2EudW6BE?=
 =?us-ascii?Q?9Ku3ihK32bZ6NOFcqr3Vp82IyqYCQWz6qOmEzBSa+rSZZ80AoYX0xzFft63R?=
 =?us-ascii?Q?m+7kz6UNjA8fXcI4HYq5m+iZvMMwaj6dkAbR/VtMholqCUeA32pl2AoqQRAO?=
 =?us-ascii?Q?YEVRkc1DgRhXIHEVl40o2JwZHCB8mPlYTt9Gw77XcfuD8gmzbR1qiLTJ4l+O?=
 =?us-ascii?Q?i1UskJoDq204zvFI5Bt8zWKmz2idA4lBRpmQgcB/vKuGZ+cPLLxvJWjFPhqC?=
 =?us-ascii?Q?m5YwbVQL1CaQCYfeShQU0b37G2opuDTj8eowkifg3QBMPfOtaQOcSlcECPf4?=
 =?us-ascii?Q?rfP/9ivR0JMcakMfzQVBDiqotQqqP2k5c+FKwXmRcKOdm6RSaoM3YJy5EZmE?=
 =?us-ascii?Q?9gSFpK+AFWIKYiyWDEqRArxGysvqDi3GNNNFUoW9qk3kSP4ia+tk5ibJwaVm?=
 =?us-ascii?Q?TNL07EB36TbiFVPV2QhbdhGFAf7hhTcc8qysenbLzLiM3Y8xm6Nl86wG+Nms?=
 =?us-ascii?Q?pzNe7ZEfuClg+rDNmiakuBbNmIxL21ahRmy4mAlCGNuDkTYx1XY/+hq1RARR?=
 =?us-ascii?Q?L6Td23Un5k0oDVAT359Com3Q0RS7mLzQHT9OMxxPx55t7HDF0JqI/IWQD7Xz?=
 =?us-ascii?Q?ggfzGyyYmqsxvy/4t75jH6fFSgctLqPraB9ETaRlCyxDQzgqUASHayhmucOr?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f1ea95-e834-4283-96ea-08da8430db33
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 11:24:19.6765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9QjhH3f1dYw3Yor5TQrpoa8ChAaTV1wPfszMb32NwXSNAUnjlJL69y+nqMMKnMsARuXKWwME6oHSByHjZMo/WU9+93neCMOTI2HqIXOHsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3009
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping!

Thanks,
Shravan.

> -----Original Message-----
> From: shravan kumar <shravan.chippa@microchip.com>
> Sent: 28 July 2022 12:01 PM
> To: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org
> Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org; shravan
> Chippa - I35088 <Shravan.Chippa@microchip.com>; Conor Dooley - M52691
> <Conor.Dooley@microchip.com>; Battu Prakash Reddy - I30399
> <Prakash.Battu@microchip.com>
> Subject: [PATCH] media: i2c: imx334: support lower bandwidth mode
>=20
> From: Shravan Chippa <shravan.chippa@microchip.com>
>=20
> Some platforms may not be capable of supporting the bandwidth required
> for 12 bit or 3840x2160 resolutions.
>=20
> Add support for dynamically selecting 10 bit and 1920x1080 resolutions wh=
ile
> leaving the existing configuration as default
>=20
> CC: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Prakash Battu <Prakash.Battu@microchip.com>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 306
> +++++++++++++++++++++++++++++++++----
>  1 file changed, 279 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c inde=
x
> 062125501788..d1fa4c4d4d9e 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -79,7 +79,6 @@ struct imx334_reg_list {
>   * struct imx334_mode - imx334 sensor mode structure
>   * @width: Frame width
>   * @height: Frame height
> - * @code: Format code
>   * @hblank: Horizontal blanking in lines
>   * @vblank: Vertical blanking in lines
>   * @vblank_min: Minimal vertical blanking in lines @@ -91,7 +90,6 @@ str=
uct
> imx334_reg_list {  struct imx334_mode {
>  	u32 width;
>  	u32 height;
> -	u32 code;
>  	u32 hblank;
>  	u32 vblank;
>  	u32 vblank_min;
> @@ -119,6 +117,7 @@ struct imx334_mode {
>   * @vblank: Vertical blanking in lines
>   * @cur_mode: Pointer to current selected sensor mode
>   * @mutex: Mutex for serializing sensor controls
> + * @cur_code: current selected format code
>   * @streaming: Flag indicating streaming state
>   */
>  struct imx334 {
> @@ -140,6 +139,7 @@ struct imx334 {
>  	u32 vblank;
>  	const struct imx334_mode *cur_mode;
>  	struct mutex mutex;
> +	u32 cur_code;
>  	bool streaming;
>  };
>=20
> @@ -147,6 +147,169 @@ static const s64 link_freq[] =3D {
>  	IMX334_LINK_FREQ,
>  };
>=20
> +/* Sensor mode registers */
> +static const struct imx334_reg mode_1920x1080_regs[] =3D {
> +	{0x3000, 0x01},
> +	{0x3018, 0x04},
> +	{0x3030, 0xCA},
> +	{0x3031, 0x08},
> +	{0x3032, 0x00},
> +	{0x3034, 0x4C},
> +	{0x3035, 0x04},
> +	{0x302C, 0xF0},
> +	{0x302D, 0x03},
> +	{0x302E, 0x80},
> +	{0x302F, 0x07},
> +	{0x3074, 0xCC},
> +	{0x3075, 0x02},
> +	{0x308E, 0xCD},
> +	{0x308F, 0x02},
> +	{0x3076, 0x38},
> +	{0x3077, 0x04},
> +	{0x3090, 0x38},
> +	{0x3091, 0x04},
> +	{0x3308, 0x38},
> +	{0x3309, 0x04},
> +	{0x30C6, 0x00},
> +	{0x30C7, 0x00},
> +	{0x30CE, 0x00},
> +	{0x30CF, 0x00},
> +	{0x30D8, 0x18},
> +	{0x30D9, 0x0A},
> +	{0x304C, 0x00},
> +	{0x304E, 0x00},
> +	{0x304F, 0x00},
> +	{0x3050, 0x00},
> +	{0x30B6, 0x00},
> +	{0x30B7, 0x00},
> +	{0x3116, 0x08},
> +	{0x3117, 0x00},
> +	{0x31A0, 0x20},
> +	{0x31A1, 0x0F},
> +	{0x300C, 0x3B},
> +	{0x300D, 0x29},
> +	{0x314C, 0x29},
> +	{0x314D, 0x01},
> +	{0x315A, 0x0A},
> +	{0x3168, 0xA0},
> +	{0x316A, 0x7E},
> +	{0x319E, 0x02},
> +	{0x3199, 0x00},
> +	{0x319D, 0x00},
> +	{0x31DD, 0x03},
> +	{0x3300, 0x00},
> +	{0x341C, 0xFF},
> +	{0x341D, 0x01},
> +	{0x3A01, 0x03},
> +	{0x3A18, 0x7F},
> +	{0x3A19, 0x00},
> +	{0x3A1A, 0x37},
> +	{0x3A1B, 0x00},
> +	{0x3A1C, 0x37},
> +	{0x3A1D, 0x00},
> +	{0x3A1E, 0xF7},
> +	{0x3A1F, 0x00},
> +	{0x3A20, 0x3F},
> +	{0x3A21, 0x00},
> +	{0x3A20, 0x6F},
> +	{0x3A21, 0x00},
> +	{0x3A20, 0x3F},
> +	{0x3A21, 0x00},
> +	{0x3A20, 0x5F},
> +	{0x3A21, 0x00},
> +	{0x3A20, 0x2F},
> +	{0x3A21, 0x00},
> +	{0x3078, 0x02},
> +	{0x3079, 0x00},
> +	{0x307A, 0x00},
> +	{0x307B, 0x00},
> +	{0x3080, 0x02},
> +	{0x3081, 0x00},
> +	{0x3082, 0x00},
> +	{0x3083, 0x00},
> +	{0x3088, 0x02},
> +	{0x3094, 0x00},
> +	{0x3095, 0x00},
> +	{0x3096, 0x00},
> +	{0x309B, 0x02},
> +	{0x309C, 0x00},
> +	{0x309D, 0x00},
> +	{0x309E, 0x00},
> +	{0x30A4, 0x00},
> +	{0x30A5, 0x00},
> +	{0x3288, 0x21},
> +	{0x328A, 0x02},
> +	{0x3414, 0x05},
> +	{0x3416, 0x18},
> +	{0x35AC, 0x0E},
> +	{0x3648, 0x01},
> +	{0x364A, 0x04},
> +	{0x364C, 0x04},
> +	{0x3678, 0x01},
> +	{0x367C, 0x31},
> +	{0x367E, 0x31},
> +	{0x3708, 0x02},
> +	{0x3714, 0x01},
> +	{0x3715, 0x02},
> +	{0x3716, 0x02},
> +	{0x3717, 0x02},
> +	{0x371C, 0x3D},
> +	{0x371D, 0x3F},
> +	{0x372C, 0x00},
> +	{0x372D, 0x00},
> +	{0x372E, 0x46},
> +	{0x372F, 0x00},
> +	{0x3730, 0x89},
> +	{0x3731, 0x00},
> +	{0x3732, 0x08},
> +	{0x3733, 0x01},
> +	{0x3734, 0xFE},
> +	{0x3735, 0x05},
> +	{0x375D, 0x00},
> +	{0x375E, 0x00},
> +	{0x375F, 0x61},
> +	{0x3760, 0x06},
> +	{0x3768, 0x1B},
> +	{0x3769, 0x1B},
> +	{0x376A, 0x1A},
> +	{0x376B, 0x19},
> +	{0x376C, 0x18},
> +	{0x376D, 0x14},
> +	{0x376E, 0x0F},
> +	{0x3776, 0x00},
> +	{0x3777, 0x00},
> +	{0x3778, 0x46},
> +	{0x3779, 0x00},
> +	{0x377A, 0x08},
> +	{0x377B, 0x01},
> +	{0x377C, 0x45},
> +	{0x377D, 0x01},
> +	{0x377E, 0x23},
> +	{0x377F, 0x02},
> +	{0x3780, 0xD9},
> +	{0x3781, 0x03},
> +	{0x3782, 0xF5},
> +	{0x3783, 0x06},
> +	{0x3784, 0xA5},
> +	{0x3788, 0x0F},
> +	{0x378A, 0xD9},
> +	{0x378B, 0x03},
> +	{0x378C, 0xEB},
> +	{0x378D, 0x05},
> +	{0x378E, 0x87},
> +	{0x378F, 0x06},
> +	{0x3790, 0xF5},
> +	{0x3792, 0x43},
> +	{0x3794, 0x7A},
> +	{0x3796, 0xA1},
> +	{0x37B0, 0x37},
> +	{0x3E04, 0x0E},
> +	{0x30E8, 0x50},
> +	{0x30E9, 0x00},
> +	{0x3E04, 0x0E},
> +	{0x3002, 0x00},
> +};
> +
>  /* Sensor mode registers */
>  static const struct imx334_reg mode_3840x2160_regs[] =3D {
>  	{0x3000, 0x01},
> @@ -243,20 +406,57 @@ static const struct imx334_reg
> mode_3840x2160_regs[] =3D {
>  	{0x3a00, 0x01},
>  };
>=20
> +static const struct imx334_reg raw10_framefmt_regs[] =3D {
> +	{0x3050, 0x00},
> +	{0x319D, 0x00},
> +	{0x341C, 0xFF},
> +	{0x341D, 0x01},
> +};
> +
> +static const struct imx334_reg raw12_framefmt_regs[] =3D {
> +	{0x3050, 0x01},
> +	{0x319D, 0x01},
> +	{0x341C, 0x47},
> +	{0x341D, 0x00},
> +};
> +
> +/*
> + * The supported BUS formats.
> + */
> +static const u32 codes[] =3D {
> +	MEDIA_BUS_FMT_SRGGB10_1X10,
> +	MEDIA_BUS_FMT_SRGGB12_1X12,
> +};
> +
>  /* Supported sensor mode configurations */ -static const struct
> imx334_mode supported_mode =3D {
> -	.width =3D 3840,
> -	.height =3D 2160,
> -	.hblank =3D 560,
> -	.vblank =3D 2340,
> -	.vblank_min =3D 90,
> -	.vblank_max =3D 132840,
> -	.pclk =3D 594000000,
> -	.link_freq_idx =3D 0,
> -	.code =3D MEDIA_BUS_FMT_SRGGB12_1X12,
> -	.reg_list =3D {
> -		.num_of_regs =3D ARRAY_SIZE(mode_3840x2160_regs),
> -		.regs =3D mode_3840x2160_regs,
> +static const struct imx334_mode supported_modes[] =3D {
> +	{
> +		.width =3D 1920,
> +		.height =3D 1080,
> +		.hblank =3D 280,
> +		.vblank =3D 1170,
> +		.vblank_min =3D 90,
> +		.vblank_max =3D 132840,
> +		.pclk =3D 594000000,
> +		.link_freq_idx =3D 0,
> +		.reg_list =3D {
> +			.num_of_regs =3D
> ARRAY_SIZE(mode_1920x1080_regs),
> +			.regs =3D mode_1920x1080_regs,
> +		},
> +	},
> +	{
> +		.width =3D 3840,
> +		.height =3D 2160,
> +		.hblank =3D 560,
> +		.vblank =3D 2340,
> +		.vblank_min =3D 90,
> +		.vblank_max =3D 132840,
> +		.pclk =3D 594000000,
> +		.link_freq_idx =3D 0,
> +		.reg_list =3D {
> +			.num_of_regs =3D
> ARRAY_SIZE(mode_3840x2160_regs),
> +			.regs =3D mode_3840x2160_regs,
> +		},
>  	},
>  };
>=20
> @@ -382,7 +582,8 @@ static int imx334_update_controls(struct imx334
> *imx334,
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D __v4l2_ctrl_s_ctrl(imx334->hblank_ctrl, mode->hblank);
> +	ret =3D __v4l2_ctrl_modify_range(imx334->hblank_ctrl,
> IMX334_REG_MIN,
> +				       IMX334_REG_MAX, 1, mode->hblank);
>  	if (ret)
>  		return ret;
>=20
> @@ -506,10 +707,10 @@ static int imx334_enum_mbus_code(struct
> v4l2_subdev *sd,
>  				 struct v4l2_subdev_state *sd_state,
>  				 struct v4l2_subdev_mbus_code_enum
> *code)  {
> -	if (code->index > 0)
> +	if (code->index >=3D ARRAY_SIZE(codes))
>  		return -EINVAL;
>=20
> -	code->code =3D supported_mode.code;
> +	code->code =3D codes[code->index];
>=20
>  	return 0;
>  }
> @@ -526,15 +727,20 @@ static int imx334_enum_frame_size(struct
> v4l2_subdev *sd,
>  				  struct v4l2_subdev_state *sd_state,
>  				  struct v4l2_subdev_frame_size_enum
> *fsize)  {
> -	if (fsize->index > 0)
> +	int i;
> +
> +	if (fsize->index >=3D ARRAY_SIZE(supported_modes))
>  		return -EINVAL;
>=20
> -	if (fsize->code !=3D supported_mode.code)
> +	for (i =3D 0; i < ARRAY_SIZE(codes); i++) {
> +		if (codes[i] =3D=3D fsize->code)
> +			break;
>  		return -EINVAL;
> +	}
>=20
> -	fsize->min_width =3D supported_mode.width;
> +	fsize->min_width =3D supported_modes[fsize->index].width;
>  	fsize->max_width =3D fsize->min_width;
> -	fsize->min_height =3D supported_mode.height;
> +	fsize->min_height =3D supported_modes[fsize->index].height;
>  	fsize->max_height =3D fsize->min_height;
>=20
>  	return 0;
> @@ -553,7 +759,7 @@ static void imx334_fill_pad_format(struct imx334
> *imx334,  {
>  	fmt->format.width =3D mode->width;
>  	fmt->format.height =3D mode->height;
> -	fmt->format.code =3D mode->code;
> +	fmt->format.code =3D imx334->cur_code;
>  	fmt->format.field =3D V4L2_FIELD_NONE;
>  	fmt->format.colorspace =3D V4L2_COLORSPACE_RAW;
>  	fmt->format.ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT; @@ -591,6
> +797,18 @@ static int imx334_get_pad_format(struct v4l2_subdev *sd,
>  	return 0;
>  }
>=20
> +static int imx219_get_format_code(struct imx334 *imx334, struct
> +v4l2_subdev_format *fmt) {
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(codes); i++) {
> +		if (codes[i] =3D=3D fmt->format.code)
> +			return codes[i];
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /**
>   * imx334_set_pad_format() - Set subdevice pad format
>   * @sd: pointer to imx334 V4L2 sub-device structure @@ -606,10 +824,21
> @@ static int imx334_set_pad_format(struct v4l2_subdev *sd,
>  	struct imx334 *imx334 =3D to_imx334(sd);
>  	const struct imx334_mode *mode;
>  	int ret =3D 0;
> +	u32 code;
>=20
>  	mutex_lock(&imx334->mutex);
>=20
> -	mode =3D &supported_mode;
> +	code =3D imx219_get_format_code(imx334, fmt);
> +	if (code < 0)
> +		return -EINVAL;
> +
> +	imx334->cur_code =3D code;
> +
> +	mode =3D v4l2_find_nearest_size(supported_modes,
> +				      ARRAY_SIZE(supported_modes),
> +				      width, height,
> +				      fmt->format.width, fmt->format.height);
> +
>  	imx334_fill_pad_format(imx334, mode, fmt);
>=20
>  	if (fmt->which =3D=3D V4L2_SUBDEV_FORMAT_TRY) { @@ -617,7 +846,7
> @@ static int imx334_set_pad_format(struct v4l2_subdev *sd,
>=20
>  		framefmt =3D v4l2_subdev_get_try_format(sd, sd_state, fmt-
> >pad);
>  		*framefmt =3D fmt->format;
> -	} else {
> +	} else if (imx334->cur_mode !=3D mode) {
>  		ret =3D imx334_update_controls(imx334, mode);
>  		if (!ret)
>  			imx334->cur_mode =3D mode;
> @@ -642,11 +871,26 @@ static int imx334_init_pad_cfg(struct v4l2_subdev
> *sd,
>  	struct v4l2_subdev_format fmt =3D { 0 };
>=20
>  	fmt.which =3D sd_state ? V4L2_SUBDEV_FORMAT_TRY :
> V4L2_SUBDEV_FORMAT_ACTIVE;
> -	imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> +	imx334_fill_pad_format(imx334, &supported_modes[1], &fmt);
>=20
>  	return imx334_set_pad_format(sd, sd_state, &fmt);  }
>=20
> +static int imx334_set_framefmt(struct imx334 *imx334) {
> +	switch (imx334->cur_code) {
> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
> +		return imx334_write_regs(imx334, raw10_framefmt_regs,
> +
> 	ARRAY_SIZE(raw10_framefmt_regs));
> +
> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
> +		return imx334_write_regs(imx334, raw12_framefmt_regs,
> +
> 	ARRAY_SIZE(raw12_framefmt_regs));
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /**
>   * imx334_start_streaming() - Start sensor stream
>   * @imx334: pointer to imx334 device
> @@ -667,6 +911,13 @@ static int imx334_start_streaming(struct imx334
> *imx334)
>  		return ret;
>  	}
>=20
> +	ret =3D imx334_set_framefmt(imx334);
> +	if (ret) {
> +		dev_err(imx334->dev, "%s failed to set frame format: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
>  	/* Setup handler will write actual exposure and gain */
>  	ret =3D  __v4l2_ctrl_handler_setup(imx334->sd.ctrl_handler);
>  	if (ret) {
> @@ -1037,7 +1288,8 @@ static int imx334_probe(struct i2c_client *client)
>  	}
>=20
>  	/* Set default mode to max resolution */
> -	imx334->cur_mode =3D &supported_mode;
> +	imx334->cur_mode =3D &supported_modes[1];
> +	imx334->cur_code =3D codes[1];
>  	imx334->vblank =3D imx334->cur_mode->vblank;
>=20
>  	ret =3D imx334_init_controls(imx334);
> --
> 2.17.1

