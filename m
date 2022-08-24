Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2959FC79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiHXOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiHXN7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:59:52 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774A2CDF9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6j4DEEBKGQBwjMUWhsCme0JAusCufS1yI4MIwc3Rr5ynugbP31vTmr40/+qXVDHGnN/HZMmDsK8lJz4P8TLCSZdNtZHdynLtA2iIaBe2k8pTXJDyFi/VQCY/9GRBpiblRDUvAfYnLYmmqjxmIUwdvSVRr4sdZJEQm0fde1BoNYOL6JK7X4gP4EQ/wyfYpCu5qrrgIH3wbt0yGldbHVG4WlcqBowvot/lAgr9K2opRxVNlqtvBZom4+oC1UvXXf0bXrS7OFsnzo9rcO4dPhr9J/Ogsay6ZCQAyzdYc69VJPZp3elRyKvPiMFz5hjinJRAzMI6luRJ7tmjUoFHM45zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gyS8vcRNt2Q2fHYVTJKCjJ6wmddKHar1KBJzE7SeP4=;
 b=EADJFdKeYfh27prNSXXzySymhHtDxc9J+Uu02nauGKUcCnuOhoAaZuOakNsCQIhnpf+OVe6+f8HuBpQyRVKj4nW6wCHoWCHI2kdc5dGHFamsyWPJrGv8l/7xlEHDkATTYqRJ25S7DHMc1gvTU3lXWXDA6kTDNP833o4TRJco+eFwp6V+Q1A1FAjtHW9GC8Y5XibvATOmVHVLb/4wG+zddL48E8S1uuHbf+71gWhQcgnxibV4bAr/72pznFyNvHLSl3nkmNvFrrp0OiFh1GIntVBok3gvL/jFzRAQYRCGsL+254v7nlVaxyOdfnlwH5j101R0VVUCdlKHKDpvh02tFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gyS8vcRNt2Q2fHYVTJKCjJ6wmddKHar1KBJzE7SeP4=;
 b=WubMojU4uQM0JwD1ZpLX1QgUBJIi/gZdAcolmWfKU/NGmBXs7Kqtw9Tp9bj8ukp4pbpDA+cTNyVVe/H0Hxmj/NK4PALp8nvWX9Yqa0l5Y66QzKNY6R7eFD9NFY51zCYY2ZsB2WUPwqjuhVgIxJ58FC7RpYajukYYymfetV1Tdu9V0CGdop3QdHuOVIZV1Phs+MbK2/dcZpJNAtuoA/B4sh2GAoq6hasnT5ErABEkCHkQCzqLS3q9P1mAz0J8fcGALnHD5pqj/t0nwZcbkWvqA0wSquhTHcoKb3eVRefIkl44D0den+uNwrG8jHNj0nyCElaToWQZGp56Xp8t6f2jsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by VE1PR04MB7232.eurprd04.prod.outlook.com (2603:10a6:800:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 13:59:46 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2d5d:bae0:430f:70ad]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2d5d:bae0:430f:70ad%4]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 13:59:46 +0000
Message-ID: <0f5f26d2-2b22-2a0d-8bb2-ee2e729ada3f@suse.com>
Date:   Wed, 24 Aug 2022 15:59:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [POSSIBLE BUG] Dereferencing of NULL pointer
Content-Language: en-US
To:     Rustam Subkhankulov <subkhankulov@ispras.ru>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org, Juergen Gross <jgross@suse.com>
References: <6228a437bb9d7f677f5e97973518bcd555bc2a07.camel@ispras.ru>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <6228a437bb9d7f677f5e97973518bcd555bc2a07.camel@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 557de305-f93f-424e-0c9b-08da85d8e705
X-MS-TrafficTypeDiagnostic: VE1PR04MB7232:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDLTcvT0oucbinoHDL9l8WFrE8+oRIlqu4Nba1aVr06sXqpG6kxKDQA7PT6EFrDhu4EYg/D+agjUvIk8tbJebv+b86RVZWPHOCZvJXK7iqe86NyN/fH14UPf/IwE+Zlo+dPmkhLhYe8Dgp3kt+DevaXKFBsmQdehtwZg9fXL0OmYoFo/2KkjdVjjq5Ve226FgKsAh5E2ldu6McCQwGrRCOxe8sQKMugIlQzeuDnfUUhKQ3CKEL2hTBsvX8OcIhy96BFq+WdRoVZTznR0rX4NUQWNDelhvmAutxV2cMu7ybCbF4SrtJm4bqxQiUkgo1XQ7xj50IZ8IGT9/rxheTlsbuKr6ukbhdD8ZpZVCKhO0NwUeTWcdw5h+AgjHgvrnJSI/OShEIjJfSyyIgA+G751cy8+z2+I8YVS9q//bca99z15PRuOfOitkCKZrct+AprlANDTvpakfSUwCs83+kMgpF2BtecMNmzk2/DSbKCaOQmlzU1zYq7TURy9ctPLcO6r8aseRd0NHaENkxlVnoCypdKLr8crPrVw0vI78wSQI6gQmFzA/mvtKJhJiwz+wgTb824oEbBcl78XKwBUOJcyVJXAcOKzLxKjfjubYv5kGip1UB/oesi9KfCDP4dW6mvMxlwbb1E1A/zdeEaZsbIY38o0Jxh8MIewAFUYmoF69VfZwbSzVpvtO14RpU5tDwctC+vaovaesRIDgaVcEQcwTZx+B9T9TwYOZxssd0R5vFYOwbOk95J2abBBDR6rrwadc/wNIsOC0C9Np7ClnTh76wY4wp3QJIKxRYivgpWLZsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(39860400002)(376002)(6512007)(8936002)(6916009)(83380400001)(26005)(36756003)(316002)(5660300002)(2616005)(2906002)(31686004)(186003)(478600001)(6486002)(6506007)(4326008)(38100700002)(54906003)(8676002)(66556008)(66476007)(66946007)(107886003)(41300700001)(31696002)(86362001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVUzL3pwNFNaYlpTb3FwY0kyN1ZxVlJGYjl5em5aalRMTjY3QjJmRkhmdUkw?=
 =?utf-8?B?dlhmdjFzeDR4eEpULzVka1l3SExjSUFieENlWWZSYkhYTE1UcUwyejFDVUZL?=
 =?utf-8?B?RzJqb1VTdkx1QkQ3emd2Qm9kdGNDSEl5cllUdjY2c0grM0wwaFNkbjVySFFG?=
 =?utf-8?B?c0FwNDdWakd3bTdXcUdUSkU3RUs4WFJiRVEzTUlpVGEyT0JoeG9vZmVpbFBm?=
 =?utf-8?B?STc3YlYxa1VoZUg4bG9vZDh3YXRDQUFQZEpPekRrdjdOTVJra3dXWjljWDIx?=
 =?utf-8?B?ZkdHSWNRZGRDK3dqVEFZc2J3amoxWU1OV3gvclJSeHU3b2tXUThEMXZneXFp?=
 =?utf-8?B?bndqYlFJK2xaeHlwaGJLV0ZGQVUvTlUrWXloU3RnSVJJRXVoOFA3c0NTdU5M?=
 =?utf-8?B?TXhmNlpXbUc2YXEzdEYwbGdEcyt5Z0hUWldHcm5qeGJxZk53bWRrTndHWEsx?=
 =?utf-8?B?MEtXM24zcTlHT1pqcHBSV3lzVVJ1QjUyVytobWFYZWFoc2NZYzFJMUp3WDZF?=
 =?utf-8?B?dWRObVQ3SFZMYklUYVdNVW94OUxzL3dhQTFVZHRtV0UzRXkySHBlVUI2WmJ2?=
 =?utf-8?B?Q0ZpQitvdlB1QjJZVmd4cG0wa1BOWXZOUmtCRkxVRE1vZGhjdWpKbHZndWVY?=
 =?utf-8?B?VUZPeWxLRVYxN1VnSUlHcTJKMnlMQWRCQXNiaWJzbHJQTzBNTEtUSkc1cE1K?=
 =?utf-8?B?aTJoNkJ4UkxSaXFsMlpSZGowN2sxNlBwMlNYWTVRdXdjcTcxTzNNRnpNaGNh?=
 =?utf-8?B?VGhMaTJlZEY4T09XSGhObnM4V09OUEhNUDI4eUtaVG80NjNjc1JNUVR4cUZO?=
 =?utf-8?B?b1puNjUwbmdSUENMMzY4d09KVWlHMVNiQWROR0dTdVlOVjUyemU3QkdUMXFO?=
 =?utf-8?B?Vk14bWhoYzVpOVFORkxsYnZTOFNEWHNuODZhZlhaaCtwZnFaVFNMQlAvdUtL?=
 =?utf-8?B?S1JadEFCRGxIeVMyWVhwczNFOFVHdVk0L05XaXNpaVlKRUNxWld1Sk1CY2w3?=
 =?utf-8?B?L3BQOGcxZEd4Tno2U0NGQmZSS2x5SElqV3VMakVpV3FxTVdXM0I5eXhjSk9P?=
 =?utf-8?B?cjRWTGErbzhlSXl2Q093RWtjM25JRjJPbEhOL0Roay9UNWd3RDUyWWEvSW5n?=
 =?utf-8?B?MGZiMDBWOThSdm5LdmxWOUNxOUFBOEwzQnJnZVBiamdTdTF4SlE3WG1WbzYv?=
 =?utf-8?B?clBXSm90SGR1VzZ6Z3FiMTN3UEVZRzlQSHdkdDBRZlFITEQrSW9UT3l6U0FL?=
 =?utf-8?B?TkJiaDRjZEJoSXNhN0dERXVkKzErUzF3YW4zVkVaQTlEWFNCamdVRDVveHVC?=
 =?utf-8?B?S0FQR0dxMUdmUnZ1SjZrV3R6REpUaWlzL0kyd1VhdmptZytraGZSeHFMOWFM?=
 =?utf-8?B?dytNNzdXMGtKRzllckhDNHRLQmI5ZDgrcXAzOTNZWDNqYXU5L1F6TXFLMFhF?=
 =?utf-8?B?TjBsdnZkb01ROUlNbG1xekdvU09iVGpLdldMOVpTWkFpUWxWT29SVlkrd05L?=
 =?utf-8?B?SnJzRDRLUHB1WU03SHZic3JTWEJnT3lTTjZWcUVzUjZQaE5YQWg2c2szNkdy?=
 =?utf-8?B?OXhsWDRXU2dvTkx0anovVUFhbXVydXp4b0Y4NDd4Njl6azlkd3Z5MlpOd2Q2?=
 =?utf-8?B?ZEJ5aHZpWUIrUGNTT1pCb1JwUnhHZnBTMkc1bld0UGlabG1CMkhzVGVzZUxQ?=
 =?utf-8?B?UDAxMHFTRUNzaXIxckR6OG1mMVplYnA2eXkzdHI3bFJxa05mYkRhcWtoNTlV?=
 =?utf-8?B?bUh4MkQxM3FLS3hCRlJOajkwdnhFQ1lZMEpSMDNrUWlPbEQvVmY1NnlhUkxK?=
 =?utf-8?B?dkoxZ3AvWmttWEI3S2c2bDFZRnllaUkvaEpDZTMzc0lzU0EzckdYcTVFL2hp?=
 =?utf-8?B?VlhBUm00Wmxkdmt5bklDT3h2MXJPdzlKalFKMU9QUnBkZkRhSlljZW9PaU9z?=
 =?utf-8?B?enNPL0dIR0hOWWgwaDR2eTYxWEJPekx6Y2V3Nkk3Q3RyUnZHVWNXUXF1VHlx?=
 =?utf-8?B?bVZYUDIyNlhrdGxoNFZVTjdyRzhSck02MmEybEw3YWlZVVc5bmZJSHlCR05I?=
 =?utf-8?B?cCtaU1NhWGptMTludTNZUHA3NkpGNEZQbVg4V0lMUHpWTDMxTjJ6RjZmTVJj?=
 =?utf-8?Q?EYQYt8EutlPT3hnkkmpwN9n/9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557de305-f93f-424e-0c9b-08da85d8e705
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 13:59:46.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laUzecwno7AHgBsL9KII5YE9eWTNCQhQNhwN88Gkg2bDspMTe0UgdWNV5eW8aGbFZqBn5czwoPAikj84/l8olA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7232
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2022 19:30, Rustam Subkhankulov wrote:
> Version: 6.0-rc1
> 
> Description: 
> 
> In function 'privcmd_ioctl_dm_op' (drivers/xen/privcmd.c: 615)return
> value of 'kcalloc' with GFP_KERNEL flag is assigned to "pages"
> variable. GFP_KERNEL flag does not guarantee, that the return value
> will not be NULL. In that case, there is a jump to the "out" label. 

The problem is wider than that, because earlier errors would also
lead to "out" (e.g. after copy_from_user() failed). Plus I guess
unlock_pages() shouldn't be called at all (or with its 2nd arg set
to zero) before lock_pages() was actually called. But I agree with
the further analysis below. Would you mind sending a patch?

Jan

> ---------------------------------------------------------------------
> 667	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> 668	if (!pages) {
> 669		rc = -ENOMEM;
> 670		goto out;
> 671	}
> ---------------------------------------------------------------------
> 
> Variable 'pages' is passed to function 'unpin_user_pages_dirty_lock' as
> 1st parameter at [drivers/xen/privcmd.c: 695].
> 
> ---------------------------------------------------------------------
> 694	out:
> 695		unlock_pages(pages, nr_pages);
> ---------------------------------------------------------------------
> 
> Then, variable 'pages' is passed to function
> 'unpin_user_pages_dirty_lock' as 1st parameter at
> [drivers/xen/privcmd.c: 612].
> 
> ---------------------------------------------------------------------
> 610	static void unlock_pages(struct page *pages[], unsigned int
> nr_pages)
> 611	{
> 612		unpin_user_pages_dirty_lock(pages, nr_pages, true);
> 613	}
> ---------------------------------------------------------------------
> 
> 'pages' and 'npages' are passed as parameters to function
> 'sanity_check_pinned_pages' at [mm/gup.c: 311].
> 
> ---------------------------------------------------------------------
> 299	void unpin_user_pages_dirty_lock(struct page **pages, unsigned
> long npages,
> 300					 bool make_dirty)
> 301	{
> 302		unsigned long i;
> 303     struct folio *folio;
> 304     unsigned int nr;
> 305		
> 306		if (!make_dirty) {
> 307			unpin_user_pages(pages, npages);
> 308			return;
> 309		}
> 310
> 311		sanity_check_pinned_pages(pages, npages);
> ---------------------------------------------------------------------
> 
> In function 'sanity_check_pinned_pages', if
> (IS_ENABLED(CONFIG_DEBUG_VM)) and (npages > 0), NULL pointer 'pages' is
> dereferenced at [mm/gup.c: 51].
> 
> ---------------------------------------------------------------------
> 32	static inline void sanity_check_pinned_pages(struct page
> **pages,
> 33						     unsigned long
> npages)
> 34	{
> 35		if (!IS_ENABLED(CONFIG_DEBUG_VM))
> 36			return;
> ..
> 50		for (; npages; npages--, pages++) {
> 51			struct page *page = *pages;
> 								^^^^^^
> ^
> ---------------------------------------------------------------------
> 
> Else if (!IS_ENABLED(CONFIG_DEBUG_VM)) and (npages > 0) function
> 'gup_folio_next' is called with 'pages' and 'npages' as parameters at
> [mm/gup.c: 311].
> 
> ---------------------------------------------------------------------
> 312		for (i = 0; i < npages; i += nr) {
> 313			folio = gup_folio_next(pages, npages, i, &nr);
> ---------------------------------------------------------------------
> 
> In function 'gup_folio_next' NULL pointer 'list' is dereferenced at
> [mm/gup.c: 263].
> 
> ---------------------------------------------------------------------
> 262	static inline struct folio *gup_folio_next(struct page **list,
> 263			unsigned long npages, unsigned long i,
> unsigned int *ntails)
> 264	{
> 265		struct folio *folio = page_folio(list[i]);
> 								
> 		^^^^^^^^^
> ---------------------------------------------------------------------
> 
> 

