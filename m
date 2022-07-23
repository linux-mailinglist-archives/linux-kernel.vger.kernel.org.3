Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF7357F015
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiGWP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiGWP0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:26:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEE711807;
        Sat, 23 Jul 2022 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658589969; x=1690125969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kgy+zqPRaxum7a3k9y+3bPjab42UDQsX+gxC9curvk4=;
  b=G9DJDN1zIzcPuHPg8j053UG0h0zAxAbXxcWJwdAhQnDbSpvs0cZp+p5a
   rGsMBMkfkVYwj8R1xIuuztZ2WL1GcWQnc1JSytRxubjij3TCV3yUoBnap
   2flpYoeU8J5LkCts1CoMl5VlAqLtJ/qIcLZqn96QtNXvvBtd36uNVeMUY
   Nwbv0CYzU5i8YQ7yhXa+XysxKtkbgGe0+eINVF/ds5UkD1OCUzQcTv/Nj
   pwKKpBAGxf/mNWIcN/a+BqFPbd+AhOd4UyDTg9N1dv94dqOFQDMqM9myn
   UXZnHnYf36RV3/i57TRYSUo3T5Oj1jG5C8HfdWb6lV2wn3rcTXc6Ijti3
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,188,1654531200"; 
   d="scan'208";a="211666140"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2022 23:26:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZljIOv6Jn9DSBx27U+40KgdB84LdyyXQ2Dj1in7xxaeVVDFsoiT7ROOVB+a/vV8vFRiYLDNgleP9bmAx+zZWpnx/jytZFZmDnJWCW3FUikEqT9O3HSopGvzEh0ncSNEinml3cycqbrLVyVOuE0JmRVCzSX5VaM4vRAqp3RUTudh1KxqJz1JdsWHrzNC+zYGO6FQjF5V1MBht1xll831M2omna3CgHeohW9fGOYnee1yaz9Ht4jbT/BBC4O069UXzvuRup5IrHFB9apkxQtHtmDXSklWpfByo/8gCbOIDDjHpXorZfEdyzmsuNYUrOnZgGEQAoLnsBJ+xX2Xm9a2Uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7zSQWZHvMuAd+BYpWwM+0fxPDqXbjyKRc1tFT65TZY=;
 b=StWmx8nsMRYz17kaNy5Flgw2vuDsWtTvSlsNNCssYKXZdodbFdhHqaaxSqJt1o89t8cRmvj7VsHqhK4VJlZVzZ0AJU68YSGw96JN+jFSSafGXO0o88oq/q51EeZt1JfRr91kGOheN5uVc1btTeK50YgqKyj0Cm1B7q1vuQkkcrcpzO3Lv3xF+A4dUcEARpEC0jF0WKu5Rnmy1EVqWDsuPuIhVNDcq4dXi2KiIz3ezmQekxvtbe/iGh6P0JuPYM9BzDpE2kprN6B5sH6MWqwpjFHgifL6zIqLfw2PsiztDgGiEdfHaFcn2GEpkEylwqiWk4/0bYKd1P6jH/lEXOx8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7zSQWZHvMuAd+BYpWwM+0fxPDqXbjyKRc1tFT65TZY=;
 b=HoeHG0Sxl8kA/+NU5QM3h1KKu+0ZEaiKf7K/Ycm9kSMxm9O8XFWXzwAHGxR6ls2tqzyXrt8Eo+PaSprtOm8dxm73I8oZflhnMOvKYrvCPkASJ9a1/222fWdPmx913F0EF7I/oedYARllDM68f5ActOhFviZical+pM8+DcfZC9s=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5115.namprd04.prod.outlook.com (2603:10b6:5:fe::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Sat, 23 Jul 2022 15:26:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 15:26:06 +0000
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
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2MGMKA
Date:   Sat, 23 Jul 2022 15:26:06 +0000
Message-ID: <DM6PR04MB657575D62B7A2136D6AF1654FC939@DM6PR04MB6575.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 2a6862c2-bf4a-4cd8-25ef-08da6cbfa967
x-ms-traffictypediagnostic: DM6PR04MB5115:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oji6N0pOGnAQyLF26jbEyYkR7uyuRTmlL1bk4UoE6u6gt1yOShSGdIGC3zE5AYF5VmWU+5UgODnRfnnpmByNu2RKfU6VzmdxByNXfztlpYSgWpwX839N7fIsWW/3IopUQW5kFl4Fv8XdJhog2z/JbeUstcsvh/pxdwRokq45S73lmWy+0a64Cvo4SABb4TiYOaDaZurzIVxnV4cJu08DqmOLJj/JKDJb6zePQwmDt1ZiTTvMp0nGa7sEK621opinKvIZUb6whW2Nr1DKxa1Gl3BEULWxv1dyV6sRxMQGzAOEAL9z8kj1llTC8w8r7YX2/uM7dfcqBur9KuFrDqg31q8WB8I/5qYP79GLpbiK18no6LhVFFKC01JwLXYjCH5/XfPOljD/6ew1+10v/Kbd2Rk+at6uSj40SQk9ED6mbkhyJVbu5Rl3qsxj2Ir2ci/cUGj6igcXFT/rI/Zae07XQva8gITYyGkmSzzOnoCb8gbXoxe/zmz0qTO+VEM7y5DEXVeLmDY0H6rqCo8nC6BdgE9BVf2//DtikKnHsylwPvnmESZc8++KFfH8/+sIZkcELG1NVQZnZGEdphMhu7ZzLig8NlJG9Xr3DrJdRYO12J9s8j70KqnO82Ey0bjcDAzenU8pcixldk+/4UUdvN1hr4W+lat1wOHMx6Uvf5cXDwU50kERqxfAgYTFuzei8yDwqvvIJwikNsJW6eI4e8LiMfp5bFe5Wk90pHWwNDLkr3FKzCbfKxuoNeX3utAlA/+Fwpnv51j79F8Vw532uHXLNKRMIN4gpOPOq5OfwwEb7O4OdhWgzrxCRs4uaatfZY4KYh7f69MDtPNqsb4nqvZOag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(76116006)(66476007)(64756008)(66446008)(66556008)(66946007)(4326008)(8676002)(5660300002)(6506007)(26005)(7696005)(110136005)(54906003)(316002)(52536014)(7416002)(8936002)(71200400001)(55016003)(478600001)(41300700001)(9686003)(122000001)(38070700005)(558084003)(186003)(86362001)(2906002)(921005)(33656002)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nopYZr9S5nTVz58KDQSxmz/jOf/IfDUl3dSNSTyj+Mzuy3ubyY+Kb4JyJf9i?=
 =?us-ascii?Q?eUzqkH5FK1QxcAong8sHQCtDOsufsZlKMjjIUy3Ao3VM9XAXo8YSLPji+iaw?=
 =?us-ascii?Q?JcX2Lp3ZQQLlbnbiNTnqGqbBYWqsMeqm+LO3ewmpDSHsbqu0sQCRfZHk1qX2?=
 =?us-ascii?Q?Ky0+trSbNbis3vG3IY39yj/BeiyGb2FPkXPgSDG01XkGMxd9y4xYuxVZlpez?=
 =?us-ascii?Q?cXm1U5zllaAqaWwG7DEPm7KmFdN1lZ5QLbPSGGCynoPdvFWheYoUIeRueNhY?=
 =?us-ascii?Q?YedzpNbt0cPdZQJ4d5G90QlbY/NAoNZryCMcvrr3JVm6ogZ7oDdSk4Hm6DxI?=
 =?us-ascii?Q?tmtxyHEt4q7f3qGtZfAn1I9/isq1yFDmyDicIcdmolrrWGwf049nMQ0seJIB?=
 =?us-ascii?Q?BQ4xwr22v2i77D9CXaEeDb7i17njfI2dhbu5TZkXNSIJk7sIOJDR+2aUpc0q?=
 =?us-ascii?Q?W9WfN1TLZFmWyKX0rw8NjBA5aNDuBDvmuX3v04HpK12TQ2yRd3QN7Qv3wIpG?=
 =?us-ascii?Q?0XHonFQriS6bx5c0P0K6wVf54uO2LQlacIJaDp7IssPHFsYkTt8lyTRNSLxo?=
 =?us-ascii?Q?8ED1jQwXlDtIgbKMcG5eVGH3fexlfUR0l4PfUYevRbYHdjZ1oFSFRgVTshLA?=
 =?us-ascii?Q?u+MjMD527aEZCIWuCseIMEIrTSHxP+mikcQ4JXufkP7CRfF/UN8JRnqGW8jy?=
 =?us-ascii?Q?clkgZK3ZFMskPk+2T+vivaSkXDgXPv1goZjHvKiaDhTSW2JN4xBAvPhjM7EJ?=
 =?us-ascii?Q?DIkmDDq2YTK49wBPJ/ncX1RKlOFGJtxW/ETtkxPItPGATNoOIdUPyFq45go+?=
 =?us-ascii?Q?9BiJc/GP/QUfUVgnJ/FM4pv6JMU0b++krxQzDNz0alAah9ay4ly0AhsZHDaH?=
 =?us-ascii?Q?qNFiCotsfqr8gnCnOBlQRB+iUbOZ+rA4xmKgTK86sHZP6OVSPMqcmC7bn82O?=
 =?us-ascii?Q?DRrwlpHjp6KGxkOWHd1mv2RRvSOfK0Fe9wOgdAbjL0RgKfGNONhgrQifAUkR?=
 =?us-ascii?Q?r64yfDmFG+gXktTMGcdm7y69qPRoLD+JBpq2b3Kitpa0HujsBC+hClx31+i6?=
 =?us-ascii?Q?Cquv/iTQUEs3pdMn8s1z1y+zrvn4P4XFYK4pZCNiu8N7dMj50E7GIzqyGS8l?=
 =?us-ascii?Q?viwJphfYDds+8+z6zD8aCTC14GdzwfF2x1s7PTEvAqkYPOaPLowRaOJHVzP5?=
 =?us-ascii?Q?o94mpWMVzePGrpLwQZwQN/J7IMAcTiVdBth9wqdCVD+wkJhyXW4eql2HV6a1?=
 =?us-ascii?Q?iESHPFKDTnPfzRMgCv5glq6ClG99eiKbP/x+eWSmC4xy8PuOOsWfGpbgVuaH?=
 =?us-ascii?Q?OG1Ro/P9ZEchiTGeSWE5RPNA3wfsUqLM7iplsrNANQGZQPiAK+7JkSeihlWT?=
 =?us-ascii?Q?/Xm81CQSurTqwRgjEqi2+n80zXn8PfWaEcJ2UgboeZgsY+nxMILnxLHG1EOl?=
 =?us-ascii?Q?Cb20X8UiL0cKevBqALnnMAaq9HegNtvAMCM4kLRgnZEgFQ1eUKcE2OdBRoPi?=
 =?us-ascii?Q?2EEOu9AUH6HvMv1EDAWggZvDyKj3tGgmFFpi5zwu+1JfTAKrA/9AqMlNnnwK?=
 =?us-ascii?Q?53FkwAXDj0WDnTECl2CZAbu6bx3sIU/yA4TIXSCi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6862c2-bf4a-4cd8-25ef-08da6cbfa967
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2022 15:26:06.2853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VP9ZJpS/2JFrv6b5nQ9/Ag5pLva/V8WoWmExB4QclvoyrgePQl5RYWpJo8B/UcB7hGfdqyEbXkZwNPu/5Wq46Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5115
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +               /* sqen|size|cqid */
> +               ufsmcq_writel(hba, (1 << 31) | qsize | (i << 16),
> +                             MCQ_CFG_n(REG_SQATTR, i));
So there is a 1X1 SQ-CQ topology.
Isn't that should be configurable?

Thanks,
Avri
