Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9284521E19
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345129AbiEJPXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345555AbiEJPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:22:47 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C669287A1E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652195215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnxDcbFV7WOZ0byOgiUFVmsEBVt8jzdShZ7LANDyJj4=;
        b=g3OzAgONJsb3V05tsNct5nOQubPZIgMO0609MjmBD30ZtoUUJ/F0oEgncjZhPxW83nu3bB
        dsJfq+WcezUKGAVZfM+6bsBwIQXWuCqWquqSgqjxKddDVfiIDWmnm+pASlX39zw1PKISlK
        OluDBvaf/htCovxRv1YN7GSGDuTxBNg=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-UOclb445Mb2Ml3jdjEUYSw-1; Tue, 10 May 2022 17:06:52 +0200
X-MC-Unique: UOclb445Mb2Ml3jdjEUYSw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZF0jBrS70u8LI70skWHUAI5ECfYNLnRThu4KeMkymwy9sRCnUJROktYok4Rl1nv9E0CEywNgnpPKxxoA3XgoiZ4pAhElPvXA/a7NeL6JFqROGnP33i/CuUhcviDIFObxEOxTMS+o/qYLm//HUqdfeM4cMS+Z4IriQKOZIZd6JczL1pHsPaAjmXUZ34L4zv9FEOH9Aj2RJU9s2Ch5XT1ZTQfK8sZcvPFKZvXJS0D4VqpcdRdoEaR6CxXFeqp2Ya0CDYKQrm1OCc+HH2jWu7vIdWz1xHQQ0sih6cflx6KOPfzbZht0TDDShpXXACG0uLk3QZ3VklsQvHeafQdi50C7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnxDcbFV7WOZ0byOgiUFVmsEBVt8jzdShZ7LANDyJj4=;
 b=JNfkp4UD3dFkODIsmytqo1/KMs3yK+26HkudnRVbL6nWH8DHpdO1utBXd+axEyQrVIMGBffpmOm59bDCHo/h7Ftjl+Pc5m3UCQXjIwKFtv1BU7EHeAbSbvceurRP8E7FCzmtaTo5Bs8SunBsAqOUcIhP/e5GYecofM9ni79v2HlZUhtJJytlAmNY/4OM+rsFM7792Y5UAq0MmK37OlimnBqFbxdmjjcns0AQPrgS2HIeB9Ir7IkmD6Wq+skEQ8qeb9Zz3zYM1qoq3wbN/cwSVM3x4aHsdchMGgTrTuZE/seqZUVOXNqxVGq6v2bGc4cflYjKuQP4n/ulJaSx3Vyt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5392.eurprd04.prod.outlook.com (2603:10a6:803:cb::18)
 by DU0PR04MB9443.eurprd04.prod.outlook.com (2603:10a6:10:35b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 15:06:51 +0000
Received: from VI1PR04MB5392.eurprd04.prod.outlook.com
 ([fe80::d8ea:1530:2554:61fa]) by VI1PR04MB5392.eurprd04.prod.outlook.com
 ([fe80::d8ea:1530:2554:61fa%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:06:50 +0000
Message-ID: <9e6ef8ae-f55f-0b47-02de-2d6827b123ff@suse.com>
Date:   Tue, 10 May 2022 16:06:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: manual merge of the folio tree with the btrfs tree
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Sterba <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220510183908.7571cb73@canb.auug.org.au>
 <55f4b515-1d1c-fd3e-0f93-4cda45261c91@suse.com>
 <Ynp/FDvASFnsVf13@casper.infradead.org>
From:   Filipe Manana <fdmanana@suse.com>
In-Reply-To: <Ynp/FDvASFnsVf13@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::31) To VI1PR04MB5392.eurprd04.prod.outlook.com
 (2603:10a6:803:cb::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8e6b176-bc9c-4d04-d430-08da3296b5ed
X-MS-TrafficTypeDiagnostic: DU0PR04MB9443:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0PR04MB9443715AF1CA9392FF4B42A1ABC99@DU0PR04MB9443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhS7f0rYL7rOyaVYB60LlCEmuhQlZeYZWDsgN7hVkZlF/ofyztpBA8G/HtLjxE8Mwqa6q0/L/GmPrOFK9nUQvgTVnl9TC1IPcSloBxOs27uqN4KUHtZTgWvKkoNapohlOnEML/31kQ7dACngcmywwO4XA3tj8ncKwEScatKbgAnSka3DtlE23OHgISZVzvyIgp8f0x+wnxyUse0ARdCgxzAibu8mB0u9PH+L0xOuJkYNyEC1R7BRQtj84ceWqqiEXg1LIhWK0wY/g1aH1VsK7I+8IBYF3Px5GXJnyAXGMfUXeOC5HFGoCsMf43bFBzd2k3Tu/9ffjmPS0utfIL+VW4UTwOWg4Z9dImS7j2X2ftYQqbAEtNDraaaP1kb65Nii7fzRxPlH6Sh+drHPOkl80CjZa2nu17NCHhqTwcQOy73h0rYjxy1hofZOd71JmUeaKXquARJtZtILiMSJrM8FgaZzvXe5eUT1xwON4Prmp5R1t8L2A9hDBEJhFdOy7Pz9BdnBLeO1fw3+A0R/fYRGVNuzsdehgOw9UfxPfXnsr11c+jQ771uWQ2tP5Qd4KuzIoR4SojyyGpbJ4RU4ySRG77ss1i+a4zNZaW0kmlje9gP4GyHa4vMW/MdmTloo3An8t2v1bmVeXJqGrjaeZxHMZ/idFvzGENx0Bjkb+ULvZE2JcW551iCtoZdJVhLHD8XtaKXEpP8iFrlC1Xj2rDP7mAYEsDOo4dCGIFIRaE4dOa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5392.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6506007)(31696002)(53546011)(86362001)(6666004)(2906002)(8936002)(83380400001)(6486002)(2616005)(6512007)(508600001)(5660300002)(31686004)(54906003)(316002)(36756003)(6916009)(8676002)(186003)(66556008)(4326008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW8rT2ZZeEZqVUI5a0U4am8vc3dIVlhBSUIwa1ZvMU41bkc1V2h0L2ZSRGk2?=
 =?utf-8?B?TW9VaW1NOTFhQ01XUllHVytwbnM0L2MxTHZEK2JrcDdydmtYc2xGdXFWYnNC?=
 =?utf-8?B?ZldSamdXbm42WU45cXlYcmxmdjZjeDdjU2FRUjllQVNLOW81UzArM2Y3SnNO?=
 =?utf-8?B?S3g4YStQZ0thLzd2SGJJZ1U1eVl1Ti9SYTFIaTU3RXIwdk94YkhxT3hSUWta?=
 =?utf-8?B?RDRSQmVmNE5SMWtHR2pNR1N1eVplTnprNU03QlFjUGhOZmJNUWdmRExBdDdr?=
 =?utf-8?B?U2VqT1JwMHBUeDJDTTBUamdvNzZqcHkwSktmYzJWTFVPNWRQSkZnTjkvTlNn?=
 =?utf-8?B?R2JCb2ZZOTdudnhFak94WmhMK2ZXNGZSZURPcXY5Qk80eXFoNXNmbS9GUVFT?=
 =?utf-8?B?Slgybk5JU1laTVNuSllrc2N6SVZNVUJ3S3dTVEg5dGhUYXZJNkJxZlZJQ3F0?=
 =?utf-8?B?SGx6eWhib3pIWHFsNW9UZEVHRGF0TU9VS0E0My9jeWlIZjZhbEJiNWFab1d2?=
 =?utf-8?B?QkY3V3cyS0o1Sy8rMXVUY2tNVy9VN1FlL25QTGxoRWZKdVY1L2lESEtEOTZX?=
 =?utf-8?B?RXBFUVkvMm0zYWxGeHB2blVIU09lOTBkdXlaRm9ESnBiQi9CYVc2OXdaTlc2?=
 =?utf-8?B?YzBNVGhFNWRraDhUYVVrZ2dkNTJVRWsva1RraVBTV3lLa1Bkc1ZnclFlRXli?=
 =?utf-8?B?YzhHekJNMlJ0YjF3UXFGTlVVNjR3ZTVOTW5CSVZDMTdSS3VtOFFuNzc4cmxO?=
 =?utf-8?B?MGlsUUs3R1IwcWZHMnNyVVJvcytOUU9VdXhGcUNOUWpUVUFzNWppeEJGM281?=
 =?utf-8?B?NXRlaHNORkwvc2FUQ2ZvcnpqM2RvK29VZFdnOFNHMm1DMmZhNTV6dDR0SzRt?=
 =?utf-8?B?REZlalJJTnFHWk1zOVNNdGpnaVA1VTNNemFmcFNOWXhXblUzMzhsWVI1U1R3?=
 =?utf-8?B?ZmtlN1ZhL29OYkJva1FwZGlBa1UwaFMwUHU3bEh4RU9kZFhMUjFZWHk4NWNR?=
 =?utf-8?B?dE5mUkdaVG5VclBmcU1TZ1hJZEdZeTM4WVpPUFBIMS82QTU1QStEQlZMWWJB?=
 =?utf-8?B?ME9UYkM5eTFEYk9xaW8wWHMxUFR1OVR3Vjd4bEU2RzB1akpNQjhxRXhnMDIv?=
 =?utf-8?B?ZzZLelczeWJKL2g4aTJ4cVd5R0krMWZaaCswSGdmeHl4L05UbTk2RmtzRlpD?=
 =?utf-8?B?aDdFRjRiUkpSVFBOMGovZEdHcVRvaHlaQ2hVSnpOcElqT3ZrbnVmclZHbkJL?=
 =?utf-8?B?TmszVk1UZXZxc3VRbkhVWkRvUm9tTWY0SEd4Q3BjUnZZcGx1dmpSS2V4NlFO?=
 =?utf-8?B?TGphTFNvN3RxT2pSUTk4eGszQU1BVEhBaitwbjJYWjErdnhVa2RpRW54OU4r?=
 =?utf-8?B?MFpuZ1FXZndKelZDYnk3akdRZnQvS2tuQms2MEtCQWdMVmV5RHhwRW5uelZa?=
 =?utf-8?B?ZFg4dEgyc2lVMnNPcjhmYjA2NWFoSkxHRjZ5dHgzTFVuMGUvSXRqRmpJQVJn?=
 =?utf-8?B?ckE1OEIzMzRobkgxcWZhUC9iUHRqR3BiUTFkeHpzR2ZPWVBQS0RuY25mU2U4?=
 =?utf-8?B?OGFwci8vQzNSSmEvUWs3RVg4K2V6VmtxT0NGRm5TcTQ3VmQ5aUJ4YU5mOFlO?=
 =?utf-8?B?L0FlSVFVbEtPZTM5dGNRZnpwZE5wTHczdGFTZTZPRzkyUDdiOFZhN216K0xM?=
 =?utf-8?B?VG1BRTI5ZEdaMW1XZU12cDc4aVdTZUdFU1A2YnkrcGdrK284Wm5EVnU1RUto?=
 =?utf-8?B?aGh0cVg2U1NTa2VqK3FvYld6WEhQRlNmbW1ZbTZVZGRMd1pCcmFGaDdpbEpK?=
 =?utf-8?B?aTJvOEx3d213d0ltSTZlVE04REk4SW42ekVqd3A0dFJHeWJBWE5tdE5wWVNi?=
 =?utf-8?B?TkpUQklxZEVZQ1Y0MHRMbTgwNkVZekZhQ2NRT25rTkxWRXE4TnNSb2Vyay9R?=
 =?utf-8?B?eUp1TGJRQ0QzaVBjMlUvM2dEc3JqVVd4bXZ2NWIwQ09PRHhIVjdjRTZvbE9w?=
 =?utf-8?B?MDg3bDkxa20yYTVCSnpoUklNN0JwY055NHJFbnpkQXdBWXNRd3FUN2hRaEdG?=
 =?utf-8?B?Q0k1cVhzY250K2l4dHI1bmVKNFNMQUpGRDNFZmllMXd5anZRNndIeU5uNXZ5?=
 =?utf-8?B?SEkrczcwRHkxZ3VQUHFadXlzcjRIeTh4MXpneEhMRzV1Um5qQjdYNjBXUDVy?=
 =?utf-8?B?dlIycCs2bFZ6TGxJL2xPbnBTbFZQM3BUUytvK1FQRktiazRaUldsRU0xNTBN?=
 =?utf-8?B?b3k1MUwzZjdwWkllcFBWbkhFazJvc1F1VmJPSUl4QWR6WVdRazB3Yk41YzZl?=
 =?utf-8?B?dXdCQjlSMVIyVERaMUpzTGx1dWc1WnEzSHpkOXoxWERMb3F6amgvWCtSanpO?=
 =?utf-8?Q?wUB7C7W5YhgjP5xAeo/VHxLEomoF86OPlXNSfyXYOP+OP?=
X-MS-Exchange-AntiSpam-MessageData-1: Hc3zfWclUrYvDA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e6b176-bc9c-4d04-d430-08da3296b5ed
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5392.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:06:50.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVtfOJJySn3LPbpeZFOTJPkvgQayshxxRjXUqhxU6HFHYLKLiUTUjKQwhxlRhNIVqmGV/BEY2LH5S8qHM0+NaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9443
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/22 16:04, Matthew Wilcox wrote:
> On Tue, May 10, 2022 at 10:43:07AM +0100, Filipe Manana wrote:
>> On 10/05/22 09:39, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the folio tree got a conflict in:
>>>
>>>   fs/btrfs/send.c
>>>
>>> between commit:
>>>
>>>   d1a1a97304b4 ("btrfs: send: keep the current inode open while processing it")
>>>
>>> from the btrfs tree and commit:
>>>
>>>   2ebdd1df3166 ("mm/readahead: Convert page_cache_async_readahead to take a folio")
>>>
>>> from the folio tree.
>>>
>>> I fixed it up (I think - see below) and can carry the fix as
>>
>> Looks correct to me.
> 
> Me too.  The patch this one enables is rather sad.  It's yet another
> reminder that we suck at streaming workloads.  But until we fix that,
> don't you want to use invalidate_inode_pages2_range() rather than
> truncate_inode_pages_range()?  If your send conflicts with someone
> else's write(), you'll erase their write to the page cache.

Send operates only on readonly trees, so it can't happen.
Thanks.

> 

