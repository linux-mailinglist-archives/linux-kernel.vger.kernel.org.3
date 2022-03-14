Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53EF4D7B83
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiCNH1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiCNH1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:27:43 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4F40A1F;
        Mon, 14 Mar 2022 00:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647242792; x=1678778792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bcwH6V1ywcN+6rsMNJzDDSFj3pO0A6vgIRNZfboCUxg=;
  b=P9ZVIfsd2SDI7kfDhjb2Hqac8LgR5xC+Hi9mZkYHZ6Fb2Vk/Pd0R9khk
   87Ies0XtL3SxX5XmtS1QAuQZEfmOlOYNLB4uw/rECPPDsVLlg+kjVhhep
   ffw1suc8UKAkiZdmSrVzhOjg4MCCaSVXdkg+1cdap2t5N43rRkqSvgMS9
   ZOqucGWKD6oSdBU3XDyM7qvguN7VklvxY0KmXvOsi/xD4h4g6AW6zKGuT
   UESNUFJSwawFdYd+cMBMRo7AKcsYyhvYCBR7vg+4l/qmrH9C8k9LQoDID
   E30UL7BeHTviYTIVCS+DfX6EXjyqCWi9fg54+1hST838WeDNP5N3nui/Y
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,180,1643644800"; 
   d="scan'208";a="195283577"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 15:26:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbEMVieZ0E/ZAzUyp276CZjgN/FTKj+dfmnbypDHF2NE3IZEHZVD5UWA60qoscTEBJuW9kIG/hm5cRf7c2c3RQMDhCeXqSQWtqFx2e3A8IWVgZdJ2ibVvfBh51y4z29+ui2lTZ6smgBMYPneH+0df4N/h2D0KKiGSKiMESmdbUmZLJnlyXayd3jlPcAHZtVhu5J+cEiDobs2acaAo0W72dSjsX7V/bm08V7ekiQE5oqrprQ8E98wtsTZVlOFtCyyTyWpM8HY50A2CV0eTInBIBDKS6MI40YtEmsCafu344C5THtcojEJT5GjccVPaotDQ1xme1eTJAfy2ECRYzq5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcwH6V1ywcN+6rsMNJzDDSFj3pO0A6vgIRNZfboCUxg=;
 b=N5o5kw5e4+jLbdw4vsUiEkNZ6Frx27QTnF7Wwo2kZDsFIW9m2P9EfJQmhEbEN14vi3LOF8helj7tf9XelFCSz80y+b4pR52rSKTYxRu3idD8P1brn+SDe86k4LewCH6FY2Tw1tYANMkavuApqauQypJNYkNDvVW7M18Nve/EKHlj0EW9eSyq2VaS1B23DHzTqbptMB7G53kzHGnHKR/YBBbfqK5cK+98SfQlefNwV0bYBy+tBGtCzUp5/Sa+bWmozjOS+AWWZ+g34tPeB22j25ZGrAACdvAnOahzJskugbdAiXFh0pAnWKBbq8+ssgjO/pKtVfmTTgrZ9wXCL7Qejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcwH6V1ywcN+6rsMNJzDDSFj3pO0A6vgIRNZfboCUxg=;
 b=X5JawCYiyKvf0SEEEPB+fwoUlCKheAIvyXii2jtGLGdfj/AHH3tRAYttGf5zT49bYq31+OluG1VpG8V9N0NxpshSGuluefOCQZDU5lJJebZ9gSjtnBBaXbwg4CucZutp91zSbeVM/KrvoLJZj52LiVMqJ2as0AW/NkdS8HasN2Q=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN6PR04MB0708.namprd04.prod.outlook.com (2603:10b6:404:d3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.21; Mon, 14 Mar 2022 07:26:26 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 07:26:26 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Michael Wu <michael@allwinnertech.com>,
        "maintainer:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND... 
        ,commit_signer:11/9=100%,authored:4/9=44%,added_lines:26/61=43% 
        ,removed_lines:25/35=71%" <ulf.hansson@linaro.org>,
        "commit_signer:3/9=33%,authored:4/9=44%,added_lines:26/61=43% 
        ,removed_lines:25/35=71%" <adrian.hunter@intel.com>,
        "commit_signer:1/9=11%,authored:4/9=44%,authored:1/9=11% 
        ,added_lines:26/61=43%,removed_lines:25/35=71%" <beanhuo@micron.com>,
        "commit_signer:1/9=11%,authored:4/9=44%,authored:1/9=11% 
        ,added_lines:26/61=43%,added_lines:4/61=7%,removed_lines:25/35=71% 
        ,removed_lines:3/35=9%" <porzio@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Luca Porzio <porzio@gmail.com>,
        lixiang <lixiang@allwinnertech.com>,
        Bean Huo <beanhuo@micron.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Topic: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Index: AQHYNcu0Jgralp1XlUCNRLBRM2Fhq6y+fT5Q
Date:   Mon, 14 Mar 2022 07:26:26 +0000
Message-ID: <DM6PR04MB6575D203B92955D9A913576CFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
In-Reply-To: <20220312044315.7994-1-michael@allwinnertech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f898a2e2-df7d-4513-5f78-08da058bf302
x-ms-traffictypediagnostic: BN6PR04MB0708:EE_
x-microsoft-antispam-prvs: <BN6PR04MB0708C9C0DFE1C0D1DDDBB741FC0F9@BN6PR04MB0708.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKKsUBCCbTTjYgOqqLmAXF8KCr5A4rKiQ0C00gLFpOKJ5amRUFeA9hoyGO+C2ij1Y6JA1Dd58AftQauA5imb3MMtl17aMvCkQ1Pga5qzQNlSlKHx2eqEG7EMvp7d7SHp6x+jc2lMSngjGurxmC255L6+dB7N0nrGKC3QShLyAAiTdOVv5jcbgrcssA4mdvD2xUItVJohkIolbI20PJqsVcr4StJJnMfVaQx03bE044K/KNGqp7KwIeEDUPPv2mbczy0sU1FLw7/wh5k9pBb2cnQQD3xQUmHWnVyjd8j+r1UwmnKAVx2dFEii5CFnX+niu8+wV+vdOEfjFRC/H3GILwGDsgWMh8UzYte1avkOI+zKQH+9aHBFEOUxPCMwWbDLDzZqyxA4BAfw49VlFRTMGimmw35ixF8ILeJo/h8GobseTW5YbXQeN7kaIuwrcBjGqlnhJhP8qjuZUdad8ZmvGCpaND7M0X+PZhTiZH1GmX24G5p+271EH2AATs89Qw4EtqdbVJDjmBihH+fLZ9IJhZr6mT7lydGFD+zaVmGeoG9zgqVULUEGU52/GUitipGOtQaNhed3sUAZnSgx4gwIlWsO2XIDrYmlr+0Zy5cELyAgHCC8FKuHuLT9y2hrZiUmrIFVnOrFmd57D1yjTlLgCVhacCxyeDRhzS8iKXQBss+cpg8J8ZoLNYxu5ao4A900AP29a3cqzSZaG/QIRF7ErR6Ql9fzW4aQK5xZhEF1kc0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(8676002)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(86362001)(5660300002)(26005)(4326008)(186003)(55016003)(4744005)(38070700005)(52536014)(8936002)(9686003)(508600001)(6506007)(316002)(54906003)(110136005)(122000001)(82960400001)(921005)(7696005)(71200400001)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Io8UlQUpawCKo0jLXx20QGFEVRVO1AIAC1L5UUHlnEABCzsyDJ0/89w+ax8V?=
 =?us-ascii?Q?bueX51PujJkDjQyGS+6RjuKQ3fcDnGPGoSspgPiI2XG8JPbADBcHRDavBBqa?=
 =?us-ascii?Q?ZWWK0G5Izhu2UO6ehyXgBJjMhdTKt8V0R5PqUDrSU3FQG+ZVnv2dvIqqSfo9?=
 =?us-ascii?Q?oFqV7JVc2fud7CRIDEhGFwDZqH2gMrgKkEadcBDKdgVrEeEq7rl1Oah8WWbQ?=
 =?us-ascii?Q?8q56ZDEKwL8v89h/7pcaNLpPaDRgJ0C7/mCv2JMZb+6um9FQooTtOVel+Anc?=
 =?us-ascii?Q?7/c5aXRhU054OX3WSbbEP2LB+4UK5jNDn5t/WWixjToACNLRhFLeGn7AzDUh?=
 =?us-ascii?Q?vqPvT56ZkPJx76/Bv+VGGxWzF8gcyzBjBVwAzY+Kgqe3+pevcABbhiSyDgeS?=
 =?us-ascii?Q?wAM717/Vo/a/SmdGf/mcghKJWGVC6BZDqXO7dErj3XLo0alr6jXinKb/PHkY?=
 =?us-ascii?Q?jn6LJsviTMOGYIBoLYivWCmhS75xn97jZtgHFZFSXGVxDr7IhR8kpiBmNkkb?=
 =?us-ascii?Q?iRe2DY9/QUsakDaEDlLwNBFBpgEa1TXC7VzeA4BJFqdyX9/oC+tFX0Vpxdrm?=
 =?us-ascii?Q?OTEuKs8y8eVarIw9qtP0tKb9byyBTuxfQrdIa2hteweAutYmus0HxGTYsiS1?=
 =?us-ascii?Q?sRJzbhGDNcYVEfNlMZmt9bwJ4G6nq/BYe8jzUrFGsqFElgTj3ux1y4H0b3Be?=
 =?us-ascii?Q?gTqdqTQ/Fny4b33k7EUXMUAUtIeELAWXVedQpBxXLTYWN2+UAEBl/KnYCeQ9?=
 =?us-ascii?Q?kXXprLGSh8Vqaca5U7Fqyw4vMOne8QNdizOgKOn3VG+AEBwkZlFHjXLVh6Y3?=
 =?us-ascii?Q?YbtsOHhKhTkqtnc1I3ffYl1xOpIzOWnjub+SBzn/dq6Go4JxG57mB0iYnFwk?=
 =?us-ascii?Q?Kddn5IvZI1NkZM9ELrQK8SiShcI/l0IquklJ/2Dv9woxPfSD64pv8z9r2vp/?=
 =?us-ascii?Q?U/Ww9xfuvbf6D9TwrD1xdHM/8DDW/ulTxc20jAhjVbnDkmUDWh7KDl7ULn31?=
 =?us-ascii?Q?MPQnfn/jy91YtjrL0k89lt9Vsg0N70S4233Uc+SPvafgm+YBW6hsnWaDJrS0?=
 =?us-ascii?Q?D1dAs0YmE86KEenkFwPT7NrELO4TJhhLK7v8Q4RNAp54WPGSmAkTP7HvQbQC?=
 =?us-ascii?Q?+8E1DX8SoghuQEpPTQ2d7u8dxNHixo8kqPxiCmtAdKip0g5IhoskoR0Cu/6k?=
 =?us-ascii?Q?YI+SMXsd5e4EaxiBpb6ZGxKf/wr7XmXY1UaxL4769tW9u8lNea1SZ1W9olzp?=
 =?us-ascii?Q?E5gPyX0683AQF4Qj+DpbVyvusTvT9s4uQmdnGAtks/GxfdglQOVlSIwZNTrD?=
 =?us-ascii?Q?oiKVlOfLonJTxQWgdpTOed+OrweqmbjWagPjYgLXhwxm5CoKuFe/x56FQ7wS?=
 =?us-ascii?Q?uqoJbjDSbxnNKSgJtduxjHvqrK1P1BFb8igKH4DNK/pAhjgIfA4BESBSqFp3?=
 =?us-ascii?Q?DWTptUunNTL/aMqxcyrBP12J32OrONVb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f898a2e2-df7d-4513-5f78-08da058bf302
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 07:26:26.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zosicn0NT1C7wL900y05I1SZBcbJKuZXDAzK0cOj1BQLtBhaAwUZjydbUHis9fy3WseRvIdkk3m8MVdqkAwYlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0708
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> The mmc core enable cache on default. But it only enables cache-flushing
> when host supports cmd23 and eMMC supports reliable write.
> For hosts which do not support cmd23 or eMMCs which do not support
> reliable write, the cache can not be flushed by `sync` command.
> This may leads to cache data lost.
> This patch enables cache-flushing as long as cache is enabled, no matter =
host
> supports cmd23 and/or eMMC supports reliable write or not.
I looked in the spec and indeed couldn't find why enabling cache is depende=
nt of cmd23/reliable write.
Nor I was able to find the original commit log.

Please allow few days to ask internally.

Thanks,
Avri
