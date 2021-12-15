Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79E9474F30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhLOA04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:26:56 -0500
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:53856
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238468AbhLOA0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:26:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+miuOE6O8XkZtDalQnGmEyHo5UBw8DsJna+GOoqS+ANuAceYsYzWbn8N0A8t7N9KVyE0r6Ix6GW4DW+30HHeyHRGoMvqLBzUrihuUWdJveDRi/fQXrU1ibnPW8E9Ap3PdyspWotWF6FrDT8acuHrGz+/nFT/2if5+wTMjDTwKfFqWiONC12UTTAXKrulX3xqnzpT6ZXS8alXBUaFbZGJ7HRremZllwL/mwiBvUcd+E/hvEx1wnHkwEIkXaaeSE0FSkU+M5JrRGncU+0q/YdR+c/4Sgz4dOoXLSNejgyIsuHIZM0oioWHDm0ad73doQIkfYqylMEkThNeSP3FXhxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECsn0hI83MLVptSmLiZITh4pnoRRuX55vtbnlVPx3Vg=;
 b=JraSzDBaCETp5USaV+3Wi6qWepTqALKWuc069oK261VnUNtHCjZ59oF3dBs7PABsmPRCyRJAYLk0KreE0xv0dVa8NYbY7gpJFWeoxkHa4pvEe0MppAyUceHi8ywl9UuvSkKN7PPELJzvP1xz3FlmvWUO4GwDrcBdFk6QHPC7/rEUSoATERVDxNNET+4jME39UAGeHeUVBXTM5KGr4a0eu+e1OsQI7TKDPczq1iOpRHCIMhjJccvmZx7bADa7pzcRyIG1tEi8BC9Z/3WkrRkboo0GZbz2Z5bT7bB+Aa87DEazd92wINY6oe9HhKbrGPLZIomHQAJUsAsmIJb9a7mZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECsn0hI83MLVptSmLiZITh4pnoRRuX55vtbnlVPx3Vg=;
 b=df2zM7mIoqUfXcwWGaxbC04SQqu6B6QXC3IF6NzvzHAb7qQBMRYTAkgPalCSL2lIJDpOZ7YOf+W031n+RhNEi4jdu1UqPnRK7h678BwQsGajtPD1qokl8Bc5XUZh29Dnn3mPmFLthp7awgzcEfmmeh/Up5wKyiMsD5nMSeIH9znp2Cekmi2JNENjxExphHDHHxzBpcf8r7MQdfVBBASmK0RARbFhsvtQxEud7UKw9cT7PC0fybsA0/T0qi+m+vBaUTbkgdDhZ7zr6Dw34Rkg34vDYA2wisifN1niYeH4qnoyIrptBmtWwMobNcFB7fXG0sKoVuacb3SQIvWHLUlgXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 00:26:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%8]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 00:26:45 +0000
Date:   Tue, 14 Dec 2021 20:26:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Enable strict compile-time memcpy() fortify checks
Message-ID: <20211215002643.GA1034246@nvidia.com>
References: <20211213223331.135412-1-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5fcf607-2f0c-4bb8-9fd3-08d9bf619364
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125467EFAC555448FAF439BC2769@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBM7dHMZyj1sU0SSwZQo1SSIBAePZrlOEsxYHEKGqY6nX7/ltEqZQcvLhqr2ccIM54V3nwRrpty58ZyzJ93A/H5DpUraz6rNcQAPulL79HLtzBmE22m+N8z8wiihBa/9b8aYPxVz6B/FZgHOtDxd50f6vKHagSXc+VeMBIhTO3EuNzgf12Y9Q5YSrr1Z9LJHY/XV5SQIgHaX9vEhq18FPwaswNgqOQLthkWK0HUsqEd6+q0tbO+N6oKjOgiUUNpf6CinvaZwsvHaKXVgDlggQdTLUFqV1Lgd7mTmx/Lql6ONAfD37mmtpUHmGXZ3SDfqMK9s0JXs5l3as8Ih155ONrBRyRIq0pXz/hQ5tjfG3Dj5JcEUl79HzJK6Jr1iKaRQ6oBesdVjZr1IV/Py0uEM61LTS+0AlFY7oxZbt38RL8pLZJydj3mHwcTsWKpkKStmAnB2pTNas2u2sA/NF3xkxHs9H//2gcvgbwZFOCBkdBf3R3JntykM4ccABA6GQmA4/Y3IDb7zGbBeFmQ1pgjiLHV+GdmW9+F3z0hDFTQhFnH/2mCFamIRc7AbabbI1kwSaS76qGgek4FjvZAbJsAq0digFBNTay82lhI8S649zdTfn0cU9tArzBa34xZelHj/yiFiUmyOk9hxTRyNgds6Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6506007)(83380400001)(1076003)(36756003)(38100700002)(508600001)(8676002)(33656002)(2616005)(66946007)(4744005)(66476007)(8936002)(66556008)(6512007)(4326008)(186003)(86362001)(2906002)(26005)(6486002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WcBQIp4kCdd+mvQ7iGo3ht3rFBQnM1z/Ixp5vgdZvwJ/HeGQ4VhT57GRC+T4?=
 =?us-ascii?Q?q5DOVW4/0aw6fPkrdml/hIExUrPNpE47Bp9doNx/dPmvID+v7FbXzfT4GOL5?=
 =?us-ascii?Q?n56ypT5tZmNdi+mgX4C0U1wuoStk0vdN0c9abxaA3lS9tpkwfXsKw2sstvD7?=
 =?us-ascii?Q?YlsGZgR4Agj5tOCW+AR9BRnPyW575e1Fa9fwVi0Vlajqu1JF0nnc0wpAPlAX?=
 =?us-ascii?Q?0FOFGmbKK2P5Nxd2TqzuJwllg2JCuXj7gQdE0i16U6ahoUVece2ZfTkgnrlX?=
 =?us-ascii?Q?r4u2YchytleAKAo3YHYWahZuFuLSIbH3nEfEkAh/pF9nmisxIvaERL+Jlkl6?=
 =?us-ascii?Q?13Yaw0cG/ew4cQMo+37S+751Wf7KShs6c/r2ynQ193vbI3PI+gq0G4UcCpmC?=
 =?us-ascii?Q?Ot4mJefxUz7Zj8rlzu33/JLmjE5Dl7LPyYncJeoqmJ2memIneXJnL9tNmDQC?=
 =?us-ascii?Q?x0LbqvyFDuDqiPo85NmABPtpr6QczdmvE6SO7zfVMT/AtaFS0VN4tTGFdStl?=
 =?us-ascii?Q?qWN8ZA+gd8AkvaHRJJk9iiWJI0Pw4/f8KtDIYVu77DMCa6Job+CS8rY4IABf?=
 =?us-ascii?Q?uP7RjLWW892rhNc7jaSYBrRAr6sMCw7An4LlH66yk1LMfpDBcrAaE4mL4jKx?=
 =?us-ascii?Q?r/oEPxGUGopNkLqHuTsiLSDFOq4pIIYKy9KJtoCcQDVMcO3yzC/h5Sn/gydM?=
 =?us-ascii?Q?AhV8f12aeVRJORwiaHs1pKKqoynvmms6m8K74p3mUbqEigeyd4yF34FJEZA6?=
 =?us-ascii?Q?813YMPJ4BWKs2LMoT1IM7GzHy6Tn6+1S8do2CtNOzIF6UkMaZk3VrpXtqDa5?=
 =?us-ascii?Q?dXv8mmSzU1JvOSe5XTWKilpQWpTcAY3i0L+c1UeUE1+zfWSeyqWzyLyI/mpc?=
 =?us-ascii?Q?Hs7QYHasOxVLKtRIFk7b/bpIVR2hSiaQx++GOkSVqM06VBF58wtl0IpDQrBR?=
 =?us-ascii?Q?ezC2X9ALH8InwztaEUm1SNT7ZpfJv+RD7BLWekFvN9nIUN2CVgVE98+JUo2+?=
 =?us-ascii?Q?n/i6wA95HzJNvivvQmH7PMal0vK4kF3iveloVrLjxAfCYbjobND+QTz8NSzp?=
 =?us-ascii?Q?mAGMY0KBJoOF8hROiR+8gL0R3V0AwyMpSdI8UpIH0o8O83ijIiGw80BK5Iey?=
 =?us-ascii?Q?hh3pKbaBn1BVMqyUEvz01KCzzHeITdVuqpnplnj6c0ZUZrQuHLJ2IZZN5YTg?=
 =?us-ascii?Q?IDmClkVNYwsoyD6VkVPUac3HiZTX85ACdUl4zkoHRyTO2hmeAcgYP6uzlKzb?=
 =?us-ascii?Q?Ibz2CYonGicEpKRiO8krZ4Q/y30ROSuN2tmEwOALgCdLovy7uqw0iQc9fn5P?=
 =?us-ascii?Q?ltXAcOhsJGHzwa1hzep7afV3Q3hE8QfwGy0wwKOecUPHwfhnzuzjzf8FjoW/?=
 =?us-ascii?Q?0xU+6jL8Ae/NNcGCK9Ftonc5wwqct+kvFPxmzL0c+kO9IfQ/fV96KnSUAClS?=
 =?us-ascii?Q?Z1Iqv3JkOvrTWIp/gRdoB5Y1h1SCqF1tj2HeXlUWPOXaQsrb7ilGFPfUTEJ5?=
 =?us-ascii?Q?aacNlq8qV51UmVqi3n0uVpG65WqWToFa5ghkjY26Y37stlGfKatXk07ciThW?=
 =?us-ascii?Q?z7yT5rJwuPYfl4wgBik=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fcf607-2f0c-4bb8-9fd3-08d9bf619364
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 00:26:45.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4nJQ6+jI6weVdwtZKiHupLArlM9KpreViL32Bot9bpYEyzpSC052IzlGMfTDOHZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:33:14PM -0800, Kees Cook wrote:
> Hi,
> 
> This is "phase 2" (of several phases) to hardening the kernel against
> memcpy-based buffer overflows. With nearly all compile-time fixes
> landed, the next step is to turn on the warning globally to keep future
> compile-time issues from happening, and let us take the step towards
> run-time checking (and towards a new API for flexible array structures).
> 
> This series is based on latest linux-next, and several patches here
> have already been taken by subsystem maintainers but haven't appeared
> in linux-next yet, and are noted below.

I took the RDMA patches to the rdma tree:

>     RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
>     iw_cxgb4: Use memset_startat() for cpl_t5_pass_accept_rpl
>     IB/mthca: Use memset_startat() for clearing mpt_entry

I needed rc5 to come out before I could take the mlx5 patch

Thanks,
Jason
