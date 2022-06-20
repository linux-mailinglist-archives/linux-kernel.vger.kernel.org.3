Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E0551FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbiFTPIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243450AbiFTPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:08:25 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30071.outbound.protection.outlook.com [40.107.3.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152702E0AB;
        Mon, 20 Jun 2022 07:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZyG+/J3oqDssww8X3qr7ICgoNcV76lOTK4AK5QdsqeA+YFTz2CrXdA5qLZS/CQ0cCGRgNODkxUOrwOteTHtpwQSF347xGyG2THtaiM5ESyDWusKwFTiwmIuvrDu0FdQw3QpG1PQufTc8NCs9lkmEK47OYUe5bSkYWpQHFa7G26rctz1yzARoqJ78ymNmVxcySqldLDBLgRZtrL0iXJIRwkv8nMuXVZV8PdQhJ3fa1Q+yCZlWhmHsilxGuixTIE9olbPVnRu0QN+zBZmV6uHSvhXrF+7Aoi3Kmuix/RP86FtOb3AlPnK5Vzi38k4EubJxKiPrrYsEbRrtHdVd49H9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAQoZbqElIi2YIlWI3bFZUt6fZUul9KHohfD2LPFM6k=;
 b=D3/UatALSpsVlmXoCwY7pBFh/SwVMjk3O0K9tAk5YxbNqq8Q6oAvGDkS2lPRKawA1jZ+l2gkFB1SfA6x48vQkKIh7Nb+OQDFPv4chrMuU8lTFzYZh23FbvmN/kqzt29yqiC3ZAHZ1lZJl2sM+zak9rQkHKf6vkC7V2/DPLnjY2g//XbuU49fbcvnzQMN6DZHOcw8duRySljwwn7WPuxoBCaV9XxqMHsb7ScTGndu2kW3q+axQg/nEOQ515yJCLSeF0fogUCwEw2GGevvBTMw83deOPRihuhSBKAYUpnbqxpk6cv7AH1adogbRnvHZt5IJ1QFx1zl0A+T45GdL7MOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAQoZbqElIi2YIlWI3bFZUt6fZUul9KHohfD2LPFM6k=;
 b=JyM0kMfGvo/WU2kVy0Ktyvj6/IWu93H4Z6YI8mOfQwhX9uKR1FsmNFSkUyQMi3LdCOXk/rI6/++/Fz1/ZbRud9AsPEFSBac+O8TWAvC+JA/KIwcPcDVwbGBeg1nNysw7mVFxTY1Us1jQfdh+JxUHmAf7jyt5W7H+SZLN31uMYk81xGZA7vn0NGVydo2c9L6JNPWn/v0qCee/XXTso4bdMXZyK7vH2MxuTasY8hrpmlXDHpsgqqZIGf6ojsdaStFrGAYZwSoTWaS8z8vxRlmREnfaxKBSftgioUmWLqvlc6LZSS9q/WZrQgATFmayevaHQwdicIJ1yvXFS1GGdOrGLw==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by DB9PR08MB7675.eurprd08.prod.outlook.com (2603:10a6:10:37e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 14:49:51 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 14:49:51 +0000
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
Subject: Re: [PATCH 4/4] ASoC: wm8904: add DMIC support
Thread-Topic: [PATCH 4/4] ASoC: wm8904: add DMIC support
Thread-Index: AQHYhLRfHAn3pSWu3UKlkdl4F6FB6A==
Date:   Mon, 20 Jun 2022 14:49:51 +0000
Message-ID: <AM6PR08MB437614D88A0F44746C2B88BAFFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 05ececfe-e684-2840-58e2-2098ad3eddff
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac63fcf-4229-42b6-acd3-08da52cc2168
x-ms-traffictypediagnostic: DB9PR08MB7675:EE_
x-microsoft-antispam-prvs: <DB9PR08MB7675CB6DE780BC9B7B9D8336FFB09@DB9PR08MB7675.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2q+PPto1aSgNSrieo4sdsRBniWzHg/HqK0nj5Hz98ue0A1YZuxksF9ExyFay76j06ckbKg0vMUFIIR19EXSNA30n1GK9tmS31NrTjprea6qGe3bgDFTGzkVCixlYivsASaSJYdUlvSm6djdpEWsXqpGC6nXm7h84sSkILu9gaIG1nve9LkEsBv5uPaqPKQjT89Wwoq34Ua+pVIjhdWv5LJTk1LCBim31ZsYcVT+WpuWBh9PRvlS7B2juAcACsUesryyd6ECzSbt7PB8xUjJ3hlXdnfiZ5+BekVlatlEbH3J+VmJk6kXKbkiSUz9VXCqTFPaMxxZ9xKT4sc9cYLk3/DnyFI7A6ikXt+tX6Xvb+JfWX8jTCagP6+OvUQEhWIYtq68vqvsCzX9NbUl15N6RQjYvZELUMC37uQSSSHcNnaS4a8YbkH9zYvqz1GFm/mKjKBIlbrv/Ezd3FIDXsM76jJUYMhogfXY1IXbB6OF9Xt+v0xZiJ7mbPrf4ixnLLs/c8TD+AQAbluePvT+GmruQlawBFIJxbljtZ0yGZc3W6q2CPjZ7tANDNdggfYviiERnhcsVJaKoFDWkqD/wTVwX0K3RU/UhGseGFncA/+sdxmTiPg0H+EUgbODg9i8WLK4ZB1HVEPjGX32p+aUjj1CcH7i7JclsUWj2VMd9yML1zJQQad29afbBsixWSVlvbnUm4qtLCpzrmiu2NxSoVwakgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(39850400004)(66446008)(64756008)(71200400001)(38070700005)(66476007)(4326008)(186003)(41300700001)(76116006)(66946007)(6506007)(7416002)(66556008)(122000001)(2906002)(110136005)(8676002)(91956017)(55016003)(508600001)(7696005)(33656002)(54906003)(316002)(8936002)(6636002)(5660300002)(4744005)(9686003)(26005)(86362001)(52536014)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lrsSf2u7pRweDMpcirfaBIXYaKYXiIqZRjWMkmBeDK+2bQzuqM6wAJCniy?=
 =?iso-8859-1?Q?Q/7n8F4OrIka/Lqe+IPDY/IHFLTSNpfQmfam2KKPgT9q4oEfqIReb6WNOS?=
 =?iso-8859-1?Q?yPJcUGQyMdWtrjzs9cnf6a5A3xj/nbbW4Od+bX+WCcdh19/TrxQrjEIH3Y?=
 =?iso-8859-1?Q?gfN7D/aBf5ngJ2J0pxpSjlFD62prEEMp18QCrkxbbpVqb7v7anhRMWiDVn?=
 =?iso-8859-1?Q?aNk6ybcgCLmcqXXhpDvcvAk+0iiCxVoOhlgfaMqUKQ+cPn6ZPt7ePPtdx/?=
 =?iso-8859-1?Q?HUOmwCcmk3NbAdOKuwTRkj5MY2D6gnPuSBK7WXutkfiEoByA5Xyo0jpF60?=
 =?iso-8859-1?Q?9Pdg2TIC9CvdYtS6cWmz2ds9DvKU0X4iO/Cp+ecbCz4tencBJupEfZgYsq?=
 =?iso-8859-1?Q?bOkJMhj4Csw/UMQw34qvq2Pel2b7RJFheNiqFj26FtaAR2VrmSgiq5bYkv?=
 =?iso-8859-1?Q?5HWLmx9P5UgsrPMqjIV9aE94Zn5xRPHxjvGtyqaGsoPJE1Bguu8ZpRpnqx?=
 =?iso-8859-1?Q?brvsmA1Glt+6+qBFVWKb3BSljOKtq3BxKIZVVSHRwtOJJ7oWATanZCIIcE?=
 =?iso-8859-1?Q?FBKy5Cx1hmIoLbTufoO/TaDK/aBrihRjLPrVthCyxOnVsn7vV7b6nrLozK?=
 =?iso-8859-1?Q?TTrjmZnSZ2Tz2HLs2v7m8WU/PtZjMy+/Xze54PKwyDtPEXGwl5W7x4hiy+?=
 =?iso-8859-1?Q?f4IXT33pQ9IgYiBkESCg4wcLW5wTC5iprupUDWK6TimBzdZgXmoeyiWlK8?=
 =?iso-8859-1?Q?IDsJV7oTn3Z7PMPwL2XNc1+qHBvPnObjXFRpZxenkz6isLD8MRCsZzt5+q?=
 =?iso-8859-1?Q?fcBLf1zAgm1ASykDW9RmlhqkRXcVqQdifRlkDXm3GQ2aP1yFsHl2jiEBUr?=
 =?iso-8859-1?Q?wgcv5lKqodwUEBAAsCiOv6wobjCiSUXX8O0FevjwaXkW1agZalGzREm3KK?=
 =?iso-8859-1?Q?dlPwsnQoE1YDAzz1nttlJk4F73kKCPPkDxjiDKjY2Kd4qwCmYSaCb5Kypx?=
 =?iso-8859-1?Q?4A0+Lln1gjxg/+OPYvXICselaDF8l41Ya+8Rkq14LisQ+OYqDcIWloyBwS?=
 =?iso-8859-1?Q?hvXwOJjAnWUqq52jw8fPbl9LQDvbpQE9185c4p8PjsBwkDNEWrhMyNzUJk?=
 =?iso-8859-1?Q?z5Sz8jQq08FBFuEUJfw/N8i3MYl8ngNvJknfESLJQr8+fhM6YAUEYsjP5+?=
 =?iso-8859-1?Q?cuD1QGwjld870WKwEHSnvSfuUisXoYduANiEl/wHcDkHbvKVA0oz6P4pzA?=
 =?iso-8859-1?Q?fTh2Qg0d9h1tx88Uukui5GnYRM3y7j1uretMnsPTxPGG0pHIlwt85e5PAR?=
 =?iso-8859-1?Q?CL6FRv79n72BNAuPw+BBA7BzMlGj9eITmCKIuP/4vER77l4Z4egQSOQKIc?=
 =?iso-8859-1?Q?kLT7lYRyeYGi6dscbgaABfF99iGlQ1NqnpnI3YMxE4AwzeBo98RSGzK5v4?=
 =?iso-8859-1?Q?gdV35hbgiNgXi8Fo/MKclnDv2wkaG4jotq1NhIvvrvSOpHGLAdItaHkvFm?=
 =?iso-8859-1?Q?XxmzlhmgQhvFzfBALBPfn8EKezLlR/XU1joxLlP3RvdIANf/M5WPZWv4N8?=
 =?iso-8859-1?Q?f8/BSXIIQNxBPSX46Qy1W9UFsPl5jjeY+Hw6qb55l9LRmKEQiakSin3p2a?=
 =?iso-8859-1?Q?iKmev9sdWYKzPLLpjDdc3WPgP9wR45kWgWz3LSbObZ/rLzV+9bwQLQOdU5?=
 =?iso-8859-1?Q?PCKnpmURjy6OUhJwaJF8BEu3Izx2RB4jmmjTQ2Ch8hSUoaqNM1SLTnVWqk?=
 =?iso-8859-1?Q?vknnU+orc94zocKWw1xTfmoDfTeonjWSWgIeZqN70LGsjRzXOmF0jWv2xu?=
 =?iso-8859-1?Q?9JjtzJ5XYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac63fcf-4229-42b6-acd3-08da52cc2168
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 14:49:51.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqhdQIgNYBiDvZSH2ZBBCZXRxaQ+JfpLuMFaSdTfXrPxoezkaC3BivjKFa1j+ViBBqgPou6G0OuvhhCp0UeKHUuX/yMPCLCSZdoeX40nusw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7675
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
> > +static const char *cin_text[] =3D {=0A=
> > +=A0=A0=A0=A0 "ADC", "DMIC"=0A=
> > +};=0A=
> > +=0A=
> > +static SOC_ENUM_SINGLE_DECL(cin_enum,=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 WM8904_DIGITAL_MICROPHONE_0, 12, cin_text);=0A=
> =0A=
> Why would this be runtime selectable?=A0 I'd expect the decision to use=
=0A=
> an analogue or digital microphone to be made in the hardware design.=0A=
=0A=
I agree that dedicated HW is required, but currently SW side there's no sup=
port at all.=0A=
This patch is aiming to provide a way to enable DMIC on boards using it.=0A=
Is this supposed to be managed in a different way ?=0A=
=0A=
Thanks=0A=
Best Regards=0A=
Pier=
