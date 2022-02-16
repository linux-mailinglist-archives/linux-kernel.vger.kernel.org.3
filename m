Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9B4B8191
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiBPHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:31:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiBPHbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:31:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD3110F20E;
        Tue, 15 Feb 2022 23:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIrZ/6V3i1uJILOsRivasQnFQqc72KDA3kEEKryq4XgZgfUL9Q3jNC55v23+e04mR3JbwrDCh5ThclRacFwcOviTs9xJAS1wUwMUhp7XypguDdwjc0wBYyRL866MbU9pjXwGlmWzlMkIiHcZE5aIE5I6vU3rQScWQG8ReW0WkhkH7X7M/KonXelSL9EOVsDHeTGlQA6czSTM0E8Y/Dozi6wLv+X6aWV8LxA+qx7W36JPKFq2RS0JWZpOWTkmTwTnbVojHxwZAkZw89vg77yGpgb1j/eXKPVp6ZgnZZoZnstw6S1iAYnFiCZODEUMA7ZJGp9v2usW4ubH2uLhlpz2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A/2027vx5pLt5iDeaumLs7ox9N+sFPxVkL3tj+H44s=;
 b=obaletMcPn5Ra7s5vJr4/51iEcRInwVS02+/WXt8h5cAwSb9JDlwkFPqATWf0BBdD9fifRKPwZGdo51v4z9hWejZSr33/Sp08PtN5un/53q6qzIzMDv65TG5fQRPG/rCUM74/BUVN+BHMKM4fvaJP66a420PRTggAc/TKIbdBtMo7RefpzBJbodt+LbKXTCxprM1v+meDBX3cOeuz+soYn9/OMQ7j2bm56TylugthN5uDCx9DlV53te5VKk9Dc8sIQhZV3dfVr4uf9ysepa7DLVCwOzB3rvxEx6Pf6qCEjEhiEQRep0Qenw+VAAxj1d3TsY+9SKwjgRh4q4elXW1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A/2027vx5pLt5iDeaumLs7ox9N+sFPxVkL3tj+H44s=;
 b=j+3U+Z8znMRbEUUjLmZ6RRDh/2GokRIA+YPT2+gRMANj/uhbrxlTkQHIPj0f9mC0WP1XIGULPMTeyuukiu3FWmxvQj+dkX2KHu+p9tZ2BHtaOlG/RQ0WBQyZCi9sHTZFpqo+RoDdFrtsMLhCmrN+KB6eFB/slWCdkYkHt+oebdObwknSUneRHfmfVSSCDVYOMBAHMz7OlxuCT44VpxZrbcvD9RIkt1fSB/ES0m0PqQK/5ENTOSPrseoYSQMCio0TrNnnbpDHbmv2RN9LSA0PIwK+Ajy3+o9Bj/+/pJLdDVjxVK4Jo6riee1aw+Q6c0VlxSzA9gP9ttCMIfzMswRE1A==
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by BN6PR12MB1364.namprd12.prod.outlook.com (2603:10b6:404:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 07:31:01 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::83b:60bf:1e58:de83]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::83b:60bf:1e58:de83%7]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 07:31:01 +0000
From:   Mohan Kumar D <mkumard@nvidia.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/6] Add Tegra234 HDA support
Thread-Topic: [PATCH v2 0/6] Add Tegra234 HDA support
Thread-Index: AQHYHkqfIXhpDBHnV0GiVPOVgWWYmqyUo6YAgAABJoCAASyu4A==
Date:   Wed, 16 Feb 2022 07:31:01 +0000
Message-ID: <DM6PR12MB4435BDDAA9DF1820C5D92637C1359@DM6PR12MB4435.namprd12.prod.outlook.com>
References: <20220210065057.13555-1-mkumard@nvidia.com>
        <s5hmtiscl65.wl-tiwai@suse.de> <s5hk0dwckza.wl-tiwai@suse.de>
In-Reply-To: <s5hk0dwckza.wl-tiwai@suse.de>
Accept-Language: en-US, ta-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31c4690e-aed0-4660-915f-08d9f11e4846
x-ms-traffictypediagnostic: BN6PR12MB1364:EE_
x-microsoft-antispam-prvs: <BN6PR12MB136459F58FDA499983C726A0C1359@BN6PR12MB1364.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0cOalGH5KKH0Vi2H9hsUtl7/PdCv9J9UxcjdvxCPDD8djrfyRHf6/Vi6t4gCKVAxQs30g7TAGy5xDSNGvzdOpphyI61Q3b/HWt6ibAgMrL2H/LoY8tQ0CWZY++jUaZR1kTtSaOF0TSnTvQupKNQ1H0Ydr4oSav3aXW/Ue0Q4iV1JKWSXfW3uEomn9ND/QRbnSxHr0/brsfxkv/v8K3ijp3DUr1ON50bd/OFPlEs90raVNH3/7EkscPmHc/OLsKolc7aK+3vdugNroY/2LYrdX7I3eCSzxHdFAQhtdV4jUiFFfKzTQ8vPRHFgZVdcp5wfAKli2EIkpSN1e1n6gbjuz9Bjq4m8bpZAXD7+H7nAQOWe0RLK2XFtNhkAvnIz+b+daAR7QmJwXplCE2SR4Bpm2fG+9OLQgEcxMXsUMfJvIMUB5/hawTJQdCvO1h+FXaZ8DUJIWeW7EqqHX1wND57rmm8KtJTM3CjQx6eSaXlSQs3EiVQMaV6JOuyToSXM8syUam4RYS6yTg2quDJ2RBFo7OrL7LJsRxNmLV4YWp3GcvGfeJZF6BmhZCVWfFCIv4bRiwgxk2oWBk+6QLVPJZSJ/YRsJ/Md+HDaXzbFxmbEQt5j8Y8PRdWBJXgYCp1VugTGlcOxgTMA0HMRW0FcztoPX/MA2tMbAtnOH3wx1tCtQ4LzPOcmqp4fcKvnNTe6a/ueUAanmyOckkzawQfNb0ohVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(122000001)(6506007)(55016003)(7696005)(9686003)(38070700005)(33656002)(71200400001)(508600001)(38100700002)(26005)(186003)(83380400001)(86362001)(4326008)(2906002)(8676002)(316002)(76116006)(8936002)(66946007)(66556008)(66446008)(64756008)(66476007)(6916009)(54906003)(7416002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JNzmvtn+yW2gzs3Erg6FSHuvDCYiRDnz75qUMVoyUmBzHad2PcVwODr4CVCB?=
 =?us-ascii?Q?lAx6kMeZowsfWp3R5hqpwLAKtLnxVv0EvrQrqDUp3mxKpGX/6SbRWJG7kWhd?=
 =?us-ascii?Q?8OFU/2WAcIGL7QkCChHNGChNM1nF2l1w2IJhQ8+MocKS/JQpDKmzpDl03RnU?=
 =?us-ascii?Q?WBxrD43B8XKTbx2Ea9VjivWdDjD+d7NUqInjfagKwcyKAIJ3RPJ/19w0ELkx?=
 =?us-ascii?Q?IM0+I3uq6myhn+Hrh8RwTbkD80HWYQHy/14Se9aA+et3fRxsW92MNIvQR82k?=
 =?us-ascii?Q?BrrKUx2SOyggC/LUhRLtlwYfkp3B0+CYdh5I2Nn4yEV+NXBENyIvrwlA7hW3?=
 =?us-ascii?Q?/qaDVaG2qJTKdsgFkCP+H3tm7rRi7UOQknvW84cIyEsnC8jwPXR4L//ClREg?=
 =?us-ascii?Q?NbCoy8L4uhKJBxKDELJuwZv+e5hie7CkqVoGDescSlG2Y5qGWFU6oXJnPh57?=
 =?us-ascii?Q?TxoHYBq0UrdCepVfHxTLMLDT+QVEl31Z3RqalR5iuSilen9pdR+ULMZGgpt4?=
 =?us-ascii?Q?mgYvm63inpqSndVIt8z3j+PjcFpfS+LmjrjomSzQ4mmYY64diJdL+ywNHfWn?=
 =?us-ascii?Q?DPvrkJWbBF/476u8rnnDjWKA7x38XM0L6hm9J6kfD+wsOYc7djYFWyqyfBMT?=
 =?us-ascii?Q?7CvD37zglWqeIaYnjfTGra2T3jq3B/ssweRis8uM766bjZeOprmQGxPuEahN?=
 =?us-ascii?Q?5v/XK+0dWzk0+rBdPBNIQUS9jvZl3dT0fRXqOnx1e4hOAP/YcSFU8YoWoF3+?=
 =?us-ascii?Q?xp+KyHB+FvIkkC7J40uL9zT18LUXY+ifqxKyPtOv/SAovJ1yMod2VHBRnR4E?=
 =?us-ascii?Q?2CaxjXEjdlSPsDVjXJnaZG7ku6asmEyTgKeZysgc2KFYhvYA4gFrRNo9665c?=
 =?us-ascii?Q?GtFuf6husJK1b5FmUalOtmj04/xFf3M8RTntZZtdd53Ul3DGoaMB05VTXjyc?=
 =?us-ascii?Q?j0wbNro8wopazDGkSDHCfZ1LSesq+y+C4wafCsW4C7RAXZpJg5QrNvvFmyAJ?=
 =?us-ascii?Q?toenZrpFdOl5dTuz08ZA1SEwn8nIss7t6cY3/sjIgCvfwId/KvTMo9wgLNVz?=
 =?us-ascii?Q?uqL2ajOwk8lk8pGivSMfBa+XFY0jp1XSbSK1UZT4d1iE364yeckUJ5ew8kQN?=
 =?us-ascii?Q?caRYENZvBu/Cj6CDdoWZRUw0ohhi5/PGwhN+giabG+DvhhQTloYReNCd2d/N?=
 =?us-ascii?Q?wSuG5Jlt5E5qAbGBESrihkgAjE7vpE50WzUalwKtAbL/RJqBkbZabIHWiaJ3?=
 =?us-ascii?Q?K1DzqKsb5y1sdWLMwJYCJ8YmMfhbU9cyV9/HhXYBniKpTfyhdmG9qoIHd8JN?=
 =?us-ascii?Q?NQRH4Hr3s3r69TPc0KZaOodWGxcKMELhdKZmTptMrrwsxZh2DuznrYqYZRKd?=
 =?us-ascii?Q?AIrqsbF7Bzid+qGR61nJNVudUXpHdik3FxZy3FJbWn23c9cwTOscdQckMLlm?=
 =?us-ascii?Q?xVDIh9aNGczpREicKPtvy/tCCcFpNycH7pg567hNMIfirj0iq9FsenMSxaTN?=
 =?us-ascii?Q?ojn1fNwCt+d9ib8LCTO0F4Jj57L9+G5Y2SHab6a7TFbP4pSVSqWwRGOrdhfo?=
 =?us-ascii?Q?1XLT/1Swrhl8NtDfpOVTp/AD98YccQBFtT0MXOcwGOn9LZy0UEUooSv4E/4j?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c4690e-aed0-4660-915f-08d9f11e4846
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 07:31:01.3064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MBoQirGuzHj+xmJXZ+EHz/BmVgMtlswERERYrSFUVXlmJD9lLpTDmwWpo8GpGgFr2XbcnUkTmstRoS8GtjdRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1364
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, Let me resync linux-next to clear the conflict and will resend patches =
with v3.

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Tuesday, February 15, 2022 7:04 PM
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: broonie@kernel.org; lgirdwood@gmail.com; robh+dt@kernel.org; thierry.re=
ding@gmail.com; tiwai@suse.com; Jonathan Hunter <jonathanh@nvidia.com>; Sam=
eer Pujar <spujar@nvidia.com>; alsa-devel@alsa-project.org; devicetree@vger=
.kernel.org; linux-tegra@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add Tegra234 HDA support

External email: Use caution opening links or attachments


On Tue, 15 Feb 2022 14:29:54 +0100,
Takashi Iwai wrote:
>
> On Thu, 10 Feb 2022 07:50:51 +0100,
> Mohan Kumar wrote:
> >
> > This series add the support for TEGRA234 HDA driver support
> >
> > Mohan Kumar (6):
> >   ALSA: hda/tegra: Add Tegra234 hda driver support
> >   ALSA: hda/tegra: Hardcode GCAP ISS value on T234
> >   ALSA: hda/tegra: Update scratch reg. communication
> >   dt-bindings: Add HDA support for Tegra234
> >   dt-bindings: Document Tegra234 HDA support
> >   arm64: tegra: Add hda dts node for Tegra234
>
> Applied all six patches to for-next branch now.

... and now I realized that it's conflicting with the latest Tegra234 reset=
 stuff on linux-next.

Maybe better to split the patches to be merged through several trees?


Takashi
