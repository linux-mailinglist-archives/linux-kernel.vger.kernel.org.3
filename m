Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16329551FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbiFTPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbiFTPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:02:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715951FCE9;
        Mon, 20 Jun 2022 07:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTEsmLPgihuUsLZVTFLObx8kwj4G9STUhEB+V0+O+myAj/T+OMDrHREfTdX2pMbPGHVIEBgGbHtQFjwHqKZXcCPBZ5NV44UcwR8lvsFNLxKv1MvKLfh6c6vbOySC/lOudczcFRbE2OQ95+Bz+Mm1fg89agILFIpqccs1YYID0skoQi/fo1nDAsTItTGQgHBh0jCPxA9fp125artwMeOaZ701uoOeB8DyTEbwFCztW0Lyt+nx+Ks0L27a/rkP54bx1aDDaGEhvYBiFKperuRNA1cQtiaVRr9FJjHZhxZOSNPn5kfTGd1j9odNkcKSsWobwW7xT1wB17aE2jikhzrQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ev+53EHif0GDgU/tSy8UTA0Zk1cnBPLG/jA8N3B7GE=;
 b=K5aSjiaylzJdzJvL32azQeTY7/S8+1+dc8xqge4bcXtPqDDestsZWNMZt0AW7vc5eh5nTItUh6QQiv61wwWqyToXMfoBnvt7Ri1ngS0m75aPX5HMGUy5dMP+LeZDqHXCKRBamzbDNpM9TR8KlZCjBsvcj6qNBcCGAzGXQzrtn7SaJgg5E8CYgfRHR+dbs7C7SD1Dqu7AOUj4M8Z0u7ljFwGwdANo21Mr9W1O39FBOHWQ5/aTITWwYZ/rzRfQneWZfzCwsEnBidFkmbKRX4Y0P3nfKE63Z0kiRFLhmmxkjrYAd9ZiSUgh2vkNDXdT5UqxyJvN4bJM4r4DAMy/YH4dCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ev+53EHif0GDgU/tSy8UTA0Zk1cnBPLG/jA8N3B7GE=;
 b=ag0lniH4Z/zLMwnlq0y19kmvsoBa+hXbzPPCmiQM2L4/xMvoeKJiI8dZf8uc7Zx35Fk+4atKR+vkaaVfoJne6+D1D+IiYLI/iByvNC6viHX7v5hBfZnD2WLKR8RYAaAQ9fpgHnmo0LhOPd1eI1k6PxJSEsctKTgsVYzEqMTN8sQnh63EJCNn+6frvqL99DSNq2AZkhH6kjGpaQSwzVBCw1/doqTv1v0IoQisAICgIcNKfHMlIZWmU3qdnJ/P0/1gNyo+0qEYDe+AVK0IKObeIm7FJr3bX5ufmWwiDp1SBvTRrS9DfyU6hx7JCgZbRcqG7B6X08PYh9oUClMr1S1cyw==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM0PR08MB5538.eurprd08.prod.outlook.com (2603:10a6:208:13b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Mon, 20 Jun
 2022 14:32:17 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 14:32:17 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Mark Brown <broonie@kernel.org>,
        Alifer Willians de Moraes <alifer.m@variscite.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH 3/4] ASoC: wm8904: extend device tree support
Thread-Topic: [PATCH 3/4] ASoC: wm8904: extend device tree support
Thread-Index: AQHYhLGIoQS3kCENdEyOs9B4L1UGig==
Date:   Mon, 20 Jun 2022 14:32:17 +0000
Message-ID: <AM6PR08MB437675AD04D20721769B08A3FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 858432e5-9aa9-032c-ad67-a21e9f3881a9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 569e5a4c-642e-4ab9-5d54-08da52c9ad6a
x-ms-traffictypediagnostic: AM0PR08MB5538:EE_
x-microsoft-antispam-prvs: <AM0PR08MB5538D56FB692FA3F7E07738FFFB09@AM0PR08MB5538.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nzAE7AG1mYrzfOJX9I/cVcB2ccjNZwptdatpy1sGGpL4tNKSJ56lBHy+aUf+3NEu+IufdHee7wa8ElLA7QVuoKtsudCp1L3x+VxnB6sQpIowHrtWgV7DElZQKt9NFnDDIrLG6j4UuP2j9en122cdfcwmAzEwzKbpzRaEXPC7zTS4bMpMpBXID4z+2L96MeJKWjODz8dBPzF/8a+77ahfbtu1QXOBVmfdUz7uwbXOxVdyBle6qrBYc8IQkbF5Yk2gaHOjVf76Ndz7lHFXe0YLbpe9m1/alw9WFTBoD40zeKkN260HgaT5gD0bNUGxjIqL04LB9+zfrTBnzMNPJA7tBHhRgiSSv2QAZ/w76Nv3mcVDBjtB9+Ud3ZHQ91anDClRzBorUcFnpsjI0gO15c+oBflOS8Qd40nt9P54LKj0Fk0ASQbLu6PvFwJ5BFZBs0exYBMc6vlr+aYvpetiulhxsp3J8+szVuP0eOfDGAodfPRzbF0jkL+GPj65B4h72VDbIeIaWGfWt9Add9TU8F+fDevtPSeB4xyTMT+DGVoFHxJMovpEudwPc5LK/MjYGMW/2/NNQWldIndsFe2IMt9r7yV/SXkjiU/etivW/UAt72mjZms0S15Aach/I0GzmL+mYtmKxM6LYDdQN0EDUmBH/CdQLZGLTovR7PxGrHJd4kofMc13uSVW/9Uz1BW0B0npEzNu+s9yvERFdPW454dGQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39850400004)(376002)(396003)(366004)(38070700005)(8936002)(122000001)(4744005)(5660300002)(52536014)(7416002)(110136005)(478600001)(54906003)(6636002)(71200400001)(66946007)(316002)(91956017)(64756008)(66556008)(76116006)(8676002)(4326008)(66446008)(66476007)(86362001)(9686003)(33656002)(186003)(83380400001)(26005)(41300700001)(2906002)(7696005)(38100700002)(6506007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5so5CDazotfq0TlzmC5it398+hkwckX63MQ0NPhWRLgbQsj959JS2jm5rV?=
 =?iso-8859-1?Q?afBUw56DAcVWxb9bXjFd/GO6ZDvD8vpw28AEPp5ekrbomd3GudJsw1q0zU?=
 =?iso-8859-1?Q?w3btL/cXx4+r299b5d+kRhAMcdi/dz0p/a5JTi+3sB87hJe+e6gz1CMPV7?=
 =?iso-8859-1?Q?a3EDby0uwsyxXx29BYBvoJKyNlzXtfxm99umfFIoxzdaPL3Eo+x0w6oq41?=
 =?iso-8859-1?Q?oRQfzgEwtHwoMQz8W+zgp5x4ZWBgk1t97Zeh9h3xMpBBjKIltwdSIXpN9T?=
 =?iso-8859-1?Q?j43fDl5Kn3o9hro2zn9raLxffvIJZyqlcsqH6fz+/cIgTbTq673ILYOBta?=
 =?iso-8859-1?Q?JpWgm5j/vaMBYmSswn75FMzIpOPZ6SSAaWdAY23awlIVqHMJawgsjlT+B+?=
 =?iso-8859-1?Q?11KIRrylSFz3jzxMTwTlZDnXNHqJG2VcH1ILIT6Ev8CWglJvPbeGdE6R7X?=
 =?iso-8859-1?Q?rBacHjkC0KFcIXDb9VQDBRFvWaVgC7cg9nVkbKBzX8zmMpObpJ3CmmCeR4?=
 =?iso-8859-1?Q?Surb7cHnnW0TsEstLcos52r0bEEY4QmBAvlI0gTon9+zZlVRIm/EoF2ta0?=
 =?iso-8859-1?Q?f4RM1Os9ape4UWp/fkAc5u8W6JSyvGrZRvYOH+sza/0jljbb+7NPjVfdML?=
 =?iso-8859-1?Q?vtzWomfQyWztHsFzZdGxa7psElxHEWlS6vsAUGy2hhAG/3a/+VNqtHq8On?=
 =?iso-8859-1?Q?TadkAfRR4yGO+tvJSdh6fq/illkMRwS3+NtW5VQRpUAM4yi4fhISbEt/62?=
 =?iso-8859-1?Q?2GvJ6C2ylA+aHyX0lirW7gj450i0lG6A7XXbTKB8S4bKFWvzf3PrhRmuud?=
 =?iso-8859-1?Q?vSLbEE8CsPVaVhBbu6kqul3DOA1MG6u2hSUac3LMhFA4MNFN7esdeXc4HA?=
 =?iso-8859-1?Q?KGBHlNO4j+IE2bunKoRxuvD04rTo+Nje0KOs3KTKiO5/mc8lrxr9QtwHix?=
 =?iso-8859-1?Q?tzUP5SqSefcel7Mfh35/bcGoyJjoc8pJUl5SQuA+o/lFwtJcajvFEpzQyc?=
 =?iso-8859-1?Q?PaCH3L8UlXvzFf9RHZz87kjszHz5lJfTPhAH/2AWAl/oLq/cglKljZa3EZ?=
 =?iso-8859-1?Q?hTXyEFeNIh4l4UJR69k7z6sX3tWUXpG5iYI1WWObnyZWx1MyKbjTyyQ75P?=
 =?iso-8859-1?Q?02hhUufMW0fh3IFvXeLO+CBvrpA4H/mV+gyjKR7y2a7e3a8lRN2vUgmRay?=
 =?iso-8859-1?Q?7PmrGXzQVNIsGt3XwXB5Jp+vA6qkZP/SBTpMnCaPJ1DiVghY1nF/KViH5Q?=
 =?iso-8859-1?Q?rXFMP1vI6J59hTWc9QGYayjK4KRGnAOsNUT1LWHaBhvhXn4M5WpUxuwot0?=
 =?iso-8859-1?Q?43DQssifAzLZ9OE3Gm4HdEkr5pHjYYx6RZXijwnPsHivXpRinJOvimXP5C?=
 =?iso-8859-1?Q?ti0IqD02e5EHGxUjhA7p50nCzUMySlHtRyZjUWsXJX0lr4HnkwFBTxUoDA?=
 =?iso-8859-1?Q?PGAllPmgKGdVk7j+fn++bVpyZTomWz9UdIbya6gujYF/xtUHymsR5+7AEE?=
 =?iso-8859-1?Q?9z+e9EcRgEtVUVeLVVPBYp0ZSUCF4Xb9CBtHHVhrR7xNEUZV3Vs6GMS2AW?=
 =?iso-8859-1?Q?TlcDntZzTmQTv5gmaXiDgxpQu80iPgMT8mUQJBRhpFUple6ATPh7s5WiPa?=
 =?iso-8859-1?Q?q8BmAFogvUwxMgiF8fDlrjEFuRbu8NiGjGcUQ9nGcKgo4SIcmTr/tfHVjq?=
 =?iso-8859-1?Q?sAkRKpdqEFq3PUSbaZt//I+LEU1C/lntwmysc20zoKLgsvJOdxODkviQaS?=
 =?iso-8859-1?Q?ZdYuWn13wIUyJqZi9BoHmnfznAwVYQAUDoVrRVqSq0doVlJ8XuBb+cya9f?=
 =?iso-8859-1?Q?1oMiJC6K9A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569e5a4c-642e-4ab9-5d54-08da52c9ad6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 14:32:17.7367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsivCYWxqESGag1Op9osSRczmot/3lnF4nxUCPetX0huNfj5AD5tqRwxsoQ5JP4ieNODIhGkicsnUap8HYnIR9LJNIqOFrqpwGMWCFXK2Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,=0A=
=0A=
> > +=A0 - num-drc-cfgs: Number of available DRC modes from drc-cfg-regs pr=
operty=0A=
> > +=0A=
> > +=A0 - drc-cfg-regs: Default registers value for R40/41/42/43 (DRC)=0A=
> > +=A0=A0=A0 The list must be (4 x num-drc-cfgs) entries long.=0A=
> > +=A0=A0=A0 If absent or incomplete, DRC is disabled.=0A=
> =0A=
> What is the purpose of having num-drc-cfgs?=A0 We can tell how large=0A=
> drc-cfg-regs is so it just seems redundant.=0A=
=0A=
Can you please point me to any reference implementation doing this ?=0A=
=0A=
> > +=A0 - num-retune-mobile-cfgs: Number of retune modes available from=0A=
> > +=A0=A0=A0 retune-mobile-cfg-regs property=0A=
> =0A=
> Same here.=0A=
=0A=
Thanks=0A=
Best Regards=0A=
Pier=
