Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD15AA174
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiIAVVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiIAVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:21:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D869F7C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662067261; x=1693603261;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ugBJibf4SCjgWuLwtWVE53+f0X0wcnjHd1mQhpbWP6A=;
  b=FQ66KTD13PeOSFTUmDLLKFDyiQZcfDP726jT3hKYO5RTsRH1DcOLAlCi
   JA6JyVi8gPbLvgEihIXLWHYup5cyUgWhIpdtyKTDRcoNmOfwBC+bGoAD7
   mYSFElxE0Y7oFIV0j1oKJQpDoDLzpH99E09DMnVwccFX0ZKjcwYWnnaEz
   Y3XvdWHEr4h8Ru6c8elrf8KeWjYqCAIcVmLZCid2f3DytcBG0KYvjgh9y
   0G6grmGfXlJW6cXEbZruB1PlkCvqkvUyh5NpKAqUK26uo2saFlR/5Dl9p
   YNYknN31771SQFuDyUtoNoENhhzCcXs+MrIb6q3Fbm2sfShY6in6owaKD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276230124"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="276230124"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 14:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="674052508"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2022 14:21:01 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 14:21:01 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 14:21:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 14:21:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 14:20:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDP7xJaXzyBvMrNIv+FKqWwPMQDDoeMSj9ItzWzInbqnZoP7ybNaw+00rTGFkhqHPP2PNIBHiklfvNyCPz+aKPqgO2+bWG6wQ6OEqM9+vjRuQ/4bf3S5PWN9WGHwrLeIW0iH3+TghoHENhJp3QRHciwegqLD4DbuEKCAl8XuRhfCPOM7i3feKGGp0EnQmjsJM26J/QhT+JGUnAa5kAKqsBV5gc5LXpdnYYG6JU88oJKb/ANbvnvOA4JN5Y+1LrtRS1ARjnniARjcFWWsSWdhacNXOvYp3KnCiYdh+mfMRecTNEeHwgaAEMWBY44f7M6h6Y+IQMjbVguY264ZLJkNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DocsBQCV3n+cXcqd9eQ8zs7whJ4vGDBuuMcJu4+D544=;
 b=k7bN/GXVxUdpOaY6WrF+9Eh9E3E0wEuyJ9sY8KbVPKxIhPH4ab3DNTZUKHFqikkA3uc5hOmA7Q5qEJsO7KKRUD/W5qDfudmt6NFKn7Oggm3R8VkoHIywaZoBkYTcNxHQn6A9LmxVdgBmVLwB355GZnDWYiIpWf+i9xVrUm5AMrGxaEVPp3lrBUhgukGJB4uggKEfLGt7O5DwB4RG2DrMWnYtWDp23mrLZshtDrnjC1FHsZIbbZP4LenDMoTper5dxrbCxXTYpibvB/HCVI9zTf1MOZdHCqtWA4lXkl8Eqp4SaIrVotV2b45UQ0pBd+2Dqc4WStV+pXvo2Oh8fqjtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 DM6PR11MB2553.namprd11.prod.outlook.com (2603:10b6:5:bf::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Thu, 1 Sep 2022 21:20:52 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 21:20:51 +0000
Message-ID: <529143eb-6d50-7dba-de63-cccef05b898d@intel.com>
Date:   Thu, 1 Sep 2022 14:20:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v7 13/15] mei: debugfs: add pxp mode to
 devstate in debugfs
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-14-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220806122636.43068-14-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ccc442e-2e5e-42d0-90f2-08da8c5fd904
X-MS-TrafficTypeDiagnostic: DM6PR11MB2553:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5gUIpKQfXic6J6xZLA55PBCV55QXHuZIGVdYU3sBcHJCvpsk4cBRim6Ni1ALeBLDkpxhkxW6JEU7gV00Hm1WSWiApmnzEXEZWNVrRgt06DzsNQHb4c5nxJZ0PspkfSjYvOcJ8O14mM7i97qqxEEj/tEX3J1n6EFe9Og2Ne3QyFjPPaeazuzEiG5oWHVuihkp6S18lZE/46KDzVWpIKIripVk39IjyNRYVl9EXKZZ68P69MNfUPV/Sn/IGxmMFM25MlQWzEy/Iue5HDJ0xIociDz7BxKXQhxuoiqrc1ByI9IRCXNPRnXIHLxNk5ehrCatkyEiFVuhrvwRXeWFbRaq4YMGhHg7OiPBCBtrkVkUMIu4tUgFi0TeEMDDrLJzMqoR2EU4TbQsIq428J72ysnCRO0sFBlWTFTVfG32WYBM+8TzMh9YiqkVkn/J9sArP1WppKptdf2VFQ14VBT1/G0B8K3B+nfs1AtXKFlXmuzuTuKM/bqx6YaCnqyNxKz5HqriDD1nGmBPBQ4l/SX22U//cVeihD2K5rTJfGUxs4/F09+HFm6LX3beYH0Dkdf7cYCRaJzErxXf+zJi6Ks8dEO3MC8s5tPXuv3cWjKFsiyF7oeSfyLCD/GSdQzooMAYdrQmt/bctd8QoeTcZPQszhfT6FF3omW0ZaDbqM19TYhe2tpV1M45udD07+DafTyFgzsU+fEpFX7239xmj0TOKd54vvUlO9W7GfnHMgiLXQ90G9IL51HFyalhsZtMQcLm+IQl6xYyQ1OiibAT9UKlmvY5xOrUINoIAHjQQkDpLnqLt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(346002)(39860400002)(31686004)(36756003)(82960400001)(316002)(8676002)(66476007)(66946007)(4326008)(66556008)(54906003)(2906002)(110136005)(53546011)(478600001)(6486002)(6512007)(26005)(38100700002)(107886003)(41300700001)(6506007)(86362001)(83380400001)(31696002)(5660300002)(8936002)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitKUkNONG1FbmIwd2RQbDB4WDN0SFFJcEU5dDRnUmI5YjNaQlJ3RGN1TEV1?=
 =?utf-8?B?S0lySmFVeDdYSmMzWngrQ3cvZkxtOElhNkdFd3VXRDIyUEYwaXNwdW9xeXlv?=
 =?utf-8?B?NUVFSFNrVWY5bmY0ZGc1V1pYaTZJV3JPRytHemMxVEZzK0dVVnJGZEtMRkow?=
 =?utf-8?B?STJ6R3EyUzVWbG00bnUxbDJFWWJMVmtPbHNIQlFPb3pFQ1VLejFZUDZBTjhu?=
 =?utf-8?B?U3Y1UFExdVFHTmpMemlMVVVhWXR0NW5sbkJCRVBBblNBbmNGaWF4a09IZ0Nk?=
 =?utf-8?B?bWptVWpZcURvUzF5S1phSUFId2NyMTNBdkpSZE01bjdVd3JhTFlna2ltd2hP?=
 =?utf-8?B?ODNDU2U0bFpEcW5EbnVMNDUxc1ZoejVtNFEwdWErcUtKR2xkc0dVQ0RkVlhy?=
 =?utf-8?B?bHZyZHZtMVlSUEZlZFBTT1paQ2hGNnNucjAxM3ZOT2hIdXIyckgraTFsYUo2?=
 =?utf-8?B?OGFuVVdnZEdaVDFYVWNBOFcxY3pLL09xY3M3cGlhSm9HUE5pTi9TRDlrMkFO?=
 =?utf-8?B?UVVJeGhpWHVIenQwQ1JhMThuTHYyRUJuL1JRMmQveXRRVXRRZ0Z4NjNyTW5K?=
 =?utf-8?B?RGN6Witld3g2MUFLekNPOEowQUpvMW5vd2RuQ283OFhRR0l3UDE4M2w2bEdP?=
 =?utf-8?B?OHRaaDAzRW9SUWdVVGU3Q2ROcDlFNWt2N05ZV2hoRnZhM2Nmd0RrUjg3RG91?=
 =?utf-8?B?MXhwRVFKS2JRa0E0UktvZlBMVTFMUkRJam1IT3FlMmZpaHdWNGtrKytXeStu?=
 =?utf-8?B?aEtvRFZhbEZwYjJqTlN3WW5zdUsyWlR5aDFCZ2pnQ05pVFFza0VRZktEK2tx?=
 =?utf-8?B?a29VazB1Wms5VFZ3OTNSQ3RmS21TQTlxV3QybUgyeTlMc3B0R1lOWEhycTJE?=
 =?utf-8?B?endWdlVqUW10cFNxaXZoT3BjQm1HMXBIcTA2dVNBeXBXajUyazNFV2ZtR2Vl?=
 =?utf-8?B?dlBEMjRuTWFrcTJyaHovdFZwZHh1L01KNlNIb2FrUExqKy9Bdlk1YnJDVFZk?=
 =?utf-8?B?cUpwZkZkNFMraFp1VXFzblhFOXUyeDZvQUc0ejRHaXlNKzhCdC9Gd2hKWE9a?=
 =?utf-8?B?Z0dKdE8zUjExaEYvKzJZQmJMbEt1ZFJIT0FXaVBFcXV4Y21tSDQ0NzBkcDF0?=
 =?utf-8?B?SmUzY3pwaDQzMFdGMGN6Z2p0Yy9ucklXcXV1dE5hSThGVWoyVW5odGV5WlB5?=
 =?utf-8?B?MkxTeEd6bzdzTTF0QzlSSWdEZVFPYVViU25MblZabHlFOCtBeTJ5Qkg1bmx0?=
 =?utf-8?B?Yk5GK2IzZVFLeVNpaHk1ekY2OHRXNkxjZzhzaEJuTDJNeGNSZW9FTGFxWjFm?=
 =?utf-8?B?VnJia05oUVZLOFZxeDhKZElVS2ZlKzlpc3lrcFMyaDlSVkRNWGRYS2dYQmlS?=
 =?utf-8?B?L2daS28wKzQremt4ajNrWVFHSEI5MEF4d09LNEJtdHVRVTdzZkpsL01ncVRE?=
 =?utf-8?B?cUJJbzc3ZExYaDByMU9YaUxaTXZoVGJGMGl1OFBWSzVKbHh1RzcxRWswV0tt?=
 =?utf-8?B?K0prRlMzVXNQWko1MHZvdkNxMUhreFVIMUpwL01ySlBvSzkyZS9OQjdXOGls?=
 =?utf-8?B?V0xZdGdOVmpheHBJVGxJVzJOUFVRdXV0Nmw2TmQyaTdOd2daMFJnU0hjN1l1?=
 =?utf-8?B?UjZsL0FJVnBLQ25BZk12T3hLTHFmTmplN1BBRjN0K0txN1k0MGFxLzdyVURy?=
 =?utf-8?B?RFVBa2oyU1oxd0pvQVB4N0orWUljNmQrZ2N2L3pjRngwRGZjU0hyZmdPRkFw?=
 =?utf-8?B?MVVHbEQyUll2Unl6ek9ReWo4aXloZTlXcTBiZTYvcTRFdUsyc3dscEZrNTRD?=
 =?utf-8?B?RnNrc0h1Y0Y4TUNoem5aT3F6alVNNW5ZVVNyeldJbGJ0MEVKREdna1dNNzhC?=
 =?utf-8?B?YlQxaEJjMVgzOE5Qb0pmLzh3WDRyN0NmcmxlTy9uK2txbEg4bFYyZ21uU2dt?=
 =?utf-8?B?aHlZVW1FL2RYWXcvbUFCMDNjd0Qzd25JZkUvTWVWaHZFYXE3ZFZIelUvMGV5?=
 =?utf-8?B?Qk00S0RPMWZIT1VvV3p3bUJKTm11V052bEtOUjN6dGNLblpVZTI3WVZDajlN?=
 =?utf-8?B?NFl2RmN6Qkdzb2hJRUJWVXA4TXZ1S0VxVjFKekgwNWtKRHpRTWlpNmJYV2NT?=
 =?utf-8?B?dE1vbHFuWGdNalBmVE82Ym9Va3N6MFRiWVBKT3gyWHg0dmlBN25peFdQOTMr?=
 =?utf-8?Q?t2uvOkvETs+q3YrLXGQm0pY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccc442e-2e5e-42d0-90f2-08da8c5fd904
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 21:20:51.8491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db76fRtB/lL0bWzVzz0rYhwMUSVZ3nxvoClHXP3IKKeHP+hbjfBkvA7lE3RbxBajn9XlUQrPcpOC9QdHzzE+5SBY7mVyZ/yCip+SWXMIeJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2553
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2022 5:26 AM, Tomas Winkler wrote:
> Add pxp mode devstate to debugfs to monitor pxp state machine progress.
> This is useful to debug issues in scenarios in which the pxp state
> needs to be re-initialized, like during power transitions such as
> suspend/resume. With this debugfs the state could be monitored
> to ensure that pxp is in the ready state.
>
> CC: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/debugfs.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
> index 1ce61e9e24fc..4074fec866a6 100644
> --- a/drivers/misc/mei/debugfs.c
> +++ b/drivers/misc/mei/debugfs.c
> @@ -86,6 +86,20 @@ static int mei_dbgfs_active_show(struct seq_file *m, void *unused)
>   }
>   DEFINE_SHOW_ATTRIBUTE(mei_dbgfs_active);
>   
> +static const char *mei_dev_pxp_mode_str(enum mei_dev_pxp_mode state)
> +{
> +#define MEI_PXP_MODE(state) case MEI_DEV_PXP_##state: return #state
> +	switch (state) {
> +	MEI_PXP_MODE(DEFAULT);
> +	MEI_PXP_MODE(INIT);
> +	MEI_PXP_MODE(SETUP);
> +	MEI_PXP_MODE(READY);
> +	default:
> +		return "unknown";
> +	}
> +#undef MEI_PXP_MODE
> +}
> +
>   static int mei_dbgfs_devstate_show(struct seq_file *m, void *unused)
>   {
>   	struct mei_device *dev = m->private;
> @@ -112,6 +126,9 @@ static int mei_dbgfs_devstate_show(struct seq_file *m, void *unused)
>   	seq_printf(m, "pg:  %s, %s\n",
>   		   mei_pg_is_enabled(dev) ? "ENABLED" : "DISABLED",
>   		   mei_pg_state_str(mei_pg_state(dev)));
> +
> +	seq_printf(m, "pxp: %s\n", mei_dev_pxp_mode_str(dev->pxp_mode));
> +
>   	return 0;
>   }
>   DEFINE_SHOW_ATTRIBUTE(mei_dbgfs_devstate);

