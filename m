Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CC65B0D26
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIGTXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIGTXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:23:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CADC0E64
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662578596; x=1694114596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XxhV+lH0W0fZ1xLwB51230Axk6PgpKNT56uiH8YsDd0=;
  b=TpyGFhH25cx8JI/xDXAs1XVmeejIdrZB/ykujcXJf7c0QRWOykz/BkeY
   Ehq1xqHao3Chqowg6R+jx46ZVLUpQC9a+M+A1i3HCN4WkEGCHecYlCg9h
   ym9JCl17XeDk6vVkbQJwDhd1/iVqXpJzUhdy9BEdMe0iPczRl9dlmI4bO
   GLyt9cHP9MPvy09ENjxJssRhjsbfwiYFc6yJ4WRbB7LcHevj7fVtRaNty
   dSi4MvkHYWLVuathr+ccOH+vMEqc4eCWPobZgr1AtipXKibsv1sc/uWtb
   7Z4GXszu0Sw2UsWkCVRwtJ0gFegz3EzlPRsB5HXntsXaK2ilFj0/mgCXV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="323164680"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="323164680"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:23:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="859759286"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2022 12:23:16 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:23:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:23:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 12:23:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 12:23:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5IU7qWjXBYV3x4ss7KoH1bJAwGmSrxHeCRD1gRQFP+cE46u8n0fxzj+ucVlJUpr4YU7PYk022jou41VRBOA89lL3BdumoCVnMR0R+nWhgDfdjYGZFozCWkh2HosYOpuBxmQ31/ciXeCBjbhdZvewBik+Q74fhjNubH0Hh4CdLgf4+uvILKj5zGhgMZL70tiDoaVuzN++7ahXBPjnzCKxNowASerZ+yDSsa213G/GXkVNpu6bwlG7hnIFX18h11t+Is11yy3Oa1/YdmSgOpTl7+tEYUoVLkyDURmEJEzNGv+lhaf1zdpBf4RYhONAr3hcWC/a8H1a627BHk1Qt4aHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZm/jPXRJVsvr2RKfy25GMvCTTcFwFIMpT6nNPEVYDw=;
 b=XB3L+BR4S0VIH6jz6aexdjg7p6Ir0Aoa6Fi6s8SX5Jo0FsBG4SFxlYN8SiVRUzmxHbBXIfsbi7EgzlpjM24sUbE1PKynZgRjL0pAnBlkWNmHhG1fhbqlReWxVtbi4wcCbcUpCRCHK5kJigUCsRD30M1Vvd1xm9kUT9YJRQA4522NX5ahsPzYPCMJwvY91fdboxNQS2VywzXQXXD5T5Wccpqp9RZ6kTwQGNhLPgtFZPC4Ewwik4m1c/Hg7Pt+NJAXoZ6g9fdPq2W3EpFGyPT/xBNv8TA2OOPWFXX7Whz03btt+L0GbwXS2or+B2Cca7AOeYDbYWCfQ1CsqBTy2AQ8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 7 Sep
 2022 19:23:13 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 19:23:13 +0000
Message-ID: <1d40350b-df80-478d-d622-2447977f1e6d@intel.com>
Date:   Wed, 7 Sep 2022 12:23:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 11/16] mei: gsc: setup gsc extended operational memory
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
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
 <20220907155813.1427526-12-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907155813.1427526-12-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d064c0f5-eca4-474e-b4b1-08da9106680d
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6179:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjA1FUU4Mj38v7wnvgJ0zCKbMs0HGUHalOk9nScwOZ07uAUCTLVRJr7uz7ZWh8JzbcxpFsXlMQrY3LdgUNW7Oi7BybqbvgFNYEvPAWeN7L8knE5/qalhhOK2gW0UIkKofY0HvjXtsxwC/ClR770FIT+sZlE1iWikBraO7f8PFE7wK3Hww3bDeMpQgiuZX0YKSkj5n+VCTubzRr6ygSLXzdBOZrlFCEbLhs30tyeXNfhTW5XCqRfWpmuAhmWnlPQC0/QveCuVeiENRo8JuCTZ/BaQ7N3GeANFdoKK+Yv0cA7WAaU/CsfIeIOYaLykz/RQB5FMSpPRN7hv0RrsltEqygRblqWnVXdhKY9wfGkOHcr4PJdDikL1Y8hMM19KeQSUAX+EzbU/H5EiAsK4hUFrRTM3MzB7Z2f/Uva9+2uyu8zRABU42lsTq2xNkMt8HHOhkHk2HXZi9diSmNeYZOWHvdA2atDnhWprfwBHNbl9Lz1P5vj3f6q4ltKzrkpKlVamWqLbOMNxWcZCH7pn68xtUVIU3b/Y/Eb2epit5MNF4f57qLWFNRcxvi7Lr9/ZfKWtS7pT6OtvrWsdYJarzAKJRKkX9FfQeNqBwvd18azLGhuM1lfnPypAKGM1VZ04PB5ZRZkfv8sZaYMVVPUhAEEE/K0ENIPCrHbMLkm78Zqs3TwFNmhgN4h8HPuPVjNl9/J7rre2326ohcvaXmGmLxE2G+7w3vrG+tXaLcU7VM2tilsMSCEYSWVnSuXzgreHxQY01yTYCu/mg9kTkHfK6i/x3NVmQL1jcpN0pu3KopRZ1nY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(376002)(366004)(136003)(186003)(2616005)(38100700002)(83380400001)(5660300002)(30864003)(66946007)(8936002)(8676002)(4326008)(66476007)(66556008)(2906002)(41300700001)(478600001)(26005)(6506007)(6512007)(53546011)(110136005)(54906003)(316002)(6486002)(31696002)(36756003)(82960400001)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFZb3FoOFJRMjArMDV2STVoV3FIZ0dIc2VNRjJ6V0xQcXVsZ2RRNjk4YWVE?=
 =?utf-8?B?bXF2NENSdDFTZ2dIZklYSnVKckxscHR6WHJ4SGhlVnJhK2ZvbzlyeWR6NVRk?=
 =?utf-8?B?Szk5WkRKNjBUc0dYSHdCNFdDL2pmelpsRkpndFN1OW1DekJhVW9PZHRuRk9R?=
 =?utf-8?B?U3RYV1J2VmxtSEdwTUU4NEVZUVJ1cVBpU2Jua2VGeEJ1ZEpXa1pMcjdFYW13?=
 =?utf-8?B?SXptUEpwK0NpaEVkdWYzelFLeFV6VWhmS056dDMrNkVsQzhqSUc5TDdud08x?=
 =?utf-8?B?V2QzV05Fa1hZeWxOckRoK1dWRkU1cDJaMHFQRVRURWN3TnpIT1RHYVFwNW0v?=
 =?utf-8?B?bytHZ2JLZ2ZOTkJ3NGtRN2VWWGJ5NTdWMTVCcXZITENEQXFGa1Z1cjN3allL?=
 =?utf-8?B?VzF5R2tsa0ZnQXhtVEZNMFFUL3RqWm5XTzNpRjh5eVJTR2Y1c0RMMmJVMmpo?=
 =?utf-8?B?VFRQM1VWVlViUzFqNldyZlhXaFU4MXYrNG1YeXUvREZINXFXT3ZOQmh1SzVL?=
 =?utf-8?B?OUliYnE5U1oyVitkYjIwdytZQ1Fud0o4RnlnY0NBb1JrS3hlNkRWOE4yN2x3?=
 =?utf-8?B?ZmVHc1poTG1wck91cml3eS9NZEhORHlENHZTR2VMTXBXWllNaTlDNUpLRXpB?=
 =?utf-8?B?eS9CelpVUW9iRnlxcVFRVmZCN2tsQ3Y4UWorWjR6S3pkTEl2Sjl6U3MwUGgz?=
 =?utf-8?B?NERxVXpiVUc5RFFtVkVuN2tJWkhzYlhJVkxPVXQ1TlpLQ0x3YitiZ1VuVU55?=
 =?utf-8?B?dUx4eEI5VXVVWk9TdWVxc0dYRFNQejlqcms2N1QyWllDalpMRGU5YURON0Zy?=
 =?utf-8?B?NTRyWkgxeWFQS0YxZ0QzYndaM3VMc01Ed3ZGeGNRSVZTWnRydWIyUnpHd1J0?=
 =?utf-8?B?TDZXbEpiaW9TemFxR1B3R1hPV2tpUlo1YmN2MThXaVFZZlZ2dU11cjFIRndZ?=
 =?utf-8?B?T3BwRERVYm5RZEpobG1MQ1FlbGdTb0JUSXcvZVlHelpZUU5IWDltS0RYbkpq?=
 =?utf-8?B?THlsRGk0MnpPaDBYV3MrVmNpNGhPMVlsMFBhVC9NRDZMcjZPaitkYUx4M0t3?=
 =?utf-8?B?aFVSKzlSUjRkeWdRMFYwMUtaWGlVY08zeDlEWEtvclNPa1NMSVdySnQ4ckR6?=
 =?utf-8?B?M2JmZVJIWEs3U3UzT3dQODMrZS94c2lZY1FqYXJPQWcxSGIzNDhGZ2FSQ3Bv?=
 =?utf-8?B?MWxzZEVCMEVaZUpvR2Q2QUFROENZT2JpdWtLb0ZtbWFjM05yUENPUjZTU0E0?=
 =?utf-8?B?ZGlHanJ5a0lLc1Y0Zk5IdzZ5VVZ6dFdnK0xzbnZ2N2ZvM2RIR0NKMWE1VHQ5?=
 =?utf-8?B?cWErRUVQWEI4VTFFZ0lDbS95L0JDdURyK3EwY0g0U0lNV050K3NTckUrSFpm?=
 =?utf-8?B?YllZQ1FqMmZpTERpM3BKbUdDUlgyZTRuVXFWSEVLaGVNT1o1ZWJYRURCbERs?=
 =?utf-8?B?eVlKKzNDRTkxaTZxU3JjSHRnaGFPTXY2K29VUjVxRDJEZzk5eHRxMHRDNHdV?=
 =?utf-8?B?WXY4L2t4c2JFYU9hajRaUVRMSFFPQWlRUVF5OEd1aDNUeXErNlJDNEdIWnJF?=
 =?utf-8?B?aERmdTVPZzY4clhnSHZ1UW5URXRiT3lDMUtDeDhIcG9sYmlnV1hyMHNvZFlz?=
 =?utf-8?B?VnV2ODhhaGU4VlA3VHl1S2RTNHBXZmUza0h5RTcxYnZvdVhweW1iSm84M1Uy?=
 =?utf-8?B?OG15dUNQZjF5dWVJL2dHVjBLWFYwbUpEd2ZqQ1l1cmUyNXdLcGVSdng2bHFs?=
 =?utf-8?B?bmxxQ0dXeUtydk9kY0xadG5CSk9xdkF3TEs4NlVLSkEvaGNkWXpORDhuNlVz?=
 =?utf-8?B?RVlJZjAzUVN5K2cyU3AxRE5TNzNLdW9IUHQ5SERpbmJDaTFrM3JNNXJ3Yzly?=
 =?utf-8?B?RmtVa2RUUFByODlYZFRIUTZyUlRrUGg2cFM5NXBEb1FxRmNWMFcvb1ZTcjl2?=
 =?utf-8?B?eU5rU0J6S0ZDMGJEMDhxajA5czNySDVDZnFSTEJVQUMwQTBka09EM29tMmp4?=
 =?utf-8?B?Ym5BV3c4K0V5TnEza0tzcWZLWmVTVnJyZjdDeVlnR082V0kxRlp1TGkwYU9T?=
 =?utf-8?B?NGRMTzBHTjFpSFh1TFJPeDVFOVlhWnV0NVN2YlJac3g4cGdGMVlhTXJEM0xM?=
 =?utf-8?B?amk4TGxVUDVRYTFvd3prdmlGeDhOZXN5WEVYZTZNT2JIVXdPMWdaVDJNREdz?=
 =?utf-8?Q?EgzOfmzElAyR/SV6pA+0QzI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d064c0f5-eca4-474e-b4b1-08da9106680d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:23:12.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xqKV21xjLhVC6i5CCJp2/CZP7xwZ12hsM2EUHZmVMPjEwMxw/u+IyMdYRVmSKjAPDF/0ywZ1S/DqWT2/xl87QADxlI7Kqbd5kjC2tHo5MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6179
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 8:58 AM, Tomas Winkler wrote:
> 1. Retrieve extended operational memory physical pointers from the
>     auxiliary device info.
> 2. Setup memory registers.
> 3. Notify firmware that the memory is ready by sending the memory
>     ready command.
> 4. Disable PXP device if GSC is not in PXP mode.
>
> CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

only minor changes from the previously reviewed rev and they LGTM, so my 
r-b stands:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/bus-fixup.c  | 70 ++++++++++++++++++++++++++++++++++-
>   drivers/misc/mei/gsc-me.c     | 16 ++++++++
>   drivers/misc/mei/hw-me-regs.h |  9 ++++-
>   drivers/misc/mei/hw-me.c      | 28 +++++++++++++-
>   drivers/misc/mei/init.c       |  2 +
>   drivers/misc/mei/mei_dev.h    | 17 +++++++++
>   include/linux/mei_aux.h       |  3 ++
>   7 files changed, 141 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index c4e527803299..79305e4acce2 100644
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
> index 15e8e2b322b1..99966cd3e7d8 100644
> --- a/drivers/misc/mei/hw-me-regs.h
> +++ b/drivers/misc/mei/hw-me-regs.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>   /*
> - * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   #ifndef _MEI_HW_MEI_REGS_H_
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
> index 3c41b61ccbe8..a5bcc475c0e9 100644
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
> diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
> index 5473b1fa6fff..1b4d5d7870b9 100644
> --- a/drivers/misc/mei/init.c
> +++ b/drivers/misc/mei/init.c
> @@ -397,6 +397,8 @@ void mei_device_init(struct mei_device *dev,
>   	bitmap_zero(dev->host_clients_map, MEI_CLIENTS_MAX);
>   	dev->open_handle_count = 0;
>   
> +	dev->pxp_mode = MEI_DEV_PXP_DEFAULT;
> +
>   	/*
>   	 * Reserving the first client ID
>   	 * 0: Reserved for MEI Bus Message communications
> diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
> index babbb0944b7f..6bb3e1ba9ded 100644
> --- a/drivers/misc/mei/mei_dev.h
> +++ b/drivers/misc/mei/mei_dev.h
> @@ -62,6 +62,21 @@ enum mei_dev_state {
>   	MEI_DEV_POWER_UP
>   };
>   
> +/**
> + * enum mei_dev_pxp_mode - MEI PXP mode state
> + *
> + * @MEI_DEV_PXP_DEFAULT: PCH based device, no initailization required
> + * @MEI_DEV_PXP_INIT:    device requires initialization, send setup message to firmware
> + * @MEI_DEV_PXP_SETUP:   device is in setup stage, waiting for firmware repsonse
> + * @MEI_DEV_PXP_READY:   device initialized
> + */
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
> @@ -454,6 +469,7 @@ struct mei_dev_timeouts {
>    * @reset_count : number of consecutive resets
>    * @dev_state   : device state
>    * @hbm_state   : state of host bus message protocol
> + * @pxp_mode    : PXP device mode
>    * @init_clients_timer : HBM init handshake timeout
>    *
>    * @pg_event    : power gating event
> @@ -537,6 +553,7 @@ struct mei_device {
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

