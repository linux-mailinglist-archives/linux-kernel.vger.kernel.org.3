Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689C94A6454
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiBAS6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:58:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17928 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235419AbiBAS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:58:39 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211IEMq7008414;
        Tue, 1 Feb 2022 18:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KpkPmh9Di6U1h6TZjHshni8UL8WARG6AvBWmQduTlpQ=;
 b=KV3685HsobW96U3oN+WYxuJzhJs++sn7n3vvyMSged5kLuHRSiktgGk9OosLkm2CO9IP
 gdIw8fytfx7MqorGIn+dpE8VRO1yKOcPABrACQz/l2H/Qe/0TI7Mm0WUmqAtKpGy3k3j
 GZl0ENaBQMmV8Mksqc4UVxThaZWqmqo8yAMVDwe9vnbYkAsOlai2TwqLvYMuFC7lSB0i
 CmifRr6ZARvsv+A1yNtSz5fDSqV3qyI7vPuG1MiU4aQpVIWKjFT6YMFfCYiz5HFfQ+yb
 VYNB7Yoyh1NWaygztzeH0GvqJYb/ZX7X/VPsQFWo7mL15BQCXpCynckGKXT8qmCFq9CJ hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vby7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211IpZHG012399;
        Tue, 1 Feb 2022 18:58:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by userp3020.oracle.com with ESMTP id 3dvy1qjm1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPNPJ/WlNY75P15Vflsriync9CSv0opGYO70FI35rEKiK+qTXRwR76oDPFX3NzFBP9q3X0XX8sLqz1bL/SfwOpuW9FdbtZWRgsUbGvif9CTlMJV9vFGxFvs/tlyhd5IC0fjpc4hVL7fpCJslZe3FlTOkro4fH0Id5x2or4f48LBhUiUVxk9yvTlJSWEKz7RKNCHXVQ5t0ZbvYC94z7rQgJ5dU/qdVOb0cJDSqiI5kL0m1k9v5MIwDBmrzpYgLAAMlwo4191xF8ueLdz1AC4lEXM81KeGashbRt5KwuIGAwjS8S5oLb/KRPjDC071rX1AED0yOWRX+VtNXx2iMAF0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpkPmh9Di6U1h6TZjHshni8UL8WARG6AvBWmQduTlpQ=;
 b=Anp4SEUAeMgWOnRivmV/KMpJOUvjaZjZ2K8N50UTjsaOYcGXVkG88vmF7hwZLvAsAh8wqVpnF9O7Y4eQYpGeNkMXti/ETBZeIMARkZC9jnT3P5WPVlF/39KPOHCfcXRvnjaxtjvaXxKOzg9QVP32st1KHuhk8olO/DmZ3rOThr6YZ730/twV3vGlQNdiC8KiiuuGpZk+T6Aek8rf7Mx/JKscOoxtYzzCqgckPOT2ZjklST5ffbl7539FqwQYXGkdMIDLNfJaBrTSa+nZWEZE2M6bT1moSDOha9Vsc8ZMKwEWCLv9dRJ1QTLWRQaXj0nfCh/2p8YJCwhbJBBCMVYBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpkPmh9Di6U1h6TZjHshni8UL8WARG6AvBWmQduTlpQ=;
 b=jrCjhFiSvJkTrTDA/PN6OVrt85DnNKqcr6ShnvRDDv5/4QOBC22KGt8gEah6RkS9SjDOzZJsypeJGuGUVvLxNl1UxvWY5t3tBHI6YQGKP+0Q26n5zPRUM+jomFORQ+LKOjIkFP6c2y9p34ZgIECmqO8cMzC3t4o0buuocUt5EWg=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 1 Feb
 2022 18:58:06 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Tue, 1 Feb 2022
 18:58:05 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 0/4] printk: reduce deadlocks during panic
Date:   Tue,  1 Feb 2022 10:57:58 -0800
Message-Id: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4431498e-09f0-4d9c-fabf-08d9e5b4c7a5
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5156B0C8020CB1551A38232FDB269@BLAPR10MB5156.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZ/jXNrVN6awKvflk8XvkeHs9/Onysn1q31CDuiPOPgklMBdW5CSvRqznea3kKf+VquLkbEGGh61fsKAn9OP7ASjtS+KUjj7AkEr/U1uChFvqgFFEctaL7dJJ7pRATuYfCvIwMetyA7V5fECVnnS5IpWcF4Ofp7V8oFMuNgDqFd1U3nOOv9Yevx9je2rgEmrTQXlrdqwZetMgd8Uv9FGACr5lDDJdlVzPqSLdaOjW0IZdCHzSVmHGrgi4zM9DCwdmqJtMVoIRWtFhNzXnqX2frGMKxZ1BGC9bxegEKGFt+KZYQV9aBGrxVkx/8Te0y5tAKHZ4iRS6OuR/+6l/hJPmxym3QVuqSJg/d4gPSfOlUxVpxNTKWzUtAVUJN1GoIhxXyrntsy+evmvcS1Z/px6wQD0DKSTqoq2pAf12Loc4ksLMtAqKaFV808o5HsxM169DHJEtSIx+kM47IYLs8iOhvMLYH8B/fHjmJpilATBuXocZo1qgcazD+rKg3FWa/w4xTBOyAAC00eakFExeZncR3v+jLj6x60y4KBdFoAe/wnNAil/sslSMBuPVB8lteWCjtqzpZwDOGzA0CujmTzdjJx1NsJEY7PA8hXoOJZ0GebrfAhH6fDve+JJJggN8ILlz0iPrgYBwMpIpCGGc984bkXGinJM+Gs+A86yZrULrgOozf+Evzybl9cRukrXTqXlgNVqqz6Ms8aGJNqLulJejw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(103116003)(6512007)(6506007)(6666004)(508600001)(66946007)(4326008)(66556008)(8676002)(8936002)(54906003)(110136005)(26005)(186003)(316002)(66476007)(6486002)(83380400001)(1076003)(38100700002)(38350700002)(2906002)(2616005)(86362001)(36756003)(5660300002)(52116002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hkDS4cpFgOXnwpkUUhcj86CtPk45uATB0fsIGP/PUQpqinJEWby3O7GBK+eo?=
 =?us-ascii?Q?eEzYNiGhl4RwkH4e7M2PoLGcyWEC4pnZOGnePk4ZzrF5+1bvIsK1//l63OSA?=
 =?us-ascii?Q?2ieKGbYQXA+uBHKHQK6xh2avuo5ntUKjJzA70zrp/eciATYFZXS+KS2DVl/R?=
 =?us-ascii?Q?axA5LlAh/P95PkfhxteLA7q4jANWz+3D4THuBrK9jgxrNdui2olKrVarEpo6?=
 =?us-ascii?Q?p9Ysf0lBqEncaXKWv5J/wrW9D8zICXGFnpzkzIm8CJ8oH8px+lBcpYiZUrwY?=
 =?us-ascii?Q?UP9BtFovF3LP4Q+Dla/uNVq9xZDipWIyWS6Ilc9nSHnmOj1j7YmE6Q6ey34y?=
 =?us-ascii?Q?X+fjf14SNqU3u6o3/LVhEpPUzkWPlA9sHOx8a6JkmT8dGnoRfbp4kijHNOFg?=
 =?us-ascii?Q?PkPww6SGWplFRiY2eAd0cRRuUp+WTjYiWDW48moPNYNkCunI5AS7JSWCa13V?=
 =?us-ascii?Q?hol/7ckl3oAHnVF78pkNOdf3vw+dNV1bJYFqDALCNpMHGgUQdqEsIKKmwFZl?=
 =?us-ascii?Q?oP32jiQAYSo6adBr+SRlJKEiKolSjtW+C/Vj/tJI27q6dLUQIhKqjUeRx9Tm?=
 =?us-ascii?Q?kLRw9Stebge2eztm2Ome+8mkMzFDPCBdBwR4GHIrrmhweBJL3iK7X5PRTTIl?=
 =?us-ascii?Q?cP17qcqVeora9AZDLjeRoOwtTSUDjRZLHtuN0GxUf52zB96G5apE27XMQxQx?=
 =?us-ascii?Q?8BeBBB3FnhZJ52iy3k9AuOgLXJY6BQWC3fKMcBKJryLCkrxe4ekesS7Xxiem?=
 =?us-ascii?Q?Yov1+kjbOmdWQIhojmnmrSxqve5L8ix9BKfh/kZ7ddlZQypA8oyTvXI/lxFx?=
 =?us-ascii?Q?Kl7v/UkLXAltr5g3Yj8+JJg1fqirkn6c1FAvl1UvFXHCdtqQSNi2yOrVY4F1?=
 =?us-ascii?Q?rcCjN2GT+oCvpDuSNtwQxSpe4l4c8UgVghvqp7XBqKOyIXQVwJ3I97qEk1Wo?=
 =?us-ascii?Q?Z4Lsbk3Va/mAkYYw5dAd096qck5WRsxpCFjUZDFyamJj0SkhWlFQKG572OfE?=
 =?us-ascii?Q?hibGExL7KPLouGxE8tpv0ra6rXk+v7Q3GtpZBrzXw+hZiUqN5nBNQ+1Hs4xD?=
 =?us-ascii?Q?XPj6jh0fRc5/r8ptNjClt7hqZxV7mkYNdXkvuXGjeO80Bfpe2LxU+RMFnYcl?=
 =?us-ascii?Q?rqKE42RQRf40i5rEspOqZD8UdIYiV1fvPcm8KnrwLQm2LdU2RYIyjfNBrM5O?=
 =?us-ascii?Q?dOTv2tHeIWdrA4aUixr35aU0fglqqFL/7zAzQO751NwSoe9wuRKzJ/Pii4es?=
 =?us-ascii?Q?/2WmYvh2p79i/bi+Bm+wge9acllAmM8FT+LcvplkcxbPFMJ+DuRxPEYLcuXT?=
 =?us-ascii?Q?uy6YfEu4abuXO8GByjRJxVaqTtzUPEeLwiIy28OvWtz0R2/gBi9QmhYIPHby?=
 =?us-ascii?Q?GEFNY85HDDkLCT/9xJCYn67Vl/nK7yCtX5mnGBi6C/QTf9FQuXFdw2AWm9Ek?=
 =?us-ascii?Q?atcpe2ZEV+VYn5J4X5okkuVCYAcgbwRCErbyXB4O0Ql0EoNH/qlu4NbzF9zU?=
 =?us-ascii?Q?keMpBJXWvme3KsubmVZjIiHCjJUcZahOHRVMJ7Ktl8AFYNvWetDcBUg8OZkQ?=
 =?us-ascii?Q?f5/4EKEuz81k04N+ROezBN/sYa7PELJyXqnD7eA+gKOtBGFSbYUrsNl8udQj?=
 =?us-ascii?Q?G3PwxPxfVxxSEEQLn2L4F+wTk8h7KhmyDomM4hs8p8iBa3FvrFs2o8X2j+f9?=
 =?us-ascii?Q?lbt2VA00/ZZCwsBR3ejRrBGBQ/Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4431498e-09f0-4d9c-fabf-08d9e5b4c7a5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 18:58:05.8240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZH4dGHGgJ8sBvQJ+T+s/Z3Zy9JcgmVSWYrcYoPb5K+Fk54/jfOUXOwl4AalwRdA8+UM2EtPWvWtX1rSEe3yWHgawlnibsCDhH+mQ820a1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010106
X-Proofpoint-ORIG-GUID: zQA7NN0G9szhfBokyyRr6md30gGKQktN
X-Proofpoint-GUID: zQA7NN0G9szhfBokyyRr6md30gGKQktN
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
after :    0 hangs /  15k trials -  0.0%

v3:
    Some mild style changes, none of which affect testing (which has run
    continuously and is now over 15 thousand trials without a hang!)
v2:
    Each patch has minor updates from code reviews. I've re-done testing and
    updated the above statistics. Exact changes are in each patch.

Stephen Brennan (4):
  printk: Add panic_in_progress helper
  printk: disable optimistic spin during panic
  printk: Avoid livelock with heavy printk during panic
  printk: Drop console_sem during panic

 kernel/printk/printk.c | 55 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

-- 
2.30.2

