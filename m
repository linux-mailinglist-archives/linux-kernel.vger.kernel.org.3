Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213A450E6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbiDYRRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243916AbiDYRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:17:40 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130087.outbound.protection.outlook.com [40.107.13.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DF417E3F;
        Mon, 25 Apr 2022 10:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jne0rA06Dw8AeOi+E67k9JaFCZ3E6rKaRlZW9sLK5pYdxoLqDWILSED7s+AmasV5HVbXt4wJ5BL8K6eIx+oG4S87RpHaz9D8ocE7PqjG46N2st727UkfmxRE31fZMwj7qnA7uzzJ799wjDGqs36GrmrqPvEqdfgd6Qvgyz6LAo3jlxBsMxMxWfKqtpayCzI/hMHfIVnqmH8p5mvMThX8+WuJd3hoNZaK4FI2oPBaaNXFIaEqA+ybbKHq+SZkMiuqbuoovbEr7eMA+ti7msB25l0pOMTM/aSDgw20xxDtylSfMtfHApWMiY/krVTOzuWaRHJSqzr++Cm5X/sUHsqnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4aGJmhX6N6qtc09nkPksdNbxdJ98Mq/5PIB6uX9GQY=;
 b=m+Wx48rIy3WhJW6UmoX672FoYkgwzq0vLwm8XFDmvwnGAZ4lD4/aUgA+Kq70/ssKPeHgnnuzpYqi8ykBqQigdKXcLRZhyCdal6aLnTRR8dYjMPE5PsaiWCaDXRZtpNaXPAjQcrwWEQ1oRz/uFlhrqNe04l9KDlxabeMjqi1V3Z/ozme2T7D94jsOxZuFQaEdMLHkcL4cXAjuWTDbDl0QwCf2xN/EGemciArML1WtNX/Z0y5pYT5gmQxV8K/yPw1THg1a0bWzaGD5z0h9V6Y9ylluG5vnPt01H/QV8ET0yRKbHkdrxxYM21eJRJiaUG5AeGxFgWOFFOD1l18Y5FMUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4aGJmhX6N6qtc09nkPksdNbxdJ98Mq/5PIB6uX9GQY=;
 b=J0gqz2ofudyK73W5ReUSrt3FplZ0r0clb003hOb6tHFSrBAoaoOYHf11M69An9N77XJb+OYyTt8WNXEy80uJXzXcg3HqI138kufpuRgma4DBo0XAKvpCf3x2ntPh7MLRxkcZNjv32vVb0v7HbmwY5jJpbdaoe81tca/it4UPV7CaW9TK6FADR4zf4HMS8/KxBL4wmNpvdpkTOQ58XH5SL54TCcYNxicGejpmtM1JPcvh+Jh46EJIJX2khLHYUGjsiSzCP4M4vu2wvv6FhJTXWP1gRgndm1akRKKiKHc5p5Ys50idFkZSXNdu4zN1gB5xMlJum7FJpe9kuk2liw3FgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM6PR03MB3736.eurprd03.prod.outlook.com (2603:10a6:209:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 17:14:32 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 17:14:32 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] usb: phy: generic: Support enabling/disabling VBUS
Date:   Mon, 25 Apr 2022 13:14:07 -0400
Message-Id: <20220425171412.1188485-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e65f353-42c7-43ce-b2d7-08da26df1002
X-MS-TrafficTypeDiagnostic: AM6PR03MB3736:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB3736F57EB86B7D4D559640E996F89@AM6PR03MB3736.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgltJKFlRSBqjZO115OrypcnrYCb33wPf325kJoRmgahP6VVYh00VhKgpHPd/f/rd1bGOrPqwiga71gmwvECzsHu1b5j0yjTdT2SHm6mknhHi+vy5ZLvvCC8cAD3GFYcvB2nKNJZtgXAdebZzh7+p2ufR7/my7R1rGXekMckVr+P9/DSNw0Qe0iUWf4aKLs249F5OpVNelQIea7EayLaXm8RMobEny32NRPlXAkCm1b9QN0MVSWZhCtGhBerZxKvoUysVGLR4pTFkO+oVDu3I2h4YiogBMLeL5kRM9ZmtZJ/GLo2IPvP2jkmqyKw6lJdZzG5hMwrildSHZGlmcIZVmG+sf9DqCr80EaEoTcgjp82ZpIIQr0Vr3DMBITBtI0FPjzFhg24d+qSOtHgUInZDxyDyrzgPPO5DBp5o/GUdRGY0dWrmK6HZjdPh+Yl1nUES1sqrKeW5rxx0G0IJVwX3n1shLm2Jz0ABRJBSZegdcKCc4blojEs37627kKqzJphtCLltLX//CaK2jsJlTnnpQHM7CwpDVmWWkERgmK7ltMeh4jU6X0nmg17q3yR+ogApsMrEWpNVxtMUkRShWJun4agBYjipmnrj0IpABNPNyXQaog3Q2oGtSiVWoLu3LfVjQ1nVLRy5HStobyX1k8I1HrRXVVSyLAMqWu4jO2ju33jM6ILspvJgigkJKYXhLwR3GeHo6EGr2VJ1dU4Yikq7ZM12YSSMStG9McRfSEC/tq/+NcM3DX6lzYfidL3DAQwcOXF2UtbIxT8fSZfES3UwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(38350700002)(38100700002)(6666004)(1076003)(186003)(26005)(2616005)(5660300002)(7416002)(316002)(36756003)(44832011)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(52116002)(86362001)(6512007)(2906002)(6506007)(508600001)(83380400001)(6486002)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2e2P+hur/8kJoa5K1/fiGJI7/OyxQltPaYGQlnWWWsmsrbhp56FUBQWkwue?=
 =?us-ascii?Q?UhwIOAxqeGGqY1iKMEY1YmCSR7Vq4h7XbNzDVkD/oj/v5IpnIGiziDzdVj1N?=
 =?us-ascii?Q?lh+UEtJfON9s2mEXho37SmT5DbOL/F0fxNUVN2dB10p0PVCMi3oUGLCHONin?=
 =?us-ascii?Q?x+XKYtYamLQZrXGynwP/oifsjJm7OnDnz0GKP4RuepO1Z+WRmZzZQOev6Vjb?=
 =?us-ascii?Q?eWDg2Dl1/m3C0IMwkkwAdDyl7O2LXTkRfTMI+hTiEd7vCPPsJc4RLYpa9MUW?=
 =?us-ascii?Q?4D8KhcMso98UCPBDWkQigiV/rlhngSYDySfi3/zaCEIFTC6R5MkP/1BxxFgb?=
 =?us-ascii?Q?uC0jGXxK5QE+aZCzr5NoF6oOAb9/762IdWc6b+LgtbtxvG1UB8Zj+X1ooqQt?=
 =?us-ascii?Q?5/Odl/XgEaJna4Hx6rOgSdDducJxBNFZ10rvoz6w/h2D0r+0kF1Mrru3Kvt2?=
 =?us-ascii?Q?C7lswyeDcGKyKSXFxfQFoH+KXzSHy6ZaAVtd0WL1krJuxS2ybadUz3DOfwme?=
 =?us-ascii?Q?a56TRuzxVN65jKqWA4kTObOlJP3x5qSnlWzzMfuZW+xWo+O8VO+EaD/74PZ2?=
 =?us-ascii?Q?Yn4KHgZfrav6zf0bXrFliFKdGmzC4zq/X067E2GNKZ6hxQdv65ofuP0MBQl6?=
 =?us-ascii?Q?/2L0ypVBOLVH7OMZ424rjvIyXhNPaeQ8IAHeWBJMbfS9MYysk78h5cBkhgzm?=
 =?us-ascii?Q?xSTIf/bCkIhICc3aJGjG7mixxv11Gasf5Mvb6QXlb3/IwZzhI1lNNeJBGoFG?=
 =?us-ascii?Q?ESm6aG2PgIoMaVxXXo0ZTMaMcVkmJPV6illCI6JI3mmZJE8ggg74Hle6BxwK?=
 =?us-ascii?Q?nI/4dzhzIYw16BNP6q38Z3m5PWpO5oLDua+2RfbkiabkBcjTjhFvbrXJBosG?=
 =?us-ascii?Q?0Z6ZTpsxrkalFUY+DAChkaq6lsZ7AhmdsBFON1VJFAqA3lCDX/prkXxUJ0gA?=
 =?us-ascii?Q?uk/LIibJOdoQ5Wtas8Q+a1qCN041pMHGc223y4AhCu6hgNqN5rZPNfq7uiW+?=
 =?us-ascii?Q?N+SGUrjC1jdL0EBRujF1PPW85VUx5YijV2wpqvNNvCX5Xmj92tcPbguUMEwD?=
 =?us-ascii?Q?5C0XPM+MF0pt8qQVxUKzwQqP6IgN3ZQePJ+Pkm9USEfoCLyM9V8WXq3l82Ue?=
 =?us-ascii?Q?NCcUVbo2sT836MkiaEEeXg3kh5sV0lBCMxfGEoJxOHfOYWL7EN3+l3nVK1LL?=
 =?us-ascii?Q?z6Hs2VaxlFCuDve2BUywuuZLAx4RdwWplOGCgxUUGUe3Uj38GRHXy+krqg4O?=
 =?us-ascii?Q?9ghwHtR+LioXZwEg2ESYlkH1gOh7+bokJRb19QfEo/H3nE/bCbIHXUBXWcI/?=
 =?us-ascii?Q?qKISvq4qOYaBsG4qLexn7Be8PNsjxweJ4tnN4VcuBg6vqUPy0ctMQk4X/tLb?=
 =?us-ascii?Q?vIlLfi6rPnyZ3BQJ4eQGfL+Y/viLvMTQxSF2jPQprVEugoaT4hJKOLtGpquu?=
 =?us-ascii?Q?Jt7Y73DG3qPR/e51oKadM6xGUhicTpE9Wummu0tMEy837aMtQZxotIFchIUG?=
 =?us-ascii?Q?KDMby5f9tiuvLoBysheaNIG8cs99ENIpGwIh/GdosGrpb1p2shI6sM2B4Zw9?=
 =?us-ascii?Q?oN+Y48GWYASLpYiCAh4yGOXTq3jeF0klI6X7ckJuW5X8o27jBhkMFsh16Ezi?=
 =?us-ascii?Q?AXSPD+Y2BqBDWbJfIem4M2PHR3Mb/bo1L/DlUvZgKpuRgEqugp7k5h4swlmy?=
 =?us-ascii?Q?ErEtsx1H2jMXYc2Ar9RMXSESs7Vept+zPPaHgsV22aPhEM2/uLOj/UuXlZwM?=
 =?us-ascii?Q?ht3U69EUppotvorpIQ9jCREqpB37pFM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e65f353-42c7-43ce-b2d7-08da26df1002
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 17:14:32.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS6WHySsjCEoRjRXbct6LdtD6QYkNOsgS8ZxqKmlCwUpZb+AaRaSm2fnP4wcCnUn/54J68qqckxvD2WNR9okpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic USB phy has had VBUS-related code for a long time, but it
has always been broken, since the regulator was never gotten from the
device tree. However, the support itself seems not very useful, since
e.g.  usb_phy_vbus_on/off has no users and usb_phy_set_power is only
used by gadgets to make sure they don't draw too much current. Instead,
use the VBUS regulator to implement otg_set_vbus, which is called from
several drivers. This results in a change in semantics of VBUS, but
since support was always broken I don't think this will have any affect.

This got no (non-automated) feedback for an entire release cycle. I'm
sending v2 with a wider CC list so hopefully someone can review it in
time for 5.19.

Changes in v2:
- Fix dt_binding_check errors

Sean Anderson (4):
  dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
  usb: phy: generic: Get the vbus supply
  usb: phy: generic: Implement otg->set_vbus
  usb: phy: generic: Disable vbus on removal

 .../bindings/usb/usb-nop-xceiv.yaml           |  9 ++-
 drivers/usb/phy/phy-generic.c                 | 55 +++++++++----------
 2 files changed, 31 insertions(+), 33 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

