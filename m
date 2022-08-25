Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5355A0E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbiHYKsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiHYKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:48:48 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20060.outbound.protection.outlook.com [40.107.2.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADAC6CF58
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvQoirI+IzhlEeM+Imap5N82xRRJl+mI1PaZjzAU3/ekCqv+McZIqC3JuV5fwiOu2ft1mnqG/hKjkQ0Lduzgq+wCBWDR+lMTiUQ/Uac4IOlHoCm7JT0MIwVutNgsuA1pTTIocspHDPZ86dD32pCROHK8wmYrF0gXOMOdykxR/6OVoQmZ9yiBGX5/1FSyBp6RqXw9FgQ36F8vtn5TqLem/JJjMRXMAFob1IU/Hm2Efqf0BsELDCLjdfNx0wcMmq9qaxVRXRRtwW3ro36bnajGywdjE6GQMOIZEzs0fVLmhzbuadaNj99QnrlPMCqXgddudyYrUYuZ4qUKnEt+URRXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uvhgJ9sFEhunRO3cgLjO3jrDzgy91TnbByJaByOIhg=;
 b=jX06NlJ/nQn6SVDV6V/Yet4WYtAO2nuyacd2iob6FXyIX4nHT0WS4wgeQPe9eYxgyI69man8UD3liakaXjS8WwvOssv3Vg5vnjOSx0ihN437n1nPp6ybTJZBZfns2+P7cLAXjIPSv2J4bYheTdsq/s502Krhj1GEsHrPvLNNrABoK9tVY4YP/Z9EwLx+JIBU//Wi9Q8ACCK1cwIMhzFcnGm7nDy9KiS1I1Z5275zKW1d7tgO+KevRXv8D0IS8Ze5rCsoSVb1B4RNwvDtB/x7GwCyI3QgPHAtEhHv1u2ViTHJ8pTH3QW0RFFsoQhWQpVaNB/JhAe/+Qf1l9qFTZzINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uvhgJ9sFEhunRO3cgLjO3jrDzgy91TnbByJaByOIhg=;
 b=d9vTUQoZmk2KaCIslBbm5j0wViRKB27MO7GPD+4L92srXd3XIVuxiIb2JLdS4bthTayq8WbXrqSwEsv0so61lAYPBE2vMJJ2jiMz1V0iHzpm1uHZekoL1n/+RAkA5Lf9SAIuTom+fANakPAxVzbOgffQWZAFxlB5cfHU0/M1WOJfP1mOrt5+XTo3dykAOajtthNj888Pdl3gvGBMiusDTA6HjQVBaU8Jcidtce/9H+GVSKb8y7DDfKGw/kzd50gAOPJ5xiIEBUS8XcQ5FLbR3uyIxLILltpjBAWlVCRf6bjuR+T4LP9iV7vzq1qT+gMt8Jwr6JClh4dlmG2QlJeFsw==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by AM0PR0202MB3410.eurprd02.prod.outlook.com (2603:10a6:208:6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 10:48:45 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 10:48:45 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo62/bykAgAAAfyM=
Date:   Thu, 25 Aug 2022 10:48:44 +0000
Message-ID: <PAXPR02MB731016E9CB8C7E04DAC4790981729@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <20220825104604.GD2030@kadam>
In-Reply-To: <20220825104604.GD2030@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7645767e-c3ac-4174-493e-08da8687620d
x-ms-traffictypediagnostic: AM0PR0202MB3410:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udL7qXIGXaCKNpMTG8g2k8d1xOx8EyiNghVbOJayCsE+BPDWkcHSdffFjhI6exw7aWU/ER0VdKxTYSNTZTN9u9qe5SjfD2M/x3JqKcun+JypbRl+p7te4KIni0bJsWrR03LalevLx2KDV962RsgneT/QMl++GdkDWEwC6SsM31I+gj1F3izaWJ6tPcJlBAjbY6RwDRcbIhaumKx+XD2zsf8nePS65kCqqAbaxZ+r/Sl/WIjY7QEftunjf7HNQ0EJSHSieEGrdDSWSrS1W8dE3O4LqlhhL3GS0Ap+L63BkwtCQOU3Br1bJwbCspvknEXfcEKz9Z0AERz14vqjffVjuhKJXaBJlXTzps9ce1kJt8+qdM9o7+BLauWC1V9wsPCo1s5+SM+r6ib5N56E00tGFDO1Vq64iqGYS5eic9fxNM/S1hPC3B06lMcOVd8W8VEy2XGLlAw4PuITF6Ez0+wajo7PXsznwQl0xigGiUt448V/JtE8aCTmbmfWciDXk1qhYADR2+55nI6Wj+iT1xnsfEtLpzOuYpD/O1a1Oju5ETHWzNa3gOscL74vz6/MT0i6Q/OKwClrtD29+2D5IZrqBlH5VewZLi/gmg+DbtZibPo3yTgn2HzMbmABAcNajvfEsfygGrK/DE093FrCXpPEQRAxQkZCSr2LWwqGKfIWQ+PdWboeE0HPsW1CuL+HqTPBplTvUmh+42jcRv+pvhT+PxjtgQDQMeCLEJPAVptatHCJ7FRmICowhg+kHARWGAcA7xNZ+WSFzh1OTD4+sh3YWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(26005)(33656002)(86362001)(9686003)(38070700005)(82960400001)(55016003)(38100700002)(122000001)(316002)(186003)(76116006)(64756008)(66946007)(478600001)(66476007)(41300700001)(66446008)(91956017)(71200400001)(5660300002)(7416002)(66556008)(8676002)(6916009)(2906002)(52536014)(7696005)(6506007)(8936002)(4326008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+6xapzERBMwRfq6PV/FTfl32BppTKe/a0xXIGsByGtBZIQchnYvbOceDEx?=
 =?iso-8859-1?Q?GJHmqAxhHWwsOUR0LoSkfPa6ph8ImVYKCyiq3gm245vhJYfAyJ8s1dptjh?=
 =?iso-8859-1?Q?1EVa8voLrBpn/CJOhF2vQHLZ4WRbJw44S6IAf0BEK26f5001SCVKBmUYwW?=
 =?iso-8859-1?Q?TWh/5MwFWNapE0MMeEAxhVClpu/q3uUB2JmfsoqtUXbRIqkQ68pH5UZLtG?=
 =?iso-8859-1?Q?6Zs4xdpRRQtMyTVpjLKo15rQHwHBQu0a5Roi6yC4RhXOe073XRdOY4T6+q?=
 =?iso-8859-1?Q?lVjBf4rgfqEUA2I2n5ncNH69e59TlRn2U+qpuLeHDNBMBQElHbGvnZA87g?=
 =?iso-8859-1?Q?41NuxzWC6VNiw8NbiDPG8qVwIXKxLx4p1/Fmc90Utgh6fAw5S6rl5CgbfU?=
 =?iso-8859-1?Q?5tF7hOkzaCDCuVEceb7pzUfAv1O96zasrMAGDdrdAa13HqR0aKNefctuO3?=
 =?iso-8859-1?Q?FXGzSmqvpUBYqVS1hA6eTkaRw8B6x7y0ATQ5SqA84jJwmcxUeSowobYuD+?=
 =?iso-8859-1?Q?Eb2fMHouMoXiW02Fwl3pdrLfxqmjha7/SI+567ab0nTnGOvHpDAut+DjA4?=
 =?iso-8859-1?Q?gGOjci2RDqZQU69aAKplC36gzBxE/Y7YL1TWsYEOpGW9TLZLhthDxi0rVr?=
 =?iso-8859-1?Q?zcB+OZLmnPReHAxKvOQqsusZlD4KYcdWysef2gP8nY2I6yLf6aPux+YYAd?=
 =?iso-8859-1?Q?qnTjS0sV2F6rQkv+5KGRjXR+OTwQhQyXzlDVsYPd/cqZJkU0JQJrCtK66/?=
 =?iso-8859-1?Q?ruAWpeHoGNfwD4diexgI8KdSwBATePH92TBl5iEd/gH0Sd25PyjnItgPwO?=
 =?iso-8859-1?Q?f8Zivr4d9nKHgiIW2i1l1AgN1KrDNLyXv21vm+ede/EFgK1zRkPytrdlEc?=
 =?iso-8859-1?Q?FJ6a9tdOLgMsZPL+zFMAbFILZ8Of4BZUDUAlOYojBOigylnO+ICZx3JHIK?=
 =?iso-8859-1?Q?3di5BabCs3FXuysUdVTvHMBUtCwbDw3emetKnm1KVK4wxoJZBxwdTcLBKZ?=
 =?iso-8859-1?Q?IHZxmSSOCct2pfbVXnDj/4bMas2qnUlNrZN35mRGZHRYqAIp/7llmfPYpA?=
 =?iso-8859-1?Q?al8zU5TObcxmUym11BK6ZGJYk2YXOW4FAbP0biPni20ZxR8VReswXHUekr?=
 =?iso-8859-1?Q?6l6MfCWR5swJcNsCEWTyP7myt4b75xXsiOvd93Ye+wPPHT8bOd7+QboP2f?=
 =?iso-8859-1?Q?hwq3s6mL2FgXip3iEmU3I2tyX/4xLUz5gEbCLAplLKAZrdJIp/RRjD8zER?=
 =?iso-8859-1?Q?lD0dg00ZNc9eTDyqBYx6idFVodTn/+/aw8t3bJn4ttFL31OT4c+/MjOKGu?=
 =?iso-8859-1?Q?aUBjeVMfXufWONC8PWAef5R58IKEL9NfrZhhAMaIIS/6Xo9bT+W4dAN2bQ?=
 =?iso-8859-1?Q?FJTTfeUzXFIuaoLS6RrqP6T1UWVgR9TEjetVMYNpqCm2CTxuyFvNRAkFqT?=
 =?iso-8859-1?Q?D7MZ7VAKmrO6qsymyYzbseXgXCCRsPYCjEb3ydFRkiU580key3cvIwboFJ?=
 =?iso-8859-1?Q?5p4mLQii2OSGZ6VAaMDWEyJvUzlQ7+/qBQ+wWP1pD5dWjIVw5/ZCKgbsJY?=
 =?iso-8859-1?Q?I5O8PKBbqZ9YW6DoEw5BLIc4wK1DGjeb7aN6wgQIoB+M7hGecYOWXvtTxN?=
 =?iso-8859-1?Q?TOAMe6MOMpa96oYDXQxTfkeP0JWSxIXB7r?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7645767e-c3ac-4174-493e-08da8687620d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 10:48:44.9008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwvZgqAYX6TNzeXqid5kHbN0cssWBRfDXdIMmgwc93A1HOkssi2t5z41xUV38VKWmrbl7ElqmL6tOQqRWmLIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:=0A=
>> Introducing the vSMP guest driver which allows interaction with the=0A=
>> vSMP control device when running a Linux OS atop of the vSMP hypervisor.=
=0A=
>> vSMP is a resource aggregation hypervisor from SAP.=0A=
>> =0A=
>> The driver comprises of api part which facilitates communication with=0A=
>> the hypervisor and version which displays the hypervisor's version.=0A=
>> =0A=
>> This patch s based on previous patches sent to the staging tree mailing=
=0A=
>> lists=0A=
>> =0A=
>> Signed-off-by: Eial Czerwacki <eial.czerwacki@sap.com>=0A=
>> Acked-by: Leonid Arsh <leonid.arsh@sap.com>=0A=
>> Acked-by: Oren Twaig <oren.twaig@sap.com>=0A=
>> CC: SAP vSMP Linux Maintainer <linux.vsmp@sap.com>=0A=
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=0A=
>> CC: Arnd Bergmann <arnd@arndb.de>=0A=
>> CC: Dan Carpenter <dan.carpenter@oracle.com>=0A=
>> CC: Andra Paraschiv <andraprs@amazon.com>=0A=
>> CC: Borislav Petkov <bp@suse.de>=0A=
>> CC: Brijesh Singh <brijesh.singh@amd.com>=0A=
>> CC: Eric Biggers <ebiggers@google.com>=0A=
>> CC: Fei Li <fei1.li@intel.com>=0A=
>> CC: Hans de Goede <hdegoede@redhat.com>=0A=
>> CC: Jens Axboe <axboe@kernel.dk>=0A=
>> CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0A=
>> =0A=
>> v1 -> v2:=0A=
>>=A0=A0=A0=A0=A0=A0=A0 - fix -0 var init in add_sysfs_entries (pointed out=
 by Dan Carpenter)=0A=
>=0A=
>Please don't resend patches the same day.=A0 Always wait at least a day=0A=
>but probably for a new driver wait 3 days.=A0 There are going to be a lot=
=0A=
>of comments on this.=0A=
>=0A=
>My comment didn't even warrant a resend at all, it just something that=0A=
>made me chuckle.=A0 It will take a while to review this properly.=0A=
>=0A=
>regards,=0A=
>dan carpenter=0A=
>=0A=
=0A=
I did not know that, sorry=
