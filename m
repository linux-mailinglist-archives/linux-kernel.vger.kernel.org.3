Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EACA4F6A23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiDFTmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiDFTmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:42:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94F6005A;
        Wed,  6 Apr 2022 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649267514; x=1680803514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e3PAH8KNuq0G7/EEf+7+elCQECWG3SBCQhimjF6jxlM=;
  b=jydN0xdUNlaaAijI/xgOlcOnhQvlSlYVUvvPTVYpAUrBqJRLSiO1uK5w
   DsegdeOZkX1n+thgjZHmhVS0xxGkNesSibHYesbHdGTQaL5VbZAT8Zqcd
   +IvI81kGD4eyWnwAT/tguHLFbOqakk12nNrYze5Git6F53JcGNiBYQYto
   u2hLOm1/Oy0iqOJGFwzt289NPfBPQuHt7Szka10FWiyQPZuV+MtC7D95/
   Q4VX3SaX7mYPozMD29n97im07S3FBU4oIoGf3PdTNFuBraOb/LruI0oza
   cxGN6bWHs5KF1xYIbN6Ir7t0OJX2IX58Umr1RyfwBy8Q0fXTR4JaXF/yS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="259952300"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="259952300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 10:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="652473848"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 06 Apr 2022 10:51:53 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 10:51:53 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 10:51:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 10:51:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 10:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iilW5p6QM6LW3DMTeoJd7iYk7h8NymG/4BOKDi+fmBl8HuIVZ0zMUgxRvgGA+LFD0y0k2sBUpOJk/R7EPL+8GrSGEMred++87MyN9//LsfMan4Xh0sl7LBL172s0sP8zdjP56j0HafEAqe3i/mkN4eX1x6lOhoqiCamZtkjCXUkqF3hXD75hmbUzwjWNMqh6bbOzrgkyLYZ03KwULUX6tSufE/cW5c2oZoraJsyrUdS5DQmLPPHXVxMfBet26W3OsO4H/8mTo8/95uldbKt0uaQs7tPoI/QfNGVeHdT7pUZVKGRLJHdTEEp63TT1TUKNHtzdWmB/6ziXUzHyKaOoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdegSsy7Rsou3x7SV08IckIWrZ/u8yKsI0rEgvk+3lo=;
 b=NfA3UrtUUW+dC1pM85ZQAb/ZWouHnNrFcpOJwnzGcLbZDYz8D3t/R1dAdoxF6sIj0/+afQX1xWjPvEZOEDH9rYzPo2ESwKkm8EStobu3NrcYruovDLjmvLRaRXcYG6LgGAkeg+Mfb/pDDWj6o/l7oE+sTOBwe20aoMut9wL2hhnBUrNDmEpy1vJQouQ6p5jdyy89FJwlFghN6xBV/BlJaOaQZrDW6uKKTEXhdcs2yYDufyB+eZ9M6Xc0bE3C107Yon8ImZx3xQEiXlxVtrcAoIvr6VCWxxJifLfF73JkOZKJi2r6XKVq1vVRr2OzeHpSqNs620UuqOMrgJwdZiMrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BYAPR11MB3303.namprd11.prod.outlook.com (2603:10b6:a03:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 17:51:48 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 17:51:48 +0000
Message-ID: <8010f544-852a-d7cd-3c3b-4e9cbcef3ab9@intel.com>
Date:   Wed, 6 Apr 2022 10:51:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 14/30] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <nathaniel@profian.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <8ed9ee98ca26c9eefde0fd49062bca6e7b9efe80.1648847675.git.reinette.chatre@intel.com>
 <c9071aa19076c7c618294f0c9cb830a8be96ae09.camel@kernel.org>
 <26ab773de8842d03b40caf8645ca86884b195901.camel@kernel.org>
 <91a02d50b2cba34dfb058fd864ba20ef1e6a5554.camel@kernel.org>
 <10303ca73ea02a300636580e87446766374f66cb.camel@kernel.org>
 <6e0feeadc562b9e3f0a524040469d4f5c3484824.camel@kernel.org>
 <ca08465b6fa8af4121592c6381023fda5e0ade70.camel@kernel.org>
 <59910ad4-a898-4eb2-5e2b-856c686b53fb@intel.com>
 <0f44fba956288bcad69e076f84118bc50f8e5d2f.camel@kernel.org>
 <38603303-f683-cb79-57e5-57fad5c5ae3b@intel.com>
 <2bf954521a3cfc7c677887b1eef772cfcc9e3157.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2bf954521a3cfc7c677887b1eef772cfcc9e3157.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::33) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b526051-9674-4f19-f8a6-08da17f61f44
X-MS-TrafficTypeDiagnostic: BYAPR11MB3303:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB3303C89390E3622AC5395968F8E79@BYAPR11MB3303.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfXor9kYkMswo+xc8/rfCYoKaBvseYVtDaoESU0PQsU/NrBPbfjKnarD5+6rpev+mgBla3fcUOtchw0CgmQIVg712uQwrdRdB0VLRX6vttyiHYyoe2KjWoVQ21+OefXEKa4oYikMnZGAhZ8YKBT7EtGnaYdQRpUiFw6mHI3GobXA0qjTEjYQkpn2i1xFWbW9QO9SYKqvBLH9QP5uSfrN0CBouS4FIY3nZJk5Qv5tWS/q7wYowzLoRqx2S07PAL95EnNsxg4BalEwRb+/NlA1alnat2VmSVtwaXxrLpM4fzcHmV1Amr+F7t43MeURwIShMhJNnKgvsEU5C/LwCaGpEBXoMVx9VvescchoQ60p8icpg5qYhxIELYeOvQEoS9KxLPQCezd0nN1CDbqEgt9HyqsTQ7bG+cTeXJ4PBUmlRT3KwAoDq76O8mVvWwTadhVW2S0cUVIc1g5ZK+o2fJOBPGDt1fi3gKdqYaIvtBJsUnZqmsEBRZzOWws/psAyyPz3G5Ek5RbA6mI5SdkX11WITpBKCWTWEEekAyivEBq8I6Zy0d31LV2szH2M0ujhi0BNsqynIGZKYA/X2A2k6TeTB0WjduVeRKks6pb6hPqV9lgULWIKbwwvcW4Iz2VxUHMRtMdEKQrRk5s7ZQ7YNtxFHbnf6EhKTbo0MXms+/kIALFeDCK3GCfzuADG+u9+9DAxOD2sckoetKezgJD5eP5UhberywZTurHVn7Pu2xsZrau4etpQMJTgDnZmoLl0xzK9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(44832011)(6506007)(36756003)(86362001)(8936002)(508600001)(2616005)(31686004)(31696002)(6486002)(5660300002)(2906002)(38100700002)(26005)(83380400001)(316002)(186003)(6666004)(82960400001)(8676002)(6512007)(66476007)(4326008)(66556008)(53546011)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVkMjdzaUduaU5taGJUYmdjQ0hCanF2dm04QVNSOG5aNC8yOHBFeHQvQ0NZ?=
 =?utf-8?B?MnV0UTdrU280a3BmbmI3Z0xpTlF2ZjI1ekUwUnE4YUFqdGNnRDk1Rlh6UG5X?=
 =?utf-8?B?bVlqV0tKSXBPYjB0MTNJd0FFanNsc0s5V2FPT0FJczNadzlPbjFJMlVSbTZ6?=
 =?utf-8?B?T0ZrVXJXeWFJMVRVeHFOMEJCZk00a1NzalI3Q1MxSGkyL0tNdTBYRmE0dHZR?=
 =?utf-8?B?dk04L1N5NTZvOVVpSVJXZE9ubUVzajdKSklBU2E5RWE4cHBiUFJlWEhwZ05E?=
 =?utf-8?B?TmRDdDlTbGowR3JwTzBteFE0cElKcWlCc1BDU2k3QUR6emVJUHJNbEdCdXZZ?=
 =?utf-8?B?bkQ1WFJNSGdTeTZuSEhTb2l1RW9IRkRLWVhFZzNZZG1xdzJXS1lVbzhDR1dI?=
 =?utf-8?B?RzN1QnN2eEVOMyt3UFNkZDNMZmpEcGV0M0p5cktEc0o2UUc5QUs3UEtUTDVR?=
 =?utf-8?B?Y3p5K3hGV0QyUzFyUGFJMUdjV1lDYlhyeEh0VmF1ams1YXVmdnVRalk1cXlP?=
 =?utf-8?B?ZXR1VitJR2U3WEU5bDVrR1RpN2tReW5iWnZ6RHZCdmpPeXNyRERXN25Ia21w?=
 =?utf-8?B?VXBDUWZvSDBnTHAwRzduU2JJbnRhVjBhaXJqbmxhcUJHSG4rOVhhUHE2MWZy?=
 =?utf-8?B?L3ZKQWI0aFVSVWp5cS9MNS8wUlV6RXBtZFBKNDZPVEN3UUkyaFRkTk9ZMVJZ?=
 =?utf-8?B?bVFZQVU3d0ZsSzJOZEtCQ3Z1d2t0WnRISE9vTjNYZzkwMHRSV1RNcS84TE1V?=
 =?utf-8?B?dnNBLzlkSlovY1ZwNjN4UnUvcEFOQ1dWRFhPT1lGZTRuVkhhRzUxMVFpYnVy?=
 =?utf-8?B?cjRwbVZsMGtuNEQxTXF6MjhaWktEM0tsWTZGdld5ZXJqQ3FTRFEzN1ZQQ1ps?=
 =?utf-8?B?QTNuNjZpZGVkRTl6Zlk4eUErRloyek1UN3ZMbWRrODRwT3UxWnMrN3B0TjRM?=
 =?utf-8?B?RGIzei9xZndqUEdDMHBGcnE2YmN6bUt0cU10UWpqS0VBMjBKL2pyUTZFd3lJ?=
 =?utf-8?B?STZuQ3dNU292d3RuRFF2dXBxcXUvV3d0dEhGWFI5MEhGUEpCSzhiZFZiSWQ2?=
 =?utf-8?B?OS9ENUowUEloby9RQkkvS0YwbFh2cVUzc0Rubm14YkJFUWM3cy8wSXNMdVpR?=
 =?utf-8?B?dEEzUzVjVFl1NXYwUjdZSWVOWVZiVkRPb1J3VEIzTXV3MEdTSmVuYnpLTjFi?=
 =?utf-8?B?K09aMGVCamp5N1RPZVNiK3pwNmhYVkNpS3NNem1ISldsZkRWNHVTaUdUOVVH?=
 =?utf-8?B?QzI1bDZ6QWlBeVh3em9HdXUwVUFoaEhLa0JML0lYN09VUHZtVm80bGhZL2dD?=
 =?utf-8?B?d0RDYUZ1RzNNRXJ1RVczU3E2VVllblJzR0hZUW41Z3RuRzR4VytJMGZvbS9u?=
 =?utf-8?B?UDlIdnZtREMxdG9pbWcxQ2FKWWJlMS9UMXVtbEJBK0c5aWlEM29selFjQVBQ?=
 =?utf-8?B?ZENxQjBLaFJvUmNlZkVPZGYrNXJLTUlWN1NLN3BWS1ZTcEZRbit0SkpNSUFP?=
 =?utf-8?B?RG01VXZNMjFVWmw0RlFYN1JZdzQ1WDg4dUtQZkVrbkM1dkRabzhTN1h5VTVS?=
 =?utf-8?B?QW9HQ1lWSXhRRHBwbnFFL1JvRVNJYnlHOU5VUktkTXNQbCtkZ2Q4a0NETnpa?=
 =?utf-8?B?L0o4NGZyd21XWW81dDNOSmhtWkRQSUExNG94eDM1K0I1TjI4eVlabTNVRjdh?=
 =?utf-8?B?eWM5aFVqdTNhamo1OEg4bXRnOWp3bXVnRDhXUkFNTFBMaGI0ZHdURjBzbTFu?=
 =?utf-8?B?dStjSEZiSGZrSUVramNNQUtnb1ZLQjh4TEJ1Z1R3SnFQSllzdU15alZGS2s1?=
 =?utf-8?B?YUEvR2J4RjE2cVFVRzM1a0RLVmNDclJnSDZWUlVGVzhkR1FRNVdJRjh0eHl6?=
 =?utf-8?B?RXlZRkZKWE9LOXRGNFZpRFRlN3g5MU50UWdVUHhEZW1LVk13RkFwdHRJdDdC?=
 =?utf-8?B?S0w3d3BRS3FBNTE4SGUrSzZzMGkzaFJTQkcxUDZwYnBpWWpKZWQ1NjdsaUpk?=
 =?utf-8?B?V3M4RXpRQ3E5Q3dBbjN6UFJtNG1mT0dpVEFUM2NhWHJUU1VIcmk5L3VYUE5u?=
 =?utf-8?B?d294a1RZZCtaRnpFb3djU1ZJakEvSDRUcHZKL003ZGU2K3V0WkxtSWs0UlVw?=
 =?utf-8?B?SjNBSGNlOWt5TStOUnNzenQxQ1dQQnZRWjJCSVpDaXg5N1NtbG9Fa2tHaitP?=
 =?utf-8?B?enZvT3JFMDJWVitqbEZxQVpoNVRkVHVHSkpRSmk5WEc4SDNUeXRlSGZvLzNl?=
 =?utf-8?B?WUZxTjRBRW02YW5yeVFCVzZqOFIxVnZKbDl3ejA3ZlIxR1BsajRGc0JDREd4?=
 =?utf-8?B?cmlSbHRERmpDNlBPSTBPeWdPWjJwMStWVVBmYXF6QnVzNkdtaEVGR3p0NTJN?=
 =?utf-8?Q?Lmjdf7cv44WqAgaA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b526051-9674-4f19-f8a6-08da17f61f44
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 17:51:48.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/h4cRodUvEELmnmh56bhHhEeq4ZqgGcaYRXImsXBaMRhZKDEJh0yfjhhE16aRDXw3EQg+QKz9JzgAgHvXpFJKInCbD/hrmPywdGeQI7VM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/6/2022 12:30 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 11:59 -0700, Reinette Chatre wrote:


>> I plan to replace the current "secinfo" field in struct sgx_enclave_restrict_permissions
>> with a new "permissions" field that contain only the permissions. Please let
>> me know if you have concerns with this (I also discuss this more in reply to
>> your other message related to the page type change ioctl()).
> 
> I'm cool with it but if it is named as "permissions", then 
> it is already software-defined entity, i.e. meaning just that
> have this check in place in the ioctl:
> 
> if (addp->permissions & !(PROT_READ | PROT_WRITE | PROT_EXEC))
> 	return -EINVAL;
> 

I assume that we do still want to ensure that
PROT_READ is always set.

I was planning to keep it in the "SGX language" since
this is about changing EPCM permissions with values from
a runtime understanding SGX permissions in secinfo that will
be provided to hardware understanding SGX permissions in
secinfo.

Thus:

if (params.permissions & ~SGX_SECINFO_PERMISSION_MASK)
	return -EINVAL;

if (!(params.permissions & SGX_SECINFO_R))
	return -EINVAL;


Reinette
