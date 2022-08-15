Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C1F5929D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiHOGuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiHOGuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:50:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56C41B7BD;
        Sun, 14 Aug 2022 23:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxl/3krrVhHYh1JnBr1S/vUlsejFjhPj8yFbTpPH2eUrcUjX3NRkPc4fcOEtSrxBCOXxl/azWHThINPVoguec35djGjQpuW/EsnsG/w29aNe7qLSxck2ZdVZdKpukupv85bv+vDzvWJz2HZktCvUpd9nYgVSMGtBfkwbl/Tbq01xSbT4fcdefKj4kSsWHF+2gSNgNGZBk2jvOe/SIMRsgdKHpArbWK+cwRzhlFYJQEQashFe12+DM8VKGrj3F7ev41GaY5njfHo38doEULpd5UvEbw1FNYwWdGac3n+WPtezV7rVXGrdTiNvM4prFV1QnVDTr9MQfp7ZFaNUV4TSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu9V2PVcgr6VoNj45Dp2op6eKm2O5IColPexFmhjSw4=;
 b=OOGALm4jxkQywR4KuRmw6ojBhq2bmoBL7dcWZTYjf37AuRc6/HpHbJkfz2uVwafOH0HRquIUxO2vTO3Zb95MES/su7mIL0D8V4AGcDzXTjip7RAIz3D6DlNYyFUW1e7lE85WW0jCcnSsi3YBTnjpDfG7vsqrmf/mszHTWdeGb3bXGuME3RY3zU3N/W6kKvuyRf/HS9YwPQcHcuetWu04yM1VRjHNOfgKgCcY8nVSitbp6Eis5p0C4M2YHbsKsvl0tF5R/mAPrVpM9ZIXM7BCvq6nL7frt+96RJkL8XsakCxC5PFjVlLsGYDAenmFBAsDIiSRX8WghTmXmDUc5bQ+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu9V2PVcgr6VoNj45Dp2op6eKm2O5IColPexFmhjSw4=;
 b=JDNA6+QdeL7KF1HEJt+XM917WYfEqbvMH9p9GzZCiwYXsBTEw7g2pvs8tvuQRnW4oEoEdhskupOwjFb3gt91c1f6+3ExKWJE1wa8dp+bRwQa3gLzSR3bQUljBvl0R7y5Y9w/NmXoPMqtJ91BFk3ZoKZ2hqyujKwLc/6GMF/rnJ8=
Received: from PH0PR03MB5848.namprd03.prod.outlook.com (2603:10b6:510:30::19)
 by CH0PR03MB6113.namprd03.prod.outlook.com (2603:10b6:610:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 06:49:55 +0000
Received: from PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca]) by PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca%9]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 06:49:55 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        Wayne Chang <wayne.chang@tw.synaptics.com>,
        Marge Yang <Marge.Yang@tw.synaptics.com>
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
Thread-Index: AQHYriedESzFVEn50EycgAScWVrfYa2rpwoAgAPe3XA=
Date:   Mon, 15 Aug 2022 06:49:55 +0000
Message-ID: <PH0PR03MB58481D2CB3F4731DBBF19B7BA3689@PH0PR03MB5848.namprd03.prod.outlook.com>
References: <1660293805-16053-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <Yvap0uh1U81gqy6J@google.com>
In-Reply-To: <Yvap0uh1U81gqy6J@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXlhbmdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03NmY5MzJiZi0xYzY2LTExZWQtODJkNi1mODU5NzE0OTljZGNcYW1lLXRlc3RcNzZmOTMyYzAtMWM2Ni0xMWVkLTgyZDYtZjg1OTcxNDk5Y2RjYm9keS50eHQiIHN6PSIyMjU3IiB0PSIxMzMwNTAxOTc5MzcyMzUyMDIiIGg9Ikt2d1dtVFNqam94QXd4THRRVmt5bkN2WU1Fbz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bae5f633-0cd7-482f-5233-08da7e8a5cc4
x-ms-traffictypediagnostic: CH0PR03MB6113:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eEEW0PaDfokzLPcMXc1VLL+Rf94SX48Ao0jPtjCTIKU8zihVHzi2ARwCiJL0Hz2tjaedEaq8x8IkYM5TrN2sRuPfm3sH3f5WSL0kwnGdYkGbu+PTc9XYgw5+zvTsMl21pMISLYKJpx1lrqsCSuwcjeqreAuoUrIo8ZKaJgpLhd9QmXnuP52exTVnFpnXjtBAGEECZjO4LnCuPuGAcr9aL2DX476dDLxPvtuNlpoAVJuPg3ZuHjUj9+pl4tzWYV1kD3OHYtv2D69c7pjfSwGwI9XJHWOj/YqlCad2+eAqbt3g5v4vRp0dqQw7xjQrTqsBvNAzFDC3Q5MGGOwuKleb9ybDMS6NSUTBwEexxL3huArlRc8O4tQlbZuuUi3aonL6U7cCMC6ejKfQ2IDgiwGH+9KseiPGp9p79HSucvFSHdU2vrSmL144lsESMRo+3uRv9XDmx6awau5JyoHJDfYtOKujzYa99HWOvUldbIZGT1GcmqbIilPs/8jfPE82CZeLreoSteLDa5ge9+8U3+Ooro+oM3S5Q2S+fPBMTVKEmYvY62TvJ0hI8EAampedxh3weye79o9GjtOKMggd7CzQB/NYx8DQ2KQbYfHhYHTj/HqNxBk+hBDtJEjuroly/gJ9hYYnZNwuL79hw7rk5UBZs6jhHPks3U50oKpyGyZ0spaWFDWsu8Ni2o+Mp5hu8UpWJOoNp76dijGFYScZJWlkKItabFS+H1X4qre6OggP691FfZSluTuCiuN2u90jlzPtPH9YwZzqG17HT66FSDbCHCAe6AH/hl7HKAOx2kCbqek=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5848.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(39850400004)(396003)(366004)(8936002)(55016003)(2906002)(5660300002)(52536014)(86362001)(38070700005)(38100700002)(122000001)(478600001)(71200400001)(6506007)(7696005)(41300700001)(110136005)(54906003)(316002)(83380400001)(8676002)(66446008)(66476007)(64756008)(66556008)(66946007)(76116006)(4326008)(26005)(53546011)(9686003)(186003)(33656002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uDz897fbbtqb5hWjVcTdCfMuMC0q31thCfVQRO/NIuAGt0w4zG8z8vnTs/Pv?=
 =?us-ascii?Q?QuXWpvq26uRj4bXYqneeTPs7JC7jPZbe5TNT7oDIlTmjFeS03k98TFEeh0aK?=
 =?us-ascii?Q?inF36kxhF+3ylnenIKogE0XVFxWOhwVKh3vyap+qxcIY7WPd1A3MwRv50wJ7?=
 =?us-ascii?Q?N8O8S5HHUL7RbNH/WNxJBa3vM3U/Q5GAUpaLjnQc4VO2cW2lXBjAJLgfKz2k?=
 =?us-ascii?Q?i+LWlfytlIdkrOobpQvb136pmsPxMi9pwirsv5GVlWeieW/GHH3nc2TEBuSi?=
 =?us-ascii?Q?UaPbDDbY+dOCZXicohEHw1Dk+F7quHuG6U1YQv9Cg1VvvhR65nwKChkykvjK?=
 =?us-ascii?Q?R/iPAPRGtKJLo2/PEWB4dXKuFfmtSeujp8n2cWCfpMk6tyEmzQAnamEAlCix?=
 =?us-ascii?Q?wZyqC4P4obfJsP/P9DvBSwVG8IghNZi3yuqzxYotsgsfpbAD5jYKec3YFvwH?=
 =?us-ascii?Q?lJKiRDlk8aNFAmQzK7/Fn9uHV5h1D/NeUqLsMHZyHph5jEmxP+GAqPMRlP9/?=
 =?us-ascii?Q?3FBG5p9IqCchEiHnsdIazA5ZOdRfgyvVEs0NH2QWDwFHobgRJ2h2uDxY0SXt?=
 =?us-ascii?Q?hYr/VjEGkzq+CwACSZbJT+Ew22bQWtVLXF/FU4BjboDNeBuPU6drWh1jeQjM?=
 =?us-ascii?Q?CW05WAaGFt5xAmrUWtcpbUidLGxohaELDXBRrl/YG+Y1+qXv0ILuof35KK/C?=
 =?us-ascii?Q?13XgHtv5pDOSO05UrFN2w+7Y1qTYcSo9sFZOMlC7PmjF8m9tVv0B7S6mowV1?=
 =?us-ascii?Q?vIBuAlVGaFCZTsXzvA2tM6gzC5o752F2z/CGbgytlpAMgCQxsvI8YNywrbw2?=
 =?us-ascii?Q?GDFwHuqq33IUAXjC02+hFJkGYNCiYnwZoo4HkccfBKzF5a4c86dHGWI/20PE?=
 =?us-ascii?Q?VSj1h9m7LrnvopRYHbOjhDFEa/ztQB354IWvghgth/tgBzZzSla44wOmjPLU?=
 =?us-ascii?Q?kRPRM8eIqeu34OnztSc4ZAPBXijlIfNxV8Fk4AK/b+YVxvvkQqtgxtNkN8zv?=
 =?us-ascii?Q?6cvCrB/mYGnhAWIcATPt/FdTcVvWY6dIxIjK9E5Wuu3VTAcUb2hNlfeYgWXI?=
 =?us-ascii?Q?fey4w8+23yGIW1yX6ztTBbm2LOYVAJmpWBdxiOBlIyeSLXeHqflXvxFb0Yco?=
 =?us-ascii?Q?Tvd5ld7kgqUJ1l5noij9d0NPlsbBLQcZYBT90V0ko8BZleELVSoBrkVN+eH9?=
 =?us-ascii?Q?S+XzrrSIb68aaAfp4nNVrFBKgfnxpFvL1uJG6Udl74gUIXP5E4cng94iwfaH?=
 =?us-ascii?Q?ACSO7b9xzHPQbMHKo2oAAnW9xpB2PKo3Eyk6oeZjaC3qi+jqjTsTUOEikjYX?=
 =?us-ascii?Q?UNMvol8rP4MoAWBmhZXx5KPeJ27u/yT0fGn6cq2SXn2PHVyGwSZneOYShwlb?=
 =?us-ascii?Q?lrgZCh6tpL9KTjf/wejQF4ajDqkZTVqIsg7YK1pXFwFT6xh/566UcC+m9hWU?=
 =?us-ascii?Q?zGp7ybo92CoEbvOsFckXKutNWt3YSJjcFNPXS3a6wLDMXZFSo2O7P/1QQeEP?=
 =?us-ascii?Q?N7htyYjWs7wuXTzZTGnSMjtqZbioTLsIlMr1BNYo0OS4wd+6pjSdikfDRb9H?=
 =?us-ascii?Q?wzZbslqdT5weZyg5HO+kFke7p8PtJD+B68+1UXun?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5848.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae5f633-0cd7-482f-5233-08da7e8a5cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 06:49:55.3146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mext06H+AFbN+bnSaPAlgy1eTZGWV7Gbb3VoVbIoBfud1w4hLDLPjjmEoj4kGQI/EPls7r/IDnCPohOqZt2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6113
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>=20
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
