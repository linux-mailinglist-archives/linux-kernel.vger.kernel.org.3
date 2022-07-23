Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCFF57EFEA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiGWO7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiGWO7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:59:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E949C12A8D;
        Sat, 23 Jul 2022 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658588358; x=1690124358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hXw6lief2QZ2WQudsE+EN2zQR2zo6ZYyCSbPh7JqVig=;
  b=CIJ1YTFLIVRT1kb6K0sQtT/3pYXm9XqvgDCQuR4LcZsgZ9GwrN2yQIGE
   8V2ipQIWDNAuUaCeEbx9BXt1J9vsvlnXseujJ0GzFYrf+0yABlA5GyH8/
   wREhUqaPRzdF/ispV2sD86V2TmKTzoalRYVrmdVdiBtdZDp7QYJxpiGxl
   uzKmdLGIx31TQZJ+SKzvSSnKeAdU99fjrv9Iq0AYXtYhqEJkGrQ1gbsqM
   r4KY82K5/XdTE03FtY3s/wZnsAUd9RPj6KZ0oLf8DoexLRSoyS3jbdbp2
   7FnbKupfHLB+0x8fL4VLn3c1A2O1ykgz4UKOvg68ng3h56lqtR0i36m5X
   g==;
X-IronPort-AV: E=Sophos;i="5.93,188,1654531200"; 
   d="scan'208";a="211665164"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2022 22:59:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPZhYEcTLDpgMm3TJ6O0xguHC4zJQKuPP5iN39P6k0HA1qWJmQITPS48O11mx6KmZX5iPXRlQW9Fyoi802wjSu36F5HSh6Z81MFhyikfPa83GTkxJc8h2EzU3UFhFv93wjT6KHnKtZ7sBY2KVzH8B4ExSfT5XhEBxwVygdFkomNnYpmthhaRYULjgQZ0+aiEWrPZN++MtZvZuWmUoX0esjQsMi8sI2EeZ8BbGe56GMg7+QmwYRuLMrXhMg0zuXvlEiTMb3CDJS1du+u7heacCfmmA8bkZ8I5DTLGGZ4Dwfr+Nby5eW6larU3bDSj/yIzR3l/1ADuSzn2YfyQsuXlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwMfDQudjSET6EeHyREmW+YSyRzRP5ERCCxI00LDGy4=;
 b=OGa678LBk9+I5Be0M42qGSH7JG5V1bc2LLOhYQZvThs/T1gP0sbUZzyWgl2w23a+eJZaxxJ7dysEviCwzLzNtsugzeURbK+r4TyXJ4SrjqiWrkTCW7C4LcpVye/gqlfiy5QqCSUrwnDCSP/Jao/wwNxDNXNNM2aQESOvdajJkOYVBoSqyVMoBqmkVEvrRYs7+7w2tdXLtriHTbIx24v558GON+f43wvUR+0hM4/4IelWvO46t3Lp63yLsJZGfOBQ1exc8zNdCq1aw35TJBcMWm+73aaStjsGhaq9eQl5SmAz/eSNB/9VP3Qfkp6zX4OuKFmHf2XCkK18PwTU7H3Rhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwMfDQudjSET6EeHyREmW+YSyRzRP5ERCCxI00LDGy4=;
 b=CI/jcRexMBuDM8pucV9x7Eo92VGK9+r0d08go2oWxwn6yRjNinWC2EmE5Isk8q+VO3baE3KAuG8CCsPrhbhiQ80wbFQkobMKdxVw8ppNemgkP5s8jWNcivaKgbwbEWD03dHXJqDhPuads7TbHYu6tKDWowSe+JgcOax+5U+Bi0g=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR0401MB3674.namprd04.prod.outlook.com (2603:10b6:301:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Sat, 23 Jul
 2022 14:59:14 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:59:14 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Topic: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2MEbFQ
Date:   Sat, 23 Jul 2022 14:59:14 +0000
Message-ID: <DM6PR04MB6575048E121B56FDA56DA27DFC939@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b22f9a0d-46c2-47fd-6d33-08da6cbbe8aa
x-ms-traffictypediagnostic: MWHPR0401MB3674:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I5pDJMXXJvaOWJWYBBAKFFaaGZF19mKw+alwTNw+PUGCuYaHib79cQWWlDsr7qQIwmNOtu7TUI6Ac3yzEtAQf/FEu3EttD7/G1Ax63QmqbQMXnLl0lqNE5plqxTvPyWhjm5k+JGIn/lub2DnOFTefSfQSbU4Wy/kPdKSj3LnHf8W9s4f4BeoyIwETIxqEdVNnPaE+EY2wg9ExLUcQ2qBtq42DhSHfssCTkjGkxG6HupSNYTHsyLWOo1yYySGWynuAp4RFdsWKnvHNsmKpcGucN5joXVbQd9dZUNXRLkFOFples+PG5SiPonUSvapOUaFYYdNn097Sr9GIcD+xGSPSEIab8mZBa58NAbzcHS4fUCqxtSXQ2RC790KYelz25gnrWUQ/hS+SXNDvfVkl2d/fz3MuLOkH8YS4xA+BuOBF8PtwQ5aNlmABNKH3g5wjAdXWlinKklMIa75HuEnzlTw0/iUlv6rtjBWJmeFOJexBb7poq4IvjPz3SdGDhZ/EeNaEKlOG8Ni/lP11fYqNJGqCu8XzjWkFxdp3xBfoGn03S6mNjVG7JYK4TlApGQgCXwgy0HtDg3GqsfFhTIaoRoEO6n+gv+DQBpaW4eLw01ZL4L7YIRVNRtJGe2wKCQf6xZscIT4Vb741lm7yBH7T/89aCHk+BeEsfPlRkLUG8GbkSvs4gTs3YEwf6Yg8W6GNGhzEXMbmyphgFMeXi2K5/d2onUyTBOBl/+Jb6bs0UDUUcILtJiDWQKbsW+u6PxkcuOXqwVr+BiCp8KqJGpMTTKTZ7FN3rZHACDMdOigoERGVn1CA0Cn4BjOf0OMHxdvMtdqOZNhgCQ+szqR+a+WgvrBTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(41300700001)(7416002)(71200400001)(8936002)(86362001)(6506007)(7696005)(26005)(2906002)(478600001)(66476007)(64756008)(66946007)(9686003)(76116006)(66556008)(8676002)(4326008)(66446008)(316002)(55016003)(52536014)(5660300002)(110136005)(558084003)(33656002)(54906003)(82960400001)(921005)(38070700005)(186003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FUKqyzQ7fJzD6/mXjt2+9Ua07MNYZUUFUMQwuBpcj1c3Njq/K5N4MbJBcF/x?=
 =?us-ascii?Q?voDq8ZW/CBCjXMWvmc63dXVL+ta60kf76YYIlfSJQqJlG2phQC2UpOKbBtOm?=
 =?us-ascii?Q?m71kJ+t4AUCs1kg68sbc2C98NcQfQOH6Bo8l8Jg44OBbTwWeLPv750SdNWPx?=
 =?us-ascii?Q?ywirkqgIXnB5loJ+jo8tTbkt2nOyJTw62aGkmvJpIOGI4F1tIxREVW+LN1uZ?=
 =?us-ascii?Q?w9yznKlFKBxcy4JRz1pNuXg7YhlO/0mU2uJSUmZZ1jnaMZtCHKB9EEYo9qM+?=
 =?us-ascii?Q?Z/KQEm/7x10nfBkK71yMhkudZiwmoysaHGq61SdZTmmB1dDdVCEnbnkhvpVJ?=
 =?us-ascii?Q?CDYAmS+tuAnCA/h46iPmjxS38yGZWUNHOBYjYuzvXmNPOD3dFWrNNP2+E2fP?=
 =?us-ascii?Q?jUvU9ZnBatbAfedTaJJ7N1m+PGbPDGDOnOOq/b2uk8lQVCGPFtkzmuIkeZzg?=
 =?us-ascii?Q?02wIjmvdX4pFphEyiu0A2iGksJA4dl9isMum81mXfMBe7PzxnhGcETyh633K?=
 =?us-ascii?Q?ySNPn5ckd6pqQaDYiukRBN32Yc/CoFPcZbahprK5PWzFBQYuJqQWb2S+ojut?=
 =?us-ascii?Q?N6ytpNBq7pwDUR+bxnozFhgCnPDKs7nndHoriTRjbY/QsQfciz6GeP895rzd?=
 =?us-ascii?Q?MeAWX+ZRT2xX8mrpY10Ehfbc171DtvdHo8px+oHi+Ph8Niu/Di/UfT2PKUDx?=
 =?us-ascii?Q?o9h/y0bFHL37Rywnjrf2BLzE0vM/X1A5kLcDHg9G2qfxY9xJDQQ+fbdvnXA7?=
 =?us-ascii?Q?XgAo1DJ/ZyLqfbEp6J6CdHZ7MuXX9zZxN6RE11vA1gBhTLcyHvPmZWvvHDl6?=
 =?us-ascii?Q?SbMxyzT78GfBysSHiqHUTEy2OzBEZ8U/4NmPay0PwbE+CEThzchvhLo5bE8H?=
 =?us-ascii?Q?fCh6L/u7u+6T+h9mg0rFwixEbS+K+dt8cGBaIfWFNk7+SHhABAgYyM5kvqme?=
 =?us-ascii?Q?jPqAbwTeae9YvxqmlTOaBCPO+P5dAJDm/1Jph+NOr0sEVjWdJRPsvadi+/Td?=
 =?us-ascii?Q?x20UiCcvFtCr59581SdLwdej6SIncaJyivkbGrT+Q6Yy31VIcq5BxHpIfUx4?=
 =?us-ascii?Q?jiOG1MKC01ufpPNek8zmscUQtAvTHKolFSzpJYsaHqxg/zgtN7mG0epHXo83?=
 =?us-ascii?Q?DETNYSKDDEt8o0Eb/ucccR8Vh1EqFDpqfFjBTIS14jqhtmhHASqd9OWSkb+v?=
 =?us-ascii?Q?5OEqXCx/xbJPNlexSMJbp9CdLpp9viHt/qIFaoP+Vu5MbnUVdrA32vK9P+LZ?=
 =?us-ascii?Q?HI/jmhiQ280S8onNnUcubyeTtp04EkaA7rXTva7GH5NahXLd7kk+XjuLIk+G?=
 =?us-ascii?Q?O59iTtUMnWCrZAL1Dz7bgUejCskyVVu2W5V7YK/5OgtWS4f6QxdCbgO2yKRM?=
 =?us-ascii?Q?GehpkQ1C/fKtvEzWVfocxuqXqU1Em9PXsJhqGEmNPDJI1c/01hoZDaYYDhzn?=
 =?us-ascii?Q?B+ED4/Aat6Zop9V6ZRMkZ/vGCE6XmdJ7oh4bHDZkT7LMhc5C86xenf/Vl2+p?=
 =?us-ascii?Q?OLt3tydIB5VWeYiLT9pcQucvsgX18MTq/CaZdLHvnJAFMbYmeoZfgOo+wdtG?=
 =?us-ascii?Q?TECPfDKybxMIvJjDLLE2y4HK4rsSwsi9z5YxlQRT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22f9a0d-46c2-47fd-6d33-08da6cbbe8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2022 14:59:14.3889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zD7++7WlFuAqlLr6NdPq9sdfaO0ejPbl6wpySatotHnBpgOpb3TAARBbQqFZ0gOANufM/lZ9a7EhglbQzjEajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3674
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define MCQ_ROP_OFFSET_n(p, i) \
> +       hba->mcq_rop[(p)].offset + hba->mcq_rop[(p)].stride * (i)
Can you please explain the 0x100 stride thing?
Theoretically, each rop set is 48Bytes long, or did I get it wrong?=20

Thanks,
Avri
