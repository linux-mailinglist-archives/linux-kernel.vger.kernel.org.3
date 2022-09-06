Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06605ADDE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiIFDUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIFDUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:20:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4511A3A9;
        Mon,  5 Sep 2022 20:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGjrqORNMJZWbczrsDYEUJw/ky1ofqKGkNV5lXU+o3D5paeU/GumvwSjci0zgob7fqkxTMgFwWYDkULqvhznx3GXpNCDzBaBsSj7zpRdIsABwGG33tLYMy5Qg+Otb1LUYP6QOY7z7QHSHaYNLIFLMLGb/lMc8KzQFsTSXYkCozrQaB4stqkQf7KYIW4pcXTRngfX1DqOMt2d3vOa2n1Nv/fq5wx1SKN9yVM0FnEuQLijV7KC7CkWLF0hCKNBHcTHoU6tvLcfnt/bT9J8xQRgrwqu6ykQbH3IsRR9UjcQ7F0m0GK7keZuyoWrbxHPXwz1bvm9nNIsGNwOZ01ft8nObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYtZFJF1OoQ881qu1qrr4+QPYAWI1ZBF/Sht+d4mzCk=;
 b=ku1RSkijv0KsVmBy7d9GHzb0s6yJCAPNtCyzFxCfn+X4STtVRQHq4cIP60ekN85hKSQzcFBpQ+dl3qLGgOSADfDEqRc5Mj/O5DeH1/lwhrZaZEd0GNT3F8Znl9dV28rMXEpjLmaaq0jNQ389rZkMqmWYid8GzbCEL4O8rI7Wkiao9EB9DA1gu2ekLbngsojFfKo4RIlPfsNXbN29eB5KVwDLuaxRnpuswd0foCDou8OMIHH0WMrA7rMVK0Eb6blHhtNNZf1PM5I0tJ6NJe/51flKsJJrtLxnYWp6jnRvNX6AP8+fI7i2s5obi1xtqf2c0tk9PVSxJHcJ/7xUlauTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYtZFJF1OoQ881qu1qrr4+QPYAWI1ZBF/Sht+d4mzCk=;
 b=2+D0/bwGOX440Eecg3NRkG+LetIvVPnGX78GUHu4MOK4+HY1jQQmgPSc5HkrM10faO1X6BNayF6jI0aseOimYUYwLV8qkTyElVsgd187HREaM9CLz3VS+5rGPfXqgk3F1DqEu86hRkuq9l/T1m3hZJNiPeWZvGrogfc/N9hSpx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.12; Tue, 6 Sep 2022 03:20:01 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 03:20:00 +0000
Date:   Tue, 6 Sep 2022 11:19:35 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [Patch] cpufreq: amd-pstate: modify type in argument 2 for
 filp_open
Message-ID: <Yxa8R7NfcA3EFD5Y@amd.com>
References: <20220906024826.1560949-1-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906024826.1560949-1-li.meng@amd.com>
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c153c3d-e3c0-4fa4-03d2-08da8fb6aea9
X-MS-TrafficTypeDiagnostic: DM4PR12MB6664:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpfeXAgGpJlrEL7OPg9Pbz4MGLOOa7ZPD/g379HBGueHS2yGXaIV4M0mJ3ANIteNCA0q7NTMDMYzvm6+RyeJwtGqcXFPqGObfHGxrvAgM/P/M9LLbLsUSAb/Xo+xIgeK4SIY4wyMdmq2CniYd8F56klIinUBoN7nWyAe2syR1DqIuwPSjYqllc6CWw/k7zacBR0elnXEw5qxvKnBH9440Msetsjbw5xqaevt720Xwud1E3ZYB3D4f5ZMw1vKWC3imQRxnZl4i1ay72n6XDFrvoAPakIyzu+klzR119dfHYP+wHJR9TuU+Wpvu2dKcx3Ptv6356QPLymMDfkCmqK03Uchkw4V0ZrPg8mVOlhdwE9muf7dRUKaTxuKSbAzAvXhRdJicdTYifNb8VVoeycfVjinuBwhAZtKt2ziqjqqzMdxiQTo1T8Bua6yhza7i8rmshmJJ6agtLNETEWmXjFqJFkeVbhqKwm5GkGoWoXyGEp2a/B5K4LkpepsdQXAl00O1IgD71eDNxaKvjR15rkYFGY2rpcoedir9n5TiESjEneUBG30LjGW9ZNLCTYqiB+RNtjk4oNOpsI6dATcPQFcckDQA7ueEgbzIzx7VZSyApncyT76h8qzGME7UlOIiQoBSEE1V+RNA94Kn7zoRtJmFZhRhEiadda8pd0qdPsAj5iLtoHC9259iKRpq2/jyZeE0iP2hJofSIi4uRA6doXipQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(5660300002)(8936002)(6666004)(26005)(6512007)(6486002)(6506007)(41300700001)(4326008)(66946007)(66556008)(66476007)(8676002)(37006003)(6862004)(54906003)(478600001)(6636002)(2906002)(316002)(2616005)(36756003)(86362001)(38100700002)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJ8nudTt4LDFI4dhw7BR45Wu4MZIP8mDKsIztXn3DtqTGVujrCdiuQRyfdtK?=
 =?us-ascii?Q?cBfC4DhbR6ZZuaMltk+vy3mpQVuHwN4z9kXPj1Wl8Q86nCBGjhuOf2JMdZwI?=
 =?us-ascii?Q?4F6EIldVlDUHp5VF9Np+nlCHzyU2lJrd1kqRpsMdhaALJ5VNBkElGGWAely3?=
 =?us-ascii?Q?aoM0Bijo/lAKM8u4PGGTwbG0IsvnGCX1P4ldeRhbgcWLTmrQhSN6ZZJEBZ/W?=
 =?us-ascii?Q?NHL7OzC9GbBTaOp8x+5FSkBPNlD1ibY2r6y8jmPLxJvPge9/SEvVlnjttVSN?=
 =?us-ascii?Q?wxH9od5dx3/WLGANk/XXD5yCJ4EcTFWTZKSujo6Effmrh9NcKygWiB+YgN0G?=
 =?us-ascii?Q?3eIQozzw0Bg5Bp2Wzh4XWdpoH78EuR35m8zdqnVDEw9rprHqsOQhyaPSkreB?=
 =?us-ascii?Q?cMbk6J4mrDDDIzmWt1D9yFH9V+5sQ48kOzfGs0dyzX63RwUZker0JFVvJINk?=
 =?us-ascii?Q?mCxjrFacDgYennDX/IUAAb9l5vVXtG1aXn3PSoNzXNAgl94E746GgihmLqFQ?=
 =?us-ascii?Q?vrJEkkITDUpb+R2orO39IOo5rYDiKzcWZQZBJbzZpeZcQg85rmPanJ6dDyTl?=
 =?us-ascii?Q?tczJyTkyvVxlqLio2ixv5q/zEsopMQyJP0GKLPZPsErcwVP2PpE8vlan0ZSo?=
 =?us-ascii?Q?YH1134nTTfGtUvacsjdbi4rpLw4keNDg/8Jrw+kNYsP3wCpU28qDofldgrVn?=
 =?us-ascii?Q?D0AZ0+FQrpKf786rWuokqlVkD/BlNKhpPhVjKGvcoNPR3gJ3bWLYmlLf4wHB?=
 =?us-ascii?Q?j5llukiMTGc/ZjfNMM4LXZ3mevRyFixvKMDSL8m/g0b1O3wxGcuZDzi/I4Ok?=
 =?us-ascii?Q?/tZ/wV2iwliaD65pkvmD+nTESDHQ8t8F21WTZccHszi43VhHDzochJBjI8cd?=
 =?us-ascii?Q?HJ5IZiAnq7RWomQeUUTCKtL/iOa1lMX+uNj1jD2M238FcjRAPTrtWoaUTJCP?=
 =?us-ascii?Q?i2vtvU2jEeVjmiXxFgFRticUACP77BAKyHikRRIie7ygKAsJh1ZO70UpLrj6?=
 =?us-ascii?Q?gnLzGyFQyJChsNF5SQ6TN/koyXH2EKAnexUgFyg+tLO3Z4ajgvqmj7G1DAM2?=
 =?us-ascii?Q?XhyVut8O9cU55fquQQYQcdqCjUotq3Doh+TG7Trb7rdh1JHPIvRaw7VlmwET?=
 =?us-ascii?Q?9Blz7J2Nf4t5ab4Ra+rhoYbgCVud1yFuti2jWiw6kFtfHI0WJRDGTWVl4aKA?=
 =?us-ascii?Q?+mDwnKDAmM+V6EXqzmS5QLnkHpqivneDP8HR93hT36KpJBssCuQjyNZmb+n+?=
 =?us-ascii?Q?uZKjDtWMyjpgKNhpOLHcb0YRuaHngIAE++254lXARvF+SsmT838LkEbQCvrY?=
 =?us-ascii?Q?BJALIsv5eX0KeRUojfT4ohUP/LCmHvhnJf1Qs/C2KpQ79nXsi06Dq9PvC1QV?=
 =?us-ascii?Q?f/CrrpM3gRUe/YEfTJ5LfkN3cD7Q66MC/wgRh9sAv9aQuDg1+CiN2Oqg1ai3?=
 =?us-ascii?Q?hntZdFgi0NZnSN7jJK8fPLU8f2t8/YWNzJ4p2HlEFyv26NbkIs3Oqt2vZMGz?=
 =?us-ascii?Q?J1aqyB23ejDhjxJjg5PZcx8PwNkvysFfNwqpqdVX8Bfwp0cjRjksyA2kNO+C?=
 =?us-ascii?Q?RcG+f7Gh+Zv8Ij1CcdWIdUBZKXk0mr9uLqlr862i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c153c3d-e3c0-4fa4-03d2-08da8fb6aea9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:20:00.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: if7JCq7iK2rdFUNMX19/Z4NjP2cHPupMmQ0cq7betdp7QXQRRV3KW5aLv/6TkXl1BQNMGaSRiSPaCUUpsiJ+lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:48:26AM +0800, Meng, Li (Jassmine) wrote:
> Modify restricted FMODE_PREAD to experted int O_RDONLY to
> fix the sparse warnings below:
> sparse warnings: (new ones prefixed by >>)
> >> drivers/cpufreq/amd-pstate-ut.c:74:40: sparse: sparse: incorrect type
> >> in argument 2 (different base types) @@     expected int @@     got
> >> restricted fmode_t [usertype] @@
>    drivers/cpufreq/amd-pstate-ut.c:74:40: sparse:     expected int
>    drivers/cpufreq/amd-pstate-ut.c:74:40: sparse:     got restricted
> fmode_t [usertype]
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate-ut.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 3947b7138184..e4a5b4d90f83 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -71,7 +71,7 @@ static bool get_shared_mem(void)
>  	ssize_t ret;
>  
>  	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
> -		filp = filp_open(path, FMODE_PREAD, 0);
> +		filp = filp_open(path, O_RDONLY, 0);
>  		if (IS_ERR(filp))
>  			pr_err("%s unable to open %s file!\n", __func__, path);
>  		else {
> -- 
> 2.34.1
> 
