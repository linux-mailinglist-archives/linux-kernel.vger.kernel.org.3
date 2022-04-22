Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21AC50B03C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444237AbiDVGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444386AbiDVGNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:13:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC885005A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In9/Kxwb8/0IA+uaW2P4CZ0Mr7iBHADiMIJlZ32o/tl0dQyP1Iewu57SeRaYEl8tQOawpTtsWJ+sDoFkRyVhOxazE/zwlLCpCDAtJzc+biufgVFbRMQednh6F7aUwV7qjI5eAh9LwGd8sQZ3Fnaz2YagLQa4Hrmnoix7ULmKP8UjEZFmZXtyP3yqCFlDrs9cNk1LpTvu04AwqXU8fxWd7yRWo6N4AZLmKCECQ8AcVzVDTcs2S1dmUDqGlP8msIKI8DxyRmrtPA8ZAaPaJxDvN4DJS7BxRuBl5Hfl6wBV0rlEJ69+oMZ/hmVs52Z2qSIkuLcuGOfsUFbd/aFC5sKe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/7eMbpnKB4dsGoQ71Vag1dF7DM97NI0TgqaF3qCyyo=;
 b=XKvJBcr4exC7BKot93F9F/89UVR0ixt3BdddZLpULlIf9OItBIAKApMFwap08zy85MY8NndddzCln/YVybSoT86IhMN3l6ZeTwMhcgrL8qOu059XvZalTpeeJCca/iBdG1iKfLx3GDY6jCyHlswVbCo5ipfD4ALGRTTPpE0F0F0ZbPb9L5ZJ4YNihGut/xs9A4Hr7AT+sPTbDPLdHbliMx7hyXpKtleK0+L1VSpZBfKjbPUHdx4Cn9ct6pV28mVhdRPoH0P2ctmaM3g8b+TyubdBsuNYRoDqxEaKNYysIIH5ntzVVwp1EBLCIqEeff5rFzoR6etWfqSAqkqJEg0QQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/7eMbpnKB4dsGoQ71Vag1dF7DM97NI0TgqaF3qCyyo=;
 b=Ivyn7l0AD5UcYXoY+CoxVolr/HsVFmPmA9GYab/i7dNJOtskOAxYcUFwqF9kHz2e/vhkKQGeK01HGaKyzOB5SPDeruy+/5M3uLFqqaWYjIRooahxvcjgvwTjNcTTwbzzd/oMLJ/8G+8cuTriMo1dW4sB+vSLSJ3V/7wyDo/36sM=
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by CH0PR02MB8243.namprd02.prod.outlook.com (2603:10b6:610:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 06:10:45 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::30ca:eaf:f972:ef57]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::30ca:eaf:f972:ef57%2]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 06:10:44 +0000
From:   Ronak Jain <ronakj@xilinx.com>
To:     Ronak Jain <ronakj@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>
Subject: RE: [PATCH 0/4] Add feature check support in ZU+
Thread-Topic: [PATCH 0/4] Add feature check support in ZU+
Thread-Index: AQHYSaTYUvhMULSPi0y5zlGpMhcHlaz7i62g
Date:   Fri, 22 Apr 2022 06:10:44 +0000
Message-ID: <BYAPR02MB4488B57657770C2589249AE6A4F79@BYAPR02MB4488.namprd02.prod.outlook.com>
References: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
In-Reply-To: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd1b2b6-6658-4c26-9c48-08da2426d64b
x-ms-traffictypediagnostic: CH0PR02MB8243:EE_
x-microsoft-antispam-prvs: <CH0PR02MB824367C74D83A64EF4FBED71A4F79@CH0PR02MB8243.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aqEI6jATLtivgs3HFYIoSBEbEoTVDK9Cwh1yH/FARpSlDPar0WrQ1+GiYgqYYvUkXR5SfvFkAQHa9PSw+yOUL3ZqRIpsl7YzHEDIJWX90me+w/1hDOfGXk0Ajb0eHVYUbfWlF3eoe2g2md4m3lqzaw2hp72t1tvpf1cpj2Y6qszVeIlztVhmKJsMOT0uA4StM4hASM4nHu+PSQ1L5kNmBiMBCnSFyMs7428YRFjgXrz/+fzbuyvlP0GK/NUme7CPYNVi1A+LJfBjqk9lkbsiIzpabfl8p0h3j1z92WxPpN6Oaq2Ly+4/pDQPvvfVLxDXmBEh7wJf0vdBhVyw/3J6oGKn/IV2sK0kNSqCrhXuY0tB09cBE+jIs9WC3Mv6cnsndMyT6uoKy1isA3lYiC0ZWZgnlT4+i2gR5M2RUShkckbqMo9b8+XxRkhFPlYZOf7CCbfxOf2GEe0P+38B1V34XEgP0uwvi0Jyp9lpExRcF/NICTeWrWwQGalThZH7g6CQYD2ynxa0/jkthX+fTtp8TaKYtGzs1mWewLT84hpCegndKmrrs7VGRSLqG3xdgCLqPdUu/gA6C6lb8zKKwJC5YpI336kfuAWu6bVKeCvCGHHNHzlVX0Y15X4egp35SpyPMdn/0SCSrWXs3WjslIc66V7O5JgMvJBc1HRJ4Vul16jIKGJGcCpDXiRwV93nSvTqJ1b1zQdB9QivBNhutsqFWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(2906002)(54906003)(86362001)(66556008)(33656002)(66476007)(8936002)(38100700002)(110136005)(83380400001)(9686003)(38070700005)(52536014)(64756008)(316002)(8676002)(6506007)(508600001)(53546011)(122000001)(71200400001)(7696005)(66446008)(5660300002)(26005)(186003)(76116006)(107886003)(66946007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rg2FX/UgJwkTYqLCbOuDollW5RMnGlND2jRSiYmp9YWOCkxZHaYYKCDPoSI/?=
 =?us-ascii?Q?ot7WuOj0QLEM6LGWHseKgKx3Doh8opTrKSi1MSDg2ajWGutjaLm+wyOTwQ78?=
 =?us-ascii?Q?KxbFW3jGBM6PPvpGY07Kx/4iAB1UEkHUUGw1POlGASvH8DTj/lm3+UQPZucq?=
 =?us-ascii?Q?ILp2kU8dQF3vnud8BSME+Ts5mbKdYrCpiWpE2yBQcocBJ+z+JCeu/NTAvWhg?=
 =?us-ascii?Q?lcVKbryZMdkV7TvVVNWlguNb6ezGCl0HukE3FQZ49GKw7aVs5B+eL+9NbaYV?=
 =?us-ascii?Q?xyQUlBuIB8rRZltuKuysJZ2bNl2STTgBOeoLYVbKCZ2reYUcbBbbaRit/dUT?=
 =?us-ascii?Q?Zcj78YjKjzTeJrbbP1w+2cWU9hbQWwlq6piWSmRi0CscScWJPdoBkd+KMWGW?=
 =?us-ascii?Q?sWS64D19Gy3KW6T2MuuU4P0B4UbK0/mNJgta0F1hNaMRT9clVwdb1eGY/Sx6?=
 =?us-ascii?Q?9AGgIDlLjIo3IFpm5cumx6c1tejHNffvjv90QvRhSj04IFA4zUGIG0EoC/FP?=
 =?us-ascii?Q?adgMohCsoh8yCG5I0rSPeQCVJMVAQi2EoH/bqouAmboBT+xU3N22hXM6/o+h?=
 =?us-ascii?Q?G9+Iv3lNtudmrQseqAngp+/2LtLZF+RJsSdBuUht+8d47F/hTNoACqv41gZS?=
 =?us-ascii?Q?YiQJOa3VSGla9hCzYhTVBjuxZYxLgpWtkS5QRY9fQwNMfJxPXx6CcB5D4ftG?=
 =?us-ascii?Q?egJlDAI6H6ra0ym5wW/nW8ExB/3TPKE4pkLudgmi44YbkwI9hEyL2SJ9Jsmv?=
 =?us-ascii?Q?JfTyjMC3CZR18xkGVgGUq4pyOa0np9itXsdYKWjVv4J+btaY/zmnaCHfZdfg?=
 =?us-ascii?Q?qTEqHgU3H8xTzPPcldW/kLbXF40Ifzm8wG7N5r9topTEaZo9u7YF0+EOKWUO?=
 =?us-ascii?Q?WsPavreEtYGcUwVaKxHVNL2IAIw8A942B6jDYn2bifQWuUtFCdxxFFtzLBWa?=
 =?us-ascii?Q?83uQJWwzWyjfCP34lpmQdkzntHpn/rM7LACA4tb7oYCg49ruUkueIotfNqB9?=
 =?us-ascii?Q?T4OrmYKq5P1mdQEK+OaMLc9LOhdTJiOZXj5opPSWEEIpzkl011P4FOWitmbS?=
 =?us-ascii?Q?x2axAnL+zzc4bIsIipRDRZQ2kG7ZE4q+ichWaUwpBnRKUwaP5fZ+5BDYZi7T?=
 =?us-ascii?Q?Iopgka88ptLGIlSQ1k4OnJChm40eKs9e6z9K1/j64+d0he57rELDJUtKjvRD?=
 =?us-ascii?Q?/nYx+n31s7r8ZBgsPVPHNYqK61tXrtsJHfVl6L+nVH6I7FPJKMExeWFAt1Io?=
 =?us-ascii?Q?Xafxp1Cig6WJC3YfY38ZMU67CZDSStoXIq7qKQGBISoyeJBnxl3oHSk6msiL?=
 =?us-ascii?Q?tpAHF+DyvWwMSOPI3l2lmATmrXKhzg5wgXElSjAeD/ahQRCtByZyqeXqlLcu?=
 =?us-ascii?Q?KfiyGw/XJoehN/v/C9hfq3eL/hGH3irgGPH5U8vZJVl6PfHwy4AnO/dBSCPy?=
 =?us-ascii?Q?/NKdOU/qdBVNdofhJS83dWMF4TAeRLZJPmab3utkyeERRlBWsg4GpOhkdkPm?=
 =?us-ascii?Q?AptlM+pSM0EpdzqDvi8/Tj0jA7uiI3RGZkknrmTcja/QFefKsECjkqXky+88?=
 =?us-ascii?Q?sjIuqME11q6NUU/cQX4KmbMGxYv1/ucOWI5XbHB1ZN6wudPxoJNR5peUFz4R?=
 =?us-ascii?Q?ADAwkrap3JbTxdApYwqlwBGDJCl732laPoq9GIaQ8lZxM46eeb9gOHGN98js?=
 =?us-ascii?Q?MAdGrHwbPZXX1wAG562iBJq+R1unjB55JW9SNOgF29KU6tejP+JpqXWBvO9j?=
 =?us-ascii?Q?nspoZUpM4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd1b2b6-6658-4c26-9c48-08da2426d64b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 06:10:44.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPs6NI14pEyKcg81EulYITpkJE+h5SiTGs6XTMvbmS4UeEmzbolAuEEux3FiOWJEd72OC/t3rI1wdeO9PJQMPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Team,

Gentle reminder for a review!

Thanks,
Ronak

> -----Original Message-----
> From: Ronak Jain <ronak.jain@xilinx.com>
> Sent: Wednesday, April 6, 2022 4:25 PM
> To: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org
> Cc: gregkh@linuxfoundation.org; corbet@lwn.net; linux-arm-
> kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> <lakshmis@xilinx.com>; Radhey Shyam Pandey <radheys@xilinx.com>; Ronak
> Jain <ronakj@xilinx.com>
> Subject: [PATCH 0/4] Add feature check support in ZU+
>=20
> Add feature check PM API support for QUERY/IOCTL IDs to get individual id=
s
> version from the firmware/TF-A if supported and return an error code if t=
he
> PM API or the QUERY/IOCTL IDs are not supported.
>=20
> Enable feature check for each PM APIs before executing the functionality.
>=20
> Ronak Jain (4):
>   firmware: xilinx: add support for IOCTL and QUERY ID feature check
>   firmware: xilinx: add new function for do_feature_check_call
>   firmware: xilinx: always check API version for IOCTL/QUERY
>   firmware: xilinx: enable feature check for ZynqMP
>=20
>  drivers/firmware/xilinx/zynqmp.c     | 131 +++++++++++++++++++++++++++++=
-
> -----
>  include/linux/firmware/xlnx-zynqmp.h |  11 +++
>  2 files changed, 119 insertions(+), 23 deletions(-)
>=20
> --
> 2.7.4

