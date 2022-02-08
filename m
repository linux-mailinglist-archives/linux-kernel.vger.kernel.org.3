Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5E4AD462
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349994AbiBHJKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiBHJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:10:39 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2114.outbound.protection.outlook.com [40.107.243.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D4C0401F0;
        Tue,  8 Feb 2022 01:10:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex+yIwtC9l2R5cv1KNglGEjB+t7m+3ehtd6SfBZhJziMIPcgxLvBXvyQftqFNAoE5hYYvZLMCA/JFWpXH4dwh8BQ/T+OJL8EO6bXIlXU5+we3GS5/Zi5IbI0gV56HrZcUB0GSFS2qJ9t0ZBvm9Lu/aVTgfUJiUe5Csp5DGkbQ/bb7j6XU2ce+freIAungq7xwdVJxqse0vYwntdGZxePiVFTM0lipe1V48VljvXWAJ7C5bh7TqrJb4NibEkXKbG16Tjlygbb0B6yvjtQs8dsYziq+SvfqX0hEsQL8/8Grl5q2V+2RrOR/bDLlLaff28syfVa9sVMLkYoZtHt8n9+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIPcd0vzLWLMyD/5DelS7XzaV4lmcUmxd16HYNOhlrk=;
 b=VCSfRvh/T8H9owJfJ2nlh/upXPsh6kPrrsdrsY2Z0/6e5UO3/YeGDm9QRHy3JeaVVE7zBy2YGSELfFxdyB9MUldEYel/EmU4pJ1MlZXNcheX0ZTPKn4M/gkaM8HEj0ZnT0ty7WheXi5vKiiODrUViWBQPaWk2SmEHBoKBulyHnEbXQdZpSIVLW5Bhq/sb7PBsg3JxXdCQmPvYBf1bCCTssTPRRD6r1kEvIjmYcyfySAN1yx7t6YAg2XoJhEDZRvBa1vzVKoX0U6uC+qHcfnxo/aXKdooWuI+srZ89MFuHwlctLWgRVcx6FEtV4c2G+Rh59HlaKZBaw8d0sPfI3fgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIPcd0vzLWLMyD/5DelS7XzaV4lmcUmxd16HYNOhlrk=;
 b=BxAvAC8LMk/tqBLOXa0O17KVpTL/6YvpsyQuNR5z4ph3Nl8D8X06ib9s1rhmxwTUVK0spXZKYgrWvr0vcBPlnX/0G5uKHoHTyxIyJHC//kheJkrkFyqKXwG3XHyoZls0P4YGppYh19TN7EEywiHQ5kA9n9qaWiUil/3uFrktd/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BY5PR04MB6644.namprd04.prod.outlook.com (2603:10b6:a03:22f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 09:10:35 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8545:a99f:9aba:4cd4]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8545:a99f:9aba:4cd4%5]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 09:10:35 +0000
Date:   Tue, 8 Feb 2022 17:10:28 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220208091028.GA3679538@anxtwsw-Precision-3640-Tower>
References: <20220208084240.3678980-1-xji@analogixsemi.com>
 <20220208084240.3678980-2-xji@analogixsemi.com>
 <YgIuUIQ8EJqzNw6s@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgIuUIQ8EJqzNw6s@kroah.com>
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e193cf-24cc-4559-4027-08d9eae2ddb7
X-MS-TrafficTypeDiagnostic: BY5PR04MB6644:EE_
X-Microsoft-Antispam-PRVS: <BY5PR04MB6644AAEBD7B540D459BF9D7EC72D9@BY5PR04MB6644.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKroRyjSzTDB/GPFueFWBYiJ0N54MEB1UGvLSX5tx89zgM8b29S6aVe0ZVN69jqALOH8pEeS1lz4Siaqh+X+FJGUs/9R6BJKMQWEsvanoV3Rimh4j0XNE0JITcLZnNKjrI9OsVIOWfUipnXdAjJSNzK6Z4T7OZ+Z3vY/21Lux51VtqZARU+VxlICuYHsJaZ3OXnLAZSQPMGhMbMmA3jpCN9wSxDV03txowsPqWjYSqgna8bfbBBRQIz08DPrtXe2er0bzGdl92cJWGcSPP8gDKwYx37CDN+vHdh3t2gv0Ll8MFKYrtTPa7KzHiRDKDYdTbqmY/870o6OR9PIdoNmSrBmSw41L6JFYB43lFOUUg/FIH1Jnkpwj4XwmbI39Vw1gXHDwB49gDA71/n0qpEkV3v1NvTMN+pqlyvYe/Qey64CA9JLEv4awQVOP3uTeT9BI1+d7d8CR7QnUIwYk9eM8yEpbjRxDJFCdAWcM9ArPy8nkyqFkGwiMpm3tOmIeBf27YwurcnXQGSEqgUKvT/LRFfCAG/hLw6BaMOGXVk3Ea7olg4p/4+iaIwVu2L93/hO6XcmSsR7xkNerrSOtXkPwPVnHJEwnG0Phezekt/5zTqz1k8DbpLeGLmj/iyo2JdWLjnbHdP0zok5bKLag93INcyI2tc+A7pgDBTfxw/p1TrxTcxbBmtOZu1SxbJxMg/wvZs4jtZaAB+G6LlqrP3u+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(136003)(376002)(346002)(396003)(39840400004)(366004)(1076003)(186003)(26005)(2906002)(66946007)(33716001)(4326008)(8936002)(8676002)(6916009)(52116002)(4744005)(66556008)(66476007)(316002)(33656002)(5660300002)(38100700002)(6512007)(6506007)(6666004)(508600001)(55236004)(86362001)(9686003)(6486002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cjW7jVQoj559jtTbsitllvzhfkRK4IGuygbpjt+ZJGSGAR06V/LNn67+n++L?=
 =?us-ascii?Q?SvaqBYZmpaVmg4QTd9inQdAY9MI5c5FKXUZR7Dw14qdRRME8mK/xbV6s4Fky?=
 =?us-ascii?Q?x2cQuW8Q4ACdJuBV/O9/XbGQAPHnRdoyI3TNxiATVoAyZ/owR4yYgLARyAfN?=
 =?us-ascii?Q?ktY7/+f0lAId4UVxjYkmERZmpTT5dTuXQ6vbWl14ZLHviy4veA+Ih1go7Po9?=
 =?us-ascii?Q?zdnTG1UNoMcToSrwHACC7QsU00AZ/Z9oDRsBPVgS8Vm+UhAbyZxhOnIyJLJ6?=
 =?us-ascii?Q?DNAzXS9BDW/DWYIN4+93+43JmE9HJZHoi3Bs/vWLZhXdJ/Tf0LnSwJibW1oN?=
 =?us-ascii?Q?Tqyl7jWwXmiCWqJ3MF/NuU4ttKXDYkife7qCrd+ynUmtbpD15+bHHdS/lh9T?=
 =?us-ascii?Q?pAW7JnVnLgar3K19do2xOSIlMxyvsNzfAdeCsBXkRBS33gp5kvOfIX8qBhg0?=
 =?us-ascii?Q?C/ArN36zqk9dVdRV38hHtaxxtYVpRLBwN6xv3K1xTlNLpA/qltKWU1D+Q+eL?=
 =?us-ascii?Q?XvZ0V4jKh45sbkExxwVBFG+CRti1TtwdAOP6/9ZL6q8T4rMb/vBYoODqur6S?=
 =?us-ascii?Q?pHkXRaqrv56E9RfQJ2JMagZAwthi3s31Y74fh8Lvjd2/O+bhxh8PnmEd49Io?=
 =?us-ascii?Q?kFBzm44S8rXh0FYOcF6/NTA4inSz98lrpB8v74k9m6FZWvr7NR1fBdX1kcsl?=
 =?us-ascii?Q?lqd7wqJ78jJKer3QXu1o36ymDOx9TK7e6SlFV7/NNthhshHZnYaT5yJKv0OW?=
 =?us-ascii?Q?Rs6uJojaEhkBmGV7MFhD6beUjzdYzox+jsGXTbEiWmN2c8RM4x4HamqzL1w1?=
 =?us-ascii?Q?GJsZ7p5sV3XaXflFMA/Vx+f2lydAtTI6vvhbJ9yHfM+Zwd0iuc/g8gWdrdDZ?=
 =?us-ascii?Q?PEYdtrA8xerQIyPa8KX4ycNaD5iUJpeymHoee4un9fscDtcla0MqJKAJwAgJ?=
 =?us-ascii?Q?IXSCk6saj5K/ar2u14a5numkfjoEDN+hoa9jNdRUPb/Q9cMmtuwmWzadDzEz?=
 =?us-ascii?Q?Rl84dOItWq3nXGpytTtqve+nuCinIi/bWSwaf0jrOoDmnwkf4A4t4e5hZLe6?=
 =?us-ascii?Q?LBJD5CXIwochB8uS/PbiZ+3uZYVUNYpFu4qnnXTS/GQ25VUbp+doUqhasJ59?=
 =?us-ascii?Q?IG4BLtRyz7S8d3DIKvC7ypLrpI8cB7acr4n5Sz3TBgVSuTigC0p5/M2A56tN?=
 =?us-ascii?Q?JAmds5QMCqlYGXX2PaLSD1pMdOQufrzW8scY7dNUihE99k83ZF6NNxuPHamN?=
 =?us-ascii?Q?ohRkEprRTLDvxXpM6n/R3CmkIQvzc1MzAc+2Xq9nj8/qnlqmqEIkXr/+vL2M?=
 =?us-ascii?Q?7oheV4zyN8tHeFuB0ZN22dh0+Di7/hRRvIh8aeuSzJ44TkGWMMX0D40ckqgS?=
 =?us-ascii?Q?jdqH8l3jwAB4onRORn5jxBng8eBSbcHvlhRqTl/Qy7ou3lBLMPvAIBO2qD6u?=
 =?us-ascii?Q?1sFTd1g4I2zDS1Ch59TerS55UXZzwL7/al7HXdS/IoOPdLFcyyMNXiwKgK11?=
 =?us-ascii?Q?+/x426P1Wn4z7v/sUS5wa9jahFNAE3pzVgnSoWemWZAyAnsbgnMRQzg+n8Yt?=
 =?us-ascii?Q?eo0TlFBeDPBCIikmgH9FxUUYTMzSJlJWKlfTSYy2OyC0gZ22Wka7FlhD02Ae?=
 =?us-ascii?Q?+0Ct8jmT3e2EV8oBRcGkVp8=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e193cf-24cc-4559-4027-08d9eae2ddb7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 09:10:35.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNNb9OYePu7UMxdfpC57AprVOXyHUz2jtlSpBervFIx7tEBDr4yiIozoBey/1pJYfdf/yMd5InmkSwtK2GdweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6644
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:48:16AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 08, 2022 at 04:42:39PM +0800, Xin Ji wrote:
> > +#define DEBUG
> 
> Please no.  Rely on dynamic debugging options, not hard-coded ones like
> this.
> 
> Please remove this.
Hi Greg k-h, thanks for your comment, I'll remove it in the next version.

Thanks,
Xin
> 
> thanks,
> 
> greg k-h
