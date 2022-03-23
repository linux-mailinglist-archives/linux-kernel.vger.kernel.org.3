Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E24E4B26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiCWC40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiCWC4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:56:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1141F4DF47;
        Tue, 22 Mar 2022 19:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXNGYRhzv2pBsQ1sZ27xjhxaRpH2rzU80Mtnpt9TdDTWL8+r5H/otpyW1G1ddEfXZDAI1lN3RTH3VTeC48H61CNXAy30jRkcmARHCRuOSRZiNhCQlLylFCAktrG3B4scBdd5npQ1+yRRyJLXXWxorIZUG289lgRh4S1hpOS/8uytQlVo2APTsNy2ERyRctmBWGKSxCC6mGURR8n4SdIwQURM3aKoRx8o1+dhBXFrTL1xrRn8GpFthOTKBX/Ex00wNAUw+c6US3/ftjM1+k3nQ++B6rChU0/tWpvyLovHDj8K+UVh6f3MGXBZAmVcH+B9rsP4qZzLTiJ/XooEA45/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMX/Ik8PPpy5uQzicOn4uk3426OkAK/6kTGwwiit2mM=;
 b=fj6FaJKG6dKl/SwE3sDUQm6I03PHwUD8F1Y0ilSFOLQC6+4xhSmkHfTuM6K5jrsQEB3co+G1UW0B7UoZfbLQbGeEZorgZFzY/GVpaBqUOjx/vLG5ygj42s34nSiOJDkEs+xSMDJOYiRV1fXk8ODwmZPyziWzQAYtjNSjQcc8r5HgBUKqupg6KV+Pu4v06HK15vp0XngZ2wZ2uuj/ZaE3px18JMqHtzeL/8NRIxPqtQCVlvRt20mXi9WrcncUdZ2Z97Ovgr1DYu6GzX/Sx1NaIsczHLY/8ThrxrS97IBT1uIhBQ5yxztO4SxIY56TBfLrIQ3LVU3nrldxoEo74AfzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMX/Ik8PPpy5uQzicOn4uk3426OkAK/6kTGwwiit2mM=;
 b=jIkg8IATTdy8dGJ1HC3p6pobr3TNbgdLqxaiq9/8R4i8A71vcqckGmoQxgSLUPgyO32/iMrFBpAuVbL9yL3V+/2LDB1zUF6Q9R46tm8XeLRvyuygiWDUyHxwkDyoQZIZHrCcj/dkR7oc5HqbZpOzpMsOT0JKEfAkN9QE+W0cxCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Wed, 23 Mar 2022 02:54:54 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 02:54:54 +0000
Date:   Wed, 23 Mar 2022 10:54:33 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH v1 0/2] ACPI: CPPC: acpi_cppc_processor_probe() fix and
 cleanup
Message-ID: <YjqL6d/IEfVcnu7D@amd.com>
References: <5552457.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5552457.DvuYhMxLoT@kreacher>
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5964ef4c-9496-47b0-3203-08da0c7881de
X-MS-TrafficTypeDiagnostic: DM6PR12MB4452:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4452A5C9BA97D7404156107FEC189@DM6PR12MB4452.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLgRx9hlVqvfTFojuVL7I8waJiuHzR25x+I4BHEdYg6Cq6YQCcXvRNkYu0qrm7zVRz2BO1uUbwks8BbG380dFkJjrSWLjK9qeqb/bN788+Hs3hz8LwuU+mV0y3qWlM29+gW9vCZfZYlYJhGZDFNQsztRHftma6WgQSdXrgayug74/XcQ4U8AKo0QvbVpOHTEKtvqF3Lnzby7n6l3dBO8LDBVUTNZFYnFlyofzAHFdA3Lj0V3bRR37KwYFU5UD93hdQlV4CCUxsFY57C2CbZjhf2bpEo7IuPFxWqHUtFBWAkAlDtkJLEIWzjodu/xnYUjhY3qMCJ2LeefwWqJoOtKvv/+2KsVdfRnKXBm9tCKy0jFdi6o9KGmlvMbEGks42qpgseAiS9RxNQrYJMvRxTtF5/O6wyq/aHm8uHDQ2KSL9O/I9+fN+AOsNBdTcRQ1xeQlAVuI9bZcvAu4zNdo/uYrPr/Hh6OGE654I2FRi1wHIXBGUcaTbp1gnRcOuYHPujvzuC8mqBRnh6gbo3HySvzTKsFHl/b7nqiHqUKeRJCVr704P4PLp6wkBI2HZ70ZimVFiVgy8voamNNArG1bSRCgy8RIHM6jtmyOeFbGS9osnIzVujhsRYX9uzvopBZbgNUK8N9c8H48mjrfMP+tsJ6Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(66556008)(66476007)(4326008)(8676002)(2906002)(38100700002)(36756003)(316002)(6512007)(6916009)(54906003)(4744005)(26005)(186003)(83380400001)(8936002)(6506007)(508600001)(6486002)(2616005)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mw/ViYiWaKkCewo6Wtk3enIKoAWJDjTEM78oqscO7pS6pn13FIXXcIyXRtr8?=
 =?us-ascii?Q?P7zLEbZNSXSxJhwsEQ4yQAMxTJYejqk81/jaJuBeNTxN05sHdbMXfKf5fp0i?=
 =?us-ascii?Q?3cwJ/sTMoJKSp2MwdrjpeH2AZmrx39j4iyboVLN6842wWbkJj4FcLF578yGt?=
 =?us-ascii?Q?J/9k5SEXyxu+PQQXMlzfVGwRcap7lDzYLFhXcQ/BlQZ1caweFdv3/DbSPnVe?=
 =?us-ascii?Q?3HkOxApMcx4fZ6w5h5YTwF/aNaTCGTO0Fnih66h2m/Cvm6MVEG/ayjcHraXZ?=
 =?us-ascii?Q?4H1w0yyX7QyAngsjFnqLYvbfJNtC7vN3YA7m4ZhkrVKjftxAQMUf9GICskGd?=
 =?us-ascii?Q?gcC6L/D20xrP6RJN2N7yapbirfIEsd/Cx4l8tnJndLo16t9tvlr1DAdv6/x9?=
 =?us-ascii?Q?oYFJh3rWt+xSYZYgiBvUhoRwKw7KcX1RU9S91qnip1b9jXuFL0ARWncTQkMT?=
 =?us-ascii?Q?/fkGKu6/4ZesHxCylfbJ+KqfxP91VMhxyhyYt41G+bHs3Fi1mQNStGcoaOCu?=
 =?us-ascii?Q?fHz2d+O9oCzxAwhQN5/dNoUnBc4jay41Zmh6b6heWzivOBLGzaRsM2Ydycb8?=
 =?us-ascii?Q?KT85tIzSCLkLp+yh6UO1kxD12iUff0x6IN5Pn5RdBg9rGQfo8KmMZpuanInD?=
 =?us-ascii?Q?tOJbrissLMR2YKL7eWiuf1HdYFKm8XcRqp0RgggizsnrY2+0UTQAi/wJw+FI?=
 =?us-ascii?Q?Lv5hsm1Uw4zXVnCrRrOYdqSE/3O83WL0Wost+8yGEqWJd1/c0anxqDg1xCCS?=
 =?us-ascii?Q?1lgQtopClaQIHxqRbQtyk5Om8atTGhL0v5NdL85WZSs56KeVLyysqH84ArXx?=
 =?us-ascii?Q?KCOWO5r8Ualpzv80NK08ZCaAbsCSIWx03++XLelkBWoJwCHB0SMoQbvwYVS1?=
 =?us-ascii?Q?Ijot0CWvHzqs/ZZLNOHiPh/WtTto6HGc+VhI9rczC8mVm/5RnW6Uvb4+LzgU?=
 =?us-ascii?Q?oJzAvz0qRx/3atqVP2ntflpGmbMy4GRFXPhD52ajLpFCdHws5Lm53oWr7XNi?=
 =?us-ascii?Q?UE6QyF5hn0Wn/YbawdcKj21FGcHuC3kaDD0vdOWUWT2lDgwCxq7fwCF0dAI2?=
 =?us-ascii?Q?mzxplmj7/CrcSY7wuwOW42NeYuwetcJAWOy5oLdqOQw+PbdDfHSbEKYzKdU6?=
 =?us-ascii?Q?fcYBrjGjkjnZyoDsBo3UTPpMzegU+PkqmZC1nhLZECs2vVcxwtwgy81FdFgy?=
 =?us-ascii?Q?gYi1d27vKVl3O/4MzAO0/fbbtNfnI5lrAkZboKgOzQCKasZQoJ0Ndgaci4D/?=
 =?us-ascii?Q?vN5EykKOQ4Ex97RCeAo2uO3fjwt+z/o2MK1eosWh5FQFVwZyv0WrhjNo9i/p?=
 =?us-ascii?Q?++5FrRXjRNTZexsJIva07f7KCeBUsQQ5qDBr/7PRumvzrA20i5ZsmkK+Y5qw?=
 =?us-ascii?Q?tEnwFpaqyHqbXGdcp/nswsWedu+8qsv0dcXIyD23koD4OewqepH5W3GAcCXr?=
 =?us-ascii?Q?jsgUizievDi7qQeU4D42kjB4fYy4q+TD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5964ef4c-9496-47b0-3203-08da0c7881de
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 02:54:54.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIyl8VZtjRHhf/sVQUltnQbWxKQPmMEZkk3A58SqhqCpFtAuND9j6NUUviLM7p+hQRRDoMB/9f7WWyFYBunQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 05:00:27PM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series of two patches addresses a possible out-of-bounds array access
> in acpi_cppc_processor_probe() [1/2] and clean up some of it [2/2].
> 
> Please refer to the patch changelogs for details.
> 

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>
