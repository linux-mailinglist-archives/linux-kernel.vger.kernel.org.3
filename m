Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310FA4BF356
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiBVIRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiBVIRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:17:22 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55587033B;
        Tue, 22 Feb 2022 00:16:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPlfbK3As1CzzkA0wXsFojtMeOpKb+p+tlxvxnfRRRoWA4VPvUgEteYMK2E0JTpqNslfsIPEF+MhCcR6KJo+Ljx1c0kga5fpEFzTD5dVNM0cOIxGZS9O8Umz6/iNt1QsYUVTSbZUMkLoEmhzcP5omS4em5s/YoQ5q/nLSfytqIaVarlwv/0TkdcTCgA+mkFCRYPcIG5Sce1vQrJfYiPiCDMlYcvgpacuAOyyNLK0unnJ6PVRW3v88WOfgZ6qJvm1ne4vnD84PoE2BDWZ5dBCaxNhp8LUEqb1aomSPijFGwQ3xG2qQy5RcwpSUpTS26ic0kWpFU1oZ37x9Ky1tslSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iift5V5mPAPsUGDr6aY4asTkaes/fx9TYFCCa1M8j6U=;
 b=hd8UlOqZyRWP5TcLBdFuyJTCghVYOjEQ5sEcNWxHPaktsN8IAYgv3V9SgDY8gjQ4xXx9dJp+UoEPdmLfEY5cYi9xQBnteyU/74kImgYscCKv6RmEGMvsL2WqDZO/HK86NDqINlIj91Qr9RLDH5/LVuyTxy2KTSJgp5iMEBj/sdtel2T8BVCWE+5AkuzgyJNDTHlaLFxLgobtt+3keahWGsrJmqKUG1sAWm+0cWxTRMgsqiU+kBloaPu0ZxQbLLEiTJBZpS+wWXAS7dO0Ionv2LijteshVhdHNckYezCswDu4O1IQe17L3/XXNcuw3jYbjUm+9rOYI52F3t+xPV1oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iift5V5mPAPsUGDr6aY4asTkaes/fx9TYFCCa1M8j6U=;
 b=htC3/zDNY2+viryNBdXVwl+F+sJr7ewj0DuZT0Y86q3B9ZRowN2InOWxJhN0Ahv9a1P9g2JLuK8X2mkhWJ3BBu5XP6Po/7Xx5A+aSZxnYYItWYlNJrQNvg4vjhVjT4k1/y4RSqfmtTs9EtjrGxSdwZeHQGPrmXymvDsjy/4cgAE=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB5444.eurprd04.prod.outlook.com (2603:10a6:208:114::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 08:16:50 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 08:16:50 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v16 00/13] amphion video decoder/encoder driver
Thread-Topic: [EXT] Re: [PATCH v16 00/13] amphion video decoder/encoder driver
Thread-Index: AQHYJul1Rf6DtZb5J0+NObHJIw5d76yfOSOAgAAB+TA=
Date:   Tue, 22 Feb 2022 08:16:50 +0000
Message-ID: <AM6PR04MB634185D33AFBD83651BB47D6E73B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1645422822.git.ming.qian@nxp.com>
 <0085d6c8-d3aa-7a5f-2dd8-c671b90d1594@xs4all.nl>
In-Reply-To: <0085d6c8-d3aa-7a5f-2dd8-c671b90d1594@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69421d96-b6d9-487e-8388-08d9f5dbad6d
x-ms-traffictypediagnostic: AM0PR04MB5444:EE_
x-microsoft-antispam-prvs: <AM0PR04MB5444B7175324F050F227DE45E73B9@AM0PR04MB5444.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DauBeznJKu0ENbCyE4cHDCu5I9688KNVRLfouRs8l6GbXfzjKLuZLUmXLC1/AitLHxNxAfP1pN5xmJCmJe56RwNI40O6wf7rP/2ezmxA91zrc5vgUaX8PZDTXfdvVP94Ng8Tg5bP9q+q/dOuacnfZGMlCVbQkOzZgX52CPEnRyseiet73Sbg2RpAv8T63kNj436dPy0xNpxBrGeN5nC1QSReVInJk3yB7uwL5sImyk3F1uzypW9kNiglwRNaonj+kVV8nduAcQz3XypIU3q9Yuc09rjbu/4d7lDnY4Gn/ozHniyDLWyE+8E2Z00LJyjJXo/UTNICCtmxxQEPSqgfnLZH0C7yQ6KMIz+53iMcJ55zv3MpmJBCQOHl16bVJNWHPCTU0fgalDofDOEQrBdQ63eXRWxkf1LWwmXhIZtyiesvGXc0x+kGlXCFRjAHVayspWuiJehncg6eISBM8ttEB+KniOCUEbemBgqIPT7MCEVMPdmiyHql3tJ6Ej5KlNKLOwHY+frJNYj176j7WcgOOaXAg2eacZ5sfUdoorbvLxAh+0Pfzzv/r6lWQTiurRghkLLWjHJl+LXgRa9HIo9JmB79dVbyAy2nFCE4XiBNLjlTvidzwzSrocPMtMmX9uyWIzs0HbKelq52rYTRSdeXGIbxciWj+sIh/w9tdqlFDa2R7LeesJVBD62AQUSbwDedB4jGURtMu+Er7RHpfBUiZp40lxx0cx+A8Am8r5CJaQXv3nmZ6cKapB1Y2VDBbYBtmdH9xKQsELskUVWO8KnURfXd7VMd0u2KTsuxgvFSGHY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(64756008)(33656002)(5660300002)(4326008)(508600001)(66946007)(7696005)(66476007)(66446008)(76116006)(66556008)(45080400002)(110136005)(6506007)(966005)(316002)(83380400001)(26005)(71200400001)(52536014)(44832011)(30864003)(8676002)(8936002)(7416002)(186003)(38100700002)(55016003)(2906002)(122000001)(53546011)(54906003)(38070700005)(86362001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xRIRlxQfKclTuXy+KYcpZEJv77IylhB8KcKyhECR0VqsavW04bcDNyll1BYu?=
 =?us-ascii?Q?uA24BJ9jN7MHfHl/F5NCN51f2N6oFw4BRMvMv1rYi7u+Ku8HQXXo4oMuV6Vk?=
 =?us-ascii?Q?rH0uDtPlyEkoMzTdG/GqX4+cPfav0O/J/sAyHne4U28v1IQvNVq0wq3l/gRl?=
 =?us-ascii?Q?kvAueJQqFq446jXRrteNsB7acv23diVl9SQapdc5QZx2+VJFDrUdeHZvdvwA?=
 =?us-ascii?Q?RZE7xfZHt1B6358UJ4Zc7bziT3b7UVsQKAZrfBdIS4cx/96MrqQ0vknzkPZ5?=
 =?us-ascii?Q?FbFq3Q7/qokRIJnQVyayGZj4oxccyFN7fzt5KCzzm//7lm/V5GI43D5A7UzE?=
 =?us-ascii?Q?n5xH7aYW8HHoIqJTBF1QaX5UFDdqwu9XNBPhNdWIKzYsmHSFhwJMayVuVdcL?=
 =?us-ascii?Q?GONRsl7RzLrLjE3jnxdWzDSivYye6b7sjb57svdF9oTmzZHoL3WMHb9OpbTq?=
 =?us-ascii?Q?CQDZH7pzb9ZH9G5IQkC1rdgUmbSN/iQXhRBYU2iHXMHV+yioWdbj57Zl6v40?=
 =?us-ascii?Q?Uv4GzUXqokN+Hf0Vsw/D4aWVKD7KtU3EzidV2ZAnGuFmb7Wm0n4ggGaRHFI4?=
 =?us-ascii?Q?CwEMUMm7R2WWsDVL7AfUsk2amRU+Ote2seOWVcFI6Fgzo2Cuu/1DjuYkCa2l?=
 =?us-ascii?Q?enP3xi9hxjz6TY3gHdHZyklJyYlz8nJ5Snzpv3slhtfAY30GhqAo7fMDjHGu?=
 =?us-ascii?Q?6bnEwAjSFakKYMtt0bgsCRHhtYlgohAJaP9Y26gxTRCXBS0aWQpRqKuGjw7C?=
 =?us-ascii?Q?L45fnpLjZgQ933TeELwgp32cWryM+zr1usNSKoLFxISdT3P0nXS3yKoyl4wO?=
 =?us-ascii?Q?5bbwpayJmXVM5v9ew4EBNVa9wa7Rt+WvNoc9WqYLelsK+IUas8Cax46LjCkM?=
 =?us-ascii?Q?7Fkqy69c3yBOOPu8r3+wMeB6QTcavLE0Iy5hoZm1TN4VUOGcWxqSFHXMkRz/?=
 =?us-ascii?Q?bPEHyUzBb2yA1YXmucho0u+31nyUTYmHHLnBuaAn6OL/4gULP0gTKE3LKD8L?=
 =?us-ascii?Q?l1EY5+Yu9Svymy5HHD/qiIlZ7f7GWL5SVFB0Qu8n5iMya0rWqryZ4bNZljIM?=
 =?us-ascii?Q?8n6if+89RKcbNPniviXATP+QofeM7YRTt8GeCEKLaso7uj1BHQtDSQiZBdOe?=
 =?us-ascii?Q?p58thIoD9lALxNM4P5PRpA7B9JD9ytW4xxEjOAZOPxT19uhrcBsKA5pI5LLe?=
 =?us-ascii?Q?TaZIUab2KH5l+4NnY+AqnTa4kwaZb3D+yKDKa+PpUR5KNZx3D7oXQf4Z+s2V?=
 =?us-ascii?Q?SzWvzmqRg7ceFw/YFRwJJ7wRs3UlNyR8eoIaiR9K3Ay69z0MuBGp2zPedQpE?=
 =?us-ascii?Q?ScM9O/RgrX+cn8Awpi+NC1dL+QIFE5lacubTjt2c41JEXzhULJbHIqRAd/Ea?=
 =?us-ascii?Q?z++wUcqzYo9//kyBG/BH7UDzmMCok2MOBxkf0VlKiITqpY/PA+gXkKp43irl?=
 =?us-ascii?Q?SJbODCgYbUKYyXvnqDExPsQqDHjMEFMkHsmpK9Wje405b9BJxvECj64n7JEr?=
 =?us-ascii?Q?zX6d+EiW8nllUUXZGJbbSjKY6CiL7tGYdBSeGbOE1rYWZWFqfBCy/i0XZpBY?=
 =?us-ascii?Q?Lsx5iJNiJoRpLHg12kHGWMa2AWU98LUYWm6mDsjpE2mvIUYWhnAZEpsZC5rD?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69421d96-b6d9-487e-8388-08d9f5dbad6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 08:16:50.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJw0gCiwZUQ0SWTpiSC4T/TBnu0vRGUBu+fViMsXltERhCD6nEZLg75IOpxeH+fOB7A7RXDNpsAZTSMyBTuIcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hans Verkuil [mailto:hverkuil-cisco@xs4all.nl]
> Sent: Tuesday, February 22, 2022 4:09 PM
> To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
> shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v16 00/13] amphion video decoder/encoder driver
>=20
> Caution: EXT Email
>=20
> Hi Ming Qian,
>=20
> I had hoped to merge this series, but I got a whole bunch of sparse/smatc=
h
> warnings that need to be fixed first:

Got it, I'll fix it soon

>=20
> sparse: ERRORS
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_drv.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_drv.
> c:204:22: warning: symbol 'imx8qxp_res' was not declared. Should it be
> static?
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_drv.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_drv.
> c:213:22: warning: symbol 'imx8qm_res' was not declared. Should it be sta=
tic?
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_core.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cor
> e.c:64:27: warning: incorrect type in argument 1 (different address space=
s)
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_core.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cor
> e.c:555:23: warning: incorrect type in assignment (different address spac=
es)
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_core.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cor
> e.c:556:24: warning: incorrect type in assignment (different address spac=
es)
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_core.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cor
> e.c:557:28: warning: incorrect type in argument 1 (different address spac=
es)
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_core.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cor
> e.c:693:25: warning: incorrect type in argument 1 (different address spac=
es)
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_core.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cor
> e.c:694:26: warning: incorrect type in argument 1 (different address spac=
es)
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_v4l2.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2
> .c:401:17: error: incompatible types in conditional expression (different=
 base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_v4l2.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2
> .c:556:9: error: incompatible types in conditional expression (different =
base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_v4l2.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2
> .c:640:9: error: incompatible types in conditional expression (different =
base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_cmds.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cm
> ds.c:285:9: error: incompatible types in conditional expression (differen=
t base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_cmds.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cm
> ds.c:287:9: error: incompatible types in conditional expression (differen=
t base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_rpc.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_rpc.
> c:167:22: warning: symbol 'imx8q_rpc_ops' was not declared. Should it be
> static?
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:46:9: error: incompatible types in conditional expression (different =
base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:59:9: error: incompatible types in conditional expression (different =
base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:71:9: error: incompatible types in conditional expression (different =
base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:76:9: error: incompatible types in conditional expression (different =
base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:94:9: error: incompatible types in conditional expression (different =
base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:106:17: error: incompatible types in conditional expression (differen=
t base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:111:17: error: incompatible types in conditional expression (differen=
t base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:118:9: error: incompatible types in conditional expression (different=
 base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:143:9: error: incompatible types in conditional expression (different=
 base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:148:9: error: incompatible types in conditional expression (different=
 base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:154:9: error: incompatible types in conditional expression (different=
 base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:164:9: error: incompatible types in conditional expression (different=
 base
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_msgs.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msg
> s.c:169:24: warning: symbol 'handlers' was not declared. Should it be sta=
tic?
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> pu_malone.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_mal
> one.c:470:32: warning: incorrect type in assignment (different address sp=
aces)
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> enc.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c:1
> 093:9: error: incompatible types in conditional expression (different bas=
e
> types):
> SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/v
> enc.c
> /home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c:1
> 098:9: error: incompatible types in conditional expression (different bas=
e
> types):
>=20
>=20
> smatch: WARNINGS
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2
> .c:
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2
> .c:599 vpu_v4l2_open() warn: passing zero to 'PTR_ERR'
> /home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c:
> /home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c:4
> 22 venc_drain() warn: variable dereferenced before check 'inst' (see line=
 419)
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:1
> 95 vdec_handle_resolution_change() warn: variable dereferenced before che=
ck
> 'inst' (see line 192)
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:3
> 37 vdec_s_fmt_common() warn: variable dereferenced before check 'inst' (s=
ee
> line 334)
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:4
> 70 vdec_drain() warn: variable dereferenced before check 'inst' (see line=
 468)
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:7
> 35 vdec_check_source_change() warn: variable dereferenced before check
> 'inst' (see line 731)
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:1
> 239 vdec_process_output() warn: variable dereferenced before check 'inst'=
 (see
> line 1228)
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:
> /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:1
> 287 vdec_process_capture() warn: variable dereferenced before check 'inst=
'
> (see line 1283)
>=20
> So a v17 is needed.
>=20
> Regards,
>=20
>         Hans
>=20
> On 2/21/22 07:10, Ming Qian wrote:
> > Hi all,
> >
> > This patch series adds support for
> > the amphion video encoder and decoder
> > via the VPU block present in imx8q platforms.
> > Currently, support for IMX8QXP and IMX8QM is included.
> >
> > It features decoding for the following formats:
> > - H.264
> > - HEVC
> > - MPEG4
> > - MPEG2
> > - VC1
> > - VP8
> >
> > It features encoding for the following formats:
> > - H.264
> >
> > The driver creates a separate device node for the encoder and decoder.
> >
> > This driver is dependent on vpu firmwares.
> > The firmwares have been submitted to linux-firmware.
> > The commit is 6342082c115e76ab5efe3f93c4c1ac6d01a3c7d0:
> > linux-firmware: Amphion: Add VPU firmwares for NXP i.MX8Q SoCs (Wed
> > Jan 26 13:48:05 2022 +0800)
> >
> > You can get the firmware from <linux-firmware>/amphion/vpu
> >
> > encoder is tested with gstreamer
> > decoder is tested with gstreamer, but the following patches are require=
d:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> >
> ab.freedesktop.org%2Fgstreamer%2Fgstreamer%2F-%2Fmerge_requests%2F1
> 379
> >
> &amp;data=3D04%7C01%7Cming.qian%40nxp.com%7Cfc84f1986f2e46e92ac50
> 8d9f5da
> >
> a2b3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C63781114165
> 2882528%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1
> >
> haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D3j64JB6tiSa7K%2FhApS278av
> V3NzSqXz
> > yeNZcCA0iaN0%3D&amp;reserved=3D0
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> >
> ab.freedesktop.org%2Fgstreamer%2Fgstreamer%2F-%2Fmerge_requests%2F1
> 381
> >
> &amp;data=3D04%7C01%7Cming.qian%40nxp.com%7Cfc84f1986f2e46e92ac50
> 8d9f5da
> >
> a2b3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C63781114165
> 2882528%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1
> >
> haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D4LLF2tnZ0RJ9jBy9T6NYECb9U
> %2B9NPjO
> > IpgBjA9M28Iw%3D&amp;reserved=3D0
> >
> >
> > Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> >
> >
> > Changelog:
> >
> > v16
> > - fix some devicetree issues reported by shawnguo
> >
> > v15.1
> > - include linux/vmalloc.h to avoid build warning by kernel test robot
> > - add entry in MAINTAINERS alphabetically
> >
> > v15
> > - fix issues detected by "checkpatch.pl --strict"
> > - encoder add ctrl V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE
> >
> > v14
> > - fix some errors according to Hans's comments
> >
> > v13
> > - make a workaround that avoid firmware entering wfi wrongly
> >
> > v12
> > - support reset decoder when starting a new stream
> > - don't append an empty last buffer, set last_buffer_dequeued
> > - improve the resolution change flow
> > - return all buffers if start_streaming fail
> > - fill encoder capture buffer's filed to none
> > - fix a bug in calculating bytesperline
> >
> > v11
> > - fix dt_binding_check error after upgrade dtschema
> > - remove "default y"
> > - add media device
> >
> > v10
> > - refine vpu log, remove custom logging infrastructure
> > - support non contiguous planes format nv12m instead of nv12
> > - rename V4L2_PIX_FMT_NV12_8L128 to V4L2_PIX_FMT_NV12MT_8L128
> > - rename V4L2_PIX_FMT_NV12_10BE_8L128 to
> > V4L2_PIX_FMT_NV12MT_10BE_8L128
> > - merge two module into one
> > - fix kernel panic in rmmod
> >
> > v9
> > - drop V4L2_BUF_FLAG_CODECCONFIG
> > - drop V4L2_EVENT_CODEC_ERROR
> > - drop V4L2_EVENT_SKIP - use the v4l2_buffer.sequence counter
> > - fix some build warnings with W=3D1 reported by kernel test robot
> >
> > v8
> > - move driver from driver/media/platform/imx/vpu-8q to
> >   driver/media/platform/amphion
> > - rename driver name to amphion
> > - remove imx_vpu.h
> > - move the definition of V4L2_EVENT_CODEC_ERROR to videodev2.h
> > - move the definition of V4L2_EVENT_SKIP to videodev2.h
> >
> > v7
> > - fix build warnings with W=3D1 reported by kernel test robot
> >
> > v6:
> > - rename V4L2_PIX_FMT_NT8 to V4L2_PIX_FMT_NV12_8L128
> > - rename V4L2_PIX_FMT_NT10 to V4L2_PIX_FMT_NV12_10BE_8L128
> >
> > v5:
> > - move some definition from imx_vph.h to videodev2.h
> > - remove some unnecessary content
> > - add some documentation descriptions
> > - pass the lateset v4l2-compliance test
> >
> > v4:
> > - redefine the memory-region in devicetree bindings documentation
> > - use v4l2's mechanism to implement synchronize queuing ioctl
> > - remove the unnecessary mutex ioctl_sync
> > - don't notify source change event if the parameters are same as
> > previously established
> > - add flag V4L2_FMT_FLAG_DYN_RESOLUTION to decoder's capture format
> >
> > v3:
> > - don't make vpu device node a simple-bus
> > - trigger probing vpu core in the driver
> > - remove unnecessary vpu core index property
> >
> > v2:
> > - fix dt bindings build error
> > - split driver patch into several parts to avoid exceeding bytes limit
> >
> > Compliance
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > # v4l2-compliance -d /dev/video0
> > v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t v4l2-compliance
> > SHA: 493af03f3c57 2021-10-08 17:23:11
> >
> > Compliance test for amphion-vpu device /dev/video0:
> >
> > Driver Info:
> >       Driver name      : amphion-vpu
> >       Card type        : amphion vpu decoder
> >       Bus info         : platform: amphion-vpu
> >       Driver version   : 5.15.0
> >       Capabilities     : 0x84204000
> >               Video Memory-to-Memory Multiplanar
> >               Streaming
> >               Extended Pix Format
> >               Device Capabilities
> >       Device Caps      : 0x04204000
> >               Video Memory-to-Memory Multiplanar
> >               Streaming
> >               Extended Pix Format
> >       Detected Stateful Decoder
> > Media Driver Info:
> >       Driver name      : amphion-vpu
> >       Model            : amphion-vpu
> >       Serial           :
> >       Bus info         : platform: amphion-vpu
> >       Media version    : 5.15.0
> >       Hardware revision: 0x00000000 (0)
> >       Driver version   : 5.15.0
> > Interface Info:
> >       ID               : 0x0300000c
> >       Type             : V4L Video
> > Entity Info:
> >       ID               : 0x00000001 (1)
> >       Name             : amphion-vpu-decoder-source
> >       Function         : V4L2 I/O
> >       Pad 0x01000002   : 0: Source
> >         Link 0x02000008: to remote pad 0x1000004 of entity
> > 'amphion-vpu-decoder-proc' (Video Decoder): Data, Enabled, Immutable
> >
> > Required ioctls:
> >       test MC information (see 'Media Driver Info' above): OK
> >       test VIDIOC_QUERYCAP: OK
> >       test invalid ioctls: OK
> >
> > Allow for multiple opens:
> >       test second /dev/video0 open: OK
> >       test VIDIOC_QUERYCAP: OK
> >       test VIDIOC_G/S_PRIORITY: OK
> >       test for unlimited opens: OK
> >
> > Debug ioctls:
> >       test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> >       test VIDIOC_LOG_STATUS: OK (Not Supported)
> >
> > Input ioctls:
> >       test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >       test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> >       test VIDIOC_ENUMAUDIO: OK (Not Supported)
> >       test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> >       test VIDIOC_G/S_AUDIO: OK (Not Supported)
> >       Inputs: 0 Audio Inputs: 0 Tuners: 0
> >
> > Output ioctls:
> >       test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >       test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> >       test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> >       test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> >       Outputs: 0 Audio Outputs: 0 Modulators: 0
> >
> > Input/Output configuration ioctls:
> >       test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> >       test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> >       test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> >       test VIDIOC_G/S_EDID: OK (Not Supported)
> >
> > Control ioctls:
> >       test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> >       test VIDIOC_QUERYCTRL: OK
> >       test VIDIOC_G/S_CTRL: OK
> >       test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> >       test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> >       test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> >       Standard Controls: 3 Private Controls: 0
> >
> > Format ioctls:
> >       test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> >       test VIDIOC_G/S_PARM: OK (Not Supported)
> >       test VIDIOC_G_FBUF: OK (Not Supported)
> >       test VIDIOC_G_FMT: OK
> >       test VIDIOC_TRY_FMT: OK
> >       test VIDIOC_S_FMT: OK
> >       test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> >       test Cropping: OK (Not Supported)
> >       test Composing: OK
> >       test Scaling: OK (Not Supported)
> >
> > Codec ioctls:
> >       test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> >       test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> >       test VIDIOC_(TRY_)DECODER_CMD: OK
> >
> > Buffer ioctls:
> >       test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> >       test VIDIOC_EXPBUF: OK
> >       test Requests: OK (Not Supported)
> >
> > Total for amphion-vpu device /dev/video0: 46, Succeeded: 46, Failed:
> > 0, Warnings: 0
> >
> > # v4l2-compliance -d /dev/video1
> > v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t v4l2-compliance
> > SHA: 493af03f3c57 2021-10-08 17:23:11
> >
> > Compliance test for amphion-vpu device /dev/video1:
> >
> > Driver Info:
> >       Driver name      : amphion-vpu
> >       Card type        : amphion vpu encoder
> >       Bus info         : platform: amphion-vpu
> >       Driver version   : 5.15.0
> >       Capabilities     : 0x84204000
> >               Video Memory-to-Memory Multiplanar
> >               Streaming
> >               Extended Pix Format
> >               Device Capabilities
> >       Device Caps      : 0x04204000
> >               Video Memory-to-Memory Multiplanar
> >               Streaming
> >               Extended Pix Format
> >       Detected Stateful Encoder
> > Media Driver Info:
> >       Driver name      : amphion-vpu
> >       Model            : amphion-vpu
> >       Serial           :
> >       Bus info         : platform: amphion-vpu
> >       Media version    : 5.15.0
> >       Hardware revision: 0x00000000 (0)
> >       Driver version   : 5.15.0
> > Interface Info:
> >       ID               : 0x0300001a
> >       Type             : V4L Video
> > Entity Info:
> >       ID               : 0x0000000f (15)
> >       Name             : amphion-vpu-encoder-source
> >       Function         : V4L2 I/O
> >       Pad 0x01000010   : 0: Source
> >         Link 0x02000016: to remote pad 0x1000012 of entity
> > 'amphion-vpu-encoder-proc' (Video Encoder): Data, Enabled, Immutable
> >
> > Required ioctls:
> >       test MC information (see 'Media Driver Info' above): OK
> >       test VIDIOC_QUERYCAP: OK
> >       test invalid ioctls: OK
> >
> > Allow for multiple opens:
> >       test second /dev/video1 open: OK
> >       test VIDIOC_QUERYCAP: OK
> >       test VIDIOC_G/S_PRIORITY: OK
> >       test for unlimited opens: OK
> >
> > Debug ioctls:
> >       test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> >       test VIDIOC_LOG_STATUS: OK (Not Supported)
> >
> > Input ioctls:
> >       test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >       test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> >       test VIDIOC_ENUMAUDIO: OK (Not Supported)
> >       test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> >       test VIDIOC_G/S_AUDIO: OK (Not Supported)
> >       Inputs: 0 Audio Inputs: 0 Tuners: 0
> >
> > Output ioctls:
> >       test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >       test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> >       test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> >       test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> >       Outputs: 0 Audio Outputs: 0 Modulators: 0
> >
> > Input/Output configuration ioctls:
> >       test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> >       test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> >       test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> >       test VIDIOC_G/S_EDID: OK (Not Supported)
> >
> > Control ioctls:
> >       test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> >       test VIDIOC_QUERYCTRL: OK
> >       test VIDIOC_G/S_CTRL: OK
> >       test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> >       test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> >       test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> >       Standard Controls: 20 Private Controls: 0
> >
> > Format ioctls:
> >       test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> >       test VIDIOC_G/S_PARM: OK
> >       test VIDIOC_G_FBUF: OK (Not Supported)
> >       test VIDIOC_G_FMT: OK
> >       test VIDIOC_TRY_FMT: OK
> >       test VIDIOC_S_FMT: OK
> >       test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> >       test Cropping: OK
> >       test Composing: OK (Not Supported)
> >       test Scaling: OK (Not Supported)
> >
> > Codec ioctls:
> >       test VIDIOC_(TRY_)ENCODER_CMD: OK
> >       test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> >       test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> >
> > Buffer ioctls:
> >       test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> >       test VIDIOC_EXPBUF: OK
> >       test Requests: OK (Not Supported)
> >
> > Total for amphion-vpu device /dev/video1: 46, Succeeded: 46, Failed:
> > 0, Warnings: 0
> >
> > # v4l2-compliance -d /dev/media0
> > v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t v4l2-compliance
> > SHA: 493af03f3c57 2021-10-08 17:23:11
> >
> > Compliance test for amphion-vpu device /dev/media0:
> >
> > Media Driver Info:
> >       Driver name      : amphion-vpu
> >       Model            : amphion-vpu
> >       Serial           :
> >       Bus info         : platform: amphion-vpu
> >       Media version    : 5.15.0
> >       Hardware revision: 0x00000000 (0)
> >       Driver version   : 5.15.0
> >
> > Required ioctls:
> >       test MEDIA_IOC_DEVICE_INFO: OK
> >       test invalid ioctls: OK
> >
> > Allow for multiple opens:
> >       test second /dev/media0 open: OK
> >       test MEDIA_IOC_DEVICE_INFO: OK
> >       test for unlimited opens: OK
> >
> > Media Controller ioctls:
> >       test MEDIA_IOC_G_TOPOLOGY: OK
> >       Entities: 6 Interfaces: 2 Pads: 8 Links: 8
> >       test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
> >       test MEDIA_IOC_SETUP_LINK: OK
> >
> > Total for amphion-vpu device /dev/media0: 8, Succeeded: 8, Failed: 0,
> > Warnings: 0
> >
> > Ming Qian (13):
> >   dt-bindings: media: amphion: add amphion video codec bindings
> >   media: add nv12m_8l128 and nv12m_10be_8l128 video format.
> >   media: amphion: add amphion vpu device driver
> >   media: amphion: add vpu core driver
> >   media: amphion: implement vpu core communication based on mailbox
> >   media: amphion: add vpu v4l2 m2m support
> >   media: amphion: add v4l2 m2m vpu encoder stateful driver
> >   media: amphion: add v4l2 m2m vpu decoder stateful driver
> >   media: amphion: implement windsor encoder rpc interface
> >   media: amphion: implement malone decoder rpc interface
> >   arm64: dts: freescale: imx8q: add imx vpu codec entries
> >   firmware: imx: scu-pd: imx8q: add vpu mu resources
> >   MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
> >
> >  .../bindings/media/amphion,vpu.yaml           |  180 ++
> >  .../media/v4l/pixfmt-yuv-planar.rst           |   28 +-
> >  MAINTAINERS                                   |    9 +
> >  .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi |   73 +
> >  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   25 +
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   24 +
> >  arch/arm64/configs/defconfig                  |    1 +
> >  drivers/firmware/imx/scu-pd.c                 |    4 +
> >  drivers/media/platform/Kconfig                |   19 +
> >  drivers/media/platform/Makefile               |    2 +
> >  drivers/media/platform/amphion/Makefile       |   20 +
> >  drivers/media/platform/amphion/vdec.c         | 1695
> +++++++++++++++++
> >  drivers/media/platform/amphion/venc.c         | 1365 +++++++++++++
> >  drivers/media/platform/amphion/vpu.h          |  356 ++++
> >  drivers/media/platform/amphion/vpu_cmds.c     |  436 +++++
> >  drivers/media/platform/amphion/vpu_cmds.h     |   25 +
> >  drivers/media/platform/amphion/vpu_codec.h    |   68 +
> >  drivers/media/platform/amphion/vpu_color.c    |  183 ++
> >  drivers/media/platform/amphion/vpu_core.c     |  871 +++++++++
> >  drivers/media/platform/amphion/vpu_core.h     |   15 +
> >  drivers/media/platform/amphion/vpu_dbg.c      |  495 +++++
> >  drivers/media/platform/amphion/vpu_defs.h     |  187 ++
> >  drivers/media/platform/amphion/vpu_drv.c      |  260 +++
> >  drivers/media/platform/amphion/vpu_helpers.c  |  413 ++++
> >  drivers/media/platform/amphion/vpu_helpers.h  |   74 +
> >  drivers/media/platform/amphion/vpu_imx8q.c    |  271 +++
> >  drivers/media/platform/amphion/vpu_imx8q.h    |  115 ++
> >  drivers/media/platform/amphion/vpu_malone.c   | 1625
> ++++++++++++++++
> >  drivers/media/platform/amphion/vpu_malone.h   |   44 +
> >  drivers/media/platform/amphion/vpu_mbox.c     |  118 ++
> >  drivers/media/platform/amphion/vpu_mbox.h     |   16 +
> >  drivers/media/platform/amphion/vpu_msgs.c     |  385 ++++
> >  drivers/media/platform/amphion/vpu_msgs.h     |   14 +
> >  drivers/media/platform/amphion/vpu_rpc.c      |  257 +++
> >  drivers/media/platform/amphion/vpu_rpc.h      |  456 +++++
> >  drivers/media/platform/amphion/vpu_v4l2.c     |  720 +++++++
> >  drivers/media/platform/amphion/vpu_v4l2.h     |   55 +
> >  drivers/media/platform/amphion/vpu_windsor.c  | 1169 ++++++++++++
> >  drivers/media/platform/amphion/vpu_windsor.h  |   37 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          |    2 +
> >  include/uapi/linux/videodev2.h                |    2 +
> >  41 files changed, 12111 insertions(+), 3 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/media/amphion,vpu.yaml
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> >  create mode 100644 drivers/media/platform/amphion/Makefile
> >  create mode 100644 drivers/media/platform/amphion/vdec.c
> >  create mode 100644 drivers/media/platform/amphion/venc.c
> >  create mode 100644 drivers/media/platform/amphion/vpu.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_cmds.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_cmds.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_codec.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_color.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_core.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_core.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_dbg.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_defs.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_drv.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_helpers.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_helpers.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_malone.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_malone.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_mbox.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_mbox.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_msgs.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_msgs.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_rpc.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_rpc.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_windsor.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_windsor.h
> >
> >
> > base-commit: 127efdbc51fe6064336c0452ce9c910b3e107cf0
