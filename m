Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065DD59B8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiHVGCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHVGCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:02:03 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40811F624;
        Sun, 21 Aug 2022 23:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRRu3mzmHWNLJWukQ4cEkPu4M5nWESC1zpOKkjHD1KF++GatiImhXC2mgjx4Q1OwNnNgkhR4hpYNlsC5NIJ5bYgZZaGhDkDXWyBlT1n1Xz/5mb8BYAWVhWUH1zkcmFojQkkEhbw4WefkmygJvKmtre/Xw5pj3aon1lbUTE0UZkZZ+TrVb5LbtdzuP/mNdWedn23JHXoqDIDBNQ64QPFfgkxXD3VEdPLSmAbZRLv4pcOUKNwJT8WuhagM0bd9kWHm5plUK7laB+sDD7dYHYsiwN/r9AjfRwnQaSL0srq2Nz0LZgAxKDmJxNKq/32fykTeAvA0jyKT+m2mT1B/Ex8mLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvvEDPH556ZUe5L3tm4OPGJBCGaB+VuPfIpMhs6HGXU=;
 b=Qoiwz1ZxFwFaxhfeUtpss3KXTNRfyCl5a58x7vJ85vQjXx47HZYQF+PlufPuDEmZhjPB3BcFEDd/VIB2fGKPdxPE+ToIqlpHJks4Zk7lVYEgUyNYi6Kj5hFUd2OfhQ0anPfXjwQHgTR666RCuZG6gE9a4IyqvJx1wO+fv064OtTDoFsZDJqmC3giphYkcjdLrJ9Q6A49Ct3qCrhqn6G42ypdh3iVWxIalLb+cYcjF+L2FkRrSDHnEJwhICIYTZ0x93CeuC4KeOZDbU/JgS74fNwTo7lBiRckvbhDFhWXoEZn/SMjvYF7ghSJaAR5u0bjhgnHVnPqvfHlWfxyvvJNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvvEDPH556ZUe5L3tm4OPGJBCGaB+VuPfIpMhs6HGXU=;
 b=Vx1T9pymdd7NYH8/knT21rxwIJAwrGRVGW0kQhZXQBCSTcLeT/+Ufe6Z+1O0TnZkTowqZUnk0dQPQzsqcuUs3vVms5ZkYKXrjdYi4A6eBMteUgd/KrSTCFJW9JGoKncvYK8CHg0QKLmSaStMwoWyEQAJbaVmu1a523+5lZo80ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB7PR04MB4604.eurprd04.prod.outlook.com (2603:10a6:5:35::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:01:59 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.027; Mon, 22 Aug 2022
 06:01:59 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH RESEND v4 0/2] drivers: bus: Add Freescale i.MX8qxp pixel link MSI bus support
Date:   Mon, 22 Aug 2022 14:03:21 +0800
Message-Id: <20220822060323.3481384-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e56ebdc2-d1ce-402f-dcac-08da8403d33c
X-MS-TrafficTypeDiagnostic: DB7PR04MB4604:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+QUMk2W9DYtHH6PgztNhNDIyZwWf2KFRoAOtceaKtSnEbWbwUYJK5RfPWNiocko7m4HHZU+wqdWdGbb2vFiAT++E9Z+V/+yA9ZVrm3xC+Bdz3Fdb0emhj3RUeM5gIFF898TUr8r3dx5eHXd0rJW5VLZnvVTLP0ixrxy9jMCEKHUrS3lcI4JleeHOL41P3cPwsTBgOFvUTxwS0UEq+ASzx71dCZ17LN1EXUKQnDb5sNe+rWs5yPHgq961RL1eh1PeVx+1xREkPvuAwI/Oa6WllHcUHeHe0gYKPvyLuN8CO7scmGbHX156y7stNDj8jxfW+mSmA4ajQ726LFGE6UKNkq05YIc8J2hElcqZBS2FG4JK6umK1GvVr1L3FMO91LP2ka+ivnzdWxSQ4Hro3ZmwD6kVwb2xS54cjpKixk6C22KKRiDbBQ5CM83VnpbcPmlnT2MXHKjf3RUcAyFx8+Ayg/U67fZVEogb1qfrzFT/CVmIzimqfcvRU/DVzfi21VaRG1ch9b2r7YCG8yF7+BS7UG00yRlK2T1OAfZn9oHPqmID12g7xSOKwW7SjdW83VllRiLJgInBBFc86U+s9sHE2WFo5/60lqXsxQBjwkw6SwA2DD8k5EiSs+En1Pl2VK6hkxLQ8Wl9SILjAlbrNLp0zjaFuvgQKNQ46fue4llTSGpw/2BTM9iPvRM2TlhiB/qYJUXoLcrbd/g4u6RcWvvh/3mLYIZCO7tVFfZhFl6sem+F0QIflvBGYXS46c9coj8GPzGyTeAQrVCAEJiY+zNgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(86362001)(83380400001)(38100700002)(38350700002)(316002)(8936002)(66556008)(5660300002)(7416002)(66946007)(66476007)(8676002)(2906002)(4326008)(1076003)(2616005)(186003)(41300700001)(478600001)(6486002)(52116002)(6506007)(6512007)(26005)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+vkq23pe7SXACX8uXIveepABLqCs/DgRGClJMPn03mNgpEnYkqpVcqsIw2yV?=
 =?us-ascii?Q?cdmcLpKS+06Ay9zo8i+FamXdiEgEi0JQWlYfv2Ri4Jvci3CmXoYb7e894TYL?=
 =?us-ascii?Q?Ze/6xDkM03+ATkW0ecEX1P2nH7I0Bc1jEzrCv3+xF7gztdkITU0amo/R+ppf?=
 =?us-ascii?Q?Dh8VgLcRlAXUvM7hj1/V5sEnDqubPqNPvPAp/flbzkK1ZfB0yiPVICgATb5V?=
 =?us-ascii?Q?zXJB3pF+qepbrJt9ROgQXGEpKnB+eW5bgO0whAv3rL7Ox8LKwVYa+SuIoNsl?=
 =?us-ascii?Q?8xqoipXFlc+4eZ2fGMxxHuL4MHlfzphvoyISgBLXQwrpeoQkjRIcmuqIf1xV?=
 =?us-ascii?Q?lOSfFHOxIEN9UeuSfxODPIjYbOs0uAguVoQspfKvxn/iqbqzCHWLYNf6X3pA?=
 =?us-ascii?Q?2kOWAoOMV9KQJ3oPUZwea04A9jAcD6eBs/y6GYEaCVweg6hW6va01k5H5o2j?=
 =?us-ascii?Q?/HL3WZgKaGAiBZYL8s/YwWDyP6rQDJCPGKhNE9sMzASKpvp+0cgmSDQel7Yz?=
 =?us-ascii?Q?3nLajngEXHHFQwbztFuI8UCcmH+aezHFj0GV5gp65lkn5A7ka4Js8o2QuRyH?=
 =?us-ascii?Q?HVqpUkHJatYQME4gNReiAkKuX+hsZ17O9LzmzsDHCZcaTxl5eFG+aaXqT0Fh?=
 =?us-ascii?Q?K+qhBDX09kENA5WRa4evFG6UKwqtJMtEuTGoKfiGj/ZtNQ//J8ZjiMWQ9DI2?=
 =?us-ascii?Q?OBRjJhAfxa2iT89sfvEILTZ9WLdQToyHRxdSgimG6NxxzedHehVPsU0EYQxH?=
 =?us-ascii?Q?j/e25MRX4kvWFIuVJ9vAlVRKwEiOyNfqYZaNjqF5v1tEpcWWVrGuWlc1s0yx?=
 =?us-ascii?Q?0jpZPFs50rh6KksLyT7G5O931uBJjFN0ZziNmtoVS++T9xXBzVJGnrUf7Rho?=
 =?us-ascii?Q?Sm3A+kKMAci+7kPXhie+GW9fmlz/PKx+344WLyvQW1Gtircgg9AuC8h01WqL?=
 =?us-ascii?Q?p6TzzcDxpH5J/q9OvxEnMAD9OuXavFdYKh0IWFHXurfH+dXtTJq5N3fUDafU?=
 =?us-ascii?Q?HAPy347SYmyqjTripqd4OkfwG0/MGCARQYBNzowvHj9rcNy64ep6DUH7l7Gb?=
 =?us-ascii?Q?FU7x2fTyAQWdSMU8MjR4CqTcOsFWt6KDjzrb1/G1m1N0DyrcsXJBSos18ltZ?=
 =?us-ascii?Q?NGBVXKS76dqQpgaW62SU7SqbgsYFCTq78W6qbUkbeuzhq9jQMPX73vTzrHoJ?=
 =?us-ascii?Q?7QvO+1m27w1PlKKjEnoM+NuuBnMuL0vxiQysxPB8DBzQ5+tfFB2/wiQiGjJb?=
 =?us-ascii?Q?nNbx1UpAbNymEqhwC2cahUeGgS/76A9Eo4B58fgXCTpstVDIEC+yB21US0rQ?=
 =?us-ascii?Q?zgz3w/7I9ksmCfxGG1GquhOIarvOzzFydGFyBq/d4zt1pcgybIgLAFaNh1kH?=
 =?us-ascii?Q?x+b8iRXFerr+nsfNLz/sV5qYTRJKJYxNSGtK9JyMG8ZKOXyCa307iVh5ngrP?=
 =?us-ascii?Q?6J8mKCbwLn+gJMoBgHTFubSXIASPnuJxPDdTBiDmoQzvwE30GKpISNU907iH?=
 =?us-ascii?Q?gCjLI7q63WMcQ0YPNoNEwAgObT2WBTBRdCHf0h/vxfyAALZ5oS0JgTsIY4Oa?=
 =?us-ascii?Q?pz4Wk4fH3NcE0eaUVwyVX2zhKOTMYzfe74fakjyQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56ebdc2-d1ce-402f-dcac-08da8403d33c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:01:59.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Log8xVufg1mYyl+oKS3DOwN5wIAPwjIZ6N7lPdq1RYkCpZ5g3Hix5GB5dvVRjF0dYNNxLgrhvP3x+RrJsq/L7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to add Freescale i.MX8qxp pixel link MSI bus support
by using the existing simple-pm-bus driver. A power domain and two input
clocks need to be enabled before the MSI bus accesses it's child devices,
which matches what a simple power-managed bus is(See simple-pm-bus.yaml).

Patch 1 enables/disables functional clock(s) as a bulk in the
simple-pm-bus driver when the simple-pm-bus is being power managed,
since the MSI bus takes the two input clocks as functional clocks.

Patch 2 adds dt-bindings for the MSI bus.

v3->v4:
* Drop patch 1 in v3, because simple-bus/simple-mfd devices probed by the
  simple-pm-bus driver should not be child nodes of simple-pm-bus at all,
  as simple-bus/simple-mfd's child devices PM operations cannot be propagated
  to simple-pm-bus. Those simple-bus/simple-mfd devices needs dedicated drivers.
* Drop unnecessary 'bus == NULL' check from simple_pm_bus_runtime_{suspend,resume}.
  for patch 1 in v4. (Geert)
* Add Geert's R-b tag on patch 1 in v4.
* Add child nodes in the example MSI bus node of the MSI bus dt-binding. (Krzysztof)
* Resend v4 to imply this series is based on v6.0-rc1 so that there are not any
  dependencies for the MSI bus dt-binding. (Rob)

v2->v3:
* Add a pattern property to allow child nodes in the MSI bus dt-binding. (Rob)

v1->v2:
Address Krzysztof's comments on patch 3:
* Add a select to explicitly select the MSI bus dt-binding.
* List 'simple-pm-bus' explicitly as one item of compatible strings.
* Require compatible and reg properties.
* Put reg property just after compatible property in example.


Liu Ying (2):
  drivers: bus: simple-pm-bus: Use clocks
  dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232 ++++++++++++++++++
 drivers/bus/simple-pm-bus.c                   |  48 ++++
 2 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

-- 
2.37.1

