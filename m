Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971344CD8AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiCDQMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiCDQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:12:32 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBFE1C8DAE;
        Fri,  4 Mar 2022 08:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvi4tFb0graLDU9QWe+WzNAI58L9SuuM3HGmfAnI+7FKlpjvKkRlZjUT6IpyPfhTjdq9m6rUBqD7HZgjYNR1BEem0HewiubZeM/UMrg14Jlg1u9s9CI3eY0EH0X52IWKYG6Ey9nlUFIIw/UX5xFLhqRTrBaw7+V1otnpIDVFoWjRbzQNaUCov6ie1H+iN3bNOeAW6Fp+naFVXAtEefgx2ClN73wR0VyxkWfP265M/ul2loujodDzxyj82tIFASyZs5mt7xhx/Qr91tNLPktrCxlO1HsAPH8AAnKZDfc9OtFnGzOq+a1IL5iN07jWjZ/PfY2+Dg1/4fsZIoJhKko0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwZTvaY15aT8MS/zyUp5g1Z4jBPXgJJZc9FH2XYPMiU=;
 b=ixqkk3/fPpZRnjd3n8+41v8wbR4eLb34ytkYn2sgFJU2VX7PVIwoVvvMxG5VhRNYG8CIBlbo2k+g6BZMUhqduGQpaEs8SSRsKgf0uDM9RgKTjw3MZWKheBvZlF9mz7roEbAlrD8doMtcMbUIpaNK3AEfRI9mZswuHJ2EYKJ9RKgw5iNZJ3vcDmOBHR8PTsAiPfuSxcwOtMV/pph4EG4dibyQjWlPaiQfJWEBeg00qitgkgoNzKOeilm2Ofi3VN4AMTfg0mTua42XK70C+MZrRFlKsoxwuVr9UUc6kW+kV9FBVU2fpFrDGoRJFj4Vp2EMJ76vbjmPjkMrFCXAceirjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwZTvaY15aT8MS/zyUp5g1Z4jBPXgJJZc9FH2XYPMiU=;
 b=pdRFWu6wC3bp/3dbpDDgwICphdf42v5Awts3EnqjxLVepq13P4LyQ8Ptj84DzjpADqsh5/X4O93qy3CRjc4Qc0/uQ2pr+p2XJG/jXJMVyGbGs8Q24UFKq0vFViJWjVhiDqznImaTfEKUeHOYaHOaMCrtGe4sjhgrckpFy9L7fDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DB8PR08MB5481.eurprd08.prod.outlook.com (2603:10a6:10:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 16:11:42 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5017.028; Fri, 4 Mar 2022
 16:11:42 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Levin Du <djw@t-chip.com.cn>, Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 0/3] arm64: dts: rockchip: add basic dts for the radxa rock3 model a
Date:   Fri,  4 Mar 2022 17:11:27 +0100
Message-Id: <20220304161130.34977-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ba3f872-c681-49d7-c479-08d9fdf9abaa
X-MS-TrafficTypeDiagnostic: DB8PR08MB5481:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB548165A69135F7B8F09D8E3AF2059@DB8PR08MB5481.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i284LnbeK/njHyxSh278FhOzp4K6b4VbG7cw+5wq3c/gRnU6eKjavqszHcHRMmHjtSXDFyPgl7etHqTS5rYbPTFV9SjxpXMTtB24xQrdQftbDIWFhjhUTN0X1wjkTFDnGLxp7TE0PXtl9meyo837TfzLrAdsLL+NO3njAkCkyLGCOKn01DRsdYQvUitBnHehT14HNSjynWgM5AUA71GNzPytWIVL5qxC94F8Y+D60aHw9J12sFrWGU2RkxhnSP4ciMzi3NR4ytB9qJTL4JDg9MHoHpbl3QUoZb3V9HiangUc2NlUJviVMtB6fmWgL/gMTJQjIL502TtMaAlpyj8Bj8PfA2h/sA9qwiEZQGLqoIfv4NwI1aGUeE02br3mL3KnpqPaFz/WSxYIB43So3e+jpp+dOUcErVHoqgzBVCWGjTXZGK9OVuDUm7a9rnkn5cbV/fCz2o7jWT85L/USIFc9gd8Zdm+y7OiXx1y+jqL/zM+EFx5oO4J0jzgTu4hunZtut9nKcEMeJONUe70aan1dOTXbRNlBT2vLYdJaMrPilYthQnLLbgUEYJWt4345I+FSf8OH/owWeEW+EldtWcB1HnAer+4ZwkJzzrXMnypzkRTpq9sTbaIgxKFyjZP5A1sMLaiGukqUJkBuWUBMt3538njFkMbKxaCIXHaNJuN6lYwGFp1v/GOMM5AELVyP9YTi4zo1mHkbustmIWCiIknrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(5660300002)(4326008)(38100700002)(8676002)(66476007)(7416002)(86362001)(66556008)(44832011)(6486002)(2616005)(508600001)(4744005)(186003)(316002)(1076003)(107886003)(66946007)(6512007)(54906003)(36756003)(6666004)(52116002)(6506007)(2906002)(8936002)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/CTXzXZ+bq4+8rBxI6sodYDA4V5+iK9GaOtZfSfG+KP5GPZtcFdiGKu05gm2?=
 =?us-ascii?Q?rMqLEFajg8wBwVp502y3Q90yuilKy3aeiF0CaEmSi70nZUq8BZbRzTr4ndFG?=
 =?us-ascii?Q?AtoUYBiGp5pWujZxZZaBypoIUPlvu892jjy3BJl/8plF4wxeVlMG+pgpIQ9i?=
 =?us-ascii?Q?gpKC6i2kEciCyVSEAd0uOeCjnuJ0OT0DihZoCg3XHfz70OvtfNhDWvqwa5oa?=
 =?us-ascii?Q?tQSirhGQUFPyJLB4EAM1ogrFDBfHFYLsr2VO8G9inefoydbv1woyX96VYDsh?=
 =?us-ascii?Q?7SeP4btB5LDJulSEzwGrAvP+UutSRLJgyWm+MyVTHPmuS3YlhDC/sWhwjwlC?=
 =?us-ascii?Q?yrWTA3fL20sA7FKxehfXhltby9qCCWZRzOencMs8NObGmT5ryWTCz9SGiahJ?=
 =?us-ascii?Q?MsO+bCqtPRH2f5OIZSl2JRHDxJiGdjxbSE0i2vtoHP16eHQXTbzMC9bsZs9f?=
 =?us-ascii?Q?yN/1hheckAmjH09eqoY362MP9WknEQntI6Q6EY3E+q+SWdGDotqW8x3FATIl?=
 =?us-ascii?Q?N7mtzZ9dCyJ8Jhc69evE5ae8T+wNJd+DFzbqDUOc3/bpczOAq9Qo8GDwEd5Z?=
 =?us-ascii?Q?ZXk5grCErfJ4wU+188kOGlNFrbbNCe4jgy3iZU6FW8ofvLWdCsty76Cek3p8?=
 =?us-ascii?Q?V8eYUtMQRx4Uqk9S5DwwKr0wXF8X0I3GeHs3QnRe3UVAr6sr9Kb5o7gADCjF?=
 =?us-ascii?Q?3srNXkVx5M+a3qe+8zpyIOUxDWkBz80bDW1DgSx4h2ZrbU+ygOsTKS9/SBLV?=
 =?us-ascii?Q?JCgjApdQPP8KHbUY4cb9PC17dpphY+vGnNERrbUcrG3U7CQSOzkzlFrQWl8r?=
 =?us-ascii?Q?JYCYyMjzbVaSEZ70CpxAJE1UTEsH4rNHrQSgc+OsT//Dh4v9iJFhNRvodALz?=
 =?us-ascii?Q?nQZ9dG3bNthbC0gTFZy1Tc1bb5/r9diOlZmGitKSvo1JGq4xPcCdlQxZlAbf?=
 =?us-ascii?Q?K4t1BUc9wGQPOe4quckFVmz0F3tqT7bwY97en2VtT/fRAbvQgbuGyS3eFYvr?=
 =?us-ascii?Q?Y1HaouoKpCwadIxbiinIaJYrFPc6BOjsItGVqKjbamNHc/6vx5h8F8vG2WHj?=
 =?us-ascii?Q?0yl9YRCEKCoG+3aBqAVU1l5ijZx5YHq4NCF2oK63f4JOt3XZgQHGfsUCVwuL?=
 =?us-ascii?Q?Ftf8AfxNSPlN5/PF1y3qNPALKrL8JBCYqFebs0FTVcD8bMJa0WB4NtvKrsOw?=
 =?us-ascii?Q?YEEo1eN98lfwbxfXXMKOljBzVssJhramd1UcQMaS8wza4owGlYwWDxCdld6a?=
 =?us-ascii?Q?6V1aFOboAfO068y7GuTwgKEJbmyNKKtfx78pM/asVrsEeZ1AsKX6v0E0w+pw?=
 =?us-ascii?Q?QTUDGRACaplliBwg+MqBzyG+jUiI3c/kj21EOr40P7jcUm7jZf5a7Qr9+CbS?=
 =?us-ascii?Q?2GtVowmDcLkDzs9jRaFOfXtPfkWoLYDvqEK4kFBrsZCqiKnTG2iKQmecLuie?=
 =?us-ascii?Q?BrUo/yUabpGP6rwQLhcxh2GGNBrXD+ZgEgY1wACv19KvsAAui5r6WrsaZZ9d?=
 =?us-ascii?Q?UjDNz7dks9KlgtwWEZ0VzllG7XI2VFkbqHtogIMSNf+kXru9aNYb/hopCQ5B?=
 =?us-ascii?Q?MfjfCts0+T2GhjjW3X6XCuTUvjtaF3PA7ynkKOTbEH+JGM9jQrEpfcw/1R8U?=
 =?us-ascii?Q?hnd0XoArJtzDJOuryibUzDAGp26bdNtrMI5X8Y5RXib112pKnblw6ZpCVagf?=
 =?us-ascii?Q?dPj2upqJOtLHpaZikPsM80V/u7tUYYlyNVYVIHdbqUzelby4JTVp5hKJe9vX?=
 =?us-ascii?Q?PY74q+Gxvg=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba3f872-c681-49d7-c479-08d9fdf9abaa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 16:11:42.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaA7ylces2/CJMYrXGml5S8SoY+6Asc3pbUaW3c83emZvALN7KaeKx5JS5eMxJm1xv4jYnGjxKGmxUPzKDqe3ICXF5ysT7L4jNTMKNRm48A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series introduces basic support for the Radxa ROCK3 Model A
featuring the Rockchip RK3568 SoC. The basic support includes Ethernet,
USB2 and the headphone connector.

Patch 3 adds support for the Video Output Processor (VOP) 2 and the
HDMI output. It requires the VOP2/HDMI TX patches (which are discussed
on the list) and can be considered as RFC.

Looking forward to your comments!

Best regards,
Michael

Michael Riesch (3):
  dt-bindings: arm: rockchip: add radxa rock3 model a
  arm64: dts: rockchip: add basic dts for the radxa rock3 model a
  arm64: dts: rockchip: enable vop2 and hdmi tx on rock-3a

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 548 ++++++++++++++++++
 2 files changed, 553 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts

-- 
2.30.2

