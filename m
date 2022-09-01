Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABAF5AA154
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiIAVC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiIAVCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:02:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06302673
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662066169; x=1693602169;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4pnWsGKM3AbFBAiPQAgqjVOjeD8oJO0SKDZgCMyB9zA=;
  b=nduEX4aePAKR0cfm/EoS/9cKmphUWkup+Q0Vf+KrT3BLSHp2KHqgOupR
   XShXkEt0wQpMAVHZag3vl9Mruu11DpgIU3+VWIm0Stld6KUEtR06QSiDl
   Mm++/GoAglJB4i25y5axlXL1jDOjoS+j0bjq7Z0bnmocOvBAUy0yf3Y2D
   l6o4BMG2FI3etQrAkeEryyOpt9d97sSA54oqrxKVHYviG24VaYNY5UJye
   ZV520Ch4BFknbbG20+5AfjGU9meYrGJuChbnqu7ssL9vCDwpxyoN1/CDT
   Xr7s1CSoQtl/PxkaXxQEfgom2CFjIccpD5O+hLcAO9NuL/qu8rNAJWnU4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275574004"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="275574004"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 14:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="612656819"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 14:02:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 14:02:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 14:02:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 14:02:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErHqOtUieGsNvMMVI3rGT3dZDyynBEUOhuGxHuXgHrHurkinUs2UqGeHdebTpMspMj9ebN+Z2AiGqEdoz9ENc0O046M2etSyk+Mca1aa8whrmSl0Go4AvizsUErt3TkHZPktJQNebXDlTuZ3hjs6Bdot3PUqy3zKKZA3AVpB3ebsZ7519hKySNP9+WNyBm1nzHpQRm2joFoXU7VKwHtw/Rxy3p4QRqOi75p63pQC0f/AlJdGErxLxh5VKtPguPkisL4uIVnfDB7AzsQTIQGQcp9vY1n+WG7Qy8aAILDHufKVAKvcl8hsE8IJzrYtitVG1M+0oJWqqVlCcsUYnmiIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=852tJ+cXrBoIaGHFqd/2Y2KCKh/zGt5L9Wczq/VIoe4=;
 b=RTuRqqlEQEMOxluyrvirYN8uf42ESvMkv1hLNN4gvoUX4Dh8bYZ45m5UIVzbOOogBS4a2wIFtMjofoZ8zSRtHcfPc9HMJZ2U1zxp1qoxIERr7GcmqI8dUbkD3o4NdForcJdRGjwjkBQuyEK+e3r3dcuE8wDsPzrO8w9NrcG3lx9SI8X+7v4lTlwY7iSA5Zb3cXNQS8RSi4WuBmElwFnUn0mu6YEffghCgLTWbIxdNOvF+88FAVdKWpWtbFk/AC9ysoQNf/r818ca5SGXk0j5R8FDwCRzJ+YaQKja/UcvpJuEPpt4gI6LTOGU/xT8yPig0vVOGkVDvpEriFmkW+yQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Thu, 1 Sep 2022 21:02:47 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 21:02:47 +0000
Message-ID: <e2296121-1f99-5bd2-2a80-a24b029bf4f3@intel.com>
Date:   Thu, 1 Sep 2022 14:02:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 11/15] mei: gsc: setup gsc extended operational memory
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Alexander Usyskin" <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-12-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220806122636.43068-12-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53e6da18-5809-4bc5-3c31-08da8c5d5259
X-MS-TrafficTypeDiagnostic: SA0PR11MB4686:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JwGEljPFtwLMDoHVwi+JHnOh2Ayj+U5e8Uj6CeZ1wsvoF3szcHHhDsG4czOECuOK7NT01lo20UafvMpMQgOWuKxq83vWREcijZ1a506XKeNJ4/xerKI0UwicFdpu6GMe4rin4wFuRJ9qOxLXxuC3FWm9A1SwGPgcdlZzF8dDj3f7b/3z084FBwVrh3dSI8tYmXNWOh5l+T4Wv0ghVrQKnqTp6HuXp/3meaBSAJnbD4EW42K3QClK+W7bNJzwEUSVNmautuECN3QTwxyrDlGkgsAus9U7+E/Pocit9ZsEaLlxn6u6ZAsYMlXj5m/PJHUiKxdqIlgdVAtFbg+jnbz6WV1lOz3/osJlLVmXWRikRDqI+vfwmRIeALQFDuZI0vDopFQPK7IjmYwRLosEkxVz+79DO1UMBm84jZoMlysFj1EhGeu8Qw07J2yxvSGRSR5aeM7LxkHO8wf+FH4xz0sRT+bkKZ5AwOVt6WdOESNABOazsY4JGiXvaZsTkhUycS/vOtOa47BuB7XQsquirmbD6RMPJz0vgOrA1kdv7k/mlvA5fu/ZQgqDbsXIZAaMz8Hn6UplaA8aY+rBulSb/eM5+HW6lEfGXyIMHGqhwWGeGEvhjaXfcMxRtg5EcGMIiUz5gUKopVALOweaVdmmqTLz8GkNjJ6g6eVImeZ7QH63htjPtXWXONEFZEJExeRo+c2GvHBCeNG2EhAt8z1Xb0MmbuYBB8G1/l+VjSKL4L+mrHJD68eXk+XMxpGi6UzRItRj5NSrW3DYe3qjLG7385Z98/DciqO58e9aRHbRbl2/Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(346002)(396003)(376002)(82960400001)(316002)(66946007)(66476007)(66556008)(4326008)(6486002)(110136005)(31696002)(8676002)(5660300002)(8936002)(86362001)(36756003)(478600001)(31686004)(54906003)(41300700001)(6512007)(6506007)(2616005)(26005)(53546011)(38100700002)(2906002)(6666004)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2Uwb1RDOUFscDhSY0E3RWZlN2o0Vy9pOFcra3V1STJCeXN6UzZ3eVNEbE9o?=
 =?utf-8?B?MmpmbU13M3BGT0xzVXNtT0svN2tKU3ZsYTc0S2xpdFFqeDJJbTFwNkFjUTJC?=
 =?utf-8?B?ZCtwSlVmVXVYdlY5NWVRcGlpZjRvNXNoUjVBVVJhdUl5NXVqczlFaTFXRU1P?=
 =?utf-8?B?U0cyZm5pak40WjlGb0l5a1htTXlHU1V3SXhCdHZYdDI4bUt3MS9tNCt2VmRD?=
 =?utf-8?B?MGhRTkhwcDRkNjFMb0l2RFYwcVh1VW9wbXlFS095SDVKTFFjdmJESjluQVVT?=
 =?utf-8?B?Tm5OT1E0cGpvRG5jdmgwVytqendZS0dTSnBYUWhubGpxRVE2Zk5WRjlKdmNH?=
 =?utf-8?B?Q2M1ZHlpMzQ2dmFnMUJZR3l2ZisvRkIzVUYxTUhqdlkzdWE1TjM2Uld2L256?=
 =?utf-8?B?M2RPb1NyUWVFTTU3WjNVVi83aE5IMWFKVTJFODV3TG5mNWdGa1Z6am9Oeklw?=
 =?utf-8?B?MlQ3MUlpbXg2L1JBWGRTV2RNM1E2Ny9VdytaLzBSNEswVmx2azRXaWsvb3Qy?=
 =?utf-8?B?NWhRcEx6b1NFVFhwTGQ1L0Y4TjkwUE1Ra0ZwZ21XVmh4U1orVGY3bTFkL09i?=
 =?utf-8?B?OWtNdUJ1YUNYSjhQUlc4OHBhMGppTkRqVThMVHlHYU9GaDJ2N1UxcHpTS0ds?=
 =?utf-8?B?S0NMajRIV1R0Rk9FaVBiam9RNW5yWHNVcVUySVRRaGJmKzROQVE2WHJ5Lzhv?=
 =?utf-8?B?YUtKUDFmeVp5eXZ4elhTN0R6VVZsYzNueGVBTlVSRG81QmRMWmpPUEhqWUJN?=
 =?utf-8?B?QW9lN0ZhNGJlU0c5NjVvSnlJM0VkMFN4MlQ5bjZGcXd3SHBDTXh1anlvWTdF?=
 =?utf-8?B?YWJ1WUUwUktVclI4Y21BU3E4dFFjMmhCMW5obDdsYkRUTjdBM1ZpS05hdjFl?=
 =?utf-8?B?NUdLcWxVSW5jYzViTCt5cDhNQWFrTER3UHY2MGh1WjFGK1JwWW54OXpBZ0JB?=
 =?utf-8?B?ZWlLVlp1S0d1Rkd2M2QwTngxRGc3U2ZNWmtEcHpVYTExKzFiaS9UUk5iZnpP?=
 =?utf-8?B?SExlZzN0Z0tZS3hCckZUemxlb1MyVnhOYlFLUG16aUdnRy81TlFSdGdjS1VU?=
 =?utf-8?B?aHlHOFpJamVSOU04V1pIU1ZQejc3cTlEKzZDRk5KT2dYRllndmxHRFdjQ0Ir?=
 =?utf-8?B?YW9xS0plVEEwU3lENXhxUmRCWjYyZis1N0NJN0lRc0loRDZUd2d6a1owOUQ4?=
 =?utf-8?B?R2lXaDU1aWltMWdZWDB0aFdEUWI0TGUvNmsxMjlzNnBHeVloaGVRY2NkM0NR?=
 =?utf-8?B?MlVaSFh6a0ZQclNwSFpGbnVud3pnL2FqaE40ekNDSHN1WjFncEp6OGYxeCti?=
 =?utf-8?B?S2NzL2tTU1ZScUlnNkZkQTBvNGtlb0orRkpzUFYzZkp6VUgyTk4wWFl6TzA0?=
 =?utf-8?B?b1lrVW9TZTQwTDBJRzlJY3pZRUpmMXdVS0E4a0dudVQ1c3FBWUVWbGpFWHlt?=
 =?utf-8?B?aWJ5KzYvZEI0eGowS2pkbnZtcUhjNWM2WHdXY2poWTRpRnZXRVJoalZHWitp?=
 =?utf-8?B?eWRESndLM0pmdGw0Tyt4bk5ZNGp0cVc4blZMSEF2cWF0dGNuTFlIa0hOMkxC?=
 =?utf-8?B?SUlabndaWkVwczR3M1VaLzhQZWFDUld0NXpQaGVCOXVMUHdzb3ZlOGQ2S0dP?=
 =?utf-8?B?VjVmTVA5THVjQlh0Vy9QMktTSkN0YmViYzVjUjRTeHZuM3Q0QXJWSytYcDJq?=
 =?utf-8?B?M3VmNU5qRThuQ2tmZWhTMnphWVRCbm1CRzlOaThZMUQwN3pkZUxuM0pXQ3BZ?=
 =?utf-8?B?eXVGOEtjRStveGRGWWIyQTRTdFB6d0FRVWRxYnJ1OEg1eHd0MmM4MVErSnNQ?=
 =?utf-8?B?Yi9Ba3AxMXhISThSelhpMThQbzhQSE9uMENrYzNKYWxCQW51MENYR29qRTIr?=
 =?utf-8?B?Wmk4MUxyK2RBc2RNWnVRbmZkcXM3YTJkclhjKzJzZDROMjB4bm1sWGRnUjRt?=
 =?utf-8?B?RnlBVytyS2d0ZVZyRVJSRGpYWHdFVEN1cjI4bVhYUjN2Zk8zNzc1dThzM1V3?=
 =?utf-8?B?STVyem1NdnZuNkJFZTVwSDdWWUttRDJEcDAzZk1RbTRsTndCVlhNNXFGT3Zm?=
 =?utf-8?B?NWV1UCtxZmIrbEFtTUhHSVVKc1pwd1NodVRub0hZNkdDazJMMVZKNE9vdlpQ?=
 =?utf-8?B?YkFGY2VGZE5wVFpTWnlJRmN5bjBaNEpIUHlLY1hnRVI5Q1RzTEFRNHozcEZX?=
 =?utf-8?Q?+l6H7eiV0oBjNKvCKKXjjfY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e6da18-5809-4bc5-3c31-08da8c5d5259
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 21:02:46.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQPpL2eUnDdTFrsbI+5G4QF4L0QmnVO0qIJp2yeizMVnht1g+d7wTzaOxg+RJWOEwkbgEllJmGQ6kdyuZODXVmT0IABwVvgg0G/N8h9I6zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2022 5:26 AM, Tomas Winkler wrote:
> 1. Retrieve extended operational memory physical pointers from the
>     auxiliary device info.
> 2. Setup memory registers.
> 3. Notify firmware that the memory is ready by sending the memory
>     ready command.
> 4. Disable PXP device if GSC is not in PXP mode.
>
> V7:
> 1. Add kdoc to mei_aux
> 2. rename pxp_isready() to pxp_is_ready()
>
> CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>   drivers/misc/mei/bus-fixup.c  | 70 ++++++++++++++++++++++++++++++++++-
>   drivers/misc/mei/gsc-me.c     | 16 ++++++++
>   drivers/misc/mei/hw-me-regs.h |  7 ++++
>   drivers/misc/mei/hw-me.c      | 28 +++++++++++++-
>   drivers/misc/mei/mei_dev.h    | 10 +++++
>   include/linux/mei_aux.h       |  3 ++
>   6 files changed, 131 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 811c94ebf250..b350cc8d500c 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -188,6 +188,19 @@ static int mei_fwver(struct mei_cl_device *cldev)
>   	return ret;
>   }
>   
> +static int mei_gfx_memory_ready(struct mei_cl_device *cldev)
> +{
> +	struct mkhi_gfx_mem_ready req = {0};
> +	unsigned int mode = MEI_CL_IO_TX_INTERNAL;
> +
> +	req.hdr.group_id = MKHI_GROUP_ID_GFX;
> +	req.hdr.command = MKHI_GFX_MEMORY_READY_CMD_REQ;
> +	req.flags = MKHI_GFX_MEM_READY_PXP_ALLOWED;
> +
> +	dev_dbg(&cldev->dev, "Sending memory ready command\n");
> +	return __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0, mode);
> +}
> +
>   static void mei_mkhi_fix(struct mei_cl_device *cldev)
>   {
>   	int ret;
> @@ -234,6 +247,39 @@ static void mei_gsc_mkhi_ver(struct mei_cl_device *cldev)
>   		dev_err(&cldev->dev, "FW version command failed %d\n", ret);
>   	mei_cldev_disable(cldev);
>   }
> +
> +static void mei_gsc_mkhi_fix_ver(struct mei_cl_device *cldev)
> +{
> +	int ret;
> +
> +	/* No need to enable the client if nothing is needed from it */
> +	if (!cldev->bus->fw_f_fw_ver_supported &&
> +	    cldev->bus->pxp_mode != MEI_DEV_PXP_INIT)
> +		return;
> +
> +	ret = mei_cldev_enable(cldev);
> +	if (ret)
> +		return;
> +
> +	if (cldev->bus->pxp_mode == MEI_DEV_PXP_INIT) {
> +		ret = mei_gfx_memory_ready(cldev);
> +		if (ret < 0)
> +			dev_err(&cldev->dev, "memory ready command failed %d\n", ret);
> +		else
> +			dev_dbg(&cldev->dev, "memory ready command sent\n");
> +		/* we go to reset after that */
> +		cldev->bus->pxp_mode = MEI_DEV_PXP_SETUP;
> +		goto out;
> +	}
> +
> +	ret = mei_fwver(cldev);
> +	if (ret < 0)
> +		dev_err(&cldev->dev, "FW version command failed %d\n",
> +			ret);
> +out:
> +	mei_cldev_disable(cldev);
> +}
> +
>   /**
>    * mei_wd - wd client on the bus, change protocol version
>    *   as the API has changed.
> @@ -473,6 +519,26 @@ static void vt_support(struct mei_cl_device *cldev)
>   		cldev->do_match = 1;
>   }
>   
> +/**
> + * pxp_is_ready - enable bus client if pxp is ready
> + *
> + * @cldev: me clients device
> + */
> +static void pxp_is_ready(struct mei_cl_device *cldev)
> +{
> +	struct mei_device *bus = cldev->bus;
> +
> +	switch (bus->pxp_mode) {
> +	case MEI_DEV_PXP_READY:
> +	case MEI_DEV_PXP_DEFAULT:
> +		cldev->do_match = 1;

Can you explain why you set do_match = 1 with MEI_DEV_PXP_DEFAULT ? 
AFAIU MEI_DEV_PXP_DEFAULT means that we haven't even started to 
initialize PXP, so it seems weird to match in that scenario.

Apart from this, the patch LGTM.

Daniele

> +	break;
> +	default:
> +		cldev->do_match = 0;
> +	break;
> +	}
> +}
> +
>   #define MEI_FIXUP(_uuid, _hook) { _uuid, _hook }
>   
>   static struct mei_fixup {
> @@ -486,10 +552,10 @@ static struct mei_fixup {
>   	MEI_FIXUP(MEI_UUID_WD, mei_wd),
>   	MEI_FIXUP(MEI_UUID_MKHIF_FIX, mei_mkhi_fix),
>   	MEI_FIXUP(MEI_UUID_IGSC_MKHI, mei_gsc_mkhi_ver),
> -	MEI_FIXUP(MEI_UUID_IGSC_MKHI_FIX, mei_gsc_mkhi_ver),
> +	MEI_FIXUP(MEI_UUID_IGSC_MKHI_FIX, mei_gsc_mkhi_fix_ver),
>   	MEI_FIXUP(MEI_UUID_HDCP, whitelist),
>   	MEI_FIXUP(MEI_UUID_ANY, vt_support),
> -	MEI_FIXUP(MEI_UUID_PAVP, whitelist),
> +	MEI_FIXUP(MEI_UUID_PAVP, pxp_is_ready),
>   };
>   
>   /**
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index bfa6154b93e2..6b22726aed55 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -32,6 +32,17 @@ static int mei_gsc_read_hfs(const struct mei_device *dev, int where, u32 *val)
>   	return 0;
>   }
>   
> +static void mei_gsc_set_ext_op_mem(const struct mei_me_hw *hw, struct resource *mem)
> +{
> +	u32 low = lower_32_bits(mem->start);
> +	u32 hi  = upper_32_bits(mem->start);
> +	u32 limit = (resource_size(mem) / SZ_4K) | GSC_EXT_OP_MEM_VALID;
> +
> +	iowrite32(low, hw->mem_addr + H_GSC_EXT_OP_MEM_BASE_ADDR_LO_REG);
> +	iowrite32(hi, hw->mem_addr + H_GSC_EXT_OP_MEM_BASE_ADDR_HI_REG);
> +	iowrite32(limit, hw->mem_addr + H_GSC_EXT_OP_MEM_LIMIT_REG);
> +}
> +
>   static int mei_gsc_probe(struct auxiliary_device *aux_dev,
>   			 const struct auxiliary_device_id *aux_dev_id)
>   {
> @@ -67,6 +78,11 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
>   
>   	dev_set_drvdata(device, dev);
>   
> +	if (adev->ext_op_mem.start) {
> +		mei_gsc_set_ext_op_mem(hw, &adev->ext_op_mem);
> +		dev->pxp_mode = MEI_DEV_PXP_INIT;
> +	}
> +
>   	/* use polling */
>   	if (mei_me_hw_use_polling(hw)) {
>   		mei_disable_interrupts(dev);
> diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
> index 15e8e2b322b1..8049f288f74c 100644
> --- a/drivers/misc/mei/hw-me-regs.h
> +++ b/drivers/misc/mei/hw-me-regs.h
> @@ -127,6 +127,8 @@
>   #  define PCI_CFG_HFS_3_FW_SKU_SPS   0x00000060
>   #define PCI_CFG_HFS_4         0x64
>   #define PCI_CFG_HFS_5         0x68
> +#  define GSC_CFG_HFS_5_BOOT_TYPE_MSK      0x00000003
> +#  define GSC_CFG_HFS_5_BOOT_TYPE_PXP               3
>   #define PCI_CFG_HFS_6         0x6C
>   
>   /* MEI registers */
> @@ -143,6 +145,11 @@
>   /* H_D0I3C - D0I3 Control  */
>   #define H_D0I3C    0x800
>   
> +#define H_GSC_EXT_OP_MEM_BASE_ADDR_LO_REG 0x100
> +#define H_GSC_EXT_OP_MEM_BASE_ADDR_HI_REG 0x104
> +#define H_GSC_EXT_OP_MEM_LIMIT_REG        0x108
> +#define GSC_EXT_OP_MEM_VALID              BIT(31)
> +
>   /* register bits of H_CSR (Host Control Status register) */
>   /* Host Circular Buffer Depth - maximum number of 32-bit entries in CB */
>   #define H_CBD             0xFF000000
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index 6a8e8f3cea7e..c86d6018bc20 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -433,6 +433,29 @@ static bool mei_me_hw_is_resetting(struct mei_device *dev)
>   	return (mecsr & ME_RST_HRA) == ME_RST_HRA;
>   }
>   
> +/**
> + * mei_gsc_pxp_check - check for gsc firmware entering pxp mode
> + *
> + * @dev: the device structure
> + */
> +static void mei_gsc_pxp_check(struct mei_device *dev)
> +{
> +	struct mei_me_hw *hw = to_me_hw(dev);
> +	u32 fwsts5 = 0;
> +
> +	if (dev->pxp_mode == MEI_DEV_PXP_DEFAULT)
> +		return;
> +
> +	hw->read_fws(dev, PCI_CFG_HFS_5, &fwsts5);
> +	trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HFS_5", PCI_CFG_HFS_5, fwsts5);
> +	if ((fwsts5 & GSC_CFG_HFS_5_BOOT_TYPE_MSK) == GSC_CFG_HFS_5_BOOT_TYPE_PXP) {
> +		dev_dbg(dev->dev, "pxp mode is ready 0x%08x\n", fwsts5);
> +		dev->pxp_mode = MEI_DEV_PXP_READY;
> +	} else {
> +		dev_dbg(dev->dev, "pxp mode is not ready 0x%08x\n", fwsts5);
> +	}
> +}
> +
>   /**
>    * mei_me_hw_ready_wait - wait until the me(hw) has turned ready
>    *  or timeout is reached
> @@ -452,6 +475,8 @@ static int mei_me_hw_ready_wait(struct mei_device *dev)
>   		return -ETIME;
>   	}
>   
> +	mei_gsc_pxp_check(dev);
> +
>   	mei_me_hw_reset_release(dev);
>   	dev->recvd_hw_ready = false;
>   	return 0;
> @@ -1270,7 +1295,8 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
>   
>   	/* check if ME wants a reset */
>   	if (!mei_hw_is_ready(dev) && dev->dev_state != MEI_DEV_RESETTING) {
> -		dev_warn(dev->dev, "FW not ready: resetting.\n");
> +		dev_warn(dev->dev, "FW not ready: resetting: dev_state = %d pxp = %d\n",
> +			 dev->dev_state, dev->pxp_mode);
>   		if (dev->dev_state == MEI_DEV_POWERING_DOWN ||
>   		    dev->dev_state == MEI_DEV_POWER_DOWN)
>   			mei_cl_all_disconnect(dev);
> diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
> index 16f59b3a45fc..7c508bca9a00 100644
> --- a/drivers/misc/mei/mei_dev.h
> +++ b/drivers/misc/mei/mei_dev.h
> @@ -62,6 +62,14 @@ enum mei_dev_state {
>   	MEI_DEV_POWER_UP
>   };
>   
> +/* MEI PXP mode state */
> +enum mei_dev_pxp_mode {
> +	MEI_DEV_PXP_DEFAULT = 0,
> +	MEI_DEV_PXP_INIT    = 1,
> +	MEI_DEV_PXP_SETUP   = 2,
> +	MEI_DEV_PXP_READY   = 3,
> +};
> +
>   const char *mei_dev_state_str(int state);
>   
>   enum mei_file_transaction_states {
> @@ -454,6 +462,7 @@ struct mei_dev_timeouts {
>    * @reset_count : number of consecutive resets
>    * @dev_state   : device state
>    * @hbm_state   : state of host bus message protocol
> + * @pxp_mode    : PXP device mode
>    * @init_clients_timer : HBM init handshake timeout
>    *
>    * @pg_event    : power gating event
> @@ -537,6 +546,7 @@ struct mei_device {
>   	unsigned long reset_count;
>   	enum mei_dev_state dev_state;
>   	enum mei_hbm_state hbm_state;
> +	enum mei_dev_pxp_mode pxp_mode;
>   	u16 init_clients_timer;
>   
>   	/*
> diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
> index 4894d8bf4159..506912ad363b 100644
> --- a/include/linux/mei_aux.h
> +++ b/include/linux/mei_aux.h
> @@ -12,6 +12,8 @@
>    * @aux_dev: - auxiliary device object
>    * @irq: interrupt driving the mei auxiliary device
>    * @bar: mmio resource bar reserved to mei auxiliary device
> + * @ext_op_mem: resource for extend operational memory
> + *              used in graphics PXP mode.
>    * @slow_firmware: The device has slow underlying firmware.
>    *                 Such firmware will require to use larger operation timeouts.
>    */
> @@ -19,6 +21,7 @@ struct mei_aux_device {
>   	struct auxiliary_device aux_dev;
>   	int irq;
>   	struct resource bar;
> +	struct resource ext_op_mem;
>   	bool slow_firmware;
>   };
>   

