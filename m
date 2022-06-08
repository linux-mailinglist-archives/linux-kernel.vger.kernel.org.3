Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115CB542803
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbiFHHUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbiFHHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:13:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E741D880C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvEMeT6PwjTmyPEqMUPyDsQTT2/VfTuiYaTNk25wNznh7/WCr1VM0WEm4vq+o2yhA0Hl9z0mlTP724hCEV0PvHD7FvRo3mM1NH43FzQZdgiJ2wMZwDtcUU+WaTbE0j8uBPXC2TnrbcckewSq2U5ySSXJxdaGfTwQvGIXSRIoz9JOxC/+ZTz4z2yzgaIE4g8t5+fxXnAjXUhcjB84fLLdHtUi2vEvJraVhbHL3K1Is/BmNMKY6pw/b1bropeKvIm6VcuaFjGCcdWxAB+sEfi3BT3Fje2XyD9xIl2mAYA9JsswRgThZKBhvfu1YpptJMMZ77r0S5ZEK0ApZAzxCLI2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMx4b1eFJN+fBVWC5pCYiz0cNqeg4W901csL/SGANOM=;
 b=VPduYsgP4POYYWP5EIVqMTGuh6OGgNLqnVwCwHYB677HwPwimxbhhQ1VP9MVvtJtKNazq9hb0YQuQH5mEEE4D4iE2b1nq+GRwqp1kI4MAbda/5NGvuHkifBVWW+nBIuS0YaxdQaeef3Uc4yDpauDRgKz5ReQccc5hNSy2v0NEUwUKW1KDLr23lKrgIEhNjxKmsa2RX0hY/9sjXOBQgkcwlDt2jBgZW8Q0IN6Vc4z2TJT3UnOUue06M4MFW1VbTBWeRU9y/Bgxe8DemeRy7iulruypKwbiPv0XLXW6Xsz3uCiCwyzpMSbwdD8/h4I5sPkdXuF9qDAwicV586N3mSowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMx4b1eFJN+fBVWC5pCYiz0cNqeg4W901csL/SGANOM=;
 b=epHeIC+Qy++NQIxkslNmjH3qycbr3FLvhLoEThdVFgDNH3AlOs9+8CXzRJSx0luPPjXzi5rmsfQJWXCHpD2ijCM5eWYEKklVNWrVsvgko3uFj2sMav45OhVbP6/cvJCgcqbnis9B7MV+n9UVe6ond14BqeJNr9/z2t61jnlelwutiBW8oKNML7iyOkQ9bpEUZUdXn3BKhEINZdTsRtxWSztU6G2J7La0zSOw/DvpnVacHLXCSlEAQUdEwuWwnp5XrV1a/vuhhklIyCCmzIbe92yLe8OZXFZFXz5v9XMDwgASJdgzbZ73TDI12IkPfYXad+CwfBlgpSIAK6g5gtg5hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 06:54:39 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b%5]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 06:54:39 +0000
References: <20220607083714.183788-1-apopple@nvidia.com>
 <Yp9aQk66fkP8MdOS@casper.infradead.org>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap.c: Always read one page in
 do_sync_mmap_readahead()
Date:   Wed, 08 Jun 2022 16:35:16 +1000
In-reply-to: <Yp9aQk66fkP8MdOS@casper.infradead.org>
Message-ID: <87sfof8x1w.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b0415a5-a8ad-4b12-50dc-08da491bc200
X-MS-TrafficTypeDiagnostic: MN0PR12MB5931:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5931D37AFAAB7C1E6BACFE3FDFA49@MN0PR12MB5931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo3dOwPx6PIjA8+eZjP8x1UIJ/WVInh1b2yqHppBhDWUU2sEibWw3+oQnjOrOtEe/YMqFV4e33dWgDP7ADTdqVj2Hx5fDzzTAts3kZb+uHxWFWsyw/P+gU+GJRt72eorUTbwBCGd9vUYGOoII1fE9AjXSY9RgbYAhzjC23dxfJyowUVTeVqj8ts42BU1TRpKTH70jRfEux4yqIawZqz2ziKRlwiMn0w0fuHPNI0pQGxeNVwR3YlUQw2mKUaqaVqwlqgtUbJvrjhw7D8hw0rS8HifrETjl2nZEnCbGJbVSBLWU8j1l8vDRi3qmlMOgeubfI4MgRiCE/ciRDpWWUX4dq7fYB/MQjddvXStQXD1p8STX2he1gmoKLXO9Ui3DR+RFIE4sk+f1LyZPchv8DJ9bmnbMBfYGXBZJXl0lolInqArKVdx5u5F2wXCMA6wC7+HZagXMXZ75H2eSndgP7u+foGFMcqlEGvZCWpaSJFHKOBdDi7g1zbYhT7prYyHav28iNH7idmi9Av5gJr2iysUGLnhUtxdjTsu2Zew3CX79i/6L0zvrD96ckpAbmGc2u0In9jAlnVmydDBhGgBCTTsPLkq7D/iI3eFeLXzCN06/fDZBsfKE3eyvX70v0gcHOa7fwTBRVJmx7CVPIEi1s8aqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(8676002)(4326008)(5660300002)(6666004)(66476007)(66946007)(66556008)(6506007)(26005)(9686003)(6916009)(316002)(6486002)(86362001)(8936002)(186003)(83380400001)(508600001)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1d651l75MrKYJwo9ZzQEhSpQAd3Hij+0THbKxzrkw7JIDYNNd3NbhUPQd1F?=
 =?us-ascii?Q?4Kvr20iwKha6b2UnWKlLIR2DZi9sHOZkqkj8Np0oks5SSsOXd1ic65oDnQZq?=
 =?us-ascii?Q?Gq7CLjjWgSCANemC3piL5/ZXuZSRrxUGeoqzPWbkLGV0dwINp/MXj0BRj2eb?=
 =?us-ascii?Q?+Eq0CwqVEaBw2/wphZhcVofCRn/ABGtDhW3y6IxMKegEEf9WBnSgZaRahamI?=
 =?us-ascii?Q?jskWbXThl4vVNd0bnvBDHOGICPAmzQ5YB0emZwbYDnCLaD7spP4G48zx7G/c?=
 =?us-ascii?Q?R44ed9jHNurbOgXPHSwVv03V0wAoFjEZ/pE3n1vJzwWOHUtnZh5iexiTUdH4?=
 =?us-ascii?Q?w3BaS9H+WepxLKb5dulQXngnEFWF1coxfsbwxAy18EWUp2Eh3wzYGHeFTG2h?=
 =?us-ascii?Q?Jg+Ck1jqC9+wamrE3jI4P6+JhsOQPJiTubx7KbiDz/d0AXOYqvGW6eZVSQXx?=
 =?us-ascii?Q?2JWEUhuN22RiazTVPrZUT+CiuRRw5KoJUvACHzB2pe6Au8pNi0SxDPY17pLv?=
 =?us-ascii?Q?nKP05JLSr4SG2YSzhS09+TRBG449fRsfq/X4EHnU5LvLi5KrP2CipMKNBnDX?=
 =?us-ascii?Q?hfJnmC+9SY0AekXn9dBd6HPYOlQjUJCKba7cito237ekTb3f75xmnYdzK/Yh?=
 =?us-ascii?Q?RtvJwyT+UJroUfna1JHVqegEi5RJOYeJX/mbhkvkkSlvjEFkVmry7AAJTZ3D?=
 =?us-ascii?Q?zJcwGoKrgjgPbsCgF76yLZC8wggR7zXEQSsOx1xX1hnIFrNxQy9Z6AThIurH?=
 =?us-ascii?Q?Ug9x0S+c8h2FZ6gkIcJRQ2dD067A2+QvwF1HWF/X+ZN+3i+Zx1Ml4gdEFSgn?=
 =?us-ascii?Q?Fe9MZrULxjiTCmoR3xNb3AqnSvpqHRe/9Y5yvMlaLO0nUo7oyq1h1LnFqNCF?=
 =?us-ascii?Q?gyCzadmsVEnDbPzaWyfmH05qWvP6rx9lnJrM0yH3UaoYYb49i8eJ/Jg98lTn?=
 =?us-ascii?Q?MLoTkx3ZqGhDKBw4a/NtwtO4oKRMZh66caiEKVDSrXlagmW/XEO65QC+oPFr?=
 =?us-ascii?Q?j0GmVMOpd8bly0BBDrGsAdH5JkXxLZmtgty/3kWb5XzBnr4z7w3BnllGDauI?=
 =?us-ascii?Q?Cq2gIpG/8EmT9CYB55HxRsHGWbW09DFYZqNVLfFsL1WCxLGQpiUtdqO6LGvm?=
 =?us-ascii?Q?PHf1N2Zg2oFQGMoO32K36y3XlEv5DNPu/SBMlKGnJqAI7BmRWYAV3XfsaUXJ?=
 =?us-ascii?Q?m1qnzJ2xNvYFFL+OfMjU9nlrLi0Xrk6O56hnELF6xkxvz8Tbj/esXiXIaL6Q?=
 =?us-ascii?Q?w+nWL4iz+IlB8t8vvC2EhcqgWMdwhFgGQRY/Ub7LCvLoGrw8KEv/lZqsA6vt?=
 =?us-ascii?Q?P2LfStKfRGVuBTLIOfDp1AtEU4C6Y82VssumpZHf+pdvPzTni7YcCi14TUtK?=
 =?us-ascii?Q?q6cOjKgO8FkmzHwyYjOFkQ+mbvteRG+LAFCRimwff1aHDcZgpVqy8oHYgnLr?=
 =?us-ascii?Q?Y+xwYkbNTi57AOkrTWDbEy9185undmGMqckFPazhJRTekPLk8NWpfRyRWIay?=
 =?us-ascii?Q?kO39eR4L9K92GMwo7SgLOMtcysYUYf/0Boqa3mcvgel0J+3/60P1oFX3F5GK?=
 =?us-ascii?Q?/vhogktHsP3lHV3BfU4AlzDAblN1kiR/9rjy6JeyNz8fKnIRYzuFMYzDsh3q?=
 =?us-ascii?Q?FskQdMXoO1q8AV06xCsqI9EJlx/LTD/LoJIkGyPX7K7tqsDCDWVA2onwXv5J?=
 =?us-ascii?Q?w5MiOHa1+zRJG69uZVktROAXzE9s0b6V0wWsfH9+sYXYbWWli417bv5iOrXK?=
 =?us-ascii?Q?jfEYmjPFtw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0415a5-a8ad-4b12-50dc-08da491bc200
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 06:54:39.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NycnqZKlJmD6Lg1q2FW7bcJUH4z9GqV4XlPJKpbi3+Y8FfebmgWqVKFJ/yq8NUC9GYQ4iFrnqYSENOAmf8pmeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Jun 07, 2022 at 06:37:14PM +1000, Alistair Popple wrote:
>> ---
>>  include/linux/pagemap.h |  7 +++---
>>  mm/filemap.c            | 47 +++++++++++++----------------------------
>>  2 files changed, 18 insertions(+), 36 deletions(-)
>
> Love the diffstat ;-)
>
>> @@ -3011,14 +3001,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>>  	}
>>  #endif
>>
>> -	/* If we don't want any read-ahead, don't bother */
>> -	if (vmf->vma->vm_flags & VM_RAND_READ)
>> -		return fpin;
>> -	if (!ra->ra_pages)
>> -		return fpin;
>> -
>> +	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>>  	if (vmf->vma->vm_flags & VM_SEQ_READ) {
>> -		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>>  		page_cache_sync_ra(&ractl, ra->ra_pages);
>>  		return fpin;
>>  	}
>
> Good.  Could even pull the maybe_unlock_mmap_for_io() all the way to the
> top of the file and remove it from the VM_HUGEPAGE case?

Good idea. Also while I'm here is there a reason we don't update
ra->start or mmap_miss for the VM_HUGEPAGE case?

>> @@ -3029,19 +3013,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>>  		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
>>
>>  	/*
>> -	 * Do we miss much more than hit in this file? If so,
>> -	 * stop bothering with read-ahead. It will only hurt.
>> +	 * mmap read-around. If we don't want any read-ahead or if we miss more
>> +	 * than we hit don't bother with read-ahead and just read a single page.
>>  	 */
>> -	if (mmap_miss > MMAP_LOTSAMISS)
>> -		return fpin;
>> +	if ((vmf->vma->vm_flags & VM_RAND_READ) ||
>> +	    !ra->ra_pages || mmap_miss > MMAP_LOTSAMISS) {
>> +		ra->start = vmf->pgoff;
>> +		ra->size = 1;
>> +		ra->async_size = 0;
>> +	} else {
>
> I'd put the:
> 		/* mmap read-around */
> here
>
>> +		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>> +		ra->size = ra->ra_pages;
>> +		ra->async_size = ra->ra_pages / 4;
>> +	}
>>
>> -	/*
>> -	 * mmap read-around
>> -	 */
>> -	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>> -	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>> -	ra->size = ra->ra_pages;
>> -	ra->async_size = ra->ra_pages / 4;
>>  	ractl._index = ra->start;
>>  	page_cache_ra_order(&ractl, ra, 0);
>>  	return fpin;
>> @@ -3145,9 +3130,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>  			filemap_invalidate_lock_shared(mapping);
>>  			mapping_locked = true;
>>  		}
>> -		folio = __filemap_get_folio(mapping, index,
>> -					  FGP_CREAT|FGP_FOR_MMAP,
>> -					  vmf->gfp_mask);
>> +		folio = filemap_get_folio(mapping, index);
>>  		if (!folio) {
>>  			if (fpin)
>>  				goto out_retry;
>
> I think we also should remove the filemap_invalidate_lock_shared()
> here, no?

Right, afaik filemap_invalidate_lock_shared() is needed when
instantiating pages in the page cache during fault, which this patch
does via page_cache_ra_order() in do_sync_mmap_readahead() so I think
you're right about removing it for filemap_get_folio().

However do_sync_mmap_readahead() is the way normal (ie. !VM_RAND_READ)
pages would get instantiated today. So shouldn't
filemap_invalidate_lock_shared() be called before
do_sync_mmap_readahead() anyway? Or am I missing something?

> We also need to handle the !folio case differently.  Before, if it was
> gone, that was definitely an OOM.  Now if it's gone it might have been
> truncated, or removed due to memory pressure, or it might be an OOM
> situation where readahead didn't manage to create the folio.

Good point, thanks for catching that.
