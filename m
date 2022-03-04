Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BC04CCAF6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiCDA5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiCDA5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:57:47 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B911D1768EA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 16:57:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYTbSzwJVDJQPKOK75zIa6UEy5qnx/rtXQ+pGGAi2TDdAVU2xuIpqx96+avGkkJiOK9FtCfalMrAvFk0cmgbBPZe7+ZmEaczF6PhfbvHT5nAj5y6I9/JBumMOirN7iM5RQv+ZZ9XD/kCz0/Pd2fy9MjYr+TppEYPIy/PSe5+NwdSZL9v1PRGO1gFp0QE/O6adVugND+AKt5pIXrKgVVPsZib+mBsIxqeKSw/pCuC1/Hdd0259ZYw9ewcpKe7jjiZ7ceWohJZEKQtSH1hMfXX0ReKN393ro6w3nJaZRim6N15t0YaIfdOkMahOeh3mA/Kjeogl0QX7JOBIEzH0uuFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yAFUe3gpciiWcgWqKDT9c69W1/wvxOSctok8uf6Udg=;
 b=HhS4XWN62EQMCs+Ma1MlaIYBV+H1ENh3o37h6uV66z3Dpus+ITRr3k+1zdrblCLGIE6uzyxBzzuqaNtSeIesgTokqdnCLp94aXRuC9qkwscQRVLdZxrfFgeONgc2ZflmsCtLGUe/kSLkGgDD3Z8vkdjG5VN+WJ077qQ8tLfxM53+DL4wdyb8qtcMYaK9a1d1WfnYe7o6cB5ynIjTTWKrEuQxgERkYgiki0EpkfMdHbZfskPCS807dW6IzUCh+pmNxLWU0q6ahnkbCgPwPpUMmGwm7OOYYbOr3x5wAS123wIow9lFLuAXqpEQDCroV5WCMP7MbRCeorgfaJ+W+Yqv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yAFUe3gpciiWcgWqKDT9c69W1/wvxOSctok8uf6Udg=;
 b=BB4QZpPipe8MQQ+EDcQyTkFhZEMghR43D/8hzFb/y3w6UsWbf4tiUIJQ3o+CM/Hw5caeFh2sZ2HJIGbpOXFTsNHu9DLYNyyUPLxsXri1OxuCKJfZkEMlbN1E6xBzsQkD60Jgu6bbSRQgjmQdJZRvi+4Xvj4IRlQzgaF9XonXZbY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 00:56:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 00:56:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH -next] clocksource/drivers/imx-tpm: Move
 tpm_read_sched_clock() under CONFIG_ARM
Thread-Topic: [PATCH -next] clocksource/drivers/imx-tpm: Move
 tpm_read_sched_clock() under CONFIG_ARM
Thread-Index: AQHYLy63bOeYqb3tBkC06G128Cbs36yuZwhQ
Date:   Fri, 4 Mar 2022 00:56:57 +0000
Message-ID: <DU0PR04MB9417A8A2DA067C1465D6251F88059@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220303184212.2356245-1-nathan@kernel.org>
In-Reply-To: <20220303184212.2356245-1-nathan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb37aea4-ef1e-4a06-b48a-08d9fd79e1f9
x-ms-traffictypediagnostic: PA4PR04MB7997:EE_
x-microsoft-antispam-prvs: <PA4PR04MB7997212F424AB158124ADE3988059@PA4PR04MB7997.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjth/NJ8L1vcyM6LEDcJJWsmLdAUfGfF18kMwJVqGg2nrAVcKpHuMpyryN9fmpm/x+hJZMKrFx/ukEf7ZdPXz81O78ADu0S3Aanh0gJj6xD0heQaqehF92iIK572Im3vlrsyd96Ed8XL1C6/G/JKNOwXyaC16pyRe62Ts/CWtyUkSBRy94gPRKrPIf5M33vImnoSGYcKA7COFWxyZ4CqgBJL3nkVRSmejEPzgHkH6cCMJTT+EKmt8hAvrueVzNAUwmGckF5y1u8EwKtldlk3i4HrcNJkR9k86xlIeVbI4WYpkg/OqzOOcdn3kjyzDg+dDr7Xdean/ES8lARvlSL2G2RuNcsVUbpfXarOGrI9NK/BMj4+aizY2642Vp6s+FQrAiAFO0z/RqF/0HQIvtmAs+Ls6I0ovTco0lE4XfRc2o1Z1Uc+LRIZ1RwMkhtRWk+OyTIy7opJ6kyqZzapIJoMSOohcBNtyZUObpn0lM+Xy8xEqigTqQoNYtOy4qKiMEz7Gtne6QJ4UQqoNggbxsclrA8K65wp7XHP3DOXax1lgZS/shMABVXGWiWgnCOjwCghjysmfUWm6ulDFvoMT3a1CWJzgxtFxen8o/wOeZHmJeFkuOibqm9r9M+yad0eamxB5x5imU9auIxKl2yN3SXAB5SnJWQIjyTdpZIbHeLxftE/hopM5S1mygX6OXPnATsmAsGQ9linPV5AgED3BjfyjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(2906002)(5660300002)(38100700002)(44832011)(52536014)(8936002)(33656002)(86362001)(64756008)(83380400001)(71200400001)(8676002)(66476007)(66446008)(76116006)(66946007)(66556008)(38070700005)(186003)(26005)(4326008)(55016003)(7416002)(9686003)(7696005)(54906003)(316002)(110136005)(6506007)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?23yEYmsvy1UqdqbRdP4ksbX719IwcUrD9tfs82mCOnqeTJs034mwSD9qY9Zy?=
 =?us-ascii?Q?mQ+Vm/51LgfIVCmsMrr1+O4hwGn1fEbYCTfqiLdxh0r1wjezexSotemM5iNc?=
 =?us-ascii?Q?S4vX13f/37ju+1Jrsnr0QvX7YtayW7FJE1HT17yHh5VeSbIuPoIIawSWJqh4?=
 =?us-ascii?Q?Cp3Rvihi3rUDxmkBlaHHY7OHvP5reoCAYUTYDxK8teYFksbjdh9F/u8wI9Wr?=
 =?us-ascii?Q?H4opQrR1lSBiq1wXPzUy/aYWjZVHwoacdL+fytq6EEo+FyWHypM3TVPD78V7?=
 =?us-ascii?Q?v2RZrNs7mzTigJAQYs2wJkjrGLLql+S3HGvmB0RwvVoVoU01CNhG/tzG2iH4?=
 =?us-ascii?Q?n92S525kv1LgoZvvPmW4UIzAWO2iZsAS0OBhuph+LVvgSpeff5g8v/5hBPD5?=
 =?us-ascii?Q?OwnAUKsfxbLB6xfQpg3xySAIyFvJfHgIla2SabBFZ8yyX8f2dl0fyDQ7OxAM?=
 =?us-ascii?Q?Xa6aqnseOxTU+PQSIs+uMvbCENdjyDzCN/3ntgS6w9VqJX5yQh8pfhqMBM7U?=
 =?us-ascii?Q?lGh5NcMOq2JdGHrFXfVVWXay39ewC9g+GRhC/pf5vLr2BcLYtS5tXCAcDShy?=
 =?us-ascii?Q?3TCi8IqIqsBIY8jEaNcMnk915IHfn2SlN5NZpMus35z0H+bsU6VmFd8CDKzY?=
 =?us-ascii?Q?rVjZPZA55Uz2oYKnl9mzsyyXcIZNp2lYsIGEvCyH+rG9ytvKgFNpThrv953f?=
 =?us-ascii?Q?Oj9IzuCKmaIaVT7IozIru1zb+k32ioSP0fRa4tO8p/2ZEJKh1LMv2N3D5r8L?=
 =?us-ascii?Q?Ussx6ZWX8ImC87ZOJhAaedgyrQkeAIkst0UQuO0o9/9l8NAVpIY2RbL3PRCI?=
 =?us-ascii?Q?q99f25l0PpEspclCE1MT0jzJ+SYKG3+NwSuJJabuQXjXnqcfM4KZtd2L31yj?=
 =?us-ascii?Q?6QWZst67hbivQqMhk5uJo9n/H9Z7Yt8bNg7newzHZdZCjvI9M85TA3t0b2fw?=
 =?us-ascii?Q?wlvs8W94jwbRRud0amSdxi3f0YCFY2yRhDPBtMjCzl7rBQC58ySTibzZLsCY?=
 =?us-ascii?Q?b2MZDTszsQbrsftDOVHcOf9qilQD+duodohMAz2+nmc8Iy+Dzq9YWHvxtt9q?=
 =?us-ascii?Q?24O1OFsKmAec/+y8QbtyS02aM9oElHLRc7e4HKWsWnIr9CqeZ0DETakPypaM?=
 =?us-ascii?Q?H864EB0uPUUeHdMGaUbgVaTPkLtay3ceYPa2NDnty2Pot6UH/XpXUUcvM66z?=
 =?us-ascii?Q?lWZuRUudccmu8ZyX1b786g/EUC/mLdpnJjiXOs1CH1QgJf08qVJKjUaDLpEC?=
 =?us-ascii?Q?WhkCfgM89q8G8wIAtzRRgqpirIL/F5rJun2JgpCjI+HC8hoAHBuH+/3vERxt?=
 =?us-ascii?Q?NzGJQ1i0FArdl7YuA7w5UUxRg/9k/CIpFv9akX5hdpgw1euBavhEAEF0FHGj?=
 =?us-ascii?Q?BnTsYoZDvdi46FYRqJUgP+Ow7viEsNuEAryDBxWCwF+7fsO1NYj6Xrsm5viD?=
 =?us-ascii?Q?DqcbpVV+ienwNrogFzdU+T6vMFUsUweTqRQ8mFLv+GvcaT+VMZKIlTxZ1JZk?=
 =?us-ascii?Q?MqEpuO7nluujBrReJ/gcnTVz6fe+c9Wl/CnNXQXnzoqGiGAl6zsWdFB5+x62?=
 =?us-ascii?Q?SpY6nUEd9y/uMC2iMsNLAfrlYASn70lWmcNv4JtjSinE40q04blzXXQP8nDx?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb37aea4-ef1e-4a06-b48a-08d9fd79e1f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 00:56:57.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CGJO0FfRCdstLydepzah2CD06l7LgBSHRoyJ1sl8cyD6cq388XSdHgTsNZ4peeUH8+gWDh7m1g1rVIx8qpYFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH -next] clocksource/drivers/imx-tpm: Move
> tpm_read_sched_clock() under CONFIG_ARM
>=20
> When building this driver for an architecture other than ARCH=3Darm:
>=20
>   drivers/clocksource/timer-imx-tpm.c:78:20: error: unused function
> 'tpm_read_sched_clock' [-Werror,-Wunused-function]
>   static u64 notrace tpm_read_sched_clock(void)
>                      ^
>   1 error generated.
>=20
> Move the function definition under the existing CONFIG_ARM section so the=
re
> is no more warning.
>=20
> Fixes: 10720e120e2b ("clocksource/drivers/imx-tpm: Exclude sched clock fo=
r
> ARM64")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/clocksource/timer-imx-tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clocksource/timer-imx-tpm.c
> b/drivers/clocksource/timer-imx-tpm.c
> index 60cefc247b71..bd64a8a8427f 100644
> --- a/drivers/clocksource/timer-imx-tpm.c
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -73,12 +73,12 @@ static unsigned long tpm_read_current_timer(void)
> {
>  	return tpm_read_counter();
>  }
> -#endif
>=20
>  static u64 notrace tpm_read_sched_clock(void)  {
>  	return tpm_read_counter();
>  }
> +#endif
>=20
>  static int tpm_set_next_event(unsigned long delta,
>  				struct clock_event_device *evt)
>=20
> base-commit: b22a1c270f533e30bc5d5d4cab6199a2cbb07b07
> --
> 2.35.1

