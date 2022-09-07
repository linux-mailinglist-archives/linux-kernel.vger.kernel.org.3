Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89055AFC2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIGGLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIGGLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:11:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF02493218
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGDO2/nrI7TV8d4ogtz6gqLUtr8nAnM7daRkfWu26UZwwOGjtstODGJIGd9Wzw/vKHdSrJ/R13dd5iDKAaMZLSenynC2Ad+qY5Bitgyq51AHTB19g+hPBEV+JGwsqJ5TQuiuAP/t7AX/LLTl3WU55UCMY3DYpvqapxs3lxDS9xIRSH0lQH6l4hgFyq1y2tBbRp1PI1f6xYW8VFmX/smJJPvj2u4X+ERpNGISgFiYr3GqN5POPBtVfzhWgaJ+wZ734cg+DBuUDMNOizFVB6HK4FR5T43xb5l8MIi7Ua+h0apQZZySWTj7OVpLoZDQUam3l9mfqg1KyQDrMvzlbwe2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eco+qQOrSm4bbadDgy26mqywE0m74nWxaoii82X78z8=;
 b=aFKfKxNG091AaDnUxOfaGrghApMaYz7w6W7hD05nbrtsqZtO4UR1HJ2Aai81KhfIuIZhh8GrawFpfysQiyMDySTfrZBE8a00A5lXL2eQ9C8HCufaoXsPZhgrb+TJbvvlAYmPNWW3kV7lHZCkK7taKBd5R3GzTbvtrLTesG5g/zfAh1lrzB4AYTbXzrq0JG383Zy9obtNvFIGYvfetFJOtuxFyZswhFqkfGL66FBS4e2Gfj/kKWBnhJ6ZWqa/d6Qdpp3lGrKTEaSJMxpOdC/GpusMOd5Z1HLQ464Kj22TEhl6uDn9306pXvhI1zdyMPnxVuHMxyE2WENl8RXalaCVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eco+qQOrSm4bbadDgy26mqywE0m74nWxaoii82X78z8=;
 b=P/A5Ihk0la+tsd+xp6XMXA1hXSRiK0Zdm7m5D7+U34amKGOxAppIKQorvS7bJJFdb5veGlD2212sCdkqDeAq3ReYDihzfCEi40yH72Vj3/ORXwO5L+0QE/Ajpz8XYHHL3HMPOjiGrcgsrcMS+EJVAFxMdMl/LgvsOESIX0Z6WgDZdstcibUew7qhNZMo8P4e5tfTEHRgd+FokCZlluuHw2aPLTnRPxfHVtIjCEYxvCD14K+0s9nse+R79/FkZA1sabO0dgpdAncY1/sfm2DBaXq8JoDKNUD4astq7ZsNLkjLhSW+bAFI7QZCD0Xby3/BiRSOVfaULiDJkUJFqNMEpA==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by GV2PR02MB9661.eurprd02.prod.outlook.com (2603:10a6:150:dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 7 Sep
 2022 06:11:40 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 06:11:40 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo63SfrOAgAEPxFc=
Date:   Wed, 7 Sep 2022 06:11:39 +0000
Message-ID: <PAXPR02MB7310E981AC6A64E5166612C181419@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YxdQLY3RWRRuFMKd@kroah.com>
In-Reply-To: <YxdQLY3RWRRuFMKd@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR02MB7310:EE_|GV2PR02MB9661:EE_
x-ms-office365-filtering-correlation-id: 90df447b-574e-4b93-ff27-08da9097d426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KAk0Ko5AGEks+2vl5VteBY7WRwEo1N3eftmEOJdoZ0us7MxXO5Nn+37FJYYYBSNR+NAiBSKSEzzvzD7ueCbxhKMq5NJcrJFuD1XliysLq2L5b2a0W01m/K6B0eP6F/44/Q+g7l8kfBex/UukHUFGyXPSpl92D/LEe6POJAWneofVK/SJAHq/Skwpbp9kObz8fe6Xr7ou9PWyyUue4vNFSD8Hja4PxJWEPUzxGYTOdwMOEHgJNwewX/+J6LAFPvHgxIy00G6pCMZJ15BHvZcYmX4sm8nWmkD34V12JLZvvQl+MNDRWrmrnuX4ZuFuhAh6khyiJ/qSwaT88u2swmI+LR1+jhXxEdyqkPWnXf1rR2zJK6CEdtjvCD8URytd28W8iQdD3EZxNK4CiWI6Ajglw2/HWv2FMsXpVLVxkFMLXw2feZ9FipaphEOaVZziGlry8HykgvZxF0oJYvY8qyAwEfi7fS8Jy/ppS6obgOc9HjacEHDKUTk4RpgXI1wUjo9GxbJqX0w3T2wuN4w1Q5WZAsISHmEcTT4s1Wy+NLHueOySwYsw746JZ0smaem7FbX2uaWw+uPPF0yPNP1JwrOsOgbsqsTDlPbLspoqoHR0pZZHfnS3h00xIMCq7ES392USWtdS9M4aQseWj3aTFvQno5mRnqX87M54OdrjIsv77Eu8VVU71dCfpLCJQC2HhRLgD5rB31tKpFpLoM4KprKR20BeywxHh3tEZowwOwRcYjrX2B3qDkTEUQn5uaiJrTARHvA5/+k/9oPt+wfp59FXBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(6916009)(54906003)(26005)(66446008)(9686003)(55016003)(71200400001)(41300700001)(86362001)(7696005)(38100700002)(122000001)(6506007)(478600001)(5660300002)(186003)(64756008)(83380400001)(38070700005)(52536014)(7416002)(33656002)(316002)(82960400001)(8676002)(66556008)(66476007)(8936002)(2906002)(66946007)(91956017)(76116006)(4326008)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rvHSP75JWSpfwQjceyQZw8yHqiexqwRIKWsT43BpdwbS/GHYifDUCx5Kwr?=
 =?iso-8859-1?Q?WHOddORH46Wz2KHSplyjT2oEokqiYqW/ZGJK0iGDm807b70YyjSFxJXQns?=
 =?iso-8859-1?Q?vlOUrxy1xD2PQ6neygVyk0REDNq6kUldpAs1/cGnQPAPyLX5+VDyVat177?=
 =?iso-8859-1?Q?DGljt1Y6WryWbm6aHDGfPRnZ8mzI+FiDvuV1DQRlNB1FQtRIoQIfROXPD5?=
 =?iso-8859-1?Q?Y9tLxFIQ9hGCvSgAnfikeAtN7UzoZwupPHj8icDiN2inlPH6CWroZP1vo8?=
 =?iso-8859-1?Q?qVlJpf6RtRBTKcNUmUJz1rwkL0IFadUOdp5VzhVLz68BZEbXV+okOFC8ZX?=
 =?iso-8859-1?Q?VGVUT0MhhbhAa4IgvnEZeR4NIwMnpNGRje2CouQl44Y6LriDETwOhHquTZ?=
 =?iso-8859-1?Q?DJRWxfHPo6gjkamVUfZRPT/Osuz8mp3CHGGOOxZWTldPJkFiAiGriCu3Nj?=
 =?iso-8859-1?Q?S9avIdE7TbU3jw7zunMC6ttLt5iFupASpsoAkWK/SidjO6wzW1WX5Ao0f5?=
 =?iso-8859-1?Q?69wL98OKIZo7lrylhdSvhPZO52hoq8SBnRGPsbNDVRVFAb41AJ4icxz5g6?=
 =?iso-8859-1?Q?WU2gv3/t59CHzHeGd5DgCxi8LWLNpo2DBX+OgvNtKPdKta9nnExKWvv4o0?=
 =?iso-8859-1?Q?zui3R2bQU6l0SPq0gBEChTduiG7CIxor8EbXT/moWEjEIm+M5W1CcZkrQ+?=
 =?iso-8859-1?Q?YXmJJXlOUQurY0Unj5rDd5CjWsZbkds0jjk15LKYWoEFfAnEbCbAlGjtsr?=
 =?iso-8859-1?Q?umILL5i61qaX5zUiEITtwD/YdNzQ1VSscGeu6EiqrKSVkA83KO3INI1H06?=
 =?iso-8859-1?Q?rucO7A1FOJWVCfjW4V5PelaVSMiv08YzqgJ6YQJvbATjsk8J3y6enmBHiB?=
 =?iso-8859-1?Q?OH7W3S1YsY+W8idwnFttYAQsgAI9DbNHMcEDrdDwCeqT0PtdgVFGO3BBkv?=
 =?iso-8859-1?Q?vElm3LAooSrl8yDl4zlAEBvJCglwLe9LVWIEBlfwdNlDCG0YvHBdvZEvKG?=
 =?iso-8859-1?Q?kWrfd1IkHgILCngdKD+184bLQMK8KARLIOwbAq/7paGXdiUlmqSHiitrRa?=
 =?iso-8859-1?Q?93SUsgfDkTBMmRcIwY9FlvmRP/+TWF1NGX8fiEr8yVzWPZEwREOY9mEYAI?=
 =?iso-8859-1?Q?cYMtJdyYM2ModlIvDYUuZGXDwAevh/ervcHiLH7CBGGAlKckTjCJGw6Ir5?=
 =?iso-8859-1?Q?pO1wWj3E0CZOoCKLgkN0vPLw0zJY7ipUA/t1xecRKOnd+M7igblOtFrMq8?=
 =?iso-8859-1?Q?0cgqtsq+PO6QZNDocHbmi9Rcu4KFTGcpQpoQwwvLzjS5ac40KHGRZ/WB4e?=
 =?iso-8859-1?Q?ssUR2yloR/e8wtno71fWylFFaH0N4ciYIMGpBfkmDcMgyBtja+TlSXb1js?=
 =?iso-8859-1?Q?tV9UYBlnAu9SeY4epdirp6s/elRvrNWUAMkTL0Dm0X0+kQ7Fz7iSnnux+s?=
 =?iso-8859-1?Q?f1I3reKf9z2jrLQRZyEXPx16964p57pD0yj1gk3CT6Rb9bZEd00Vc+KfCn?=
 =?iso-8859-1?Q?j5r7cw0GN4++Nhw6LLEG5VSOyJw1hSj9L7HWPzcnxu0yItjvgl3rq4qwcW?=
 =?iso-8859-1?Q?jp2haKL7MyC5uIERqOCxfBFPX3BkoejaDZoCgcGdQ7ebK41bCOyjQ0KYB7?=
 =?iso-8859-1?Q?+ix3yWMYw10Lcw4qcSoMq96v4nqPZ00xlv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90df447b-574e-4b93-ff27-08da9097d426
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 06:11:39.9508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgQBdK5qap6m4bcEqhEhrPTa0S4BgFvHmUbbIbKicchCr3HfuBkt4PPkIOfMPmOChgt5QJDUUsS8cKPF+dGh4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/virt/vsmp/Kconfig=0A=
>> @@ -0,0 +1,11 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0-only=0A=
>> +config VSMP=0A=
>> +=A0=A0=A0=A0 tristate "vSMP Guest Support"=0A=
>> +=A0=A0=A0=A0 depends on SYS_HYPERVISOR && X86_64 && PCI=0A=
>> +=A0=A0=A0=A0 help=0A=
>> +=A0=A0=A0=A0=A0=A0 Support for vSMP Guest Driver.=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0 This driver allows information gathering of data fro=
m the vSMP hypervisor when=0A=
>> +=A0=A0=A0=A0=A0=A0 running on top of a vSMP-based hypervisor.=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0 If unsure, say no.=0A=
>=0A=
>In wanting to test this out, I tried it but this depends line is wrong,=0A=
>you have to set SYS_HYPERVISOR, you can not depend on it otherwise your=0A=
>code will never be selected :(=0A=
>=0A=
>How did you test this?=0A=
>=0A=
>thanks,=0A=
>=0A=
>greg k-h=0A=
=0A=
as you pointed out another mail thread, I've made a mistake and developed t=
he code  on the a kernel which isn't mainline, my apologies, this patch sho=
uld be dropped until I generate a new patch which is based on mainline kern=
el.=0A=
=0A=
Eial=
