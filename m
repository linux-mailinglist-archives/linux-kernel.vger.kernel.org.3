Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD4858DA1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbiHIOOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiHIOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:14:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB227BC94
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjXnA7jFGbh4QPMzP4CZH57gjdnT93GjAxLGTZqOh2ZPOMujCdMJXwyrVkwsr6qAnwTN3caRzTejA1pIabySGb7qFVh/Cpvgysl4Mel1IyFaMkLu91Okkyv9sx4dL0QCcEOc6gg6SyKNtk7uVXgLcgm9rWpiDQiDhq2VBpDkkL7Y7iNQaurPVfD8IUKM2JRHc1rmuoZeEKcgFRb97GhJ88Q4R07rfE9Zlw+sufpei3tfGGG1kvpvr9f4Z2olmnyr0rix5zZPF4kTgHh8TIm1Zfb2orftaS17FkB3BQfOok77rq6HOkVIUxGawahLmgAfcQQIFZ9OcUNzUOspAezf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q75WHtyErmbot3tVDAup59t5rWriCzUjr0glV10f68=;
 b=b1vKZg1gut8dOAJl14vzIMHd7qZDlOIAEbND2lKn2GI3ClAcZ6j9mDnr+Mgvo0Z2cFw9INcJFPBdieedPSsgO6CjfnRIqnHp4jEpRTITHS5VBmIZ6EgiLZ9ZkaBWAab6/k/HP3efA4sGy6m0GCwAMAwDyeeIENvx72ZBL9G+zGQyax8YtXZhLlg7USfuADHGu13recskdv5ImXKWeiuBgAK/6iOJJOeDV52NwICSn8if04n3Ce5fItVgH6IwxsohOQ1V1SMJCFtFvhRrlssiHVUD6VLs+PtgsnZ5sQ79H6JJy9R5LCfmD5m0Xrpg7ef4JbVehowFqu9x9L7UxDswJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q75WHtyErmbot3tVDAup59t5rWriCzUjr0glV10f68=;
 b=193wvfg5uDeybiIfklX9OVBWJjnLjT9GEsWi92ucI2cu2uwmH9j5BlLgpFlrs7KH9ay0PdZ5xyb1EA3o3a3AtGlAbh98KRbXEqDk1xqaN7rakuDvvZCx86dbhpKbJDqALkQRyHa+CxKu3ec4Xcxa8z6DU3/iAFGDIeW7ybTBVnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR12MB1656.namprd12.prod.outlook.com (2603:10b6:910:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 14:14:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 14:14:15 +0000
Message-ID: <cd25ebd9-52f9-2e66-841e-fc94b3949f7d@amd.com>
Date:   Tue, 9 Aug 2022 10:14:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: re-allow pinning of zero pfns (again)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     alex.sierra@amd.com, akpm@linux-foundation.org, hch@lst.de,
        apopple@nvidia.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <166002010021.381133.11357879752637949308.stgit@omen>
 <YvJTi0fAgl/T4WA4@casper.infradead.org>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <YvJTi0fAgl/T4WA4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19e49c83-689a-412f-b82d-08da7a1170c0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1656:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABdrzSRKmPPIbIOEpfdDMh4BJH8ASL1IYj2bvsLrnsMRvwezpBGstktoToiTVEgODO4/qCI2VFyfUgW3cOGWn8ZYooN0lAeVJVas+Mz9v837KqLGrxc3W+Qus+1VxTCsdNR4N3Q8OmmQANr1TyUiHh/G+aD2oxBjKjViBmXOEXAKEyAqMoncP6HpDs15NHsuSSpgsO7MDsgRRnyE6k+yda/lXsArFaiXfT0W+UTkQNcb+isStrtVoWpHxslA6aUXY0FXmNEagoFiHLfotoFi1yfgGuBaZdG/CITDv3BOSEpBw5le7ZeGSL2BAwsqzmWY5RV/TaXMX+OBNTlEikf8V4FR06o56aDzsP9O9QdDJqRmmhaPhLlKhPVdfswpBhjLUApFg9gbIW+NgjDL29tF8tOgiiQ2Sgb2Ug5XAgpXTD5tnqu5YCvTfknsGOXy7TUnN3p8OMkmilD+KHkKNE4YwlSPfEp6ZwrcKoSHhTelvL55NH54+T2zmNj4NQTluHOCxzX8srhHuZllxKEb5FFckf//nzCpmz5xjtWGuZmbsyXg6930lwCZuG7LzemGaqfz2zKV2qzR+UFTbb8HNhN4qVfaw2/MndUSvX/ivQTaHD/H9PdAsiOCTmhCO+7RlQmtkymqrUHPPIm5ZARnWaJ9bN++CEAUyp0+kU8raK6pnD4u123UB8updS72r3oObyFQ2COkOfP3zttaJe/TVN+7vtYX53BfSMvUda9oVpQxoPWRoMt2DiGpqicpiCxiguH5TPYhWKc2BThAU2YsZ0/9uFtWokQXwAtKJl/lOEIJf16uL4/8R7/e973QMWKxDZjiJs3yBMzJ+yuUTBufWc3R6/V7I+508J2DFqSMqzX8yC4uuiJuBPw+YZHX4ARVSDB9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(44832011)(83380400001)(8936002)(31696002)(86362001)(5660300002)(66476007)(66556008)(66946007)(36756003)(4326008)(8676002)(38100700002)(316002)(6666004)(6512007)(6506007)(26005)(6486002)(110136005)(2906002)(966005)(186003)(31686004)(478600001)(2616005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rno4UlRkQnlnSG1QL0k5bnZiZHR1Smh6cGpxcXNXTTVTbUVDZGduRGtZZkxB?=
 =?utf-8?B?V3dwV2ZDSzVyTHVCQ0xKcHo1SVpyaktpL1N2Y3Zodkdad2hSd2svbUk2dmV0?=
 =?utf-8?B?OGJKTEEyVDF2R3h2OGFaR2FXZHV2QzQ3bk4vN2MrTUh4TmNTT3NhQkszRngz?=
 =?utf-8?B?WThTSzdZbDBkOVRTRmIxNFpra0x1NjJnU05Rd2taS1VjZUxqL0lFQ1VlTjF0?=
 =?utf-8?B?ZFRsZ3N4N2NWQ2VhdU9yMkFaZEt0UFhnbGtGQk1hQjI5SnE5Z0NISkpKMkVB?=
 =?utf-8?B?OVdSRS9PWTQ0c1FmOElFVmsydTZ0Q2hpdEV6SnIzWWIxU2tBK29zVFE3QnEx?=
 =?utf-8?B?NDljUllnZkExbkNhcjFOYnN1allPK2F1cUxESFVDSHlpMHhLNllta1hab3BS?=
 =?utf-8?B?TDUrbTRkNkp5NkMyb0pNRFdLVmdQWjRLdnBERDQvUGd4Q3VNZVVrS01ZMm5W?=
 =?utf-8?B?a1JQdkV0akRPYjkzMTFOS1pTaEIzMkVQa0V4bkI1WWZiZzF0bkdwTGh5MEJo?=
 =?utf-8?B?Z0JLVjNLbE13QzdwN2Q3VUZtZk1LQ0RHUklJcXpmMEtyTFRLZjkyZFk0eUtq?=
 =?utf-8?B?aTh2aG9LdHZtR1JJbEpVbDNvdzFneU9vc3NZOXgrVWNSZ3JJZjlpSkNJZnRF?=
 =?utf-8?B?R1FCOGk5VkJpb1NTNk5nTDdwdithVDZSdzFNT21nZkFua0VEZW0xdm9ieitN?=
 =?utf-8?B?RlJCSGNCVWtEcjRNbGM0bVYwNjJDdE9sZGEwZ3I2TFdIVEJDaXpWVkk3VVpI?=
 =?utf-8?B?eTRJRFFQVHc5TS9IdUlUYlRvSjcvWnQwNnQ3dW0zWW1Fd0tYYmQrem92a0gr?=
 =?utf-8?B?QlNXMlVUVVNVcXV4OS9qS3NwWityQXFSMjNVTFFNUFNTNlg3Y0VDcG5HcXA5?=
 =?utf-8?B?eFc5SWhkWnVvdFJnRWhiSXBZdkxDQ0hSQkYzSU1rK1VEWkpwUGZ0Q1llTyt1?=
 =?utf-8?B?aWpSK0kvaHpJNWhpd0pOZWdtclRIU3RBQ1k5dmNRTDVuVGFIajljTWE0cEY5?=
 =?utf-8?B?SzBCY0pFc0Q4NDlUYkhPWEM2RnRvby9CUisrNmJGUFpwRk80QU9IRFB6ODdq?=
 =?utf-8?B?MnpmVDRiZElPdkNWa3ZTV21aOUN0NEhqb21DOWJRdDA3VnVFdFlZN1VRVDhz?=
 =?utf-8?B?UzZCcU1jbFgwNzJTdmFHMUdxdVROWEx1NmZicWlPc3MwUWw1Z0g4eTlzRGhw?=
 =?utf-8?B?TUg4N1hETjBCTlI4dFZsUld4N0lzZ0ZQRUJiNXBUOS8zZ3hxcXRHRjFYd2U2?=
 =?utf-8?B?ZnlzZ2FwZFFadFJJVkhpdm81c0JIZjFQd0g3aFJGUUVwZGRNZmIzT2twYkVK?=
 =?utf-8?B?RzM4cjhmMnlMWjR5Wmh6VU1CbGdJZCs5YzRORkpTdzJ1eU5Na25yNWtkNUZo?=
 =?utf-8?B?eUN6V0ttQWE3Vk04MWlJNzVlem1CK3VleW5MaU9veC9XSjlOd2NoMWxwZ05u?=
 =?utf-8?B?TDlLOUhZaWV4SElpZG1mVmg2YXdlSUUzWGhoc25DR1NTclRYNWxrSjdSUUR4?=
 =?utf-8?B?NjJnTk5PSEZpb0lNNkVYSUJrcU1ObW81eTdyUCt1RHR5aXNjUFRtWDJ5NWxW?=
 =?utf-8?B?aG1Eb0xNeFhRakZaaEpCbGo3UzJrazhwaTlXeXFuSFhrN3Y3L0M3bFBBNjlS?=
 =?utf-8?B?cVhyRmtueWhqN2QwMlloNFNhRm9VZndVeUFJc1ZoZUhTTHpYUXRrbXNTejNC?=
 =?utf-8?B?TTBBcGFXTGI1U0hnNmhNUWRycENKMXFvM25McHlBRDl5Mktydkt2enUzNURN?=
 =?utf-8?B?Nmc3MEFsY3RxYzhvSFJzL1cwOVQ3Mk1WblNSa3UwMDVPM2lxTXJVOVdWSHdh?=
 =?utf-8?B?dUlJVFE0cU5BTG95UW5IYmQ4TTZaUjhoVjhNOXRBbloyRUpybThrRzR4S2dV?=
 =?utf-8?B?UEgvdThyeFZLb0tZZHF2S21GVC95SnBkWEpjYzdtMzIxL2I3SWdOY1FrUTlF?=
 =?utf-8?B?QnY5TG9uNTdRVDBMUHI4c2RhYVN5YU9lSnp6dmdnSGhUck03a3V6b0E4eGxH?=
 =?utf-8?B?MkRBNHByNXlXZTVvcmVvV1NNRTFOSU91dTk5aW9WN1ZTMnNKMCtaWWdGVHBi?=
 =?utf-8?B?bDh3d3MrZ01aRGVtT3ZRdjl3bVZJT2Qwa1RoZFRVR1piTkdjb3AxQlhSTFdh?=
 =?utf-8?Q?2J8ogUy+JiZsD6KWlDz1FQj+r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e49c83-689a-412f-b82d-08da7a1170c0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 14:14:15.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M23QmB/ihfENM/DNpyllm3K5MImBqEfdrs2ECJDwWdBusLmFz3FYHBquA/mws9Z8Ds1nwBMTtTZRlHtnIJdJpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-08-09 um 08:31 schrieb Matthew Wilcox:
> On Mon, Aug 08, 2022 at 10:42:24PM -0600, Alex Williamson wrote:
>> The below referenced commit makes the same error as 1c563432588d ("mm: fix
>> is_pinnable_page against a cma page"), re-interpreting the logic to exclude
>> pinning of the zero page, which breaks device assignment with vfio.
> Perhaps we need to admit we're not as good at boolean logic as we think
> we are.
>
> 	if (is_device_coherent_page(page))
> 		return false;
> 	if (is_zone_movable_page(page))
> 		return false;
> 	return is_zero_pfn(page_to_pfn(page));
>
> (or whatever the right logic is ... I just woke up and I'm having
> trouble parsing it).

This implies an assumption that zero-page is never device-coherent or 
moveable, which is probably true, but not part of the original 
condition. A more formally correct rewrite would be:

	if (is_zero_pfn(page_to_pfn(page)))
		return true;
	if (is_device_coherent_page(page))
		return false;
	return !is_zone_moveable_page(page);

Regards,
   Felix


>
>> Link: https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen
>> Fixes: f25cbb7a95a2 ("mm: add zone device coherent type memory support")
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>>   include/linux/mm.h |    5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 18e01474cf6b..772279ed7010 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1544,9 +1544,8 @@ static inline bool is_longterm_pinnable_page(struct page *page)
>>   	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>>   		return false;
>>   #endif
>> -	return !(is_device_coherent_page(page) ||
>> -		 is_zone_movable_page(page) ||
>> -		 is_zero_pfn(page_to_pfn(page)));
>> +	return !(is_device_coherent_page(page) || is_zone_movable_page(page)) ||
>> +	       is_zero_pfn(page_to_pfn(page));
>>   }
>>   #else
>>   static inline bool is_longterm_pinnable_page(struct page *page)
>>
>>
>>
