Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093B155218E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiFTPtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiFTPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:49:41 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10095.outbound.protection.outlook.com [40.107.1.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B11BEB5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8pbtTwcMMoQoRbBo4c//cCaERTKHI0ehcDIHv3Gbk/dYygAhPjgwPr8RjH6kiPB7wC/TSextMp6y7A8pJFEpv5by3rh7Eir9L+gqELtXjgPzMH4KHrQImVlqv7kSx+FLbuFw2TWA6GGtcxEH0H4Kaik3OqalJpMiIYBOUrXSNjlJ+DoOChaNZODRZcFjuQScTYAVERYGZXoro1X2HXj0XUOI/1k3C0PMNUrO0abcrWHfXY7LzC3bJlQmzKl/jZLHT/OfGHt7jZp18+/2sRSX5N5h1PsvadfTi6ylBd+75sa73wlVAU5buHTvGhi/FeamH1kgo7fu/N95c4Ycovhag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A0l9j2CR+WnpVZzOu05og+4uz8BzRvFxapYbylIHG8=;
 b=dze1tc1/4XwITvl4cGLADimshlMC7RTsVn2Ul8QT75HHWKw5i+b9qSLvfulxNsllb6gZVHcpYxL0AGtD/JmtorOqt3NcqdIxf5ermFmaypUdrEP7AZ+nwaOK8CMH4rme085FYCtL+MiL5AiJrZ6bZHM+8NH8B0XUS+HjFV2Wu4ndGeyLQbu5FOHQerUEiTUVqXv/VfLnNzwGLxQ2m+vudzINR9IS3Y1aPWbVoTCkReNGBsJB7i5kaAZE/i/1dDz5csrW/m+m7W1Kl1g2Y+9d0MDasDkofhv7HD+R/euwiwKPNW9aqcBpeCZgEERg0YsBfbEnqfu5X1Lw7tnI1TryoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A0l9j2CR+WnpVZzOu05og+4uz8BzRvFxapYbylIHG8=;
 b=spDkynicyyKHET07tCuDgNKmb3MjAK3wPIvjmX6s0tjr+R+d6Hd21U9RRenS84euUn2dBs5EmqJdk/TGf1lJPPSocnbKkASRzkByMXLmYjD59wD6hS6SUW8tNyc5jT604M1DDxBFMnUUx97j0uJ/Z6PhPjOPtrq2h7f61ti56O0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com (2603:10a6:803:13b::17)
 by DB6PR0902MB2022.eurprd09.prod.outlook.com (2603:10a6:6:e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 15:49:37 +0000
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::10ca:5087:bbde:5678]) by VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::10ca:5087:bbde:5678%6]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 15:49:37 +0000
Date:   Mon, 20 Jun 2022 11:49:32 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux RT users <linux-rt-users@archiver.kernel.org>
Subject: [RT BUG] mismatched get_uid/free_uid usage in signals in
 4.9.312-rt193
Message-ID: <20220620154932.GA33760@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:408:e7::31) To VI1PR09MB3582.eurprd09.prod.outlook.com
 (2603:10a6:803:13b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77bc5f1-8eed-456b-8f7c-08da52d47ae4
X-MS-TrafficTypeDiagnostic: DB6PR0902MB2022:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0902MB2022CAA6F489B5B2B02B1FA1A0B09@DB6PR0902MB2022.eurprd09.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZms1VdM+ksMauv26bm1DNdpTyAbw0wD5g9V6JQOJC8kQ3n82D+ZRlfPS75/dUVW1VXaf5YWEBn7YhhjhiKBBQRnze5DLSdtUBTXm+wLmc3C1jbdr6mKsHgUurwXY1ApZu4QPiYOJU2+hKpHGuh8Y8LNbGEfGSM3jSPTf6olPPPMhFYAciOabhipPQDndDMQq/H2mMEWmqqzD/9Stj5Lhc7J4oOat0Yc+n9K/9waWDyKvy2kJFL4DlgwuL9qCaiZvKKJ93ELPUtspm7Pbt+uKlIF34bGds/yXVv9jQmbHNeP7c3rAsKkSq9CktG9PAGcBHT/uR2dLbbUxJvaZv1BhcEfRFNZuy3BVRQyiHOas7rl5/Qat/CarxeolGb/umzvczGzXn8heI+h6xc3J6MP5tOK9UCeWuvUNCAJJuXGuwCpFuRw7qtdt1kgP6V9ubIZCE7KPpmsx9YU9d5FtEQMxMwJs2lU1Idf9zsFOteMgAGWFUoowJmAhl5xLiC3iX1zz/uYozqw8AKUYSdz3xb7TQ3Qw392RMswi7vEWtsPnfWM9kg3UhXyGNXFEHGiXvNlPWzdgpe5fUQo/rf0DqwpkDYLslQKn+WHfNldQxZ5RXwde6jc23z0N0QxG9vftMAWw61ArWqIvVh5gt/BPIOR6IyuUNjoERxo6C+kN/MYd4DXceXgTdktyFrGw5WPXjx5kZcfIYStmHhOZdwyRzvB6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3582.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(66476007)(186003)(86362001)(66946007)(4326008)(83380400001)(6506007)(66556008)(4744005)(38100700002)(3450700001)(44832011)(38350700002)(5660300002)(2906002)(498600001)(6512007)(52116002)(26005)(8936002)(33656002)(8676002)(6486002)(54906003)(6916009)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dcMvm741wjh+8kC7iK7kU+MW+GRg3ZZK5983T18UC3fB7vE5f8miiOKR8tgo?=
 =?us-ascii?Q?N4C2KoKwy1P7z44m9zfg98Wuc4WAAlSPj4lRoVeAJjTPotgsrrI4C7QYSZdr?=
 =?us-ascii?Q?igJnvKuMBE3OJhu+MGIAHA7q+3bpAH/dIUZ6C4RbHrYx0d5gu+M/+Rn6Icay?=
 =?us-ascii?Q?RnzN/OFzr6fjhLHsUwwIFV+E8FH5mhZ6QUZoQN483fI5go3+0z/PlwaiTI9n?=
 =?us-ascii?Q?O6VtO4Z6uNSe4S9p2euMQdYeTsJN/g8Ig4NnRz970WsLsrkSi95k+2cRrnpO?=
 =?us-ascii?Q?ePeNhsrJDxNYSnrmIgKWIrxF/z3BwYjMtbYULyVkugJAHPpLHSD0NirWXqOU?=
 =?us-ascii?Q?Bzb3Z4UU5q4iaPOCTpilicrys7sJ7KVWBMQ3qAS+YG4MirLirNLnM3oQhmAx?=
 =?us-ascii?Q?c+GRBr+HM7bFUMTrVJ9ENBF74s7cme5OwWcqj+fY6XerhjyI5xSiGxYBK9LC?=
 =?us-ascii?Q?3mId0usQbh3P4NqALe70uKqO3P/bvsFlilqxYcmISvh1TUneNnxvlRFOl2de?=
 =?us-ascii?Q?i5tngPSfSPryuAUZ5ulQG/sqM4CWzIOUq+wEBYzxL9j9ukTQZgYd6R22T5AN?=
 =?us-ascii?Q?nucpAIt5r9VgUmKdUn3wrNgxHM6TMHKg/cRm97SFfZbpoKZPWrqDHyAelc7T?=
 =?us-ascii?Q?adu3SvUKrysyF80qDI5s0ZXum7BtZIcgETDCjY3aTzejHxQ7c14S0+PDcfyT?=
 =?us-ascii?Q?dZ+Nixh7pgMp3Mk0cqyQPyrenrhvscad1vxYblDJifBBljwhOEjbXQSA1+ag?=
 =?us-ascii?Q?VectRRf3UWsmCxk9egIoQrV5E59qHPxApgjYX7w30XnhDA6NahBz1nwISthZ?=
 =?us-ascii?Q?87uzi30sHNjsCLA20rfTBiiimduyVgKvY68r6QLri1KpAbG0bRfzlp7NRCUf?=
 =?us-ascii?Q?kQxn42uGLr6vOB/0tCoiKXnvzsKYNv78eIWqa17loTaWocqvnZXYJbMeoiG/?=
 =?us-ascii?Q?nXEQiWNHmAwrg1Od56wT1HDUamfojG5g8amlNzejLxq1V4VbKyWTEuQh9M/T?=
 =?us-ascii?Q?HLPP9N0EEyjOTdOO4vlmj/GIjgiMdnzxg1N55zvFeBmol5o3zPnhEYdoaj0T?=
 =?us-ascii?Q?BF+T4MVnV0qtPvebRXyjx7fpAcg7+1pvawUTLXVG4qU9gjoONpvIbN74Sukw?=
 =?us-ascii?Q?nM3S+Aac3mTsC8S2AATNB8xQOqKA0IYPm590tydE8Y6V9CftiG+xDHMfG4bJ?=
 =?us-ascii?Q?2aDknMh/J435cR4rbDd3mVEfOspSAXE3NLMNERMNKlMprtT2Rlxo1dcEfOOb?=
 =?us-ascii?Q?L4FFOvowA5aR3riR9o7NuJoJUuUyML94yghsEv/CbaaPo0YK7Lze0nu1LL/A?=
 =?us-ascii?Q?qpkszDSzwgQ6pFRXzV+c3hmg8k7tsal05LWuDYCF6hF7NKXf10tgQkwlhUKG?=
 =?us-ascii?Q?/ala/DVbjs9T8L4xdlXsVm8N20HE47G6LI6+pqOgPua27/qRrr62JPEc8+2n?=
 =?us-ascii?Q?3zTKHtobuu0scAGQMDsH6gAMCiM5o97HXRb2ZWOVjiwaWbpnMNrU+xsWV09O?=
 =?us-ascii?Q?SFOiWGPfol7RbCDgeM6CY3/5WprYMrZoWdDznQr6Umy55M1qFu16yI1iaF5M?=
 =?us-ascii?Q?I1Ikiij4bvH8cpoFfZMFNaNXnrDcqVGCOoLJvpatFo7eaPeDV5zCM5XbAxb1?=
 =?us-ascii?Q?Cbda4vH0ghM3j8AF/N2KQ4kNQgZMVvjknJM6rcfqDOlG26DXunQZWhkXljmc?=
 =?us-ascii?Q?F/RHd1QxnhA8qfUrvH2jWwHhWnk+Y/K3dQB1n6Ad3c8AStIqJh3Z7VKEXGpu?=
 =?us-ascii?Q?J5dn9M/wgb3TVg6P6VHETQ+AsMgvlqA=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77bc5f1-8eed-456b-8f7c-08da52d47ae4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3582.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 15:49:37.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bnl/1LJuR9Og7NOVq3Mt5imy7PfNofXbhk0J7dNL+A2XA59NeTYLidCSimZ6xFNTboaBTo6q8fQRCvewpc86MTFvg/hkQb5OIQWf1LD2U3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB2022
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 4.19-rt patch,

   0329-signal-Prevent-double-free-of-user-struct.patch

needs to be ported to LAG 4.9-rt, as that release now has the Linus commit,

   fda31c50292a ("signal: avoid double atomic counter increments for user accounting")

which breaks the longstanding rt patch,

   0259-signals-Allow-rt-tasks-to-cache-one-sigqueue-struct.patch

Current application status:

   4.4.302-rt232	OK	has both Linus's patch and the fix needed for rt.
   4.9.312-rt193	BROKE	has Linus's patch but not the fix.
   4.14.87-rt50 	OK	does NOT have either Linus's patch nor its rt fix.
   4.19.246-rt110 	OK	has both Linus's patch and the fix needed for rt.
   5.4.193-rt74 	OK	has both Linus's patch and the fix needed for rt.
   5.10.120-rt70	OK	has both Linus's patch and the fix needed for rt.
   5.15.44-rt46 	UNKNOWN	no get_uid/free_uid usage in kernel/signal.c anymore.

Regards,
Joe
