Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7546A4CB36A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiCCAM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiCCAM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:12:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034548338;
        Wed,  2 Mar 2022 16:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646266301; x=1677802301;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4rPkGRHSpt+zL8XzBGFqCM9fB8qpvvjx+LeuoVpF+jE=;
  b=CsfKgAKd0EwgwXN04xmBq+No6PP0bfIyaEp4mO87sMyrVxJ1rr02Wz/G
   GrlmpCwm++znW3FuEMbBR2OGnQ9rxvTeO6r+0rGxmaUOG4Sq/vp3StPg/
   2nKzpt/DSusGysV1ndRoqW/wj71tnM9gdIDSxxqRBTmXL0+Vlxk9FzOYg
   GiF+hsxNBXa3T/IAXG83udLoLMIMo4i6gOLXa5cJ1SiHdGImK/priEiKk
   NJaklubkb6Rznxf3mCFc93L9DjBzxqMi41aKXgdZU352dyzY1hTsTLlGp
   3PFzfEygmdr6cTPbFUxcphERkOUE0qYI0nNCUC1Ty2VY0+SLhEPuj8qj3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253717179"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253717179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 14:57:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="639954540"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2022 14:57:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:57:54 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:57:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 14:57:53 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 2 Mar 2022 14:57:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5BQ8MIRg7L4lNEpkIw8C9sHM3ASzYQDzhkEvzqWJPYpgSM8hLuOrL2MFaCxFFFgazYFlPFmQBslK/Kj88AaCgsy1DhpgW/+6gR40BWAzbcRubNvZfNoBUKhEO1ep6QUOZdZWBNMbEu96Lo1op+qFaLbLoB8JlzW9EvRYIh66+57gfBM/MwQUMV+5P4Vy6xZmluyu7QARDqpukR859AFdlEgM97KSDVBbtHECPMdz4aJQAIXcKadU3D18z2f+jCE8dixid/Xx70PpOtNOtrOtybIDoGkVaNwynoVuWjJV0HELBZ5EJVHtC9bgiPrCNA5FNsjo6zU0lFYIOgHlwm3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi5nwuYKdrwcmOYEuBo4PowInPSwM1IR2DbIxKdgAq0=;
 b=kXmNJYEgAHoDU6vxlnFuAkn+OKxFYPQx9te5Vz/Tr/GqTPC75bIpKPWJQ4miVlLn4kSr1UskefokWV6IqC++lybF4381YPaeRTmZra/1VzMKrKH9kjZPgR5sBDHnXqcghuo/JXMuke9OCwtOyEYfof0VD57rPmR5zS8G7YoM1g9ihwCYfFxWlPJFV+Ox0+Sf6Mn3LLtJWKF0wHGkBsDNZyArsJUsPWOrpTMivQlj/0sgCO6k9YFejBqFz4c3CP3rPMo5jbQg+p+2wvh5OPm0ejVhxU9ze3HV6AAaXL7vybLnFnluIzopCudeGdsO+TLEH/6hX0177gFUkbIqqmUaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM5PR11MB1849.namprd11.prod.outlook.com (2603:10b6:3:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 22:57:50 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 22:57:50 +0000
Message-ID: <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com>
Date:   Wed, 2 Mar 2022 14:57:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi> <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi> <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com> <Yh7Q5fbOtr+6YWaS@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yh7Q5fbOtr+6YWaS@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:300:6c::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd6f4a9-6235-420e-f9bb-08d9fca01323
X-MS-TrafficTypeDiagnostic: DM5PR11MB1849:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB18490C9D5CCA77A3978EF5D2F8039@DM5PR11MB1849.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8n7XdOw07BQDmFiLvHprkLw7gFxj13+pUk8Hp9ZiBJqsH7k+RJ4xtRo2u4QQpH4fIJZ1WPbzHxebYHQK5m6QPfCuYt39xjGAU3rnqrYkm5T+XMZv1lZKnnwO4lioboCdDAUphq2WnJpuXBHnzPh/LieoPyhpsznaUYViSKPq2CL7IiRF2PLXXYy7w9xtkQkeyejFGWH1JRohoCbiX1RxBrmyYkDC3JRos/mCVIzHnIEiyde0zm52sK2E337d3rIDwCbmq3do3Qqr1f3wAPfluBvmN1GJxXxdG2LDN4GRQsFNwSg6bmv06Z+LxO0dQtLYT2R3A2Oi+zL2DaGA0cwUcbIFqBIANUKfza3k29NIDEHzn1p2znzK5UijIs5fnlpxEEMmonyW9aXj37GWzpHFU09Ejae1i/fpbUYhUyeuQSjYNg1DiY84KDcQ8IpYZ4yYmSJQdbHBTasa8QpBTmriZP9QPAgIt5eisHSvelBKjIGf8QaEFyGFlmoiGQ4U1PLPLEbyF+bNsXSIe8jqDRlj8E+WCyBbL6X6kmnjw17FcVjd1de52EjqyRyclJrvzG+XQrMIKaN1b+H39AWViGpWqntGq7MKzx1vTCqnVPpuuI2WcoUxPjAqz8vpzKLGpDqr7Uq8tOVEnjIV65SZxn9kSDvFVVmesIe3bjFKQR/L5MfYBMgxZdCUypJnyeT+ifQKkFP1//ISkwDE9yK1e6DpADgbl90Hlwspu2m0YPra6MT/y2tWe5+C/iTT54QkNfLirOjGOLskvXvZYEFdPU1tJwKYvsSLDzFkAxsQRCaug7cetCEYo25+NfstuV/PwsZOoV2y/KkyYcpXgqw+lvDinVY1YylFMX97NHQyUDuWJsyBaHT8kL+9nGintuV/L1C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6666004)(82960400001)(966005)(53546011)(36756003)(6506007)(31686004)(6916009)(508600001)(83380400001)(54906003)(38100700002)(44832011)(6512007)(86362001)(31696002)(7416002)(5660300002)(316002)(26005)(186003)(8676002)(66476007)(66946007)(66556008)(2906002)(4326008)(2616005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHBNUEpwYjlFL0ZOUDBERHQ3azVzMk8xbzh0TEtDOTdNaXRKMHBwTnhnRU5m?=
 =?utf-8?B?L2hBVm16TytqRmRHVlkrdHpuVVNIbkpnYU03ZmU3NGROQUdiV1M3NGdGRy9k?=
 =?utf-8?B?YkJCWENESUlVR0J1TW9OKzVXNWV1eEQ3QUpHODhYQmVkR0RRcDhVbXM4dXFK?=
 =?utf-8?B?OGUrUElxTDFsS1dBSUxEdGdDZzloNFo3a0dTbDJLVDhnOXA1YkdyZ1hJd0Zo?=
 =?utf-8?B?dktmWXVuOHVXOTdZNlN1c1l3dTdDK3ZxQkpEcGo2bnhoTUlqNWQwdlBhRk5I?=
 =?utf-8?B?UUtBRGNPZlE4Lzd0d3hZUzE3RkgzN2ZoK2FjRXNqZHV4TVZoUDdBR29JcGtl?=
 =?utf-8?B?cC9kYWdjTjZ4NTNkOVllcHVGNnhvN3I5eTdGY3JLaGVnWEJsM3JoZW12MTFB?=
 =?utf-8?B?b09IRjJMY1dhYWVremQyY2Y1c0o1VDFqc0Jnb2VTMU56M3hGOHdEaG9CamVp?=
 =?utf-8?B?bGQzaVg5M2pSRE4vaWdCVU00NWx1eWtCR2lYL0dzeVRIS1AwQ25HaC9LNjQ3?=
 =?utf-8?B?OUVwVWlnYlRXZCthMWpVZkJITjFDWldsRXl4aEQ1dUViTlNkQkYrWW92MHBx?=
 =?utf-8?B?b204K0REaHJYWnJQU0lFYVhoVnQzKzdSUGZnUE83UkFCZ05hK2JaME9IVmU1?=
 =?utf-8?B?Vll5NFNCcVFKKzJybDN1N09WRVZ3T2hSOXlSbkIxNnU3L1p5MWp2NTRNeWNi?=
 =?utf-8?B?Z1NzeFNCbm1vOGZWak9ESnp2bmNjeWtSdUlhSW1vbEtRNWJ2WDNWK051NWJq?=
 =?utf-8?B?VEVGTWo0QnFZZWFjUzUrNk1mMHNXUktMMFk3ZC9pdEFWeGQxZHZRRTNjNkNr?=
 =?utf-8?B?RVU1VVF1OSttNm1QbHFQalkwM1Ivb3dicFRCb1lDNGZtelk5SXQ3QUlwcDFp?=
 =?utf-8?B?WWxydmRmZ2ZBL1gyeXVlc3IvOEpQRkNTWWtCbXppL0xKazNzak9yempjOXFK?=
 =?utf-8?B?M0NXT3hSbmpmbDNLQ0hZR2VGVTVJK2NHMjZ3V0ZiZ1VLbFBFRVNuNkdNRXdB?=
 =?utf-8?B?Z3NKMVpRcFUvaE1VeVV5RWJyb1oxUTQrQXlkQldVT2RHdE12ZGJkejlYSVpy?=
 =?utf-8?B?YVkybGVYaVdtN3docEY4OUtIci9RcVk3SW82dmVQUWVGSXBGdWV0ZGxzdFNl?=
 =?utf-8?B?YytidUxqY0ZqZFNCVUhscWFQbVM1QWg1bUdhbStCdmVHSFAyOU9lb3Y2aS9q?=
 =?utf-8?B?bnhjREhwMUpPZS8yZG4vMlo4NnBuUWhsVU8vczhYRUFwTTdUMWhnNlMrdzR5?=
 =?utf-8?B?aGRHenlRM0FDczZpMi9MY0p0RVZ5VTF1L2xjNDVnN1VpZTV5WDdTVU53Q3Bk?=
 =?utf-8?B?NHRNencxNytFWFZjbklSdU9lSzZVQjNNV0hUUmEvSnlTMnZzU1crQUxYdmlj?=
 =?utf-8?B?dFgyR2JWMnRoRDgxUnJiTVNwQkFwcGY5aWZlSEIyWHIwdE93akpIMlk2RkdU?=
 =?utf-8?B?VkRxM0VDYzRHbHRIQlZRQW5uZkxsTTRYWUg0cGgvNnRlRWxaQWorOWcyT0xm?=
 =?utf-8?B?S21HTDB3cSsydkxQTTB2Ty9JL0tyYVN2WDREQVU5NCtDdXF5SSt6cUJvRkhh?=
 =?utf-8?B?UHdWS0ZxbGRnTXRIM3BZN2ZxbUc0N0IzKy9uMVNqT0ZrTEtnNkhTNTQ2M3lT?=
 =?utf-8?B?NmVRTVNnSWJ1cDB6VlBYb0QzOGRJcFRtcjk0MTdzQmlKeWdacWFRZER1R1pB?=
 =?utf-8?B?emxPYU5zTC96U1AvUkd5OGd6NkxSUUQxbmlMNng3NTlnWThiazhCOU5SWWhI?=
 =?utf-8?B?YStjc0FtZ1h5TEMxc3hzWUpmWnBDLzZuRGhPSTFxbWlOVyt0aUtJTUdidCtH?=
 =?utf-8?B?T3RWOGxyTHMwS1NXNm9YdG8rbitkV0NxeVVQT1VxZUZ2NVIvbHR6WTA5bmZT?=
 =?utf-8?B?VlEzRzNTTU1vVGErQUN1TDJWWVNqUExnNHdsMXRmeWR6a09HRDE5QnBSL0hp?=
 =?utf-8?B?NnExTUY4Qlp1UThWSEVFSGdnanhTbEc0YUhMV1BhVng3cGQ5RFBWdlhRdnNK?=
 =?utf-8?B?WTkrZlJ3YnNUZjkyZ2wzRzkvS0s4QXV0QzhYUE4vR3ZtVENNbWFsTDI4amQ1?=
 =?utf-8?B?V3kzbzhyV1QrSUo5SEVxYTFjYUtnNlAydHVoVkpRR0E4VU9TZFUvRUxtRzB1?=
 =?utf-8?B?eDR6WkFldWtzSURKK1dxRHBsWUUyd21sZjZ2bjQzcFNvYkdnVHRWSDNMVGR3?=
 =?utf-8?B?Yys4TUNEUHFQYTFHVkJ3TTBKeUJaYmRydit2NzZqYUV6b0wyLzZCQnJnRW1J?=
 =?utf-8?Q?+grgsiBqHNyhRo6ok4lMIqes2hvUVLEox3q5TUq3xo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd6f4a9-6235-420e-f9bb-08d9fca01323
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 22:57:49.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvmyN8S/FMugcyCQ+Px6HzbPBjyH+rqxJXcMw3lsDFtEewOK6YCJDBqMjp3eIIEf3ySEYb/fyR3U+44OpT4sFUFe8MDqXU5oEiabBawNaUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1849
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/1/2022 6:05 PM, Jarkko Sakkinen wrote:
> On Tue, Mar 01, 2022 at 09:48:48AM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 3/1/2022 5:42 AM, Jarkko Sakkinen wrote:
>>>> With EACCEPTCOPY (kudos to Mark S. for reminding me of this version of
>>>> EACCEPT @ chat.enarx.dev) it is possible to make R and RX pages but
>>>> obviously new RX pages are now out of the picture:
>>>>
>>>>
>>>> 	/*
>>>> 	 * Adding a regular page that is architecturally allowed to only
>>>> 	 * be created with RW permissions.
>>>> 	 * TBD: Interface with user space policy to support max permissions
>>>> 	 * of RWX.
>>>> 	 */
>>>> 	prot = PROT_READ | PROT_WRITE;
>>>> 	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
>>>> 	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
>>>>
>>>> If that TBD is left out to the final version the page augmentation has a
>>>> risk of a API bottleneck, and that risk can realize then also in the page
>>>> permission ioctls.
>>>>
>>>> I.e. now any review comment is based on not fully known territory, we have
>>>> one known unknown, and some unknown unknowns from unpredictable effect to
>>>> future API changes.
>>
>> The plan to complete the "TBD" in the above snippet was to follow this work
>> with user policy integration at this location. On a high level the plan was
>> for this to look something like:
>>
>>
>>  	/*
>>  	 * Adding a regular page that is architecturally allowed to only
>>  	 * be created with RW permissions.
>>  	 * Interface with user space policy to support max permissions
>>  	 * of RWX.
>>  	 */
>>  	prot = PROT_READ | PROT_WRITE;
>>  	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
>>
>>         if (user space policy allows RWX on dynamically added pages)
>> 	 	encl_page->vm_max_prot_bits = calc_vm_prot_bits(PROT_READ | PROT_WRITE | PROT_EXEC, 0);
>> 	else
>> 		encl_page->vm_max_prot_bits = calc_vm_prot_bits(PROT_READ | PROT_WRITE, 0);
>>
>> The work that follows this series aimed to do the integration with user
>> space policy.
> 
> What do you mean by "user space policy" anyway exactly? I'm sorry but I
> just don't fully understand this.

My apologies - I just assumed that you would need no reminder about this contentious
part of SGX history. Essentially it means that, yes, the kernel could theoretically
permit any kind of access to any file/page, but some accesses are known to generally
be a bad idea - like making memory executable as well as writable - and thus there
are additional checks based on what user space permits before the kernel allows
such accesses.

For example,
mm/mprotect.c:do_mprotect_pkey()->security_file_mprotect()

User policy and SGX has seen significant discussion. Some notable threads:
https://lore.kernel.org/linux-security-module/CALCETrXf8mSK45h7sTK5Wf+pXLVn=Bjsc_RLpgO-h-qdzBRo5Q@mail.gmail.com/
https://lore.kernel.org/linux-security-module/20190619222401.14942-1-sean.j.christopherson@intel.com/
 
> It's too big of a risk to accept this series without X taken care of. Patch
> series should neither have TODO nor TBD comments IMHO. I don't want to ack
> a series based on speculation what might happen in the future.

ok

> 
>>> I think the best way to move forward would be to do EAUG's explicitly with
>>> an ioctl that could also include secinfo for permissions. Then you can
>>> easily do the rest with EACCEPTCOPY inside the enclave.
>>
>> SGX_IOC_ENCLAVE_ADD_PAGES already exists and could possibly be used for
>> this purpose. It already includes SECINFO which may also be useful if
>> needing to later support EAUG of PT_SS* pages.
> 
> You could also simply add SGX_IOC_ENCLAVE_AUGMENT_PAGES and call it a day.

I could, yes.

> And if there is plan to extend SGX_IOC_ENCLAVE_ADD_PAGES what is this weird
> thing added to the #PF handler? Why is it added at all then?

I was just speculating in my response, there is no plan to extend
SGX_IOC_ENCLAVE_ADD_PAGES (that I am aware of).

>> How this could work is user space calls SGX_IOC_ENCLAVE_ADD_PAGES
>> after enclave initialization on any memory region within the enclave where
>> pages are planned to be added dynamically. This ioctl() calls EAUG to add the
>> new pages with RW permissions and their vm_max_prot_bits can be set to the
>> permissions found in the included SECINFO. This will support later EACCEPTCOPY
>> as well as SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> 
> I don't like this type of re-use of the existing API.

I could proceed with SGX_IOC_ENCLAVE_AUGMENT_PAGES if there is consensus after
considering the user policy question (above) and performance trade-off (more below).

> 
>> The big question is whether communicating user policy after enclave initialization
>> via the SECINFO within SGX_IOC_ENCLAVE_ADD_PAGES is acceptable to all? I would
>> appreciate a confirmation on this direction considering the significant history
>> behind this topic.
> 
> I have no idea because I don't know what is user space policy.

This discussion is about some enclave usages needing RWX permissions
on dynamically added enclave pages. RWX permissions on dynamically added pages is
not something that should blindly be allowed for all SGX enclaves but instead the user
needs to explicitly allow specific enclaves to have such ability. This is equivalent
to (but not the same as) what exists in Linux today with LSM. As seen in
mm/mprotect.c:do_mprotect_pkey()->security_file_mprotect() Linux is able to make
files and memory be both writable and executable, but it would only do so for those
files and memory that the LSM (which is how user policy is communicated, like SELinux)
indicates it is allowed, not blindly do so for all files and all memory.

>>> Putting EAUG to the #PF handler and implicitly call it just too flakky and
>>> hard to make deterministic for e.g. JIT compiler in our use case (not to
>>> mention that JIT is not possible at all because inability to do RX pages).

I understand how SGX_IOC_ENCLAVE_AUGMENT_PAGES can be more deterministic but from
what I understand it would have a performance impact since it would require all memory
that may be needed by the enclave be pre-allocated from outside the enclave and not
just dynamically allocated from within the enclave at the time it is needed.

Would such a performance impact be acceptable?

>> In this series this is indeed not possible because it lacks the user policy
>> integration. JIT will be possible after user policy integration.
> 
> Like this I don't what this series can be used in practice.
> 
> Majority of practical use cases for EDMM boil down to having a way to add
> new executable code (not just Enarx).
> 

Understood.

On 3/1/2022 8:03 PM, Jarkko Sakkinen wrote:
> I'd actually to leave out permission change madness completely out of this
> patch set, as we all know it is a grazy beast of microarchitecture. For
> user space having that is less critical than having executable pages.
> 
> Simply with EAUG/EACCEPTCOPY you can already populate enclave with any
> permissions you had in mind. Augmenting alone would be logically consistent
> patch set that is actually usable for many workloads.

Support for permission changes is required in order to support dynamically added
pages (EAUG pages) to be made executable. Yes, you could make
a dynamically added page have executable EPCM permissions using EACCEPTCOPY
but the kernel is still required to make the PTE executable.

> Now there is half-broken augmenting (this is even writtend down to the TBD
> comment) and complex code for EMODPR and EMODT that is usable only for
> kselftests and not much else before there is fully working augmenting.
> 
> This way we get actually sound patch set that is easy to review and apply
> to the mainline. It is also factors easier for you to iterate a smaller
> set of patches.
> 
> After this it is so much easier to start to look at remaining functionality,
> and at the same time augmenting part can be stress tested with real-world
> code and it will mature quickly.
> 
> This whole thing *really* needs a serious U-turn on how it is delivered to
> the upstream. Sometimes it is better just to admit that this didn't start
> with the right foot.

As mentioned above, from what I understand the support for (as you state) the
"majority of practical use cases" on dynamically added pages do require
supporting permission changes also. It thus seems to me that it would help
consuming this feature if dynamic addition of pages and permission changes
are presented together. The SGX2 functionality that remains after that is the
changing of page type, which forms part of the page removal flow. In this
regard I also find that presenting the page addition flow at the same time
as the page removal flow would make these features easier to consume. I
think supporting the addition of pages and leaving page removal to
"future work" would be similarly frustrating to consume.

Reinette
