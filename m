Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389B24BB9F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiBRNQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:16:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiBRNQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:16:49 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A521A1132;
        Fri, 18 Feb 2022 05:16:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+ps+IWzwlS9NKm8VGs1mtHS5hR12Q0EjmsYBbaPOpU+pfavlZP4jDEhYD5cr8Na6k1heyMFjKZG6ScTwdtntYm7SrV+Ha99VRFUQXrqEWvRItoGyYb5asXrwltVADSAdjq5/yoVy3VsjgSify/1FVpLX0g7tLBjIm9fSfu3KTDKgMmoHnAutrao9AzSA5xtir2rio+Rqy10ArxWXHAt/2cEQV7lyDjXU2oWTiSyM5HCA9YwqHXRz0tPJ3K9ySGpuX7P3SSNiJKlsrYqsY0mpqAGgMaLq4b7etVpS/W5f+WCZbx5miCU53mZvANvPwormK16V+3ubirpFsUycKiW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTF3YRl3K2HhKI1q41WOYY/t4CuYmoCGdyOTWTRYBtM=;
 b=EfvZoKHF2uICgi5E2jgEiMFMRGbOpq+FRFeiszyNadQKHzGI+zroxQPPlte6EylVC49Nf9iIWNy+qQo2vYZ43OkZrHCrZXzoNKts9kRPmw4x09LMPCBLlsJijNN+MZJUY4tKAF5Syxmv8oJamO39Th0m+5ukjPIOkPHu93ssxC3Irh++/dLP6esaB8oy5DwTh6neF+e8/DmANxaNwpvy1j/VjKafScP71UX9QHPYcbxEjzfbLo9cBXWPr0LD1aUBYnIVgeLqiVhJ6psR52WwIlQEZa2Venee6wnLEiI5AJBDOs7SiCXmN7Ex115pU+AoeCMn9EbyBle5EzsFeELxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTF3YRl3K2HhKI1q41WOYY/t4CuYmoCGdyOTWTRYBtM=;
 b=a7L5uR66m+pUltyguUoaRGgtHiw4D9gTGCTJmD/jC8a1IWgESarta3J8Pmd4XLAzZYEpTDbM93WYmqDxV5ysaqNwhtYm2CJTADvcedj78kp9thuSoYxFzjwsTo3Bz95icQNJHqHzSze7HEZmrfDrfnBYrRPSfObcUZjK2w0iYQA=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by AM9PR10MB4594.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:271::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 13:16:26 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acd3:e31b:a13e:b0db]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acd3:e31b:a13e:b0db%6]) with mapi id 15.20.4995.017; Fri, 18 Feb 2022
 13:16:26 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     zhaoxiao <zhaoxiao@uniontech.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] input: da7280: Make use of the helper function
 dev_err_probe()
Thread-Topic: [PATCH v2] input: da7280: Make use of the helper function
 dev_err_probe()
Thread-Index: AQHYI58zwbDtbyG0MkCBTWTBmQpfP6yZS1+A
Date:   Fri, 18 Feb 2022 13:16:26 +0000
Message-ID: <DB9PR10MB4652FAA0F35075135BBFD33280379@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20220217013912.7228-1-zhaoxiao@uniontech.com>
In-Reply-To: <20220217013912.7228-1-zhaoxiao@uniontech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f473cdc8-274d-43c7-c99a-08d9f2e0de7f
x-ms-traffictypediagnostic: AM9PR10MB4594:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM9PR10MB459495193D27F8AB159EA87BA7379@AM9PR10MB4594.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xxH0QDALK3FTcPh5n5ELqMFGGYaziveUe2S1HbQ3M2nxUsE9kwcUqg9XlmIVSzo5SuCXEs0h5tBZdVfS9zYdG6zUVyAd/4lcT+DxE9Wq+8MRSUKtEsrVUA+sTEhtkY11IYcFX4wVFg1OardcDr/U5ajYwbLa2bjrK6AWQFtZT0PAEjeyXxu9m0hKUj7Tc+aiNqHOlL56h7lwWukzEysCK+S8RxwDL1laSHaiBDM7MOBqOb0fEtfQpMEPqz/G6QNZb5xeI/JAknr/WSnhwVei20EBO7+HGi1a7IM3g/W8GoWlBwzhrbWyaXz5oDQbonDT58d9wNCb67G8yqSzWAMDZ//0wk1oiadmEWpHcW5eBvHGjFqWwOUboV2pqx1SwfIHPMF96YNHsd1DHaIissryCX4xmhB86p4J6ByUyVxMux3oMqg7F8V1uUSKYH633NVQhTNHSOs4MWDudUo9Uf59mjhnaCN5L6pbb7DyEXAKsdI4ncyki9HL5oqmTGmfeHGWG4MhMHIKKknLOv61lZRlfZKOnst0Q2Kz2yUI9tnXQylW7623XdZh6/KPF7RS8eF6W/BVrhuSN5jJhsCLbKKFTVNRR92taNoPb3D3JvOBs5kPV8AREATz4hwobfZrACaBwLtQIje2ipY+mtsFhLrUW9ZtUDp4euBoPV7IA4qrH0Mp9X27X8UrI2EbrVLnuRx9cvMTzv0R509/IeLjMUFjhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(66946007)(76116006)(66556008)(53546011)(66476007)(7696005)(55236004)(316002)(110136005)(54906003)(9686003)(508600001)(38070700005)(86362001)(186003)(26005)(38100700002)(71200400001)(122000001)(66446008)(64756008)(2906002)(33656002)(4744005)(8936002)(5660300002)(52536014)(8676002)(4326008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t1KvqHQV6B45CCKEPn+Bbns95TUeAdWuTaongoWxGig0yzJX2lwXcPF9/tCU?=
 =?us-ascii?Q?xCOK5WGk9oBxRmBIGBm8gIapZZ0tXRdqisJ7mSROTS8T8d9Ox8wX+Doc6iLx?=
 =?us-ascii?Q?2g6MzXnSXxA8qChvN0DJzbFtj5BKedTMp4MBlojv0u4jYguYZ7JlJ3zqNHgH?=
 =?us-ascii?Q?G/HDl0oQH8gYjPjNGZhnAwqd8UElb5m7m9SA7KtxW8MOpm5I8SLE28yq1aO0?=
 =?us-ascii?Q?DLi/SOLH1vR5ayfiEtzRrMSrT4FkHhTL1YEgxr9R2ths12ltTjLprJGhaMH4?=
 =?us-ascii?Q?IOZOVq0o/cVnaDQlm1GP80yI1phvQMYze2uK9EumeV33W2qPAFPA14ocr5yz?=
 =?us-ascii?Q?GKW7OhK4RFclA1Nqe6l6Cwk/1SAvwkR4XlKd8VV7ELDa+fQLgVMc1xTjhlh8?=
 =?us-ascii?Q?eyLWtywbTkT3Q+xrAXVkNU1D6ETNpqbf5yDH5DAtOVKOl+s+WAdjshrc3npb?=
 =?us-ascii?Q?EVmExQHr1R/dlCWhLMwkbP1yOZvnhpRuZTxbqT07g8YWyFYN8rPGQB50xNqX?=
 =?us-ascii?Q?ioTGN/wUtxxY+Us1+M01AeOI+IvOuAczoTti41sGNe5eRtJP8EK3S69TRiUa?=
 =?us-ascii?Q?WYsCSObVXtORjpIakEgpSh0drxMXlzH7Xfbx0xJh3BW+qhC6bLZwirRtwVxG?=
 =?us-ascii?Q?nOLEqpoGxMrW4pspGETcx0rm4uEOVfkErYVC5Yq45akER7ZRTe0YUoptaseF?=
 =?us-ascii?Q?b3xt+W6ZGB3S7nMAvLym7L8nItPTG5JTxI30qAkwPPJi5fku0q9ycqwgNhMz?=
 =?us-ascii?Q?wV50VJW/++jWM8vlJi+VgVszEP8UyaJTfsOfl+5sxPZam3Oe/C4AwNQtRuxX?=
 =?us-ascii?Q?OvsohrZWTT/ARBZE3f7TCFzcMi6PjfL2YtcEsBtmGAz0G/FVJ4sSYUaBQ+Jm?=
 =?us-ascii?Q?v9X3EYR+etUCq+Vss8mOA5pTdeh/OsDdSdPLnI+e9Iw89SHmQi/RR6nKYZvZ?=
 =?us-ascii?Q?BE6yQC5o7voV1IIkV5Ukv74I007td1sNI94jrSS9cccj2bM3xjPVSqzaZvAa?=
 =?us-ascii?Q?Hx30CtvO5UL66xi85XmqJGLI1/7pW3dFFszYZmur/ajl65cX9A8xB+RQQmj8?=
 =?us-ascii?Q?NW3KB1FBmc8/14RHa1+wDCwRa+yQ7Rp6A1Bfvi+cBcLdawO2UkXyrw2oV4qI?=
 =?us-ascii?Q?QcFxm9/f4uQ/Bb+Lyr3BwAPYHoLUac+3qYh7R1+e2CCNNwHESfxTe8Bsu9qU?=
 =?us-ascii?Q?wZibuo3SuyaKF1oVnS1madHUzlYBD4sXsMoFYCVSgLj5zkTIEU8EXRLfoSbh?=
 =?us-ascii?Q?XSUnE/VM6jIe3G69fDlgUOmr2FxJ9OBTpaz6oaxo44QuY2JZG0OS2fwSsrM5?=
 =?us-ascii?Q?DiCElPyw57ZrkwKI7k3MUU/jxGu830giY81XCQTOb5fQ10yefTQOAsilSL9J?=
 =?us-ascii?Q?jFKCSrKXWkXnw224TlhWciYGmY1voyce5R5gJuno73YkojuoS8g8tT3qkPPR?=
 =?us-ascii?Q?/H4S8m+azd/kpxYnkIRXvPr4ybBOcP/kdNoKFnYt+UUAeZowaBP82TTpn/ZF?=
 =?us-ascii?Q?dcR1s/RwVOZGXbdI2NVZXmcK4tB3g+4/Tudz6KQHVpYizkaQe7xGug4tHuZq?=
 =?us-ascii?Q?JXexTW18fD1lbYyFfJY/PKA8AciOxHPJDcCnR+d4RxWyGXQQ7a66RO9jhace?=
 =?us-ascii?Q?KyDrcCVxv57U4/Pa8edp1AzBNTEtOuUN+4DxvWB4KEqUZDLQXIrFEga77u4/?=
 =?us-ascii?Q?zZCT0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f473cdc8-274d-43c7-c99a-08d9f2e0de7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 13:16:26.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tvmTtTrn4YDiSFkpWvtFIbVREqFD1ylr7NXhzlamIeSXy9TgZNkc1QukxJHPo6j/bHNSpPOOZaPtzazbBb9P0gn1ufGQ+z/XNmKl+H4SGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4594
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 February 2022 01:39, zhaoxiao wrote:

> devm_pwm_get() can return -EPROBE_DEFER if the pwm regulator is not
> ready yet. Use dev_err_probe() for pwm regulator resources
> to indicate the deferral reason when waiting for the
> resource to come up.
>=20
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
