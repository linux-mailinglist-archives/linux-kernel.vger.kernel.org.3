Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E7E578F72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiGSAvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGSAvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:51:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D436B1DC;
        Mon, 18 Jul 2022 17:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvZDMRp7ikvMV7ONAqIymC9TQRRKryIcw20EoV347pHQwBy6Ft1hdR9tEJ7HsL6QcFAFQO4p11abABKcrlncxMX/1Fp9Q+nwqzW1EzU7urmPuS3h+afGM3lgvY/sBYZS4oYDN++7ekV/afNx8UPxuGStrRfDBkiQTNa9X7d5LvpIZVsih2hc2rUvUeKp/a+RZQrj6YYUi1wb0Gc9GUZMRy0qeV/Tn0I0tA1lyGoygUYJNaiOjvuH8dTC82uVLrpX7r6KxMnQgthmY143l77G7rPdIF2Bph6hl12wtUNULQdxPNgFc4hrhuUtU5yAK2h1d//L06acpznieUmdN5sdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+20QMJ45xb3tUgAUruqUBn47xDCIaITMSLblic9qxNI=;
 b=E8cv1miQQ8k3qMTgoT96AL4e+snGBexD8dx9urjJnNRrZWY/BV7Ya2ZF3ZCMe5xJk7pfj2Y1WxcIowCvVmVQInV6FJuY1hb4zjBeyoQq1EGKY9OgKrsNG90U5EnFMseJfZVWH1oCOqwP+bKakrLks51zu20JVA/JV8MFTPGdmWK+FluRBJtyhqg6zebpDhwFaiCcfk3wnGloVhqE33nycpJ3EbCfD+Oux5gIxYq9oXNtH2PHhjSZ2yH/l3QmQAiAkXq2chye1L3LCdcs5M0tyq9GY6n3draXvjIF7ImcMeMGiMa+P6fbmEGTaEV+iN5Mn8/97g+Q+hhbdUqaFVmCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+20QMJ45xb3tUgAUruqUBn47xDCIaITMSLblic9qxNI=;
 b=1fjVzmHIWzWDbiJB6fzrZ9q6EEIFJv1mzs3ZWdUuhg7207IjZwleMIhBylwZhoWf6W1b3wbB2QLUF0FDNE19Wr8djCKUUZms/bDWfXMkmpJaXBePk8VCpNH+7RngbE9fRFAqOQqVxNGU4gS0OVfM84eAwIYCPN9lrXHyWC8fRQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB3314.namprd12.prod.outlook.com (2603:10b6:408:45::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Tue, 19 Jul 2022 00:51:08 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:51:08 +0000
Date:   Tue, 19 Jul 2022 08:50:45 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/13] cpufreq: amd_pstate: fix wrong lowest perf fetch
Message-ID: <YtX/5YOaad1M5kFR@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <7091e6ddb8605bdd870bad3273b03eea67354bdc.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7091e6ddb8605bdd870bad3273b03eea67354bdc.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9545e9dc-f450-4321-4174-08da6920c4aa
X-MS-TrafficTypeDiagnostic: BN8PR12MB3314:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRmgOY9LiS9lnR9I/RSj6cYghjc1JMeO+mSZAgR/92i0WZvG0A7C33rhSfu7LQn9f6EywWd/Xmt4fwHjM0ghCaAHDOHFaXrrJMNlI76JsJ2hHX3NkfL35cR+iAZd5uZMly2eZv8JxmkBCrTMsWDSyJQplltMPUjkB8mbJNB8RLFo9WbsGt2QjjtWzkrOe6Hmwd/kGvF2OgmAGbO3+HefxX8dSSTzb+uLeU0viF0wA0ywUzlNnay5j9PWtYGOHnWyw4aDk7IR7a4pHTy5tax2gCihXlLPeqSeJ7O6buBsf/qNt2VlG/Hs8xygqEiWzRv7cv3+QQAEdqifzst3wVJRbFaPGaJwcrlwFLTLDs47/n2RCNcD7foSy+Rn3ODrnR+y1oetFvfXsrex93jmepzaDer6ZeSmlzysQ5skuwArW6JwjdujJth/jLpRL+Kahub6J/R7G9ZZIv+Bqpxq8ZKiF3MnVaxfXlOsH9PnNE4cm2TLwmhhCd/plm4OaEZTY4GwSSMMDY04xZjivAVP/DUcVe+17kziA22KyjNRxhVBwv2AhGomy3ZB3K9zh3+yq9zKEYV3N8qMSSfIp3OZlv5xAj8lWAJo2N2pO4rCbq4s9DSUfoduDxhaj6d72aJvolbSIs9Bz2RIFEu0rRDLoNFSTC3A0h/UiVDkPPbK+sl9LeAWoeWXai7g/nQb4FlPorFiROPb/Lrao1a5NWq0Ttao+BpwFxc1JC1FkBj6leeRcIBBhyMjMNaoNfRQjhAqhTR/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(316002)(37006003)(6636002)(54906003)(8676002)(66476007)(66946007)(38100700002)(66556008)(4326008)(36756003)(2906002)(6666004)(41300700001)(83380400001)(6512007)(186003)(26005)(5660300002)(6862004)(2616005)(8936002)(6486002)(86362001)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHqTzkheVAOJQGjSm8zMULb4UEQd16zAvD8+Jcm4DSAmmp/G24XkFvXIhWs5?=
 =?us-ascii?Q?5Yzs3JPpLJct59Xc/AgQtn+E0zgG5s5AWjJzVoIkO4lT3t8u6/j74qGisd+f?=
 =?us-ascii?Q?cRZP7yZ6U+yC7lpTN/Kt517J5sx1VDjrh4j2mDWqSikpRDuFdQgO0hJg2yE2?=
 =?us-ascii?Q?KwLQ0nOTyd6tx4JzK7vW6n15P91lAwRErGTQ3beIMABzWotpChkOf/Sr+btO?=
 =?us-ascii?Q?P10XvyX2NZgEjUZC4xQ6TaLTGPvGWC65fv+WEdSYME+vbTzAfeQyB8W7c5m1?=
 =?us-ascii?Q?9WEThw9M7uT1g/wGLZKTa+F8Scgf6w0uNb+0FeRV3cpaJe4nS558sTtq2XH2?=
 =?us-ascii?Q?K4ILvEAQjex1+mO406vjh7v7bE1vpqnRrtdB6gE3J07SYuFRv6HIjP7sGpLk?=
 =?us-ascii?Q?znw+AzaqYxvNQRjuTkQ0L7AoNKauxAtkrSgiL2dwojuT2UKBoTdaRsOJx0jA?=
 =?us-ascii?Q?nAIQ4Ob2Mg7pn9pwuVtOuNw7JApmIaAGCv+H79Mo6EvMOYY6uUfX6V3+h1nF?=
 =?us-ascii?Q?OFLf9ShZ01iHHj0AmlTytJqB6xiT/fbNt2ziBQYJz5UhjFo+kCxD0pJgc8uj?=
 =?us-ascii?Q?AiHtifGEtjqERoKAMirkBuPxOVh2OfHGb2Cd7M5nLnmPpxsAgRvGbDT6+giV?=
 =?us-ascii?Q?GUXxsIOOUkSODaLUIX+UND1YRg4eYUn8+myVW4D8AwzBVSKLgtU708+yQrVQ?=
 =?us-ascii?Q?rO9vqTRD8jReQDoFho7HBOVCyBvtTi8WtDt+OAmETsTm7LDEOq5Tjobeq2Pg?=
 =?us-ascii?Q?q0SvYRdtoQ9YcWWcL9lGuV1d5sZEBvGa9rhEaNRtd9xR0ezlydEFjyxWG+cv?=
 =?us-ascii?Q?1FX1ty77FfC+OmmBqMn6Tvs5K44qszsyFjhWNuBtEA4aKsNbmjmC0RYSr34i?=
 =?us-ascii?Q?YDlMAr7ahxfitHtyQTGZtTce9YTGxAr3UT5Mc9a53whjeJT56FVyRjvkJ84z?=
 =?us-ascii?Q?YUOeWCBON/8kalEAKE4VyKtCrKK/yp3NZ80EhPworfMaPi6MDHQKGQZkxN3X?=
 =?us-ascii?Q?LL1QfwUk/ZbdDCYDVbwEcc0MiRo5OVuZvPoaw7vgg4uyqU0yPLVdz7c4f4p+?=
 =?us-ascii?Q?PryZWVjzQ/+/Ed2rRDweoRqrjzI9nzjRD0p7iuAgZV1UUBRgED2T/Wxum6KW?=
 =?us-ascii?Q?t963bauFzojPYdkdlzkB3943AE9PNqg6Ltc8HJNRDM13uT6+jwfcuYkMSKro?=
 =?us-ascii?Q?P3y48snxOPVNzCZ/14kxshNXk+uCnZ2ap0F/dZb5Fs/J8hLKDrWkiBR5+4Ej?=
 =?us-ascii?Q?nvND/yjILekSUhM7wBfeIp+pJcRFKevkKExwm6Ajj/hcU4DmTBId1Jab1MIT?=
 =?us-ascii?Q?Domx8Zdq58PTkgr3lVjUSPoTTXhXJi2j8ljD8FXFtwm7VAymteQSOw2+WcKy?=
 =?us-ascii?Q?xgG6rtBvtKTAmgbmcfnCqWDeQdrxFG8yYY4Pn7a6ne7q/nUv3spjg/x8r5FJ?=
 =?us-ascii?Q?uRgm3jROyAy7RJ4CTynAMNHAMDW57LSg8L0g4199nk+jINaWnqwUI/i/Wgkb?=
 =?us-ascii?Q?8PRU+/ownjFJ7PJ+64Ri+7IXMllB2JvVC+7mC3HAZ9sMNL9B1f+4WzkEcNxi?=
 =?us-ascii?Q?tqdIVQ9MBcJntuL16uRsKYERbBIjbh7fLtNO2wG4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9545e9dc-f450-4321-4174-08da6920c4aa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:51:08.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyWEqa/hDLE333gd1gyk6tYwHRhxgL3dK+Eg4bHu2toNiF7KATU1OtOO9GcYTemiZnrAwDsIgidYJVireK1cIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:25PM +0800, Yuan, Perry wrote:
> Fix the wrong lowest perf value reading which is used for new
> des_perf calculation by governor requested, the incorrect min_perf will
> get incorrect des_perf to be set , that will cause the system frequency
> changing unexpectedly.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Su Jinzhou <jinzhou.su@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 0c8256638ed7..4b764870035e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -311,7 +311,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>  		return -ENODEV;
>  
>  	cap_perf = READ_ONCE(cpudata->highest_perf);
> -	min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
>  	max_perf = cap_perf;
>  
>  	freqs.old = policy->cur;
> -- 
> 2.32.0
> 
