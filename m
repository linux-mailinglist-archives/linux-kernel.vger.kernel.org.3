Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537A246AA72
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349557AbhLFVdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:33:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:23425 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349328AbhLFVdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:33:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="261474090"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="261474090"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:29:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="748415305"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2021 13:29:36 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:29:36 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:29:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:29:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:29:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+ZVq8/Hk6H/66G2vWSKT4jd0Rvd0easeG/RCjA7Bpr7gXX2ifK6ueD2zIlLIpNDljuAOU6/ib52Hl5T+hAFebLNfU+72SZVSWJIXdbNBbjDNtImJLZJkFVW5PjbVudq+1qBXIF3K3yCle/j0pnaUqHkW7VBnna/bvXUrEtqX15ZQoDD0rUhtiWPu5ZAiIP5fQZWdRXV5nXf4jvK3+HtaHdOKxzAItsKKb7nD1yKF2K3Iih0Xl+we529exEcM1I1zmPhUduOsDRF1zr+uRRKe8ZHGE/ikeIDECDHjvpnk/hvbhL+Nj9zgj4LHR8EcNkD0xeHRKqPPdGdITkgXu+Hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU5aJHybHyWaUT82WuDLpObsSCc9rwONCtGiVDzvOc4=;
 b=bccRZ5v0HqrkjMA25+bFmiOQyAlTOUNhTfsTNotupa7sc5HH56iysLj9oE8mFcBPMDdugQh/Y5X0r7Mv/oM6DFj2SwBBeXk3ESaxCxjIshxPpVZAp9L4KYozsitspeQ0wKHhtDA51ECr9hQn+lf7LS2lBf37en8QgM2v+Kr23PxKGDrg3q2ywBsLa7Lk2YWh5dc3hfJimzJ7QgJhwYQJCML6fMzodsX0lZrxPkeHTTkbyFGOptDVu6KBqHSK/NyifNd8Y5fLeETLB03D4pE2+iGjPNdCjtBP4INq8Yibg/C+raC4C/YoWvHlCcC1mME417s/Z8EZbVLEw8adj1e/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU5aJHybHyWaUT82WuDLpObsSCc9rwONCtGiVDzvOc4=;
 b=MdrsW1md/QwrO6lanCbbCTC0dCSY7RYj7Fdv1jF6zVmUpDcpL7hEs69pIBHVGhxAboh7W5ig3ngd7edid+ghYUOtsMuWTOtA9jdIPfKqmpdfTcWnc8DgKSKa23Mw4XQv8rwkg47jgJFi7qNYEo/OOnks5T0hvsP8UnAXnMfhT9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2802.namprd11.prod.outlook.com (2603:10b6:406:b7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 21:29:32 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:29:32 +0000
Message-ID: <138a9433-efe3-8fff-b2cc-22b1b7297da0@intel.com>
Date:   Mon, 6 Dec 2021 13:29:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 06/25] x86/sgx: Use more generic name for enclave cpumask
 function
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <a6667798da726f27e6b63029ab67da1fef5a771e.1638381245.git.reinette.chatre@intel.com>
 <YavyMFUJZKZ9Bpsf@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YavyMFUJZKZ9Bpsf@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:301:2::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR12CA0044.namprd12.prod.outlook.com (2603:10b6:301:2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Mon, 6 Dec 2021 21:29:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2117398b-09c5-4de5-c75c-08d9b8ff7de9
X-MS-TrafficTypeDiagnostic: BN7PR11MB2802:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB28027E18FAE793ED1E7760F6F86D9@BN7PR11MB2802.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsMY7zG3YEltAPqEesJ46u94TTCETwztylMaQWcn62CN4fVB9y+MW2x5+9Ze4TG/KUZ5SMc7ZgX37JBogoRrw2HtiCJCwYdM23ZTIaC3x/u+wo7IZrlpFewnWl3e7e9zb3loKn5tGECGElZRVGvsXYzZ3bbbBisXW0osSjQVWd3bbcVjGKoqwo2/yHuevf9H4q27xNedlf6d+RiAFJwVBbNDvtJ42EFWMsru4MGtE85pmzh9P9zvTm/b3Kzd6s6MqE5lfmOx29tG1OHEIQCRVIYw/NnPX7tF0y2WsCbXDIuYfTiUm1DoNwDvH9Wt9b8UcSjn+EINAdnh8as5DPrzCkMr4KD2rsI8ev+eQ+OyXGN2wPapukDoFaiG7mckn8q+fDOURYAV39e/wo6ZswBK4Vr4IL026I15l92MdaThT3o5NZMgWUCzv3+FFmEY/qaj7PHcvIeZafemYBUjx3MYjd8kqEQrYGA5+bzD48IOFFOa4zny2ThkMedz3ED1hiedrlDRwBB+mLGRqZFvpvMcgDTl9MVDMMhlL2tCNET1Jg8HEwzq34HnBN8n1ks8b+TZpVL//mVlY0MT6GZ4eK8imEjKHr09Ir7ROvixuZIaJhlIisjmbQv9BITbRcczBpyHJabVBV3YvYZZQyz/JFipgQc5ZtDeqNIPh9rFFaexRDXGnfdBQKz9Mo7l2lweoIVCodOfa4E1aXQz9HLVwwCmHm6VLSKxF/JypcWimLAAMezHCPZc57qxPFFeO50iJ4bL3pFh00BZV+cvewD+DFWpJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(38100700002)(31696002)(2616005)(6666004)(16576012)(36756003)(508600001)(956004)(53546011)(5660300002)(186003)(2906002)(26005)(6486002)(4326008)(86362001)(82960400001)(66946007)(44832011)(6916009)(66556008)(31686004)(66476007)(8676002)(7416002)(8936002)(4744005)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJqTjhCS01IcVByOHFZdmFqUUVxVTNCRHpJNEpIaFcwWExUcHJMWUduR0Y0?=
 =?utf-8?B?d3ZUelBFeGxXU2JnMjJHU2ZBKzVYWTdDTkpQUzZXZ0Y3MFZRQTRPS3FXZHRC?=
 =?utf-8?B?L2h2VFV2T3R5ZGR3VnlpdE5MTEpsUzhSeG5TOXZUSjVvN3VwNkk1SVUvWUZj?=
 =?utf-8?B?OFNXK2t5V2QzekFSa0dHVERUckZ1dms2R25WVnFoZmxtMVYyU1JES3pkckRD?=
 =?utf-8?B?R245allGaTBNZmtZYVhaL2huUDNYRjhnSHN0bml6Zks1YlFTcnZRT0lUbXJI?=
 =?utf-8?B?endTNlkzdzFQaVFHY3pGTjRXUzhtSWRHR3VaYUYwZnhMenZvZ2U5dEhsdTVO?=
 =?utf-8?B?M2JHd0pGLzVHb09RczgwME8xREYyT0V0UnBFdU5OMXdzV2Y2MVZDSlBXcDNV?=
 =?utf-8?B?a2RvZjI0aFNaRW40SVBISlhxNUg4WnI2aDVYOUcxWDEvWTNUM1Bqbis4a1N1?=
 =?utf-8?B?dW1JSXMzbzdqbzVnSkpJSU9udVYyd0xtUXZQdVpOcTlrVmhJQlRFWFltWFJi?=
 =?utf-8?B?VG9hMmphRjFEK3ptNFNZS29kc29EVGNhMC9qeEtZUUplVERHQWdLZ0Y1cHpY?=
 =?utf-8?B?U0ozZzROeVlxTVJ6YXpJOTJSQjRyOEpKQklQdXF2TzFTYllHSTJidFFwV1BE?=
 =?utf-8?B?eXVwNHZ4MzJMcmwrNllnajBxRFNQOVFuektxSHpzY1VBR1VoOHdkRDFRT21o?=
 =?utf-8?B?L3ZiQ1oxVEtFQ0tob0xzQTlxQ3pkUi9DV2RSTjhnaW95c1RlaGpWTk5LQktD?=
 =?utf-8?B?eUdHQVl0dDNLSUVaeDlEY0JBWVgwRXNRcUZkdUdYY1RTNmFOWXg5V1RNK1VE?=
 =?utf-8?B?SzZmRDVieGZOalNTMkNjYnpKc0paMTBLVE1KZTdFR25Zc0RLTSt2cEZuN2Ji?=
 =?utf-8?B?aXZsMDJINHZRUS8rbjY2YnJnellvUmY1Z3g0bU1adXlDdlNVYXZDNjg0QXlV?=
 =?utf-8?B?RzJkRlc4YnY5Uy9hSUNlejNHV2IwMWx2TWNGTXA1K1h3RE5kRTh5Z3p2UzNN?=
 =?utf-8?B?MWsyQWxmOGY2ZTZrSUxDaExYdTkwcThEZzhMOVZOS0NnRGVCVk5VZy8yM0oz?=
 =?utf-8?B?Rk9JY2RGQmJmMlBBOGR4eXJDdTFiRS9jMzQ2STVxOVU3TXF0TFdBY3JnOVVV?=
 =?utf-8?B?cEJJSFFHUExDbUV6ZlZyTWpxSFJQV081dlVjdjJEQTlNcEFiMmpSQTFwY2Fz?=
 =?utf-8?B?ZERpTUlEVVdYckUzSEFKNXBtWFAwVVpoL09lbWZsaWZOUVQ1M3JtTFRCSG5W?=
 =?utf-8?B?TlRwSWU2aXpaWWN5c0o0UnZzR3IyRXBRYXRUN05uMXczbXE3WUh4MDljcWJF?=
 =?utf-8?B?RFE1R2JBcEhURjlWaVFqYkNjckJYdzZ0a2RrYXBUMnNxdjkyNFpoSHJETGFL?=
 =?utf-8?B?U1lYa0JyS2t3d3Joa0hoYkVHNXNwc3h6SmNJcUYzNXhORWVUeUVyVnN6eU55?=
 =?utf-8?B?Vzlud3h3MTFkaXJ1cklrazB4SWx1UTZtZGRkQzFXUTBKTTEyQ2ZxQzh2VUds?=
 =?utf-8?B?Z3FXeTRYUUVwK2Y2cnpuRzI3MzQ1TG4vekg5RTVueFpQNkdWL2VqZ2JKYWJF?=
 =?utf-8?B?ZjNZUnBBYTM5U1F6NzViRm1xb1hQVi9ldzdiYnBWQTJSUHNzVno3ZXdvd3Bv?=
 =?utf-8?B?alhrd1VGRDJLenBkRmdKOHdhOW5iQ3J1NXVtcmpYckpmT2hoVDIwSGl3MCth?=
 =?utf-8?B?cFhrWnFZMFlQMjROS2hDa3NSM3NEaHExVDY2MWExZ0FHdVhYbTBFbzBzU0Zl?=
 =?utf-8?B?cXZYMzB6V3RUVTlRYk9GQkhHMS96K1BWY2JsL2cyRkpVK1RUYWtrWnhJK2gw?=
 =?utf-8?B?UG5qTTZ3L2g3S1grekVDMUJjMThRUTJnaDV5RkVUSlhlM25hMEdja0lUemFm?=
 =?utf-8?B?UEJsTEljMmVDN0pHVUhuTWRKRWpSY0ZZb01LWDc3Q0hHMytWeU5CbWprbHgv?=
 =?utf-8?B?TUxNbUQxQ0xmdkgzWktjeWkxTDVYaFBYa1kyamhScy9OV091QVhCT0FEbURP?=
 =?utf-8?B?NnYwdWVoUVJQbzBCL3N3S25VVFdjbzYwOVNlRnpJSWdzc0hGdlN2am9JSDky?=
 =?utf-8?B?UVdBSHhJeHdWUHFtdkVqbmlUQUR4cGVZUWVqY0hGdnlTNEFXSW1abEpFRXFh?=
 =?utf-8?B?SjRDc1dzRmNwdVZnN0Foc1BEcklZaVZHcDk1dWlMazRXZWo5LzZZYktybkxB?=
 =?utf-8?B?T1FlU2dqQVZHTzV6aUVzeUZpblFWV3BXWWlsWmhSYXNJanduYzRiVEZqTUdC?=
 =?utf-8?Q?/1wSIMpE9oUROuh9S6msnXf7C+I0sNds3HUXmUh42k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2117398b-09c5-4de5-c75c-08d9b8ff7de9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:29:32.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfD5YrQVq4uKmjIdYN/8UXEHUGz06FfN3Scge/VmUPf2s3bILIta6sFIGemXs9SkTWfhSjoK7sRFmEuYcgco6169P0Ao1s9RiWeotNyfl2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2802
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 2:56 PM, Jarkko Sakkinen wrote:
> What are "enclave cpumask" and "generic name"? I'd prefer to speak
> about concrete things and no use weird rephrasings at all.
> 
> Also, renaming is not exporting.
> 
> You should split this into two patches:
> 
> 1. x86/sgx: Export sgx_encl_ewb_cpumask()
> 2. x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask().

Will do.

Reinette
