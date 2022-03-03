Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06CD4CC28B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiCCQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiCCQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:22:02 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70237199D5D;
        Thu,  3 Mar 2022 08:21:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkuPBfTO9mBmW3J+Tp+naqgfqtL3+O6wXdzJVFKpbgshlsr7uABUNBl5jFSVgqcd7Az3BrFCc9rEeIHxd2s3/AfYLsUdtnA2lHANiYwyhQW25ZYuOjYbcnJfjIB3KG+HMZ7QokQ5vI5TRWy5lLey8eaGpxrDP4dTdb+WE0Cx7HHJ0jq+RRONJV0BDBsoswVrAdfvdIQWmJi88YaTOOIKrsr+Mwt2D+dMdRRPa/zXN8LEYNT58zxR+5T/orBCm5M9SZpJIRBwKxNawd+/LqrPVK9xTjxgL1IkAWIaq9W9itLaYYAx/VTWMcn8lcqDI+Ze4W6DgTNqmpM/0xPp3xPpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0CmRnVTVpFbd4Bzh38q+wbyUw/F751LcToN8Pzy20M=;
 b=T10O+OHMu60ipEFj0Q1ySO9XHu2CYWTwM76pRMP25quccPNEHseGdIgsE4Nie/16tpIqjCZMrxzqzbi+ZK+B6ZcXYu12yRzhYdFPdnysepc0Vg0BR+sBd9JGvlbuOaoMbUmFcwdnYU8VukwD2Ljs6XLQjEEFN4MOzL8dAQZZ5EuydENe6mtVXhcxgQEN6a2OohLoy/LpjzUIuSUUvbeqHAYWwQYHj3xhfDuIpNRi2Wb3Ap4VAOMR2+AYwkCfZ/LXzrESvT+y9q8YznlXfpbIbGWiHeGLXZbfjTyW5qO+NkfVTfZOdNT7RUnERFOk/0LtX6zePcMCIyQxm6NqXhqVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0CmRnVTVpFbd4Bzh38q+wbyUw/F751LcToN8Pzy20M=;
 b=cggOm/uBQzbj/tYelh1mQCMKgV7z5SzhcW0lsvPrKrDvpSgyWi7rZ96l1bYPgZaA6Y8Y4/U/mn3YytmULKc1Gey1Q4pJsBfHL/Mrw533c6c5IjRq2Qxts2c+ahqiJ9pisBR6gp1dhYiuIK9PZmTqYtw3Y6YXty2YOGHpkZy0GmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:21:15 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::2911:de67:4045:3f28]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::2911:de67:4045:3f28%6]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 16:21:15 +0000
Date:   Thu, 3 Mar 2022 10:21:08 -0600
From:   Han Xu <han.xu@nxp.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: Update NXP Flexspi maintainer details
Message-ID: <20220303162108.cxngob4yg736nrau@umbrella>
References: <20220302192915.6193-1-singh.kuldeep87k@gmail.com>
 <YiDnFEcpx5OiNMaj@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiDnFEcpx5OiNMaj@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: SN6PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:805:de::28) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b5aab0f-d74d-44fd-44ab-08d9fd31d6f3
X-MS-TrafficTypeDiagnostic: DB9PR04MB9354:EE_
X-Microsoft-Antispam-PRVS: <DB9PR04MB93547C108EE88603F1D9D6E097049@DB9PR04MB9354.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXwbeBUJjOxfBLob65FJbjLH/T/xdiMh4livF3TT9PnpSN6aVehdmIEA4dbUy9d/7I3XmI0d/DFoIeVU/zrIua7rNwxeS18hsK0XHlrqErq4+zQdhc13dJNA8k+vyb8j8KS+9YhHTOo0F8W7d1tXn2KT86z2xIPqF7tAFO5K6gDH6Sbuw03JGVNZ7aoxN8qzKvLp1swyN+qNPr7FF03jmLPYeGQECS/cyZo3+Q4EuiZhihxBff0LJcOCu9bNNSML7Y7MwXRc9wA25F6uIQEMKjOKNwnxiRpXhk+oDZSBSSz4xrABYc8rzE2fEL8FvNkWOurnSBr/kjkSCjR6ZSw+SiahZ6Fy3EN6CCeIr8KpGvwV0A3mVmbKJfy54wBfCCFl6MVvxJWTn8eGZLDC4rmlNRO+R95E0UANpOzfJ7MqmvnBBS4x5/KNt7t7pPxOyBH1/10GLJvkEOG6OcnFyutAbuoHmGnqlK7gzK6jVxwFEJf73I53/IEsto5aAnzL9HHr2/e5cI7t+0E1ZDB8JKoMVAeJO/rcIQsCB11CUMe3pxUR6eArtim+NxKTDawmoNIY2j17nA9cMjQ2XeGPTq1CnqZPd8EA7LEmAj5o9AdIzTemU9R2/vNyjDUL8T582LgaflzxLI/8btTNVqLPh3zVm/rv18pRDZ3odQIhGYcBCd59xYC3vqMvqB2iLigiTmlQ4yeS4ZqxNuzgjj1ayoI49A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(8936002)(83380400001)(86362001)(54906003)(44832011)(6916009)(498600001)(15650500001)(6486002)(33716001)(1076003)(26005)(186003)(5660300002)(6666004)(66476007)(558084003)(66946007)(38350700002)(66556008)(8676002)(38100700002)(4326008)(6506007)(9686003)(6512007)(52116002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9VYJk9k6HOMtVuqt4/EavfHkc9b7nFgNi9VA+7skT1vKcxH5Fw5XldO5ZKZ?=
 =?us-ascii?Q?DJ5M/SalsYvRhkEvF9vzyoVvK0Ev6blPrBte1GlwRapHtw7novsnnXuOYOWG?=
 =?us-ascii?Q?4ZebBmkfFv+GS1WMJhmNfnwfy//2nEZDIgLuMPXXkkLfE9ynZ7BpsufMQDMo?=
 =?us-ascii?Q?kACO9gZrSYyNCvlDaeD3cF3bSyiWegtGcJTnfprH52CLP0JlYWalWGCFDy/v?=
 =?us-ascii?Q?iVx2rcYFcNddSo6faPvpF9AdKT0UvVGyf2Pp4218YimLfdySspgYcjSrOdfQ?=
 =?us-ascii?Q?wkPooKT0KD7HfjhqcjVMHGij+80JuIbLyU6Qjy1hGZ0IVR/UiiC+lxSjgpwC?=
 =?us-ascii?Q?k8jihRXWubQ56ujzBrg7B7V5TkRp1suz7kJNEmHJEOUv6o3usqQ1ccZI/3t4?=
 =?us-ascii?Q?c88ybB0OjNFEHzI2lpsDML0CUEdicoe+yEqjnWGS2DzYaK+07yBZbr6D+pky?=
 =?us-ascii?Q?+LSpGJmiAczAJVO06b3VdTJcUEHCQ2kobx4sZJtzCyi1n8IXI3XvBFkBP8Fi?=
 =?us-ascii?Q?lGkXmzMfnC4njbEO6mHrbwMHPRKsWqTioA+VK38NAa80y+6myX70BVRr+k4l?=
 =?us-ascii?Q?RrXmcFGv+NU2t2W/WfULlf4E23ELW8fDDmj5qKSOiikynn7txpvBiKA0QDpT?=
 =?us-ascii?Q?wUfA4K6p9fARcL3/A+cbXBbmKnVTQVO6iK/UevUrLYZlbqsgVenzuUWGoQig?=
 =?us-ascii?Q?Ao0o/gulQPQHVSGPdz0AOw3ZQEgww2vY6THGAzUksfx9sUIblWCC6rhUSkmg?=
 =?us-ascii?Q?t5AdgpyDDQxDu/4C2kbbxC7uVwpaIPoO7e0M1iacaaa/AUuQ9X2QKb1cyC9F?=
 =?us-ascii?Q?2yeBn23CMZIf0a/HBqqg9V6NITPoyoyNOXEUNUBXowl70hPC2ZWgPLwtCgKR?=
 =?us-ascii?Q?hm0lR/JFu0/yLp2JnpF2nP12lwXe3l6xyR5QyWkgICIPR6nsB7/IqdiVG2s9?=
 =?us-ascii?Q?4Zl+k1RWl8F0luFKCrYczCeUzUItAgasMTfaIJvcQqaRCTkLhaPgZ6T0ejtR?=
 =?us-ascii?Q?2lFLUy4Ck3PKvt8NmSjRpVQ4c26G02Zn95E7xPSfx0/sQCYlAhNsq8gl1CNz?=
 =?us-ascii?Q?KE5ljkRyYtZHmGUADqWgYfMgdUAmvz41BCMdihzfopmqgK7DVYOvAOXgELXk?=
 =?us-ascii?Q?xhYh6bxhtfdh9KNnauutME2HRVA/iS37b1i/w2Kn73CE+W4u4aKxzNWYtZ8X?=
 =?us-ascii?Q?GmaQj2sJeutxdPBGT2TEPstFM5Y1ZgRAy+aWy2KOm+C6Oax5YWv0TSOKHTDz?=
 =?us-ascii?Q?C2E5VQPbLZAQ0zMBzCp9Cgz8pEZ8DB6zn7zaXAwKuvG3hv1mZjbCTCITumQ6?=
 =?us-ascii?Q?RjP+GiTu5pf8vBZd6Di1q1jx3ZWk0oJ4zEqo1QFYAPPINFy/M1x5W345lSaz?=
 =?us-ascii?Q?/dNA1N5y0IYzTgIxTCVtd8xFmXYEjy3yS5HardEyc+oLFRIHuw61mnz19FBb?=
 =?us-ascii?Q?ZzIyzJSIqBMhU0GtpUki5Ne+kVFmdWRYMMcu7g4Mnq+34iSbOtAOH5NEO6CM?=
 =?us-ascii?Q?/PKW8vrF3CqZb+TyDFrsrkzcXd6KVROSor61rGYzEB9fGKYiCLoxW2ubh8Ft?=
 =?us-ascii?Q?nxI5CnNLD7cowoLxUpI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5aab0f-d74d-44fd-44ab-08d9fd31d6f3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:21:15.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1HM+aZXOJCJyyHPJXw+RjZn/lkySwuVDAW6wJxaqWg+hFmrpMKEzOaqrRKltzlo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9354
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/03 04:04PM, Mark Brown wrote:
> On Thu, Mar 03, 2022 at 12:59:15AM +0530, Kuldeep Singh wrote:
> > Add Han Xu as flexspi maintainer.
> > Also, update my email address as previous one is not working anymore.
> 
> Han, are you OK with this?

Yes, I will take it over.
