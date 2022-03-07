Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686554D07E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbiCGTsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245150AbiCGTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:48:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580395C861;
        Mon,  7 Mar 2022 11:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCFZIElg0qaJLSxnDwBC8SRIBtcz9fVczwe7OgCs0Rb+2tlnrM1qZTwQzlKToxXerWIXcK2jbQCdKP0oav/oF8Bmw/5Y4Ewbt3/3JB3OPB5F/em8/E9sIvm1IM0PM33VK0i6KRXFuB4j3RGcA/jXTIbszuyk69hKQGSrefEIEFHAY6oIYV4Uw0ruQhw1Td12o7D8PdKYOewnb0h06TkH61wNA8nPFsWtyAgelTTU4WYfnJKRJJBTfmSBu0gh+vqZBXPsjvYKIvrO6e6FQWsUu0/0V+zAVLlG0UxfdAcL4LP6f6Sxmpfr6PastGfKl5CBUZfApYSZkSQFl24HSfHpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FB2b5SZTSBdFxSxEuPqbjPYALbYjyT2I+WSfJqZCM9M=;
 b=iaEBvRJ6zc9R933gLCpAdhWuB20aboOaxft9/68d1PLnd3wpeHkBw5GXfA8+2aJk+S/b+vuPRo1KMQPLE4G/oeEpKM6Tw+vEz6JQYJ+MHonn8mhx1tAwYWmUgApYgrnlCB3KpGKlRN5LqMofAxYrUeR7ZTbU4N1DP5TgDZ86EcoP1GuFHM7oE0Wzs6e6PKRBdCyI/Csx1e0s07rxUiKPmJaERFRBPxbvFlAMLo0tJfrMyXUHSSPNRtlSeuFfEcVLkteQOvxpZGZ0y9tpazEsJaYiv/80w5y+hRZYcz1ybLAgwLx8i+0ylYunuwrdsTAOelnu45Pcki8comKJpG4sVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB2b5SZTSBdFxSxEuPqbjPYALbYjyT2I+WSfJqZCM9M=;
 b=KvUeZ+tJ8hO2BLSgKXzhKa9++C9tuwE7tDDKp62MR6fLhw13lXt9a210iFFj1x28iaVnPLzcgzbqNk+il5E8E/gLWNtjNGk9j5NcSlGaCfGHav5NulB42YtPN1k+JEOe3637tlqTkgDvxmT34OMXR8MMfnixn4j+RJGbFBs5zefeiUdwlu0uWpHcgqmq03K9RPJpAFMcbmirB0SSsveQpptW5WCfX2nqEZlSBReCHbMhD7UUNn+S5vShYbl1yUDwxQzsnnIaNrgLrQFrXBdCDpuWaxuFqPLAKdMismqpFcTHJMcflyKL8GsIFr6fZ3/8b/EmJaj7Ccsx62oiwLhN1Q==
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by CY4PR12MB1622.namprd12.prod.outlook.com (2603:10b6:910:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 19:47:08 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::a57a:37e0:825a:d894]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::a57a:37e0:825a:d894%8]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 19:47:08 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Sachin Nikam <Snikam@nvidia.com>
Subject: RE: [Patch v4 4/4] memory: tegra: Add MC error logging on tegra186
 onward
Thread-Topic: [Patch v4 4/4] memory: tegra: Add MC error logging on tegra186
 onward
Thread-Index: AQHYLhHEvTV8LxjL40qENT0hHpzEZ6ytmQoAgAAI34CABrYm8A==
Date:   Mon, 7 Mar 2022 19:47:08 +0000
Message-ID: <SA0PR12MB4349E55BD1968FDC1962DC7ECA089@SA0PR12MB4349.namprd12.prod.outlook.com>
References: <202203031247.0bBX70B3-lkp@intel.com>
 <a1f26936-6522-a3a5-f812-a80a63003453@canonical.com>
In-Reply-To: <a1f26936-6522-a3a5-f812-a80a63003453@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea12a42e-0b54-4f3e-b356-08da007343c2
x-ms-traffictypediagnostic: CY4PR12MB1622:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1622F3FF8EE0C928F3278165CA089@CY4PR12MB1622.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mnMn9iI8VYjgH0CSzfP94jPnvdcWk0+04cQGBAxUJGikDz1rXh7vgtbpCPbW6j1PDeQahWbSz0XS3wCGG03fDEMRIxi0Kn5G3eIj2X/XzyMS+sQXzqZV/tpxXrTKrUzgtqhvDxhygvl4/tTgRQ/e2VfnY3Z/KVzGz9Mkewz1tF8/XHUWTNzD7rMV+xqOwfcWaz+hVRbMZ8+LSFJLYKDxK29kukOSE3ztB5KJVu2pJwbOYPqbVHAdHE70njh7VuNJ7mMSYyLjomRCRLjxPxVOm+ctgLGLG6zTxu4A2XQjQejopsGNyQbIKl8MkLWCYxIGhZYKX19N9ZpG5lRre7EYhmMwwXgSlMR6xnsS8k7Vi+acJh3ADSGXNvYUPnVTk7hiCsVHs6rYwxBVfvzDJJCKS5RFigMvR7rKvhyjaM0BcY7vO0Fa4kHAgz0VHtcismTiBE6TgKSvZuYEeB5kfY1amt76ptDBExyPXvjDjse5gedF1G9R1gdDa06j5+IcSnGKZH/91xX00rH0CKOESDLMIBijeTNh6fTGqnB+7laSQuTK3VW19Kt/nBp2twvrnTtVbxJdd/KF+8igLnTbZGfIoLb0VzErYmkpS1BUWVKtaBS2M9xAZoZ60rrluhKQgWvqnU/WCvTZrhHqkZO1FRnBPcp4cJEP+X43//VJCLeWnRJxBvxcROFQHYFnpkIYAzQGsgzX2EXTO9l9Q1sPSoUGEKKpr4LfdEwhV5jFwDQj2Vh5I/464o2KxO6YQedMmiHhQ1yC6khhW6v+l1dDV9qtowqzNVx8MJVgeRqkF5gyJkwS1U15noR/UaWE/EYpwDc+93NY1HxaNpfVdZVZjTReeRfgTVC/XmWVlR4iuz3/sGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(26005)(186003)(38100700002)(8676002)(4326008)(921005)(76116006)(64756008)(107886003)(66446008)(66946007)(66556008)(66476007)(110136005)(8936002)(38070700005)(52536014)(316002)(54906003)(9686003)(86362001)(53546011)(55236004)(55016003)(2906002)(5660300002)(508600001)(45080400002)(83380400001)(966005)(71200400001)(33656002)(7696005)(6506007)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fTxNkOfBz/9eyWrd85li5XW15wvaaY4pII/QMmVks0ilU1/ygaYJJRKYejpg?=
 =?us-ascii?Q?sz6btUHPHHrh5OXxZydScRAr+2evI9l9ElbPUk//pcLMRf74wejAzu4bFTe3?=
 =?us-ascii?Q?x6R7bGbsQPeNCrkZxmW43E+2wkIS1Wp6rjpf1xuEDEhjq/brzqSMuC/2+fGj?=
 =?us-ascii?Q?fM9qY+SKIbOZx3X+KKV51MqHxzult5blG6gEG4s3PWm//gn8jF0tmUvW3YGP?=
 =?us-ascii?Q?mMewz7f4lspC/jBx71o1JdX8VZ56VlvZTtyLj7/zcwJuFL3vLPTVKkl/sF9Q?=
 =?us-ascii?Q?ay4ZUC0TIh8ZyfLwe7QOH1g3Na5gzGeZIv4SdoRD+QY0hkEetratJ4o+Mqd+?=
 =?us-ascii?Q?Bx7m9Rd9TmGmrsx2ZFWTL4i06vkXRDIEPG1phuSakyR/r9rJbssRxFQ8dWxq?=
 =?us-ascii?Q?b2/Yf1W0UvvyPS/7CRXHtVI+SFOl69Jw/nZv//drYZLkkcqqaCHinmb2MI2A?=
 =?us-ascii?Q?P3qkTL7MCEOpJIrlDXVIMBh7zMAEB0hyf3KY52AGfxIg/JEFTjKvegEs4ADu?=
 =?us-ascii?Q?I38brz+OUBYl0xIaRAVZWUf59GykgH8vQ1M/GRVogvvLqfok0Uxg5QP9ML/A?=
 =?us-ascii?Q?tZJnDOyjXAKVVP2fJ3WRx9HFk5RO1YpiVD8bSRpWyorNfLXBaSk7Z0mnqlOf?=
 =?us-ascii?Q?9TEtBr0LzMfNW3cGptiikb/BQ63+a5PspCkWT1Nh7G+51j87kzrJwk4vIpAG?=
 =?us-ascii?Q?kh7VQdQ7X8W9lMh1NoVxfkZTDDRuY/qM2qJtJ2O5xRmZDH0ONtudEUaXU3PW?=
 =?us-ascii?Q?CQhTPluzWcLp4JRoGhDt+QAgVo3Bb6D5gWuPwnj2tstXv4wjylZmfkwYiPCs?=
 =?us-ascii?Q?7elSj0e4UVQ8bErjqOUQFZz7xZGV6BxFqHC7z0/irRLP9dCz7B7RDRrzgJdx?=
 =?us-ascii?Q?KQu3fzvlqzVAiN7IIuLF511i7/kkwU81Kc4F8+LI+Pf1sa80jri3fMKlyMEi?=
 =?us-ascii?Q?xmZyQLkRka1dBhVuTqgtspaHjgwHOZL0G4S4g7wgVOpfsK2Vh4abtq48xU65?=
 =?us-ascii?Q?1JbvlB6f141dNFqFXTBJ9yO9C5FiFayz12hq64HBGgx3mtBkec2U/ZuG1WaD?=
 =?us-ascii?Q?d5f1glot+Ml3PJ3hEUgngfsSIYFw4tOkjZ0DrCV2kA0dlleU2O697JBFTv6M?=
 =?us-ascii?Q?s4IJxaKj4aB16b2guiL5Su8j3eonILJirPrZN2oFir0GYHSDB3nwYgysFlVT?=
 =?us-ascii?Q?p65i+/l/1TAFEt6lwDt3KM6vtkbrWskrDqYxYx9rQHrZ0K2b750DvZZ7wdOc?=
 =?us-ascii?Q?6MxdutLUtH0ce7BaKCTm6QNRP9CKXKmBpZhXaJCXcdVycBvw05UP+Ic1Pt4x?=
 =?us-ascii?Q?RCqjHKPxtUzBg//Mjhu3C46M1b1+YC1YKcMvAI2d48a27UKpG3AqvSwxGzRd?=
 =?us-ascii?Q?9EIU96Gd90Bg7f24STLJpdpJ7W93HTXvUB2YIBVEpFamIkjGZqJKOUufPjmZ?=
 =?us-ascii?Q?bumgHeh2n40x1/eXeDCnWpFc1O9dntKFfWfSb5O8GzGN8rtqlJe4MOlHsN9q?=
 =?us-ascii?Q?KB669rbAAkNTXuav8m5xcJ211TrpSWPbobkJh+18zvAhfzD9YP7XoXRGyElK?=
 =?us-ascii?Q?Sf6WOfyOQxwLtK6Kguf0UPiASrJpaVt3pPqo982C9sN/2MKw1skEUMrj3oE5?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea12a42e-0b54-4f3e-b356-08da007343c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 19:47:08.3637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lD/J2KLvQ8GLED6M1yAtWACBOxt+Sbn0UjAiMKN9cOYCeZxy0ASaaqMpN9W7JdPeSpDQQY0bogjNoPr3oZmfRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1622
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Sent: Thursday, March 3, 2022 6:33 PM
> To: Dan Carpenter <dan.carpenter@oracle.com>; kbuild@lists.01.org; Ashish
> Mhetre <amhetre@nvidia.com>; robh+dt@kernel.org;
> thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> digetx@gmail.com; linux-kernel@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-tegra@vger.kernel.org
> Cc: lkp@intel.com; kbuild-all@lists.01.org; Krishna Reddy
> <vdumpa@nvidia.com>; Sachin Nikam <Snikam@nvidia.com>
> Subject: Re: [Patch v4 4/4] memory: tegra: Add MC error logging on tegra1=
86
> onward
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On 03/03/2022 13:31, Dan Carpenter wrote:
> > Hi Ashish,
> >
> > url:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.
> com%2F0day-ci%2Flinux%2Fcommits%2FAshish-Mhetre%2Fmemory-tegra-
> Add-MC-channels-and-error-logging%2F20220302-
> 164625&amp;data=3D04%7C01%7Camhetre%40nvidia.com%7C448e9570ac274b
> 7ed2f408d9fd162da7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C
> 637819094016979779%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D
> dzcWTAMPikKWLFc4mkD%2FJPWQckiYrUzI9OOEEGvvDAA%3D&amp;reserved
> =3D0
> > base:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftegra%2Flinux.git&amp;dat
> a=3D04%7C01%7Camhetre%40nvidia.com%7C448e9570ac274b7ed2f408d9fd162
> da7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C63781909401697
> 9779%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DpbpW4cT7C%2Fa
> qP8FJClKKdG4NdXpEGh0yBZPPk%2FeCSvU%3D&amp;reserved=3D0 for-next
> > config: openrisc-randconfig-m031-20220302
> > (https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdo=
w
> > nload.01.org%2F0day-
> ci%2Farchive%2F20220303%2F202203031247.0bBX70B3-lk
> >
> p%40intel.com%2Fconfig&amp;data=3D04%7C01%7Camhetre%40nvidia.com%7C
> 448e9
> >
> 570ac274b7ed2f408d9fd162da7%7C43083d15727340c1b7db39efd9ccc17a%7C
> 0%7C0
> >
> %7C637819094016979779%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQ
> >
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DTO1bX5
> %2FM
> > PhUpf%2BnwSuHkB%2ByLEe4Mdn6Or%2BiZUrbeHpY%3D&amp;reserved=3D0)
> > compiler: or1k-linux-gcc (GCC) 11.2.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > New smatch warnings:
> > drivers/memory/tegra/mc.c:593 tegra30_mc_handle_irq() error: uninitiali=
zed
> symbol 'channel'.
>=20
> Ashish,
>=20
> I mentioned with your v3 that it is expected for submitter to run certain
> automatic tools:
> "We not only expect to compile it but also compile with W=3D1, run sparse=
,
> smatch and coccicheck. Then also test."
>=20
> Judging by the output here, it could be that either you used old compiler=
 or did
> not run the checks.
>=20
> Can you please confirm that you performed all the activities mentioned be=
fore?
>=20
Hi Krzysztof,

I had tested the code and verified that MC errors are getting logged as exp=
ected
with my changes.
I had also compiled kernel with W=3D1, ran sparse and made sure that there
aren't any warnings/errors with my changes.
However, I didn't run smatch and coccicheck because I was facing difficulti=
es
in setting up these tools.
I'll make sure that patches in future are scrutinized by all of these tools=
.

> Best regards,
> Krzysztof
