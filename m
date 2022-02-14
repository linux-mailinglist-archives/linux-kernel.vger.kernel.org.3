Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C130E4B5928
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357279AbiBNRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:54:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbiBNRyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:54:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA262AD2;
        Mon, 14 Feb 2022 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644861285; x=1676397285;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Zm5jG73nyRuo4VcgnUgWC3l6TALkzi5GNssLlk/yHso=;
  b=QfGednr54gZm8dvLys/pIJ80mJiJFvOJOcf+/3CKYV68gtXVWQxlpMeM
   SRwplwF0zQUqTxWrvtjeSRnFzjLgVa8tP4ujw3+ke1gfsN4RquByIbABi
   fULFbptWCDjaI9rAyO7bxUxN3cHIMyMCnNPLo0XxZobT6GK3icKJruzkr
   QoVlsfzaVK7wOZa3S8I8ZVoWpCLL39+SrrSjR2nb8QslqM9Z/CgSuvuX6
   A5+7XC/7xFmXuqwAoyOBjUsWVgS1v9bhyZoEZk4LQT1x7goTs4Y1bb8Hz
   lkypVagNi9OgKK1J72ebZAAGc6ZfOJ5mTEbhWru+Bg0GmwPD4oHktgER7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237557861"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="237557861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 09:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="485610324"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2022 09:54:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 14 Feb 2022 09:54:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 14 Feb 2022 09:54:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 14 Feb 2022 09:54:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 14 Feb 2022 09:54:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeY2yZJ4Hy6+K8XP3/+mpuh+fw1l2Jviyx7o+8+A4CEUnUKsQkH395IWUiMQ/EF+5YKJJGYl7AEE+UFLfwZhC002zqRahqPLvHhfqU9p275JRX/ukg+xT0iSZyDrVAxoWL5VVmx/YJj/ewLyGlyD/WclanrmwIwPqC6jbnB6Ja5RsQREKM4xMDIU1QjUZjHAYOtq1HJ/kF9rjthji+gQjXF9QiFhCrR5+5nA8svXJOm4eR1gjQEJYmqtk/YFZs9FP8BsXE1butP0UI2HeeqkpvXk7wvH90SrqKPgjSZSo0h8WLRVprLX7+e8oWnKdhyytz7MpUzJR/NePqKUBzpFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm5jG73nyRuo4VcgnUgWC3l6TALkzi5GNssLlk/yHso=;
 b=hc7JjTBnIz6fT6cOURkTuZTemPrrZLsGy/fGgZv6wYczY2XF5KJjd9btcF8tyTGN+JMLzQ1s0NGsT3CrISWJqZ2QPaXlG8n7JCbtc4YGBys9VqF9XT6S6pZfuqwytdHNofeZ9jIWlkUbBiMrF1bbLFmFRGLnjT4iuc2kIntojGkAcV57YNyxid7PheTL6rqKvWiIXBA/0uiA3XhEyusE6LqFM5GnJfZyg+GhxzM2ryVXMk6kvYC6W6ddMvbTAk+DIBgJJEoEIgeut6/aD9VqkQJz56rZCWf7KI9lWa3GBYSJawNsKNr3PNbR9jnv8IrG8tXxXb9Gp1OCBOnC1Q3zXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by BYAPR11MB3560.namprd11.prod.outlook.com (2603:10b6:a03:f8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 17:54:38 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b80b:e4b3:5c22:87da]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b80b:e4b3:5c22:87da%6]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 17:54:38 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 11/15] dt-bindings: pwm: intel,keembay: do not require
 pwm-cells
Thread-Topic: [PATCH 11/15] dt-bindings: pwm: intel,keembay: do not require
 pwm-cells
Thread-Index: AQHYIXtJQDADK7SNXUymGTBTO3mi7qyTU4Gw
Date:   Mon, 14 Feb 2022 17:54:38 +0000
Message-ID: <DM6PR11MB4250189900DB0C09D56111B2FB339@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
 <20220214081605.161394-11-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214081605.161394-11-krzysztof.kozlowski@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f721b1e2-1fde-4f19-9fde-08d9efe311ac
x-ms-traffictypediagnostic: BYAPR11MB3560:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3560B544A1DDE4A2A198AAA8FB339@BYAPR11MB3560.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:264;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Th2qsfmksiSrz2xM8bUSqGENfg1OnBAV94Inn5raENYvuAKA/lP3nji934bgWsNFb5hxEmoRi6uzbUiPvjYQVrR4Fe9l+DVMPzcMm9B4ZTII8D1b3LpGgYovOPqJNw9TyV8GyI8soNZ4xysmv3bNSgk9bXiqlvjcykrIX96tytt3GZnRxwytTkSQPFQsQwitbTTBXfgo895NpvTJRpLIQ4uYLRowf6TuIXMJiSJGyFudEmuO1ZCUPUhIsD5BSys4jKd11XZc1nNJbLbtdhDfb8znu+putSn2+n26VfcPXXtWwIiUi1166JS7r8s4Pz5XKi68khr+EyugQ7F7kDmRj3SOLUs5tw0Zzo2xoFOCmyZakuxj5UI4ak/GIV3e7e3PZjjMoXFjzS4bCKGATQUdJJRQZbIoO6+LHGWK+ZLjKVgQMIy2khZ9zRNZE3q+LlDFQHXvWjRjopv5jsItdhWgHo3i/bC97gkF0514QPjigtV/3MeR3i4Dgt1fZYlyL19/03r3hSSQcpIHV4voToDRu7uuPmuDoTEERuw53bzqtVaA0wwBCjujPvgKYj/RgJJB3J8HRqsprYoVKVJ/zjz4Hc5Yjhgz8Hy0RRzZatyEELBQNqOuIgG0N2wBba+J3brahUQOeiPgw68tT1rO7mDdtD/AaI1PCJQg4DWKC4j/W9Uq2BRlfaWOfAdg5hgYtOhe9cBxe9LL3tEI/u3l2/BCif6D28UhAofGvcW9Rm20IvWzdHdcsSn6SqgQ52sl6cVIkD1N7BRi/Vbcww/XPLTyNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(186003)(6506007)(66476007)(66446008)(64756008)(66946007)(76116006)(66556008)(110136005)(8676002)(558084003)(33656002)(7416002)(5660300002)(2906002)(7406005)(9686003)(316002)(86362001)(38100700002)(71200400001)(82960400001)(38070700005)(122000001)(55016003)(921005)(8936002)(7696005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mU1zExsqAmS6wqpKOO5R3WWbVUordWa1nsMyEp30M2t1FCrmsFwZVR8Pju?=
 =?iso-8859-1?Q?TH/0DDoOruYBJEju9RLyvrRLj66Z0MGYb7ByCTcHORzimCE7H+fZO6/hEm?=
 =?iso-8859-1?Q?L4AB67fXrf6foyIjtoCsHLToDqD5pceyzPPs1MI3g0N7dEiiQ5GDiQDnTp?=
 =?iso-8859-1?Q?NsjIwzuv3BHHxdwgddSPYOtlnHxMjDO+UIqyT85JTdoCkPgVmy0xn9Mb9W?=
 =?iso-8859-1?Q?2YlkWHxFphJ0H+Itrfc/VIqTj7GG0/Ho3XdDq+Cj0cqZeyjFiqRhk7FpFp?=
 =?iso-8859-1?Q?eJsucUqB/cAws0Qv/vNdt+VSZEfDqGwVQc+5bSVxYRnF7S9KS5cZM2EMmK?=
 =?iso-8859-1?Q?Ue+ZMPBB5tpVvY7Qd4GtYL0N3/WQTnvoE14IwQoR2FLWjl9pkp04Fzuxeu?=
 =?iso-8859-1?Q?dTBFJaEfo4DsKT5CFekVa/wVyl65+eAd98XlHxMGDZ5Z4bYmzuswr/3wUt?=
 =?iso-8859-1?Q?3L+1vfgENZaDkbbRXoDI0l94WlRD43wtp0O4WKhmpkPDq9XSOJYq6esLLe?=
 =?iso-8859-1?Q?XxgXeEgC5Zs6y/Z0u7XzaIklRjVT7kOim+N0wCQY03l1FRkRluSDiUErMg?=
 =?iso-8859-1?Q?Y04gvR7sLeaLeOULVSEdLQeqhh923pNUYYjtL8fLfRroarWVuyi4b+7MQb?=
 =?iso-8859-1?Q?WsECD6eWdX470tVcD+mz1hMWLk55lkvehd/7LOEnWjr/Atkf/6TiqoT98x?=
 =?iso-8859-1?Q?bSE1R3aRqIYVKMQ7jzLqtw1zhhShGFwOFfMuJ/M5WUjKcHU/eRU8aZHe8A?=
 =?iso-8859-1?Q?IR3BDJqbOlQDNQfss6gSBD89Fv9tusDXj2LlodaVIB1J0/BQNpzCmSOTVl?=
 =?iso-8859-1?Q?k9IdFR3UYlyAE8wmdREpn1Q7VGSlbR60BGB43gYdLGwPg/u340/nUa+FPg?=
 =?iso-8859-1?Q?a8C2i9vCXQGdCRYPuNTrBO6VUqsndUFj985ZmzingqsJ4eUsBZif+JeDdr?=
 =?iso-8859-1?Q?wolSiZqWd9OIZexr6wAABdS1fBwCMO/rlLjR2lKZnvKe2XpqXA42LrzIN3?=
 =?iso-8859-1?Q?E6PNMY5NNLNWTg6NeVIoAwIrFO11bQeGYPx9y7RWHQZqgssdGIDhUvFaIR?=
 =?iso-8859-1?Q?Bllwh/NY5GvxZ9TVRPIT6jL2WDgJWlWWxbe5JEY81WKe2pgtkwIi7H5/Vs?=
 =?iso-8859-1?Q?NPHvqkWQlBWffeXo3XshuFd+gBbOW5H+NNVjFvbONNFtqSFCIdUk0SeHdE?=
 =?iso-8859-1?Q?ua+jsDv27TeOQzbil0jCCpzASf9cP50yHssuMPqwy+0II1b8zKp/V354fa?=
 =?iso-8859-1?Q?rLhLXbyzTBhLF+MlSzDBxQDfVpqJXbbo0CNKMBNJhBxKsBwy3ADmGB2QA8?=
 =?iso-8859-1?Q?Yrkb+qKjx2I8NEIIxs1dHm+7HStGAy97ezMySg6Xk4luvA7Jnz6oe02yXw?=
 =?iso-8859-1?Q?ZuNu2BLEIZlpFH4O5x4Gi4YQNGKES7WcC/gOAR0DZxBxjuLIYfpfjAo3LO?=
 =?iso-8859-1?Q?433VNrwkMPNrzU0e5kc2LJdbuhyVDPGZsNJqO3Kl3jUooBLvKlM68XW5YE?=
 =?iso-8859-1?Q?rUQJJ8tHH6/fLqkpw6hBqlKLeee7EQRhbGQGKMSGlxMkAVz2i77Vhvz6eT?=
 =?iso-8859-1?Q?lcimVbUYygpN78IbjF02wvIr+7E3BMbSBsGgjMy6vli2qX0s9oKCrneCMM?=
 =?iso-8859-1?Q?lsnBIPjkBAP3iLIOzpFkHX2llxb8pMWfRQmZipAw96p1mwU6CJ7SE3LylS?=
 =?iso-8859-1?Q?4gPDPleNslaSZzr5/QIrffzvX6y3pWX/XsQ95/maSZWLXjWkZIfDpjqPXR?=
 =?iso-8859-1?Q?FO0GK5nbytzMfczunxDc7dmcXTnkfTgVOMTDWYliDJs+eCjpF1blJdkSWd?=
 =?iso-8859-1?Q?cPsxzGRN0qu41ui7iOcmYb/DADew2oPDfUX5+9dx/UQ0P2ccOJSj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f721b1e2-1fde-4f19-9fde-08d9efe311ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 17:54:38.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TF4Z/5eoVpGiSMK6t0ay3QQ1UT5F8UcoXLZSYISdQxKudRfSvbrLH7DESC3LlIsgm8kIMl39A0Gx+FstEnfUstnCsE0Q8ZdIGSfrq1eeVsanN6b5xj/c/X/isM2VEgTL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3560
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>pwm-cells are already required by pwm.yaml schema.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
