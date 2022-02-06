Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE0B4AAD76
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 03:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381564AbiBFCMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 21:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiBFCMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 21:12:23 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A29C043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:12:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TojeQUZU2JY++5jx+CS0yrmvj8T2q3bmzJKwt7QzYRYnRKIMxGdDrw2z2DIrns8hIIr2R+a7J8ZntwG/54HcTSbhI0T/q4M3vjmKlhrq+LgWKV5GYY6wlDLi+mk/+sbb41VDpiSYv1fmvRsPW2Z4O5QRGrqV8EwGZhbpsF3Ipm2dl7Jzuhy/kA05TQidBUrJBB1ZUMebHvmx5Yt5MsPwidj2Tach9InEtRN9vnfo+9EjIPCZHCjtC/qnmL+zlOigcdUtKkT6HEEUScKf4PCngmBc7aXyMSizNPXCD0c7CgqU39n0ONG6GAbUSgbgQgmq+P8C/zV3Fh98M+58hWYn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+V5OfOdyyprrf9++A1FZS9SXuXbhaFg7CzUpkjl2jc=;
 b=DDpaq87Xhx4pE8YPs0jujcs96UW5FXuGcgCi0+NuNMQdZBt0ngP+hsFIsjXSrTneO/m3qoUDqV1Z4freM8+nDV0WcUG0Qv33rwpI2aj7U0dpHgCovZOkzJDLH5t4aBrKvvV5bBaLkv/WD1XSCbBM157T6cZZzkLWfpyQnUyOT70HhJWipj0pzd9HPWJaIimrJAHc2a5131n0OynT3NT2ptQA/eghpdIv2yFwmLjqw2iD/bRku0JdeyE24Gzs0YLv2xs73e9mYbDOeAKRzvY3LmjFzYw+7YRfcnZDpqMdG02TmlPCq2KFzr+rV9kBkzhgFV1MZnT3ueKLXe1PcTz7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+V5OfOdyyprrf9++A1FZS9SXuXbhaFg7CzUpkjl2jc=;
 b=Ep2+zXM1BPN9NvYTnPV/Aw10ivs1Y6a2xveJcMmgF6SZPcnzhZv7Ai6Wh9h3LQFpgEgJ5Ap/gE6N4QDGtNGTvZRSyJQs81Y41M9oHwmVtN2NKxX2lj/LkVrWLW1gXNztVm/SrSUQdAALVlrdtWVa773sG0uQjf9cvl3AYMaYHtHU/IBBoMMIT8wY6AK2sMlBJD4LRRa+LYIRzOxM0Ae25i+9gtO5xHpfT7pH1bPeD1/vTUXyz4mQOa6CyfjntaL9pkd4hBwDpjg/t4qxzQ4J9NEAm03lEpU/PnVkYf0wARIg19VMg7q5XijeYhbFaiceM+ZH9jDisiTQjxZnDYXSmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR1201MB0198.namprd12.prod.outlook.com (2603:10b6:910:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 02:12:20 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 02:12:20 +0000
Message-ID: <171375fc-5654-a727-a6d1-e92bf574d3c0@nvidia.com>
Date:   Sat, 5 Feb 2022 18:12:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 16/75] mm/gup: Convert try_grab_page() to use a folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-17-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220204195852.1751729-17-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::37) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89f16192-6540-4f9f-0de1-08d9e9161af3
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0198:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0198C41C7165D5E81847DBC2A82B9@CY4PR1201MB0198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gh2bt5z65nvSj5MY5sa4/8Ng8N0JZxeFJKCi53fSMjs670k1ALmE1+HlbHj4nlPIZda+Tk+jezcj1srtdVHDh8FqS0uPsLk1biJ4ecd3YdfbB35K1iIRmZ1ceM+akD193bbDhmCQ7Agcharp5OZ8Nyh1GBkfWptPb6mnLG+CBwu/6B87fpq2WQnNvEyIGlrq6v3r9fnf129ZhOqZV1rzNbG7XSGGWfJobQpIj4Anupvm/D6/EDeG+eBTIuc9BKTPa/BQTuzh1IHR3sE29MEm676+XyCTc4Fqw6sfY2Y+yzQuo6MGOwW9ifz0ndBBVffrv2y5nBeCiXUfhJo2fCcodJuynGU86rTx/E0AiwKAAunXaGO2qoustm3ZB/RLIJH8PUY2my95f71XdlUeqWfIzfgcQVW48CevWEgqyJnG9u2aoLK3km+ttRjvZ5pGr5zAU9wNm6f16SJAwA8kjD13NrDYD7jvDj31+bpMCM0+rvFKksNW+xa+/EoGcz2zjsds+NYRGKzIK36h3K9AOUKUqvYnup6PzbXF0tBF6z7WxdWz2bYemLyt47htbXDOXaTNCkax9njHr3zJItP851v8YrITDdk2tGB5+7hGRvL9/qMp6JJxAUlpNYzMmbU2VH0VrCrnXJgGanDwqg2hMHs4BM4/o686zcZ9sseXb8WbG4bOpcXnF22RdIc7u0rBziyVu5pVOMM8OOHfFp9KITycqNuJJiJwOSpKOPvz6LTCRP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(31696002)(316002)(2616005)(86362001)(36756003)(66476007)(4326008)(66946007)(26005)(53546011)(8676002)(83380400001)(31686004)(186003)(5660300002)(6512007)(66556008)(6506007)(508600001)(6486002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3llcHg1Zi9udHRXRWpOWkl0ZkJzSmNEM2xHdldWazQxdU1lYXROL2dla1gx?=
 =?utf-8?B?NDhrNGpiOEFJU1pPZEZOKzNDVXZxVncycjI5UXM4Zkp6YStNZXM3M2VPbmVN?=
 =?utf-8?B?aFlsdDhqQnQyZEJ3RzYvZUNOY3J2OWNZbTZMazlpSFZOb1d0UDBMc3lrazZC?=
 =?utf-8?B?QTh1Q2VyTmtwMENQTHN3RUxqbU9DaDQyRUZiM2pHL3V1dVN1L3FUV0ZEajdt?=
 =?utf-8?B?Zlk0TFJNeURSbjhiMWtmMmp5am5WTTdoN1VKdzR5MmlPWWVwTk1BRnNVbnhh?=
 =?utf-8?B?OE12bXFhMHdEeFdZdHE2ZUQ4K3BTMmpLa210aGNRNDVyZktRSlIvVjQ2clRJ?=
 =?utf-8?B?TG1yVVB1REdVWUQwK3ZKNWxHNXdBK2twRVR4M3VzNUtwYThQQnhEdCtMVlFF?=
 =?utf-8?B?UTFRM1ROWXJTOVJ6eDBMUnpCY2RnT05NN3Y5bVR4WklMMTBEUHRrQnNvcEpr?=
 =?utf-8?B?MXJwbStzVHhaalRCa2dGZ3hwcU9VZUJDSThtNy9paEtOYVBkZFNnQzFJay9Z?=
 =?utf-8?B?Zi91czltcHVmNlBObXd2Y1B0ZUlzYnlGSWgvQUVMQWxNRUxrUmNoUENXa0R0?=
 =?utf-8?B?anhzZEpFL3NraHNnZEovT00vQ3hqOEZybUVENGxDamovZUw5ZGNXWjhQcDVG?=
 =?utf-8?B?TDc0QWkxbmxKTUpiSG9aK2pxSEVYa1k1T0l3VjdsWThQZnc1LzRYUmw2aVRW?=
 =?utf-8?B?cXJiMkwxSFd6ekNValZMeEYvTXdjeHNiVm1Vc3E2T3ovdy9COGJXSG1jNmtz?=
 =?utf-8?B?YTlVaENNamIxdkh6Q09NbE9lbTV6SWN2bHlKUWMwaFdIQ1ZrS0tmYXhRRnVG?=
 =?utf-8?B?bGFvS1JlcHY4eEVxeFRyMlNsTndvb3l5ZEVvcVVJNlh1Qk4reXl4MEFqZ0tu?=
 =?utf-8?B?Y3Z1Y21WczRKd0ZuZDZ4dkthdlpXemRhZDJVOCsvaU9xRlNRbldsMGRtejVw?=
 =?utf-8?B?VlVkTGQ0L0JpQktpaTlxR016eUVBeGIwNmg2cDh5ai9tSmtWOGJudEVLc3N6?=
 =?utf-8?B?cXRMeHJhVWYyOEdLRUFlTTRLV3VsQURLL29zOW5INVcrUldCWG13TjVzcnIv?=
 =?utf-8?B?OVR0RVZNZXU2T3UxUEFONzhwdmJvVlh4cE00RVRTWFZPZklSWFV5Q0w2cDQz?=
 =?utf-8?B?OVFxc2p0TjArUEZlbjRTQ0NvSEZneEM2bzNkaDhMUlNYbHJBNkdHanJpYmpK?=
 =?utf-8?B?cmVhdzh1MFdZWFF4aDZLRCtnNjNqbzhFQnVCR3U2cXRiTVVBTjY4TjZvcjF0?=
 =?utf-8?B?VW9vQ2x5SGZzVGM0eGFDRTlGN0ZUUktPclhneHl6d1ZWbWJXWkl5NU1zM0Zy?=
 =?utf-8?B?QllvTUNrT09neDV2YTY4TWJaYUc1T2Z0TlFJcTgrclAzTWFvU2tBS3BNVzd6?=
 =?utf-8?B?VnVsa1d5OUloOGVQWm44Y1FFaXExRGRiUE9ZSDRQQ3dpVFZRbzJiSThyNjRh?=
 =?utf-8?B?Qms0T3hqaDJBeFA5cmxNT25zeitCbzh5Z202OWQ2WVNjc3E4cmFnM2JGbWMz?=
 =?utf-8?B?TklnVVhCTkl4K0g3OC9WaHFLQUs0a0JMbzRtNEhXbFpqdlUwNnhldTJNYy9Y?=
 =?utf-8?B?eisyQW9wZ0tJVHRjd0ZMSllHaWlDWkVWUjlacTBYTzMyOWxuUUtaZkE0UEtZ?=
 =?utf-8?B?d2dHY0ZJVXFsMEFDZTU0Z1JRK0pqWmNkZno5VzJ3TWF1Um1yN0VBZldPeHBo?=
 =?utf-8?B?bjhQaGhkbjYrOWgrMlYvMm9UWVdKZXJtMG03NkRDbUpHOW1YVDVueHBMOGRT?=
 =?utf-8?B?NnFTc2xlcGZackVXaEFlQ3ZqeWtRSjlkZEUrbVlqZVQzNnplTmtqb1huK3Zr?=
 =?utf-8?B?dUZWTkhZUEppRko1VHh2ZXpmUjZPLzNUTHQ2dm1FWWhaQnRpU2lxREpMWTEw?=
 =?utf-8?B?Y3UrT0kvRXI0NSszMlYwc3lDamZMeDdTbENLV2F5NUxiMzBsOUVvU2xxS2lO?=
 =?utf-8?B?YmlTUUhGS2F2elB4SURVdENGdUE1VUdRbUNzKzVVcG5yV2pQWHZoT1ZmeUd6?=
 =?utf-8?B?d1drS1c0bHcrYnFaVG1OVmVCNDJ2UktkTW5SYTBRblozZmdqNit0eUFMd09y?=
 =?utf-8?B?dFBjdDh6Y1RmVng3ODBPZVU5R1oxQ0lrRFQ1QXRqQjNabm1OSGZZVE8zM1lV?=
 =?utf-8?B?Q01VeW9BdisvcENqeTg1TmdwdGx4NzhHenlXYmo4cjVLTVZ1djErTjg3cjE5?=
 =?utf-8?Q?5Q7Y/FP4yQodFjMZAjgjUMk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f16192-6540-4f9f-0de1-08d9e9161af3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2022 02:12:20.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USmclEhndBIMCwwhF/KgvtLQYVjVmEEQe3WkHBjV8In27EQ5Kb+H5+Sbb0Q64vJVeF2vtno7kAG4nbtEEa80aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0198
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 11:57, Matthew Wilcox (Oracle) wrote:
> Hoist the folio conversion and the folio_ref_count() check to the
> top of the function instead of using the one buried in try_get_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 4f1669db92f5..d18ce4da573f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -174,15 +174,14 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
>   
>   /**
>    * try_grab_page() - elevate a page's refcount by a flag-dependent amount
> + * @page:    pointer to page to be grabbed
> + * @flags:   gup flags: these are the FOLL_* flag values.
>    *
>    * This might not do anything at all, depending on the flags argument.
>    *
>    * "grab" names in this file mean, "look at flags to decide whether to use
>    * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
>    *
> - * @page:    pointer to page to be grabbed
> - * @flags:   gup flags: these are the FOLL_* flag values.
> - *
>    * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
>    * time. Cases: please see the try_grab_folio() documentation, with
>    * "refs=1".
> @@ -193,29 +192,28 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
>    */
>   bool __must_check try_grab_page(struct page *page, unsigned int flags)
>   {
> +	struct folio *folio = page_folio(page);
> +
>   	WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == (FOLL_GET | FOLL_PIN));
> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> +		return false;
>   
>   	if (flags & FOLL_GET)
> -		return try_get_page(page);
> +		folio_ref_inc(folio);
>   	else if (flags & FOLL_PIN) {
> -		page = compound_head(page);
> -
> -		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> -			return false;
> -
>   		/*
> -		 * Similar to try_grab_compound_head(): be sure to *also*
> +		 * Similar to try_grab_folio(): be sure to *also*
>   		 * increment the normal page refcount field at least once,
>   		 * so that the page really is pinned.
>   		 */
> -		if (PageHead(page)) {
> -			page_ref_add(page, 1);
> -			atomic_add(1, compound_pincount_ptr(page));
> +		if (folio_test_large(folio)) {
> +			folio_ref_add(folio, 1);
> +			atomic_add(1, folio_pincount_ptr(folio));
>   		} else {
> -			page_ref_add(page, GUP_PIN_COUNTING_BIAS);
> +			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
>   		}
>   
> -		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
> +		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
>   	}
>   
>   	return true;

