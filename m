Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A854D1524
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbiCHKv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbiCHKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:51:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C153EF22;
        Tue,  8 Mar 2022 02:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646736630; x=1678272630;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KKHDmlx0YF2dkd4fJe839rmUJptnI165HSbFIRvVyTg=;
  b=cDFB/r8Rp8vol6xwutuj7Rg7x5LTyZpuBIWZ0v+3jep2CqrtLxbKIfrQ
   QK6OxBvgSghJI0zwDb5VppiO6kM/ZizBN7V8IsygqGm2JshPDz75JLqkC
   lor8SNss88OB6nBv9hPBzOhB5ppoBf0goulIosrXrlI0OIU08vwzVSk1j
   JiNQjaLs/ortPhJGoBDbQy2dJH+qK1VK1n0obzaGk0wCSWbLAEQzif9jF
   Yy31pt7nJUsFVfA7Gnbu3iQGjTZ95Hma/DwhQeBE+036NVLcjUHgTea7d
   OgYFQG/7AJpn/tXL88HyrgOJqC+C2SUgNxMmt/Ng/RoyErJlY+6Z/I3dg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="279367756"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="279367756"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="577954998"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2022 02:50:29 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 02:50:29 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 02:50:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 8 Mar 2022 02:50:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 8 Mar 2022 02:50:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpqpgWS1UFJKYs9jxtKRZy0ySupSPy7IPDcyeETtd6PJOMrgbXBsPCYCi0yo7SVrMtTE2d22SJZzg+tDkiOtq6o2kbQkObrdw/WHeg3My2hOqyiDkuj1YnJoISRGLKKKR26/SwVkPKP1ZPtKMRiV/gMPqZU/Qxtoaeqrm5cnUkNu/SKjk/9KnCYAvW3cLAnItaiWQQnWQjqF1Z/9PnAWDwFH2Ils3WDxI6PUBVfGrUZHGNCc7yRBDSFqXjWgT+2SHO6B7L846gr7im5pO1G6VvdzfMF4X2BAFjvfpBGfdrA+umYQdrFe41DhS3iTND6ZlA4EcMfOxkFsV1iVW741eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHdiCSEedhRKu2sNpDMLif8QlvTftLmLhLErX6NA/LE=;
 b=gs40RuliLzDBXbpK/KMryHFK7G9ndr11o+z1hcxO6hYhgRuL6Ng5cuH0rPWdCD3hsl00TroaPoi1RhxT3MJML3LKPN1xHlK8x+MTgF3txcwVjS8Z+SixdeQsbErfMxnDldbXYDL1gWT4iGtag0sWQ7Hxqo6y+w1FoA7H0x9rMG+kIL8MzfcmXAQA40YKM8Lq+7dOqd9DNhgWheqJP3i0t8yqpFv63Xmtngu0lNrgCLLXBuGNRn7y5/FE5/A3dCvHiWl5b55iCOO8Hqr2smILiwTCQT7QYlwKdmKfVlHB9oxay1HQciOV0Acwfcf+LtYPNkziWs5dPBnxpKjl24RvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) by
 BN7PR11MB2817.namprd11.prod.outlook.com (2603:10b6:406:ac::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Tue, 8 Mar 2022 10:50:27 +0000
Received: from DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::11f6:76fa:fc62:6511]) by DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::11f6:76fa:fc62:6511%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:50:26 +0000
Message-ID: <56c49d7f-33be-3d99-af65-edbf19a960c9@intel.com>
Date:   Tue, 8 Mar 2022 11:50:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH] media: s5p-mfc: Handle error for clk_enable
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <m.szyprowski@samsung.com>,
        <mchehab@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220308075538.1117983-1-jiasheng@iscas.ac.cn>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220308075538.1117983-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::13) To DM6PR11MB3180.namprd11.prod.outlook.com
 (2603:10b6:5:9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee8a5f89-f89c-4c00-ad87-08da00f1745a
X-MS-TrafficTypeDiagnostic: BN7PR11MB2817:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB281797BFC1873E156FF5C139EB099@BN7PR11MB2817.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QwJUZMhJ1jyAuIin2C+JwTB8oCS0y2VUieyzZPTmp/+X5Rh99eCV0/ou8ps0ez5N7r1lU4avrZc+yTEY+/wzmqJkqXw17+czYf2drJNPQnRfhLsfgT2doGFrWriVU+gt9VzF4gpbfQttUvfeArZb6md6Sp42umUMF9JBnj0VsgEhV+SjYZDqDRr2CcAiA1UJ9psDCprRZGi7FOA0a6tJtYalXWWeVbVMI8/MRlrG2uQ7V9XlGjxycV2cdHK0Rnwni12TnHNE16978h/RxcHnyk1pCM5oDRbRrp+Zupo1oErCwcR2Mgve3VKlUUFJbmVsQw3uf8eVM+G374DAZQjDPY9hWNNZWrjzDE/uZP5muDKfNp/Hl1M9Rf6eCN5sq69Zn8z1p68C+6W0/dOCnSpoCjSWdNjpZhAl7IE1Q9XoRNn3N84vR1vue6nCLfE6pgRfuIpYk6SdPm7yLRqmNuMyIW8DAqUySb53bZnBCyRia5D4MoJBhE2m9NxVC7YDN12/J3k8H68b0UHM5KB6CL2r0pzuSRI3iXtN04mHA7ATkScUh+nYLtk2EUKA2FD1T1q0PcjF/X6IAogUSphXZZSfUHYuOagQAnA8qe3SnBMF/GJhHmDUVn1dKZoYfZXMUYqpSpAWjgdxQIwJ8aWQ3kGKPrNnCux3NBGKnhlkDQ88g4VBz/A1zGVf7nljMCLjzi9tk5mDRyeYMoG1nbQFnaKVLgrjfKlQ9XsNK1neegck2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36916002)(53546011)(38100700002)(31686004)(508600001)(86362001)(66476007)(6506007)(66946007)(66556008)(5660300002)(4326008)(8676002)(31696002)(2906002)(2616005)(186003)(26005)(83380400001)(316002)(36756003)(8936002)(44832011)(82960400001)(6486002)(6666004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjRmNVdkbE1zQWxZdE8wYVBVVEM3aXkxRENiVS80Y1JrNlZnRnBlWjFtcUxE?=
 =?utf-8?B?U1p0M20xbGhQTmpXTEVmZWVTU1Z4eGFnMkEyMnJ6aVl0QXJnVHRlNTF3YldF?=
 =?utf-8?B?S2pTMGJ5V0RidDJmczNKQXNIV3FsTHM4aFpwTXJWTnR2SmMyREFCNk1HaW93?=
 =?utf-8?B?ZUNJcUtkaEY0TElIOHhMRUZ3WWhpK3g3ejBya3VGY2N6M1Z4RWZZUGhYNEcz?=
 =?utf-8?B?SGcxRDdWZ1BQSVIxemduTE10dkFjWXhSanYxcmdQM3NsK0I0WHBqc09kaUty?=
 =?utf-8?B?Um1aeHJuNVBuS1YrbktPOGFPZ3BLZmdIbVVkZnZCVUdoRHZKRDRBMHNrQ2RJ?=
 =?utf-8?B?SVFRZUpURDVzTi94Ti9ydlAzM0RCVWtTelQ4QTRpTVhOMk9PNFZ4aGNOYjBO?=
 =?utf-8?B?bkhJN2FRTG5DQ0I1aC80SHAxWTJXdmJMMlA5YkJHTmFtYnV4ZGxKMlFTMFpt?=
 =?utf-8?B?Y05sb1NTdkJUR1NSV2VndnhVd1F0RDFveXRtekQ4eU92NXA1VzZHYnFmSk1M?=
 =?utf-8?B?M1I3OFBabFEyaHVYdlYwM0NEKzdsdkVSQVF3dHZ2Z2JaQTQwbkZpTjk5ZXFz?=
 =?utf-8?B?NjVTODMyUlV4bDZKS3gxWktqbm9WVzhmcDhMR0N0V2ROUUV5b2dxUXRybGIy?=
 =?utf-8?B?TnU3V2RwTmxkaERhRzJMMElNR1k5ZDFQYUpYWUdCdzk5TWtDRUpoUGM2VklR?=
 =?utf-8?B?UUxsVDgvWUx6cHhvTVJFdW5jOHIwcUh1bUFuUUpmaGU3cXcvK2FHVi9QbEg1?=
 =?utf-8?B?L01HNnVYYThTdmI5b1dHZ1dJMk9KeW0zT0NSb0NXWUtYTmFLbmwxa3p3ZmQr?=
 =?utf-8?B?NUliTjFqL0c0QjhiSmxJTTR3a1hQcDFzdTIwbHQ2Zy9ERXkwNUFJVDdNMDJv?=
 =?utf-8?B?RUJ1Yjh5QVR3cEJVZGZJdng3bTdxd21nQUhTRTJCWlRaUStaQTlXSHh5c3hH?=
 =?utf-8?B?SmhUZFZOSkpNQjB3dnRzTjltZ1RldjhyM01SSnB6WURZcHhhbTI2OEplSytj?=
 =?utf-8?B?VWNjMEdIQlpXK3c3RExYWkxWUkdaZmluVEdUTEVxUEYwa0JGVGJYYWJMQWs1?=
 =?utf-8?B?QmJZb3JUYkRaNFQ2LytRc1NpeGlvczVpemtjVzRFci91SzFydHdpSGdueUFT?=
 =?utf-8?B?Zll4bDlvbm1FdnkvdXlIdlRJdVc1cGVPMThlSGhOWkZ6QkRwOE1UNUREMVFK?=
 =?utf-8?B?N2ZkYkhmSXoyaExuVkgrMGdmYlYrV3g5cHNKN3BPb1lhV0tCc3d3aGxQd2U0?=
 =?utf-8?B?WmZ0QlJlM2pqWktQUmI1ck9aU1FDV2ZjS25YcFV6aWoweTR0MitrTWhMRS9B?=
 =?utf-8?B?c1pCbWFjU1UrbEZRbGxHNEkzT3FXZTJFbHhyTFJvZVdnR3p3QmF4TDN5eEpr?=
 =?utf-8?B?ZzFuWUlZU3hhVExBUGozdmNrL0IxMml3Vzg2S3RPN1J6SkI4NUIzanhRb01w?=
 =?utf-8?B?QTAyZTcrbDFIbi91ZlVLUkMyRE8vVXNGM1ZZRmtES3pBak9JSmdUNWt5dzd3?=
 =?utf-8?B?NldyeisvYmFiUEp1cCtaa0puWnJUL2lidGJpd3JicW5neTduS3hsL3VoOVBy?=
 =?utf-8?B?L0Y2YVVuK2wzMGZSMW84NE5IWTl3b2haVlhsa3F5TCtyM0orRFp0TFQ0d1Jp?=
 =?utf-8?B?aCt0ZVJha1pXdVgzbVc1cnlzVVJHZENOc3N5UjgybEdNbjlUL3lOK2xuc3ZC?=
 =?utf-8?B?VkF4REVRYThYQ1J1S1IrMHBaK0h4SWpOd0sxNlEra2d6RUprRDZaQWxpRGM5?=
 =?utf-8?B?bk4wamVvNU9vcS9RYStkdUxWVC9LckZtZDJkVzh4clBwMnAwSW1KdkhuM3V0?=
 =?utf-8?B?Q0g2OUxwYThrN3ZBMXA1VWJiOUxKWkxCT295ai9IRG9YUGdCbS9QeHNSOXZK?=
 =?utf-8?B?eDk5ZDNQckZTRkJ3TnZQYjluTStvV0NrcTA3R3p1VWZzY3V2eEdwUGVTVXVW?=
 =?utf-8?B?VnJnNWJOeEhrdVRkMG5wYmVrelNIZTYvZ1NleTlrY1pPVkh2dy9OUngzMmJH?=
 =?utf-8?B?bEZRZ1JnNW8zYnhranFlTnpWb2pTTVAvOHRxdkdzdVNTT3l0cWhqL2RBZmtJ?=
 =?utf-8?B?TERvWlJRREdXclg4WUUxVlRidWJXeFU2dERHdEZzSVVPdDdIeS9Mdyt0ZVRu?=
 =?utf-8?B?VHZDRXpwMUo3Q0xlekU5NTEySGtaM3lueWZQS1dHeHpISy92cWdWclZVeXhh?=
 =?utf-8?Q?gdtFFQ3TymZkZwYd8/i1hMY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8a5f89-f89c-4c00-ad87-08da00f1745a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 10:50:26.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnv8wh2JLSONtYG4N5A2Z/cvnA+GnZZGj0WIZr8lXP21Mj4p8den9etlteWLvhg/08S4epQDIkh+Sh9M30NDKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.03.2022 08:55, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it and return error
> if fails.

It does not seem to be real issue. More below.


>
> Fixes: 1bce6fb3edf1 ("[media] s5p-mfc: Rework clock handling")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
> index 88b7d33c9197..392e6fab0a75 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
> @@ -106,10 +106,12 @@ int s5p_mfc_power_on(void)
>   
>   int s5p_mfc_power_off(void)
>   {
> -	int i;
> +	int i, ret;
>   
>   	/* finish software clock gating */
> -	clk_enable(pm->clock_gate);
> +	ret = clk_enable(pm->clock_gate);
> +	if (ret)
> +		return ret;

Here clk_enable is just for balance enable counter for pm->clocks[0]. It 
does not matter if it succeeds, as it will be disabled in next lines.
For sure failure here should not stop power off sequence.

Regards
Andrzej

>   
>   	for (i = 0; i < pm->num_clocks; i++)
>   		clk_disable_unprepare(pm->clocks[i]);

