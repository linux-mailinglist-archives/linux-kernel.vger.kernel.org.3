Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B609D587E5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiHBOtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHBOs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:48:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2128.outbound.protection.outlook.com [40.107.113.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEBA1EED0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxNP/txF+6i7pF5m60otONtfeRVx+Q1BUkO4jp/aWlXm+5YTdUShCRN29eeHJRWILfJDFh5P/sdxejP5c56b7Wr6Yp9pgVsOFsQSGIchk+4Az34uAADEJuPgleJbNC+59tOgygO3Gby0PoyRMC1nWmNFKQFLPO3vaPpNalFM55dXZoErnoY1S0sM0TIU5IxftJZM32Y2hudv2y/OH9wxk66VK8/AqHGf7lygElpo9zGttmAoAh4s+XxiRSw3HBn0EKbJSHUWqx28g+id6+YOZV7shShP9VCNrA7DciyBfqPskT16m/O3nQtqeMCyB2aQHORvXZcnNJ+BQ/EcLIPO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgcUNTv8NNu1Wp4c9UKLrflZkZxMJ71RdoyvG1xgjyQ=;
 b=KLed82jYweQ4B/6ffWppAKf4z+0LM6qFSyAQZwNlkDgE9ZFO3m2P7rR0vtmQ0XntIh8n89VV/gd+qKZUxUnHQ0bqRtPrVDew3tCfCuVYzijllwjCCKFyKKNKWpUlnDpH8LxUgWOlNkXB5gMEeNC//aDQNbFgP976VF20xgKnz3MMPrp21wBkL+sehHKdPJ11bDeUkG9wivAhDFMEvr785d0mX/kKbe+apvpwJOeS5i4xrzgPDsnyyFkyfM89pjgl9a59wVsH7CNcwNKfTg6eoqhkfjhGhTJrjNGaUtdceZrBhApYNDQtffELQPi1uKKzh89JJljIVuDQt9cachorcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgcUNTv8NNu1Wp4c9UKLrflZkZxMJ71RdoyvG1xgjyQ=;
 b=PsrsvWG0VxDhREePo7gR/E/qDmfit/1fJ/digiFSTFE/G0tNf9lzqa3gAobjfgaHvAk0R5oNcUIwzeCeHd11rKm0E4Grc/UyebjiEOXR4uqmcAM1X/as2gyUwlDuCVfqoSuEOHyWlM414xVuHo1YgW9GUVXvUqGiR+Pk6sVRX1g=
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17)
 by TYWPR01MB10259.jpnprd01.prod.outlook.com (2603:1096:400:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 14:48:53 +0000
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05]) by OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05%7]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 14:48:53 +0000
From:   DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
To:     DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>
Subject: RE: [PATCH] MAINTAINERS: Update Dialog Semiconductor mailing list,
 website
Thread-Topic: [PATCH] MAINTAINERS: Update Dialog Semiconductor mailing list,
 website
Thread-Index: AQHYpZYYkopTX/ODm0m6gaAsd7CCL62Z5ncAgAAOanCAAbLBAA==
Date:   Tue, 2 Aug 2022 14:48:53 +0000
Message-ID: <OSAPR01MB50603BB921C01B643D336877B09D9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
References: <20220801110140.7DF6280007F@slsrvapps-01.diasemi.com>
 <Yue3LpR7FdHygLze@kroah.com>
 <OSAPR01MB506015B38A0A9DC6BE90F7A3B09A9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB506015B38A0A9DC6BE90F7A3B09A9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e4f54c5-a91f-421c-bfb8-08da74961e7b
x-ms-traffictypediagnostic: TYWPR01MB10259:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkn/+ESQo0P56ICiivZBag45l0Bf8mJ5JsH8tQHxGpJD7j/91Il2lGFzFNsX8hwoSgMxp8jDXgsT9fpSLAP2WtD+NXNmqEyUSbws1l3RzSsXbw6hofIOVylzXmkvpnZuToBH701wN1qzR2+vfJuhyO+nmHO1cuUVRQqy0NBzKpauFC+GdV9Y1SFVq0Az5LRoTxFXtWSp7rx5ICvup1KKQ3F7QG/7ue2xF4QrcVMLtOQbTRUj3cOHKGt/pE4dHybGRY73uk5n6eqrpEgSz16Q7MGtDmqCG7gGQDcfmNeZPxYcgLA11OscMuhW0f7GLXvVCOUBhxTwKvRNHDtNZvAQchm1lzrEUFA8Qo3Qt36geyj0faGVr34cxuNErWNH6LSyKDqbFY454v7P9BdWwo9RZRyqd22GjDt9bA2EqG+YCR0M4Cj27FlQHjjmiY9crx+JnDh4UIykwrnvOYaMaMNSlINS8PwwF7IOKat85/CN0pM68inD/YEJrHuQQlC5YGmHOtVZkNDix9HIgQMBO1X2L6jTbTuj+thAojh6pTWVZwnH+8wVLiHaSlsgDvpQB8lYe82bbVpAp6JEsTrk8trSUH70zUO6aWSatljrH4QYR5UskBVJdUVDdJS2WOBC6OhZTN1sAfvHZ+rpPjdLENnKSwaLeND+z4/g07Fe+t8eeqwqWmZcf5UMRM5T0wxWwEWWzMUHa8B4ENBrEsCYXmfRAIk6wg4U8qA4polOajCze5lMtudqlq3OCtONDWdGbIHGUWVVZHqCTyHEej3Umm55IvRSN3w6N+cS9GsozC207T2+p4iKyIWJD47TUN9fWqZp2s8VYev0oDargs1soA+vr3egCaADP3HbO2aj6VoKfoI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB5060.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(33656002)(5660300002)(86362001)(316002)(64756008)(71200400001)(66946007)(76116006)(66556008)(8936002)(8676002)(66476007)(4326008)(52536014)(54906003)(110136005)(38070700005)(55016003)(26005)(9686003)(107886003)(66446008)(186003)(53546011)(38100700002)(478600001)(83380400001)(122000001)(6506007)(41300700001)(2906002)(7696005)(15650500001)(223123001)(130980200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uzuVGvk+th+qVDuizHaWpS+qD/QDLJQ70nF1v6Vw0jCbDfCioVl65Mp/XZvQ?=
 =?us-ascii?Q?SKPaKPd06twROrfdnXcuvIelJXtwD5nvwn7f0NaUw8SdfViOxjuLjwm8Qg1z?=
 =?us-ascii?Q?LNYIfm4Vtf7Y3CvuLQCIa0gJpC7xG7eTReWGnGzf2J48c+6i19Qe5IgMHdxf?=
 =?us-ascii?Q?saRkOVCcgRd/IUWyYfJsmvbmt/IjGhHEXL67k17c79WEvKVMtJUHUjsGPrdS?=
 =?us-ascii?Q?8iyGKzPltVUmo/vs63hvcJFSPp7UJcap9t1XXkdUag9mBdigXJ1OVM2nnt/r?=
 =?us-ascii?Q?kfUTiniagzTmQWsxhGFHAqwo0KYT3e/os8IQtOKjXzxxb5r4Fe3RTS412fyT?=
 =?us-ascii?Q?zUqMC9dKOAQaPF75LbVXOBWvgB7HhdlZWWbcDmEMXmi6uBJy59J9Mkh2M44i?=
 =?us-ascii?Q?0y94Z4tqpzMOZL7NEzWzZ1v9n3Xuj/uAcddzWZN3pjieHzHjWablTsyLmld/?=
 =?us-ascii?Q?fx6Ry7IVkUDtrOW/pAHARlrZT7ww90WO4DeXlGu4SlF/HFfIppgcgaMHtaWu?=
 =?us-ascii?Q?lwiIu2SQRRiXCeoq4ANQ6e3M4+xzcWQwVmA7LYcvn1l3xRhWuZ0/a5YaGRyd?=
 =?us-ascii?Q?HRyb92GK4CegVh0zGyTUg+BbGTzBvqMrXc8BZKF7oUGA1qus2CwSxzhBQgyV?=
 =?us-ascii?Q?BgPIDp4zHsHLjbkhzfGMhqIRUnTx8iS5FH+QpfzQyj7RbPjvvQeczcJnrNyp?=
 =?us-ascii?Q?FXF8p8fVmAEw98rLLAzZN9CTz/5PLpA4OYCT6gUkPGEM9hjoZpbV9XumRL03?=
 =?us-ascii?Q?OA9Ffcao69xAxl7fqjdAph5hHFUaprCm1mrAGJZdaPH4W667faESMelL71En?=
 =?us-ascii?Q?WWRrj8MMsxoepV2G9TeGF9/xzncBtl0y8wWaYeCQol424dJ+7Lt6BHB3A0bn?=
 =?us-ascii?Q?svMPMfFoSxLLfVj6UL7nrfa57mck2p348YnmOGIcvhpg0XuWzrYp980mgXLj?=
 =?us-ascii?Q?R1WlgAehGxtyH74OGTGmQuJPYL+DN09w/Tu5fCrATOMCQ7mmHZLI9pRnLalk?=
 =?us-ascii?Q?IVTe2gIMNE9JSQuScu0PymImhOtGEOG+KYCZGeRF88dTBOB3LB4LVbWHH1lW?=
 =?us-ascii?Q?ZZcJQYwGN9u5O7w4HVxlVAB3LF8p6PmD4eiU8f0s7b1gxwn7fpMBs7Ht+poS?=
 =?us-ascii?Q?ImfkC3DJD72RisI1vbdnSBZOdqb+WCDQujeJv14f4c66L6LpdBGbogmwyma+?=
 =?us-ascii?Q?6VqdHBpzS2r8YsXrwYMEwOxgoj91il81XOPKodVVg2mAz9NNo1kxzP+0XIhT?=
 =?us-ascii?Q?zK/yxBZaut+Tf5frkf3334WSv6qx8o5CY6KKUYwMvoxX+J1+TlRxccDFFvpi?=
 =?us-ascii?Q?CJJTJXhLw8vRaBIbdHN/GX9CwDXDPVWtJ6VZw4uLzJCEe3Y6CNC/EU1p2rvD?=
 =?us-ascii?Q?cYxiBMZx7PDj/qgpnUjIzQcz/wKM/NViveaSan8BSTWLRECHFxujMuYL0rAb?=
 =?us-ascii?Q?r/82ARWjta8mvYbPRDTr4ynnHKwMAmx01HU+GyGF7g9Reqo/ZTtAX2rP6nBo?=
 =?us-ascii?Q?5yc7C2aPaF1QWFcZi5BYYiTb36+57s2SNahm4NIMw13tkwbViNTMxxl4OxJ/?=
 =?us-ascii?Q?NTpgJTKo8+XeF2ZnXuxMY/cPFRdazz53Bu/nBW2QnayF8FhefZfpLuvTNObY?=
 =?us-ascii?Q?zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB5060.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4f54c5-a91f-421c-bfb8-08da74961e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 14:48:53.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5R251f78LlLrVqFxQkCMoEfvJ5dFOxe+3xV0QgdzLyZcbA9mg5M938NM7v4xlOFXk9OdPzTekQm8t304DpB7Xvml1EKs8K5ahDkUpUeuZVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10259
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 August 2022 13:23, Greg Kroah-Hartman wrote:

> On Mon, Aug 01, 2022 at 12:13:25PM +0000, DLG Adam Thomson wrote:
> > On 01 August 2022 12:21, Greg Kroah-Hartman wrote:
> >
> > > >  DIALOG SEMICONDUCTOR DRIVERS
> > > > -M:	Support Opensource <support.opensource@diasemi.com>
> > > > +M:	DLG Support Opensource <DLG-
> Support.Opensource@lm.renesas.com>
> > >
> > > I strongly discourage any anonymous "group alias" for maintainers of =
any
> > > kernel code, as that takes away the personal responsibility from the
> > > maintainer entirely, which defeats one of the strongest reasons that
> > > open source development efforts work so well.
> > >
> > > Why not just switch this over to you instead?
> >
> > Appreciate the input. I will no longer be part of Renesas as of the end=
 of this
> > week, so wanted to update the mailing list address before I leave. The =
actual
> > mailing list itself hasn't changed in terms of the people on it, aside =
from
> > myself dropping off of course.
>
> Then why not just list the people on that list?  That would be easiest,
> right?

Well the people on the list are historical and with Dialog now part of Rene=
sas
it's possible responsibilities will need to be re-aligned. Honestly, that's=
 out
of my scope of knowledge at this point. My aim was simply to prevent the
existing mailing address from lapsing and removing any opportunity for supp=
ort.

However, I think I'll have to defer this task to other colleagues as the
decision making will ultimately not be mine. Thanks again for your input.
