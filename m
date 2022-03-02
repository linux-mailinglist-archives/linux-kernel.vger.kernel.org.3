Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7344C9A38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 01:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbiCBA5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 19:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiCBA5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 19:57:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42390248;
        Tue,  1 Mar 2022 16:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646182630; x=1677718630;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gg9QrTCinjj9vcMtuxLSD8E4qL4oOf9u41wQvwYw7IE=;
  b=iVoBbT7YJxfnOPgvQRuEZMMnl0TgQ2VGpff2UYvw1YtfDg4QHnP9utyz
   Y4V3nlgdWzKEjZ9gBB/KzznTlxodEMabzrE6X1hMW/w7vbVDBybxookkj
   al+CAqVJITBO/CFe3MblDaPYpefpQ/BJTTRLIHABkecwz4wKvsRTEMFGB
   YIpgzq7bPghJQPRVpW4PyyK9uOyPZFieq784SjccBwK+Wln6odrK9ogfF
   XSm0ykrI3xulVDtoeGTgIfEAyMaz/b8x7M8U75iaMTYcq8KnCQ7p7YQ4b
   CpZo03CzY5ww5ooSlgXFAR22103V5llYmcD9b0n92Jm+R4kuSqE07+x6N
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="240691129"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="240691129"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 16:57:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="806181429"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2022 16:57:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 16:57:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 16:57:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 1 Mar 2022 16:57:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Mar 2022 16:57:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKO+jBBqa8m+jAS8xzLGfUfNJjACyqMjDrpIw7s99JnKZd8ErA/Pn+uV9SICrdZT69RTn5TdjKr94x8OxGRpv3HtTNibTNU71uWrS9D1ivYrcip0h8s7uephN1M3rhparpjcnf0gs5RQ524h55ZHIqCe5MIewGqmCaBNltYVkUI2q6MFPXJE2fkbyv4kkIAKzB7N8pxy/3gN9nFtGHInWz/86ill4UPx4EHCEkZCtNmNpkbOZPyKY1QHIyMBCsJeJebY4H5kkVUWOXDDsiuLT3VfCtKuhvgSpKumvzvdRoF0lOGabS1XwLY3vMLA1StGzn5x1nJiBsFTBjjFdGqwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGY3NwLvDpfSRadum+m5SJqSriK7qf24e4EQEfcEg2E=;
 b=mrI/jgEeaBri6D9jwxn10xQWkP8Q+xbx6ZNUMU8zeWMAWhuWG3+Fm5E0TyxjzryXSLhdanuzeZfV34HJRKM+6DX2X38CC3mF6d0rj/Evt5Qlz+vGtB/k99zjsiXwoTSBiF4JzGX7O09D1nD48zZT801AlNk6mbxb3RLwYwJVLyvApRPExmOfPtCjsE1oJPx99I+OlaU52XkWeOQFRYzjQgbYHya/7DOp4rPGJY/TKALNv1otcEf4cPZtSiV6KA0AxM0sm8a8gAH0HzhqR3fGmJbGLJ9JYXga139ATpIlpjk3oB0N7OgL3n3GRZXSnRJrQqd6XGn5pENekGMP91s8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 00:57:06 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 00:57:06 +0000
Message-ID: <a292492e-d922-e964-cc60-ac05ffdee1ed@intel.com>
Date:   Tue, 1 Mar 2022 16:56:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC 01/10] x86/microcode/intel: expose collect_cpu_info_early()
 for IFS
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <andriy.shevchenko@linux.intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <patches@lists.linux.dev>, <ravi.v.shankar@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-2-jithu.joseph@intel.com> <Yh59WcIr06mK9aK2@kroah.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <Yh59WcIr06mK9aK2@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:300:ed::22) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 300281cd-2372-4096-e6fe-08d9fbe79235
X-MS-TrafficTypeDiagnostic: BL1PR11MB5303:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL1PR11MB53037019A1A9B943F35EBB0080039@BL1PR11MB5303.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esM3GcqZsz6eEoeqCiRAronkTBk2q4o1D1TUqD1AVnbqvMhLX8FCPYwHKsbPIMpwqV85z+KMy+uIs/cOxxCfQ+xawNWIm1dJ+VqMD/iku7U2GHB2vNiWfQtpCbmr2YOItiI0XQGmaUea08OvLOKt+6OhcxeKhTS59oubGhGWVUdlBBLEtVoSrjMrMw9Pi5gYPqujK8zcBDAdAaQbqfnZVFu4kIWDiZwX273bN4XyC0wZGV2CiT8iPpbqWGiAn4UK9JF1svnKkllkzG5O7TA5I4+OIdDuY6W69ruDBmNW+tiBqcaVAhmN6VDSaEvb1lNUklsLuQoOjXJ6ERGgV0taV/u6lZu8Ysy/z8heIabbAakHtPQ1VtnOZkoSy6r94IIIob2XUFPHvrgiQda3rQZydWEmqSBkg5R2lGzhTtakROEotU4C41NcyPbef+5clCfhbZEIaj2sWuGbuTRagoOjuVhxAODuzIoerGBjRbfkKMYcE1qSlTKJDeSA7dE0ovGGBKJezUYp7VWiYVoocQCc02Lnl0NaTjvkbERhEhqhYpkbDYMdffimXcsGcClpNy/wHMHzoiuWZ49hsVNMVZLc+z4VVnmTqdI9GFdaHcZRXGQMGuMghwAjxjFfy5VPstFhLnHWEIGyIVHlM07xQLbFtGuE4lE02twlnisICBJY2a9Ucx2Xy73p+t8STzP+sV0TDt8w/MrkoVYXK2pdnKzIUAueGtvA2YHBrB/mZfAPtw3d3NLbvLNgoaOsYS7SE4Fc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6512007)(6666004)(6506007)(53546011)(31686004)(4744005)(7416002)(8936002)(31696002)(5660300002)(2906002)(508600001)(26005)(38100700002)(316002)(66556008)(66946007)(8676002)(186003)(4326008)(66476007)(6486002)(82960400001)(6916009)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhhUlR4Nk9rTlRhZTJTU0hQdGdCZXZvM0d2Yjgvb1h0eHg4MUUwU0VzcGg5?=
 =?utf-8?B?K3ZQY0tZUUVKYWFGRG5VUVVSa1d1QVk1U0l5ZHF1MjNJNHVscFJtenU2MUxo?=
 =?utf-8?B?NUhOTFhUampNaDFTbFJTOEdWSlNMa0grS0ZQUFdkU0ZGdGsvYUJVQzVYd2gz?=
 =?utf-8?B?RXlYeHVkcXZuNzBNb2R2ZXJKWlcyU3BvejFKQkRjNVJlVmcyT0J5RTM0NTUv?=
 =?utf-8?B?T3d1bm9ycUx4ajl5dzdqSGl2M0s3M1VKcHUrNytQZ1oyblJlcXZMaU9sVlpD?=
 =?utf-8?B?bTZLV1RaaUxvZmVNZ0o2QTFMYzh6UlA1WTArS1FJRHJwNzJDWU43dkoybit3?=
 =?utf-8?B?Ui8yQ1I2VnVhN3ZxeHNSRmlXOXdOaGRScm9KVGpRM2c5Z25pK3VjZytWM29n?=
 =?utf-8?B?eFpSMDNqL2hOdlBJOXNkMC8rMUNXUkdSNWg4SmRwcHo0Q2NVTXJSbVNXOEd1?=
 =?utf-8?B?b2pZdDM0VlhTQXNVUE1uVVNVUllDWlB5d1ZWT1NwY1oyMExwbmgyOXJoQXRW?=
 =?utf-8?B?RUVpTnF4ekE0ZVE1dWxKd1J3K0FmcW1hZzJJckdJbXB1V2I1bFJzTWxrdUQx?=
 =?utf-8?B?bUdpbnJ5RXFoSmlNcHhGYWZQL2VieU4xaStTbGZhZ1c0cUIweHFrYjFjVFpE?=
 =?utf-8?B?YkZwVmFYaDZnMFAralV6OXMzOWU1enZOZjRESDU0OEk3UERhNjRHVVRKV09l?=
 =?utf-8?B?TmlkM1l5elJnaE1Wc2VSWFVYbVZpNEhrSjVSVzVNdmEwcVpxTW54QjNKSENN?=
 =?utf-8?B?VlFwVVhsOXRucEpmcFNkeDlNMWp5R0F3RlBDM2RDN1o3SXBqYUNEcW41RjJD?=
 =?utf-8?B?VFdrblFIMGg0RmRsMVpqMDNSYlk5czdwUUl3Um04MVVzVEdwaWthaG1iaHpr?=
 =?utf-8?B?SXNEcmRBRjJhK3FiUEwyUjVUeityazAzWm90OVY3MndDclpqUHRhVW9weisx?=
 =?utf-8?B?aVVaZmduNVpuWURyaEJpdnZRamRGZ290andYMGRqekhaZWFaZHRXT0FLNUFs?=
 =?utf-8?B?dGZrWndQSzJpR3VJV25LMUw0b1d2eHpCS0pxTkU3bkFNek13SkpRZzB6bjUw?=
 =?utf-8?B?NWI5VGV1aEhkWGdUNzVqcTdLWTBVKzJxY3NUc2JPcWZwbEdDYTRiaEV0NmUz?=
 =?utf-8?B?Mk05MzRXNUpVU1VkdE5wVkJUTkF4aGxpdGY3QUU5VnBRTWU2clJIdGM0dW82?=
 =?utf-8?B?VUpyV2E5QndGUWRGYUx4SU1YK3U4NTRtYXdZbWh5bEVmbEVMTGpCa2g0bGxF?=
 =?utf-8?B?TldiQytQVGVqN3dHQTBuK3lBLytJeFd5TWorWEY3dUx0ZjV1TGhiQjRpMUlF?=
 =?utf-8?B?UU1Mc29BUjNTclZkSmpjWHA4UUJqbzU2Tjdrc2RXVDkxWTFvU054UlNjaFR1?=
 =?utf-8?B?NDRHeDI3aEprNjE0WGl5TDRqRWdYTUpSc21MZ05aM0hZL2tjS3MyaDZTZXl0?=
 =?utf-8?B?dHhJbUUvVmUzKzIwUUlVVWJ0bnk2RktrZitoYUpKZjBVeGF4eHdpbmo3MDBE?=
 =?utf-8?B?S3p4TWVRc3FoTSttaUlPSkh1RHA1SS8rQXVENEsvUVoxNDVOb05oN1JaMDg2?=
 =?utf-8?B?RzIveWlRTExabTU3Vi9FWkc3SGV1VlhJOStXUnRHZWsyZW82dWFLdjJzSHBV?=
 =?utf-8?B?WXh6SEZrYXpVYlVPa2dmVU1ETTVRSlR4QTJpS1E0UUxKSTJ5WGlMb0ljTGlj?=
 =?utf-8?B?Zm9Bbnp5ZzlpWjJoN2d6YU9XQWlzbE9TRmZHNjM1Qlp4cGtJakpSTEdNY1R4?=
 =?utf-8?B?TktPM1dySVlqMmRzZHFZTVJldXZPWnR1RkczQUNrUTJvQzRSdWQ3eG80aVVC?=
 =?utf-8?B?bDdKV0tmd0dadmpOTDFxdHFEUnBaSUMxcHRONFNGNDd6M1U3Ukg3N2FNaVJJ?=
 =?utf-8?B?eUU5cWlTcTgwQXY4WTB3NWtVcENlWGltNnJaTnYvdFlZTU9BQTRvbDRvUWkz?=
 =?utf-8?B?Skl2VXpBVXF2amFIM2xFVHVhajVaTWtLQ1o1d2puSGVXVDBZUnAzL1JEZjlZ?=
 =?utf-8?B?LzczRlRsRzQ1V1Q1ZXByeFhEeVI5MmFnSElMRWJOS2pJdHoxZVVES2twRzNj?=
 =?utf-8?B?VFNDdkVrVG1mczUzQVBNSGt4QU1HeG1lVE56YUp1Ny9ZVDl1N2hibmVxS2Yv?=
 =?utf-8?B?ekg5OEZERkJWbWo3SExRaktIQ1VJMHhmb1ZZbUtGaElpamtOTDIzZmk0VURq?=
 =?utf-8?Q?eFc3/NsDnmjVG0nmB0Bwrcw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 300281cd-2372-4096-e6fe-08d9fbe79235
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 00:57:06.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5FPA/bqyoGdcmV3YPzgQM5IlUvUbNEoK9Kmbwx9sbei6DSFKHdk1IDdLykZDLWDqOV3Bd3WfpB1U5GmlfIbrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2022 12:08 PM, Greg KH wrote:
> On Tue, Mar 01, 2022 at 11:54:48AM -0800, Jithu Joseph wrote:
>> IFS uses a image provided by Intel that can be regarded as firmware.
>> IFS image carries the Processor Signature such as family/model/stepping
>> similar to what we find in the microcode header.
>>
>> Expose collect_cpu_info_early() and cpu_signatures_match() for IFS image
> 
> If this is going to be a global symbol, how about
> cpu_collect_info_early() to keep the correct prefix?

Will make this change
