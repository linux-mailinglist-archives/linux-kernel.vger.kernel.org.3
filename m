Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9004B1C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347334AbiBKCam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:30:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbiBKCak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:30:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D555A1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644546640; x=1676082640;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JURO3h6kmu8QQpyD5dkDPa2tJTRXyx7lMlJDrPoT2/o=;
  b=eWy3SIqCszRSCDdzNSrbHa8MMhIe4s5mRP0mYUBLjS4w+Q9h54Idjmtl
   XJpzpT/pwazr+Q+4WKLoRIb5MY8dK0cp2Ez3QORfcPo8CB+C5OwvANzyN
   BVos8rGPJ5Fq21e7pfsRjkTa1FBfsccuDM7gamIHLTyGD8S1IEASv8GbV
   frKbqhqIWpddqRZNDXLafiJmIzrqefslx/TCPBDf06IgVyDIcnFZau2mn
   Zj37QfeFkR4Z9zQO9+VXbDTGootVCluGvgwOLQSFfVg+8smcMHAYyIqO0
   Vb12AEBbMiZgMUYSOmrjgybSp6CpJPlwxUn/JRZx0PsK19m4vLAxPCXup
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="229608307"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="229608307"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 18:30:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701932045"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 18:30:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:30:39 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:30:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 18:30:38 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 18:30:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOLg9XU2+hC2mMg+lYGw2zznyorisLerm4Amvm2oMvzddrcOMWmwMvFVGP5b0tmJ4ZjYu5HQ+PLjFtSh3SQqJMc7KnZj/PBmhCvGFxkiQFK7KlA6N2AHqzp85kTketXC91iupe6teaT/Wf6Uo5uX+139T/JPyLzKf3uzBDIWhocbLMrvM/tAYWhNi7fHO9cA7vAP72plkBXX/z5QE+JnBbrbeFl22pKcY+ech7zkPXMnQhsUaIDmT4117C5kDLFlxu6Wkln8l8euogCnQPFZlz8Mfw0YDh1JDXMjviF/h0Ldk7VZQOTXwBdd9GLZZpQ56FrcKwx7qlBrs0wzGg5MNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb+5Rk/s+kk55QCGzBt5HX69sv07f0OsgSl03P8BpX0=;
 b=hVTfLv9RXC5BZNmQUoJOLf8QaMO7n0QuglNK3KbHW6T+BeHGIj2YBth5GZoXx6qG8YgheTPd1DQ+ndb00U2dsdvrbHwYsGwBZdLWWpopPGf4cocmfvw0JqpatDhVp7OnwVo57HmnuwqJ94Ua7KNjBsp2q+C181+FQedkScodHbl8zKJWsoDmjsSB9dDzz6oxDx9DlpnZWq9QzQZHuV4k/l6100eUVVBE4BasMzQSPzXCpJIYf0/gw8H7efeHaUSv5gil5yaSq6QaqiEWQE5PC+FtgmxgDCOroseUUWZL236cVqM9p4v8A8sYMn5GL+Ut+IPXQFwlR/05Yh4aMKDViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM6PR11MB3435.namprd11.prod.outlook.com (2603:10b6:5:68::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 02:30:35 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::5c89:e3da:dfd5:ec7e]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::5c89:e3da:dfd5:ec7e%7]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 02:30:35 +0000
Subject: Re: [RFC PATCH 0/5] Extend FW framework for user FW uploads
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <basheer.ahmed.muddebihal@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220203213053.360190-1-russell.h.weight@intel.com>
 <Yfxem+AF9lroota0@bombadil.infradead.org>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <d0c18f9b-383f-ce36-94e8-e273cd26a2c9@intel.com>
Date:   Thu, 10 Feb 2022 18:30:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <Yfxem+AF9lroota0@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:300:16::25) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 694f160e-1a61-4963-62e2-08d9ed067b92
X-MS-TrafficTypeDiagnostic: DM6PR11MB3435:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB3435AE0D64C4C1A7A709D0F2C5309@DM6PR11MB3435.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/ZSL+QOdBjzXKc74iMAHviiIHWN6/EWCIVlx5lwf3uyfNw7CCWyOilpHdkWZ+zh7H8GaJ42ByvbzvxHBa2kF63PiWTFo39YCp0OwSf8D57iF0WIw3cGEn9OvBKqZoa1owNzEbvBUZEDW59WXDzHAcNcgwMlqQgqqGAryD4XYGFhsQZDW9ik6JRt7ws3FoHGkzcLWSpshhOBCPTXqVdBHpJciGixIZ/hEoJ+WPkkuZS/VeyRa1upmDpXHgIBzRv7G93ydL5Z9XdngQDjhF9bpsohK7Mle1+lUTbHgc1Gx3lpXqDMSjzK//aPUT0sgbsDNc1nWAu2yWJn7Xckle/WerilxEyVduhHC6bhBvaZhZ9VdpuOB0ztwmV/L79Vsh1+ApHkGEvget1XShUN+QBMERfKJbqQqFCRSYlIjlN4tv88QugMUsL67/RTu1ZdgiXcK7uXpiiefrvQT5d7d4X+ugSagxMq4uaUprbc2cOYiTvYkQ3+Tzhqy640AcKC53GQIQoRHiCLcXvNgFWikK+IF/NcklksIFPrj3ns2/lgqg+D55KN3LFpFzn3lEafzlpNDFbngRjIjkPFB5oLOIicuGKUKZTszT4PpBFYb6aHEgCGlE44q1QXTS9TqeirEiz/cDYb2cWKaoKlAKn7miRuu8/sTfYOtPyPRE6nXGuxveF25WgksHJSDnRktHUnzMf7LU6mJ2kg29wISqiuIQ+FKye/HUMy0Ih+y8JTR2YmCD+VAZGE3M+LzkuNFelFut9w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(82960400001)(8676002)(8936002)(66556008)(2906002)(5660300002)(66476007)(53546011)(186003)(4326008)(6506007)(83380400001)(6486002)(26005)(2616005)(6666004)(31696002)(6512007)(107886003)(38100700002)(508600001)(6916009)(31686004)(316002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHlZa3BwTmF3VlFzMHpsa3paZ1FJTGdlWWJycmZ0c2JXOE0wWWRwM0p2emRR?=
 =?utf-8?B?ZFZ0Qkw3YnRrZVBhUTlpMVd3ZmdyVzdydXlaU3BGdWpMd05WSTgrV05FQzJu?=
 =?utf-8?B?T2ZZejlSOFl5cllHa0k5NmdiZGpFZnZtd0xpWnFMblhQRzRHUXExeWtZSjRy?=
 =?utf-8?B?TkJWK1RablFueExGNG9xL1dsYm11VVcxUkV2dlZBUVhTOWJjS0xBUG5wTFY4?=
 =?utf-8?B?WjFLa25CQTBLRnFBYS9tU2ttb1BTNVpxT1NtQmhoUk1jV1NvOHZIMURXSzVs?=
 =?utf-8?B?ZG1Ea3krTW9zLzhEalYxejIyR1ZKTnFHTGQ3ZUpkR3A5azFNUngvSitJcUhE?=
 =?utf-8?B?R0RjWVRiRnh0ckZpcEpmazJhd3ZiSk5rMG5EV29QS3lyMUxtQ2NNRVBKV2xu?=
 =?utf-8?B?YmR5SWpsbXh2VTBES1c4aVBuRFc4aGpVMm1vN2V1SHhkMVhiaUtwU0I2SlFi?=
 =?utf-8?B?dnN3aThwRUoxUU1vTTBTajJnNXljZ3NKZU5wSFVjM0RrOGhnUk50TExNZGMy?=
 =?utf-8?B?YmFSQ0dIRXZ4ZEpPT2xRTk9MdlVNVnFEWWxiQVdsSmRZcXV3U3VzTnNzaG1m?=
 =?utf-8?B?ZitYcmJxRXprYi9RdlB6OUQ1Uk5IbDRjeDI5ZmhWZHdEMks0elZwWVcxa3JH?=
 =?utf-8?B?ZFAyQUdacWFWVmNzVTJXNm1JNGttZ2dlWStUbEpVUU9waGJMN0Y4MzI5SVAx?=
 =?utf-8?B?d1F3MmYwUFlFYTJsQWw4UG5qZkY2c3ZaZHNUWGdVOHR2clg0U3Avbk9OT2Ir?=
 =?utf-8?B?VGpvZGxIQ3k1dzh6L3M1MjMzOUk4WGplai92L3V4alF4bFFaRmIrSEVjbC9u?=
 =?utf-8?B?a1F2d2Z3UDRYVnduTTNSMmxrd1UzL2tJS2JlNmMyLzJHNUZ1VndIeEI4MjFT?=
 =?utf-8?B?MHpwanAydGFsV2x1cmtFRFczaHdRYUg2QUhUTnhlNzd5anFPMmc2UFRBM21s?=
 =?utf-8?B?MHBiNGdxQzZjK045cGJzeElhaitiUDNIcGNTZFQ0Y3N6Skx0dVVTcXJKbDI3?=
 =?utf-8?B?QUViNU5uRklpVEZIckhkWEl5SVpGOXJzdU1mL1lzRDNja1ZZZitFcmNCS0JZ?=
 =?utf-8?B?WFB1LzhrSzRxbzBvVzNRajVBTk1KN0RGNlZsOFNKMUZGeUY0RXBjV012dm9D?=
 =?utf-8?B?M1lRSFgxVmlMNHFmcUc5aElGSklUOXRMRlUwNWJBTU1IZnlsandmTWNWTWc4?=
 =?utf-8?B?R2IyN3J3ZDZURjZhekxncHF4ZC8rdTNBeDE4UVV3djlScmNqNXIzeG9SV2lC?=
 =?utf-8?B?NWJPNERHRk1JclVBQlgyUTRkT3UwSEFXSTMzZThhRkRRRnRTOTYwcSt5R2Jv?=
 =?utf-8?B?RndZYVNqT0FBWFlUVUZxOFBwbHhGWEFEZ2xGZHh6MVhna2tlek5XNzNZYm9O?=
 =?utf-8?B?UGZEZzZlWjRpZW9odkI5OG5xQ0FNVWhHTERPWWptbW9zS0RZQWFrSHZlaWRZ?=
 =?utf-8?B?bTFNM3VjUGF3cHA3M0R3Qk0yL1hTNHFXOEpMWWo0MHhzRjlIR212eVVGUXdj?=
 =?utf-8?B?b2ZtMVFKVjJCVUs1cjJNaWt6dm1KWkhBeGVJRUVUeHV1QUdIN01VSEcrak94?=
 =?utf-8?B?OUJBQkVWWmtucjRRVTdQOUFOaks3U0VqMkhzUEV2QzJsVGRFVUROSUlaTVZ5?=
 =?utf-8?B?UTJzVGtuL1NVVUlqUkZJZitkT3dvcTFJQnlDbzF2S0pCZ25HZzg5QmIreThq?=
 =?utf-8?B?R25OM3BWZGhXTEdOcUpNQUZwcC9neWU3am1pa3JXbkZCc3JpSHNuN3NScmlp?=
 =?utf-8?B?YVVFd3dMRFZoTkpQM2gvRVMwc1lidVpxSlRUV2dGM0JBd1ZGTGZiaFp2ZVdF?=
 =?utf-8?B?SmlSTXA5S05OcmI3a3k1YkJhbE9ZTmFrUHQ4eHBLa3JtWXQ1Y3UwaGZyaG1N?=
 =?utf-8?B?Z2xCaGFZMWxjWjRsNVpkM29pOUh1cENTa0prM3o0TnhSd1B5c2t5ang2S29h?=
 =?utf-8?B?dU9PVC9nTExSVzF5QWtLWlFBbkZiblVVQW5VOG0xQ3RIaitGMDhpay94YXFi?=
 =?utf-8?B?TVlmUVlaVWtzNjJnTTVQZXl4b3VuYUttaXNVTm1hMjJMekY4ZXVZYzNYTUVj?=
 =?utf-8?B?Q0ExOUNmcnY3ZlNDUTZzRnhlc3JoUXJYckIwSWVIeUtzZXp6RWlUVjhPNnNJ?=
 =?utf-8?B?NkZra0FDRW9DUll0K21MQ0FCZDdTQVdKT2E1WjdJeFNuSEIyRFF4cWIwaHNK?=
 =?utf-8?B?UWNEbldYODZ5M3B1VjVsN2c5MWsyR0FzWi8vYWhOUytCeU51YTc0S3ZPTHhp?=
 =?utf-8?B?ZXRtdC9sV0M0UjhGL1JGbEtsbFVnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 694f160e-1a61-4963-62e2-08d9ed067b92
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 02:30:34.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osZpTtW9kskXxmz+sxHC213OiPHi5GKw6GYs53yRaOtf8p7Nu08yctdy15kEkGzb+I9/xPuYsE9G02ACF8/RWShmZ7eHwpL61fwYVGk4vNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3435
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



On 2/3/22 3:00 PM, Luis Chamberlain wrote:
> On Thu, Feb 03, 2022 at 02:30:47PM -0700, Russ Weight wrote:
>> Extend the firmware loader subsystem to support a persistent sysfs
>> interface that userspace may use to initiate a firmware update. For
>> example, FPGA based PCIe cards automatically load firmware and FPGA images
>> from local FLASH when the card boots. The images in FLASH may be updated
>> with new images that are uploaded by the user.
>>
>> A device driver may call fw_upload_register() to expose persistent
>> "loading" and "data" sysfs files at /sys/class/firmare/<NAME>/*. These
>> files are used in the same way as the fallback sysfs "loading" and "data"
>> files. However, when 0 is written to "loading" to complete the write of
>> firmware data, the data is also transferred to the lower-level driver
>> using pre-registered call-back functions. The data transfer is done in
>> the context of a kernel worker thread.
>>
>> Additional sysfs nodes are added in the same location as "loading" and
>> "data" to monitor the transfer of the image data to the device using
>> callback functions provided by the lower-level device driver and to allow
>> the data transfer to be cancelled.
>>
>> Example usage:
>>
>> $ pwd
>> /sys/class/firmware/n3000bmc-sec-update.8
>> $ ls
>> cancel  device  loading  remaining_size  subsystem
>> data    error   power    status          uevent
>> $ echo 1 > loading
>> $ cat /tmp/firmware.bin > data
>> $ echo 0 > loading
>> $ while :; do cat status; cat remaining_size ; sleep 3; done
>> preparing
>> 44590080
>> <--snip-->
>> transferring
>> 44459008
>> transferring
>> 44311552
>> <--snip-->
>> <snip>
>> transferring
>> 173056
>> <--snip-->
>> programming
>> 0
>> <--snip-->
>> idle
>> 0
>> ^C
> Nice. Please extend lib/test_firmware.c while at it and try to break
> and ensure your stuff is not regressed with future changes.
Yes. I'm looking at the test_firmware module and I'll add to it
for the next patch submission.

Thanks,
- Russ
>
>   Luis

