Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0C4F4CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579562AbiDEXbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457861AbiDEQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:52:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288BE326E6;
        Tue,  5 Apr 2022 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649177408; x=1680713408;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x7xiRfIyzHS7av8WvGI8emCoulx9khjBeOPKOj6bN28=;
  b=eefOTr6+/+VHgE3asPZRyYzFAbI3vESeRA+M3lo14JYtH8PkIy5u92k5
   KK2KPk9hRv+n22tfH8HfEkwPNtD9XIxQrjjx7Q6ypWUnmUfArcrK5eR5T
   z1+gEUbYWOQ5islLSBGz7dE3Uhdi0yP5hFjER/quqsM7+lPHdcnKpkblN
   ZiD8Nm1K0bizulKNXPxn8cGEPO0rkgB47WDUwcpo69jaiWe9PAAKodYhR
   7LLNrhp1hSi4OF2xXlhbpO91YcvnLeRiaTvgZU+/1lpP/ySUXGj8YJQ8p
   HVWv1wBnynCvem/rLOgww2e0wxHF/j76FD7NjwVL5jyUhBUkh1R8LGyW+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="323972720"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="323972720"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="505353486"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2022 09:50:07 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 09:50:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 09:50:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 09:50:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 09:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih7uQcnWuletcqKaBkgfin74l+Z2eNDGm10bZp4GeAIEC67iBYcRtPja6nLMS74m9BKlVChrPZuB5XpjeKjPqCjJIOawIVGQgX/8HSqE6hB5//XYtt3ZXpYsVdetVpjyS00Xy+Yemi+m7WTLNJIplZe9ZtLvk6m3tzCOQNN8ALdlP20uYUnTOkjXMsSqy6pPCxFWH/+8Rra6DATTwKiGCW+uq8x8OMB7peUG7DWRI0FdadOawESL6XyJk5ToaQX32GcmOoMdJUwbcPIZBo3o11KU14QMjPjrzMobpTQUMT3SyCSKvI1xym9qOt7yaXmYU7+dugsZw71of0joDaip5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiJAwV2FlVkbUkVo4+bz3Pa6FuNW6uZbmTiDtap89W8=;
 b=dWDLVyj7pMxw0426BEukZWb1v+XQvHW5QKWJ1ETRryw7ng8KrEih2YiJLxRKd9yZDiR9DGA0ELA9Qu+x97ChyoyT4L5F2jVK08sI7mlUszY2N7xB3NIhT4xvsy6Uw9xjO1d1AUJcIG/TdiHzJBw0kGdTQwm3a9cQZrcrBoH/gs1P71FNoFhWFR/WRDNq6sobhBXdC/ouTlhNKNNWiTHW1rZVtwJQh0Vl88rAC9jKp3WjjcTer5EqV6qSeyWuhaVZmOBVZPnVq/6d5srwd3dXQPjbfevxnOLrxzA4aF/KmHCcKSxIKlmEJycNwimf/HVb7uCkKEMF/pTCHi7HWDztRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SA2PR11MB5164.namprd11.prod.outlook.com (2603:10b6:806:f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 16:50:03 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 16:50:03 +0000
Message-ID: <59910ad4-a898-4eb2-5e2b-856c686b53fb@intel.com>
Date:   Tue, 5 Apr 2022 09:49:58 -0700
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ca08465b6fa8af4121592c6381023fda5e0ade70.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:303:8d::23) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a3be220-c7ca-4f56-3007-08da1724545b
X-MS-TrafficTypeDiagnostic: SA2PR11MB5164:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB5164B9DAC861E7E107E69F28F8E49@SA2PR11MB5164.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lF88VgRBdKIQCYe6UTHRklV7rfHPld+aPWuiuk7vbAp8OW529RRlWomVlxKYsNHuztWKorW0bLqVfCbz1Qk36b/BFUUCm/MJmRn9r7p1cSjZ480PLXkCyjSTynxfHO4lYu0Up0xZA7qOSJVXhpnp0yRbSSv7fyLQFSAgH1ouaF3gxXEmcZU+/IFsYbRGs7Ggw2P14MXFIA+GmJHQK3w4I4fGRSJXxNLSv6NFjsfvuEMjSP+Y6th05DemMGSfpi8fxOXL6ZusXtP2l1txdXptoTB5yZ3qTyi8F+rxtwwL/m1nHY0vPX2IcQM0mD4icvhGbbgLQ0TA/g04gkI3WCkXELFENXKI/5QYhdwFGtU1gy5Mez24xX8o/PdtNumQXOUol7cc2HtfwiSG7gfCHMtR9NKLmUpN7YLzjUfZmd/ec+PiME6WwccUOwraCWv11MfPQ1WT93C4T6Esa+9g17va9sIFsKPkGGE+8hOCwdxtN1RoXaS5HHVeQBR0NPI8e6Cb0yDULWB5OBuV2F7esiC9BrL71m/lst9VCwArPpZUW/GwfhxKo87Ku5LmZ1q4iS/0ggH224qkBZdeR762fZGeXGDWq2knY+ePn/EOLzJdGhO+x2lhRYx2+dZtd+3mqTGv5mNdqMO0QeqAf5b4G8nDdyVfSPYrMeNQ59UzZkXtt0syeYZ9mWAhAm9DrhP4jyfsdFBunqyn55DiPaT8hcv923e5wVJ3g20uBqUwbATdxs79gfBY+344ut1zcrX1MtBWVif32IbBPmh7D0ggmDqwJ/p4XpCUt3lCEaTEksgodfXiD8myCGBhgXpsLNQ7zJXGiqZi9zvNJWGynWzjKkY6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6486002)(38100700002)(966005)(82960400001)(31686004)(83380400001)(6512007)(6506007)(5660300002)(44832011)(8676002)(53546011)(31696002)(7416002)(4326008)(8936002)(86362001)(316002)(66476007)(66946007)(66556008)(36756003)(508600001)(6666004)(186003)(2616005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlQcFlYZU16WnFFY3lrYXQ4Q2EvYWxyckZiUnkvaHY5dHN2OStORWUwa3dE?=
 =?utf-8?B?bGo5ZTFyRVBRNW1PN2dvUURuajF4eTRRVllYZ1kyaGtGM3I1R1h2aVJZREhr?=
 =?utf-8?B?OFpMRnlBSHRmZXZsd0oxbmFGU21jWTdFYnJoelk5dDVmNGQ2MmhWUEkwSmRr?=
 =?utf-8?B?ZFIwNWtzbWJETHlsWVNSWWo0ckk3UFkvODQ4M3dtVTRRdnFhZEsySEF3U2JU?=
 =?utf-8?B?ZXJod0ltemZUQWROcE9CTkRCVjF0R092TWRkekxycCszVlo2bzFma1puaE9N?=
 =?utf-8?B?bzJJbjI2QjhNRW9Vc2VEUGJtSTFvVGRXU0d5VS9WV3I0SmgzQU9kZHhPVUJm?=
 =?utf-8?B?M25qQUdVQ1pMdUJwV3IvVWY3K2pKdnVFdHpVazAzR3JyajM5UGtQRk1tS2Nl?=
 =?utf-8?B?ajZnekFMdng3aVBxNU9IekdwWGFkY0ZSVDNQck1jNlROWHBERVZHN2c0anA4?=
 =?utf-8?B?MCsxWi9PK0FHeUJuVFdUeGdEY1liNUVuZmo5eURBZGpzeTJzQlBtV0ZnZmgr?=
 =?utf-8?B?bm9nTFRXTW9xajVrNFpnNkdMTGdidG05WGpzTlVXSy85SjNiTkI0YVNBMEY3?=
 =?utf-8?B?bTFXSjRJemZNbUhMSGtsSDBkWjlIUmdHTmtoclZpTWlmd2xZM2dnK2J1MGdU?=
 =?utf-8?B?ZzFkMk1zNCtCcDdoNHJ2Q0Zqb2ExMnM0aUFCZG12M0J5QkVYYS9aemxzTXU3?=
 =?utf-8?B?ZU5Cc2NQM2FodXNNVXJUUGx1UmtQN2IzTGNsOUx0cDBqcUJTVlh3Qm9MUEZj?=
 =?utf-8?B?NWNncVNiOFdFTXJHUVZFYjFZWmRZOHZuaWlpazNZc1dkbDlrcFJhSlc2VDFJ?=
 =?utf-8?B?YlBuckJxVFNPVVpIVEV6LzNUV3M4RktJbDUwZTZEOFN2L0h1VmljMTBoZTNh?=
 =?utf-8?B?MnNKZ1lsS1pTeVNOOG9jMm96UzB5WEd4YTBnRWU3bTVDaU5URE4rSUZsWW9Y?=
 =?utf-8?B?SkY1MFRzdzNvV1crSmNhTi96dG9zSHIwVU9LTC9BT2VIRFNUUENsZkFqSmda?=
 =?utf-8?B?YmQ5Y0FiNzhZL3FDNFR0OTZveFBiRlBya3lVanBqY3BmTVlReFE1ZFZ4WFhj?=
 =?utf-8?B?TndCOTE2S0F4eFNmZjZjSVVNMGtVR01xcTZsSjhoT0FVRkdoMjFsWVBCd1V4?=
 =?utf-8?B?VzRLbmJJR1NMZzVmKzdLUVpZb0NpQTNqWGJLdDlRT0ZpaURXbnBDQkZ5TVln?=
 =?utf-8?B?T1V6M0ZJUlNTUjlQd0QrZTc4YlIxUERaZG5oaTNwV2JZY1RIY1NQaW4wbFAy?=
 =?utf-8?B?NG4xQUppTGlpS2dMVVBnaWFnQVlZcWR3Y0U3T0dVQTA0eStnK3ZqLzZ5OUY0?=
 =?utf-8?B?TFprRTU2M2p1Y240NG1hdkVJQ1dObm5laHFwQ1ExcU9sOHV6MDNLN3p0M1Bn?=
 =?utf-8?B?RXI2bHBIYXRSQzFxUGJ1STlwWFhJcHdKSTZjUkdZUVhyMVFFMWlTenR5TXVh?=
 =?utf-8?B?U1lGbGlMR1ViTjFITjNaNmZ6aGxPTDZxdGhQc2Rzd25WblBNbmZQYm5Yd3JU?=
 =?utf-8?B?bUE5V0UwdHYyeVNmYndaM3VBc3hIb1UwV1k3eThlMDB5dndWQ1NHaEEyQUo3?=
 =?utf-8?B?UkFNdnJiejRGdC9LRVY2UGVNWVNIU0JzV1gra1owa292L05SVWNsVWttaUhV?=
 =?utf-8?B?OXlqMXovMGltZ2hpQXIwU1NJZkNob3ZYZktIRTZTZThmT2lLOW1WMGZKbkxU?=
 =?utf-8?B?L09PempGSHNXNkJhRUNCT0IwbUYvam4xelIwZjdmbElNWTFYMXFhUjd1TDBk?=
 =?utf-8?B?aVJnNEhsZUovL0JyY2UweVVWdlNWa2c0L1JGZjQ2b2VIaVhxYmFqd3NpV1o1?=
 =?utf-8?B?VVlUZm5BbUNic1dVQmlxc0JSMDlPZXhEYnFvdjVua1lCQ1g4RzJGa0MveHVp?=
 =?utf-8?B?TU1xSXFwMWcyRUtZMkkyamJhcUZNUGVKOURTeVVXZmZod3UzY1B6eUl0VmlX?=
 =?utf-8?B?SGxjQnUvczZSNmZRZUt4UlN3NUI2REVZZklPbFZ6WEZodzA5bFcyZEY5ekhQ?=
 =?utf-8?B?b1hFSy91WmJHeUNoOHl3MmlocGd4VDdOVmR0VndvaFpubVd5U2lFQUFkM0lr?=
 =?utf-8?B?TGtBc3pwMEpDbWV0Q0NYTUlEckk0TEVOQ1NDeDFuZWUxZ1N0alVCVDNKc205?=
 =?utf-8?B?NlpiNUxZYkM4ZStnZEpwMHM5RUIreFNNR2x5YnUwYkw0OW11Zm4relhVS3Rt?=
 =?utf-8?B?Sy9WUlk4eFBsZCtTT3RTbnR3TW5teVdPd1ZraUFtc2lBNllOeTlYZ0swTi9a?=
 =?utf-8?B?Sjg3MHM2MDR1aXlRRUlWSDFwMlMydjdYT1QwdkYrcmpkRTlXWHhTNWJzYmFQ?=
 =?utf-8?B?dVNNaEdxMmhFejdMeWpLS0VvMnpsYVFvU3M5M3JlMVowdmI2ZjhUc0pFd3Ex?=
 =?utf-8?Q?WAqPOws5ibRQ/3PE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3be220-c7ca-4f56-3007-08da1724545b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 16:50:03.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gt43u5fEDtnyKByZ7PtuWujQABqML0Md6uoixMzX8H8+W1w5CCWx8YL0enbfDhP77iqHEgnOJbTCVc6FYAxISCtqpSF/rZRtwjsrfuj39Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5164
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/5/2022 7:52 AM, Jarkko Sakkinen wrote:
> n Tue, 2022-04-05 at 17:27 +0300, Jarkko Sakkinen wrote:
>> According to SDM having page type as regular is fine for EMODPR,
>> i.e. that's why I did not care about having it in SECINFO.
>>
>> Given that the opcode itself contains validation, I wonder
>> why this needs to be done:
>>
>> if (secinfo.flags & ~SGX_SECINFO_PERMISSION_MASK)
>>                 return -EINVAL;
>>
>> if (memchr_inv(secinfo.reserved, 0, sizeof(secinfo.reserved)))
>>                 return -EINVAL;
>>
>> perm = secinfo.flags & SGX_SECINFO_PERMISSION_MASK;
>>
>> I.e. why duplicate validation and why does it have different
>> invariant than the opcode?
> 
> Right it is done to prevent exceptions and also pseudo-code
> has this validation:
> 
> IF (EPCM(DS:RCX).PT is not PT_REG) THEN #PF(DS:RCX); FI; 

The current type of the page is validated - not the page type
provided in the parameters of the command.

> 
> This is clearly wrong:

Could you please elaborate what is wrong? The hardware only checks
the permission bits and that is what is provided.

> 
> /*
>  * Return valid permission fields from a secinfo structure provided by
>  * user space. The secinfo structure is required to only have bits in
>  * the permission fields set.
>  */
> static int sgx_perm_from_user_secinfo(void __user *_secinfo, u64 *secinfo_perm)
> 
> It means that the API requires a malformed data as input.

It is not clear to me how this is malformed. The API requires that only
the permission bits are set in the secinfo, only the permission bits in secinfo
is provided to the hardware, and the hardware only checks the permission bits.

> 
> Maybe it would be better idea then to replace secinfo with just the
> permission field?

That is what I implemented in V1 [1], but was asked to change to secinfo. I could
go back to that if you prefer.

Reinette

[1] https://lore.kernel.org/linux-sgx/44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com/
