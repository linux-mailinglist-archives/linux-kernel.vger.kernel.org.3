Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1056261A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiF3Wce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiF3Wcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:32:32 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E313357219;
        Thu, 30 Jun 2022 15:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQ0i5MMaL9v3aStFn9J+88o6Ks0OryJoLNX+3mdnoSIKdo9OaVxjcmjAGVrSiLPhLO9LVLnyvUgaHZZuj6Sk7YlWECSqta0lEKdWFn58n2dZlJnQsSpoNQZ2MuqSFGnQ1JHwJtSD1wfWtRjrwsYXU2t7d+AttOw9g5WBPPbd9InATZsqr/nB0qL8GjKu9YVSJC+Yh7qqh6u/YqaMmML/aY5yXMWOlPBGhJ2zASki/w2dlhMv17NzhD4r323OL/HMzCHEaA8725tjq7nb0kElS0+EaUuYC2wM+kyoFowQrwsyJLnsm56gIkwC19RC+9y51X70eeNsXSZc46fsjxq+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6JEEiwXbbAsQzfCZ9XjfwWMQFHUFwqv/+R1UDX9sR0=;
 b=hLWCA3hxBNFFsyWKVESs5qyzCdhfDMsoIZFcRMTCblok1roIPgeBum2t9hc+DONL0uiDhZniPCfNrsuL8KDJh91q17nbEQ+Emf80kcllyug10tnyoKMnxjs8toxCzpjRv2Anw+3rXBUNr4fZk5vcEfI89caFA9hFSKy95p+j2P/ropRkxujLExaQI0DDfvHF4UZrWs8WfXXtGU4aktaJHZMIcTl2lKZC17wcjpMiDxmVpYglLaprCNqOtswGk6AOv234d29D2RB2QoC55wG8ovoPeLrkLjGcGjZ61ri6+z19uXbA5ra5aIHLjzJ89FOJjm5NQi5vf9Djgg10qkx7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6JEEiwXbbAsQzfCZ9XjfwWMQFHUFwqv/+R1UDX9sR0=;
 b=F5U9BKXldZLzeDgVuLEEs1hNw7qy4gal8XJvlWw/CmZar2M3K4IuJy/xrs51SV+HxwhelHEi4bxyRFP8+GuYNhC47fCtrUc2Jlx/rBCIslERQ7nESzjeO0xpCR5R4KUFtXL4vxV+FL36WRH/FjFN9cT3U4JURykY6hhnMcFEMf0WMYDjMyj+eRkbE8u5qbJUI6QrsuSXNRNQYwjECJ1z1O6SDuzDeb4QqTVB3CoCMLMVg3tZnxh/UyKEnfo8fJS6XowzBhkpBlkMkO3jwmJvvnxlO49kyxWxLfC1yD+CKvBEn4MI3JuvlrPopDQEB6djbEVxMQ8AjMUm6UB5lms37A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB8PR03MB5884.eurprd03.prod.outlook.com (2603:10a6:10:e3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 22:32:26 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 22:32:26 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v4 0/4] nvmem: sfp: binding updates
Date:   Thu, 30 Jun 2022 18:32:03 -0400
Message-Id: <20220630223207.1687329-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::24) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17446fff-7c33-4ac8-f346-08da5ae868b3
X-MS-TrafficTypeDiagnostic: DB8PR03MB5884:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ir+OV3/R+axJnYJVT6wv+apTec2MHfRldtsCF1qW41nEvdxsNlrdGUzNOIRJqtPlxP4DgeZY9B0fRobNXRd6/C8ERuDAnytBt+DoPKFowKKa/INRB5ljSkqcHgkomXiCABTmBKds6yBBLWBhJZKO1cZgw7NTSDkBApwiBlaV0TiiDf55YzJV6ceOi/ZzQ5m23Ujb6X4gIX9JItjd44rZ1xqXEODc5FprIi33aRP0O2h2mvn4Ru50mMHMxs6E9XZ0OgPWKvagiBOwr563PtFrMNNOiJSlh5ApeoX9tSa5uW+8GtGEllhp8VsLYJ+Bg54nH5IHExMCrKKnJTKdA++KKiACnUtF5jAbgpdghTGXnGwyQQq78+N95A6YUjb3s8qB+v2QTYjyf41Nx1IEE5rxdHwyu+iDL9ABJiviHHbBubQy5BD7Ln63+6yOS8v/nxNSnPL4t/byDl+xsqWrZ52kR5mWs2Tq5WIJq9pQqUoBN1UpeUC1psF1hSMFAUpwhNpmwRJErYsf8atjXKh8YwO7kAIIyUlJhD0Gk0xZUvhxGLmk1onSofiAmO8J9B0RYfNi28SjtkIeLRJhaFNhR1Eg0qPvBEvPnB/Bh8nH1aeQQEWM2F/De/egCEyqP+IpKrUcOdkkfT3COQoL5YoNjPqKjfUdVCjbFMJQJz2V/wyiCekH9o5a57rk5pznZyRMnu5JwzKhTAcNfw/SQ1YfSE+wFTSodPJ1MVNDMmOnuoLJMN318xjC/ZrzX3ZG7eNMFbWIKkrwayFFwZlDHjOASS8slG8lZ6My0eTqI9n8W7L42Nn8qfSxFuiXZArL39l51FJlOdma0cjdSZItjBkIOwoNTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(136003)(366004)(376002)(396003)(346002)(107886003)(38100700002)(66476007)(966005)(52116002)(316002)(86362001)(1076003)(8676002)(6666004)(4326008)(6506007)(26005)(5660300002)(6486002)(38350700002)(66556008)(44832011)(478600001)(66946007)(2616005)(2906002)(41300700001)(36756003)(54906003)(8936002)(186003)(15650500001)(83380400001)(6512007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4FpY9GE776Zstr05neNp5Ul7lqGUbqtJmwwN4hsZjrj3e4tF+6nUBfU6A6WN?=
 =?us-ascii?Q?/5v0mMGXQ9jm648/C/bzL+jQv7G/+ph6r3wOJTjT7n3AeXLgJLwdj5jP5ZXm?=
 =?us-ascii?Q?9msn8ynarYHyA8OUF+3r5RwV5aXGAcQVRdAqQ8HihR9AMbFJddJaCR3FzuP1?=
 =?us-ascii?Q?+BineIfnY+9ja+sk8eZilWbXe5Ox207Lt4Fql8ZtizaQXFdOXEHxNRatJ7fS?=
 =?us-ascii?Q?40o6+K5YbuKhOUmpxz7dUS2Z25hhYcWGaL+vuosPOAijKoRAHwtoTbG+Term?=
 =?us-ascii?Q?ZPFEMQbk3cWgMINE8p9WAOIZFpkDCnJcxJ4qhKpbuoHhHAyRhK3KXQiyX5ij?=
 =?us-ascii?Q?96iv2jce0bHMRFTmLAzkmYzqdDfFmthG5kwoJ2vZnU6J/w5HqaJXhyVHrobM?=
 =?us-ascii?Q?tlUOF6MhWREJM/cQ6odiNX8tPCAQSoYeefgbIxkt1mtwCZslWLf3dgj/R7ao?=
 =?us-ascii?Q?mzhXY4ziCHH1Rdn24rouRUSBH76Nma2CnXY6++rMxCk6WhH401am1g+acPT6?=
 =?us-ascii?Q?wZx4vLhhwM0bGMEjY/G9YRGWNRiHp0pll5Kon7w9QX9lxjONW5Cedi+v93hd?=
 =?us-ascii?Q?v1BdVIY9vQk14TH+EGa7nDFm/7QJaRlPaad1W/yq5YzejWSpxAiUJpYabrJH?=
 =?us-ascii?Q?nqKPiaShPp5X5LXukUTrH6ppy2BFRisxKZ99J8IO6jGE94+0a4LpDKHtGmUP?=
 =?us-ascii?Q?aV71KzgJjnJ5bXkq0deq5TYcqVtD3pH69H2848PEWoCSSCxDd50K7LJL/Wwq?=
 =?us-ascii?Q?MNX/36gwPidw3e+GP8vazNbIYSZiuSBI52SAsat/KFWi0gUMbDgkynmclzuA?=
 =?us-ascii?Q?do75R3ws0KsCI0DGHvr4DqD7PYqXYnVpWpMekLvlwnEr2Co00ibZxw920qjG?=
 =?us-ascii?Q?6mIMKiMCsFyf7sWljc+qktTgmP6+oDpf0oANZq0PRnU20kRLTz/YOdPf7QTK?=
 =?us-ascii?Q?+FapvTTa5N0oIvOlVJIaB1jV3eKxcjfoVAPo1THnUP16sjk7q5APzhP0/mMU?=
 =?us-ascii?Q?SJ/bobuoiGzzFfto/v+q5N3BSmVso9zxYFV37yohrvR7TEmxOXBPbbZPPRyf?=
 =?us-ascii?Q?LdFKLW17ycPJnrZeDjpI8Og2BrGEoaZDj6dWpCNjDWndaL7n7Iqr5IYx0bnP?=
 =?us-ascii?Q?E7d64qakkNMvIisRVjBmXSVjLoGJFGRpcNGShCG6M6TaFDS845alymrinWsy?=
 =?us-ascii?Q?b0KI/H36g/iZVWtcAbhH9on6axzG79CdETZNgQc5o4BvR6V26Y3emKE1dhsT?=
 =?us-ascii?Q?XIliQOCYOH9ymmhOYmLykUHGNtseSu9bGK+9prbTdP2azYR5s59AhP+FL9v6?=
 =?us-ascii?Q?Eyf3mAzUVcYl9fqi8O94lunoVOrLwmwZPlfVmdBCciiQ9EelE4F5+1hZHVMB?=
 =?us-ascii?Q?9CZA9odRqJMkM+FmhADtwOg6cU260ojOg4UaeHuC9E3z1TDbye/Qg5Xl00oG?=
 =?us-ascii?Q?eojLsSI3aF+7QniVyY4ck4XRAiWEEJLFzg/91+s8wcBUAXwL07Y6fJbpZyuA?=
 =?us-ascii?Q?AFky57A92iK0eT+5SknWqyfuHuEBj0BN/Wzz3BxtKL3OPU4wEspRd0TSsrm2?=
 =?us-ascii?Q?rA/pBOIzviNCRoZz5NOXERQ89P2NHLfUQw2x5RGfqqbJxtFOMwPd+DZMD6N2?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17446fff-7c33-4ac8-f346-08da5ae868b3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:32:26.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Zht9DIxP7REcEk/o0XWQRzptEX4Je30/HfmTxwWhAbAgyE2LrQXbaJuBBQCIp+F30vFMYnHeevJ+ZqdhlLCEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds bindings for SFP devices which had support added in commit
33a1c6618677 ("nvmem: sfp: Add support for TA 2.1 devices").

Shawn, I saw that you applied patch 1/4 (formerly patch 5/9) [1].
However, I wasn't able to find it in your repo [2], so I've left it in.
Feel free to disregard it if you've already applied it somewhere.

[1] https://lore.kernel.org/linux-arm-kernel/20220629133217.GM819983@dragon/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git

Changes in v4:
- Split off 32-bit changes into their own patch
- Use arm64 prefix instead of ARM

Sean Anderson (4):
  arm64: dts: ls1028a: Update SFP binding to include clock
  arm64: dts: layerscape: Add SFP binding for TA 2.1 devices
  ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
  arm64: dts: Add SFP binding for TA 3.0 devices

 arch/arm/boot/dts/ls1021a.dtsi                 | 7 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 5 ++++-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++++++
 8 files changed, 59 insertions(+), 1 deletion(-)

-- 
2.35.1.1320.gc452695387.dirty

