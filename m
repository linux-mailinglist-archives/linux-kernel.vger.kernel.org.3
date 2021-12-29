Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA6480E43
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhL2Ahs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:37:48 -0500
Received: from mail-mw2nam10on2118.outbound.protection.outlook.com ([40.107.94.118]:8991
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231808AbhL2Ahq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:37:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcbGO2j96C0N5OrxNl8eQ1gGbfUd1h3a0jgHUCeoOlQbc5q99aUGPW73Q2vPo+RPvji9OWRMzyIVd9Xxk3Hezj+oIvNXQto+V8JABsSVyyhC//fJ0NY0EKGSwNjh4BQH8NWtY1dlhrLNt5KhysU35+lIwfRhThRc3Fvu54IpPZc8XYuWbznNTQy/wKXgfdr8qkUYqxE1iSrcpKBFQE/PWdEaiYgkTC9cJPPjr89KAoml1MhmbMTu9+UQcQN/HUo1LpSju8t9wyuRPneoX/X9tvAoCWZX1dX85d6YaL+qtLo95BQFEUvt+vTYMCIedVDqjYbnQDHA//yL9YFVnzWwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIhZ/5zmYK4Q0FWsAZjQxzMjsmGWXaXqN42mopO9C4s=;
 b=lO3gPOm3M2soDeiJilop3p82l3sTE7k+CUXq/jen3ToJLGaYAMpoRawTMslDu/RRxhangaffh20iOy3iW9a1a4xJFUwbvw47w1+A9Xfp0RWNQKvQLN6WHqLRrWlIGl3BccfhQ6/LrPox26EIEJ/YG1AkH6Xbqcqrldf7HTooigk2GG08J9J7TVskATdFoCYxj6IXOhrmQODCST+sOvww05rc8M9eY3GXHEc6Ecq/6N1C7ePdYov3HOXMmBkEC66VN2bq5SwvD4zNjAbQ6Dw382hNGBXdPLAz9A6fEUv42BfdPkGKmGvdVdF3qYNWIqemowaTAxqt/qHQIMEC6GfOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIhZ/5zmYK4Q0FWsAZjQxzMjsmGWXaXqN42mopO9C4s=;
 b=QGEW870tn02BR4LeFMysKJEz8EewKeyXp6NuE1nAL8OV5Qi3FTz7IwUXymrcb4NJeEoy5r/IdHEIeX+7dZxucibYp/ToDi9PxxhKy0UUyj0r1DMXRfg5pumYC80HM+VNEOVzA+xHEhRmGvIlhRVpBn+XUPwOqidrXAHzJRzxm2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com (10.174.170.165) by
 CO1PR10MB4612.namprd10.prod.outlook.com (20.182.138.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.17; Wed, 29 Dec 2021 00:37:44 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f%4]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 00:37:44 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: [PATCH v1 pinctrl-next 0/1] add blink and activity functions to SGPIO
Date:   Tue, 28 Dec 2021 16:37:28 -0800
Message-Id: <20211229003729.618079-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO1PR15CA0085.namprd15.prod.outlook.com
 (2603:10b6:101:20::29) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8d1953c-82a9-40f5-3cbb-08d9ca636d9b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4612:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB461219714BCC95163D119AB4A4449@CO1PR10MB4612.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+5O69QIYefJkCyWN6SZw6KoEFZWHs2wnDPMt/r7hLYlIB2pZ+ymx4gNbwnoK5JPdfeOX/VcZOaPNKRJ6J5w1Ztx2D1peFe8WvyssAFTmd273sIi2fEGMMxPIe1HzDjYMnaP6kXpN1uQ8FSPWfdLfE91ulb2YdTWMmO6MrPJ5MREkupPXFYU9KtihgPYJ9JiIkH9iKI+j67naTI0YFbqOKuWQzajQBi+oetO6b/vd06PB8+mrskEQ6QOeuDQauIgEYA6Viz2pjLiVu39mDdtbbP/VqZhAT/dQFhRdPC5j18NcGAwUlPtdY4ExAm1nhVcXkpiYLVsUKtjXoiCYvi3e8j59SoJ5zv49VMBxHzFohwlVcHlcTHBCOS5QbJD5qZdHh3yS0s+rdF72Am6wX06jlVhVRjm3/i75Lyz4x6Kx4zQsWSXrYmsvmzC+xML7iwNhGH3G/dSOclM+5CymfQT/+lmzMn9tYepe48LGmpNRtjKyv+fwc4pwGQTwq18NSXZfJMR74YHukQti3iRxa3rXa8yKnSEZXyYy22g/LNGIDuroShI/mYRVhQuX9AaOOJ7LPCsBFXuHErk+4uXcGFbQKz0lxVPOMJdMyqfl9NkrqD1euM1MGfCfUWzrpTTYh0bfBMjLAAUuDTLWs3fLtcoOSbAAd5/rA3RASlkfQbneg/Zbq1EefgvJntuDEkCCVjG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39830400003)(366004)(42606007)(136003)(346002)(66946007)(8936002)(2616005)(5660300002)(1076003)(8676002)(186003)(38350700002)(26005)(316002)(6486002)(38100700002)(6512007)(508600001)(54906003)(2906002)(86362001)(66556008)(6666004)(83380400001)(66476007)(36756003)(4326008)(52116002)(6506007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bC+RsQvXfBuQR3Azc1Ev7T74dOm55j673lvS5VhyOTqkESfWPqcjwU5EyWZX?=
 =?us-ascii?Q?oLBzJG9bjWAXgIfDCStVX7Oa/jiKIoUEh1VKed9JJ+1jPoW9IkcRhbXqzLZ2?=
 =?us-ascii?Q?jFc4Sp86lDRarSqIE1+yniGDHoio5JqV4KZAph69pV1GCLA5xXZ8r+Q1FUPT?=
 =?us-ascii?Q?XE3qXXmbGdNPbRrWYAIKaVcm824ZZ+d5WqeGbIxCkhMkFH/8CgM2wMUIUJZy?=
 =?us-ascii?Q?/oZK6oDW6YSMVGmWdkOqF22c4P++CLTsFHqAo0hqPqtwHpx9drXrmgo9ZTkX?=
 =?us-ascii?Q?71XS/mUYLnjOd9/XAzisUJ9fnWOtiRofmpmLzD8RbXdJdeEzyudr7A7tBS7N?=
 =?us-ascii?Q?uiFRIPECDq5dijeXWhLIirH2QzpCyNFGWOCmvoX9Ym7WJOUMpG7trZckZClj?=
 =?us-ascii?Q?IImYS77tpQEkCrvh9YBHArp6wil1jvX48eTef30DhwlS+KJHHNz656E/iJ0t?=
 =?us-ascii?Q?uw63NHjEyYhvEr3GOI8FifRPeHP/rYqq3KbLsJg2DlSC/wWw+S44l5xY4vL8?=
 =?us-ascii?Q?AtW5nxv2BUTpyoRvrIhnLRTAwBiX7qsvaKfc4Nc3U5po7rCyzDi4fXtSmpWI?=
 =?us-ascii?Q?bO4ltpKsxrBy7ZTq538v7yCm/7NJyrh/BfJGL5IMX8MoegpDjnfjXqJqXt1z?=
 =?us-ascii?Q?gygO4hb0ngSIjD9/inOFH80vMkr8FticcWx660wyMNqvSz3SEw3uXsaG/P+7?=
 =?us-ascii?Q?QFtE1aGvfUYIssW/oC7LyDMJRlbTG+02ezhnMqkejlpiSm5h8I1Z2n+eEwQ1?=
 =?us-ascii?Q?OfZf6hJA/8t5+/oL1E+e7l+iEr7ALNXxiwMJlfMj/Nuh4GjjbbtK3EBA6C14?=
 =?us-ascii?Q?q30K5zxOusUjwopcH2f2m6Lf7Cx/VraWcIJzpHkBUwCg+Jkl2flVch418QY1?=
 =?us-ascii?Q?35h6Po4RbdRCg95ZSJIghLve0Pt5c1vu+BzSQC7Bewt/041Ilb/qIV/M8ZGL?=
 =?us-ascii?Q?AdAoT1Kbq7MKIX8PCUXqOF23cx6/a/1znSU7q504nO1736b9HA8I8Wgy7pi0?=
 =?us-ascii?Q?+OGH+Q2eYhRt6KYpa58wFa+yxybE5CFAcn8MMbvGanrSizI5DIaY3ECXdGCY?=
 =?us-ascii?Q?t471+e5kZbrSQ/6rVNQ3RdbAQO26eZPxch+gR6W0/GHjuAppUBLxJQU/J3nN?=
 =?us-ascii?Q?iwFCQCw19fvyO2wX5uufz3nvinsSGMdwFZuPN+h/YRULPm83chTSSgjpt0T7?=
 =?us-ascii?Q?PsFsiJM6Cjj5eO7SS3f+CORs5iok1KeJsPV1yrCpnFsu4HBUAKoksssI2U6N?=
 =?us-ascii?Q?jcR6945CvIQSaO2Swkk960SDq7jJS4tK4KYNJ+hHffnCHPl4QYUCVNhKjYPp?=
 =?us-ascii?Q?ESe7rcxP2r70GYmIVyFcOI8Y3sIHuJ61xEzVTLOCmuEZjxEgYPyY1fHbzOzv?=
 =?us-ascii?Q?OnRSOOTACZblU6p11GzUEEs5sWa7TY9+r8OPk2uIOE/S5O2vvcxQfAYEqGo1?=
 =?us-ascii?Q?iyIQL5wN2fi1wJ0hWxmy+epD8AZ3m0cJ2FdNQD1o30r8o9gsncNzYDri3Mbq?=
 =?us-ascii?Q?C88zhgbddTZpMA2WSYu5xlpbm8vbsg+hP6WSEZm2yejSUyAgylPIVeNlA1yl?=
 =?us-ascii?Q?N3nT642S5+BbXTVGe6Ex5+sO0ye5uz+C5V1sTC0/AcaGwUA9FwWT08wQht8J?=
 =?us-ascii?Q?TJXddTiexsSMSCBDaQL2xwViWFWObWRFb03BqyYKTA/eEsMowpoa58Nv453j?=
 =?us-ascii?Q?tHx5BA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d1953c-82a9-40f5-3cbb-08d9ca636d9b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 00:37:44.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ed563Kuyzzk2I5iPkPegx7+XKknCzopAIhJe2p2mwORRYK2r72xmpipl5xwcQowlQWeOq4NGDPiafwWknJgTYYBkenq08D+HsJDZx8UccU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4612
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a debugfs / devicetree interface for Microsemi SGPIO controllers.
By writing values of 2-5, the SGPIO pins can be configured for either
automatic blinking or activity.

The implementation is modeled after the code in
/drivers/pinctrl/pinctrl-ocelot.c.

I have only tested this with currently out-of-tree patches for the
VSC7512 that I hope to get in soon. They are not needed for VSC7513 /
VSC7514, SPARX5, or LUTON - but I don't have any hardware to test.

Of note: the 7512 chip has a discrepancy between the datasheet and the
registers. The datahseet claims 20Hz blink default frequency, the
registers claim 5 Hz default frequency for BMODE_0. I override the
OCELOT registers to correct for this. I don't know if that is needed for
LUTON or SPARX, but having two blink modes at the same frequency isn't
beneficial. As such, I make the blink modes match the 5Hz / 20Hz for the
two modes.

Tested with VSC7512 by way of:
echo SGPIO_O_p1b0 {blink0,blink1,activity0,activity1} > 
/sys/kernel/debug/pinctrl/pinctrl-sgpio-pinctrl-sgpio-output/pinmux-select

LEDs blink!


Colin Foster (1):
  pinctrl: microchip-sgpio: add activity and blink functionality

 drivers/pinctrl/pinctrl-microchip-sgpio.c | 135 +++++++++++++++++++++-
 1 file changed, 130 insertions(+), 5 deletions(-)

-- 
2.25.1

