Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562AA572AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiGMBft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGMBfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:35:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69A5CB448;
        Tue, 12 Jul 2022 18:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVDieQz88IsVnoFAwccPx9UKB0bWebYn1dhTvDFQRx6P9nEWvn/xwfmQ0NFi7oOjQ8PCVFjOeRM+9D3gxzPeLSkIJZIU/deqxPxI/6GTo8aMc1YIVmW9XHGHftroW2DRW51aeGfOHlowEuqCwYeHfhFQrxOUQuWgqEU3SP0SrSIHxdoXIC0zeKZ17GiEDTdFipmODaWtBxVHfg1Xk85eVtTdz60F4IyYtEKsX69YBcP7BGaXTy/1IlI2DYpF/M1izQs+AGZLyknBImYqSXisdSeqohOEEUiGdUpucF26bs1EbuNnk0Cr2KJnwDVIjBZeYqH3jUyCS4UygV0YptTzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddo/S8RK8zfpj2dyMNU8a7uWnD8XMriQO6FxXXYVM8E=;
 b=Tr6Ef0kXDoQ3/QZ4oECcWSxkW6LVP/gziVO+ePKU4ck6assQXYwKi+FKt8LbdZE8SkmLwmfjaItecACa1SqF+mC/kYv4Os9axovDEzNWY0iBDl81ufK7l05Ewcr3Ff6FRfaYMP8JWLxYdgxp91TdxMcPu5h6iN9fDVC88IZyDlQxmwYrc1CdbkQcBw4xPo92AwtaPhTsfifkVR5wvL70BSXdx1C1VJMwSz30EqUJVihkcWwQRR/LJVuX6qg94UED/O8dXijIo/4ezw2DwHyB80tg8/mTfKa691Ur7t3vpAOIsS4D3TaY3HK2F3+aJwLGe89nTMQL2mTvdt3FpbKFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddo/S8RK8zfpj2dyMNU8a7uWnD8XMriQO6FxXXYVM8E=;
 b=CqnNj9XHIcrD8u1MJJxW+AVA25sjlApk0cwdYQ3G+ukctqI42D4O4Kjj7McO99dMtmRiDS8ShQzPcmQl50sOgAsbtB0NviQH8RfjDRKocQruXfaHZfrU3u7yqMMJq1ndGWPlm0hJzxiYc+mnNaH5tjjuKv7ZbCuMDNhDQ4DM23M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BLAPR10MB4931.namprd10.prod.outlook.com
 (2603:10b6:208:331::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 13 Jul
 2022 01:35:40 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e%6]) with mapi id 15.20.5395.020; Wed, 13 Jul 2022
 01:35:40 +0000
Date:   Wed, 13 Jul 2022 01:35:37 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, alexandre.belloni@bootlin.com,
        kavyasree.kotagiri@microchip.com, UNGLinuxDriver@microchip.com,
        maxime.chevallier@bootlin.com, michael@walle.cc,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v4 2/2] pinctrl: ocelot: Fix pincfg
Message-ID: <Ys6D2adSuRmoSD3s@COLIN-DESKTOP1.localdomain>
References: <20220712195043.3842081-1-horatiu.vultur@microchip.com>
 <20220712195043.3842081-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712195043.3842081-3-horatiu.vultur@microchip.com>
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 770587ab-51bd-4b74-e28d-08da646ffe82
X-MS-TrafficTypeDiagnostic: BLAPR10MB4931:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQ0RsYgNmnKk6PfLdktylZ2taootKFXVkhKvtzelCuGAXKBaczhQv2CiEnbPJ/ghwoOvq2YhO0DFX1jiRFvzoCHBgAl37fiP0+S6khdz5S3QJgnSS3UaWUbC+BgqDKj3fIWB9E5T7lBRdrpJNMMeTznYurvpTDORn7+TTvmPeSkTSnGG3FTTyJiMMZVhBR2RG/Q/zIfgZkqE6aZKJ9aemSHg49/V6OF54AMpVI76n99iIWgi2cuZJhKrDMuJoOYfPu/V3qcw8WsMFvjm5h3FZppa2mprrOgJ4br9N7rC6oFkenQphKu4I3KI3OaGUG/2xf5gHwba+sqdQsObGjKJVE+gbMZnz6IA6RhKlUo0wflQUrJns0PB4qDOQvpl1RukaBbYVZebt/FhUlRPP7qYmh16e6fn/mT6sZWkPY1Lom3U5JIhv3rVLNgbmHthT7u4l2UpRwV811WeYe6J3u+I55dUd0R9jIhUHmpMQLdJdUO8XBI/6FYAOWQrgHL4XUNIZ+3Jkwwhq8F+1H7ls00MykPB4n8adKRoe/baJpsIqAk2ljxgN2fp/aZKcNxJOPo2B8nHgV/1yKepEk9xJqqWZdOLT1lmFe3sVG6IH34YoZbgejMaVITqAEeZHJTYqay4waZTk6NEo5Gika9xWRpTUxfYUOKb83UYF4f2ySZoC7uYl5/fSTeY8eLfWod5nNLxzbYT0oyFGDll+CixR1kchDoFNQ0R7i59Myf96OrqWMWQ6Fe8v5whu7J/EvMWtA27
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39830400003)(136003)(366004)(396003)(478600001)(44832011)(4744005)(6666004)(83380400001)(8936002)(6486002)(6916009)(41300700001)(7416002)(5660300002)(316002)(66946007)(26005)(8676002)(66556008)(6512007)(186003)(4326008)(2906002)(66476007)(6506007)(9686003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+AAGnYfYoeO6PWv9bbvdhcyqyyseZjGCuZcFUbqNKvFw/HprHUUoauyJHnP?=
 =?us-ascii?Q?fzgx5bBtDg10QHnAJ221gD/98k5JZyK3rvzmm8Axtf/20VChC5L8ETAbwjHd?=
 =?us-ascii?Q?TBa/xR7cgDPdnkvRKmroFOmOk11YPLEPVoLxTB0hXTrzxBmkUad661qgrokV?=
 =?us-ascii?Q?SFUXGz+fGw0abbgO5NGkdH4MS49786KWNX+aF+UcURpVB3I9uXWzvC7b41XR?=
 =?us-ascii?Q?2BlR8DUYOymAek8xzzCLK77yf5DPH/6qS8JDRU4uMwOgBo5zR3sugZ61FK31?=
 =?us-ascii?Q?WuNZq93Eto8FxckW+lbk5SeKd4t9MZAGFj6vBLiK3pJzNmkIpd//IDugLeP9?=
 =?us-ascii?Q?XLGXdU4ifpcecqnBDUi2ZRc6JpsXQ8cNtFcI8cP4C2G0SDylvVPnchqAVToO?=
 =?us-ascii?Q?dnzHy1E87xxxebdPTunWe7fIBaf3ndK2aDaFAzuEN9dtAxbcDubB5A6vPSHd?=
 =?us-ascii?Q?bm2vAjotb46h8aLomkC5ip9aQvHc4cn7NBPInR5dH99MV6oi9ISu5TH1BhNg?=
 =?us-ascii?Q?aptkUSBAjxEjJO39/woDg2eGdCf/EXyoRumnLpek0mpySSebN6OBHbLHyRJ8?=
 =?us-ascii?Q?RQ5sT2wprS7TV35b6AbIqFavGCDgoJF7rbDt2zt6lyh+QLrsLJQX1jSY3T/f?=
 =?us-ascii?Q?9Sdqks4/gW2R5t0v61cU0/cJladOO9vbcrFPfl3wo7f9v7W+BAdyfoX/U4f/?=
 =?us-ascii?Q?jQbFaZSh7P49TeWIbbIfMzNBVEZH45qqTuBFePSgyxEMMfoe8MH5VZeDEvpt?=
 =?us-ascii?Q?a5ahfIJhtXumsbvgtDe4sAGOVoJrP/IT5Twsw/oEnjW/uDiul8MQudD3rH3h?=
 =?us-ascii?Q?0zUbGAGEo/DGSCcWR39RxE2jo2QmKeQjnSnw/qARpALrlRyQ8kxklo/lsQzX?=
 =?us-ascii?Q?O0xayj12fxmeGsj8ebpqb42VphEOvFWQUk9lZI+EM4R7GQOYQOhugyN3XAfN?=
 =?us-ascii?Q?xV8CEyykRi8Ao7IftWunbC9xL6dU1VZMlsBpcLKO0k0HfzCU2iQigsff1Usm?=
 =?us-ascii?Q?9ZUEHxNevzch6Z5SMPvOIx0aNNtFs2Y81VHOdLO+fOgh5+ou8wbhD/g1U/a7?=
 =?us-ascii?Q?seWpNTVi8d9HDj/n4ION/mvqp/N1KUaZxJyuIKwcaPT7S9Bs0AVsRpaBVtet?=
 =?us-ascii?Q?cLKzUl1TEE+zTnMSKGt/460lY3xC8XPJMcnGY/x+BDeO5hUvWYYPvGv+vt2n?=
 =?us-ascii?Q?yrrnjXH0LKcoqgt7632bU+IkV+TiGqOLdpAxks5QP2QSk2wfV0W5ON0muMX9?=
 =?us-ascii?Q?458E1nEgIW7KIUKTv4Hv9vtn5B2g2C9mT+QFx3ahv+nxiqg6MWO9ErPieVfy?=
 =?us-ascii?Q?URzcl4WZPsPQnEmxBavr6GzbgYNDT20dc8ZZk9dcpn96HJg3id7nBiH4JllG?=
 =?us-ascii?Q?wlMASSofql0UTO04DQ3GyK0N5xrPtq+WgdSEgYiSuZJUEpJRoJGUdGc8clT5?=
 =?us-ascii?Q?iag3SYmf/TJpSbl94aPAMMRbIfzcx7etOPmZoMcEhfkZPYy2av8NfEhbCOsM?=
 =?us-ascii?Q?eR/n02Rxt5JznCIM8VNwgisNHUg+R1i9is+/357Bw7DEDb9pnM+XUWMu9bpm?=
 =?us-ascii?Q?INHDMLm7lvSEIhdYigSK7zlkWNy7qabG4KYJ4CnpVhzLalRCVxdpfrJLfNwV?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770587ab-51bd-4b74-e28d-08da646ffe82
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 01:35:40.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zx1ozCkafBtslADpuZdWzNZdH81ubRhgD2LDdM9h8bn1Zbx8F0lmSzKrTO8R9CZWF8lGjTnvlFPvN89VW87TQrtIP8NWz650A8hP3rj4gYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4931
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 09:50:43PM +0200, Horatiu Vultur wrote:
> The blamed commit changed to use regmaps instead of __iomem. But it
> didn't update the register offsets to be at word offset, so it uses byte
> offset.
> Another issue with the same commit is that it has a limit of 32 registers
> which is incorrect. The sparx5 has 64 while lan966x has 77.
> 
> Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Acked-by: Colin Foster <colin.foster@in-advantage.com>

