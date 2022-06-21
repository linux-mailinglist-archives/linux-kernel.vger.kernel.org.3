Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641DB553210
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350437AbiFUMaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349343AbiFUMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:30:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBA0140B8;
        Tue, 21 Jun 2022 05:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/36bLz0mmfzpsdS3AWdciIpum+jxExd0tk6y4b+MP3fW9IxuHt4unkavix7VFhML1bhL5v7xmxS93V5Az+SkRXSd/rfA5duyMG+iGjPf7WPTkrbNQ1wjpMHqQ9uV7mxRi76F2FEa+mmyR1ut2tJr3zR/+DDtFv7f8HeX9/XjbxZH9k5X5Zl4qPpijpEzEN5GgWOiRoSxtFT35GTdH2svm/sKohlj02/AZyB6Lthu7f0s2hORqJ8i4ZnpRyHP4exygSGjlKrMWcVE5klDB35pz4SH5WxPoL6YW3+Glv+go5NkOk4Y4rAvq7Dcqr7z6dqPngx3nfhsbwJ/yz2P38O6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW48pd1HORdzaAmxF3NNnGosfoKbHwD0+j0zQqQVbII=;
 b=YIqZjnPx13UqAvDMgBDrmJFvdCY7SEVQFG9anG/RkF0pHe7NfYUW9K0cnJwAFLka1t+FZkTdpWpu6oNWXi0cVFUEz5nRQXsUzDSrwYczLWnflpuSUl3MGq8jSa7xth6gRjkyDj4ynbjU4igsZvtPPT5kzDwM84p9qp1waM8beDkM8wouvn8VsThsXi0cjjgH9fqdyn6OtGOfciwfm9kVUvpHG4GfNWwz+HBCoKNXVfLqPqRST7r9AKnM0jrJMvo3n8y9QXEcEDK5+ROCmtxDfZL8s+SqquBhKsfapBh8q/QY8DgkZ+w1E1+NvMoN/RfhzgelDyMXboEgHGEQCuvs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW48pd1HORdzaAmxF3NNnGosfoKbHwD0+j0zQqQVbII=;
 b=aoSMyla8f7yodUxnt7lj8JdctiPpVr8e53mONA5LVm+T7ewT4/9VQnkKBHi2L7pz19weS5RENVngo3J1SwsNhjMccTIJpFZ+LaC/vGTg+EGTUHGj5+k950OturGvpBLLZqA2ED7UdjI2/9YnLZfqmSfyYThKAhVLXOsGkGMp0/idncr5ypVxLJm2JmeMAuzVj3U9pyQnwG1+fi+YGS9tB7aJc+E1awUDtbjZaowG/n2A3a7cfpgVaK3yRLvea9YyRd7q30BWItZ1Nd/J0+WS0b0zBv2S2vNCxuEppqLLN6DSmRQsxxdLHopash7edtXRgvcmOmtuTX8d35qM2ZSeFg==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by BN6PR1201MB2466.namprd12.prod.outlook.com (2603:10b6:404:b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 12:30:41 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 12:30:41 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sebastian Reichel <sre@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the battery tree
Thread-Topic: linux-next: build failure after merge of the battery tree
Thread-Index: AQHYhD7/SjaYCOIaYU+H8cFj+TXaJK1ZzNSg
Date:   Tue, 21 Jun 2022 12:30:41 +0000
Message-ID: <CH2PR12MB389507C820B4C3E631EDBD7DD7B39@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220620104503.11c0f2e1@canb.auug.org.au>
In-Reply-To: <20220620104503.11c0f2e1@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94953ace-d8c3-4525-c835-08da5381dada
x-ms-traffictypediagnostic: BN6PR1201MB2466:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB24661B4DEF5C50685FD3A2FFD7B39@BN6PR1201MB2466.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LgYCO7BZ8sNBz4KJfAMIgL0pyXeQG/OujvrVEAAeuOMyn4DexEF5feIrZBF5pyA2DxL6CL2ZWnfrLbtisJImmKIDhEQ5RSnqcI5hvNxGFjSbB7RPQw2FAci1gi0dQmTaIp/PtWNFDaNwUJy1P07vcOE/Dg5WAUpUwCHmMshdKWiXJkHrx319bug/KOCCYgK7i9Voz/7h0tgFNpRBAgce0qxCzT4AQcTCKwV31B9QhAnokg47sWyCl9N9Iv8EEl+3CaY9aQLc8C3QPgj1J1CP3E7uHEUWmTO0HUMYqapWVY3Cn4bpUVcsfLpWTLRtZHb8G3fstXmn9fR+/cAEeP2r8oMiJ9TLeB6c6pOKUVJLsRq42oQC9MD+sofaZcHEGLVQvzbP+UFmFrxI7xQAMXE3cZ3RAm2TtpJNGD5qK3dnKUFEHNmhMEw72kC9NmS8DoPzCexnqMyw3hr6Up6cm2qO10N9voQyxxgjpz0tYe9fPcIr9hRd35F6gdnDDDvKDl+Wv53oWsbYJC/eR2vEDbPIa9vyW7wo+iI+bkLoEDleIHoZNrOippsYAJSJ6Q+lRMRpUJ5B/0nnPodfVkoKsq8E6jOCRY2dV4hgQSQaV/KqdJLxndj7HFZUO2iFfAMP6iLLgwuvT3xQa8Ua/+u+MF0u2zQVe0oQqNwwG/CRrQG02No9I6hJbfYC4B0ipCvNqJKzi1XwMza7se1EXYNrO2mY4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(66446008)(33656002)(8936002)(52536014)(66556008)(54906003)(64756008)(76116006)(8676002)(4326008)(2906002)(478600001)(66946007)(316002)(55016003)(5660300002)(4744005)(71200400001)(41300700001)(66476007)(83380400001)(122000001)(26005)(7696005)(86362001)(38070700005)(186003)(53546011)(9686003)(110136005)(38100700002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kBaJMu/eQutzUSdAKUrKhLOp+ieR31ubxypLrT7/YpEYxBws1qLvC2qGFsLx?=
 =?us-ascii?Q?yyLgo4lkjG4xCBWXLRvRYuAjaF20LYMtWC2+mLOZM95YWuCe0OAj2dgLw7FZ?=
 =?us-ascii?Q?Q2YSixEw8gJUW1//K9cvJoReBxAvpH2a+BuSGkXdVrWg0YPQ2ReXgidzyhhr?=
 =?us-ascii?Q?Y5euKZUVBGU8DTD1v1bYhB9wKnQb5snmEkxVxsQETMv4X2T7aMOH6O117BdO?=
 =?us-ascii?Q?pcdfcerEPef4O4muYegVzzBUSXGruUCEk2IkOCnXKkx6qIpO3ARKtQamnzKn?=
 =?us-ascii?Q?+0Ouyq10tGxo9FusW5EoM1fIzzKTraYzw8Ufgj27XjwdUgVqcqq3wP+FWl6/?=
 =?us-ascii?Q?22b3zjUwBX/+2L5xb6if6byaFFiFOkqg2Y+apqYKXOZTcLQejVa6OZohBcEr?=
 =?us-ascii?Q?QSCke6Q6MO9k1XAZzTy1Teix82/2Yzq9eQ+BCPAY918lJ7eG6HGeK/pCOE9o?=
 =?us-ascii?Q?QgCxpNffX/orMut5SPazicVifBWhXmXD0YJHbku19J6mHjzHtrotCdtOWI82?=
 =?us-ascii?Q?EX11ylnsTo5/sYpNlQJ2kG8Zn9Z7R5D5lPe4uKVuPgAqeZRVLAv5omMXySkN?=
 =?us-ascii?Q?ENrWBCxxqWR2sik4UiiyuNA4qd6DsJL88gP5q2OTUW9BOHA+7x+v7dAvKTH8?=
 =?us-ascii?Q?Uwo3zjzJz8PWLyKOX5kPhllr9Az8ewJAIoC/La+xWpIkNfLFddrgMJ5JHGNc?=
 =?us-ascii?Q?1pFKg3/VJC7dx4n2VeSB8erFKhjyJqU88HTY76mbXnLQCSUrNEVYkySf8s2V?=
 =?us-ascii?Q?DUZWTyU7CHoylYUEyJto6Oo0n5ESxBL1Cq2r44eq+pHiSKC2Oed66hvvznyr?=
 =?us-ascii?Q?Ye9y8hJzUZzRTAmTG9f9ogl+YyQSgRQb01kj0D6sO9lelWSEQ6kr/MDNtwKc?=
 =?us-ascii?Q?K03tYsB0Al7Tq9Pr3kJPFK8X/O1gVizO+wZl3N026oqbx3DLRL3ZDeyLSyjo?=
 =?us-ascii?Q?Yx9ujwjpUW9NYJcbW7aZS5geY+PAoKoDLWrEnvI/jhxR9BsVcrAMLEHQpYdu?=
 =?us-ascii?Q?sgUqtzC1DkDLVKsbkCVEqXaQR5jCkRpoZJcdUMlX+hmqzCxCW9TJ7GP0yH0K?=
 =?us-ascii?Q?utIbIpEXZkzIfwRYYo6a3QpCSDGTR6U4KQdf43eG1lBFgbN/NMtUgtrbYxXS?=
 =?us-ascii?Q?wm8OLPF7Xv8Nk1FpXKG821xMF1HKOvhPIxV7rYZhY3gbLpOWbWaRMNZPgJWY?=
 =?us-ascii?Q?zK9qPIbIGRIBqPyemhu8KOtfLmsijBRUB4IvtMZ7NeC9DeufwCdZ+EhV9YQB?=
 =?us-ascii?Q?JXV/PHxUHSVcnIlDWHnEV3CLcoHKqyebOQ4oZXZzSF+to2WdNVxesY5XLwNL?=
 =?us-ascii?Q?+Vr71yvcltqbRVKAXMExJs1DMhpFYWvlBj0IvTuOrRQxyDO2PGpJ8L7iXQpk?=
 =?us-ascii?Q?SL6VGuAB0/ClAnFGvzB80tozELhFo20HsXrJjic9UfmBqrGME76exibuH+kd?=
 =?us-ascii?Q?KCCxLI3kssZOYyGSfv/mfsiib89khrjVFsqfKWTUTZLa7/b/Bid4ZA+qbnyx?=
 =?us-ascii?Q?9tInbw6N8JFMvO/WMtaJcKVnMxtG1ZUlef6D27kTk7hXy7EORrlIgChsSIs3?=
 =?us-ascii?Q?8rDHKI4ozHocdKis9GrbL+EGhm9vo3tGe+rlFXEp6Y6V6YKy7zH4RVZQ9++c?=
 =?us-ascii?Q?dY+1WWhjo1fzaq2PoUqlvRXl44uY9/qyPEwE3UiIb4Rzh1Q45DDyupJWmXAb?=
 =?us-ascii?Q?v8f8GRTPWvj1Nsm+LqVmRzIeXfj7/tgvpgsXxBd9k8PA0JaS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94953ace-d8c3-4525-c835-08da5381dada
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 12:30:41.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUOsRIyHkltZx87nFIlR0eP3ixBzJiuXP4FHUJt99qWKflA2oOvZCgQcOoanm9f+R7IIw/2WBYouuq0joFn4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2466
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will send a patch right away. Need to include #include <linux/devm-helper=
s.h>

-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>=20
Sent: Sunday, June 19, 2022 8:45 PM
To: Sebastian Reichel <sre@kernel.org>
Cc: Asmaa Mnebhi <asmaa@nvidia.com>; Linux Kernel Mailing List <linux-kerne=
l@vger.kernel.org>; Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the battery tree

Hi all,

After merging the battery tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/power/reset/pwr-mlxbf.c: In function 'pwr_mlxbf_probe':
drivers/power/reset/pwr-mlxbf.c:67:15: error: implicit declaration of funct=
ion 'devm_work_autocancel' [-Werror=3Dimplicit-function-declaration]
   67 |         err =3D devm_work_autocancel(dev, &priv->send_work, pwr_mlx=
bf_send_work);
      |               ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  a4c0094fcf76 ("power: reset: pwr-mlxbf: add BlueField SoC power control d=
river")

I have used the battery tree from next-20220617 for today.

--=20
Cheers,
Stephen Rothwell
