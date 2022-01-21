Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6438F496564
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiAUTC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:02:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51752 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231273AbiAUTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:02:54 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LGxIVp011145;
        Fri, 21 Jan 2022 19:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=IvxeR+GNxx1Tzg8qO5pXqg1YrRCLmNBiyEdjssGtDek=;
 b=w5ViONxHyeqbIaCDGqcG3UCA1EfwMUDKmyLksmo1X99AYpWtJmalS9Fk5xv/0By43jwO
 4dVjR/9CGdpWWjV/SI7/vi21OmCgoBpd6B8WTRhDYPtE9Iz6AB0eeIfv3QzeAplcRFcm
 6xBBJ6CEU0gPET0fs59R02oWIobveoDfY3AdD3epQnkwrtjh5NDLVxmM28liTGtb/0ru
 wEtLP0ryeKTtiQOQ+K1dccY9Je3mEx8LSKo/azl9UNJDymaibfsliqvYFAyNy7mzIEG2
 Fvr/HjxfW5nNqew1kxpGwBE69VuRTeeFs4PxeqKZT2ppToOnEfB72H8wFAuZ4lOWHs5N +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhykt967-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LJ0Dm6181197;
        Fri, 21 Jan 2022 19:02:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 3dqj0nen2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbCwjkWPhtvZb4CkcfbxtXl4ac8JxTJYEuKb0gP/vTAbq/f+d0BwLBzBp8/zKoNMCz+yqWQIY/sUE31HdgRpxedNY9ehUd3hfMLsHUOUUO2PIg6MYMhsgLl4c0XZURs6g7jK7LF76DbOiOi+ZFHVpPf9+LqGGiVwOS5iZ+i6n8zUpajH5jCIlDC5BRUdhktXosVxYjV6mZ/KJvU5IDXayXt4m0Mleenk6TNAdFqHtpR6ulNBGx4iUlk3lQbKhSpIn6CZ987OIyJMc3nbqQ12czFF9tT500JBKG7bzV3uLSi560E3657BwpMQUZIdMew3/k3UcgGjTLuMrJgf4/E+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvxeR+GNxx1Tzg8qO5pXqg1YrRCLmNBiyEdjssGtDek=;
 b=d/DvbO+BoSHy/rlfYpJDugt9xtYV6m05/yo4Ioc90kaNB299X52IGX+q8anHyPXcJQs4Qssg0FtiyPp7oUzA784p4orJwuHyLlpwlMY6p5J/k8S329tzHa/sYKsiDKxlZB2Geeo8LY4LiZt/DDtcEnoZnOq6dx33SCL6uO39VItqGGYq99AlnS28FWDVelmM9BFi1enrkJ2oW6Hx08WtMsilyAPStW7sYgbbWF80H4/9swSSP+OEgCFujVelWDyXNff5NMoexYCKGPm/N/q9UagoK1CVxJT5blm7UWA4GqiCwW8ch+rgbfMMsg2wvhHv4G59eFQ+9A+zCRMH+UQnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvxeR+GNxx1Tzg8qO5pXqg1YrRCLmNBiyEdjssGtDek=;
 b=I6isbjjJdJI5QMMA6dKXAQVJf79N1mtEQiUdvyi4uOTToAt53AZ69C9WKnJPBw3GBh2vg6IaOgjp4vcpPChGpjERU2Q3l+LdSufQEACrvF94m4HPttYVUMGNY+rA5jN32PW70pAw74Vze2srbiMcsuEc3soNs8SKKpiloPzWjJc=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB3434.namprd10.prod.outlook.com (2603:10b6:5:6a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 19:02:26 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 19:02:26 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] printk: reduce deadlocks during panic
Date:   Fri, 21 Jan 2022 11:02:18 -0800
Message-Id: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:805:de::41) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db6d2df-7cac-427f-c850-08d9dd109076
X-MS-TrafficTypeDiagnostic: DM6PR10MB3434:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB343413D1031DC66BDEA81E8FDB5B9@DM6PR10MB3434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IY7CduuXRLny2yXCdDOVh9Whtmjvm7CCaEtJCrnQE12n1qBgFo7lYKVHyH6eRlNJY8GlkXliD1XAqhZq2P8Rjfpm60giRJjJpWY/gtWQ0qG9Q/r7vffMkCxx4O8ntWTHe3gF5R+QvRmxpQor9GW85jTpjPDVn/5l5wGdRVMgN3RjwqcQPdJTKUKswG40Jj9XSZVT/A9g5oqCQawP94WmortMuUCbCD9YpDfOV93YBfrPoGtNceLQGyCo8S1GXLY6PnAUE/ce0d7OcrDrM32WApvXGEKoiVEaaluj4S5bi5AOyPQXBVee6DYd5ONlq+Kz6rXsDWfg9/c4T5N3ITXfry4aQZik7Bq1h9p71XXHIQHHYsPQjoDvbLuJhYgE9Aj0v1apqEin3ZnoTHsRLc+j7XB9WN8ipXWAno7a3Zs3zDRi9nXu4Wp9S04XeFbSNMn0nnsLDiSoNCq/nHk0DbmqZqtFLhmZ3LSg+R2V08NF9BYeah6kBXwwYjcfDMSqfjKjOxKxBtyHHm6a+WMBml97qLztnj+bqafO1KIbO96mAYlMnNb/LCBKc9P2QfeXYsTakkA7oTPb/hQ1GWRQykGaDbEsqcM1EfSBhgFmQMYg3xxx6H6C4KHlK9G8RZv4kAOmGK3rqioeo+xp6dgxJk9Gk24TmzZt1NDXx7/Vkuc0Br0Eke+rSywu8kT5zO0RL86EBBiNk98wHbdbcZYKGXcRJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(4326008)(316002)(8936002)(54906003)(5660300002)(103116003)(8676002)(38100700002)(6486002)(38350700002)(86362001)(110136005)(508600001)(6512007)(6506007)(36756003)(26005)(83380400001)(186003)(6666004)(2616005)(66556008)(52116002)(66476007)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJ9LSiWpa4Dj0BmcMrjbDXtbPU+vvyczMu4eMV5VHuEiDcnZ+7i/KutwkzCF?=
 =?us-ascii?Q?kHgQsouqZAByv8bqEqUNSPGPZh/ZbJpPSe93bBOpOa5KjK2S2DblDy8BG6k+?=
 =?us-ascii?Q?A9ogZ3UJbAvP+hCF5AFiAiPzsO1n/hwMVUMJAbDa85zdPXsp1QiIowNin5Cb?=
 =?us-ascii?Q?VqDMvDH1UL6EIB7eQJxJ9EdEQhr8x0sOUEYWatvlj3ZCMNHRWpyEvhP8VYqY?=
 =?us-ascii?Q?dDuugXsf0hGGoi3ZpV5zw/jkuVrxCFk9RdDHhFEXtjJr4r0TuExmwUTiX2OO?=
 =?us-ascii?Q?+vBIuyfxwZ1KFhjW0aLSi7/TOwhchqdklSwK/6hqkXVHFovMkYEGVmoeVjC+?=
 =?us-ascii?Q?D73Mi/cJh3nllK5w5v/dMFxP3Whh59IYQ2PkwHbv1IpLwdBNIT52xyVGPZ7D?=
 =?us-ascii?Q?KJZp2gHWjvW5DGSArsSjJL88xgmAX6R/+n5Xj0S9Wts0GM0K2zdmhjvvGdmc?=
 =?us-ascii?Q?ZRlfNFr3xubwfbHGIk7BdL+4JbCSOwW5uwmBrjQ5q1qomyAjC99uz48wARUb?=
 =?us-ascii?Q?bZe71fT4u6kVA1XOYG9/R11UPabB9Q3euq7UJjPGR9uj3fJB5ciFawlPQ+5W?=
 =?us-ascii?Q?uZFeqVi95YUvC3AnFg3Lr642OE99A1i+n+aHE2BDeseUMvccsLLm46xL23HK?=
 =?us-ascii?Q?33clzPWQdo+Ouk2J8Y9llEX+fVlLcO55hH2+1Dl+2+VrqVgS7RIQkJsq2Nle?=
 =?us-ascii?Q?1C5XMyy0ZiMdHhPthwUJ4rGsSeqpQbOMbp5gWOt/6J8c7nlzDemVYh2DxHuF?=
 =?us-ascii?Q?+yHWafgP3ZWcjCL/jDld2nt5b4/EslWTkOeoeP7ikaOllHa9Wm45DBjfzCXt?=
 =?us-ascii?Q?zxUsFxSW93+r/cAef79jhCgsM5jozLc/f+ZH27BSbK1pLkQBe+P9OwoQ7GUX?=
 =?us-ascii?Q?Ba1cxrxSfX7E51+eHGT0kiRhsyKaCLqO/ei4I3RYoH/Pkk0dgkNr383+0g2D?=
 =?us-ascii?Q?1dteo/m3uPVoOoe3FwNgD6ZEgL0E3QqJCKIwNgz82XZu7S8mFj66vpMLVpdp?=
 =?us-ascii?Q?c1AhAL+tAnfOfQLnb86YhQe7h5AeV19zsmtuAmN3Ryh7CpQG0jmFv/MLehCO?=
 =?us-ascii?Q?sX0LIRRnhMQ5ocY5bDejhf5YNuqo15QBlyjOKa44df6WuC8dRDNfl6K3jqEk?=
 =?us-ascii?Q?PlyiB8ibslaF3gHNMECTRtv3iuUjzQbDz6v1UiHcsbgYayt5pzuu0mQfH5kz?=
 =?us-ascii?Q?nGUTd4agD27tLat21qhutlpW6XMC7NOfwjkrZiZCGRx38lYoqV/bmwP/dCEZ?=
 =?us-ascii?Q?aPh2ZUl+yTQYHf/BTXWK//0ZN7iGFvq2oqukB+QQ//Zf++96oFl926hZInSn?=
 =?us-ascii?Q?p81z7pYnYujn3/+l2dHdo1cZ8pf8R73DjGNyCJ8DslWXM1IY4IjB5VgH2hGD?=
 =?us-ascii?Q?ewMRpnsrjybFFksiCoiSoulByLsEr1Hx0zQAsQMkg//COcG7OazYJzOW8WkL?=
 =?us-ascii?Q?XvekKNDI8xUUixnYC5Rtln7dHFaixDkcQi4b4jljHWhwfs3ejneAQe/rpGcR?=
 =?us-ascii?Q?+hJX5Cx1ADizThneOZtZ7k9wOWvfoFSt/bYJ9W+xecmy44oBNPsfuO2zgWoD?=
 =?us-ascii?Q?7u5JA3vhmbED+QENvvAJptvDhrHYdpnFeUb/lbN6kFPq3UaAjbHyzr+koYWa?=
 =?us-ascii?Q?OYPBBGXstb4IV7hzRe4ypBWRmzvwTzPl1+HTnGUCqkPIjSrPQKLhqd+bEr8C?=
 =?us-ascii?Q?QOcoAQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db6d2df-7cac-427f-c850-08d9dd109076
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 19:02:26.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3mSF+5L2NvlbkNVkPu6GfMbkjitIC6lhYdX6s92nGmkwYMljzEYLWtyfnIz5FhmXN2/3zB33999837+/zcVD97wxz2z8qikYCnJPCIr3Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=953 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210124
X-Proofpoint-ORIG-GUID: gJSEsHWXwKoEDmbX6vxku-r1W_jn5crN
X-Proofpoint-GUID: gJSEsHWXwKoEDmbX6vxku-r1W_jn5crN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a caller writes heavily to the kernel log (e.g. writing to
/dev/kmsg in a loop) while another panics, there's currently a high
likelihood of a deadlock (see patch 2 for the full description of this
deadlock).

The principle fix is to disable the optimistic spin once panic_cpu is
set, so the panic CPU doesn't spin waiting for a halted CPU to hand over
the console_sem.

However, this exposed us to a livelock situation, where the panic CPU
holds the console_sem, and another CPU could fill up the log buffer
faster than the consoles could drain it, preventing the panic from
progressing and halting the other CPUs. To avoid this, patch 3 adds a
mechanism to suppress printk (from non-panic-CPU) during panic, if we
reach a threshold of dropped messages.

A major goal with all of these patches is to try to decrease the
likelihood that another CPU is holding the console_sem when we halt it
in panic(). This reduces the odds of needing to break locks and
potentially encountering further deadlocks with the console drivers.

To test, I use the following script, kmsg_panic.sh:

    #!/bin/bash
    date
    # 991 chars (based on log buffer size):
    chars="$(printf 'a%.0s' {1..991})"
    while :; do
        echo $chars > /dev/kmsg
    done &
    echo c > /proc/sysrq-trigger &
    date
    exit

I defined a hang as any time the system did not reboot to a login prompt
on the serial console within 60 seconds. Here are the statistics on
hangs using this script, before and after the patch.

before:  776 hangs / 1484 trials - 52.3%
after :    0 hangs / 1238 trials -  0.0%


Stephen Brennan (4):
  panic: Add panic_in_progress helper
  printk: disable optimistic spin during panic
  printk: Avoid livelock with heavy printk during panic
  printk: Drop console_sem during panic

 include/linux/panic.h  |  3 +++
 kernel/printk/printk.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.30.2

