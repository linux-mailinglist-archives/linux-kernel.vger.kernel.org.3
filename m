Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521FD4E3C47
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiCVKSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiCVKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:18:09 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140077.outbound.protection.outlook.com [40.107.14.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6B52E40;
        Tue, 22 Mar 2022 03:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkbdP2aPcAuQQhRNUPWIgMQtvAqPBDNn0GkHX/RToHVsQjpKthMRFMdjggAQQGJKppv1be9S+QoDmBDInhNJAExpOwTmTuBATlU9uYBnpmJEGm2oYYd+NFisSeyhB9WgUdkBmCnssKfJv9W9LJkpWjRXGVpAi5Aw6DMfdVmoG0FkHU7ZbKG2pvOLvpy7AAdV7k8GguXl4YAlmTt5kFZmGXeKxkLJ8b9E463vlyan4vxC29BlKmij048QVOHIt7hEM2ci0RPz6cBfYFjT2DtDaNBL8RZ4gD8P+yGUvfR2FEA46+68RRvHTVfkcN21RUGUkUgZoYyuHlMhwpinrDfHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KTnRXHhaUoaYFYyPyUSkUHJ3AqXqbpWl1ddnr6hGhU=;
 b=fG+Sjwt6gwgmdXTT3Hi/Wjs0NLjNyRievGYIxVIRIjYosrjzPpuBzAZwdFF1CLpxXN+2SCWw7bV7txzZdCluW/RbBBjB3zrGRmnwIp/QTCSKFVIWrq65omIpefNP615HnIT/fF5kfhKVfc12uukO73n0Ez0DzJraSPPxPwrS1sz+47+XjY3J/Eu/YnTHar/ZIz3GwM7Wfcu4TMGY5kViiaFATuxQ0ghzZwOVqVmFRGiByxEjX7CfCqxcIn3t/R9OAR2Ya63iyHtHxykdzeJJIGfFkL6w5pxLDU9g+22s3jSA/CsM1Na2mZWXgCv78kn+Y3kTykUL5dqirrHmKDol+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KTnRXHhaUoaYFYyPyUSkUHJ3AqXqbpWl1ddnr6hGhU=;
 b=UChQNY2OOMmEnHS6G2dt5wEL9z7pHe02/ZayhhH4zhCDlc0U9pkSbpYWsoXu13Kfdu+6GkbbOZvz8617wHJ6QlEbPQ7H6mZZyUAr+QuirOtOy8n06WewkurLDVXl5XJ/VXRsYvNv1+aHdVsnGccT1x+tshUT9xGLKZ9rAn/jX5Q=
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com (2603:10a6:208:5d::20)
 by PA4PR04MB8031.eurprd04.prod.outlook.com (2603:10a6:102:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Tue, 22 Mar
 2022 10:16:38 +0000
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::7d05:fb24:8147:8065]) by AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::7d05:fb24:8147:8065%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 10:16:38 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] gpio: Allow setting gpio device id via device tree
 alias
Thread-Topic: [PATCH v2] gpio: Allow setting gpio device id via device tree
 alias
Thread-Index: AQHYPbD7FlvS1AGJcUS4r4lO3/zxK6zLFtqAgAAV3FA=
Date:   Tue, 22 Mar 2022 10:16:37 +0000
Message-ID: <AM0PR04MB4001E8E8DA1DF5355EB96A2B90179@AM0PR04MB4001.eurprd04.prod.outlook.com>
References: <1647927649-9907-1-git-send-email-haibo.chen@nxp.com>
 <CAHp75VdZ9RVuMrgWXOWqCrmvHBtkz+S=dxXhR44Ri3p6Pj5LMA@mail.gmail.com>
In-Reply-To: <CAHp75VdZ9RVuMrgWXOWqCrmvHBtkz+S=dxXhR44Ri3p6Pj5LMA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6ae3b0c-1f98-4b41-d25a-08da0bed0d1a
x-ms-traffictypediagnostic: PA4PR04MB8031:EE_
x-microsoft-antispam-prvs: <PA4PR04MB80310D3E72CA36F09F014E4190179@PA4PR04MB8031.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0QfPPV9HoB24b9OYDPE1Dv2/aiaY4PwY+r+ERKCCTrCyCydha+r2K+XpWWxbomm7DlfBgqo9ji00d/Uk4kG6B9aVXzChH+KhA+DuuJEOSCYP5lyRbcgH/WQRZI2++HkaQHfLKg+5qKpUYEPGbcHIm2cpyiLhaGB+snue1MbALdEtVbAQXP9Gpqr8Z4D0Sozw6wJoq7PcCqUYTjQht9wd3OOE6rwzrj8DSKdtDChYMK+XX/CfgnCEQh4dJajUo7PEAzhfqoxaZcBZBKiJGbMGkXnxT0dEY4WRbaDfoPNu1wJSNWCDRktoH04tHfHKFD4Y0EzCzPqH8uYaYo5ibuIEH4iZEySrql7jWCbrAMTOa/HOMaN55Sii4HSxMea36iMbmfcNYA3J9MSF8XKekAYJA/EPKjxh+2tmKleq5KZKYJ5v+rR4pooK2fyqLgThEWLcSDcAah2y0yEa1qpJtr8Yz9kasFtIniKhOAnkOwul5BKZHEBklfArQNAw8X+YdvCRiS+/Bow1Y7KBV9xTnxaU/IM4WSANwwBcZRiXXQj7XCvc8byQmOtHQ+BBWI+NMRJVN7zVttY7GoWfHh/4AAbpNyVrGLQElxzmbf9IsX8g9byIYTkjdbM+RNVBRYXE7mL1Mof3tpk4D71i2pnJ6Am0OwMHC7SurlQkOkJRyo3g6HDMY8y7bk+0/xvEq7eQx6/VKiD/cPpF4RbI+K1CSnLJPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4001.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6506007)(316002)(7696005)(6916009)(55016003)(9686003)(5660300002)(76116006)(54906003)(508600001)(8936002)(52536014)(66556008)(33656002)(64756008)(66446008)(66476007)(83380400001)(66946007)(186003)(71200400001)(38070700005)(26005)(8676002)(122000001)(86362001)(99936003)(2906002)(4326008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEdiNnJZZDNSSkV2SHppWUhiUzIwdUlLa0dmeldNRndhcWh5NkcrbVJhaEE2?=
 =?utf-8?B?ZmxPUGlvVzVTVUxiVlc2Z0cwOUJpemdGYTk2RnRQYXB0NjdtU1d1bk1WZDc5?=
 =?utf-8?B?OHZJYnp2SUt3a0RkR1lBSmJjaXM2Y0RHcmQ3WTBzRWlQeWh0dnlaVkNSVmkv?=
 =?utf-8?B?dnh2U3NNd21kMUZZWHZENE1XODFvTkYybWtUbU1Zb0tnOGtKTTBCeUVDMGhO?=
 =?utf-8?B?cDFFODdvUUhtQllJaEh3WXBra3FsWEN1VjlYS0o1TUdZT3l6d0tXRTdCRTll?=
 =?utf-8?B?V3lyOHZ3Z2Z0c1pCWW9NR3FlNGRtR3h6TVA0eDdVQ1E3UjQ2dGxRMXAyTWNS?=
 =?utf-8?B?WEwzZGVNcThTQUE4UEIxQ3RxMzduQmIyY1k4Ui9OV3Voa1ppRDVzUG5Tdy96?=
 =?utf-8?B?S0NQbjl5YU1LdGkrYnptWXoxeW9KbW5qRElwNlZLZTFhTUJOR2JvQ251L0x0?=
 =?utf-8?B?SzJQZ3h1T2RtWHJ5ZnRHd0xRUk5ORW54RTZZS0E3Z2dlOEpKZ3hFVlhuZ3k1?=
 =?utf-8?B?MVdNS20yejFLaUJ2ZmdKdWU1TXV6MnJxdnFSOU4xUldJL0p4SGJmT0g1RkZr?=
 =?utf-8?B?dld1RWN4MjBFV0p3aWlacWFQS3FFb0Z1S21ONU9nb0NYZzZsZ0Q4amJRRERO?=
 =?utf-8?B?UHEzRjBtRnd1aTF4ai9Bd1JLVm94Z1VmMmRlNElRYjE4d1RkQXl6M0tWM21Z?=
 =?utf-8?B?M2FzU3hNT3IydG92L0llMXpvai91czJUNzdGcVJwN0JCcU5nKzJNVXkzUFpU?=
 =?utf-8?B?Z2VmdUpOVkZpS3d6LzFVNzF0QWlXY0g2VnowM2NlRFBIYzRhS1J4SVFqZ1o5?=
 =?utf-8?B?ZXpQTnZDVE9rWlVUY1ZjRkxBUXphSThsNzc2UXZXOHEyeEgrby93ZU9PWFZD?=
 =?utf-8?B?SENJQzA3cm5pMUt3NWcvSUFXWW1qZmNLT2IweEpMcytWUGtjVjYySTdOY1hq?=
 =?utf-8?B?YzlTQWkrd2xaTUxEaEx4eTJpRzg2ZVN5d3pHZFVXYXRsc3RQbGk5K0tQcVRv?=
 =?utf-8?B?OVJnZ0N6MWNlNFZoWHRwbUlCUG9PanlaK2JvV1hlSDBlL3hsd3F3ZFhIQlVp?=
 =?utf-8?B?b1NLVU5IME13R2cxRWRka0F2WjEvd3l2Y2J3cmpTNnhKcWZsMDkxWU9IRE9i?=
 =?utf-8?B?akZBMUxjUEtVcExzOHpRa2c1cTBXaHNBenhEdTBiNG9nb1VlcEhXOW8vRGpX?=
 =?utf-8?B?eUlrMktzMElXajd0Y1VHRDlDNHE4Zm1LSWh3K1JkSHBQSHJMbHFqa2ZHOGFt?=
 =?utf-8?B?NEhqRkY0aUlwd01LN1lLeHFNZWdOaEhDZ0J4UVVLd3I2c1EzM1JZTXBrd2pm?=
 =?utf-8?B?czc0QUg1c3JGMjBmVlNaWGFYalV4bmMzV1k3RXFoY24xRmtYRnpsV3p0dUdo?=
 =?utf-8?B?bmFYeHZOS2Z2bWNyM0JZdWhzckVMNjlmMmU0QmxKMC9UTE4zaXV2Q2U0SEgx?=
 =?utf-8?B?NlhYMzFFTU1RZDJMVVFpcFNQU0EzMjUzWkFOL08rYzdwNU9NZ2N0VDFIdkRk?=
 =?utf-8?B?VlQ4cGpXUTFoMSt0djFlVzdmZEdTYnl0MnRPek9OS0MyRDlBN2Q5RldCSDk0?=
 =?utf-8?B?WS9rUHVEMXdIVHcxdnhUUEEwTm9laGJtNGNnMnJlUTVTZVR3WVhmQnBuZ0JF?=
 =?utf-8?B?NHhlUGVwbkxOSWZmR2tmNTYvVUhUaVhEc085RDZDcXA3cU1EV3I3c01jUWxp?=
 =?utf-8?B?UkZZTWpydCsrS0NEd2VjNU5LeSswbzh0NW9wUStGV3RLMGtSMDRkamhFc1NK?=
 =?utf-8?B?YVlpVW55WnJjVm5SQXl1NjAvUUc1dUJnQm11RngvTDc1bm4zZHIxZlRYQldS?=
 =?utf-8?B?RU0zOC90eVdtWWFDOTdRL3ppaXJRYmpBQlprWmprWi9iSVFwOThhdy9mUnRT?=
 =?utf-8?B?RkFPREZtbktvUkFHVFUvRmdwZ255bzZoL0g2dWJDbWpkZUVVc1BPWFNIRGla?=
 =?utf-8?Q?3HM26TeLFP4kxKPXcNPvbIq/es3kfFyC?=
Content-Type: multipart/signed;
        micalg=SHA1;
        protocol="application/x-pkcs7-signature";
        boundary="----=_NextPart_000_00A9_01D83E18.F64A47B0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4001.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ae3b0c-1f98-4b41-d25a-08da0bed0d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 10:16:38.0581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URhfEu9z3Q8kQ8Ep7y/rpiZR22lhCfYisebyq8mX6kizWCKplzwqJZ6cVYELklct2VN6RG5ImF3pUGcb0E+rZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_00A9_01D83E18.F64A47B0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> Sent: 2022=E5=B9=B43=E6=9C=8822=E6=97=A5 16:45
> To: Bough Chen <haibo.chen@nxp.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; Bartosz Golaszewski
> <brgl@bgdev.pl>; open list:GPIO SUBSYSTEM =
<linux-gpio@vger.kernel.org>;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH v2] gpio: Allow setting gpio device id via device =
tree alias
>=20
> On Tue, Mar 22, 2022 at 7:52 AM <haibo.chen@nxp.com> wrote:
> >
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > For some SoCs which contain different cores, like few ARM A cores =
and
> > few ARM M cores. Some GPIO controllers like GPIO3/GPIO4/GPIO5 belong
> > to A core domain, some GPIO controllers like GPIO1/GPIO2 belong to M
> > core domain. Linux only cover A cores, without gpio alias, we can =
get
> > gpiochip0/gpiochip1/gpiochip2 to map the real GPIO3/GPIO4/GPIO5, =
it's
> > difficult for users to identify this map relation, and hardcode the
> > gpio device index. With gpio alias,
>=20
> With the GPIO
>=20
> > we can easily make gpiochip3 map to GPIO3, gpiochip4 map to GPIO4.
> > For GPIO controllers do not claim the alias, it will get one id
>=20
> If GPIO
>=20
> > which larger than all the claimed aliases.
>=20
> which is
>=20
> ...
>=20
> I'm not sure I understand the issue. The other GPIO drivers and hence =
user
> space (which is already quite a question why user space needs
> this) may distinguish the GPIO chips by labels and device names.
> What's wrong with that approach?

For users, usually, they will open /dev/gpiochipx to handle gpio related =
option.=20
By the way, how can user get the labels and device names of GPIO chips?=20

Best Regards
Haibo Chen
>=20
> --
> With Best Regards,
> Andy Shevchenko

------=_NextPart_000_00A9_01D83E18.F64A47B0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
MjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIw
S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhw
LERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlz
dHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VD
QTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCC
ARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVy
cHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9i
YXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0B
AQsFAAOCAQEAJpGYHveFzmgLQ4J62fcmPkd4wJ8urL46itMWCgyLBPRARYB9oArCqPd4j0Yl0RmS
F1oNZgVDYQTy2aLoe+YGm23TkdJsTx1ExTxtv+njRnvvlSXMMULlOIt25/Vj+vTZ/wjFDq6PJOSZ
MSQHaVHSUrkLBT1H0pBmCA1Ecjuo7gUpG5T2NqD5KJP083pJZ+nogA9TVC9Ob+jNx0d/UR7UgRLf
KOxBG05AakTa4luadPIRktiULtjzG20WDhvAIg4M9w1+9SV+LpvvqBtkovpCfj9Rf4pNRV1CjjTY
AFIH0s3Q11HnFd1UNHKUvpp7/SrTyxaCXBO68U5aJz4zDjwIPzCCB+swggbToAMCAQICEy0ABsdV
/0AV+3f0TucAAAAGx1UwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMw
MTRaFw0yMzA5MjIwMTMwMTRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
MjkzNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6VTRRCbJgUEuoR2bppNZQc3ghr
l0pDEZjK8uaayFYadelTc6iWe8EBLWrrOWd17yNeXc054yw+Yu8eI1IWMEE/mo5l93Kw+BkuCUda
vpqZUMOvaPDKkHNPBNPJ6AP+vmZW8p/46dxo6Nx6xGzkpbUZ1Ju1a9LuxeFQBNNvV54wYbFmoKJF
eQQ3RZdEafNucOw8ukTyWurcC8fPUQwqE1sFRdtjLeJWZBtrvNim4oikb5UFxcmoaQkJ/sqoJGZL
+bR3ZZx3101+Y7RJp56hfqT1eqkJkc7OTz+tsZx3p1a6r266NCB/RBIGVD2cFmhUs2Uitp/oB+9k
BhycuX8wowECAwEAAaOCBAowggQGMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwQQYDVR0RBDowOKAiBgorBgEEAYI3FAIDoBQM
EmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAuY29tMB0GA1UdDgQWBBQY587dMxoS
HzI5SkUyoLrumaVa5jAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAsjJuJnMzvA59CAlY
87eQCOafWbMF4HfC4oobtAqboB48BtCZ5dOeo+X4XQRaSmTwFJ2hZjX614KFnRGXLk/nDIY4pp8+
fqfgHKUdY1ceVqs+Kjtabk3gY8zq7PtFUsAkwp4OW23kwphh7Awx1tf3XRZeOqwiVuk5V57GT8Tu
dKNiOZqut3mrcdZINNUsqjt7ZA82r4ov5MbEBHeWVjo7CeWbgZFZhKhMKC9+2DKEUkdDJUcDYqxz
+Rh+6B+dgxeYkTGIqHELhkMjMCC5SwRNHfCxXCI+qRy4zIAo2K3V96zs3ungqiFZuFrpatfSBfAL
d86AIrOgsHhvOB0UU1W//zGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlz
ZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0ABsdWyH4wxYEw
yQ4AAAAGx1YwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIwMzIyMTAxNjMzWjAjBgkqhkiG9w0BCQQxFgQUKsuULFiawsKOFi9dRUPq6vl5
n+IwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsGAQQBgjcQBDGB0TCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMIHhBgsqhkiG9w0BCRACCzGB0aCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMA0GCSqGSIb3DQEBAQUABIIBAGYH
wCog1EO/61f3zo4iobW0l8BFYAw1r2SqTtT4IChSPQpu59ZD0RUWjSJUMmKnQ/SOSKeWnctkTZdU
rX4PyJE6GFVyfjpYtVtVfRuC8L8zaGLOf0QpJ7y8ZUoSXQn50/8kiyE1slR3FG5rCsr/4xpJUZ4h
Tr+j/7bezEzUopEjf4wEz6FaPXYizanHdXPqo90K/S688rbTUglU9qtvVrZqliRZMq8yW61rOkin
zQJzNdmZhHGpwBKaG31KT3x2dfDLdNIWFSxc56lM+tk3oi7wvl1X29dQnOSPq2v48PXl8lMSvf6G
YuzKniHMI6FyZhoek1QnH0bZkoWxAwGBiTQAAAAAAAA=

------=_NextPart_000_00A9_01D83E18.F64A47B0--
