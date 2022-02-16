Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747874B87A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiBPM3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:29:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiBPM3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:29:40 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110CC2A39F6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i872YpfJ0U+Ngsu1Exi27+0QgGbkf2rbwqZ6Wv2vTUfKGVz0YTJ+ZLKt1e1r1tu0GYOD+8lVHxVZnPN50ojeou5KlyMm0c6eDOBfeu9CrqBA1FEsrqGYdEZbMAUpPPBBqxTRqXO7Gy4lHEfyCnv9cCHK6NC4QVaHC+b9cLCLOsMbTrrfKLoBb/fDe/1RlOwUCZbfIg68EoB3sQI37mPLfDi8hK+e48KT6FlY/fsn5HBt/tURmtInTJjZBhOI/FaSzrNhK/p3pV8xk+PPL/UVWhjtsfm00Wv6arAA6Q/vIR7gPOs9S+PYTLRgHs6U0dFjRM9M8MXaREnaB6lVCffzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W++0AnnDF1rx3aPZcxXGwHOnAq6v9JoPieWKKLPEI8o=;
 b=cnBJPHklf8csI10Nf4Xqw6PAqLcFo3tPZCnK2Z8BOyHmRiscvtpQ51hDkTfZvfYbzGD43F447Hda+gQ8zR72qAV8B3IQptoaNjv458FpwAloyJrpyy63xJw0d2rbBtFPywIdEO1J9Twjq58AFepyMyY5ROL7ahOyb3SFSa+WjIdJnyAgsp4F14rtB6WV8peCec32/+PkJZU0rw+k6YUoUJxjkpNM0jmQHanOCpKSSWC3cldYBEabxDGS6SuCdLCt0Oke+J3xiALNNXeKd4fzGjFr6btc/ZzFvLyakeGvlaiUATB1E6kUHRpDnOsVem35nY39q3lGGckm+hR3v1btbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W++0AnnDF1rx3aPZcxXGwHOnAq6v9JoPieWKKLPEI8o=;
 b=Sti7QfCe5WnMtePRhHCCgGkUrXXDlSMacI56l/fZgL1RlG2FnMuOO5V6ZLCTkR/wQ+9R0a4oMAhRBTsn6gr1BVOOmlcVxA9qFvVOhaHTfNNmX21Zw3MXZZL8qv9UnP+WGLXC6Z1c/k4IYZj2lsT8BKcOhwpK7EJglz+SgpJee0Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3374.eurprd04.prod.outlook.com (2603:10a6:803:b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 12:29:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Wed, 16 Feb 2022
 12:29:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] clocksource/drivers/imx-tpm: exclude sched clock for
 ARM64
Thread-Topic: [PATCH] clocksource/drivers/imx-tpm: exclude sched clock for
 ARM64
Thread-Index: AQHYAjHm/PobCbmizE2dQK99zJo4HqyWXUQQ
Date:   Wed, 16 Feb 2022 12:29:24 +0000
Message-ID: <DU0PR04MB9417736ECAE9DB275627CC0088359@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220105124304.3567629-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220105124304.3567629-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9c9d3d9-4541-46eb-22b3-08d9f147f806
x-ms-traffictypediagnostic: VI1PR0402MB3374:EE_
x-microsoft-antispam-prvs: <VI1PR0402MB3374EB421CFBD931CFEEF57588359@VI1PR0402MB3374.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgiyJhOIVjWZ6oyeDj0OR8VEtyIVuvmaKOJfdFkoc6o6vfMtxvE3ONBDTjuqwoBq9tCnGSfmUD0pn6ENzViJXuKeDjrrYg34e2hlAbmi/U1WxeZeSSzz2Zyfng+X7w0MlSzoxYcHDgM3k59J+E7xBD32+7bdMxnRcbg1IpCR0ad+UmETHmG0T9gK5s6oMpjNjW6fhP/sWt8DVrvGkkDh5efrsBGj+FXukD3vUPYXLxIANo+6KUyddqUCJYVdU5G6HrbZK8alPVDVb9VXG9dciK4ELGMxtkFN8BZz7SXlVjq6LgwJeK48mXIOvT2tnxSo1/1JKs09xGwnNiPzUoBUzZkOh1Lwo3eUPBnqG7FDnghHnfe8RLVyl94/HpfXV1HrSOOrBo9AaITIDdBibwZe2NJlqj687MnxYvDsiTDQgrFlidH1Ry9OrViQlMI60Jkk1HRzIuVdsVHDEzUMIVCXEcj2Lub+fEesnDXwhx8xjNqwiWsKk1P6tlYHESmyZXHz5vFBL/LgfaqMQJnsVtKM9L98TRB3/L7ly/tBhdwwH642uB3qQfX1Ruok/XhKIj130oOr4vEe9SX3+/2wz1Y3wRzQ+a5t0/kMM0IUXNmIiu8mw6pMhcO/IUosyKGq53Jw9wzpkhXydo0DMw44C5/8tAECs++DKz9K5a5xrZNLSGv6xbqNz32j67Aw2kKw417RGv87NsrqtlOaDfjdC7QQlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(55016003)(508600001)(316002)(110136005)(54906003)(122000001)(66946007)(7696005)(66556008)(76116006)(6506007)(44832011)(66446008)(64756008)(8676002)(5660300002)(4326008)(9686003)(2906002)(86362001)(33656002)(8936002)(52536014)(83380400001)(71200400001)(26005)(186003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OxpJHDf5ZMfGY/wII9swfk9/I4kZVXa+OrWwF229yT/JiT1FxaxXJ1DHtGKy?=
 =?us-ascii?Q?vcnzmcGfuLO53NTI+mEwS4eP/KZ/j96VZHGSO8M33U1MCK4hK/Sx5+FXIkIL?=
 =?us-ascii?Q?FRo9OoE/30dV+/tw2XcTbMSDKqwxrgZgWbdl5f5pU9YxdECvL39xUY1Adi4U?=
 =?us-ascii?Q?GKOhMgym16EdfAEHpwd90lrNC0WX1SVH8EGTzSrofFCeFxQpC7GF5a3KOmAG?=
 =?us-ascii?Q?jDps5t23jX55a8bfXjE6dkAOnbonrGvMf23RRisOIAqLX1ePhZQWN1QVkkA5?=
 =?us-ascii?Q?YDCWdnNSmIHBulIIjISeXkik/BZm4yxe9RmoOl5kzEX7dzsHwSn1+xccxHDI?=
 =?us-ascii?Q?ltt4MHbPbMziRnnNlmQm4jNve1ahxf8mRk8uN0rnlRLHOeNvvUGcZLbMyf9v?=
 =?us-ascii?Q?c1PJ98lmBZdkhSpBCHVXiUg3tyYnS+mWkWNAUZTDfVTTMC3KSHKajwGaxP9n?=
 =?us-ascii?Q?aAIr05N8I3lTP9ru8Hu75mQVhpIcpSfdJHXJRkp9/C1Y1SzmIk2IrC2Fww1s?=
 =?us-ascii?Q?q+y8Mz9zYfBzWl2WO+hKhJw4dnpNDvUEjDBkSaaC1U81xDu56ki5Lxy6T1bS?=
 =?us-ascii?Q?hdFbZzfpVD4JCBvt6uRKhZp0eAATHKUocDbThvpvze6hQFfdrx905nThO3lf?=
 =?us-ascii?Q?xeslP61JL2XUOrZtUsJZ1t+rUzbvqBBi49nMQRdKm3lE8c9CKpZcWwJXhNIx?=
 =?us-ascii?Q?CRQ39pPxr5hXJOhnAyrJ9FkPJcpmyHnbq7uhUzcRzLtRLMyUQqUdYTao+vpk?=
 =?us-ascii?Q?SfE1yg7JvbmEUC2uSFJRnKVT75KZQ95HmIQcVPRRVTH1rCFLV3JktxAAHBZO?=
 =?us-ascii?Q?hGROMncBMFEGhp6F1/c59J8BeVJ+/aYmU4O2nc6pTzDxopUjfRgq3TWsgtTk?=
 =?us-ascii?Q?vvHHgyrJycTW5krpo3Ja1EZftxQF7NGeqbrRe9QcYHBjh63jKW2i6Ssgf914?=
 =?us-ascii?Q?LpBU8VI2eUqTT3uJ37wWX4WrdqmMWlSTVPXMTzQqjI98U/06DKl/b+0MW70q?=
 =?us-ascii?Q?oLU05QS53FYoyZGV41KiLz+V98n8c2K0/FOG2UNxEuH0Damca6TPK9TH0Tl2?=
 =?us-ascii?Q?CX8BoBV7jZz7hW84coJ0CyQZHUa+944VDHvJsuof5N86v/xfk7qqKdTsSit7?=
 =?us-ascii?Q?kpfAai8g+uF5ulYtfyYANtPytKgDvg90n1acTfQGUEqvTW3Bl1wlob7Ozcu7?=
 =?us-ascii?Q?p0s7Mx3R9eirVFkDHUxsjZSoIVfFQFkx2RSL6a7idCmqlQViO/5vtL2MB9hv?=
 =?us-ascii?Q?Pq53bQwEYRGP9HT3z4R09etgDzUX9nY14kMKiXipbZJtVC0Z0hQcfqFbdVhH?=
 =?us-ascii?Q?OvzEP8FMaoq4/0og/yy1hrexyfKGCbUfH3Jgowdwuce46mGKCvVjsu9zyCJZ?=
 =?us-ascii?Q?F5e6l0+dOX5dj9+gDRF3s2XiL16+4oB1dQM2mBB6K3bH0fvjIn9JDUgCMDhS?=
 =?us-ascii?Q?GyBYvB5AKgmKMrzBOPtvHDKKFK+b23jRjrUh7zF77DkE62oypM7xXoqLjsFZ?=
 =?us-ascii?Q?8W9KhdOfN7XUA14M6dnpKKHJdHKXXVTi53VN7HJ9t5s63ByvGmVVFfP6rHmO?=
 =?us-ascii?Q?upDc91APIssT3rOJFGYiF/7OfhTEPWBgevZE4AaYD44HiT+x3+PrEtObbwil?=
 =?us-ascii?Q?knGLCMKAR/PSO+yGwVXWLVU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c9d3d9-4541-46eb-22b3-08d9f147f806
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 12:29:25.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RILiqAtQnrrF7DNiiOAAMophxXoiiyEFGS+SrThDpC59a40/pkctpqZLBQ4tEftLAS7e7TG4WLZYfN3uuyj8yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3374
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clocksource/drivers/imx-tpm: exclude sched clock for
> ARM64

Gentle ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> For ARM64 platform such as i.MX8ULP which has ARMv8 generic timer as
> sched clock, which is much faster compared with tpm sched clock. Reading
> the tpm count register in i.MX8ULP requires about 290ns, this is slow and
> introduce scheduler latency. So exclude tpm sched clock for ARM64 platfor=
m.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clocksource/timer-imx-tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clocksource/timer-imx-tpm.c
> b/drivers/clocksource/timer-imx-tpm.c
> index 2cdc077a39f5..2bd530b9adc4 100644
> --- a/drivers/clocksource/timer-imx-tpm.c
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -150,10 +150,10 @@ static int __init tpm_clocksource_init(void)
>  	tpm_delay_timer.read_current_timer =3D &tpm_read_current_timer;
>  	tpm_delay_timer.freq =3D timer_of_rate(&to_tpm) >> 3;
>  	register_current_timer_delay(&tpm_delay_timer);
> -#endif
>=20
>  	sched_clock_register(tpm_read_sched_clock, counter_width,
>  			     timer_of_rate(&to_tpm) >> 3);
> +#endif
>=20
>  	return clocksource_mmio_init(timer_base + TPM_CNT,
>  				     "imx-tpm",
> --
> 2.25.1

