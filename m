Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E65A223C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbiHZHry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiHZHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:47:52 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D995A8A5;
        Fri, 26 Aug 2022 00:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyGCGtt4fNJuzZ3UEgefaoWmybuXcY6Bml6sHJ+Ik4scAppcm7qcmcWvZnNlT2PhnnXNB+aH9OktrusrzZKEhJ2qUQE0dfIHT5l2c1l2TpmI2IPwNu9GCMQwiJf8VgoJZ3J7Bp1C6noqFuxvSSuErxdEsSX57YQxIq+K+d1PuZx8JykZZx8vHuyZnb1d1Afz+pJFSPXQf/6GrtwxwR37B2aXfthHgXs5IGY0H9/sGilNz6sdwaVEK34hX/8p2zk2hHMgwU6Ibc/r5kvKh1PTwAKLO6u441/flhDtYwJUPa9fxN5+SnFWfJHi3Tggsk/GpK4lbzeaR6F5FFm4QgbTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYPJi0qAz6V2WN2KsptPV+otTTVcHSM/8pd1wnF6Sac=;
 b=V877qe/WS3SO3RyvABJGThTLs9Z7oEv1v8EHnXA9BakCiHL8+9Yk2RNwqyaVtYBd1qSF1Wj2/P1Ev4i+0/TjE61vGNeX0+a77ylTmXkC9usCUCusOBuGRiA3vr1U8QN0dfK5+uNZRg/L9kVxD6r6pciJeKE8D+SVglmaWepHV2I6Y+r3S5F1Ssvv87SGOfj+ytIksK/T0NxE79zjLkRtwq4qL+9behYAZABE/nbLq3H9olXjalUWmprMrnYOHH1wI1ppPN9N0f5FLhkp7DdvgAAN2oAyz/33tZoJZBpfgSSxaRek6Ww+AR5G1cY7+eXkfoE5BVEkPux41SWTEo0wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYPJi0qAz6V2WN2KsptPV+otTTVcHSM/8pd1wnF6Sac=;
 b=NdoZR8G66iflAjt1XL21XqmWnJHRs8Pi5xsZ6aV/kZWFQO9QUqc3Woicv9fEzI9gRAhXWe94e8lWUQQtAAvbnO2Lwv8eH8IaeWz+6xrOc2kSWrXwXDtRo//QNOLRQide6TsDTzm0t3Eg1w2PSoVn2vpdeu4lguInv7BAyeEpS0Y=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4191.eurprd04.prod.outlook.com (2603:10a6:803:45::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 07:47:48 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::cd23:6d52:9925:4f38]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::cd23:6d52:9925:4f38%4]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 07:47:47 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v5 2/4] media: amphion: tell and handle
 contiguous and non contiguous format
Thread-Topic: [EXT] Re: [PATCH v5 2/4] media: amphion: tell and handle
 contiguous and non contiguous format
Thread-Index: AQHYuCHju+FVuKkz9ki0/lyYsF8uQK3AyHWAgAAGC2A=
Date:   Fri, 26 Aug 2022 07:47:47 +0000
Message-ID: <AM6PR04MB634128ED70894F35B629C69AE7759@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1661390673.git.ming.qian@nxp.com>
 <7e6a945b898254679bd93e7e001e7c24b5aea0ef.1661390673.git.ming.qian@nxp.com>
 <20220826072047.GA3151@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20220826072047.GA3151@tom-ThinkPad-T14s-Gen-2i>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb32daae-4be8-4d8b-76f4-08da8737451c
x-ms-traffictypediagnostic: VI1PR04MB4191:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGoqKeLeeDs753PnilslXzPyQiwb5ojJXOF+cew2cQjv1VuPjd9lDAVcEkG0HZtoJvshUzWDFDULLrEcXkGk2PnDtgHKur0KDicSmwMkkcbFEAvkLGKZ3urPf7V4hlni00NK3Xb9P3V4+iPCQ6ThxwBXOLjfilnn0TbwK/AmQpKr46mzftdU12v/tRMiUDYsDW/DQpXG6xhWhcVimWqDKA6l0V1XlPwfKl2s5jp1SpuBx+ITXCPbqQ/VKBxfLMlPs1n7JcEklSG9pkIAKMZ80zucSEWGe5DuCgGxpDTMertuZRrphY3DeQecVVXIXlFLpGyt5rMey0p9kDnnmWe1PO5R2gGO4z196GXfl8DztbPphSAGxyCsI9iD9Yf5aOlSaOkPkWZ6dQbryyzan+lyC8YS+DKMaBZ0vjjiDHPKopPYQGaJF+qc44LIt9byGDc0ZDwxN61VSHYkJYn9VSAeHDKRJS/AwAHZ4DOPf0YZMMl/HwgHS3VvUdJ/R6lKr2kzSJnoscZBzFZs2MSYl5u4wMq7OSAwT3z/HnM7myG+8nTYvLBg981aIxiNOM8JyFqv5GIo1tOAFk2BA/0MgtvmZVMIy046cwJhCgmXO/C67n9R4kRyP9pj+9VxXpdWmpTeJTgnGPAEpIxxko//h2Wmn17BZnjuYpVCsDl1aV7Lyu3A22OlCbZ8OEufO+fKCPCHNhtal2NgaE/ovn17xWms6ZiESqaPviKcFmxVhJwouFMGqvvFvGjZO2MOV5/3CvsCpXZd8CYOHS9/wwttcoUTwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(316002)(83380400001)(4326008)(66946007)(64756008)(8676002)(76116006)(66446008)(8936002)(41300700001)(7416002)(52536014)(44832011)(5660300002)(478600001)(38070700005)(186003)(66556008)(7696005)(6506007)(26005)(33656002)(66476007)(55016003)(38100700002)(6916009)(54906003)(9686003)(122000001)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NK+KO2WhoWAoAtgwKwNXfSYARYO+F23Yl9tAinN/2sCgsaF1FEqsWyUiWQBk?=
 =?us-ascii?Q?O5QtSBGv5xHi05g5nBV4WkaoktpCy3SXs9ERVQMsU9Y2/TxXGXWqQ7eOTmUM?=
 =?us-ascii?Q?/6EnJqdi9mwEGOH43LrjJP2yVfEhqW7Xab5b+W+2+ZHankWyC5aZkfCaHZxO?=
 =?us-ascii?Q?7VbXvYT2C2QpPj1x1cCKxjkIa1c/SkivpsvtCudsh2QcaLsXCwNZzncEq3I7?=
 =?us-ascii?Q?sVxGaiQYVvW4DWIylZeVVVimYOsuOLnZCDNGmz9l81DDcJ/ShD+Dj3cTmQUH?=
 =?us-ascii?Q?TJcnSjdkHxC2UayFiLlzP/JvKY9RiQI0NLg454QdvnaelQMfQFgpppQvq8hX?=
 =?us-ascii?Q?9wWgMNHby/XwCsHGx6povZq+RUaojfn0kEDn3nhkEnUI5psf7YLEkZ57Lswu?=
 =?us-ascii?Q?txC1s9d0uRfqp7HpJAzusoW4lLqfn/vuMyh07NrzpxiOo2X+TYhZu0McWluW?=
 =?us-ascii?Q?fa1/LTIddt/wZLufb83RKQGZMdoTgdM8FTM7qrL/Tso0vjPLdRC2m+NA5hJE?=
 =?us-ascii?Q?6TdwrbvEvADwEwWCKTufYOMjH1zmFmgbXANrMoEUFuGUXgb9DaTAUcl0JpgB?=
 =?us-ascii?Q?lqRsUuYVbb0/tBUqlkW6hnjZjYVk/N3oSrKpfcP1kj13+ljOzoC3c7AsxxSL?=
 =?us-ascii?Q?YfPfbYdpcF3UFkw7xcLtn/MxTMxC2S5FTWnm7rjiFFQWSV8rwFA9GNrXDykO?=
 =?us-ascii?Q?07J+/2F8j9yANFKeWmjN4ca7nRbt0FT98hU6TDkMr4qqZFUNJ119Zs2huIt1?=
 =?us-ascii?Q?LBt3cVr10LQ3MBeLw0nF396a0iiIAqJiEEgCzLXmLyZpOliTtT1dXR682gxl?=
 =?us-ascii?Q?ejZds/ulm58RgZ8/we5tl9C+qgPesTn5oVBFoIabbk0wIqqA9bhJy6Ybvu0q?=
 =?us-ascii?Q?F37q0mGmKF1HFMd0qC06ELno/UJ6ew2NsmH0SZJ1xl1+VMSHylV3HTp2yHW3?=
 =?us-ascii?Q?LCs4Rh7KoJwm+nD7mIBGWLT55BRqzE7r4WzVG8qT+kXeBSXZZm096m4S1QmJ?=
 =?us-ascii?Q?fmH3uabmDTjNac0ZIMeyfn/Nb54pHHfZydb2e1ryYOBujngMTujx4vjCBzkz?=
 =?us-ascii?Q?FsV+KpCFF/G0+YcaQdq0aokJ6XwBPKcEW7MxXdla9XmVsx/Bw71IaZE47Hd0?=
 =?us-ascii?Q?nVJbeyoaNt8/kBY9hXYQD7qoaHHlXZmq7dVoX/mtCR/3YplzE0rYNWMLOv7i?=
 =?us-ascii?Q?Nc8t9GXZ8sWMPYaL8+A/O0Y8DOhCX7dyxhaz+Bk2DEg5vF/gM+iwnJeWSPvb?=
 =?us-ascii?Q?8Fq8xCpKRHF8gmIB7eQtWVWb/9QhMA4Gi4xhe562ZGQ/YDXIBQ8fSX6FmFn7?=
 =?us-ascii?Q?0TifjM8RxChFuMuXtwOKiDikVIwXMMhYWVNKmIOTikTBV1RtkvXsJZXmZnM0?=
 =?us-ascii?Q?msX9ACpQ6cBFRcAwFZhk9/oogHCnetRH7R+8tdsBGp6EZDIjvbzvvbNBCPNr?=
 =?us-ascii?Q?4gla9+KFUvZjtvNkDOAkazQ9QiDbZz9cXrpt2qJywW53POms6/ZQajEHMwrp?=
 =?us-ascii?Q?FSJzCHbsbQ8LzT+sYNV2138xGEkI1ifewLF3BYngYVNNtQkyzEbRMrZROpIe?=
 =?us-ascii?Q?jzasg88zWKVaschbTW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb32daae-4be8-4d8b-76f4-08da8737451c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 07:47:47.8322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/StMUNNLVnB6mnw4//PpZfPnHRY4I2IP+LUIUi1OuwiLwuHdf8GSFxendqHkxmyb9ixYCII75cTLNVJkbJYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

>> diff --git a/drivers/media/platform/amphion/vpu_helpers.c
>> b/drivers/media/platform/amphion/vpu_helpers.c
>> index e9aeb3453dfc..019c77e84514 100644
>> --- a/drivers/media/platform/amphion/vpu_helpers.c
>> +++ b/drivers/media/platform/amphion/vpu_helpers.c
>> @@ -59,6 +59,36 @@ const struct vpu_format
>*vpu_helper_find_format(struct vpu_inst *inst, u32 type,
>>       return NULL;
>>  }
>>
>> +const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst
>> +*inst, u32 type, u32 pixelfmt) {
>> +     const struct vpu_format *fmt;
>> +     const struct vpu_format *sibling;
>> +
>> +     fmt =3D vpu_helper_find_format(inst, type, pixelfmt);
>> +     if (!fmt || !fmt->sibling)
>> +             return NULL;
>> +
>> +     sibling =3D vpu_helper_find_format(inst, type, fmt->sibling);
>> +     if (!sibling || sibling->sibling !=3D fmt->pixfmt ||
>> +         sibling->comp_planes !=3D fmt->comp_planes)
>> +             return NULL;
>
>I think to preserve code style you need the following solutions on this if
>statement:
>
>if (!sibling || (sibling->sibling !=3D fmt->pixfmt) ||
>    (sibling->comp_planes !=3D fmt->comp_planes))
>         return NULL;
>
>I think I have suggested to you this solution on the v4. But never mind we
>need this :)
>
>Thanks
>

Hi Tommaso,
    The parentheses are unnecessary, the checkpatch.pl will report the foll=
owing style problems if I add the parentheses:

CHECK: Unnecessary parentheses around 'sibling->sibling !=3D fmt->pixfmt'
#11: FILE: drivers/media/platform/amphion/vpu_helpers.c:72:
+       if (!sibling || (sibling->sibling !=3D fmt->pixfmt) ||
+           (sibling->comp_planes !=3D fmt->comp_planes))

CHECK: Unnecessary parentheses around 'sibling->comp_planes !=3D fmt->comp_=
planes'
#11: FILE: drivers/media/platform/amphion/vpu_helpers.c:72:
+       if (!sibling || (sibling->sibling !=3D fmt->pixfmt) ||
+           (sibling->comp_planes !=3D fmt->comp_planes))

total: 0 errors, 0 warnings, 2 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

1.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
