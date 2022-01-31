Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713DB4A4FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377933AbiAaUB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:01:59 -0500
Received: from mail-dm6nam08on2064.outbound.protection.outlook.com ([40.107.102.64]:4288
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235449AbiAaUB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:01:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsYUW32IB9+5nYz1tbcfIAyDE68OQhth38M5AzOmz62rftc1xDfCommW78YexHIXQC+xbmLj4jtSWruRX7Zz1q72xBm6ZqTpbb/Wa175YsQ4V8BJC7TNb5FY5imf0xHuBunkWp9zYJNwOSkBRlbYTiuLXqcrBAE1VAIPtKe8ouM+u5vpldZBtus5Rz6+7toHXB4YY2NlFBuUx6PuwWBFs2DJN+CWOlCo2s4SMJTube1MXQrTir5X2e/4Xv7u2YUkEXiT23nhluJpGekMnZ2B2TOLBPZFuW1MKvVYnzLYzVLBf0E/IytSCPAIfgNHkMrxp6iE9uazlBEJsKokGdUYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+mNXwrIM2M5UZZa6hnENXN26dcXlucU93BwmW1liV0=;
 b=OXitOmD90U8zenxP+aLqflkZwCRruzRnH3PUMx1E9dl3/tvGBTU3XDslYEOm9LoMUuBMVasHhQvGcYVrT9Ds755CChlQlNdBvCXDmHLnHB3pvrzNluwefhhrPPZKWo3RKaSuvNxryAGDrGsZpYu1IcNCo9qqu45RbbUFAvKfZwRB0db0zugBapaS+O0ohZsPj4l2Yk+VZ9fxH9Cu7n+qO3ZOLjmwMA8EjaaX4SnxTsS5JAhGtqRgur/epKOZnNrK/tD+oPEsUGdmyaKizh2jEhuZBbayI+d8XquBHaEnim2m9OlShLGCtNLMOgp4SDD3UhuNN2gDKiqUVOdLp80Wlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+mNXwrIM2M5UZZa6hnENXN26dcXlucU93BwmW1liV0=;
 b=nr6KMwF+kHFNS0VxufoXx9Ech/7VmLi8XnP1WzI5VyudI2Mz+BWdvVsfAd6KkVgDH0UPsRlhWBAtPXub8SZ2zaSLl0mwnSEs9vQWPG/MAllln473b5UaIydkr7nvbCqOmksZ7r10aol1jFDtPHWsHun2j0WqAWuFRBrYVK7c7D81o9T1yNNNxMWYW79nOdzq3XVh3Hb38HlWDzTvo9ocEnCgF7iMgTkh1Uz+axnEPlm66hf+cCn29zDh373qO4im0tr8jWusW9CA/ndF+JokftuZF2q6CLNHp4sptbY9wabeMmu7VTArTAOQL5l8SD+hOnJTvRI5Q74kHmdDheqikg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 20:01:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 20:01:55 +0000
Message-ID: <d2f4a932-3cce-5b0d-fbf9-b9cf2291bb61@nvidia.com>
Date:   Mon, 31 Jan 2022 12:01:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 4/4] mm/gup: remove get_user_pages_locked()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220131051752.447699-1-jhubbard@nvidia.com>
 <20220131051752.447699-5-jhubbard@nvidia.com>
 <20220131133612.GW8034@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220131133612.GW8034@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ab9f224-2aa1-4115-e3e6-08d9e4f48830
X-MS-TrafficTypeDiagnostic: BYAPR12MB2760:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2760C101F1F89A48A3C58E63A8259@BYAPR12MB2760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKV5FjvqU8irOwoPml971WG8oItlLJvbmNfvwwJhQIuX0Vo/PnWkwYeQ4FZ2Bh4yh81kOVqymBjLRc0FWmzRCGhV8VLhtd3DkinZ8WvmA8cmWmwOEoRc2k8wpU5+ZrNAeFiElw1YjURyWK7rG3aELuabQZIw8Y5vHSsSz/q4wFWF5uISD1JPxVOSOf7Cli9060EEh4uWB9jZwWXvccRzsvKKZgSoHO5svcSFdWayNRsRHb6N8JqNXq0aQw4dfIuXGB2Q8m0w/0k7ORkzOj+YDX75qA/YCks2W4JfvJxpgMLVab+WLldhPEIXf+JzGBzZTnNVNe7ZlGy017Stj8d4VYtBErBMM3uEgEOiY73nKcT+wYYniwxcu/szTL5IjAyDGZlbudn/tpWJhM2BnZdEnryC6GQ/9yoql4nzprM4kicwLrpJYARHyyZRmcNaOSw5tQ1IeobIXuOzx7Xg9cE3y+eZ0GzroATLoj9yCkdRtu0zjmMXyiw/K5uHa1uNAzzit/sWJSrSvSpb3efVqrbF+NPkOL63Y9N+IPR/ETqhJUEV/Opyqi4liwri/Qi51TQH0Rlwoj1/ly2i6Fp1TZ8k+guv07kl/CdpzsomF7Iao7XARsJpgP7uif9zblPuwqbCWX2RQ1/saxekojbIV4xxKW3+o1aNhqtj3IEbAC3XSFvtCbf9WKr8+cElUX6PcfVvldMVOCmw2YotfN7PiSQR+yx8Mqo/eRDEQZAtB/75oT8ipkgnZpuQ1ywWX+ukJ0VK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(66946007)(66556008)(6486002)(508600001)(66476007)(38100700002)(54906003)(83380400001)(316002)(31696002)(36756003)(6916009)(53546011)(6506007)(6512007)(86362001)(186003)(7416002)(4744005)(26005)(2616005)(5660300002)(8676002)(8936002)(4326008)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHBoNzZ0MUUwSXlpUmkrUzlZV1d1dkJxa1JUQmhlaTdXZVYyS1dJZkRFVnpN?=
 =?utf-8?B?M1oyQldkZms5Q1ErVnprUFdEcWtkVlQwakpVVHEvOThvL0VodTBOMDRTMU4r?=
 =?utf-8?B?emZMTmZOVmNKSnZyeDlHanNaMm1hMEdmREd2UDJTSm02TTU1QTYvYXJZb1Jx?=
 =?utf-8?B?SHlETGZxUUN1RGpIYmovcnFwTnl4bGhjSGo5VWE0VElIc0pyYVNwc2liM2p6?=
 =?utf-8?B?SlNOU2lUOWIrSjU3djBtSlVEWXZQQkRsRm0xTFB1R1Nsc09LM0VHVExWSEkw?=
 =?utf-8?B?K3ZHTUQ4SzVTbVZ5c3dIKytieWxXdGNLU3k1THJUWXZYR0NwZDVOQmREMW5G?=
 =?utf-8?B?SUErT2xMWktOOTdTNHg1em9vUzdDaDRlVjk3ZlZQLzEwa2hTSENlRSs5WXpw?=
 =?utf-8?B?WjlhWU1QNWpzUXR3bWpyUDlsc21ndXRUUEs4NU1wQ1E4RFBHUTNONHVTQ0N5?=
 =?utf-8?B?cmk1VUhlNlJrb3VOZDV4cHFPV2t1M2k5RmdPQ09GaWV4WjdZOTdlZmhIL2kw?=
 =?utf-8?B?b1h0N2pJK3hUN25LaFBHYkdlOFBoVVJMemZyTFRoT2JDVVVvb21DRnRzZjhx?=
 =?utf-8?B?RGlYeXl2ZGRpRlYzSk1VNnB5eVFxVEdLNWNCYzZaWk1Ib04ydDJ2SDJoTnBa?=
 =?utf-8?B?ekRveFhjNGZmZHR4YlUyRWc5TDFsODhYdyt3cEhscUFGUGZ0cHVnZkY0K2M5?=
 =?utf-8?B?RnVtVG9hNDJpKytjV0MxbHFCa3U3T3FOdWdHYndXc3RicGJaSUlKVDliaUZH?=
 =?utf-8?B?L0ZMcy9TUHV2SVAzWHJZemE3aGF1QWd5aEp4SDgwVTRtMjhsWTZoU3hXbFY0?=
 =?utf-8?B?WVNzYkhScGkrUEdBaEw3OGZzWit2QVI4U2wxa2pjaFVBV0w0KzNEUzVyVFBF?=
 =?utf-8?B?WjM2OTcrQmVmZmtBc0ZEQnFOZ2ZGTDRaTDRkd2JwMXRFVXo1WHFJQTBLMGxK?=
 =?utf-8?B?bnozd3h2YlpGN2ZENEFxSzB5djFPRm15MGdFNnJhbTBHY2JKaWRZRmFCVUxS?=
 =?utf-8?B?UWRLZDkzNUo3U1NTUFhacnhqMWhsdGN1YkRQeW1lbGFhRmo5ZXYyUlQwb3Ur?=
 =?utf-8?B?SVV1WEZ0WDJ5YVl2ZmtCY1FBSkR2M2w3RUUzcDlCbVpMbDhWL1NsNEVxTjRX?=
 =?utf-8?B?SGFCRlV2ekhLcC9SSm5WcmNlSHFzelF3VGRMU0hXc1JCSENzV3A0eEwrV2hD?=
 =?utf-8?B?VmhIY0xpWGRqWFRXSGpCblV5OGtXY1RyUURsMlp6YVFmRUlBemMyd2JHYUgr?=
 =?utf-8?B?eGFHNUtKUVdxanNrd2tHM2pOSHh3Ym9nNC96VDI5Y2JuamxMZzZvWE9lbU90?=
 =?utf-8?B?bWp5dkhwbGJhK09GaTBhRE1YQWo3Z0hweXM5VE1kL2FrbHluYUM2dXBveXU4?=
 =?utf-8?B?dHZ0TXBuZUx4QUlZdExNanBkNUxONnV0b0FsbDlNbnBKWXZ2bVdKNjVqbERD?=
 =?utf-8?B?VDZWcUpmcFRUVXRUZ2d0aldHZzA5N1dPeFFPVUp3d2dMTWloemdScjZKTEQ0?=
 =?utf-8?B?TWF3d3d4ZHI5UTczdFRqUHc5Y3ZWQjJKdUtlWk42MkRBK0NtZmpMTXA0OXFP?=
 =?utf-8?B?WEg0c3FRZWF4QnZvKzFPMXQ1TU1BSHRJZ3JyUjd0Wms0RDlzVHI3ZVBJNzFB?=
 =?utf-8?B?YTFqWFEzMm1NWnM0WERFekowa1Nxb2xxbTgzRkJTSTNMbVA5bzlHblJlK3Zs?=
 =?utf-8?B?Y2VrWXErREk5bjN5NndvTDRJQ1E2dDVyait6dTMyeUZTanJxbk5nVXJ4QlBw?=
 =?utf-8?B?V2hWVWdoVDFNMUdnSXo3UDVaUkN3RUFNTXlxYmFTaUM1RE0vTHNBR1RWQmlT?=
 =?utf-8?B?NktCV2FiYkRxTnVzWCtpLy9CWXpaWm4zbjdlSVlVZlVDV2hoSHYrdit6WStp?=
 =?utf-8?B?VTVXSkl6bTRSSVB6czZkQzdVZjdCQThTcjdxM3pTZEllMmcwamh0R090YjU0?=
 =?utf-8?B?VWp0Q3h4K3hwTUJGZ3F0UmNiVTBuSXY1U25sUXprSVgyV0RGenc4NXVuNEJn?=
 =?utf-8?B?bDl2T0xFTGRvWW95UGR3QVltNmdRU1AzVk8zSmtXbkxRRlkrN3pQcDUvTS9Z?=
 =?utf-8?B?QkhHUVVTOGFQcnh0S1dPS1JpaXR1WlVsd0trblhjcGVtcGlIcVNTSXZaeUow?=
 =?utf-8?B?Vy9QN0dJQ0tkMTlOSEt4MjQxNHZ4THEvUFBBK0NlMlo3cG1MSXJ1cHJxcUt2?=
 =?utf-8?Q?PUXTidHjyQ7u0BmAXoqO8kY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab9f224-2aa1-4115-e3e6-08d9e4f48830
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 20:01:55.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32cnWLusnCiNPSPsnBI21V/r3c+NSAejQZmpRbKsddSVrpPPStqiA/JxBp6O+A0lUL8XsKEreqKnWm2S8IR5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 05:36, Jason Gunthorpe wrote:
...
>> @@ -968,15 +966,15 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>>   	if (flags & MPOL_F_NODE) {
>>   		if (flags & MPOL_F_ADDR) {
>>   			/*
>> -			 * Take a refcount on the mpol, lookup_node()
>> -			 * will drop the mmap_lock, so after calling
>> -			 * lookup_node() only "pol" remains valid, "vma"
>> -			 * is stale.
>> +			 * Take a refcount on the mpol, because we are about to
>> +			 * drop the mmap_lock, after which only "pol" remains
>> +			 * valid, "vma" is stale.
>>   			 */
>>   			pol_refcount = pol;
>>   			vma = NULL;
>>   			mpol_get(pol);
>>   			err = lookup_node(mm, addr);
>> +			mmap_read_unlock(mm);
> 
> How about move the mmap_read_unlock up one line and then use
> get_user_pages_fast()
> 
> I'm guessing in most cases here the PTE will be present so that should
> be a net win?

Neat, I'll do that.


thanks,
-- 
John Hubbard
NVIDIA
