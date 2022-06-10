Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867DD546674
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348681AbiFJMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiFJMTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:19:02 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76C629FE6A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654863541; x=1686399541;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LzulFglMBoesllwk264Jv5fA72Yf7pBzBb27FMzAEqA=;
  b=VQOyRHJCQb1+dV4qz0aUTu7uRjzS1G0Jeg8hkT+jRE3Iwhxa0448bp80
   ZKZetVUeUES4TgkwKhCrDHkm5XCybHKTuc81lkF7idIq6OjA0PUhJ/wQM
   Zp+8QF0F3Fb4QuAJ442ndIhnkASBBJi+0TGTJuScOT4tbXx4EcxDmGu4d
   aePVPwxe5uTtLQ1Mnz/ktVQgNM1pZN50RoNRl7UiTlwLLjqPNUsQuToMT
   wbpyVlimAondgb5Jy3Xa4rvH+/SFKjY0rJqP8NZkf2lBGvhhdsVCrKvvC
   aO8dwS7RYDWjOb5mvpIM97eOhpLViGXEJeRUzyluErR6/HeO2ZFsRz8k0
   A==;
X-IronPort-AV: E=Sophos;i="5.91,290,1647273600"; 
   d="scan'208";a="307079840"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2022 20:19:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDeJG6qKXaa8kFAQkTg0rK46ls+4PIY1sA9mMsQIfMgByL+X+TzTbKdTeCpJvn2tUcJ/3V+WDUwH8gksmSfPRmMOdQ9gGqcHkrgvP840axSQ7vwsIWsUqj9LX3NByk31QYCzwj93G3TCNWsf5tatQ6QzEBIVsPdtCRMSjBgZ4EbLQw34msoN53tbc0EsQLk9Q6yh7xUnAYC47W1/JFBjrVI4VvEhfGyrnZ28V93VqKIuks2HqqNQ/09RFPd430C/KWJsTU5yk+EXmcZu2duj5yl7vmB+ZzKLeJi08VD7O2RkKhidGM6gYI+egodn7EUHsXNJREN7gJH4y/6FvMLCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzulFglMBoesllwk264Jv5fA72Yf7pBzBb27FMzAEqA=;
 b=aqfDk2xDGKJrytpLdQmcjE2AICfEEnHavWxHKWabWItgtvWo/KVhiaL7kRU1GCx8C1w/2jHrYb2HzlUKKOvqGZbS/C/7R8ZhELu9I54AAfu7uJcjHkh172SPYsSA0Wk6Hli288IIsZo8UTL/3AmK8rmrr0LQ3Xx6EVW4CfCYVpXFGaGvXvqN7lxIDMyzSN+mLg9G+Uarczk34aPYsQ8d++vgUJt/zkCZYBKy8cFzKRFyHezfBTKs9zWfeHl+uyqHuq5GJX/Sf2UpBhVteDJsewDPAQINq88vOQqtZ7cgWK/EzhisyYpRbCIIG5vmUVWc74XlfD4nxQn4Yi+dUWUUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzulFglMBoesllwk264Jv5fA72Yf7pBzBb27FMzAEqA=;
 b=zj7tx9nPtxbpdqz2/RADvyP2jpmkU8lq88GDIebmtUxug+nQWQBsL30CpBqYQl0lczyR0gpCLZCEeI8mRXJCt3L1GxjT9gNGB5v8fDVAKWeNR5B5V1Hzx6eIRCwcPncqL9eWyuuV4sOzEs3qHmHTOwnGEjk5aNPzLG+Z2T80KvI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN3PR04MB2161.namprd04.prod.outlook.com (2a01:111:e400:c5f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 12:18:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 12:18:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     keliu <liuke94@huawei.com>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: mcb: Directly use ida_alloc()/free()
Thread-Topic: [PATCH] drivers: mcb: Directly use ida_alloc()/free()
Thread-Index: AQHYfMRB0uPvaSYWfUSTi2n3kA/ZQQ==
Date:   Fri, 10 Jun 2022 12:18:57 +0000
Message-ID: <PH0PR04MB7416F2E5DC9C9580512781229BA69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220527071156.2359578-1-liuke94@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f57afe77-813a-4eeb-8977-08da4adb64bf
x-ms-traffictypediagnostic: BN3PR04MB2161:EE_
x-microsoft-antispam-prvs: <BN3PR04MB2161ED63D5D893013110AADB9BA69@BN3PR04MB2161.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hHOvRChQzZ0/UjPwIxMVfpdSBtlUKZwQiE+6MJrhFIvv8wdTJe15S4IYJVD8qm3H8WLrrtTf3gJUZK5XSfzaIFPi8w/XtCn5HoVsYrtS3XDcLU8cB+JI1JWtRjeY9YwJHMPy/5AOeVTZQt1/MMuuhxpAtb2vkjlp5T8PwFoKjwTPv4iXyQNwy3pCxx7f0DXoSQ1+EZHPrPOBAyllApCKSQ9874P3OjsQZ5xStMi3UXB+Ch/TDLn0aNvDP6ilfIu8Ll9EzX9x9S5Dh4+jbevoxXPXOWyr7shC+l0TTsdyx6mbDlCk/j8Bv5vN16pXY0+AaA1XXmdiiuMUDL8dlRubsIJVYVNkex15dCQxnWi+oSMAHCVfrltRmHkul3IyjUTNXn8L7JQdi3Tr66M12Ss6KxpS8zqlimkscodIUdrZu7qbIL9aDaVIQnf/Ve9HN+8oJnbIm7i+28VVS+NkpB7sJAYr3rYWirLtDEWctPPo2AG8hz8W7ffyv0oRJFcdxISryxPybdtzJXObgVUJL5utX4sfypagUPdA2a/U3q0/ahuhjBOnnbf5eDm1Sh7PnPV7HYyWkQ+f3mOQi03fcCmQTwO40qDgJL7Jsd4y5EMs975wqQ1MceIpBieIVjtaLBL4kXCD+rV+hd9ynYfsggCHzEmREKLxNZPXaP5MD+pci90UgCwggMlY3eGWbmPl/OaEurdLRpEn5XBysRQZb3Hp5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(66476007)(66446008)(8936002)(76116006)(8676002)(316002)(64756008)(91956017)(5660300002)(55016003)(86362001)(110136005)(33656002)(558084003)(52536014)(2906002)(9686003)(6506007)(186003)(82960400001)(508600001)(122000001)(38100700002)(38070700005)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?trhbyPsxblJ03j/l1KPjpJQ4k9E7Hlk2LlcY/fsR9/Ipu3pTtZ5zTm8jWxu/?=
 =?us-ascii?Q?4eKnccdfVnc6zJQy7/C2BtyY0/BCQw3M6MqTRfQy99WutQ6TOQGVtcBuXnhG?=
 =?us-ascii?Q?rvhtxeaP5S2sIow4HfICzSx7GtnFdeZOKxRi/+VYQiH+/i7gVB/GqeTsGllE?=
 =?us-ascii?Q?pM3I+KaGWxICvEoT/d9UmuhXb0i1dqkFrb2iA0C8HRebWh/iM3uhBNDQyZjI?=
 =?us-ascii?Q?z0PZzUpu0Wrj7S6vvPIwJnw5OY2NrEd8O5ul/vx9gi3wyeJUJ1G9oQD3wVGF?=
 =?us-ascii?Q?8vM+wbarMMAoompYgOJJzf91v81qCbQVTEgbdalJ7hyakScGMcX1oWBy4jnc?=
 =?us-ascii?Q?e+LmJwLRyF+6g+yWkBNZibBuTtiV5NZHbwoUWZHJ0mPVF/qK3v9AyTZ2fcyP?=
 =?us-ascii?Q?fZOy8xBor34HdJriSltRGsK1a5upVYl5ro2M/SIJNCnh44LJwxR039zJld16?=
 =?us-ascii?Q?6+oDeNrolH7Ww/iyTT3T39DELZOTD7a7CH6mpy6juxvjqiMZjYksVkzNqokZ?=
 =?us-ascii?Q?dGFwsYERc3AAZdgVVOxg5ct4g/FpliifPD1wg0wK8IhK1rDwWlGu0+jhlenD?=
 =?us-ascii?Q?UNCqd27nRx9hxXHbORbEckM2JgqU16e2rZAbikkjM4HfKtWHCO9hcPqqxSqm?=
 =?us-ascii?Q?eavhA2LB6cuvc2tIW+0UnUJpf8sHBzdYxIe3yFZkxSgB48x6C6ogc8l2Ehi9?=
 =?us-ascii?Q?B1CBNU69oUlauX5CAammf9m2O5fUnCLcc5lJfoY06Bu91OJmC1bImUidJh3o?=
 =?us-ascii?Q?81NQZyCnR54jpmI1DhQjWAU0Z3sp75AUOQLqLKGWMo0zlZdh613tBJeTkjrA?=
 =?us-ascii?Q?AtuO6V/63txkPxyRO8ekkOzQEP1G+B6bJOja07TowURyx97aYdzdXNLMYUFd?=
 =?us-ascii?Q?nmLOZedaJ3ou9BwD9n/tFIQp1fbFeSFIA5fJcRC4AdnGLf+4H4e+ghdMkUxy?=
 =?us-ascii?Q?hP/Z2XzHt4RyUkCmAnWIBPNNU05D3EOLiKGMf8RyFY0z/svgE9D64KL/AKzM?=
 =?us-ascii?Q?7jE5UNTAeW/K1TesmQuyKVVmSbt6QPn7QcrzKh+teSS+Yyzs48ce7X50OTFi?=
 =?us-ascii?Q?MdnoaLYOpFgcWmiAowiBwQIYO2YysimWfAJGM7Jwqb/SQnLPJGhlic+o3PU7?=
 =?us-ascii?Q?g1wxBUJ42OKtqaPKpwsPj9TgaVhha3X5RCEFXYynQrGBB2KvLAG9PfpbSz0k?=
 =?us-ascii?Q?GE1YB1Yp8e0pTUvb4V6ATvUxGAPYlg7MRR+WMhaVaWu6FLZN9hx4OOOj02i9?=
 =?us-ascii?Q?oFyckshVLWiNFib8fT0qj9M7vhdN0QvU/MC6byamkM6gp6UjCjxD7brWeIQC?=
 =?us-ascii?Q?I8/rTiCVgdHe2qOHAd8Tej1jTRXut+SnL14cGel97lK4YpVQNrmF+TbXIEL0?=
 =?us-ascii?Q?RM0qp9fyTzwT1Ejr3EReQY1rHN+72kvhbuHTTWz5HohERJ8ZsI8NM7vjAbQQ?=
 =?us-ascii?Q?AMNxKzLfVz6DNpVl/seaRZwrbehAUVkIjaQBLcZrlxAxImF3ZXB41kei8o0l?=
 =?us-ascii?Q?QGABeNGcUfx6d1YrAdu2fHB0v3yV1C+Pz/Nb3oMJClht0Ibv1nFB/cXN9tja?=
 =?us-ascii?Q?s+oiiTZ2PJQXryWVTm2ElverZKqiS354JdN4mkdy+/Opjb48otYjpZeEeEBq?=
 =?us-ascii?Q?oz5bFeZ8UgVUL8v8SJsIU1kDEH+kAqx9DIf3E4ti1S8irs1vCQ82rZDCVZDt?=
 =?us-ascii?Q?8A6Hm+cAbwMuImdwqWvq1tLxneqm9aEL4uYV6ofFkWAP3zLv68W8vEzTxslW?=
 =?us-ascii?Q?499B8XZQ4P1ikVF8EQy50/0FqZBBG6ZflEfeBQVNtfexeHWtqA9zFx0QAUst?=
x-ms-exchange-antispam-messagedata-1: EA0FspoDer6u644kn0Na8jLZAzLjX4Z+5Z/EJFYBA/uTLiG24266JWT+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57afe77-813a-4eeb-8977-08da4adb64bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 12:18:57.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNKrP7tfRi1EyBlJB/MMyX/HZYbRYEk2phID7cZcf+GPgP/JWWQ7iyrlDsUmyeE2sonKEEoI+zhowaQRqG8tTqOmNjKXjO0Ulh8ByW7ggVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2161
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,=0A=
I'll queue it up for 5.20=0A=
