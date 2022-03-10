Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F2D4D3E17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiCJA3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiCJA3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:29:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E3201B5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646872114; x=1678408114;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aeuf1mhhr1koVpS+WovCl5660mDjg7jxPA3KwQQKu64=;
  b=gP+9DFB/Pw71XqA5XE73+1GLquOxsl2XegExsCAKpScO32SnXPog3nFO
   IGg615wa/81SaWhf+F9wp7CCa1ZmmyvMEHQ/kbkRH0vbTI1gU7bNiZdmz
   /Mq63x5pwivC0mww14Bm7gWLFJkj8MV6IxCffUegFql9DUWcMckNv9KZ0
   u7rmjjN1XDUuZX2IsK4ryMH44J2PPf/uXcMUA4LJT9s8lcTxWnOtKwP7j
   Q+BukDsQx+/nXg2yRKQy+5I9QnTJxbq7MmhJV5QzUhTIb9w6meRZe/FXo
   HV8z1MegUe2jicLMXDRV3eZu6w/stP7+HyzYfMsp4uzJUVHHkH0lmK4mI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="253953211"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="253953211"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="513754746"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2022 16:28:33 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:28:33 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:28:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 16:28:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 16:28:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSwvVORlAq4wsFod06CD57YzsFMIZrtEqtdriFMM0geyryibQCQQa07YQoPtfwwUjp3b2R2/032g/9ySRh4IETr1+XiZsfrHzLJCdUwmp/SXBEXNL/bZNs8eAxOKTfcCYWidiXVsS1YIN7sxrj1rXFvmHMiBleHpoOoxXEuWc2b/AKx+fEDqILof678c3ZouMwb20EF2RzWCGt3k8n5AeSXwjkGDZmfObjt8qB5wG7NkVfhdDKDJU4cwxiJq8uksv19EwLIYVJ4tkbXOiG+teOu4emEDy9CThvX/vd4llY57JegjfTU0os2mQ1CDarN3iNvgfdZRUxj0AbQIlesigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yj+/b5p9OZOlKz/A8QKVqyH2p1JkcYxF+iUddJRG3A=;
 b=k3kUUnA06Unl7LTv/UJW7kXXJ9wU7PCdy57ulsKnaKRe3s9e9phCyAvTWhRZ43vfc7IxqFKdUDczsdIKFFOywqynxD4HvpuczlZV0QQaHPlynM40ggDwCcNzqjw/tPP2+n92SAM/UMLK1sZHY/mJ+9Sq3NH5mryBbOsU6QxKWP1I1TjtziK3nTxpTHMVSfapyk+JVFb9ZSYuDu4sn5tw4Qud5lVse2RRnfivCZ6fSUyMZ/Iz9hDnke4gBaXZdrAi+/py1AI+2f/u0fB2Up5kw3O8GTRIxfnro2BxYRIsNAVA+esb3oGqobc1+s1Q8cPJebHN6WjHBnuN4AD4RuOZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 BN6PR11MB1345.namprd11.prod.outlook.com (2603:10b6:404:49::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.29; Thu, 10 Mar 2022 00:28:31 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 00:28:30 +0000
Message-ID: <8a8f7205-32c1-0618-a29a-c3ef66357681@intel.com>
Date:   Wed, 9 Mar 2022 16:28:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [Intel-gfx] [PATCH v10 3/5] mei: gsc: setup char driver alive in
 spite of firmware handshake failure
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>
References: <20220308163654.942820-1-alexander.usyskin@intel.com>
 <20220308163654.942820-4-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220308163654.942820-4-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:510:5::12) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ffe414c-366b-428c-160f-08da022ce739
X-MS-TrafficTypeDiagnostic: BN6PR11MB1345:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1345E6D4DC2C6135A1E6F9B3F40B9@BN6PR11MB1345.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTuPVS83bg/0H8B8Ni4ZbfRITbiONP8J3Ae5gi7WHj4jfg18rdnsoIgkCUiWvRnn1N9MJ60pjzdO0uQmlfYhIy3LwAz7dmfNamhyeVNyL6fMuGRwItYUwAP3iieuoQIkYjBauGuE2mW/CDzS4G+IHWr3yGPVPBKkotnv/+AvezlWqvfGqb4oqFlz0e9pzyepontBlTeQx0M4QPBvrB0iyIJP+PsoLwQ21kI5KmyzGXMvL4peUa7Y+tNm/JsEiLMnTx/0WfkLiqWu4CZuMSkbsKNfqqmG03t9XtYD8P61PgSUAo2n6BsdfItqzZ9NoHfbt0TISKKh+bqgmW3OAe3EV6kuyPAAFgZ9TsGwfWc9BcuQFzKN7hzUi6ZwJeNLsMx9JHfhpXNPtigfLMHl3bAMgNSBlLGVHz1W29suSnhdL29Xvq2heJmY9vcs+GDSVf6ubOT7+a9olfdZqgQ1moc1Wti3t7KyrYd09V/wRgYsVEZb/LnXCT7KCbkHk354HN4UfzruZxe8YaX4dXPLh/9xCvVRyaHvAEAvJVX824vefR5tQeNStKlJWzpbON0c4BOmD7G/1SwBOX1oTEWTUmLVZEt3zfis8NT+pI3zsyBUgnK7ri7BC+3YDdq4z2EC7B3ZEcUNrqncompCYckWgqYkis6POaoECcHB9C8a1IBRAwN+Ha2U7kpIggv1R2aB28uF4fv2o8GhjLoqP+SUelv7VNvGbNYma15wizJc07Q57W3zHB8l4QKEyw8kg4K0Pi5V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(31686004)(6486002)(110136005)(54906003)(316002)(4326008)(66476007)(66556008)(8676002)(66946007)(8936002)(6506007)(5660300002)(82960400001)(26005)(186003)(2616005)(83380400001)(53546011)(6512007)(6666004)(36756003)(86362001)(2906002)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENGbm9GWnExc0RwczAwQm80TUxaT3ExdVpFbFBtcEZmNFJZM3BkT2xVQ2lr?=
 =?utf-8?B?NSthWGozT2NGMEcwRUQ2My9zYjFKNHNBZ2N4cTgyMENLRmttbG5MUkplK0Er?=
 =?utf-8?B?Z21MMGt0eU0vU1hrVjBIMDVhbFJieklFN0RnUlJCTUJ0Q21aT016N3dnTEQr?=
 =?utf-8?B?Y1VPVlc1aWl4dDVjU3NCSkpIZWtRSERFQlNkZEI3MkZmYU9PYlorUWUzSDc4?=
 =?utf-8?B?WXJLVVdvanBzcDNGRjdtdzRLc3RwZUQ4ZHROU1FVeHBXS0lOclJBRWJLQkxi?=
 =?utf-8?B?MjRNT25jVjVNK0VlciszYVhLYytyVE8vT2pTSldVa3hGN0p3U2E5M0pqTkUy?=
 =?utf-8?B?OVI4dzdnLzFub0t0d090c3VpV3JETCtKSlRQVWtEYllxVEZuQUpDd0c2VEtO?=
 =?utf-8?B?SzUvY2htdVpZWk1CUjZFVGVjUTVlTEVHZ2lhQ2wySTlOcngwdUpDTTJ2MmZS?=
 =?utf-8?B?SC9FQ0k4T0k3Wk1KOVUyUHlkclA0T041RDV5Y1hZemVNQ2s5c3puS1g4ZC9Z?=
 =?utf-8?B?WTRoSEJDZUFrZzFOYS8yRDRnOTBSMVRlemNwQlFtd0xBLzM4bWhWZmRHMDht?=
 =?utf-8?B?alhzOUFadE5RbHFFSjBmN2tNa3FHNmdGaXc3bWRKMkNlS1p0NHlYNGpYbHE0?=
 =?utf-8?B?T2JnTHZ0OWZSTVkzWTZlOVI3UUI3VWJKUEFYb0NYL1ZubEdOeXdxSkE3YWFo?=
 =?utf-8?B?Y1lTa1IrVVBDdy9GZGhjcWx1Zm9TYWh2UmZjR3g1VThvcDdZVytjNnNGaUJr?=
 =?utf-8?B?ZjNreU5TYzVrRHp6U3YzaTQ4RXIvbTdtOFFlTDlLRG5FYzhoeVhqT2FkdTdC?=
 =?utf-8?B?SUxJNys3L1hWWnVLNkNNTHZpNitRK1k3T0ZlSHNPdUEwY2JzVzg5b3ZNcnlT?=
 =?utf-8?B?VVZMSjZrcjNEL3dTOGVXVGhlUGRXL2FFWm9DTEpDelRiNVFNNmxZditvdktP?=
 =?utf-8?B?S3MvYVYzdnZ1clhqcDN2OEtNNmU5WHl3YkQxN3pIU25qQkNzdGdvdkg5V2g5?=
 =?utf-8?B?TWh0ZDZQdm5IdVlqSi93c2VwR21mc3VIb3Frem4xbmxkQUMzNlM5ZlBzdUpr?=
 =?utf-8?B?bHhFNlJ5d0RIV1haV1M4NzI2dU9Mb0RnbGlGV04yVEtEN3J6Zkp3TWpWV2Rm?=
 =?utf-8?B?cjY1SE9QU2FJVWdmdE9UVlNPRThWdU03b1ZuNm9VbXQxYVE5b2RIYW1VS25T?=
 =?utf-8?B?UEZKd2Q5S0U5cVBqNHUyZm51VG96SkRSTms1K25lQjhxWCtlbFRDMUNPazBN?=
 =?utf-8?B?Yjk0azBhSnJOZ01QSURSdlZkeWtiK0lJVVJYbEdHZ3ZoK1ltRVNvU0RaVyts?=
 =?utf-8?B?NVM3dXJGbFA5c04ySUEvNmtyUWJ6ZzU1YzFtbDBMajBLcWxFR05BUWEyb2lG?=
 =?utf-8?B?ZE1JbnZlR05oekExZXdtMFp1YUFZdlZidy95cmtOWWdkbkZvQktDNFA3MW1R?=
 =?utf-8?B?eEoxUHNGVThvWC9xb3BYcENveGZDenBKdWlqK1dwTVBKMUZEeklIYUNPbU4w?=
 =?utf-8?B?UWV3Um5NeGdSU29pOGllSCtlZzl3WnpNRm5TQXJQOGZhd2VERGNLVDBJRmhB?=
 =?utf-8?B?cHZtSXlmMnEvSXBIeXh6ZkZJcWhYTitUelZnTGRrYk1NL2JwcDlxTXhVVlpx?=
 =?utf-8?B?U3VVZnR4d0RXbDk4aUVyYWh2YWlZTnBpa2pMbzBncGIxMGRSaXZKalVOY1Jw?=
 =?utf-8?B?dE5oQnJHR0dEWndWZXh3VTZUcUNmZDlwZkYydDMrbEZTd0NOWitwWHNVSEln?=
 =?utf-8?B?RklWZTBRaXBPWUJGRHJRVnhsUnk0OERBeUJSL0RZWmpyeWJMcDdQTDhoVTVE?=
 =?utf-8?B?ODdXSlF0U0RiZStjSkYwd3IwNERSWmVjMmg4QTFLV20rRG13NnVsYzVpbXNU?=
 =?utf-8?B?VHFQY2VVNWFyRnJjNnhxMU0vQXJWUWNXcEZiWGU3cGZlRENILzdlLzBQNldH?=
 =?utf-8?B?L1QrczdHNVVJZC9rV0ZObnlXR3ZoWVgwMitneWo4RXA5Sy9IVWVWZ1dwU3lZ?=
 =?utf-8?B?VmxGbmZ1K0svZFBpQTU0ZWZwSFBPNEk0d1loWTA4WmFJMGlOMEZDVytqQml3?=
 =?utf-8?B?U2JRRFVCeWlJQlZKUVVoOTBtWVBKNUpwcXNDQzlwcUFZWUpCangwdUNZM1F2?=
 =?utf-8?B?T1c3ZTMvMFlEaG5QdzVCVUNSbG9QUVZieFI5LzlIV2d6eU5qVE9PMDVaSVdQ?=
 =?utf-8?B?RVRaRGdxNVFlYjU2RzZVUzEwZCtrVjgrcVdCSXNxNVRJdWlqUFpheUI2eWJ1?=
 =?utf-8?B?QmlWQUhabENoelpRbjZYbTVYY2NRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffe414c-366b-428c-160f-08da022ce739
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 00:28:30.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLagAZEVRRqiBlmOIPU6XVvgbGZO2cHGPln0pbO+tzl0RTEa86jZwHC7MBKrwkIw3+NjwStB+l7k/CSeP+NAx2xiCgTOfou89BS1BLlj6Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2022 8:36 AM, Alexander Usyskin wrote:
> Setup char device in spite of firmware handshake failure.
> In order to provide host access to the firmware status registers and other
> information required for the manufacturing process.

IMO this patch should be moved to after the patch that adds the logic to 
fetch the FW version, as that is interesting info for sysfs. Not a blocker.

>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/gsc-me.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index 0afae70e0609..cf427f6fdec9 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -79,11 +79,12 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
>   	pm_runtime_set_active(device);
>   	pm_runtime_enable(device);
>   
> -	if (mei_start(dev)) {
> -		dev_err(device, "init hw failure.\n");
> -		ret = -ENODEV;
> -		goto err;
> -	}
> +	/* Continue to char device setup in spite of firmware handshake failure.
> +	 * In order to provide access to the firmware status registers to the user
> +	 * space via sysfs.
> +	 */
> +	if (mei_start(dev))
> +		dev_warn(device, "init hw failure.\n");
>   
>   	pm_runtime_set_autosuspend_delay(device, MEI_GSC_RPM_TIMEOUT);
>   	pm_runtime_use_autosuspend(device);

