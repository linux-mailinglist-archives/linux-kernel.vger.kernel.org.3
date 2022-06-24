Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A45599CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiFXMoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiFXMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:44:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D127548E6C;
        Fri, 24 Jun 2022 05:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jtad9WJdZf9glkRPJr7PyJ1YUNA0TIQ+I4SBATtAmRVllyYK8OdLOMhgSBdrU1r/C3dPROVZUqrkIufDoGFbYWTW5xj26hJTEY/o3IUY5DVHzC6vR4ddCwgMgYlAyWr4NV2lUnltJCd6b7xurbdvdwnPF/3TuPKxWHiPDdGkdAPcvAcp/bK72a9d6LIBqtryUEjrtxyQYJvnpZGyeKeVQ+B/Ngwo1vNHBogE6xzqNnSa2PtqyTZ3DBKVdEJRD/JrxrGwiadnrrDwoYVabnwSyw/ceNsI1FrDSTMCOzEnjpWJePjuqk09QvPJZfiXr1VWCXpubdgl9MhSrZ8LtnPqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PRhaygxHrBAAgy+CgxiIg7U/HPzu9LjHwSE52EAl/Q=;
 b=O+vuJA63si4FOP8Z02bdWcIH/0wggZNoWZGXnPQ3tTGKKKCJ/nUPLZnzBM9TASp0brtQiTHKMhwiCO++CNAM90pmdPdjP91Uu5xwJFfPF/SvkG4GMLzRNBdlPw9FHRAOBCL/Ci6LdaUxbkwudC+Mtv5RE6s6YJ+WMhTOx+JUIvOlGtH84aOHKdqY0WX1xvDoIwtiSCsGLYso/PsXbzTFLiyM9g5quLh5d2uSRfB7dm8GTCkXVOzNzD6y/mFymQAOgujLS6yg6GRAMKRuKCRL1Wn6SqIFO4Ve6vFM/UjiPkWLdcIcRS7wpna/mlu4Ognj/mldQ3xKqRsProBa+gkoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PRhaygxHrBAAgy+CgxiIg7U/HPzu9LjHwSE52EAl/Q=;
 b=TUEmVO2y+2Ih6jRF886ZqgsDOOVuY+MFmjsuYwUjKwGjaaUWc47bqIK5/gf04KIsDSnjqxAQbha3sO9QmHQ1zYuTGOcVrwjWjr13CQUE20BBrSeq+wt+tdH+atn0QfRQcHezk+Dk3WMeAOacld8TPPUmBdNgAGcZrYiI+74jOpx7APrgT1T0CGi5ok9BnR6Rwruc9J2ZxsxQNlz5pZVsVdRdefq5mP7ifCpuKdlGuP+lMZPWOvT83K/cagTv6t7c6xojKgmaZPf5s5z8ykNnVzdOEgaNE2kuK/32O0lAKJ1q+sACGZ7YLT1eaPOGASPRPeLusiBWilozZF5Z3YHjTA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CH2PR12MB3846.namprd12.prod.outlook.com (2603:10b6:610:24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 12:44:33 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b%5]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 12:44:33 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sebastian Reichel <sre@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the battery tree
Thread-Topic: linux-next: build failure after merge of the battery tree
Thread-Index: AQHYhD7/SjaYCOIaYU+H8cFj+TXaJK1d4QAAgACmE/A=
Date:   Fri, 24 Jun 2022 12:44:32 +0000
Message-ID: <CH2PR12MB38951BF631A307CD350B47A9D7B49@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220620104503.11c0f2e1@canb.auug.org.au>
 <20220624124730.3516928c@canb.auug.org.au>
In-Reply-To: <20220624124730.3516928c@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b6c441d-202b-4c2e-e468-08da55df49c2
x-ms-traffictypediagnostic: CH2PR12MB3846:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3sh1xSouSecOM4QtOJ5ScLZ7hgwr+n8x4XEz+WWZfZ1gmVjDsATJiZ4yybd924PgBct56jY2xdcL6V2Ftdh9KHDo3xW+fXKnhqNPKRvAcrcAAvM/DzKZnJQV40e35bnu9AEReM6tkQcbQCirATWyRNVkebwOGyv9vnLuTKW81406kp7pSiw6BflXQn1q4hYSqXSTpVxQUXetlAUUBDsIen93hNtvyQo40g+6ODI475wuJm0EJXS8eE8Ib+I3ryaS57AHNf/A4ULMB7biCBht4iJrqYfiVEe+YLYjXdQFf9YsPpVi7GNS4Tw0XvO6lWmngBdwICpZlD2cqh3gLKN+OZ6/UGSZ/oKRMmKc8WbzJP8NJjgXIQPH8rf6FXrgPSm+2hR9cVshLy3DiSpnH95+CE1X/dHLH+cioWz7V2RGPuklk3Nkxd8gYrGtREbh/q+jNS6PXXh42NLa4Y1JvQ7ethR2iFzn6K1wWYwUUThleMnKpLnegUxXVxFoHSusr5wxbdhqB0MkXetGZSRNKu0WI9pYxZHd9Ovoq4MytaAmI/4DFEPvLwAsN+WmRx0vT+hTVF2oNEJfW/ADdrbna33HIB9hnP76G8SEfIqbgFdXpnAjXow+MWEgf0FyqA7lemijDeLii4fgs5YZ0m8Igvaax7VRZJeHqB1HwSR/oJS0B8f4QizvcH1azLRNr//TpWKxCoyy7U1cSU9JO99PKhb8KVMQCNMRJXjXPL9ZFMp9AvVd4+LoZyZdYiBv117ZEH0yPIFAdPb5+/eiFh9nF51heUa9jJxsUqHMzJmqr9VlQ2g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(66556008)(66446008)(66476007)(64756008)(110136005)(54906003)(316002)(76116006)(4326008)(8936002)(66946007)(38100700002)(26005)(186003)(8676002)(6506007)(83380400001)(53546011)(7696005)(86362001)(478600001)(9686003)(122000001)(38070700005)(71200400001)(33656002)(2906002)(41300700001)(55016003)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e5wbGLSs/g5kNvrPQdjkVBFzkI1cbyL0SS0931JURCZLVpPSIQ8j+Wjrtl4C?=
 =?us-ascii?Q?rTN9KBOhHBUGEq5BZZwzycMrbF84cu2CtNIrzXlk+GtgQI1i9Es74hWGdbEQ?=
 =?us-ascii?Q?ypk3yVDEBhFJA66vYgMd6eCF05b8hcXpIo+4Wxy8gnuTShHiYvbuKemg19vE?=
 =?us-ascii?Q?h2jCoDPafsRKR7qHnMbQouwLftCQUMdqchu+c1qPtO0XYfVcSz9fz4p44A+Z?=
 =?us-ascii?Q?FMH35O7TILEeR47uG8t5wNVVSjQN/6k2eF1az9Ga66qJx7ed4VQMTt21y5Zw?=
 =?us-ascii?Q?dcx/nCre7Ex0tXePTNwxT4XU82PcZaHsQPy3tnIoqwo9T0XKPtABil9KTrD9?=
 =?us-ascii?Q?A0AS0Al+Ifu+zbn9QPR7O1j99+tyUpIpOqBCeAMiu0h4BWfpsxTAyv8uwZzb?=
 =?us-ascii?Q?l4vJVA/DKOVLTDhLWzkTInH8v8CwjH8Y59dQsuhdFGHXoAaa9vaxd1iLHvUl?=
 =?us-ascii?Q?/bSYqeZK0fPQSppGrub7gVQiwUFD6j+ycPA1zI3glLbQQgTPVYoAUfxpWt9J?=
 =?us-ascii?Q?knxEdiXA+5IzXxb8Kla2m20WqVQoq9eaZ2Z71kOgnCqY8EmuHjGy7D6CqQdP?=
 =?us-ascii?Q?h8Ktkc25LFFIT3gx65wyVj/MUPdwwGbhT83X+G9GFmZgBA6gk2wEb/Bx5zjA?=
 =?us-ascii?Q?PwM1x+kO46F90uzJgp2OVZwRCZM6N8yErO4NMVJy2YApBTr8l7tLTj//SfQQ?=
 =?us-ascii?Q?aoGZGkJyEAMAxm11osl9y+4/ymndmSf1NPABXb2kqNADHELHt24os1WPSPaq?=
 =?us-ascii?Q?l88JHC2VTaMkmrTPxVMoCU8vGXHcsQ9a371kmE+PmO8vgIiQ3zlJ4qj+wXB7?=
 =?us-ascii?Q?d5jc4FMI5X+om03qRE6o1CfAYOveHyBqHHdK2oVvOgSpoV928jpGK3fp3vCt?=
 =?us-ascii?Q?plBOO9M2JQTdeQYC6ufSK4PTIqwByo65j8F/MGIP9PogH9lmWs9LXXxZ3bS7?=
 =?us-ascii?Q?dhVdyjKVnPBcgQ2r6abBTmog/bXWqAC7fmwUu/03ar16lSiUfD9Quh+/LNFO?=
 =?us-ascii?Q?jMSao3TrfyFz06aOiwQUJXJfjSn7Q42hpgGOSTtOuaZeL8GqC4Fe0B1tEe4H?=
 =?us-ascii?Q?5eFqaTbHmfWNcv3Kylzknw7E77Jl2uVT9yzSioYrDUO0VXVLk5wLNl+Ir4YQ?=
 =?us-ascii?Q?Tfx9erZkRUCgiPCAq/8mCASj6XtRzcZ68kKRdZ0E3qS6ZEf1N2dfPr17Bdml?=
 =?us-ascii?Q?q+wdkyL+2ITvpp6Io4C5F03Yu2YIG3KPaOPZh3F8jiOhgTki9fm0yfKolVtd?=
 =?us-ascii?Q?UYVJzuWGg+yypV7GlluVv6jZZxfCwHdmWA+ragceRiWP+uAnyBDKodXKzKmO?=
 =?us-ascii?Q?5tzK5Nt1fxo48RU9agEyihCKXfpdpeUto7ciDD4xlXAXFcz8szLRw2KmWp33?=
 =?us-ascii?Q?HoFv2jbo+/XtnY/RttGhnlifwer3jOIDsdR4K3Jh7Sp6FJPajHIndlfSpJ40?=
 =?us-ascii?Q?DPr9pnlR5cuToaH0HQrTBgTo4uB4s6kpvL2AtUGGGH7ynrj88Y0gdTDvdbfm?=
 =?us-ascii?Q?29K+rcyd2Qd8zsswDM2z2HucXMn8/DiZNmoiCPWGhIiK5H6J5Mv8M8F0z79b?=
 =?us-ascii?Q?XBOApwEaZ1I98KZc5B8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6c441d-202b-4c2e-e468-08da55df49c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 12:44:32.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14aRt7TtSoi3iZLn6Gw1iE7jA9FxjSkAs5QYg9pfPFoC0q3BSbLc2QQ1m0ks2NkNK65SSszIa/67TflDWr0dAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3846
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sent a patch on Tuesday and added you as a reviewer. Could you please tak=
e a look?
The name of the email/patch: "[PATCH v1 1/1] linux-next: Fix build failure =
in pwr-mlxbf.c"

Thanks.
Asmaa

-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>=20
Sent: Thursday, June 23, 2022 10:48 PM
To: Sebastian Reichel <sre@kernel.org>
Cc: Asmaa Mnebhi <asmaa@nvidia.com>; Linux Kernel Mailing List <linux-kerne=
l@vger.kernel.org>; Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the battery tree

Hi all,

On Mon, 20 Jun 2022 10:45:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the battery tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/power/reset/pwr-mlxbf.c: In function 'pwr_mlxbf_probe':
> drivers/power/reset/pwr-mlxbf.c:67:15: error: implicit declaration of fun=
ction 'devm_work_autocancel' [-Werror=3Dimplicit-function-declaration]
>    67 |         err =3D devm_work_autocancel(dev, &priv->send_work, pwr_m=
lxbf_send_work);
>       |               ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   a4c0094fcf76 ("power: reset: pwr-mlxbf: add BlueField SoC power control=
 driver")
>=20
> I have used the battery tree from next-20220617 for today.

I am still seeing this failure.

--=20
Cheers,
Stephen Rothwell
