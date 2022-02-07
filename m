Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A2E4AB321
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344367AbiBGBbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiBGBbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:31:12 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D85C061348;
        Sun,  6 Feb 2022 17:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQh9XQuUVCpTAObG1RSqE1ShQytYOEdL+ZMMOrhn0RzwvFAZVFv7x2APzU6Of1vvLhdaVxpGlsirMGgzu/6D02HPTguWspDC7bltH9lD11voN6ZpyHimC89+I95FeaTcLIClwbx1b9j2jrV+v5pHNIjIS0ieFIkqBOtFXB4tJeUjq5/ozXNNyBLJm52CEBt4KQW1jEOO/sdlA7Mnj4gR6KFcycANV/qNnuPvFk33gXgQ+VlxpfxRp/dteTj3KXAk9O5ctdKfmFXZbHMkz7ze4irHD0YE+6DxM67gTvc5PgHss2Cn0NcOqa2rWfKyQJLzxcwi+T1gZ5VJyTigrg6dRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z0bGtqz90WLmaFdWV9JZu4kURgKn3y0sbsv8XpXmws=;
 b=enoZ7fRLTFYpqlPawVFKP7IClp7sE4U17cSc+RaZlqVYe7KlMSOgOm+OfYDGv6b/SwEs5wVHbyFgZRjOAi3KdcH4sulbSYog2UiEGa2AC7mAEwM+ZRN9BuieJV5OMDOUeCdtpmh9k/xrLz1eRsfHga32a4iEMQSa4SYNPVIoCDD9Z8/vz5qOnrd7I2trFVS+OXuSDU4eMVHEXlENaoYIM66XOuqERa6UC9xcgTxLSLaxX9Eang4QdPpgBCFCBXTKQgZ068cU54mi8Gud7e05CBNxwA6l8LVmBLO1S11uurjK0RnkI74dT72uQajecMVSwQlBnwAJSgTyJZ7EvOHIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z0bGtqz90WLmaFdWV9JZu4kURgKn3y0sbsv8XpXmws=;
 b=rSCjLJv02DCDIdzsX5zpzzyrx8AW2N5l16QZFhwpiSc8MsWNhXZ0EzvbcbijKe0cHcDqHbKTXOznbaH+9Zdmp0LG8pe2eDbuk/glZXccCDD1FhUEgHf++VaYG6UaLfF5r1vZhkW3cr8Zx5z/m/GiPsxNO0Q10Hbo/p9RJY9dqJ8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 01:31:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 01:31:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] remoteproc: support self recovery after rproc crash
Thread-Topic: [PATCH V2] remoteproc: support self recovery after rproc crash
Thread-Index: AQHYEpIEHEs++qV8cUuKksCGalsIFKyHX5gw
Date:   Mon, 7 Feb 2022 01:31:07 +0000
Message-ID: <DU0PR04MB94176981E1D8F54557317513882C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220126085120.3397450-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220126085120.3397450-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60acae19-6675-4489-42fe-08d9e9d9838a
x-ms-traffictypediagnostic: DU0PR04MB9495:EE_
x-microsoft-antispam-prvs: <DU0PR04MB9495E06D005F3281E1D853AE882C9@DU0PR04MB9495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ulva7wQUYhRrq7T/Mizl4Bw9ryH0u0RxS5rY0e5OvbX/SZrx7Dqq2lPw3MPhqmS0SvyxCQxCxNmIM1/JmoiT8L5gMkPs9GWASReJL+0gJv4eDS9XcHOJdZ39+NySLECc1JLiE23mDIDlZ2wDJPNLMZoEPhRHpD0Lz3vP7fltWv9H6BRN/k/rZ6yRUMhdeEfYn6dpgb+vPBptBy+ZDEXnWYyu2cBqSMShZ+zoHDrutIvwlrkxiU0jqRNjiWTTognVHJOKp0mFQeHqEVZS18yLf96v4TUn2h2n3Iwiqj94cGIHWYYdMakO0SdpM/Z2HYx+wAhSZXtCAE2hzg+/A6B1m9AUdvbpWjDIO5GS4mjbGxc3QtBv+T0j4nFg0qylIPr6LSFISYJg5VdKnxmf8aMm7/kHNZX2vzZdYTUxIiM/mcM7b1vbD5JkMw0Uv7pxmjIScJRJF4aMpYGSxGX2QBMHqZvTneV+LqVzvy9i4czCi0vt13phchuQx1MlU6OYL8rg8TXcuQY6vXdGQhRbhnIWXhrpGMpAanyUSpnFA71UTELB/y7rY5hlRnLFZ4Za89VQ0+84bsAzpBuLE1A+UzRbrnq6eVUxH/VE5/JMShohtUMWxot1QLd70kbHu10D9yUJyc/5g19fJjWrCOlWq35YDMMYo+GrYTMnihaXRGK+oqaPrk1hzAsO9TEczfdpMV7sxAgDUZc2T/eYgp6d/59RUUEHZ+p3qVkxx12KtHHEuG9SVAFd2nUOsOjvJZzuUAhlxY99UZC6MUeUBvXp5PWqR/eYfe6akX1JZ/BSYlKCZN8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(71200400001)(26005)(186003)(6506007)(110136005)(33656002)(316002)(9686003)(7696005)(508600001)(86362001)(966005)(38070700005)(8936002)(64756008)(122000001)(66476007)(66556008)(66446008)(55016003)(52536014)(76116006)(66946007)(5660300002)(44832011)(8676002)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EOn8BucDp42ra5qhTdFhni12cRP4opPdoYt4/gW8frm4Lc4iH2i46JE3LESG?=
 =?us-ascii?Q?JVOkAZot6P43GVn6a3TeUKKS5ViqO4+6Y+l4XHalK7cD7DmdWuVmgAbNenn8?=
 =?us-ascii?Q?atzRj0gOpNgnnuGwIX22WNZIPLJDpWwzqFvbuS28vb0dDDVWIM1Qu4pumStm?=
 =?us-ascii?Q?Fcgch6px570T5kpdzRG9gMsFuzFon/VCMtwDMn1HGBDLU62onCH5NiacTDdK?=
 =?us-ascii?Q?2KKzBl1RSelMZzw6GE86EKMQNO5zjPkEPHPu11lYCw+rUpL2idbEyweI+lya?=
 =?us-ascii?Q?zpm6AR8CV1WLWKYZZXycbwLOZlSl3LulKY1X7L6d/wS1NFnpgsftfI+OMQ06?=
 =?us-ascii?Q?M2jLlxWa1enMdMghJzU/kBj9XqHKA2J3OR7hkZIda37Am55J9OutRGEmz/Dd?=
 =?us-ascii?Q?u96aVXbvwTk0GAVS5VoK4NmA9jXGhDSi0q6WOomCtxPOS637ROV5JuTNnN7Q?=
 =?us-ascii?Q?wki+hZFUgcpzZ43rARSzunEyoxhFm7CKQDNp+Xe7Zbxl3IlYZgH3l5/NDIuP?=
 =?us-ascii?Q?6WiooiZUeqdsPUjo9fQsZ9rVfjZkJeLE+J/qqFZ4O4N8vJMC5USfp1UL7a5g?=
 =?us-ascii?Q?dt4tQWTCayoSqYpHysZyPKSoXEExTMPU+wd0nvkQ1zxvaH4/RtWIGtEfDdxR?=
 =?us-ascii?Q?O8B4VlS7xyeGnMsDYP9cIsqFFfNeXRm0ASNXyySZtmoctNYULkoJdcjSxwTI?=
 =?us-ascii?Q?FpmgsbBD/eAOIJrzfJ/b+ZrJCf9h1uTUKs7wMh0/LSBRvlpJ13+GLpZwvZ7d?=
 =?us-ascii?Q?rhEFNcm37FSEvFtNADmrfeSa72L3uKOKAMDCGyquj3IGYJYQ/tSMZV7RcoQQ?=
 =?us-ascii?Q?M2xNwhd1z6rr4ZRuHHXKxt7rtnhO5s5PnI4vUI+Anbi4SYiK8SADeHJsC4Py?=
 =?us-ascii?Q?wzKprE+jwsN55HkEAslZ5MNOA7Utp1YmxMgGqIb+1zKwtPt/loDVKTAqsen0?=
 =?us-ascii?Q?1FPya9h6cBGj2n2FekY9FFRwe1ceO1sZYcXkXiMDqZkfuexxrEFIztYH2c6H?=
 =?us-ascii?Q?WP8jDmlk3grSUuUK6rAGFVYgO33mC7F7Pl0vKLWASyNMZChcz63LD+xU5DJt?=
 =?us-ascii?Q?aS1le00hS0TA2o21SzEem3iBHehxrQ/y+WXfOl+7uyAqjfKrIMnpnKfduSYO?=
 =?us-ascii?Q?MVKEeEfPEWYj57GdMvMzLFLWw2TXxD3YRhMzG6rjiTrS9xu1R9RJ+wTNgemZ?=
 =?us-ascii?Q?5K7ilHNEG6AmoqpyyXs7xtbHdeE0mTo97GOJoRsZeGhDWn3D1sjy17YqMQpT?=
 =?us-ascii?Q?MgQ2/T6VOJtl87ZFZzVKwUIDUlUX9vLiDBdXSobFH05KTjE4nMKBLITt9PPZ?=
 =?us-ascii?Q?AtFR2ckfpKiMn0wDncZQYJsCLgX+OitT/kYdZbnFi1jcMqG3XjSQTfj0oqTR?=
 =?us-ascii?Q?DcU6nk7gK2Dvln09Imr9d4nYIgiqJmxyaL88vsZ21cVNok2mZ9pb3c51oNDR?=
 =?us-ascii?Q?xbqdgQhCyJjUwHe/Mq7p6NOtmf0NbYbjxKxKs0yPgrKGqLst7zFeGRu7SquM?=
 =?us-ascii?Q?9XJO/Lc5LqzRO6r2MzC9xt1ebpTatv0BUy7/FriNTdK5idvK1ajuX64G8d6+?=
 =?us-ascii?Q?kCPp6d0/tgqd4hvXK6fO34TGGnG1/k1oQM6KEnD5tJSvxX0v5eLvOJ5rFAxD?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60acae19-6675-4489-42fe-08d9e9d9838a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 01:31:07.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZLrWHUAFUZc+HWqAFYtmVprQqpkjXtQuhQj8ePOzaBpT/F6xgIM5jI15iip7TcLcVOyNIjzbF4rNNqRxQsTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V2] remoteproc: support self recovery after rproc crash

Any comments?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Current logic only support main processor to stop/start the remote proces=
sor
> after rproc crash. However to SoC, such as i.MX8QM/QXP, the remote
> processor could do self recovery after crash and trigger watchdog reboot.=
 It
> does not need main processor to load image, stop/start M4 core.
>=20
> This patch add a new flag to indicate whether the SoC has self recovery
> capability. And introduce two functions: rproc_self_recovery,
> rproc_assisted_recovery for the two cases. Assisted recovery is as before=
, let
> main processor to help recovery, while self recovery is recover itself wi=
thou
> help. To self recovery, we only do detach and attach.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Nothing change in V2.
>  Only move this patch out from
>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=3D604=
364
>=20
>  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++++++--------
>  include/linux/remoteproc.h           |  2 +
>  2 files changed, 49 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> index 69f51acf235e..4bd5544dab8f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1887,6 +1887,49 @@ static int __rproc_detach(struct rproc *rproc)
>  	return 0;
>  }
>=20
> +static int rproc_self_recovery(struct rproc *rproc) {
> +	int ret;
> +
> +	mutex_unlock(&rproc->lock);
> +	ret =3D rproc_detach(rproc);
> +	mutex_lock(&rproc->lock);
> +	if (ret)
> +		return ret;
> +
> +	if (atomic_inc_return(&rproc->power) > 1)
> +		return 0;
> +	return rproc_attach(rproc);
> +}
> +
> +static int rproc_assisted_recovery(struct rproc *rproc) {
> +	const struct firmware *firmware_p;
> +	struct device *dev =3D &rproc->dev;
> +	int ret;
> +
> +	ret =3D rproc_stop(rproc, true);
> +	if (ret)
> +		return ret;
> +
> +	/* generate coredump */
> +	rproc->ops->coredump(rproc);
> +
> +	/* load firmware */
> +	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> +	if (ret < 0) {
> +		dev_err(dev, "request_firmware failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* boot the remote processor up again */
> +	ret =3D rproc_start(rproc, firmware_p);
> +
> +	release_firmware(firmware_p);
> +
> +	return ret;
> +}
> +
>  /**
>   * rproc_trigger_recovery() - recover a remoteproc
>   * @rproc: the remote processor
> @@ -1901,7 +1944,6 @@ static int __rproc_detach(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)  {
> -	const struct firmware *firmware_p;
>  	struct device *dev =3D &rproc->dev;
>  	int ret;
>=20
> @@ -1915,24 +1957,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
>=20
>  	dev_err(dev, "recovering %s\n", rproc->name);
>=20
> -	ret =3D rproc_stop(rproc, true);
> -	if (ret)
> -		goto unlock_mutex;
> -
> -	/* generate coredump */
> -	rproc->ops->coredump(rproc);
> -
> -	/* load firmware */
> -	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> -	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> -		goto unlock_mutex;
> -	}
> -
> -	/* boot the remote processor up again */
> -	ret =3D rproc_start(rproc, firmware_p);
> -
> -	release_firmware(firmware_p);
> +	if (rproc->self_recovery)
> +		ret =3D rproc_self_recovery(rproc);
> +	else
> +		ret =3D rproc_assisted_recovery(rproc);
>=20
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h inde=
x
> e0600e1e5c17..b32ef46f8aa4 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -529,6 +529,7 @@ struct rproc_dump_segment {
>   * @elf_machine: firmware ELF machine
>   * @cdev: character device of the rproc
>   * @cdev_put_on_release: flag to indicate if remoteproc should be
> shutdown on @char_dev release
> + * @self_recovery: flag to indicate if remoteproc support self recovery
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -568,6 +569,7 @@ struct rproc {
>  	u16 elf_machine;
>  	struct cdev cdev;
>  	bool cdev_put_on_release;
> +	bool self_recovery;
>  };
>=20
>  /**
> --
> 2.25.1

