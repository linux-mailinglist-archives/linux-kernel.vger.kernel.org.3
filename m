Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9BE4C70E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiB1Pnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiB1Pnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:43:50 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B927173;
        Mon, 28 Feb 2022 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646062990; x=1677598990;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=boBtRU12OK0BnCWuS5+piKFqm6DrUUtGJSeWflBk0UA=;
  b=GoVMniovpBwHsmnt+l46o3jljTfrryOaw7LaHSj3VX8Fedpd1PkiTwhP
   m0EiN7n/T5Bt0v24zxvb9WJukz81t9KR4lRSZ02aeKOhRgRycHJBIIEkt
   /ONe2b8cmnGsetbtiaWFU2dkvw7CjagiPUblRnfc7jXcLqgR8RfTskPWi
   Hwx1sLAOGsV+jautrC1KOtswEYtgvDaeLbMtr4QN96881RCesC01UK7Rg
   CGDRYyvQynT6xF4BSGm3+sUWM3kq7x+780Mjd6veO6ieVD2M4pHSL/nEi
   2NOmiFQre3ZqfWAy5V+KZrJ2QDUi8nfWB+6wf+pd6S3MeMMFkI6P34g+i
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643644800"; 
   d="scan'208";a="194119980"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2022 23:43:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMNxHmDZG0iIyKLz4fOfeCdrpUfnyu9uAvf4EAr73Yg07L/RMr95yRLznrX1aB+3PI28P3vxiJC1WT1k3NCHj70PriDOU4AsC1n03kTdvPXhqAY3klrvoB+S4HftxGfULukDcTrnouhhwLyEgxEbuq+ufIU3VDUq92uslsPHLX/RK9OnmRztcQfB1VsnXsYc9+nmtpnIqfxw4Bl38KBcMH2i5Hf6CRdZESbVpDQsbmnqRFCefiY1SLKyV/ofBUm35uKoRAuD5+rwUYhz13SgEUNKOFDwzeNODdOK8Sup4C9T6SxB2FXWH9G7TawR9TlTUZOqXrWP/FNfaDIcuR2Xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boBtRU12OK0BnCWuS5+piKFqm6DrUUtGJSeWflBk0UA=;
 b=CtwDqRaSvM7MjNehUEyJ0lmeoD1piLfeVJKy4DVywCgBVBySTQLu2CtqisTS6XP8VL2hHe24QppAzHQlpZgutG2Y8iNtbJe2FxUWBdXAXNyLh7FymUb9RHCihrEjUTn1ECX+I4bdO1jOL6uyPwdMSkSAWmMw+LVhbaatwB52Jr4QtrkSX/9Sbi/xtATUno2BaiQQpIGGdGg17NO6v3ANnT4/GMQmYF8DJeuGIRJOEODcfHjTmvyPTu5l9WWtjb4y5qDKVIMzjd0mUoc8T9PuDaVJsu8Sq1r/JLonY0odl5V5/zJfCWJ8B9KqeTM60XFUBtStBBVHC1jiLmhjxJD0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boBtRU12OK0BnCWuS5+piKFqm6DrUUtGJSeWflBk0UA=;
 b=L77alg5ms4o1InwGG01rUCynyNdOcHqXKxRBygls89J/qwJgQ3S5qTsNzqpMX1dUgRNzVMxlfM9a9yUHo9BNT2Zs3U/3PQyQ+MBm8kyCV2yZkWqeBD7Dvouo1G5badNP1F55ZOAQhobyKXt1x4K4RSCLzKfDWK5Mc9Ol+4vk9gI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB1140.namprd04.prod.outlook.com (2603:10b6:404:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 15:43:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%5]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 15:43:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Zheyu Ma <zheyuma97@gmail.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: wd719x: Return proper error code when
 dma_set_mask() fails
Thread-Topic: [PATCH] scsi: wd719x: Return proper error code when
 dma_set_mask() fails
Thread-Index: AQHYLLMgk6W4zitGikuKxPul7WQOdg==
Date:   Mon, 28 Feb 2022 15:43:06 +0000
Message-ID: <PH0PR04MB7416EBC9CA1843989E252CA49B019@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <1646060055-11361-1-git-send-email-zheyuma97@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d970c3bd-dd32-4d6e-a2a9-08d9fad103dd
x-ms-traffictypediagnostic: BN6PR04MB1140:EE_
x-microsoft-antispam-prvs: <BN6PR04MB11400FA75DD0B4D63ED3A8209B019@BN6PR04MB1140.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OBM+4Bunl70JOHzMvr+injUFEUu1TiYeM+OZTsIio96hsBirG7FDCo7bRh5ywscIVMBP/SMTX+S47hRXWVJYk7uRsMbVRgL88Q5P93KMDsH+ZliKh1rZLH8I/L9/VzURz3yH1Jm2GAwIn3nBWZn/6320h6Bs3/G7nB30Y/+KbmZ51d0duZCZYZKSkg+dIKNsvlG7veLhZLp47IGLSbT4cAgDb1phCC2AtEW0nvrSnlLi9uIicdJfBJ+Rwdkm6JKWipJHNY2Vy9TwQp6inlVNmRhhit8FyBvrHh0oX73bDBFEglGp26YQRcacvLu9vxGzH1mZT0gLEujrJD9GvF9NpalEWuV93pD0tHFfYzH+/xpdjnQ3F3SGUAjGYHydGMM3svrkTIO/tOmlZ7hubXoC4yD58qhV3w31I4hTb1CHcwxhX3FlTqalNooO7b+AwYfkk8kVO7e0JT9/5jvZfUwR1OFPEw8MsusFPWmUsgLaSRqwETDozeeI23MTf6QWi+iYi1pUNpPNpdM/Nd3TIKm/zssNr/IF0SDdBG/uSgNwCDcHH+CkGZbWYgX+RMo7f+4zXXilXIZhba+aPJErMfNOzVvV5u/Hoir2sv1MHc37bxchL8kGh+l/byJhTO1ajUceIE7Fu0FgS+yYFKlJN8IASnPLJ/9QyaL3Ctay23t/I0RN4YIhFtq6elW/rs/FyYi9x8Ou3zmHfsQz39vx7EJnQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(55016003)(66556008)(7696005)(8936002)(33656002)(5660300002)(64756008)(66476007)(8676002)(66446008)(66946007)(76116006)(4326008)(91956017)(52536014)(316002)(2906002)(110136005)(54906003)(508600001)(186003)(53546011)(6506007)(83380400001)(9686003)(38100700002)(86362001)(82960400001)(122000001)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?66VXAVSgrw0JEqo1V9z/YDqarVRegSU6BW4j3d1QMKHSralCmi7n79tALQQI?=
 =?us-ascii?Q?CytXpFIhBW4VvBb131s2UOaPZtXcKJXj3BwEGP/oF/bTNT4Qbyxoyg5Lwq6d?=
 =?us-ascii?Q?sblOCGBIfupWADr1Bsrq8d1PL839xV4QB5irWs4sWwvHnDIPKRzSTQ4s8nP6?=
 =?us-ascii?Q?EDWQbJ428/coCVQOHfgU3eOGUNe7uGzyqW7xX7BRyuaZd4bEoWmBpHxahrOH?=
 =?us-ascii?Q?OAsWtmAJk41xy5AxZhLLgjag2KfUkRz34xvY7Tjf32dIfL4BXBFq4vwRFfF2?=
 =?us-ascii?Q?W/he1/SRgodWHFd9wdH0JT1RHAcTZCIzzNtJ9Hc3uNIHiUpmSqwgmlNOsEEc?=
 =?us-ascii?Q?evcd3afcJJKXhpsjv+vPu479a7Vbesu9axn0EIjSpnICj3PM3URqO4LWQw2l?=
 =?us-ascii?Q?LT0XZTEhSsBpZJd410SB7UgyuRPTDrthjmMp4XSNHGt30HVDOj9EHyTbFJjL?=
 =?us-ascii?Q?wwAwPjogKPZ9kt5eYPLRSe34QLNtw5L6Jxj0C6ZBH5LICBAQCqjoBlJthO5N?=
 =?us-ascii?Q?cCId6o5z675D33G49DV0fgoF5kQc0MND+Y2icrOZ4vEnd9LfzMdrGhRn2aja?=
 =?us-ascii?Q?76k8mwpaEZccYj7TQzMWmN5rHGm3IR8yrcwuAzD/5dLyqfJcmmFS0oZbDkBj?=
 =?us-ascii?Q?xxQAGh/t7LzOantqHdx+4ssVuxqjX62/6LosKW4fyI8sPgpVbd9fbt6HzP6+?=
 =?us-ascii?Q?uP8BdB7Wc8o4WXg5XjQRbYdkxUYBysA7/SZKKIrDj+LUEc0Zm3b8+MegD6Rz?=
 =?us-ascii?Q?1jQ856rydZPaP7YGfQ1L5xDlt+N8jfh6n2bmsEmwSga0acyIIIue7oEvy0t/?=
 =?us-ascii?Q?xdG5iirQZBfS7SuwDtXHwmQtAeYA2Lftgu08JMFeINzwXHpoi8GjC/T+FyHn?=
 =?us-ascii?Q?l8aDJnBGXXWf2rZVVCutgIdTbBF7SVsGSJhSuTH99B791VBlpJC+OQYhbBMN?=
 =?us-ascii?Q?aK5lgyBSm59EAGfBOhQblgIdcHFb4kJikeN1BkHIgBqqemurURmFO3FPp8UB?=
 =?us-ascii?Q?UhqqTUMZgrSlipeTU53UCQAmqUKPqKW0NdddWnJliFO+x9Tl+voRObXl2QqP?=
 =?us-ascii?Q?wplunZfiTBpCaU/4eYcIqrSgv81rmRyZIFSle8EvYRmJTtAig0A3dsMSWZdL?=
 =?us-ascii?Q?89uWAL5QNuh0n8sQwCKDT3Klc11MPlTvvL3PdmBGPuuZAWQ0yf/C4eaRY7/L?=
 =?us-ascii?Q?e7GAaVbiZlPHUW/RoLBq7mDaJ0G0/PSw76mrFUFeBfIX5jUeOQU/i6Gk9b6d?=
 =?us-ascii?Q?DFLVZLwXGasV82XM3mKt78qVn7WidNcwRpLxzxPY2Idd3yk+ApNa8+m7zdgy?=
 =?us-ascii?Q?Ze5dw4/o1+quQX7HtA5pCDbqqwWFWl34XOH78VjKdIB37Ds+breOh0FnNjpJ?=
 =?us-ascii?Q?YgLTQj0m7YdpgK3Q4NKo4HKX7kv/CQNIM2bEwA+oIImBvtpYjhUY9nQt8uzM?=
 =?us-ascii?Q?XhlahxyRyDs6tHMY5v3ixUwh6CJqAo/hh+7Q/CicRjeqdIKRKjd1cOfaUZra?=
 =?us-ascii?Q?+808HgLS2bvH/Xr1hyWs0M8ejPQ/qOevMfJVNPbTCUyrDe21KN29Xkg/HRzq?=
 =?us-ascii?Q?V+rjtmhnkK/bw+5iwUi0KxiO5Awfs1WMUq2ebLEuvBC8nMfqUHTq92en77GR?=
 =?us-ascii?Q?i368HqBc2OoPdpmiOMztxLRrkJoRYBn1dw5Ojgf3kti16D/xg9+qB6xY5VrQ?=
 =?us-ascii?Q?U3oFp4y2pGMjvrdaEg9507Kde3a6ThD+14vBvQtC0MksGKkZ24cgEb5LlPxu?=
 =?us-ascii?Q?wo2W9BHELsMLqpFFH+cmHAgvJKGJaBs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d970c3bd-dd32-4d6e-a2a9-08d9fad103dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 15:43:06.8664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q29RGbqtC8xoxZraqBbrwx4DNc+0dQ2zpMOrtaz8kCunOckNgAoHQPY/QD6BOudbxknBYuMq4ZHmMDNZ7PUimgbLkzAH/nw9Y+CiCGz+Dlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1140
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 15:54, Zheyu Ma wrote:=0A=
> During the process of driver probing, the probe function should return < =
0=0A=
> for failure, otherwise, the kernel will treat value >=3D 0 as success.=0A=
=0A=
"So set 'err' to the error value returned by dma_set_mask() in case of fail=
ure"=0A=
=0A=
Otherwise looks good to me,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
