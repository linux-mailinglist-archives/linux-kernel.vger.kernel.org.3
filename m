Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C24D2898
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiCIFyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiCIFyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:54:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414BC6D848
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646805196; x=1678341196;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z0WZ2+e3eQC6CjYRcjr/hqIxAhsx9VItfgQbYfOji+w=;
  b=PFUtBYNxuXgdfP6PagTRKu6k79Yex5kKmzIX95rBSI4PuOx4+ibO+5ee
   VebXz8mkHm1laRQMeMjSBu/aj52PE3FlCYsZMGEJMWSbWpy33Yhk0pSEQ
   zX2FvAf/V58nrl1N6550S4XpFpOyZ/Y8LVjo2D0gFmQozxM05JH9Q5ih/
   TBMEwNLK0Lkr/3A14AdysRwdcB4bVyu1QpwNPlIjyVIs2DjmILFTmd6Z4
   GD8BfzAEn/giQaPT3sjIFFpuGJJalzITsA6N8jVgoSXMCZJUAcRAaNUnU
   yDLZSwWGjh55VdQ4lCGULxymnyKjHAgBGOlXO0Hzmbl2ZrGKM410EeCeo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254835513"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="254835513"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 21:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="643926368"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 21:53:10 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 21:53:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 21:53:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 8 Mar 2022 21:53:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 8 Mar 2022 21:53:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj7e8y37N8pUvbHZzCvD86r2G2tq3kmJgNJ85ppUf1HNQ7UPw08+kYScYncywXpxPf6oA9mLHNteTTqqPUOjgGA7XsFoRmHps0qgMdLsnyR0q3LpY3szYTJ0NiVQ9aRhFKj7yzjPAK9xh/v0OuIS2VZPki50Fxc1eEnsjCqwsSVFpHKvu97fn3/FKmMjbYXMdP4/1N1efh0Q5/c8zHe+1GgBUAaPhsEc/omotMLpCTwu+fzFshK7RQRob5fMLLIiBR+Q69xL0oVWWCDvk9R6MKlCBt3iIRpdU1YhtJRWL17DhD5q4ZGZAn6gfE2ko7l4eLURaDA6PCxJZ4/6Bc9lEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhCdN+hqgjfyWaVl0aKuOb5Jn1V8X6lEx5lvX/UV81g=;
 b=RCJz6z/fri4ms+crJXogEFEiGdVy1+K1S6Qx7iQlDTIBE4sggddTZ+Q2jqMbYAgTJe67o6SictixcgVWEHafP0YRLMwr6pCmWFho75rUkljDQ60iNPD2gq0pGM7KjjKY/zkiDogwoVClck3ZfZDRqAbJHAjRdZvLAl24T+st+q8NaMBXgLaE5eLbCvQ6a7IIoJ4ERaSDJI4Z3CBGtWWb6JJrmJwb8BVuu1b+4qk6xIFLJN2eowdTHwtD7ejno1ucJmPADQwUWNUMtv8aRVIv/McxK7gOdVQdoK4M34TXVitKGjtGaLiJf/FGz+NJHtkBVt4+JjQyYj9Z6aWjLnk7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by DM5PR11MB1755.namprd11.prod.outlook.com (2603:10b6:3:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 05:52:56 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 05:52:56 +0000
Message-ID: <24c282d8-f740-ddda-53f7-04eb8f5ae4dd@intel.com>
Date:   Wed, 9 Mar 2022 13:52:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.2
Subject: [jgunthorpe:iommufd 10/12] drivers/iommu/iommufd/vfio_compat.c:358:3:
 warning: Value stored to 'rc' is never read
 [clang-analyzer-deadcode.DeadStores]
References: <202203010007.dMWQzNHZ-lkp@intel.com>
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202203010007.dMWQzNHZ-lkp@intel.com>
X-Forwarded-Message-Id: <202203010007.dMWQzNHZ-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca8da33-e24c-46d8-28c5-08da01910ef0
X-MS-TrafficTypeDiagnostic: DM5PR11MB1755:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB1755029EEF6E0DB0CADD7A63FB0A9@DM5PR11MB1755.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsQ36HTBnLlVa32tlVnC+XFva8ItMOg8qR0adlpqvGjX6bYgwulldNN2jYZFW6f/kSq+MRRPMjaLcSRg2GUQfioNvNijgEA0639NovVWmYOTTc2XmFh8xvi/zTw9DMNyDLXxa8xvHsIb9UelXuTMGhA9t5iZ4gwj9wKzDA2T3pfPZSsUtMTDSJ7KewiipVyUNkyaEgPY0nnDAb+/Xma/5KYKvz7rodXcTHiqNCoQ3JmLqqz32xKjK/1nRXag+ESkUTBu4UPLkHg+drYrH4TZKdBcjsxMxQ4ItukZHCRojZO6lX0G3czn2UDwT75HXl4WjsZSN9ETDlNl8hOGCP7IYMP30kNTwsLFaZM9/NtGhbGxZe844cvs/o2Qrdboj4mSD2uzmzUzG5SqxzlE5LBVP1eSXtsiyz+dTsmvy5zxodgcmKmP6QwgKhr7N5/D7BjS+m5/kbacIgS59CVLTjg6xTfNIDlGcF6MnkgBdCjDCkdVHKdU7n/5oB2kO1mQAuMIeQscpE2NzQfRES4dGe6yLHIpZ0SP7fI/H6MFUfg2MzoUXeAqYH1e64egL3/d0sfh2C9Acu05POY7f/WAnlNlZ7+jKkAphdG6mvSrqniuBR9US9maqFEQWxsJA19PMgK6Jl3wR4PS6RsbJuQMXABSdv6rLXD7IH5lerxeCC9vEYigPcIERD/MkNOrlSd65Ay5zKO58bJQMMehRaHB9MZKed2Ow+zPBsWDaKCO7B1xyGC5iHIWxj59z7P+wIAeQFtY8dH8vRIghYfuts8tehLwydSfnyQQjWeWKJzAXlDeaOsc0jgHXsPx/yb42m4kJ/pxULB/kPsL9xRSGwmvr7DfJjIZfvewGQo9HuXHY/7Yh8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(86362001)(31696002)(186003)(966005)(508600001)(26005)(83380400001)(2616005)(6666004)(6506007)(6512007)(82960400001)(2906002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(4001150100001)(54906003)(31686004)(316002)(8936002)(36756003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnUzL0N3TW5QWjZSdXVxbFRHQXAzd3BONzNmeVBhT3VnUGVnSG1nMjR0NGhL?=
 =?utf-8?B?YkV6dGZuQXB3V2p6bjlUaDQ1V09zM3YzYW1CTE9EQUlrandoZTFsYmR0aXlw?=
 =?utf-8?B?dEhoaDJaZHdyZW9MbUloVjVZMGY3WkR1MUEwek9QakhEZWwraFZ5UGZxMXVz?=
 =?utf-8?B?eEFCVUtVSVZTRXJmVWZmRlFoSG04WlRUNnRRTWhiaENwemRvcmVYSmN2cGxv?=
 =?utf-8?B?UUx2ZWtXdUtXVzZUcTU1ZmQxNEJ3VitJWnVPZnhkenMzYVZDQi8rSVVwL2RY?=
 =?utf-8?B?dDVIWDVON0c2Z3VNMmZSWThyYVJZK3kyTUVES1lLYms1Unk3MlFqcGNCYUlo?=
 =?utf-8?B?UnBjTlJtOTUyWlhrMWtaNW9PcVlkNjBpUFI4Rlc5OW5GdzhKdWhNVGc0YVJ6?=
 =?utf-8?B?cTdoUVl6MkJhZ2doMVk0MjNTdFBGaGdORVB0Snc4WGp3MmFLSU82RTcyOVEy?=
 =?utf-8?B?Y2NnUzYwckJGMkw0Sk5Xa05VM0M5U290NDR3cktsZUUvVEJ1REY3ZEVyQWwx?=
 =?utf-8?B?RmZsOGhlckFqZmk3VHp3Zll2V1BEc0VlTTFoODkrV28xbmtXeHFXaUZaYUJm?=
 =?utf-8?B?Ulc0QmJVWWpYSmtSL1hiQmMxTm1Lalc5dXhKcXZRd0ZDS3hObnM4N3gvUWUr?=
 =?utf-8?B?WVRPeW9OcTAvdUlZUU9POWYvc082Ylp0ZTkydUlzTHQzeDA5MlA4YXd0UUNW?=
 =?utf-8?B?NTd2TGdqWG9vbDh6bGdkTGNrM0dRczYrUE1OalJhalhaM3BUUXozUnJtdmd4?=
 =?utf-8?B?VWFwbGNkM01XQTF0aWhEaXE1c3NpUVhMekNqZGpKV0JZTnFRS245VllUV2tz?=
 =?utf-8?B?ajY5cEFlaVBuUVowT1NoYWZ6Z29tQTZkVjRBbFgramFxZVhPUnBqRXIrc0Nv?=
 =?utf-8?B?cEZtNU82WHJxSWJEWU4wdzc2RHhBQlE4TTBoandwRldXaVpkOVRmRlgrdGsz?=
 =?utf-8?B?ZkgvVDlLL2E1MSs4cUYwUHRmSjI4LzZ0ODhMdThQL3MzcTVhaTFVRlp2Q1JT?=
 =?utf-8?B?a3YxSzEycTFxSmFUbWRMeVVmSXFseWJ6VmNhRHE3RGxxTTlyS2lIZkFyNlhn?=
 =?utf-8?B?Z3JpS29TNUs3Lzc1c0NheWxCRVF6dlVoRUZjQVpZNUo5OXMvS2c1NUlKWmZC?=
 =?utf-8?B?NkNyU2MxY0NnaGJqZWc3bHVtYm9SRmh4QTNwMWhCVGlwVUliTy9CWjlWaCtu?=
 =?utf-8?B?R2JEY25JK2lnYmZENkpyTUJjc0J1Y1VsTXhQcU1PQk45NzVEaXYrRHdMZ1VP?=
 =?utf-8?B?anRUNlF1WDB1RW9rMnhoZkdlQ2twenZ6cG0ybUk2eTdNYSsycjYvOGt1a0Ja?=
 =?utf-8?B?QjRHOFhvd09vT1EwUkZxMmU5enpTQkl2NHh1N1EzNzQzNGkrNTVkR21vVkQ1?=
 =?utf-8?B?MlM5enl5V0JrQ3ZQM1RRaTdseDNNM3FVdDRkbWFnZlI1VjIxOHdWZTcxQW5O?=
 =?utf-8?B?N2pudWpCalZZYlBTVmw4TjRRMXMrR0M5T3NJQmdYRE1pemVKTFhXWC9oeVdM?=
 =?utf-8?B?NFRGa3NoRGlweUxhN01BSUQ3SFZUZ3RwcElUSldDTlBBOVJZdXJIYTdUendM?=
 =?utf-8?B?MjJEWHNpbkNJbk9TWSs3VTAyZUxJNWpHK0RRREpXVk1jcTZLbCtDZWF2REty?=
 =?utf-8?B?ZHlWSE1taE1XQmNGTkFHQWlFb0NoZWZjOGwvMWlNYlA0ZlZJZEJRTzBrRlU3?=
 =?utf-8?B?VjZqMmRsdVQxancrMmdYMzVrV3BDQUdoL05aNEZBWnlwbTd6MXl4VnpCRzY1?=
 =?utf-8?B?K2hCeDhsUkRwYVpsNGVVekJnb1pUdXR1cjNJc3V2QU85d3Y0ZjRpQ1lYd1R5?=
 =?utf-8?B?VUcxSFpkSnc5VHdXT2QvN2dPSElzVUk2YzBvSGNXRHlPV0d6enlZdS9kRHBC?=
 =?utf-8?B?RWhjS3lUZVhWamdXc3FYS3RCVndZZmpPY0RiYjhUcnpHcWtpNjJoU0gvdktJ?=
 =?utf-8?B?SGJRdWgzWXBqWkppeUx1ZnRPYmVXb0pIL3lCK2tmOXB3ZC9LOXo5UTVjZFVo?=
 =?utf-8?B?bXhmS2RFeTdPYkQxWHh0Zm03YjZMekVISGRPV3M1K3ZwMlRyeENZeTN0R2w1?=
 =?utf-8?B?a0JqVU40eE5LMWlMV2F6TE1zSG5RZXlnYnNmcVQxWWNyRGJ0SUxCQVFiVjdK?=
 =?utf-8?B?Q28rQW0yUm1OK0I5QmVqQjZqKy9BSnVCOEhEeVRlWGc4R3FuSmlhS3J5U1I2?=
 =?utf-8?Q?8wRNE90yKsVb4q4wNR+0028=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca8da33-e24c-46d8-28c5-08da01910ef0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 05:52:56.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Q+puYkMfzRefzDrk07oX0GfFlpl1WTJDVqjofNwx/UxsJi5jV47EqbAjpyS2Lq3XRL0oQWcFg8jBJLgvBK1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   446626304259cf3deb4a4799b42a909bea0bc070
commit: 6df3783f55eb10f5583783566fd12646ef693568 [10/12] iommufd: vfio container FD ioctl compatibility
config: mips-randconfig-c004-20220227 (https://download.01.org/0day-ci/archive/20220301/202203010007.dMWQzNHZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install mips cross compiling tool for clang build
         # apt-get install binutils-mips-linux-gnu
         # https://github.com/jgunthorpe/linux/commit/6df3783f55eb10f5583783566fd12646ef693568
         git remote add jgunthorpe https://github.com/jgunthorpe/linux
         git fetch --no-tags jgunthorpe iommufd
         git checkout 6df3783f55eb10f5583783566fd12646ef693568
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/iommu/iommufd/vfio_compat.c:358:3: warning: Value stored to 'rc' is never read [clang-analyzer-deadcode.DeadStores]
                    rc = -EFAULT;
                    ^    ~~~~~~~

vim +/rc +358 drivers/iommu/iommufd/vfio_compat.c

6df3783f55eb10 Jason Gunthorpe 2021-12-15  291
6df3783f55eb10 Jason Gunthorpe 2021-12-15  292  static int iommufd_vfio_iommu_get_info(struct iommufd_ctx *ictx,
6df3783f55eb10 Jason Gunthorpe 2021-12-15  293  				       void __user *arg)
6df3783f55eb10 Jason Gunthorpe 2021-12-15  294  {
6df3783f55eb10 Jason Gunthorpe 2021-12-15  295  	typedef int (*fill_cap_fn)(struct iommufd_ioas *ioas,
6df3783f55eb10 Jason Gunthorpe 2021-12-15  296  				   struct vfio_info_cap_header __user *cur,
6df3783f55eb10 Jason Gunthorpe 2021-12-15  297  				   size_t avail);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  298  	static const fill_cap_fn fill_fns[] = {
6df3783f55eb10 Jason Gunthorpe 2021-12-15  299  		iommufd_fill_cap_iova,
6df3783f55eb10 Jason Gunthorpe 2021-12-15  300  		iommufd_fill_cap_dma_avail,
6df3783f55eb10 Jason Gunthorpe 2021-12-15  301  	};
6df3783f55eb10 Jason Gunthorpe 2021-12-15  302  	size_t minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  303  	struct vfio_info_cap_header __user *last_cap = NULL;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  304  	struct vfio_iommu_type1_info info;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  305  	struct iommufd_ioas *ioas;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  306  	size_t total_cap_size;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  307  	int rc;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  308  	int i;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  309
6df3783f55eb10 Jason Gunthorpe 2021-12-15  310  	if (copy_from_user(&info, arg, minsz))
6df3783f55eb10 Jason Gunthorpe 2021-12-15  311  		return -EFAULT;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  312
6df3783f55eb10 Jason Gunthorpe 2021-12-15  313  	if (info.argsz < minsz)
6df3783f55eb10 Jason Gunthorpe 2021-12-15  314  		return -EINVAL;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  315  	minsz = min_t(size_t, info.argsz, sizeof(info));
6df3783f55eb10 Jason Gunthorpe 2021-12-15  316
6df3783f55eb10 Jason Gunthorpe 2021-12-15  317  	ioas = get_compat_ioas(ictx);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  318  	if (IS_ERR(ioas))
6df3783f55eb10 Jason Gunthorpe 2021-12-15  319  		return PTR_ERR(ioas);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  320
6df3783f55eb10 Jason Gunthorpe 2021-12-15  321  	down_read(&ioas->iopt.iova_rwsem);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  322  	info.flags = VFIO_IOMMU_INFO_PGSIZES;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  323  	info.iova_pgsizes = iommufd_get_pagesizes(ioas);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  324  	info.cap_offset = 0;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  325
6df3783f55eb10 Jason Gunthorpe 2021-12-15  326  	total_cap_size = sizeof(info);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  327  	for (i = 0; i != ARRAY_SIZE(fill_fns); i++) {
6df3783f55eb10 Jason Gunthorpe 2021-12-15  328  		int cap_size;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  329
6df3783f55eb10 Jason Gunthorpe 2021-12-15  330  		if (info.argsz > total_cap_size)
6df3783f55eb10 Jason Gunthorpe 2021-12-15  331  			cap_size = fill_fns[i](ioas, arg + total_cap_size,
6df3783f55eb10 Jason Gunthorpe 2021-12-15  332  					       info.argsz - total_cap_size);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  333  		else
6df3783f55eb10 Jason Gunthorpe 2021-12-15  334  			cap_size = fill_fns[i](ioas, NULL, 0);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  335  		if (cap_size < 0) {
6df3783f55eb10 Jason Gunthorpe 2021-12-15  336  			rc = cap_size;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  337  			goto out_put;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  338  		}
6df3783f55eb10 Jason Gunthorpe 2021-12-15  339  		if (last_cap && info.argsz >= total_cap_size &&
6df3783f55eb10 Jason Gunthorpe 2021-12-15  340  		    put_user(total_cap_size, &last_cap->next)) {
6df3783f55eb10 Jason Gunthorpe 2021-12-15  341  			rc = -EFAULT;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  342  			goto out_put;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  343  		}
6df3783f55eb10 Jason Gunthorpe 2021-12-15  344  		last_cap = arg + total_cap_size;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  345  		total_cap_size += cap_size;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  346  	}
6df3783f55eb10 Jason Gunthorpe 2021-12-15  347
6df3783f55eb10 Jason Gunthorpe 2021-12-15  348  	/*
6df3783f55eb10 Jason Gunthorpe 2021-12-15  349  	 * If the user did not provide enough space then only some caps are
6df3783f55eb10 Jason Gunthorpe 2021-12-15  350  	 * returned and the argsz will be updated to the correct amount to get
6df3783f55eb10 Jason Gunthorpe 2021-12-15  351  	 * all caps.
6df3783f55eb10 Jason Gunthorpe 2021-12-15  352  	 */
6df3783f55eb10 Jason Gunthorpe 2021-12-15  353  	if (info.argsz >= total_cap_size)
6df3783f55eb10 Jason Gunthorpe 2021-12-15  354  		info.cap_offset = sizeof(info);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  355  	info.argsz = total_cap_size;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  356  	info.flags |= VFIO_IOMMU_INFO_CAPS;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  357  	if (copy_to_user(arg, &info, minsz))
6df3783f55eb10 Jason Gunthorpe 2021-12-15 @358  		rc = -EFAULT;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  359  	rc = 0;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  360
6df3783f55eb10 Jason Gunthorpe 2021-12-15  361  out_put:
6df3783f55eb10 Jason Gunthorpe 2021-12-15  362  	up_read(&ioas->iopt.iova_rwsem);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  363  	iommufd_put_object(&ioas->obj);
6df3783f55eb10 Jason Gunthorpe 2021-12-15  364  	return rc;
6df3783f55eb10 Jason Gunthorpe 2021-12-15  365  }
6df3783f55eb10 Jason Gunthorpe 2021-12-15  366

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
