Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B7B5620B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiF3Q7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiF3Q7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:59:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2109.outbound.protection.outlook.com [40.107.94.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA1B205ED;
        Thu, 30 Jun 2022 09:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3uBnG/oswBkgYH+wVKZqib4bXUDovmzD+cgCktIk6iKdw9xyJP+Tx3QGCeqiQ5pb7QrkX3KP4adIQ6zHvR9SviZICUdAyJyEjtP8SLIEgtfXd60I8PB36SiYBC2ypYi13Z054pBcfbC83IUCskGA0dOrdQSJR3yi9DY8Z4t/8V3LhJ3+0lmop4q3lfBxZQzLyVaXYlaGZ0uoDAMXA9evMlstJukWcPRcKqqOW/4eXpGwxiGj7co+YsLiT3nVLXrD1qgD3IBJPSzXr7jD4k3nk/tCh6jybuhLBU4wibmBhbeP/lmXQHGN5WdXMF2c3c0Ya+jkaLdr37D7p2FajuToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UWGs03E3Hpgfj+rRfKu/Dl7twMuBlsLA3afrO1bKhg=;
 b=UI2FlfyMqT3ec/Pa5AyMBLNe/pJ2je8ZheRp3MD/X6veFHIhTOcv6pcIrs+QP/OP5xfjK7Tr4/PI3W+UuWbyXa8HOb4XRtSOLnqhFtEIwapS4GQNNQ/JW9gZjbMMae91UDaR+FhUk5EcPYVewU570pi3FaCZ+WaSeDsKfv6qdLfIr6CuSUH3JBZ2eHnp7QFYx4cGLfwsFLG5dd53LsrQz4/OMZA+aM+yLRwOiz+x3TDI/FjPtKoQVsiUtpZBgaSzwEExNYpVV8jXhnAG9TaH1hk4P4cLzeS27tBIOgvXokvlWNCZ0MXuit9ftQEBTJBabGLbQ4HMwscPlRevwfFBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UWGs03E3Hpgfj+rRfKu/Dl7twMuBlsLA3afrO1bKhg=;
 b=WMIWdRA7m+BSEFPMnsg3m4Jd5ZikSZIOCkr8lkots4+ZXhud3G4UHRpFGIdUL9NtynLy85Ni5fycJvanNOLgpF1f5D6HevcCBUbPSahD7RdE/VSYWoHPn+PRgHwwp7JFFs+DvXvJRYADdDDG0tEvKKtF4KKiowTJ2nJIImAOgdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BN6PR10MB1763.namprd10.prod.outlook.com
 (2603:10b6:405:b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 16:59:36 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e%6]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 16:59:35 +0000
Date:   Thu, 30 Jun 2022 09:59:28 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: use-after-free warnings in 5.19-rcX kernel
Message-ID: <20220630165928.GA2152027@euler>
References: <20220630043558.GA1985665@euler>
 <Yr1JKPLQRj/IM21m@atomide.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1JKPLQRj/IM21m@atomide.com>
X-ClientProxiedBy: BYAPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::27) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7895689-41d3-422f-a164-08da5ab9e929
X-MS-TrafficTypeDiagnostic: BN6PR10MB1763:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wY+PcM9DGGtOMtStNiRCKw7xgNeu51C9LjF+zg0/Og4kIEquozK5O2tPfBhJZ/vA4B3/Kg1CqoGnMw+6zbi7vPZKxLEVZ/UBHPe0SDmAUuRhOGhC7G7O9mk4IHgLykqqV6VDjTe087DSDPyZoHZZbuCh1rQUzUzHQJWDLXrr+aH0VzXNUTcuTNzlrd6u11lpyVY3260J1bPw+m+UQo1l+jZaMfc/BBW56XUBkOIb7N0Imn977CF5sj3rDbs3snf0/6AHpg+eanwlZFL3d3A6QxzAU2ulYe2+vop8lCfQhIv3Zd92IHQmm0Fb7+wPn7iG7BXjajB5zwe3ZhlSI48JKR/muLAwx8N5D8FI74xMUmNr9rBsfhQLB/yPnGN5CQ+pVAMoMr9Do3F165aDuFIe/ZU0q7AUyU8FEt1+edjL4sdZXYu3W++GESP4KU4/WJoPxwzwZAuCA4Kk+Wz7xwt3ySgxoH1tk8l6C7bgNXETbKPQTtPnYSBbOlbxP90IXF5/Qnegd0z2P8xXYXhoR1r/bwiZE6b2fo0yUnupVnvGhz9GCgKSgrvz1YDzdVZhDxCD/vqfmV4HxpUY9N+0ro6YRZfOG8ZHdCkZA9bgSFpl2/U5vZQ1FSraTy8W2dMu2JSI+FGz8DlXWdpESf6dX5BzW9aUqdYBMnFUXhtmNt4uvwBAaa6598UQ2xS5H61fV6rHPTQUmSant81+L4X9h8YAOo2hhisFn10bEQyt6w5pC+7gjrv0NzndP2VTR1FCG/m54XoBFcGIm80eQURyNqjoIkiO6K0tMYM9zYRZbqWwxTunfAgcQhdq9vHLnrnmUUOxb6gTNx1lcxlbShSZvrEZwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(376002)(136003)(396003)(39830400003)(6666004)(6512007)(6506007)(9686003)(41300700001)(86362001)(52116002)(26005)(186003)(1076003)(38350700002)(83380400001)(38100700002)(6486002)(33656002)(66476007)(66946007)(66556008)(4326008)(8676002)(2906002)(5660300002)(54906003)(966005)(44832011)(4744005)(6916009)(8936002)(33716001)(478600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6oH7dLLJcOj3x+4HZjMJiLJ5DA39oRtbR+UPyHpvkpTjdKOFvvIRkQDO2g37?=
 =?us-ascii?Q?sc3b0wgxkFmgtDLUivJ1fdPHDbyE0kMAkx2te+Mzn5LXF/b9VSgXwV+LSr7E?=
 =?us-ascii?Q?rxovEPmmgR/JaXRxCPtH9KKA+OPhv2leZtDUn1IP2h2zyvMot7y8X6IBXW86?=
 =?us-ascii?Q?LiHPuPUsJ5rbYVmAlw7f4yDLORRUT5Wt1M3h5v+3kXRb78TcFYzefkgR9aiZ?=
 =?us-ascii?Q?vszH+AOHlGYoHXHHDranT04qsbUAsc4KPaKxQwh6ll6/49gFCEiOaZnfMTfd?=
 =?us-ascii?Q?/Urpx5y6ZXMu9cIgGyDxjU3ExFZB+RVijDYzutz3pdr0DfkrIq1ENt8vP6Ts?=
 =?us-ascii?Q?cbSA5o7g5QUwT2kcRJme745RmzoQ9oshXUuqqYHdEbf6Axi/7B3zM/Zy3ygR?=
 =?us-ascii?Q?YR6YMNTS4LhT+ePTa/nfKYKOdZYfSEJASuxF3qwN7ISy1iDSH4pusoalzgrz?=
 =?us-ascii?Q?vns6GvY2NE5rzu6B8/kqAQvdUeE+FQdROwq0Px/Z5QHi76ya23RI8VSaikfW?=
 =?us-ascii?Q?reCeJk22QfSX7fa2PDmJokN++mz/DL8repvHmbqgut3TXuopRseyiVPjrUuA?=
 =?us-ascii?Q?90aCykpcJuf59zMuMvLtu5OeUPyguk+zUZYtkPK8lL3Lexn6WEsbCK46CzLf?=
 =?us-ascii?Q?XQk1qRbezvoti4ETKtHRWSqj0gdxFWi6+MDcfSiUXtNPfjCrtwcYuYgpj+Ta?=
 =?us-ascii?Q?eY8bBPRCMhtFQe/NxAG0bVr14e48EXLSZyUCBz8B7TUs1Wpjx4m7uM1KnvIn?=
 =?us-ascii?Q?n1qtlQQJSxxUy+eVUIuNSPWNjnIFsJe7+khsr+EjmPcDH0ku2aVYVJgoBsqK?=
 =?us-ascii?Q?X3jCjB+S8OjSIHY6aAsht9YugHaGuI6ycU2OoY8T6S5/5hL9Qnm56bfcawm4?=
 =?us-ascii?Q?HXbGex/qkltU4cwOPfxftzlJprMDjLIo2AFg2GFFB+YnZllnz0U0UWDviXxB?=
 =?us-ascii?Q?h2fXUYE9vH5XylPNy2Sg12kCVzQkfcVqVv++sjLTJ1rSkG22Y+8Ff6jjTvcx?=
 =?us-ascii?Q?BefJyhOqeSDUIQGSEkR20l13j7XbDsP4r2fvHbXxpjQOsUNbL0tc1IOo8GO3?=
 =?us-ascii?Q?KpS8Xa4mwACrPz5hl2e+6imhKGH09xYTd8d7DunSPXnm+RLmg3cuoYu9Guxh?=
 =?us-ascii?Q?cUiIqXcJ+nYvb9TuOHvdHHEVEnoJrc4x0INsjaxrkOD6e1VJs6CklSzfImp7?=
 =?us-ascii?Q?5yWrQRtV/Ju98FrmhhjPkfzE9/PdZYb1atQsCt14RaO9WZ0csl9T860x0G1r?=
 =?us-ascii?Q?LmJ1oOOK0yoFyUoftDBppVkBwzuJIRM8XCgHPMdtkt4PZh/AIxizohDLFQGD?=
 =?us-ascii?Q?jeGmYzdlHhn6gmZsc/gck2pvl08bb96YxCV8FChxh5DQiSE1zZd6mese6NjE?=
 =?us-ascii?Q?2d51uHWavBcPTt0zz7maYIlPWB7Wx3uV4I4SlONzQHr/Arkz1NFrlcn7tltk?=
 =?us-ascii?Q?O2PXWTSwPF0Ll1B5vt00tjgzsYAXidCSC0hfyXw0z0ldX3+Ki8rN7r37Ya3Y?=
 =?us-ascii?Q?Frc+LeXzlbcmM+p07HHqpQPc2wtzi1nC63A/yzmRRiEQRHSm/153tGU/dxV+?=
 =?us-ascii?Q?uBI4b0BRLUAtcqM5+0ZjUwfFKNs3cFOq5v0QiPok6PpYkgA3+UQD76NTpRie?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7895689-41d3-422f-a164-08da5ab9e929
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 16:59:35.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agNdL0TgFz5dUwoaBF7AUXSDVkOpAkKATadFt4/+gfS3FM4A5sxTxOPQN0t+v54fO7SFQxffwMiK8zMNYZY/dyqyevhEg3mEYQI1dzkVEyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1763
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:56:40AM +0300, Tony Lindgren wrote:
> Hi,
> 
> * Colin Foster <colin.foster@in-advantage.com> [220630 04:30]:
> > Hi Tony,
> > 
> > I'm running a beaglebone black and doing some dev on the
> > next-next/master line. I noticed a lot of messages coming by during
> > boot, and more recently a change that shouldn't have made a difference
> > seems to stop me from booting.
> > 
> > The commit in question is commit: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
> > Prior to this commit, the boot seems fine. After this commit, I get
> > several warnings.
> 
> This should be fixed with:
> 
> [PATCH] clk: ti: Fix missing of_node_get() ti_find_clock_provider()
> https://lore.kernel.org/linux-clk/20220621091118.33930-1-tony@atomide.com/
> 
> Can you please give it a try?

Yep - seems to fix the issue. Thanks!

> 
> Regards,
> 
> Tony
