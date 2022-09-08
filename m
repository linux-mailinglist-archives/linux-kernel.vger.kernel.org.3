Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6393C5B28A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiIHVjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiIHVi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:38:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC1A266B;
        Thu,  8 Sep 2022 14:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662673137; x=1694209137;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6DNDpyOd9z6YbhlKGnfbL/ZCRGTgnNMKJ1RbFKUaS94=;
  b=YIW+c+KIkEH1Z6Pw4CdofIkHHVLojwWCDMJIPexlTf54vGHwJ6FQmRta
   SvMd59WZqhHxWBAiG+rcbFTmRyjnzdqC/Qw0yu6DEyabNWEcvWwJaqwfQ
   d6M5AIrmOETtGVwMWkgcoj9CTUMaPUmRaJipyG5vBuWoC6anXTOZiKQdD
   7+g5/ke0tHdArDH3fi7Ja6L0hwUYSQiBu5h98N6fFJB4XSyMWRYGdicpw
   SFE+xVMC9UfOtil7bGa8KOhCphrn98mn4drAKXFdFkczubokJsoI1wIYM
   T6rzp7QXgKsxyHHvKXH5D9INli8eu2RFbBtTwjQPYlPBLrP3VEZbR8pI4
   A==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="173046505"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 14:38:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 14:38:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 14:38:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKwHfnIXXXtcQF3/OxlEi4YcFWDaqA4/QNsiZFPG8ayIHq132Qaid2AFmzBJn/TMiWtICfrgSwDm5vNOsgM0Jg2kajfkj9rA04aVnK5RrGqZg+YZJXE7zXt4sHvof2HbvjESlpmPL99s5EsSWCXEg0W4KCrgpQH6PWVKRWx86/tVnDys9nB7HzTU3p/3GAB866JMR09HoEPOdkEjYgpg27hEMNy3Tvalyx9WmDxdYQh7MaOgReGUeV8m3+eIPwOtsPl6AARpkR9O/UOmnGrTSF+NzjlKvX7UCEjF9rPTHPj6alVXufVgkO4dZdtn/9LQpr2heZmSTQ5ubYjEAMZ5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTa2iCpx510EVaGSd6zMiTMOmLDuTD72GnVqoWMiX2s=;
 b=huRogqO/1zvxV1bMKe8iw+kB6q5zoQn4HzBMuHuLBcj+a4wMiq9sYxfa4cjV81xPV0vLuqyPZI7dbqkEb85vWe3xwIn+KFIETKZESn9ahK5LRwJIdO94IGPvbDsr/o40Bnh76MFd5ymJFmrJuywolxQaJhI66ZYblg2jouaNZtyaJcZLZPjyh6PDyqhF1lUnMTcemkMaUGLtP2TYPNrRP9L/gQEeJx5Ui4VC3/sXTayyfWTBCPN+UOXjqyVWHTm4RXtfNN+VwCFUjnRMKn3gOv+byyseK2Kfui1nDl9NsKaAiB5kj6KQ0OFh0Nn7wrL7yvMARqGzhmhFncOdlKH1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTa2iCpx510EVaGSd6zMiTMOmLDuTD72GnVqoWMiX2s=;
 b=D0WkQ4dwK/Lie9hNWb+dNCcHq+kHSAQGJp6S0qwwu6trLdM2w6ZiODX3euJaJ2QHin7y7RwR2pyhMp1m4Pphb66HRGp14h5gLdq0E1JtN3qoFCTN92/mX6IZka/xe8/sFmlVEdy8wVdZx6TNaUiPKkVvc9DVo5pmDvwKi3yf2ts=
Received: from MWHPR11MB1693.namprd11.prod.outlook.com (2603:10b6:300:2b::21)
 by BN6PR11MB0017.namprd11.prod.outlook.com (2603:10b6:405:6c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 8 Sep
 2022 21:38:48 +0000
Received: from MWHPR11MB1693.namprd11.prod.outlook.com
 ([fe80::ccae:ffc6:d9f5:8535]) by MWHPR11MB1693.namprd11.prod.outlook.com
 ([fe80::ccae:ffc6:d9f5:8535%9]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 21:38:48 +0000
From:   <Jerry.Ray@microchip.com>
To:     <robh@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] ARM: dts: at91: Adding documentation for
 SAMA5D3-EDS
Thread-Topic: [PATCH v6 1/2] ARM: dts: at91: Adding documentation for
 SAMA5D3-EDS
Thread-Index: AQHYvwFp6QlC561LLkqA//RC7ZzMi63WEOwAgAAHdAA=
Date:   Thu, 8 Sep 2022 21:38:48 +0000
Message-ID: <MWHPR11MB16936F4F2FE278CAFAC6E7AFEF409@MWHPR11MB1693.namprd11.prod.outlook.com>
References: <20220902192236.14862-1-jerry.ray@microchip.com>
 <20220908211048.GA3344136-robh@kernel.org>
In-Reply-To: <20220908211048.GA3344136-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1693:EE_|BN6PR11MB0017:EE_
x-ms-office365-filtering-correlation-id: ae1559bc-190f-412f-f31e-08da91e28384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CrzKyeKw4IDX7/npf/Zx8F8LCh0yH6A1cpbXRIXlpDlOkJ+k5NiOyWKLAeRc09boz3Kt6ppeZ8+KRilDdBgI05FKkLYu8tBdGpb+6mQFww8o+sXJdrlh4SBeiKLCtkKZ7tMva2+eIZzoD/+b6M/sYrLZm+Vy5dAnTYx8qq9cZi6JAO8xL5Hk87DDVZ5Z1ghevDIScXExpOfxWXHeA3ZF/cyZ1Celrfl1Tbn8V5qQtYYKRkXHbBDznEo7kplOsTQXJcQ8DS+vJBdmW7E+kaSgWliQP1JbX7uZl14GgyC7yzrW6ql8OoiLT4A0DEbtUwbbFH04i3AeAawZjxkmbD9phNf8N42+1dejlzLLkpf+pGrqeBeLqXrLxMcUZFHViSe/d+dIDAnHW09esKuoNv7dz0IWzc+XDo2Ot+O2pS9+oNZ/K2u7Fsah1MR72aGXn6W/WOBp9pa6dTFbjMgAmGJ5vQMbvILKDR0BWx+6vGIPkRDLqysk3E/62ulG/Hz6Heo8C8uq+Dsz/0Cw40MIjs9ri3xc5m9+1gdhge5TRu0H5eSn8vxL7ItnEOyWF/Or4pauNroqwWiLPsjHbr5bBl7AvJhjKIU07WNfVyWDMKPUJaXpAZqbNNqaviy+MJhh0s+JsX2F2QfCnZtJ3KT06xnXViWoNuPAgK4BBvz+EL8IsXicb6CnnNetrNZlFDRzNd614KqeOGrELjd54QOv+tIsDuCsBw6x4OD/13bY0SxKQ/IFA/BPbSXyOEedQJvGvmYPSYAD1omwhFy8hNZ4DYcdcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1693.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(396003)(366004)(346002)(7696005)(9686003)(71200400001)(26005)(478600001)(6506007)(41300700001)(186003)(4744005)(52536014)(5660300002)(8936002)(55016003)(316002)(2906002)(54906003)(6916009)(4326008)(8676002)(66476007)(66446008)(64756008)(66946007)(76116006)(66556008)(86362001)(38100700002)(122000001)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?05szg5aYAgY5FtJkSELw+zr/gehvyxLu981IdmGOudskTndDDcliam5Yy1sn?=
 =?us-ascii?Q?+n9FR58ieZPrLAQWJDuAuoNbMik4CuDxLNScMMLA1niSfYIwDyXf4MF5mSSU?=
 =?us-ascii?Q?rk8LuOjmGqR1nTaYnFvaikliIZphG6Sf0frdVN+RA79r9RoecFV5dbFgyAjb?=
 =?us-ascii?Q?WecgW3k2/EZhWEAE3vD9A47ci+KQXHWh1/ro35GUd0ur6X91z2HJBZLt93Fl?=
 =?us-ascii?Q?mZI+wyrQcoXDrwOl/skJ5jpsLv777cfu6Gsc4KF5+Sc4nliK6YmDSa6XmnkG?=
 =?us-ascii?Q?QAd7Y44dfNHBq7cMcNG/7iHvp1Dk0fZcVgZpwbWYYrHQlSm+dMOxAc1oW0Uq?=
 =?us-ascii?Q?HLGUxSNTOMrQXNXTVZpTY0MKY+8LzKgY960oCcAIS+n5uxg191USV1PneZ8m?=
 =?us-ascii?Q?28jtWMX9wbpwzSg4Xpa3qetvm/eWuoh/aLdUy1SoqwOgLyPCExSltYZtZ9/b?=
 =?us-ascii?Q?0yS3jc15PC5WZthuO1XSxPPUShlqCamzUa8HclwXS0ycCHCGjlx8/aXcckvj?=
 =?us-ascii?Q?y+4yP0BeN5nNP2p/btW3v3M5Os7GejAgC2tfKNPpGAwWHIQiu+4vNl1cR5n7?=
 =?us-ascii?Q?mTUtCYDec4eItUsFVlxs7QJoaSpI6fnqF3zQZROB/68ENH2JSEj2Zry4xjTF?=
 =?us-ascii?Q?yfFkI1R698d6fKcHcy5Ho70+b4FBteOmnkLrwISNn3wxMn7OVGRRd2E592rz?=
 =?us-ascii?Q?ud6h6ygFyTJKMduiCzgvCGMfdDgYaFdsNV5NaUanFTu/hCSkPWxhLhbKzP6K?=
 =?us-ascii?Q?Fq08rmQsnRdrKGGKBGONw4TGWZktsBkSDr312clbJfeHXTCEpxJk9gz7r0pS?=
 =?us-ascii?Q?oTjXxL85Cq1aQj7s0qGCOLYusBn+yORP92OSNXhPLY+EeXvXYS3NGJp92Tq5?=
 =?us-ascii?Q?ZRO0UYvdJPCR1yi/AHvc02H+xc6CxjQWcz5Fef1SexHVLrBvQ85gCAND9Okz?=
 =?us-ascii?Q?9f/Lep/z0qoWrPwzzSkiLN76J9a+59b7WN8Q3SmLajCUIqn+CE/i5vJrzPL7?=
 =?us-ascii?Q?S2XZlWSGLsU4IGCIdH5B+7xadfb+EQasbmGNMFtS+FX1PVtRP7WCfO7AybEo?=
 =?us-ascii?Q?wlVC+MHasWgeTM5/L4gJZsedqloQJ1zDrTynoCdwyjG9rtGgIgQh7V0hsiPO?=
 =?us-ascii?Q?ewoyx3AWipYmzCPujp0RkJqv+iP3G9uH5t7Nva25UgvtH67R8hQVUWZTL18v?=
 =?us-ascii?Q?ShahIXn+TXst+f2X3g4KaYqw77a4WW22ti32ApD337jUdDNbncHqgN7zNiEj?=
 =?us-ascii?Q?aD5isTQH+9oNs6c9G6HKsPgS+JykTMZgzFzJrClv4keNXpo7bqp7P8POq1kq?=
 =?us-ascii?Q?6ITrHbdalU/LKfVSlvWoF7Narr0XZRAUpbPMUnFfsQ3HiYbiicIrLFj4bW0r?=
 =?us-ascii?Q?magJ329y51C7NySkUXWHvL0E9AE7O0+zrZxvroISc/3j/mXyJMtAEe4cR72c?=
 =?us-ascii?Q?QBnwAACO3omvM5AFNeWx4gA3P1nbUk3o1t91hu7p6iUdzUAsWaji7qzQqLdd?=
 =?us-ascii?Q?9JATVAy6aYcoxWzHiH/1Q231+DiEVAVAL7xt6FYzuD3KUSlj6T1XxgYRgvD2?=
 =?us-ascii?Q?VSL8n2BEAnBSMnRNqLI8LDJ1hKcTA+IdZCWY89vu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1693.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1559bc-190f-412f-f31e-08da91e28384
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 21:38:48.1198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HH+lWKTuDPI6+rBLONjtzM7gdASbIIqddhwh8dgheGcf0g8EgYX00fTIKst5OcatqpfoEXV/hOZJgeZM9cURGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0017
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Adding the SAMA5D3-EDS board from Microchip into the atmel AT91 board=20
>> description yaml file.
>>
>> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
>> ---
>> v5->v6:
>>  - No code change - patch prefix naming modified to match with others.
>
>You did 'git log --oneline Documentation/devicetree/bindings/arm/' for ins=
piration?
>
>'ARM: dts' would be an arm32 .dts file which this is not.
>
>Rob

Yes.  I'm trying to get it into the right bucket, but I guess I'm clueless =
as to how things get broken down.
I tried "dts: arm: at91:" but was asked to change it.  I can keep guessing,=
 but would prefer if someone could
help me understand and get it right.

Regards,
Jerry.
