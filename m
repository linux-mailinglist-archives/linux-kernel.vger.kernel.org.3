Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7914D78A0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 23:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiCMWqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 18:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiCMWqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 18:46:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967474616
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 15:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0tz4GpDjYhkVNB7LZZC59nelFU7bkRP/IjlJ9ocdHxDhotefPmR/svTFw83UZwS/tq1gcCU5Cr8go6quyFSvZcDIg5QAv1lTQGUOQFmGRZPKSvg8+j5kX72I8N5TT4wVETcpGhj6cwO2h3LBt39iZ6K2oayTXCZ63ZInoCjcWRlDs6rhEx9DfNFV3XlLqleZHbIRh8ea3tg4om1Hc5m8bHnYRNLMYQGUiOPOs1WiAVBbgjq9BuXQ7qekBoQGJNyhBRUmhM3xkjhsgvtcmn0z++MKeSMUaYKVSKUUuHbheja2Xuu04S2lu5KB4krtD8PspFsXrbxu2nx+TQpPKDY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeySgBclTvkWUy5IwTcS8H4IaM0bjl+/vdn644eCILg=;
 b=mf6GE8rnt6CRiIwAH3AI9ZN4poq+K/PznhKQX7o3glg8VWBsFUNO0F3sjJkBF4x+uyLqycP2c+pa/M0JwYtFv4nAdWuznd7BveNQNYVd4KxnFu3MZqeXz1SnrncprpT8sU8MgWZrUMlSXNkRyAhEm2A5+pCm20Gy/cV9QiobW+cBy+rg8VkAMaIkGFrraLci12lRsi4yqpfm0TjcQzOOHOKMbx2tXFUpjjrQacqYeuih+xeii035WcTel58PZfbQfSGFhT1Yq8Y8dyAhQM1bDSdqtr51kf8RF5A9n6JEYpDq9tmNsUqhhRuDKqoupQq5OrUCQ3m8kKv9X5LirkTZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeySgBclTvkWUy5IwTcS8H4IaM0bjl+/vdn644eCILg=;
 b=of4zza35jqSErt8s2vNV2X7lNhXX8BdLyh0d9XGFUddJ0NALNum1+A+p8jNqW7sFX2QOWbt61BN5Uaa21Nq32zn9+VsRAUQy0q0PxKa2rWtXox1o9Peo3kaVCUhs7Qrb+bR+UAqBzVkO9nvSAo/GjUwqRENZD+dgejYkWXcqZwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by DM5PR1001MB2379.namprd10.prod.outlook.com
 (2603:10b6:4:30::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Sun, 13 Mar
 2022 22:45:37 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 22:45:36 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [RFC v1 0/2] Add more detailed regmap formatting capabilities
Date:   Sun, 13 Mar 2022 15:45:22 -0700
Message-Id: <20220313224524.399947-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:301:15::23) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b8e775-ccd8-4c7f-2e45-08da054330b7
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2379:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2379180CAD1C1CB66A8F7F21A40E9@DM5PR1001MB2379.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atzSj7nxvWXNjwQeEwo/Jic13YBH/br8Hd1yoJAWmoLW5Nl5mbw3nUG++0ri/6FmOgcpZOTfxTl8Fg2y5bdbfyeJH2HRnMnB8jPXrKqx4xAlHBOi3eurKoaOcDuCqFN9v1zY7UiBbuFPBHtdDpEIW6JkDCAu5Qgp1Lre9Lxps0YVLaamUrA9ffv98IbIrOEFx6wMvV7+0tI10k2tgowHQOym5RUoDD2dV4k3ibsRKVjFzNPHai3OI+/FYLzPEYeC+6ao1ahnr3MG4Hj/nWCw8x1t7PGZdYu/0osvdNTXqL9dnhBPkxuVNJlEkvwG4XwJUecsiCvYsh18XJbIop4XVxRjVPxWlm1kHkvCmBEEOde7fYg25kwhlzcKa6bPYUr1gHkEnGfQ//MjvkK1UAAIrouLAagGTRvW6f3VXHloVoP5MwVZzIeSzvadLadY8u1coS6ChzTBWm8mqTYSVwJFp4Gw7VS0HR97pCdtWduVwW2LkSuNmhsWGQs9JyskdfKhK9wAPep+hQBQfANGo9k7CPS60Qk3wBodE6nl6cLyXQDgaRDO0VlWTbZI8m5ZhiAxRQ9B44Zjp5/M+XR4BF9nHvn7RwIPLNIGExsDQl2+XW+RgTe9uBTnzoczI5K1M0Mm0k5pBv7772pzxQygkdhq2xzX1SkkP/un83lsDtd9xEAqremMwGl2F/afZMgHPSNj1TkOfHMyYToudatg6Iizxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(136003)(346002)(396003)(366004)(376002)(1076003)(66946007)(6916009)(316002)(4326008)(8676002)(6506007)(66556008)(66476007)(2616005)(6486002)(36756003)(26005)(186003)(83380400001)(6666004)(52116002)(6512007)(86362001)(38350700002)(38100700002)(5660300002)(2906002)(8936002)(44832011)(508600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4K5tJiYm6Yez1YOM+ddjCSQtDhMtNKGRh7xPEoAw/1Ytr1HmUWbdS1MsCV9L?=
 =?us-ascii?Q?i01R+agaWt1G8O7vt58QaFRJEpvfGfIiFiJVjRF6cpiwxchOTig6AKMEaZND?=
 =?us-ascii?Q?hw/RyraQ/4mZLgwpTearZO47zjeQBB+XVgxHGeK2pItFW8GpYLrh9f9faa+C?=
 =?us-ascii?Q?3d7+AMwZRpe70/u/Tt2+f4gX6JMO2EtCI+quJwf2YC5CmYw1Xy6TanWnIutI?=
 =?us-ascii?Q?mWI/zkOZpilDHyRQ8fSUlcGVFt9FQokHIRabpTmPJnAJeuzHCwmXaYrrrDl0?=
 =?us-ascii?Q?b0k1PLtfRD0sY0sedCYesXCLUMxK17U9xVtpvXsGroRPJJRglqSeOymydFVP?=
 =?us-ascii?Q?KhseT4LkdkBpD+1GZAlG1wR58KRuXvf+wqLyU6evYO2fCxWlMYdZC3XulSay?=
 =?us-ascii?Q?83b06+Y+VYpTPW1YGJsFtMzAW5Ap76nB77x7+vQpDPZDCwkzOvG20ccF/Rbs?=
 =?us-ascii?Q?QjOcyBZqEQpUkzfMCkLFPD8+TmC8cQisYpyfQvb1s7CQLpAdjmLz0oHSW97m?=
 =?us-ascii?Q?NJ6E3iUkEDy6E/ffOykfJ0XX8ji0iIANCGtP6aIfei/lWae9C12KNqfVmFtR?=
 =?us-ascii?Q?tkF/i3/aUBRP1AJVjmSoJFja2qrdQDyDYtja5IcqLlvZT5husKJ0yquqsmhC?=
 =?us-ascii?Q?P+3/vWRzIAbq63PJsF8cNmCNQzYJ9I71iEmVreH/N5zkjRmZNiAEhppEE6jy?=
 =?us-ascii?Q?PaRAOQ6IQZGtOKkXgXamTGhYz3J3rnpeNAv4GqJPboQMIVIxrQm4QQ+YgE8n?=
 =?us-ascii?Q?feOnP2JM6X7Mce+LD3NQz5iEduc4HDIBW7Qm/BHY3hljZTIWRJb4BRVnFamX?=
 =?us-ascii?Q?Yr8CPLR6yFQHfNGOZ+poFWkcDOA2bhGGX20JXrVtyFBefutj9uhZkbNBzsTP?=
 =?us-ascii?Q?l/Kg69Hd9htMglfkgamfehlK4t5DZSrCQP3+NbeV8Sbki68+gMZRzKMExul9?=
 =?us-ascii?Q?bWnXUcLzDnK0GjwE1VftvAawkEKHCuRym6NjuEx7ZuTdXlnawEceBbRbwXO1?=
 =?us-ascii?Q?6HQ1/79jf11yIsYR2+qnGff9ZxisNvChhhsrOHkla1RvY/rXC6NhIavsYXVR?=
 =?us-ascii?Q?el0pHXRyGEn31SgwWeWPbXmiaczrOWTWj3HXK7plYRLAsyEturQxQK2uAB0m?=
 =?us-ascii?Q?2igoQb2mgYRRWXhVN2xIT2184jbDhJo6w9XXNPlnRu9OwPo2NrCcPB0s8CIW?=
 =?us-ascii?Q?W/hidkN4ILBx1hxrrVxMAOquVI1QaAOsJ+sXyCwagrWvVRir+d5sQ85DgaBC?=
 =?us-ascii?Q?PCvWXbs9jyivi9XVOchT8Zgs1wNxNVqp6fUKL+AlZEmBjlOtQk1CRUlINBVT?=
 =?us-ascii?Q?AjF3R74rK9hpNRbqj1D09R/36+NU7jGAEGSqpLVFzq9k2tbjAx0G3D98jVTU?=
 =?us-ascii?Q?7Eqd7mHOI0hSvlrODjE57rgokLZBPc8pOulG0dWE+TzlbCVy/u/hSWzFJoE9?=
 =?us-ascii?Q?LWqzfNLkeHWFyYt/rmckTmU4LgooTXFiCcqYxTmAX3Inr6zIRIx0Wurix/gM?=
 =?us-ascii?Q?aK8tpqIMwYVTCTGqvHzFCLTQS7dZ5Jym8G8+Be3zoBZ1GtQnQ/j1hX9pTco6?=
 =?us-ascii?Q?2EzMn/Z1d88MGEMcOt2TAIvn2nf9Bt7CSlMSq+yEXnW6/f1atwvz74iP+HEd?=
 =?us-ascii?Q?+1Sne4f5jOa6wbl+PAhlbMJOoP8o2hoI4PI3pgUBRtwOQlzx/dwD58v9oHbH?=
 =?us-ascii?Q?6BO4Vg=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b8e775-ccd8-4c7f-2e45-08da054330b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 22:45:36.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9RIOEB7/BxLlvWIh70dkkSRZP0sGnWP6mz3WT/GBF8i4hjxjEFimqvDGVb8TUxh/WgSNHIIz0ttBYcJYZXPNIFHzFbE6MEzIxK4OM+vemY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2379
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ocelot chips (specifically the VSC7512 I'm using) have a method of
accessing their registers internally via MMIO, or externally via SPI.
When accessing these registers externally, a 24-bit address is used and
downshifted by two. The manual references it as:

SI_ADDR = (REG_ADDR & 0x00FFFFFF) >> 2;

By adding this configurable downshift, and a configurable register base
address, the regmap definitions can be shared between MMIO and SPI
configurations.

This also allows regmap to be used in a bus configuration. My initial
testing shows that even at a much slower bus speed of 500KHz, I'm seeing
an improvement of 10ms (was 14... now 4) to perform bulk read operations.

The relevant MMIO code can be found in drivers/net/mscc/ocelot_io.c:

static struct regmap_config ocelot_regmap_config = {
        .reg_bits       = 32,
        .val_bits       = 32,
        .reg_stride     = 4,
};

struct regmap *ocelot_regmap_init(struct ocelot *ocelot, struct resource *res)
{
        void __iomem *regs;

        regs = devm_ioremap_resource(ocelot->dev, res);
        if (IS_ERR(regs))
                return ERR_CAST(regs);

        ocelot_regmap_config.name = res->name;

        return devm_regmap_init_mmio(ocelot->dev, regs, &ocelot_regmap_config);
}


And the SPI counterpart is slightly more complex:


static const struct regmap_config ocelot_spi_regmap_config = {
        .reg_bits = 24,
        .reg_stride = 4,
        .reg_downshift = 2,
        .val_bits = 32,

        .write_flag_mask = 0x80,

        .max_register = 0xffffffff,
        .use_single_write = true,
        .can_multi_write = false,

        .reg_format_endian = REGMAP_ENDIAN_BIG,
        .val_format_endian = REGMAP_ENDIAN_NATIVE,
};

static const struct regmap_bus ocelot_spi_regmap_bus = {
       .write = ocelot_spi_regmap_bus_write,
       .read = ocelot_spi_regmap_bus_read,
};

struct regmap *
ocelot_spi_devm_get_regmap(struct ocelot_core *core, struct device *child,
                           const struct resource *res)
{
        struct regmap_config regmap_config;

        memcpy(&regmap_config, &ocelot_spi_regmap_config,
               sizeof(ocelot_spi_regmap_config));

        regmap_config.name = res->name;
        regmap_config.max_register = res->end - res->start;
        regmap_config.reg_base = res->start;

        return devm_regmap_init(child, &ocelot_spi_regmap_bus, core,
                                &regmap_config);
}


If there's anything I missed, or if there's a different way to go about
this, please let me know. I can also drag this along with my VSC7512
development or I can send this patch (or whatever it might become) after
the merge window.


Colin Foster (2):
  regmap: add configurable downshift for addresses
  regmap: allow a defined reg_base to be added to every address

 drivers/base/regmap/internal.h |  2 ++
 drivers/base/regmap/regmap.c   | 11 +++++++++++
 include/linux/regmap.h         |  6 ++++++
 3 files changed, 19 insertions(+)

-- 
2.25.1

