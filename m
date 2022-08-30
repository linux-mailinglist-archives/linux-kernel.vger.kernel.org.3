Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E295A600E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiH3KBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiH3KAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:00:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A7AE2C62;
        Tue, 30 Aug 2022 02:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1KFzZiaC0Ix8j14TvoKlhi1ZFiLROkeCzpL6MzHrSDLIMKO0He+JCyrPAQUu+kmttDqyKrpCCVzK9sh7ldUewPYmt5Rym+mI35fO7AImODLaDb4F0DswneNGkV7vdmYiblY2ytmCcE3Imqg0exC2oUpJk8/ULgOizeDDwXh4iLWGjKcrKUemcyd8blbx9H+vB4HVmk9UrQUs7QPOwck59565pr3iU/WbmMFGPKJAKyX5Kq7ttJlt590bPjwwSkAJ9L8KpQgDKD/7uuZpCIfjbH0e9V5ueHDaJd0qvG6WH5IvmmmLO+1fiYqqN64I1EZWaLqbYTQ+dQhpOLXTux0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpewygHkzfmK2aR880BaKlK/yKn4xMv5vlKLKVkJ++M=;
 b=BmU9nnqgB7AgbE21tZND8H04MSQ6G68NQaoevn1olRgNkirgIRwUmEt04fZ4lJ+Gln8WkRSunFE0rFgqMCvOA/O56/S6Yulu2gIgCV9OMxAb372p5tmo5ODfOpRqR1Jk+lICpbeaV/ozPs6NibibDpYRTHe36Ma3CVOG4g74ONBnmJ0duBLprDPLiCRYPSGSHfuItkKRHeqdUXiWIUDpqFTC0CRQ44RHImttdbYKhH8rUqZTNBj/0Z90B0YU4GY8t4302gXRTQvLBg+7j1flEOVqt/HzhYqVCtUxXD6RfSpI1/+gitxEMw41hgH0nTrpaRAAXsAGDOxWaPkIcAeR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpewygHkzfmK2aR880BaKlK/yKn4xMv5vlKLKVkJ++M=;
 b=UtoAyEBw7g0jUVx2fVgMcuCJoZ+IFBKpEYNkEQ34f4n5cKRG3Au2bA4CUqz7ASCm878XcerywGB2sw/WJwGBvwD38LETsHrD6MaALtUNmFCTiaKE8i+dHx7y26QPTFDlxyqvxwMUHloS+09igSUIPsEgNSNLHLdgX4U6j/9tZKo=
Received: from PH0PR03MB5848.namprd03.prod.outlook.com (2603:10b6:510:30::19)
 by MN2PR03MB4991.namprd03.prod.outlook.com (2603:10b6:208:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 09:59:26 +0000
Received: from PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::a894:97da:c3cc:6274]) by PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::a894:97da:c3cc:6274%3]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 09:59:26 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        Wayne Chang <wayne.chang@tw.synaptics.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Kevin Chu <kevin.chu@tw.synaptics.com>,
        Derek Cheng <derek.cheng@tw.synaptics.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>,
        Carl Yang <Carl.Yang@synaptics.com>,
        Ian Lu <Ian.Lu@tw.synaptics.com>,
        Darren Kang <Darren.Kang@tw.synaptics.com>
Subject: RE: [PATCH V2] Input: synaptics-rmi4 - filter incomplete relative
 packet.
Thread-Topic: [PATCH V2] Input: synaptics-rmi4 - filter incomplete relative
 packet.
Thread-Index: AQHYriedESzFVEn50EycgAScWVrfYa2rpwoAgAPe3XCAF8smEA==
Date:   Tue, 30 Aug 2022 09:59:26 +0000
Message-ID: <PH0PR03MB5848C74BD8C8FA9CB07C8C8DA3799@PH0PR03MB5848.namprd03.prod.outlook.com>
References: <1660293805-16053-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <Yvap0uh1U81gqy6J@google.com>
 <PH0PR03MB58481D2CB3F4731DBBF19B7BA3689@PH0PR03MB5848.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB58481D2CB3F4731DBBF19B7BA3689@PH0PR03MB5848.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXlhbmdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02Yjg4NDdjZi0yODRhLTExZWQtODJkOS1mODU5NzE0OTljZGNcYW1lLXRlc3RcNmI4ODQ3ZDEtMjg0YS0xMWVkLTgyZDktZjg1OTcxNDk5Y2RjYm9keS50eHQiIHN6PSIzMDc5IiB0PSIxMzMwNjMyNzE2MjU2OTc2ODEiIGg9IkZKUDJrdUo4SCt6MUtxeEVUZDlSZXFsejc3Yz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e1ffacc-f2c6-4d2d-425d-08da8a6e52ad
x-ms-traffictypediagnostic: MN2PR03MB4991:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0LDkV+ioastCZIt8Fssjmkd8K7NPT0yChMVa679MrvvEbkhRMfJ7IUj4EbPjOqqWflY6Y2GbFjbDSwb/eDgnfxgWuVn1B9drd+BgdLRqYxGLmhC2+KJW0ddaX7pFcVydb2PlUhxLu1iMtto6paWj6xsLCbZ+ELYwlK+q/aCLE2rkLypzxmiWcpYMxWcvNrjQJnpoDnMGU6edMTJvW6RDbvKyG+tTs5fhTv2COowVX0N+CMOIP2BfpyGAoKr1Glr95+giYK6KvaD5qMQuZiDctENMoMPYy7VTY/ghZX8v57B4TJsXCDkxgolPh/NHa9ThAcST1yXReMNyMBWG/USGYXYbQDd/R2JBg33kEfL6k7X3AXLx0YrUZ4oDm2Ob6B6dVb5XTE+A/zHkCM3fj2Bqek13Eh8Nbjdc8fJSk1HXLkBbgPavnUS6itJt+hf/eNpXJa6VcFnRkgHsmOXorz/c4JrhmmiRvgKJ9H5bJhfa2juAA3rSsa4v1XPrgwJQXuTWR0wSMGZtSp2WOlubc55CRke18aGU25CMq1rdjO5rBVK/gfPxv0/S9YKlzvCzmucGDjLkf20kJ3JHSpO+sEDIvESlgMvmXPenjJKaetde9mXSkjI5bZxV0JLzlVRzfMoaD70bN2HHPMWS+vyq3kZDM60JLGpspVjHdm9ZisYFbTKLWZRvokb7w1EW23MymAy8B5UpfQVTw+RpfeLtGkORccdJookDFWcbMNMqOpfYn7IlAxfXURXHDy4v1KXOw89eGIYs6aQe3ceNJ8LUCmY1uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5848.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(366004)(39860400002)(136003)(110136005)(316002)(66476007)(83380400001)(478600001)(6636002)(54906003)(122000001)(71200400001)(66446008)(66556008)(64756008)(76116006)(38100700002)(38070700005)(4326008)(8676002)(66946007)(41300700001)(52536014)(8936002)(55016003)(5660300002)(9686003)(26005)(7696005)(107886003)(33656002)(2906002)(53546011)(6506007)(186003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fvO2BH8tYw2ZxsGLunEvj9V/1T/8ik3BD/rVndCJIAP2zefy+fk8TVAi8B9K?=
 =?us-ascii?Q?nqCvcFa3IVwUBpci7JlB3w0OQy+PpCmovtCq8ToXXo2L2WFhb+5UBA0QM5w+?=
 =?us-ascii?Q?PyTGLnt+MYpjLUeXBoS5nBcI9IsHUYe6Kh10TuRMaX/IwFKOqn/1V+T2GMGM?=
 =?us-ascii?Q?TJe8RExd+pJB6CslaiVIMxPb3iUpSJCIjky8MY9PR2F0O5uIfmXwLrUKIiMu?=
 =?us-ascii?Q?sMZP8c66M/2TiNe8yeHrtJS2b9lAwN1VcJtxk7ibM3OeAMZ4wagC7tm8kbi9?=
 =?us-ascii?Q?RbSe8UFtI52a21nrDCFkYdS0/ekX+4tdpnMEIcRIiZLCeWt1JdakgmhE0A3+?=
 =?us-ascii?Q?Ny/eZXmKNU76f3p/0mpUc5B/hK+oMchR0z4nYOao48/bod4CarEVZ5g1UY/1?=
 =?us-ascii?Q?DTvutVYwjx38jvCaSSlex/UqKkG2B52qmHHEpr7YkHT2bd78i150mtqXRd5A?=
 =?us-ascii?Q?ohb0C0+x3X4VKhJ6b8gznTu9hG1bXtYCVgF4pzxJ2qwGWYchWNnIP+PBYfp7?=
 =?us-ascii?Q?Ann03AJkJJSoimVBcv3mfNQjw+TvmHkh1PH08c5PZqM7Wcy83zS7RcpuX76U?=
 =?us-ascii?Q?siAPZ+FJ5ELMpQIFCxMTTWDohDKJuX75VZG3kZzCQS0GdoDINZxwkxHUWveo?=
 =?us-ascii?Q?U7EQNyEatXFYl6L0hfvWLpkxSRh3ENe/v6TPZ8LHrroK4+cUEp/9vZZUKUWH?=
 =?us-ascii?Q?8U7+MgkS/08wijRdH+Nq+qDC3ogKx8SBZwv83Gm2GgYRhWu5m3xGI6cbYg6N?=
 =?us-ascii?Q?LpdChWjm1i2ORCasWO+gftiSjVgb0HcqQvoQdmPjWofOjMkNuTkBccBUBE1T?=
 =?us-ascii?Q?xwRBOHG2EbQD14ORVoFgaVZQqUCBM6u1WLg5VXbmAg3qoy/i/QYfWUFn5cQh?=
 =?us-ascii?Q?kTtkljfJhVtD3CiyLlRVj3bnTIlsYgHtl6beh/gEBtBo4mDJYOrtbi39RNEY?=
 =?us-ascii?Q?HHiC+v3opx6BkxsaQ0Tc6GknDy8o6kZGufpNfFnVr4tpWn/s6kxR7XRycYAJ?=
 =?us-ascii?Q?IyoCWipu/LyD9Ed4VlQ6jnDlGWZ7YS0Xu1gl2PlBq/NlDGa2NLrx2zBNo4jW?=
 =?us-ascii?Q?5I3LRgdBIrb4CH3fAfiWIc/f93SmLEoJyd9oWZoTmZH67Q9oKpnQTO+8nEhU?=
 =?us-ascii?Q?WycnpXwv0tu15my5HiuAn9pBhMPyQAOXslxx/VDX886s4Joijmj0MtfN3tRc?=
 =?us-ascii?Q?gEVSt/H6weZAXJfo8Oiqy8UUHdODOSYzQGfQE+YkP67TqXbb9y4yxhcXp1UB?=
 =?us-ascii?Q?yTAfqaV2FTmjYmCXab1oDVHqP6LgACmC023xl2lDiPSYV0++7LqW/vgJHcBf?=
 =?us-ascii?Q?tNK5YUnkUIwhW6B0pzzxepk9E77O5nvhwSZicuRfrueSINmvXvAGV3BZ7Nyu?=
 =?us-ascii?Q?iMYpCsizN5yPkQTn9dd5BUNMTwRyur0ZPZ+i2FVKZnqyxVeFcuCZi2ikyJBy?=
 =?us-ascii?Q?z0kJbajszutCxxw2kn/hkQjpqNppLg9AdkUXaSbb+voo2ry/uvR1Llr59++P?=
 =?us-ascii?Q?9gzBV79NqRsCT7FvYseW4+L8ccOdEnDWAdEsEaQlkYvkb4SUplvbbZ9EwFYu?=
 =?us-ascii?Q?4C1fB+cB0ED5vyVWpdesrC4eWP/oaxDapy9pN2aO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5848.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1ffacc-f2c6-4d2d-425d-08da8a6e52ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 09:59:26.4156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXwFHMHFBzz4egSH5LN8EWi5ufHxRt424bWX505SXnBRV3z7037UcdUfN8FIR1bs+ID6yLHO5XRrTzrbIgng8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4991
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,
	May I know if you have any concerns about FW's feedback?=20

Thanks
Marge Yang

-----Original Message-----
From: Marge Yang=20
Sent: Monday, August 15, 2022 2:50 PM
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>; margeyang <marge.yang@syna=
ptics.corp-partner.google.com>; Wayne Chang <wayne.chang@tw.synaptics.com>;=
 Marge Yang <Marge.Yang@tw.synaptics.com>
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; hdegoede@red=
hat.com; benjamin.tissoires@redhat.com; Kevin Chu <kevin.chu@tw.synaptics.c=
om>; Derek Cheng <derek.cheng@tw.synaptics.com>; Vincent Huang <Vincent.hua=
ng@tw.synaptics.com>; Carl Yang <Carl.Yang@synaptics.com>; Ian Lu <Ian.Lu@t=
w.synaptics.com>; Darren Kang <Darren.Kang@tw.synaptics.com>
Subject: RE: [PATCH V2] Input: synaptics-rmi4 - filter incomplete relative =
packet.

Add Synaptics firmware member

Hi Dmitry,
	Update Synaptics firmware's comment.
[Wayne 08/15]
To address the transaction error case in the middle would potential lead to=
 the unexpected data transaction and latency between styk device and host d=
river.  F$03 didn't really parse any data packet but simply works as bridge=
 functionality to bypass the command and response packets between styk devi=
ce and driver.

Thanks
Marge Yang

-----Original Message-----
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Sent: Saturday, August 13, 2022 3:28 AM
To: margeyang <marge.yang@synaptics.corp-partner.google.com>
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; hdegoede@red=
hat.com; benjamin.tissoires@redhat.com; Marge Yang <Marge.Yang@tw.synaptics=
.com>; Derek Cheng <derek.cheng@tw.synaptics.com>; Vincent Huang <Vincent.h=
uang@tw.synaptics.com>
Subject: Re: [PATCH V2] Input: synaptics-rmi4 - filter incomplete relative =
packet.

CAUTION: Email originated externally, do not click links or open attachment=
s unless you recognize the sender and know the content is safe.


Hi Marge,

On Fri, Aug 12, 2022 at 04:43:25PM +0800, margeyang wrote:
> From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>
>
> RMI4 F03 supports the Stick function,
> it's designed to support relative packet.
> This patch supports the following case.
> When relative packet can't be reported completely, it may miss one=20
> byte or two byte.
> New Synaptics firmware will report PARITY error.
> When timeout error or parity error happens,
> RMI4 driver will sends 0xFE command and ask FW to Re-send stick packet=20
> again.

My understanding is that F03 is intended to be a pass-through mechanism for=
 PS/2-compatible devices. In that spirit all protocol handling and validati=
on should happen in psmouse driver that attaches to a serio port provided b=
y F03.

Historically we did not pay attention to parity and frame errors for
PS/2 mice/touchpads (and for keyboards on x86) but we coudl add such code t=
here. Do we actually observe this with RMI devices? Can RMI firmware handle=
 this better instead?

Thanks.

--
Dmitry
