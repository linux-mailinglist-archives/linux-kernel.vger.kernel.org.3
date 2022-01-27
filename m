Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0338C49E602
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiA0P1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:27:20 -0500
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:62451
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230332AbiA0P1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:27:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMDKQ/ZDtcw4vaRxaw9KEZVUQgGlBJg0u1w3ia6hiLr0CWxKUDGMFa0eG9/3esVSF9b0m60ZGh2JZYctnbAnkTaoGV+9RZflir9gg1jwVpqD1rxsjZ5i6GX1myxHaHPGICxUPKagcuA8TwLwHrNZJYEskZLC2RTURaajQyPWb47GDAL4MrAN9BzQ1/dbUKi1FO8anPEcFZ04vjkLmzunEbLgtsL9lSTonnXlAzo0Z64XM5EeOopKtL4v8zEoVI5Jo3Rir+bhmoFRs74TEXTwfKR168PpPNhTKY8fmMMr3g9q9+1Hjiv84sEDMwDtWLglu9x9QMrSOLoIVn95SdHapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIU7Z9+8BLfArGJvfXe4oV75yJ46wJLaKONT8i5ycfs=;
 b=D9tVthh49QqQiJfqOjLb+XFZM+WGG6eXioIagMJKu906MB/YB5ay4KTaxGmfXg95fab1GKGKDzKHnv5xDoU/MmEpTod1viDxM3CduYFuXKf805yfKEffXoZU7Q9V87oErypbf7m8Ef/Cc9LLogizehkmf3W6hntgknHr6PeqD6ZqasMInXzN8vhHYMVP2c3ac2SVbpNKhlcZbxCRynwechk4WEX8hYkTdmkYqHmPCoTunJhgDI2ZGjfYAcQWAXtRix6NlAJcWicpvz2LUtobfjpIywJrQ6Zs0xCIgSQORDe9uibp4bqkDW0z4r2tCVaIv26kqz86Eu5yZMr8gmCwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIU7Z9+8BLfArGJvfXe4oV75yJ46wJLaKONT8i5ycfs=;
 b=UKOeciIUjAbp+qDKhPfbTUV6VvAkUsBVAhC/9cv4MYUJ2GAt/svlGcWshT/AwJFFfMiaIwPbQCX2NMKPcZDGsdLEGtXllaadRrrCkG/c9dqPHWQHEEUT7b94iYoygwA1xkCdQE/5gf+XWkxRSh4mCboZtYHDZxmSB390YHEI6nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 15:27:18 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c%4]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 15:27:17 +0000
Date:   Thu, 27 Jan 2022 20:56:58 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        song.bao.hua@hisilicon.com, guodong.xu@linaro.org
Subject: Re: [PATCH v2 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
Message-ID: <YfK5wjuvy+Y5SZDb@BLR-5CG11610CF.amd.com>
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-2-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126080947.4529-2-yangyicong@hisilicon.com>
X-ClientProxiedBy: BMXPR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::25) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65cb76cc-6218-4ca5-fa9f-08d9e1a980aa
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB43832B924AD83BC952317E2A96219@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RktfHyExewIYPSRwdX7JbjVCWWu17fENUt1hFPHIM+ImWbE45WZNfjlFJqklmHZ93YUjHMK2k7XHT0uh3PQ3GeuETOfNS9kzpevuYMM6HsYbxxP4RX1V07mOoqHXy6da4ho1p0t2UWv0WpcunTcIaM0oEOt7jB2iSSm9KrCUsbjD3/gN6tR4bRlO3ARgLsHyHJhUCJ9CSJ31U5oU9wSnT6G/M3pPzZ2Qn/q6ZwGpPG3d75VGVQYkGiWQdnTT+jYFfPBJ83irbWMLJqkNnuGfRksGaOxLQcNHdKEmg8UWnzR7ICnD2wWJRHztV7jTSJ/iWaYXInc0MHHZE1HC8nxa5furai8V/4sOI0iNAJgXWKnK63yFwgkM5d0Ccrvn+8cQS2LusLnz2cTLfkID9z7Uf2nObaBTf6mmtBATlts7VB6+KsPbVgNoOj+R1LQltS98AsXvW2trJpuUXtpu/DKtcdWKNEeTTx6KsgTkwDm91V3Svw8wOUUm66Dbk12GfnjyXwa/q2diZ220mICa9HR10KPE/JRnpWNyckXPIZyOJJX779/egUDUh0URupeCJZ3DEJoyUUeoS307awg8bUiGqr806IKU1FNxrS5qupom7lDqOcosPUofocrH8396d15Z7EJGk9X0OvJgdsKEl8QmTO+QasUQ1qwmoswTmCbgfvcbPcP7ZgoNPQzbZj3iWtGohkRI6qR3tOP8UIs6GFd5Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6666004)(26005)(86362001)(38100700002)(6506007)(6512007)(508600001)(2906002)(6486002)(7416002)(5660300002)(6916009)(66476007)(66556008)(8936002)(8676002)(4326008)(66946007)(4744005)(316002)(67856001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7rtPp1k/YFUmfXBnSHzP+LWR+HqeoVb4g3pfoDT15eXst0NKZkF7hkudNC47?=
 =?us-ascii?Q?lTT3K/fJGnV7JzQfrTzV1Td5qZe8yDNww1b3FNq+vwj904FvLWH6ULVUpQQY?=
 =?us-ascii?Q?0Q0IZs3udqzfBiofQOfBiSwwqIsFg+1jdK5fFouD4y1vp1aQ2EgrlMzhIJbd?=
 =?us-ascii?Q?o76H3ORBds5kQv9CCHPMG7N4s3FUXcPJpyS/USHl0c8Kq6py3gmb6AP/QgCv?=
 =?us-ascii?Q?BAcU0mYuhMIU68uMcOk9OwSuYi0CceEAWF1LatCLm2z0aBZp2DagmcSAykyT?=
 =?us-ascii?Q?P50TODyvebbto1iJzfyCyO5hTrwuoB78dCwqNlO4B+xWD6nFsU9jITHfnxbR?=
 =?us-ascii?Q?FG9FkVwwJ4NZoL3NeqNIeaJN2299YS8euEaUVpNi+eGbTkDWLGpFLN/M9DYR?=
 =?us-ascii?Q?QeRnl3U8XGuG/BJTNsC6LCx2J7KpQwrVnKc5KXMduA261oI0d49yaCtn2pDG?=
 =?us-ascii?Q?MFI8VWL4he+lecI+e5bY+dj64upNTWVPwXYl+tWzsXS2VIErrcxyxdIehdcw?=
 =?us-ascii?Q?0LlNOwh4HKOjHENzyTIpEY6D2tPWnB4J5tQYiFVn/OT1M6Ux1SJWuBM4bMFK?=
 =?us-ascii?Q?rOlbvJJnJdijPW7KKgcj5zGQuDah1mgeTL3xA83HLnkJ9FnOh/AO4dNB3P0Z?=
 =?us-ascii?Q?JxoII7rj+hy+R458xzeGnbUHYcbP3JtEcgQJk++fAvKYce3RZlImxoWYDCMR?=
 =?us-ascii?Q?H2qnvXXAXb0azSXmWiyCekgEFHgATJkykysaHeM/sYJhavoAm+Xnmo6clGM5?=
 =?us-ascii?Q?83KSwehTfSrRQ6XH5jaEXuZOw6bVBEHFLl5uZ1yeFPGvPKCsZbB/de/nceBh?=
 =?us-ascii?Q?0HF2tI40OpLDJ2qYZrVbKe8sKRG9u2A7RBXxW45NMcy0HE1ow4aCjDc9Jnvl?=
 =?us-ascii?Q?9Z+OJMUYr2uocuoeEYjNUfFbS6gvtybXurhp2N4qJ7w77l8ctDfNNzHq+Iwk?=
 =?us-ascii?Q?3wwxUl71qhbMC1XIr8e6tbFVwAS2AxyLUWHlNAYKOqAnE/NFmg0fDO/cJ2xd?=
 =?us-ascii?Q?NPVqjRvdaEf2XJnWPe6CuwQQIEteBV4m+K9qiBHYo2Mzg2JyLJDGjViOhZaa?=
 =?us-ascii?Q?kUnPsT4EfcoG1oGkUSLWThRSKlUytmcD25IMz8rcKOPpaQBfa3D5pl1tyZAd?=
 =?us-ascii?Q?c1440OB7x323lNRfRv6UE3hGSb44y5eIaqChdIJY7Oy9FwmhF7VhfrRylsoC?=
 =?us-ascii?Q?bBJx6aSEsm2exuyoGfiRJ9rPm+dvvW7+Ql7OuXbZUv1gsI4hKoyhjgGvYiv8?=
 =?us-ascii?Q?m9iUGoDKhnvzejnweR5U20bc/fhANlREQ59+cy+OHQI3FLHac0mHSzkE7eL9?=
 =?us-ascii?Q?eaDSJ7RMHvQvh/4MeugQWFFBlAkoJ8sG1TjVf1d/EuOvN+Ct5T1ATMTdV59z?=
 =?us-ascii?Q?qWbIgZvrC+6vrXi2JMCMUXdery0LEbHnqqeuw6dRSoIheZVNDt2GO27xPinE?=
 =?us-ascii?Q?ceJxgw8O7DaR3s3HP5cYiL9zPlGinSolAViFwPVp7X1PHUVta9FYiJuJf9oF?=
 =?us-ascii?Q?7ghsH/nLn0d469I2zzq2cE6sMBL9y/iI98OHcJvPyQOQkIKHFCt6Ry50FTBM?=
 =?us-ascii?Q?kDfCUhFWNReeButoNtXgBocWS0LrRPFR9f2mqSGIvKy4D0ro65rSg0pDbXlq?=
 =?us-ascii?Q?ZrgUXwghL5WAVVguLKSudes=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cb76cc-6218-4ca5-fa9f-08d9e1a980aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 15:27:17.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knbs27yb6sNAysV0Jnj+BGiH9c1TWsXbEJ5+n1dxEAdr3v32gjazvJoh4ZbAu+cT6p6ocoC7RACUaxE7E1LYMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yicong, Barry,
On Wed, Jan 26, 2022 at 04:09:46PM +0800, Yicong Yang wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> Add per-cpu cluster domain info and cpus_share_resources() API.
> This is the preparation for the optimization of select_idle_cpu()
> on platforms with cluster scheduler level.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

This patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.
