Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F954AC2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355768AbiFNInE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355810AbiFNImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:42:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599C4338D;
        Tue, 14 Jun 2022 01:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGGFtjvs+d6yaTtg7ABmHkygfYdp0g90sgYlds4fcXs8kKMRtYQe4q/oRym8KDGrANY+DQD3vXEPbb8Psb2XnsncdKxOl7PoJt+liyam6hCTcD0Im+O2Fwd37yeg8XZ9bgjxA7i65C/9n4YzirTwuLm9KKnCiUK9G9YqreDOY6P4M8XwEQfrdf/Mu9HT6VE7gNj36l0zpWqrxTU76i7WdTtYDFQoSDi+dn6zIFM4fiAlZg78p/z0lzFMy1XX2oxqh8aXy+uJBGsjrWftMZcbyXT2mvCBAgQVb+bPSr1UHsDk1lomCR+aHWLV5O/maGFbInOIuTjmNbf4v+j80UxOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNpswhHnh3H7A2S8PqPBA7ZXeIRVxJ4rEBV4vuvkW6Y=;
 b=M/TUt5qg0yTZcN1pceL0zOZUt0SKHL8Zskah0Jz5+A/aO4b1xQOAfzfVdhBFPySS2BPjRui6OPLBDpzPIB/OHFlbqlvBgUuU7D7Xl5epandd0rJrKjLAjHknO6GySkeA7FQ0fskGd0pp4ANY1wetS7BWkPrwAyMXo3VXCOUxdZMt0CNpD5gBr38wdMkuj0Tt++ttCfhz8LirCMNF04sy9tlLSMJ7+kBTWHaIAZJnT9DDDdZWjX6gaHyB4P01xrVh7Pe1YslN1cp2XU9fHZatNM1SKYiiWEZ3zu7GAfe9PDdm2YlMS7D28TYmj12l2LiImApn4vqWUmgyFsZkS1OKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNpswhHnh3H7A2S8PqPBA7ZXeIRVxJ4rEBV4vuvkW6Y=;
 b=aVIxYiUaVHYGlCveedP+U4+x/qKTpyuYbGWGQ7LfeAMl1yJ70Y+0BzGEUc8vnIKmgVz8liB1n4f/bNiHAqAPyWX6yYGXnOKiCBwLS16k/frcey0eQnLtgh0m9baX6cp4ZQU1A5RjWjraSiF/l4ScqAB4asw5KJCaVLDIjzQWIc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.20; Tue, 14 Jun 2022 08:42:00 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5005:bad7:e9a1:4275]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5005:bad7:e9a1:4275%6]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 08:42:00 +0000
Date:   Tue, 14 Jun 2022 16:41:34 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: amd_pstate: fix the highest perf query for new
 AMD processors
Message-ID: <YqhJvmQqs86txz1V@amd.com>
References: <20220614035229.170852-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614035229.170852-1-Perry.Yuan@amd.com>
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a68ff377-8545-46b2-7941-08da4de1bf50
X-MS-TrafficTypeDiagnostic: DM4PR12MB5722:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB57224564210E1314994A3AEAECAA9@DM4PR12MB5722.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83CWsmXIxprN3fj1hAXXWpZQaFD3D+F2WldRbZZktaSahliq8IFDm7xIYa3dUFNDI+BSNIYqnh+dkAji6/icZImgQsmy74Yt7As6L/VGY++tMxtmQxmhtldClpv+/Wc9bACTjLj6hFkH5txBdwMkkaRi/F5jwzaodW5aI/ZRx2I7SCvvtoq3tnnT8GHwMnR5vGucZLukt0AxG9JFwIR0ycrXqLEQjXiQE63E16a7zALOFH5kIURM2vJTneA4i+2NJPK75F7rCE1Va/avOQj/o+BrodLz87W8ub9UAS7TdMtrdzp7Kdmai8i4XrhWP+zmRtjCgZEI1jNsNPD+cOPfu+L1sPcXplwVkfcERM4fDGIIXteLOgr+Su6nT3pGjrCvrTbKNlwiEe+lIXXp4upDb45t0l+CMoZtTERJuy+wwHIopxV/7lzPeTvDGTcDDyw78YiwvRGV/daCDx7h2ED/W4Ki5n8asVI4P8iZ071iySZvx9wxl4690VtiHfzcK/eJVN3wAZVw54WjHTdhLw17BWDqoNELu8YssrGevpDYMGZgnqzs5hwnFZY4NsQARfu0zp/7SxJsCBFfvO3Zjh6UZCoaFCy8rCzA7uLPEJKyhl3d1NQFzrk1vTlbUlnWmMAx0G5Z6dWbyNGCnKXriv+EOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6512007)(6636002)(83380400001)(6666004)(186003)(54906003)(26005)(316002)(6506007)(6862004)(66556008)(2906002)(36756003)(5660300002)(508600001)(7416002)(8936002)(86362001)(6486002)(4326008)(66476007)(66946007)(38100700002)(37006003)(8676002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AfQTMtCfKvv8LH8POwpIUM3hl+4qBV5aty+8t0f7VzrqUkjd9v0DstzW8Qyx?=
 =?us-ascii?Q?b/k9wzUWD5jkXPrRv7QqZKtOWiqpd26NpfKirqFsFJddqpFka4KVpdLAs2yF?=
 =?us-ascii?Q?cf+rdPhbuTcwF9/DLrjScSGheF+P0CPQ+0/vQr7ex4vzLRxBfTR9QmIleN2x?=
 =?us-ascii?Q?H1T6sCk0fDCjzBJG2K9S4tZcHIih1DMUW0tPf5cMXCiyTvWePGqJc5R4Fk1M?=
 =?us-ascii?Q?rRCAjAmFmY8FFE4ueLNXKVe34YqqAbT385ivWzthcHao1SENiI6DLtHliHrN?=
 =?us-ascii?Q?L/OvGjbtxlfst5Z5ualrSosR8PIHyFPtBxcSFwXoj7+frvcCe6G9H1QObNb/?=
 =?us-ascii?Q?EJfelhp37Qr0Qfylmvt7+WaFKdLIm1FGYilVIEBdDQo5LlBvAJ8M/hbeHcAv?=
 =?us-ascii?Q?5c++x+A0nsALKS/5U8Q7dW2BwcmSxDr/vehPWCjcgnQEtbO1Lx4S7FAUf5Fr?=
 =?us-ascii?Q?+jvN5zlldB0r6UHE7MK1WPr/0b8vemy9cFsXAmCENyKCSz5h2rBDZ13t/j5K?=
 =?us-ascii?Q?2FW2wb5UPr7uJhbADDwxdYPrsoEqW6G0JwvCO1cShcbt7ReNCCVoujRZkjtO?=
 =?us-ascii?Q?dkXQgR0IF13v9aD/VDwU2z3nKhME/mNkroXdIfnh6hw4M+Qgf8vikhoGFDk8?=
 =?us-ascii?Q?d+ujBR97sbJxKYuZakoISEuF+lNXl17Y8fUoxgWSZqiPeW1sJAcvJYmzDhWI?=
 =?us-ascii?Q?NCuYZPjNiTrjOw/jeNwxPRzsiMcqBY1kbTwbwfqvgK0NXUX1UUqemq1EgzOs?=
 =?us-ascii?Q?mplLsOLfmeL/k/2tQUBHuyYeSVGV3QPg5ePxdFaLTuFMaVUnnFiF68gAr1W8?=
 =?us-ascii?Q?TTdwQOfbJRw48N74Vq1LYyArda/1GsDCFW3VMI74yCFfQFQJIMW3yTrY9Y+/?=
 =?us-ascii?Q?WOaFrCqewq061CQmpTxHqyw16tVEptzbtn6GMGI8V8oliV+voq27nqcspLUn?=
 =?us-ascii?Q?xnra5JmjqGl2C3KLxwx8VQ4SnQ0Sg2hzIJkUir2ojaBgKBU0FPu8hubP7jYz?=
 =?us-ascii?Q?7Lis4c36/j16b68kATB4BX/+P2YH2Tb5aUuIVHFVb7mn1kxK9kXMhEV4Yjrd?=
 =?us-ascii?Q?ExTzXYEN6Sk2veRTlk1Z+Xpl6UDxmqDRMhgQp5tSwUiZoZcyCNcFzyDLgB0a?=
 =?us-ascii?Q?SLwBBxgvTRpHUbW7M1R+r4PHJ20Lwq+zXBjKwUuGutGfsP/tgNU/97tLrjI7?=
 =?us-ascii?Q?+WVAVY/qD5q45ixz4I09G+k2rKAj7NEmTitVGwz/n5dALPzAXkA7Zqiqbvot?=
 =?us-ascii?Q?+PqSbtworAWSvmi79KQXfffLbzx/+wuUKuAHxTFXU1FL/l6vZ4aXreCasD/W?=
 =?us-ascii?Q?2skLMHq+ICyyotV9DVbCuizBrsxMR8DC+5UmHChij8mZWSIb2CTU0ZicdLJg?=
 =?us-ascii?Q?gcfWtc7AiBTwea6EvAgMxxKrR8CURdPpz46vOby9qrxz7WlKNP4TOnmMSZb0?=
 =?us-ascii?Q?wgseUyBDDnBq9AmIE73VEoVT0Q8wa/vLqZG23lvamH7UHjj7dE8fPbilgI6s?=
 =?us-ascii?Q?6zsi7ndG2PLK9KfxrhpcmU9b4EtzfcBZIdzsZlkv/XXxJB1hbhHaT4UOeBVP?=
 =?us-ascii?Q?wL5+cxADQLnEjGf7Uxi20A85yw1qpB2N8qrpSyvG4lLGM6LNkn36D8adJdbs?=
 =?us-ascii?Q?NkAC6XrVGMd+WL8KTa7+TNH7P7d/hTKHugMLQ4wTSVQWQxxGQo/hdABkMEbP?=
 =?us-ascii?Q?Iq1OCPZvoZ2p+mujRHPxC/JYbAV2hbzfkKs10xfcIGBRyQAG8bJoNWAeLS1+?=
 =?us-ascii?Q?+TO2QGi8Pw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68ff377-8545-46b2-7941-08da4de1bf50
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 08:42:00.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNt95qOm9o4QV2rN4D6LLoCfBFBcW2vtGX44X2uHPEUI/3vYtCgPby9fRYgRVK7ppuhtuUP+yGKSWrWUbuELxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:52:28AM +0800, Yuan, Perry wrote:
> In order to get the corrent highest perf for some new AMD processors,
> the amd_get_highest_perf() call will check the CPU model and
> return correct highest perf value.
> 

You needs to change the prefix of the subject, because it's not the
amd-pstate driver.

x86/amd: Fix the highest perf query for new AMD processors

Thanks,
Ray

> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 0c0b09796ced..ff2075f26ef4 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1152,7 +1152,8 @@ u32 amd_get_highest_perf(void)
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  
>  	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
> +			       (c->x86_model >= 0x70 && c->x86_model < 0x80) ||
> +			       (c->x86_model >= 0xa0 && c->x86_model < 0xb0)))
>  		return 166;
>  
>  	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
> -- 
> 2.25.1
> 
