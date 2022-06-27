Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA755D56F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbiF0VPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiF0VP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:15:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2092.outbound.protection.outlook.com [40.107.220.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B2167C7;
        Mon, 27 Jun 2022 14:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsV27MPMIQMpWj2RjTduTl0PKMdybG40hemOOhX1gnik3BTUnz6bSGHFP14vN4nSHe8JPArYap5l9SSJdFGZVN6Hv55Hebm/pSfcl7EsgJGMPrnFx1QIplW9vd65UDtsnjZm1VLF+BCKUJjP5ICjFWWTgtuOzmL+zZ6MFxiatgVteShhueTFNlNgkrmMQ3ZX3g5y/UEA+egMGPFIP5XennhYoHKznO1agGZR9CheaaLgFZVzWfuTektJZWydn3SxmDQpHzikYQu2DHuyie7+c1+M3HLmz7+ItwMmmXtc5fI5o/nM9P3wV0zEaJvkvdIEtDLyfVEJ4qC7cq1bzctzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6aId0008up4bS+7T/y4Rs6MgnHWl9sg3YGUC3zSfNY=;
 b=CN4syDQVdH1dsYKbvWQEpS/1vXBKBzOw9tIuom7q4qUGGhrVOgck5DLqKoXdSSn1Z9PY5+2tUo2xEWY4/z1YH/wgpkyGYQAycGIegzFFNqkh7ZLC6/9ZBx+9Q0iGs9vHiddR6H5ap33vKT+kQ381goa/mfhvNp/x5BoofS6Avv8DdWrNAvu06kO23yS8l4SQFFSU9npW28nl5c11LPtZHJe4F1ATnadFCNfjPEPNudhDLoLsSiEdbtSl4YB5r2U3h9MssPqZJoKbEIL0Eto3KIX1vky8CNx0l69XM3xEMIAUk4SF1WjP3zPOef2WkVPM+vDNmkwFT+gfOwWQByiEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6aId0008up4bS+7T/y4Rs6MgnHWl9sg3YGUC3zSfNY=;
 b=cnuUZPc6o7xCxmY8ZYpKhzJmxD7GrJ4YJrBx1tUix4ekpZfnxrUy9ajSpXqEw2hAWNWQ8PvygwH/EJjXENCe57MYk9hw5cNAxMM589JXRh0ze7NImkA8J0jMaTgHSOkyUai0UBPBg2wUHp2hjxBR0ysKb/NY+X3tlXL5+/uhm+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR01MB2638.prod.exchangelabs.com (2603:10b6:300:fe::18) by
 BYAPR01MB4584.prod.exchangelabs.com (2603:10b6:a03:97::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Mon, 27 Jun 2022 21:15:19 +0000
Received: from MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::e1e5:b43e:c774:40d2]) by MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::e1e5:b43e:c774:40d2%7]) with mapi id 15.20.5373.016; Mon, 27 Jun 2022
 21:15:19 +0000
Date:   Mon, 27 Jun 2022 14:15:17 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Doug Rady <dcrady@os.amperecomputing.com>
Subject: Re: [PATCH] ACPI/APEI: Better fix to avoid spamming the console with
 old error logs
Message-ID: <Yrod5bc5JCz03wH3@fedora>
References: <YqpX9npa/wR7mafR@agluck-desk3.sc.intel.com>
 <20220622170906.33759-1-tony.luck@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170906.33759-1-tony.luck@intel.com>
X-ClientProxiedBy: MW3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:303:2b::31) To MWHPR01MB2638.prod.exchangelabs.com
 (2603:10b6:300:fe::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b791bdde-27c6-4c2f-33ca-08da5882231b
X-MS-TrafficTypeDiagnostic: BYAPR01MB4584:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JrAuZhGoJ1Bb5hmbjBvDOhhhBE3Zluwln+LYR3WciY+IBz24ZkCTXTEC+Cwx8IUnXuY1XqH2D3rM5WaFBpiILM0SYbqr6RK60ea7/8VHpPTPi/WnK5WCje/Vzs3olIOUuuGoRU78qHMLqfQU6RammuHUtHFZ1SqcB/d/vd++eGIqSGXyL3jPQ0r6zuv+UyYTzQPNezfwGY3r0WiSYRQX/UVahlkGM2OFuOsXTZwTIyUEo205G38H5MROIr/inHq8hvzGjuwRrQ3TJ67A6hRuJEVYVUAk9PzpJz3eR7KLvdLGsZafIxs6DB7Ha3Weg2uV3XovZtDIgYa5uOZylFWfb990mifEkYjwOE7FeAEq/cyZ/mKSJUu3Ouaj/34N2CfXq2FK/kx3c3xvF/CQuB4bYt7uxvtuRnNmJaxR43CkakIzmd9s0hAa/FsGUoMqZVOmYp/yg9cQ35Cxs0CN9u0/kcCSD788EaFHg46knLlPOIKnY/vZ/Xoek1l2JdyPIWRJL2fZeDXc82zIXIACzZk3kJ/GIeP5NhAB2121MUYHUyBmudSZWho5RA1IRlqVK+dop1T5BQihU7T/TN+2HoDjWEs9ZEeAW0luAsisUXia2TTHtCifl6CDDxCxdZ/+JttSBo94+Oskk4q97ErjUardd3FxXh1d7U8c7pZPSR9J4dwfgSS+0uuwn8+AzwKJsXUeev5GVV/VYWsRdrXqcC0m6p0+ujSeUE0H9zO397XmIS76tDxeKQxbV2SxDZSzbMLAP0fFSiWyYB44qK8pYxPyCi270n5+VTo4CA7KqA5ETo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2638.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(366004)(376002)(39850400004)(136003)(346002)(6486002)(478600001)(4326008)(107886003)(6512007)(86362001)(66556008)(38350700002)(6916009)(41300700001)(26005)(54906003)(6506007)(9686003)(66946007)(2906002)(52116002)(33716001)(316002)(8676002)(5660300002)(4744005)(66476007)(8936002)(38100700002)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIXyUOADtlzERqp131muq9vb/s2Cx9OfCy7lxC2Fxri+szazetHQ7uHGfAsj?=
 =?us-ascii?Q?GZQjSytYX5gFQex9dVyckELf/t61M4bva6W2YwQX4GNdsvzkrm9tqaagQqoZ?=
 =?us-ascii?Q?q1jaktBKnWXhyYQ2OAAXAVmb8HBpaeQu1Hbo5pT60ptRKit6BPePS9WwdC3V?=
 =?us-ascii?Q?2BabmqdRqjwIXW29spm5fTBsuf+mAlsGkQVVRB+fj8RJLXt1MYx5e26mv5bK?=
 =?us-ascii?Q?TtAQVeYwPEjAWS41ijvXd1XPxeHWkZdTrX7lCywL4q8eAj0/+h4fl7/K9Znj?=
 =?us-ascii?Q?U0vHZAK5laHizTZbNp4zYivcnyuyWI3IlpXC4wLLHAkRY3cNFsxu5rv3+FUh?=
 =?us-ascii?Q?rwobXqpRJG4qnLsuFwfzwCWQsI3ckM8uTU+vTc35zrWiPhdY5USF6dPPgpRQ?=
 =?us-ascii?Q?sMo40p9Dt6y+ki6lPcQFPqTlyA4+ndyHgCppIu3tBs8eR1ze2I96ZVwy7r28?=
 =?us-ascii?Q?siQRJ0AvERbzJpFfW7vGm3CKxvkP5aX+7JJepqYGq1kBTc7f25ZC2+zppGMl?=
 =?us-ascii?Q?441kJE0djUfiL6uZtBUWgLo21X0leIF76v9rBd9XxNP/5jnzAJNKOZK/IQEK?=
 =?us-ascii?Q?SBS+witttUdG2mSBkaCMlTMXNDksONbBk9lo8aPXqlQrrGt8hvzzuMkYV5Xa?=
 =?us-ascii?Q?8gFaB3Iam5PC8qaT8IQG82CSZ5uKrGvfUJUVVq1tPElVPLYWORVlzDKfQEBx?=
 =?us-ascii?Q?VL+a8HxBKmG1a1LVPf2Jdf3WQm7dT+iplvVRxA/SBvwlYDRcIbAQJgJpHr7Z?=
 =?us-ascii?Q?Bn3lJ6a0OHHz2zCOB1yR+xaM9XlpC3dKR2a+z5NZFguOBcLpJmInjqznvQsB?=
 =?us-ascii?Q?tQ1F/+LWGsM5Eruewv7y5eIpxkR04ZmAZCDYlWDPRRnPvLsu0EwbzijMQxgU?=
 =?us-ascii?Q?o2x3SuU+9WTofd3V/kediDfy5XIqe54XIgOOOl3w7QEmjS6TIle3X9RgVKZD?=
 =?us-ascii?Q?dvr6YpKv4Cy88yjN/Iq4OeZ3lt9yt5whP+8GwmpOAZLP4Na6AjB5ElhNw19c?=
 =?us-ascii?Q?HEOmBg899yXimfGxvczvTB9Ra0pe1LoQeBlX7bPmvu8jK3hZAfOT36ZkSkqk?=
 =?us-ascii?Q?w98iug4ZVCo+elprWerTQva+J6pfGTozUqdqA+IJEtHrLRnakp1QXoj+ridt?=
 =?us-ascii?Q?QbUxZa0ELZTDHK1ZQ2bm5EKjRt7WAHvsg9GVW+69eqY4THivirsUQZUd5r/v?=
 =?us-ascii?Q?lHLa7Enk946DrnVoDJnMkvQtcFg+goKuWIfscuqjXHx4dSna9oGID6Z9USS6?=
 =?us-ascii?Q?jlL+NCQYBGb6cBdODVgmhHxtM/rLR5ohWvir4OgsJlJbaUJUPy7oYnW7ReFi?=
 =?us-ascii?Q?xdHGwIDkoVQA2/yCPaWNANVJsztZTBfz+wvIKaTOF4F9HJaoIPj+Iek0iJfV?=
 =?us-ascii?Q?ocSGwyLTrgjt4xmm3nYvTA6/ncGkq6P0Ipnn9nZxmmCnrU+MGOZIhmzZakrP?=
 =?us-ascii?Q?l92WWug5avGDUh//c12CyR4ubhEgszbDG3jYU2GhL4WkL+b11EP1LQp6bUt1?=
 =?us-ascii?Q?ybtwzBihfxjLjbqZtjUygK3+Zbw9nnmE25n7y1pIVm7ggSwNzeehsoh+AgdK?=
 =?us-ascii?Q?iDUHO0dGs6SCQi4u91RwVjHbULulALavXx8hgdqRazJ1ZJpHNVvVd+3ees+o?=
 =?us-ascii?Q?+8Mrz4fRzmZxpaDxU3eST2o=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b791bdde-27c6-4c2f-33ca-08da5882231b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2638.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 21:15:18.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy2wEQptShxLI8dQADu6Ik4uu9Rsa3dGVxMXNDp2Mi0uGZTQN63Ko+ftecUo87kSL17nvgbNvWwHQeFoo4obGYO0jboVIE7TADfW0B5u/aftMvhPAToNdE4G3ttX3GAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4584
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:09:06AM -0700, Tony Luck wrote:
> The fix in commit 3f8dec116210 ("ACPI/APEI: Limit printable size of BERT
> table data") does not work as intended on systems where the BIOS has a
> fixed size block of memory for the BERT table, relying on s/w to quit
> when it finds a record with estatus->block_status == 0. On these systems
> all errors are suppressed because the check:
> 
> 	if (region_len < ACPI_BERT_PRINT_MAX_LEN)
> 
> always fails.
> 
> New scheme skips individual CPER records that are too large, and also
> limits the total number of records that will be printed to 5.

Apologies for the delay.

This seems like a reasonable approach. Working to confirm new behavior on Ampere
Altra systems (specifically how region_len and estatus_len are related).

-- 
Darren Hart
Ampere Computing / OS and Kernel
