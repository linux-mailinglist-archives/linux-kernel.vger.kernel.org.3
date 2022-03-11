Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A352E4D6868
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350878AbiCKS0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiCKS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:26:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2129.outbound.protection.outlook.com [40.107.244.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D5C6812
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kqgk836P6fv/fOWW+WtCUsQ/nSEzP1eVMi7P82ki7ITVFPU4g4Srk+hrjJObIqyYp5nTR+bGljOHNUYAzttlS/ElL59RFNWuSQW2I5IBoLUskAe872ND9zB69v7SDtvvm5xwwQv2vO6FiLig/w5xzaCa1hPJr5pFUF5EhedF+zVLj27ULTpRSQZEcUBwa0ftI8I1mMkG+xpecpO+ZS0bd4kCdKDQpGz1bd8ow1J+RNXiKFzri5zRuD7XqPJnSQKBpDTn3xsC5KWR8/g/if4hNugsxvSKYx+RtZyxbgNjUP3J3O2OuLY+3YqaXlya/FPIow8BI5LXcgSkRaUjyJ8X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aix509hV6wfGJaN15StGHBqy/qvzbQd+EA2YV+o6+Lo=;
 b=caxQnj5noqUKDQkEY3nxuZvtiom5RTOzoMPIo6l2nYc3RYqt5ZlhpxHvxLWjZgD3zmkR2QoK6bZbaePynkaQPdIIGgq4FKqlz+Gt8TKxAp+xFoImd7uo3W7hcDxXHAxZrH0jmv3rYd/Rp+3Za1e/srdfFDfmE2Q7e+haWw+bAQIHUS3CZ5xGeBu9E4bgBNrYBxGbey4hkbhDZNFOn1kejgX9Nj9/fDH+yFl8eMR6MDqGJ/SSLQgqom2rSnhFc8mgQ0nAyFmPqwRO3Bz4Fr4pV+MdIaAZWdz2OT+lg5it8hHQ7I3mrVECsxs9wZSA2w2c5Tl3Uccx92gwzpgQ+MLPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aix509hV6wfGJaN15StGHBqy/qvzbQd+EA2YV+o6+Lo=;
 b=Csco9Ly4zi+3zbDKFE6AtxG1q7PbNfz93G8aV6m/UW2AH0Gudt4kXgToVrJtpN0z7YD2r0RZv8llWV7Le4Psr5fU4QTNXOuEFwS6GhSsD5PHNsAbUTinCq7kB/xGjpqSzDGNY70o5h7/kNTy0Gtt7JnjNc/TxPc7j8ri/sWDhMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6326.prod.exchangelabs.com (2603:10b6:510:a::8) by
 BN6PR0101MB3043.prod.exchangelabs.com (2603:10b6:405:30::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.18; Fri, 11 Mar 2022 18:25:33 +0000
Received: from PH0PR01MB6326.prod.exchangelabs.com
 ([fe80::adf1:ae3c:fafa:7abb]) by PH0PR01MB6326.prod.exchangelabs.com
 ([fe80::adf1:ae3c:fafa:7abb%4]) with mapi id 15.20.5061.025; Fri, 11 Mar 2022
 18:25:33 +0000
Date:   Fri, 11 Mar 2022 10:25:30 -0800
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] sched: topology: make cache topology separate from
 cpu topology
Message-ID: <YiuUGi0cFyLHZhAI@fedora>
References: <1646969135-26647-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646969135-26647-1-git-send-email-wangqing@vivo.com>
X-ClientProxiedBy: CY4PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:903:103::15) To PH0PR01MB6326.prod.exchangelabs.com
 (2603:10b6:510:a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaec79e5-289b-498b-3140-08da038c870f
X-MS-TrafficTypeDiagnostic: BN6PR0101MB3043:EE_
X-Microsoft-Antispam-PRVS: <BN6PR0101MB3043A38273C791AE2B02E322F70C9@BN6PR0101MB3043.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VcgO0k1wr2+qN7FA5IpzzOYz9N2OAAoLW6o/PBxgWYgTIFnUTdLv49EaVrDO7FPT25QkQy+VrQOKIPl/qlKwB0FFRD/D3uonlmoAMDzXWSkedNYr5+xYGyF5Ixur8svmi8RaZCXCGv+xHXoOUck5n1p81BfAGwJN99IaWk9OLO0EEGGoiIA0aRptiXFEwlCfNwt4ajjnBOiiQWPk90y1sLCQ4wpN8GNTx3hR6bH65Ra59YklAVCeIjID414cCkUhMhbcMgVjEekLPOJ7rwVZtxHqcB3avlIqwyyiyon0L/IOMZ8snjlzn1Wb2sS4eLOi+Fde/eYrF265pmmldCUohggZofgYuNm9nl0wMe2ED6E1RtQfia9CZDZXhsOOS3Fhe3bSIF0u2RVzeSjsU5HAf5YeIvTem4rkncj6v481xGD8UQ2IX14zQl6Etxdusq29JMkXoBy+m6Harv/Wxgc5qpiEf+kVbw6dpPgwq+SVB4uVFWytAy0enuSRhmd/teEOltyFkWdTn8lDz3k//ntBCria3cd65nzxxXc/94o03IMOE5TOS8qFcOPPiHzN2AvlWJlFkJStDks41yYCsHIh+WJb7m6LSZARhrd8l7segeQQJyzfDBdhYV/VidtMIwYdxS+0ygxFgtezoR//zMhJD4pKNbMuwzBZfJFf8H0Ovof9g1Sx1jxVkpdKBaCInsL9poeTQgSZIl0QxH7B461sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6326.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66946007)(66556008)(8936002)(33716001)(8676002)(7416002)(66476007)(4326008)(6916009)(6486002)(316002)(2906002)(508600001)(9686003)(54906003)(186003)(5660300002)(38100700002)(6506007)(6512007)(38350700002)(26005)(86362001)(52116002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1v7lrfl0klKrII5bqymyB47Rz+pOoFHwwUDiFhjoxhc5qSZctt7llQJqrm2S?=
 =?us-ascii?Q?oLwFy8yLP+KUaznqsKk/YjNecwh4FhoqxXjPcsDGpaQpXqXgRvrrrIkuVAed?=
 =?us-ascii?Q?F8Pugy3tL3EtZxnTZDiIGmO1OXVbQT3wBYI5O77UHJNXI3JhLJ0Cy3BhI9OT?=
 =?us-ascii?Q?mn/hH6q+jYjbL5OOujkNzn/XeXyGp7gr3w+n9iDQI84+hp0P8hHasl5qxbkR?=
 =?us-ascii?Q?H1WgfWGkHMZOo58fyYVOqdMj3q0eq56N4Xehn8oVMrKwGRZJeXbn6NB7s8Lh?=
 =?us-ascii?Q?5TrGGKELEISqBPW6r+IFY1M0lIowbB5Df84ylQ6z41s0E4qbFMD2gKHykUDN?=
 =?us-ascii?Q?aIVKYO4jg0Ml6IWh1dPLk2YNICCWouutGe5iDSR98ZCkcSN0iPZOGPOWn5F4?=
 =?us-ascii?Q?R17e124CpdPzrddHcgvbtsOyhGP0jq0fBLm8+/mCiSV+BYj98QkpI7PSORHU?=
 =?us-ascii?Q?L52bmQtXLxiunKQ59QCAKsz58qxwOpLBO8Beo2gcjPJpLvNnfIc3E0WCBTbJ?=
 =?us-ascii?Q?VTdr/v2pLtEZzON/BDB5JHA2j234hw0Gxt315rEFQFDoXAKh1zyok1hBLLqv?=
 =?us-ascii?Q?dFLuADYUfyyZZLWm9dpOAygV4pjgjioTWsSHh64EHJ9NB1MjaLyR1nDIgaDB?=
 =?us-ascii?Q?T2HhmZ+WRivkB0hVMxEwJjC7mHJuP7j7qdSCrSKspDMATUKhmab1sd5zeQVe?=
 =?us-ascii?Q?ULbrfEhRp/rCfWsIIVENhdxkOinvzHdGse7RgdQcb7ocvS+4BJ4CgNXCVi+/?=
 =?us-ascii?Q?9tu8rWjBBpIc1fkK1VNxzCB1EV8Tt0DJLj3FbAwhQxlU0znmSc36N5EkmlA2?=
 =?us-ascii?Q?9ZsquLo+JJccgsoMGNM6n8ECm+TSjzIInLiJfdQUT8UmxZVORhQnSPwZ5ZZQ?=
 =?us-ascii?Q?zvW5RErkB1f6QfU/nRfEYidXq9544M6miyOsO+Oc48lEjTD3c1GTooj8FyWL?=
 =?us-ascii?Q?Dmm2UI0n3dScI048Uu40kkMaDRr9TqiLaGR8LwDQV7K3lnZJFKNOkgb3EZbx?=
 =?us-ascii?Q?r8NHfcJZDKL4Op0R0uwdrOBb8R5KA5I+Fx7dsimuWRCwiQZSZ3unUi3r7kbe?=
 =?us-ascii?Q?1cPGPzaORSg8PzA3Ja3RWowvTtIJzQRkwgPlAT7HOmfAiFPyJwZe0CtPdb1w?=
 =?us-ascii?Q?kubAb7keHtUhu8u4QtY7mutDeaZXmwCUs2cwbbobnOrYx+Cbgr0DV0AcZie7?=
 =?us-ascii?Q?ey66H2BuOYK8MavANNkJjC965hyHdUpW78By+uwlQoenY45eqlF09iR+QSxp?=
 =?us-ascii?Q?2fJIIoR2ruA1BPD954YXg6E7QdZY3077382zKVFdoh14FUnBpoOaMrf4xb7i?=
 =?us-ascii?Q?+m1iha+IbiB9hVny0v+SGsociQofIC0kKw01V7e78+3H/b2s8f46ppjzURUa?=
 =?us-ascii?Q?EHcXnFJXIyIkR6ZTuVW76PSABEqcIZj4hWFHwLNuGuRTIM4FzVVMtEp75e8p?=
 =?us-ascii?Q?HoQDEbVJYG411mFwtlqA7aHMeF/qbnt9Tw+tC3EkiIPf7JI3NDx7bSCKJztv?=
 =?us-ascii?Q?xWaTgzEZ/0yo8FLnJW8qas1ZNX3opduUrJkNrBR84nPXfqeo2t1bnO8ggqdd?=
 =?us-ascii?Q?HM4v2cWjJ+o2ivVIEiTWBLx4W1l0hR7qvfs+8K3PdbD9xv6JAPhST0cOKw7r?=
 =?us-ascii?Q?xtyr4M8rG/p1jn9TkZzA5kuexi18/P2724En7qUT+1O40imj6cjSBWbdAx1O?=
 =?us-ascii?Q?2vHYumWelKFkmoRx9UPoW7b6D5eV0yg+LdjIKfnMNf66RneurmgeLVeREE0V?=
 =?us-ascii?Q?koQbThs0Qg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaec79e5-289b-498b-3140-08da038c870f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6326.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 18:25:33.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20KGy+m8uqmYcickgPuvtqVWpx3tDcbPXsMkh2QBtzAWtBpGFkM7J7WyGrSnnqp6ciNnBQgp6/RD/J+A3fT2bExQWWg8z7v+/keLKLz6ECK0vlrE3gJA1kPHz5XEFIYX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR0101MB3043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 07:25:33PM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> Some architectures(e.g. ARM64), caches are implemented like below:
> SD(Level 1):          ************ DIE ************
> SD(Level 0):          **** MC ****    **** MC *****
> cluster:              **cluster 0**   **cluster 1**
> cores:                0   1   2   3   4   5   6   7
> cache(Level 1):       C   C   C   C   C   C   C   C
> cache(Level 2):       **C**   **C**   **C**   **C**
> cache(Level 3):       *******shared Level 3********
> sd_llc_id(current):   0   0   0   0   4   4   4   4
> sd_llc_id(should be): 0   0   2   2   4   4   6   6

Should cluster 0 and 1 span the same cpu mask as the MCs? Based on how
you describe the cache above, it seems like what you are looking for
would be:

(SD DIE level removed in favor of the same span MC)
SD(Level 1):          ************ MC  ************
SD(Level 0):          *CLS0*  *CLS1*  *CLS2*  *CLS3* (CONFIG_SCHED_CLUSTER)
cores:                0   1   2   3   4   5   6   7
cache(Level 1):       C   C   C   C   C   C   C   C
cache(Level 2):       **C**   **C**   **C**   **C**
cache(Level 3):       *******shared Level 3********

Provided cpu_coregroup_mask and cpu_clustergroup_mask return the
corresponding cpumasks, this should work with the default sched domain
topology.

It looks to me like the lack of nested cluster support in
parse_cluster() in drivers/base/arch_topology.c is what needs to be
updated to accomplish the above. With cpu_topology[cpu].cluster_sibling and
core_sibling updated to reflect the topology you describe, the rest of
the sched domains construction would work with the default sched domain
topology.

I'm not very familiar with DT, especially the cpu-map. Does your DT
reflect the topology you want to build?


-- 
Darren Hart
Ampere Computing / OS and Kernel
