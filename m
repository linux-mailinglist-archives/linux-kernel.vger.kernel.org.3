Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE34D5816A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiGZPmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiGZPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:42:50 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B434A2C677;
        Tue, 26 Jul 2022 08:42:49 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QBr6HI008689;
        Tue, 26 Jul 2022 08:42:42 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3hj68j2s9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 08:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWNurMR02zX7W0leRp6WGGtygg+DfO2uGkQ2pJSbt8/n+ymUbZVy+OrXC0++cz5thW0O7mhx9+46ivtwnmgS8pDSVZkry/gk4H7OvMMWYJ6wsy8docvILzK9E+TDouotiUV6znTJpo8+DfvwDpW9ocVXRfGAK9v1+ZI2L+EY+r+67RKy4CVsJrcmSM/l3szjryZ5ZBKlvkXAHw3ghEMr/mIsHcPSxEs8OPflWp5RURftfiG6apv+uV2O5DvnPfwemfUbPD0yfCTl5KNULv9aCDM25Sr8jfswYAP1ubPlU3O5tW3SLpb+UQWLMCawJA46ND42FtQOSi4BQaZXu4H9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD4A00tJE3UXUNDEQ6sMwfLFv13sc5PZ/YoFKL8bYz4=;
 b=g1gLu66JHqoHZOPHcIeJJNvB8uFhSlVmRapElAwDMXQ2DPYRIlm71IjaTSBd6o54w5R/zh83HlLDwTjs3IVYSh9AAxObRyQqykqGyvvSXBOjx83DUlW9PgKjMUvbEGVmEupz01l+jq3hSNhLNCNbAh59HZCdL+R85OK0tBOkUv0eBtynvvgAFTtruRbhE1pAzAEgmDvZwdGFrOAWplpWBnhUj/+uYLLZp/m65jKQMQdL0HqEOjQM48pebhBewT1GCUaf6ji+Bx7loBLzZiC8zKJxP7loyMdPey6rf2FGQ79Z3RHYUoUkmzt9jLoheszGb58IRtVGtXy8Gh84/HmWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD4A00tJE3UXUNDEQ6sMwfLFv13sc5PZ/YoFKL8bYz4=;
 b=Wz77O8vK8AysR2Ubo67gKq0pTsHIiJA3kYtRKIUg4qODaOoWF25odwY8YcqumIVpFbjfsfE7xwMo/2/Nk1omMYCuS74WZyS5muaQhrpzK2r/X7231hPPhaoTwHo2uApFYdFRq9jzf99DvrbEWAOIAHc3p0lduqg1IM+OKXw1R7c=
Received: from DM4PR18MB4207.namprd18.prod.outlook.com (2603:10b6:5:392::6) by
 BYAPR18MB2711.namprd18.prod.outlook.com (2603:10b6:a03:10a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 15:42:38 +0000
Received: from DM4PR18MB4207.namprd18.prod.outlook.com
 ([fe80::94e7:106f:bc01:fe3c]) by DM4PR18MB4207.namprd18.prod.outlook.com
 ([fe80::94e7:106f:bc01:fe3c%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:42:38 +0000
From:   Noam Liron <lnoam@marvell.com>
To:     Mark Brown <broonie@kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Elad Nachman <enachman@marvell.com>
Subject: RE: [EXT] Re: [PATCH v2] spi: a3700: support BE for AC5 SPI driver
Thread-Topic: [EXT] Re: [PATCH v2] spi: a3700: support BE for AC5 SPI driver
Thread-Index: AQHYoQTri82MQeXBHU+w/7+vBQ2Hma2QybZg
Date:   Tue, 26 Jul 2022 15:42:37 +0000
Message-ID: <DM4PR18MB4207A37902574C43F6F1E45FB9949@DM4PR18MB4207.namprd18.prod.outlook.com>
References: <20220726130038.20995-1-vadym.kochan@plvision.eu>
 <YuAI/kUrL6OQG6Ff@sirena.org.uk>
In-Reply-To: <YuAI/kUrL6OQG6Ff@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbG5vYW1cYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy05MDA5YmM1ZC0wY2Y5LTExZWQtOWMzOC00NGU1MTc5?=
 =?us-ascii?Q?ODFmMDFcYW1lLXRlc3RcOTAwOWJjNWYtMGNmOS0xMWVkLTljMzgtNDRlNTE3?=
 =?us-ascii?Q?OTgxZjAxYm9keS50eHQiIHN6PSI5NDAiIHQ9IjEzMzAzMzIzNzU0MDAxMDAy?=
 =?us-ascii?Q?NSIgaD0iQlZpNVJpV284OUhvenBqaWhhbGJKU2lYckh3PSIgaWQ9IiIgYmw9?=
 =?us-ascii?Q?IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQ1FFQUFBcGVP?=
 =?us-ascii?Q?UlNCcUhZQWRzWmZuUkxUNVZnMnhsK2RFdFBsV0FHQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUhBQUFBQzBBd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QVFBQkFBQUFwZHFja2dBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpBQnlB?=
 =?us-ascii?Q?R1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FCbEFI?=
 =?us-ascii?Q?SUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBUUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0IxQUcw?=
 =?us-ascii?Q?QVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dC?=
 =?us-ascii?Q?MEFHOEFiUUJmQUhNQWN3QnVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUN3QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVBSFVBY3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e30b655a-4cdf-494c-c588-08da6f1d77d6
x-ms-traffictypediagnostic: BYAPR18MB2711:EE_
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2oyvoY4K4L4le/pP12R8uxMNdNsbfB7hl/Gh/CVQnU6AiNXRapk/erIxqJI0jycxHr8TsuiWd3zYdqORknNuF4TWiA4n+FB/508w9HEHrzhLGpDWAFrpjglRKrMFIgZtheSeSkYB1m65gytesjeusxyJ89iPKF/9ounqOpaN+kC/Gyw4arpSuvudTY66/Ay5Lr6O368BZ3F3Kgy2pbYv58BlWGLDoLSB2RNbU+yQJpFbQXvdrrqgexYoY5Ff42UgDT748Z//JFQLpEyhV9BGFk0dL6x/UgfCC8dpBktHsK/xVLj1kn5c4KsEbCPjcCpJ9F9Nk6/kfXTuT0BZfQMoDS7uK5yrfRI3Gt7cfGXlUQiN6BUKitBEBn9vpNa4qf8fmqCJ0LYaLEs2kjO6R57957mbrZ4B1bgJFFdnvcCos24i5VN6dfr2aGQt8VPgMyNQRmXdxGvEEcTh224RERqnjjWK/nrkHowDYmsRCpPOY6FT7XOWXWXsY3tKri03s9zx4EyAm8GQZR7080gNB4B8EmZd410lzQE/xizqJ2wELumu5Rl/taKQ0asXmGa8ZMC4ijFGv1kNSTdQjWmkX9TzVIorMzv/thj34BbLnyPD/+dyfjkjZLYfeReoiwQovEwGU50UKxdtZLz1urIIfkI3KYcq+paLZ5WxOiH5tPrTVZDF9BLEQmI4Tt3dzVUIdCCB149akuSK++CNq8N6clHQv5UYU912ZqUnNXtn9EO/0aKhX/Cg5kvTZ2ZuXjrHotih3gksxAlf5S1rFkwKSDIsGwjhyleUbAYaqmjzffOMyiHHffXj/3YVKcAMibxSBol
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4207.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(107886003)(186003)(83380400001)(54906003)(110136005)(53546011)(7696005)(6506007)(9686003)(41300700001)(2906002)(26005)(4744005)(86362001)(64756008)(38070700005)(33656002)(55016003)(122000001)(5660300002)(316002)(478600001)(52536014)(71200400001)(38100700002)(8676002)(66446008)(76116006)(66946007)(66556008)(66476007)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u5VsmjnH2dT4XmL+m+vkE+aGo00Dn/oAf/u7zP8GSPAdi860mSneD4aoZ5N8?=
 =?us-ascii?Q?sozaGq11k8/gac9H4YXQVLCUltBebk5RlnUG+Lbnzgt6bzsDSkc4DHKNo3Ic?=
 =?us-ascii?Q?f2eFh1l1+ZW3DnmsyiG26nDtGM7CLkvneaT0u3OumNYEzYayXsetHpdI56pb?=
 =?us-ascii?Q?nh6fzCZFWEZ4MsFFc8G5CKUHquIQtY5fYtr4ZFMFucn9HGM9650Ti8BxcE8N?=
 =?us-ascii?Q?och6ukiRLINYXEGfAVx9T3gTVAkGTxVtOWC6CKsU8soa+xhTH2xryDjXAqsH?=
 =?us-ascii?Q?KoIxGeRkgjRj0QMSxb0VKvSPya5qvh+YUEf02zA5bpgOCRbccfyn78PjuUo1?=
 =?us-ascii?Q?ns9PvNACoyJo+Hw2a8ADJnd7eBWVaA4Oy3AGZa5l4r8dFRZcuWzXoLhDsNEX?=
 =?us-ascii?Q?0PVIzXxDk+i7OZmExz2mOlqOHS4OS/DiN1rTDFz2gBEIMa9QV6gSVG3MUj53?=
 =?us-ascii?Q?+cJjmYXRf4B5uTQglkx+ESQL6tO1Np8ffgz0JmmhYJA2GS3elaPBexQCZaPM?=
 =?us-ascii?Q?Jc/8X77o2iZ2qW5+XP8DeukH5JvDvZmsnrhgIoYut6P7xCVGgJ1S0h1An/kz?=
 =?us-ascii?Q?eUqq08GFGklsqTt2/D5Q9DD93t9DeFs4DjfaonUeC9zTkJk5/0GSODwrFnli?=
 =?us-ascii?Q?6w1HOfmRlTbWl6f8SEwN6DR6oZFEmvMrxTwWcAfOLfKeCjIi1q36f1B6/HPZ?=
 =?us-ascii?Q?9M42p7F74EL44Rh0RQIgSmDrHcZcpu8V6RmIV3cU3rA1jwjgkiLdJwsXwvsW?=
 =?us-ascii?Q?U5sTZnjD1H8PwCZZEnxmTuP08z7BbL/VWfOXP8cmYzDto7IA3KJ8upyxH2ZQ?=
 =?us-ascii?Q?piVNLYkA91ed+KOZWd/+9v6k0bNfrGB3t8O0z7K0CUdKzXe/RuWfNtXcnxvq?=
 =?us-ascii?Q?yffykBxgHkpm0loU2MCYH9vGkPidDDrjy0yxeGJns5GC6ojdDPmEPRVszIcm?=
 =?us-ascii?Q?GP8oBWwqmx59MA/BKmNdyQch4gwVnKIDzl/uyUwZ4Ny7b2xU4d7Xc1GiYWmQ?=
 =?us-ascii?Q?3x/4BmvMUtRoCZyCodTTvrzN1mLuK/XkwfXkFAKfvxbfjM6sRytMSKWCC1lu?=
 =?us-ascii?Q?dN39lcEtbZzTjbpT8LqIkYH95crJ6ditw1fjG+7ZFWL6m7ELslGZNbuFoBL3?=
 =?us-ascii?Q?B/fTFeBCIViDsGh8pgA7iUCnKO52Ga7qjVLabh4rdM3210aD00DHW5DBTuV7?=
 =?us-ascii?Q?/6ajgCCu9NysdqPBxAT/nkjFHwDWUSZ6Ojdd23CIlAoB9Yo72+Z/UY58nGyb?=
 =?us-ascii?Q?wdXHc+AHc4loEzz0ZkjtWpmU34LVYhE0ZGK+F+bP5sAAlJP7TSe2mEj+czKR?=
 =?us-ascii?Q?OxblwZkgtY5gFdOZXamDeJ+iyRV7qboMhcSC0vmMlNn0UDsUkWJE9eax8OGv?=
 =?us-ascii?Q?UrIr56AdaLwwn0qYKVIpmCPPctbJxHm/meRwll5M/X3yN4Z1rHx7tohO6BQg?=
 =?us-ascii?Q?PMwFbnvPtFoqO6mwep060KcLslaWuLIyp52qdAmy3L5d0kpXnoGkXCXzKyGy?=
 =?us-ascii?Q?bTGtLVBxAbBtRz/WsBN5jyFS13lnrK3/mvrLXPcUgRlgIloYp9sDioDSm3ZZ?=
 =?us-ascii?Q?TK1GIksjwIEVQJy79svoZtzIK3BjMGSCn5xh/5XG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4207.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30b655a-4cdf-494c-c588-08da6f1d77d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 15:42:38.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NodJSro/lktd63pOjs3S7ZZb3hE4fjQbOp3wvsiJQ4wTbMcDCk0f4jv4xcd8RqUekbc9eYDmJCSQRny/xfrfhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2711
X-Proofpoint-ORIG-GUID: r7srlR4gvG3tWPZFL9sM_bV-1x8lrhdm
X-Proofpoint-GUID: r7srlR4gvG3tWPZFL9sM_bV-1x8lrhdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Yes, patch looks ok

-----Original Message-----
From: Mark Brown <broonie@kernel.org>=20
Sent: Tuesday, July 26, 2022 6:32 PM
To: Vadym Kochan <vadym.kochan@plvision.eu>
Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; Elad Nachman <=
enachman@marvell.com>; Noam Liron <lnoam@marvell.com>
Subject: [EXT] Re: [PATCH v2] spi: a3700: support BE for AC5 SPI driver

External Email

----------------------------------------------------------------------
On Tue, Jul 26, 2022 at 04:00:37PM +0300, Vadym Kochan wrote:
> From: Noam <lnoam@marvell.com>
>=20
> Signed-off-by: Noam <lnoam@marvell.com>
> Tested-by: Raz Adashi <raza@marvell.com>
> Reviewed-by: Raz Adashi <raza@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v2:
>    #1 added missing SOB for Noam

Noam, is this OK?
