Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE67509C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbiDUJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387657AbiDUJ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:27:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA21D54
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4pXPkV3Xl3J2Kn8LItSpsdn9NzKjz+E6lBPrAFaRFCG5KYlybxj9NQXnOxbjuecFzLyiMtr1er/ZZx00vCDFoXiV19lBTRzLfpHl5zySpECTjPO5Y3e4jX4NaXsGfG63XzjXHFb8JnHIwYA4lxETh45CiyYia4Lbw3zXjuoB/mZy91LtEwPzJ/68qsYsPkb3uqhJO1VifEK8bPjmKdRaqamAhaBTdT5o7k1KJyE+z0Ba0DvVa7LNyxB+kJwsnNlvV4TQdx8UETt49FOGgXzwSHwU1BZRjPnprU/CZqDIozXuH8tJkY6qdGh74TftiTKLynPsnudRBzq2fjLuHe/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLlEpHFEuWTpGimyAlbGymQtTNYBDHueO983fD9jMK4=;
 b=VYuWnYaX01OR0Uhwq9p6YHND+wrf2bne5+5iAj5rDwj7Nabfxvm8CfFUqySiD9mBcz1SFEloVXs6synf5phfhPSH9jjv6N+PB4i+CvT5i16AnfoP7LPuI7FbM1sr5tD7R2Hl/pTxq4rrcFh8rsHNI51U3ywi/FSuLmlyImo7+9MFMxl9naOWETF8biKPDt/QhgK2QYV1f3rDy3a2qjKQQUbB9R7r1zC4ztPoZaOkb4OxR/6xjLl6u0CTHjRaSpx8wuSRm2JyspD3Hw4co2PU6IDYwkqCi3mmP+YgLSfZtXocEInfI4UjFSZvqmcLI0k20ihVqClhasC3vuD4bWA2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLlEpHFEuWTpGimyAlbGymQtTNYBDHueO983fD9jMK4=;
 b=RC0Ng51NuI+KE6LYupUgAUPv2hZDZ6wHgSakt8lCnJ7uzqCvQM0OSSTfPDYP0vbr+90EbWMDjkRykUn2PHdJVB6P6MapHntVtX0mg4BMaE8l8sGGieu8qQbPQg19q/4QShvlX72QIwDfkkhsRuMbrLB8Ffc3GxfjgYoFaH0SZKE=
Received: from VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15)
 by PA4PR10MB5684.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 09:24:50 +0000
Received: from VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900d:c198:84ab:680]) by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900d:c198:84ab:680%5]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 09:24:50 +0000
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: RE: [PATCH] regulator: da9121: Fix uninit-value in
 da9121_assign_chip_model()
Thread-Topic: [PATCH] regulator: da9121: Fix uninit-value in
 da9121_assign_chip_model()
Thread-Index: AQHYVVyZGmQjckztX0y+MtXV3smQLKz6F3xQ
Date:   Thu, 21 Apr 2022 09:24:50 +0000
Message-ID: <VI1PR10MB31673DC2ED738C26A8D30046ECF49@VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM>
References: <20220421090335.1876149-1-weiyongjun1@huawei.com>
In-Reply-To: <20220421090335.1876149-1-weiyongjun1@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee8e8ecf-04ef-4d4a-543c-08da2378c941
x-ms-traffictypediagnostic: PA4PR10MB5684:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <PA4PR10MB5684106066C2683D38B61573CBF49@PA4PR10MB5684.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UQ5W+4u8ylCBkTYLzSvPQD48Z0NIYdtZ1/vMCswfxRC1dJpLrGddV4UCg7qXkIsBkQnnc6zD8DiN45Nzi9aCIN2XoHrN2J9XYSQST9yQCLTio6VAXWKhNHAkvWu+onQDGMeaErILdgYwSwsWzyPYLxiW5xIVrOCvgdkF9sBeDlkgza10yuCHIe6+FQTOUbi1HPy8FIJoYlmPHOcLXZGIoaP/D7A8ahZdCOj9MtaBTAXiY20B1t2j05HIrDvTjel8TpLDzPh1rWV9NTygsa+xf/ClkPz/Ej6t0pHovPNjNHsnOuutol6JC+aPR0XID/WR2Wg+72HFZ0XJ1gGY1vF6qVMWj3DEwAYJCGzte+M7oSub6NqyD38G3VkKO7x9A6MjqQCUYlv3ocaB0txWou6X+a+GOKurKCh8VVDjrFI6nlE8QgFvMTVtC1isdLbUZbgrHqaSa+CN+RJXnajRfYDeMYWecF8qiKTDmCesOX04Hb3DO+AllTBgq7UUKCoQPLg6BAhpm7vrPVL8xVxMhYH+crhJVBfAytnEmGpzyggPn7VhcPmjI54MoCJ6qdQrjRR7uMJt7fbGL9NGxCpZRMKhgvnZ6/DKXR+/8ExnScmFe4JBbgmrh96iPMgmGT/J47atkCqjGgRvz94zDIa2cMo4nGdAGC8Plk4+fwLhRuYrCU3y05zm/QHom2paDG+gZ9VJyBUV88cqhVO6uySlvYtZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(55016003)(6506007)(2906002)(54906003)(7696005)(53546011)(5660300002)(4744005)(83380400001)(122000001)(33656002)(316002)(71200400001)(38100700002)(8676002)(66556008)(508600001)(76116006)(66476007)(66446008)(52536014)(8936002)(186003)(26005)(38070700005)(66946007)(64756008)(86362001)(9686003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zBqcYikOq8FXzg4/94KUCdx0lliHVVo/VUaHW4GbyOmUGaXodSofQMiCEpy3?=
 =?us-ascii?Q?BNB9KoCyqQitEgEsCMU5JN+HVbOlege/9HVf3HyNbwEVEUSoWWbokX6NS5bR?=
 =?us-ascii?Q?apofqVNsG8MCEUsLvOsxQroXGIzslI2oH20ru1vtiy8BJyCbl/SOaIRPq/f9?=
 =?us-ascii?Q?scziD+O42EzOi54QP73rCeg4uvJjmIBr0uwHarqD5jLNPjyA/mds4psExQjc?=
 =?us-ascii?Q?D0PwgB80hFEFNb9eYjxKKZ0qCAZISlwfqsNbvTBknlsyRnTmOYNASoU/r3CW?=
 =?us-ascii?Q?bdwPw3oR9Y2iqrgxaryLprrhnZNKG4VhB+SpgLUMWURXIZgXzo0nGs4Z3bC/?=
 =?us-ascii?Q?ZyxMCA7KvZTInwnst4GwTzZVIhBSKYzgiLl7pZoGnDpQtTYxiFL8AtFcKsUs?=
 =?us-ascii?Q?BWFoJxjuoF63YZGVfPzL5SNUm9pTtVOgJZVRPvCk3EoJNUNkHEbtmyaZhDPk?=
 =?us-ascii?Q?ScKdhFD/uZdeEjkNfqOzXZo236Z4myPuH+hQonZGgJrlWNtpXGeQEVff+8yZ?=
 =?us-ascii?Q?9emOL4XIMWlDWSxAXwQ6fafj3dJIAZnoirZ1GZRqkJC9BJ7coPWDkOSHeSFx?=
 =?us-ascii?Q?S6dTt6NALP5b5GWEDrLNLkBs4rigJeoZSA3cHmZz6HLsCC5rI4cvYLn2raFv?=
 =?us-ascii?Q?h0NmOY1GZrqdmgMIQteEI3U6jEpeBa3ae9k8GsTqJXx+H0kghQ5urOAPHBEB?=
 =?us-ascii?Q?fbXWcdcjqes1aGAWIaEVFui2UU+8PpqimG2cTHRXwK6Z7OReZNaHC/7sxfe/?=
 =?us-ascii?Q?w+qkxgCRzT6a2KogbO5uvCsicNu6O1R8q1m/DV+LGDwxtufec9N/Remav+V9?=
 =?us-ascii?Q?SglnVRAYpb9cxFs6aD8IwkLuJUJn3blpugpd9jblACVRVBMBC2cnLCYUmD89?=
 =?us-ascii?Q?D6WevLQRe/5Tla9p0UuMQ6614XzAKPY2qgqCl1RszJNQNL23dLdf16Iqe9pm?=
 =?us-ascii?Q?0ANtjw0rht2Y9bRX/TqGukWKtEcvxMgnPlPqz7/MgekBQTC/WuK4uQCBZZLt?=
 =?us-ascii?Q?fY4EEiccdttBxEMygFrIeROa4+9eOY6TwSofhbYgAo1HVymkvDJAZb76uwgh?=
 =?us-ascii?Q?IxI9ZSXl9P9FTJfYEISCAE40DngT0xDJ3gNLSzv507t/iQI6rVe1G/j7wlxf?=
 =?us-ascii?Q?3D0Hd+I0R1W4CmJi6E1iLc5zivW47X/S6+f3FUqetrXBrE6qUoCJNEJRmpL6?=
 =?us-ascii?Q?XO6PelcP7m569Ff+IeCgAMkrj8HcdRZ0zzq1Dj/EKOyzFD4wum+bEvaNkudM?=
 =?us-ascii?Q?ywTLSBqYA/KLVfkys/V3iSfN7SBX58tMVsyIMubmgqsKZbZ4L/iPhNQTQ0+u?=
 =?us-ascii?Q?JaTU5+zcp6rbGpVFEGAX1ZjB9p+3OM6TIFwEM09Xy+tBwbaJfbRyvYLqd1At?=
 =?us-ascii?Q?35E25iLsPHzsGYVfRgjHRtW/mFFUEnRh06kqJjq35Ct+R2iKyWOS8WYXGuft?=
 =?us-ascii?Q?bx8NF8m7JBcF11KaPpGVsLo421i2WAEwI9m/S3n+VP0SUsy+9bvSLhvpb3lr?=
 =?us-ascii?Q?QC91Xp2azCRiaqtOuNBn/oA60ZEGgQGTlUbi/Xu7/niFeq3IwIYbvzCW0Z64?=
 =?us-ascii?Q?BR6FBTj1gI/u21LhCi/AekRaa9nwh3wjYiVWg7Fua0NhkAK8egjw/PSVr9q9?=
 =?us-ascii?Q?qQR9sOMkBROx3tjjRjr1fE/3guWry/thivObP4UOcxD9PMRLQ/PtlKbTODsK?=
 =?us-ascii?Q?+/5OyC2YVxpakR3Sd+ARiExgZYdP6qU6pTMASm9aN8+EfOHN/jALtH3oz+dF?=
 =?us-ascii?Q?e6YPn4lMHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8e8ecf-04ef-4d4a-543c-08da2378c941
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 09:24:50.5739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwtI+BIgYnM+ir7LO8khugCp8D5mfltpMaDKmgffqQtVZgB1pNlFpbT/T0SHlSnEMTVmJR/FGhDksJk/w+llwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5684
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 April 2022 10:04, Wei Yongjun wrote:

> This happend when da9121 device is probe by da9121_i2c_id, but with
> invalid dts. Thus, chip->subvariant_id is set to -EINVAL, and later
> da9121_assign_chip_model() will access 'regmap' without init it.
>=20
> Fix it by return -EINVAL from da9121_assign_chip_model() if
> 'chip->subvariant_id' is invalid.
>=20
> Fixes: f3fbd5566f6a ("regulator: da9121: Add device variants")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Adam Ward <Adam.Ward.Opensource@diasemi.com>

