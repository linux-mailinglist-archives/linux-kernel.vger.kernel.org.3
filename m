Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B9554EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359039AbiFVPGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358938AbiFVPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:06:39 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-oln040092070012.outbound.protection.outlook.com [40.92.70.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8483EB9D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2dV6eyiP+0KFbWa8RA93DGz7nkTwoI8jNBskmhX1Fd9r6rhQcrmnw3uo5ot1+2Hk1fwyFLFHmEQ+JknES+xRpjbnzkGCmXEXvWSXDaxSL1h+yYDbygUP8Ey87dZNMQ6S96zCVbhYQP0isYn6QtGxlrs1Iu3MYp2WNjVLnxaJ1RTCyzWclhoD6jMwJuSKQrhwpoEIAV3aHTcpfUQaczmQxkycxRdrX3lxsHcrvoY2EB2hEptT9i/WL8Vk1BftLTg6x5LvXVNgegKmrleHDbUGWGfWsEa7dKukuOahdtudh7j9QE7pl7AZ2x/uRq19BIcVSRx9vOh3/WJvBERRzidNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn4sEBEiEWUhZ/vsdXprt4Jb9PFngHHWNz2hgFdKAWU=;
 b=Y30ZawHd5uDAHkGL/RZo0nzAq27hIURvBfV2bzT4uBTiNsScqq3Ol9KFnn657vkluOt0t0yOy4d7yF72hEA2Aoz11exHxSWEhCoVlkaXyEt9vJNN2F0oXeTqlcmUiJ464wwfhm9Fvp3IbhcsMvMYWtOIiDOne+xxPmkhSOqivTICGGcfg+JdjZ+W5GtqH8nVQaSFj5PnXep84h4kLn4wD17Zj8RmDseElmx/OKD3jc5xtf9QEXkoWAoJ/0yvknU0+FoIIZCR89Jkr4T2DK4YqegpppPfd0iKU1qhGxjpoJPw9rIoegaeY/t5M9SjmP4tnOm5G7Vv0BmmqtEnaWmyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn4sEBEiEWUhZ/vsdXprt4Jb9PFngHHWNz2hgFdKAWU=;
 b=VoeNr9vZ8kz7uDWBanE2AwYMcjeWIY7d9qt3yvbDT7JjWj/7lPoRc/0MJnMOG1dfrRioLqxFHDFT++fP8od+3TwXPrHMTcD9h6Tl/by79OBKPWVXWpUvn6dkPsb1Vgrt4pi0VV5HQnUcbCJt/JsJ50IKIXgJRyGDBaEQM88LH+maJAnv2CNwzjjH9ormlvS4SsEzw37ltE8XWy0A7fEUfDh77qT5Umnj9vy/YgxYwSBfZMq0A65rphlQK6oomeEOk14oRNyWIfttRiyiNPGOWGPmHUMQOzPRAkovxYyMtFJyp9htcphoScu8GvGAxmOSlZWNPuUpipsZqiMH/fsv+w==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by PAXP190MB1504.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 15:06:35 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 15:06:35 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Staging: rtl8192e: Safer allocation and cleaner error handling
Date:   Wed, 22 Jun 2022 17:06:30 +0200
Message-ID: <AM9P190MB1299BE496801C92B735967A2A5B29@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [einGLq8+dg/h+EUQt8gCEe8SZTeYrUNl]
X-ClientProxiedBy: AM6PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::28) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <cover.1655909205.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1585eee6-83b4-4bda-8758-08da5460cc9d
X-MS-TrafficTypeDiagnostic: PAXP190MB1504:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jdk9e3P2zGIwauovSBPhlVLGx366WawxW+3MfO2mPP7+3jmzw3wVvzMwhgk9iFH8LAB+qtGeuH4rV4x0suoCL1nPrv3bUXG3rODLziRB6zViXWt8wMkSTUsFSBbi3q4ZWW+2lLzgRTtY/dc1ax7bo1QccWSwz5liWf4b5PCSmhN45deOg1edtFXIIVyqPGF9H9kJ2+sDIjqJPkx6Yvety+xGFOXjYhy0Ua7bYnFQENS0aElaU1bLeEa7eVTIEvWHspe+ITniWt6vS15jssy0Nrei18BxfnHmDTh+EuTi80ohPKY1BcWwgnnUta7igdbvi+Xd1IvsqUyihTcUkJlNMGT1LrwC9UKtLiu01zi2BHon5kcc2qx/gM0b4CRJW2bQtlgn+lPeUCBChUTFZels8GH5zM3uJDriPTQkKXp0i0u3PafggCGcvyoLPEoo1NzVzv7HV+L4N/iuFhSLZjWLMvC8Nzc6Fy7wgVWrQHjsyI8+xKG8IC2CHySirlJf4EcxEb+5gUT4IBb/NNKPdO9a8+80lae7PukiXmrtXp5Bg3XJZU+DX5nUj72YVycHk0jPLVT0ozEJC7atSif0xlUT7wOT/HQJdSDRW4XjaFByScqd/64RDqz2lH/6GlpWatWYVcGMCXnx3rIvp4ImLjYvpg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mez89Z3aJyUK6bqn8/6tVqp6Ilf8QFcfM3u69CgEjdImWa3Kapb1AA58Wk+n?=
 =?us-ascii?Q?7wZavfF91RDavOYfma6ZweetALOf6pxxNBGL9x8DTSez8j3A2yarHmChEqEK?=
 =?us-ascii?Q?gQu5KA6cAV4Xw7ETht2yGrqvup3/K4D4DNx1ZE7bKPiYFxSm18rULeCfF0/E?=
 =?us-ascii?Q?p+6lxKVTmfFEVoGRXUGTbJ/UPrncgud1vzy31y3hk7P/UEM5oVDEuCRrKjZ1?=
 =?us-ascii?Q?szD282HTZzLGt0X3bn/1AKCgz2O+CdMBkLZJS4YO+F+YR7H02INiHGGvI8Sz?=
 =?us-ascii?Q?0YXdbgNTl249JLUdxJGFKJD6UOlwG4KRiXacDTOk4Rp1x49gNso8NumYqUEO?=
 =?us-ascii?Q?Ioolx6R9PTBKhbg9e6XnzP8KysfhoFTVcZqrQpwaJOH4td2W+6pIXNEQFR/O?=
 =?us-ascii?Q?utp3GrFceQFicEGV4rJzpsqz6QjLq6VeVikFLYXuetLTQfQcCERDw6n6L3W1?=
 =?us-ascii?Q?6kdl1hiKRe2uyG80z3myBfM2eAiAS6uQK+yPjhW3nTfEa4tMKhOswgMVgPN6?=
 =?us-ascii?Q?8HV1JT3VM4PdF5x3/HZAbi/eor4iNdfPjEs3UDi68xy0f4Y24NGf9ELUTD52?=
 =?us-ascii?Q?jiLmJTH1CswYUOgNyXmfYxuwPp+z/YLPMZfA4J65Kxheuty5EV2+DBYer+XM?=
 =?us-ascii?Q?lovMPhj7MaasofKMI/cO8Kr8pAKVCjCxXpo6vr+GLIT+H6q1GMV2ICuIt3oG?=
 =?us-ascii?Q?xMgizDslDgB60SopG7QrWyh0+13kItMQfZu7H2MVFcQak7yuX+qIatQ96Ao0?=
 =?us-ascii?Q?DpsUDBeyk21V2SZUDqUsSCd1d4zUimMVUR755bvpibZnb0ARvzd+hmf/vbem?=
 =?us-ascii?Q?IZWRN9TIXuVp7zcJ6saxFisXtFm6UYCWYDk476OU3KeUdg3YZEAQJtx6tTGZ?=
 =?us-ascii?Q?Kx1NU2BEcyHc+ulvJ2oUWqUBYGg4Ovc4MdWS5IUJrblMBD3blHs8Yrn1TrLp?=
 =?us-ascii?Q?awp2J+lw4F28d4PrGirgpJ7smHx289xU4x+aTS42+LaEAnMXKfo1tLQNs9sJ?=
 =?us-ascii?Q?QOKYlviKQZXb7QYpR9bLHjQnq3/IbimQh60R3sjUsZF90wHIVCkdbZ9r5DVN?=
 =?us-ascii?Q?pbA7eYhudmo3Eyir5qJjf+21BTvgY7ruQTKWk97ziugf09lF4gejvPCV1Idk?=
 =?us-ascii?Q?7Ucgpssx1NmSy6nEjqNeDgDhLdZlTOxjNhchwelLvE/C1Y7psYrgD3wL7AsG?=
 =?us-ascii?Q?pD4wBnbict/gQ7F1yisiTrbJ+8ExRBzKPi9gASzRhY/SvKtNhxA9noYql06f?=
 =?us-ascii?Q?j4IWi3x2GiX2Jgp9MFHCO7OI30CeTUAK5B7f4unIeZPAdIDyZpiNThmO3BDO?=
 =?us-ascii?Q?lo5i9Rg+JKpS6NqVZcqZ2UY0DwsDHLEqE4+njEf4Gdr8FRz6twl+Bnxx1Dbo?=
 =?us-ascii?Q?LIi46B33a9VFHCyw2DWHXd/DPkKL2X/WiSfjoGgAMCVPNzF1nsY2QzXclPMO?=
 =?us-ascii?Q?lJEriifCzyU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1585eee6-83b4-4bda-8758-08da5460cc9d
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:06:35.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
  - replaced kmalloc with kzalloc against memory initialization defects,
    thus also removing a memset
  - made error handling more consistent

v3:
  - Split into smaller commits so that it's easier to review

Felix Schlepper (3):
  Staging: rtl8192e: Use struct_size
  Staging: rtl8192e: Using kzalloc and delete memset
  Staging: rtl8192e: Cleaning up error handling

 drivers/staging/rtl8192e/rtllib_tx.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--
2.36.1
