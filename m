Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBAC4B3E06
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiBMWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:32:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiBMWcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:32:06 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA675468F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 14:31:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq+dZ3EJRyYSfO/VYfX4uHUhNU6uX9lfBzw88FpdFoJIzUIr/JogU5BkpGY0Hb14QURCBvHEG7pNW4iXHGQc1vsqZoL279Cmdb70H1FAzishtJXXbEsyA2zUe1eMrBPqEnShFfT5kzKJmmPG59P9a5Hueyw3zH1OJk+RkTJQ+r0Q2CsSqKR1tnILZHMxnLoP5n02FLzEsqbyKSApgLBcgcZZTWvKb3lRSG3eactrtezUJ7XVW4il7ensVtUmahyj4uCaFZvgv+cgybr4N9jdndajq8Kmds/ok40nnsfceNH+Yc9zjVIQsx0Fkw1+PyxA1XPWTd0IY0k0XDMDeeoHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyYAmV4EsIjanB8pRznb8Z7AreYPT9U+HB/dfTDjG84=;
 b=AN8y83rqpcsLsyaqlQG50K+8zH02kSzx53DIyKZ8iPI/9kFhGjeeL3AbTHrmyZuJ/23QqQgqIxZugWb0wTtUK50XZG4KxlHvChAO7aI9NN6vgNEJy6Fpr4a6PZIUkaO6uE8ka3uO7tOWIilDyefe7R9720xnrTvgnTH4vAn0FlBApRV/HBPRwEbcBjh8gFT/bMYIV4i2CDzewNxhC8qWc9E1jaOY5DPcyyGEVFW5yse1e/8iaviEOfk1w//FvKvlUoACv3/xZ9ts5ngqgB1qxDuT2TisFChkg0B9MzxKFFqgE3RHNGJHJu4ceXHstLx1O88OVHQz3QDpsUUQoq0Z7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyYAmV4EsIjanB8pRznb8Z7AreYPT9U+HB/dfTDjG84=;
 b=OlimQKSpWEhd3wolm35vtOmGZohoG6vUAQsoay2kgJAWnL7UTbxTM+NWFfvNYUCu3AeGZuUmJ0p6bGREOs61vbYSMEUVck513Xckk9PcErUEZcZX1qWwjw0nDcGeKC0Cmni6cuZCKInSRSohp2BJy9y0+U+3WdGL2h77t5cLilZTP5mey1GN5xZfPnfdAlsSo6iYkbEKhJiZb31IDTAPZ88pdQJssvGdc9mpaYRSak9NZFZALifcqi9OaC1CGyKxfs+2Eubkeo5kRQrfsflczwXPHR7X0S78oX8Eu42dBTa4i5lCE+UmbGYW+Sqlfr/ZnQV8KFJx1BawZ4idJnQqpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Sun, 13 Feb
 2022 22:31:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%5]) with mapi id 15.20.4975.014; Sun, 13 Feb 2022
 22:31:56 +0000
Message-ID: <c0e7873a-ed48-1913-654d-f9cc93bc095c@nvidia.com>
Date:   Sun, 13 Feb 2022 14:31:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 00/75] MM folio patches for 5.18
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <20220204195852.1751729-1-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f1e465d-d908-4334-9bfd-08d9ef40a445
X-MS-TrafficTypeDiagnostic: BN9PR12MB5034:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB50345521E169FF1AA6913F29A8329@BN9PR12MB5034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIHJ98k3AlPI1IpsT33wamuCBSEFUYYQC76uYgN45sqL7U2zbMYY1xHZ862cORJm6+naeSI09HLTlzPcB4sgRkTvvDKnzZgLN9rF6rAHSEHa8mTDKqvTHJhjD8UCd2gFWWYwEQKKIUouCyOgrnhlHUD/0PRcf5Lrje3eLA5P2IiA6QuMrB4VCnnngvRt0/Ro+A+yFTk5J0VpLDI+GX3jSMfHPqoc/vdpsMl6mSAaRydfjtG8t6oWjqrBpDSGTeHM8fr3B4bSwNVV8m5KqKYd/QilTucCPXsq5csmGuK/6DhwCyOGovS61jnkuiEE0Rso8VM4cGKhgF0wS3gffDTC/Lt9CMa1GKbtQMxEn3lP46UndjZR0keTiuSE9JTkdxl6Qsh4NzEVxzqy3x/7M+qVA7+H3+yscbvyFnYf4gS0GVjtDkNLjXftWHJ/UfGXAvZP22G1fyylTegOBkZgky31USeqqYmRs4jLa6RgDhTy13KzMpgS9j0PtMw/xkj68jC2tu2Sw+Efkit/NrYpo4lrgyt2LrjhsNJJHG/+hoN7Xv5ZaCwYnZz8uPhHMqgj5mGoY2VcIrtM6GaemJ2MxPKKWUA8eonTT8dztUx12kMZHR70EWtpHC6iuHLyR7/u2f/7DuQdDMVzaFwGPIyBE4CUUrxXtUoEyXosYbsvINBFIK1sCCp9V6bVurko+UVYex7dlf8dG5hGfXWQjwHV5tc4FfqEH7l1de391aIrYkBmkEhr+7pvYyF8HVX1RZz4q/zUnXotkLsfEZgTQkcD/3NSJ4GsctLcPdG6oEh4ZtAM+mrBzeg0RP0T6OZ94w1eEu47VdF7Eh8k7PbQt5I0VjTzgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(31696002)(86362001)(6486002)(53546011)(2616005)(966005)(316002)(31686004)(36756003)(6512007)(8676002)(66556008)(66476007)(66946007)(6506007)(2906002)(38100700002)(83380400001)(8936002)(508600001)(26005)(186003)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFF6cVlDNTEzNS9uaHBXbEJNbUJnSUgvUmlzZEx3UFU2bklMSFdLOGh4cExZ?=
 =?utf-8?B?Z0UrZThoQ3gwaVN6cW5sMmlTNnIxVGtHN3lIb0tPdDZJZXhFR2EwQWd3ZDdX?=
 =?utf-8?B?SVpNUzNxdjE4c3VLZ0pMY01tYW1xZUdXa01wdXcwb0hnSkorVmpMTmQzTWVt?=
 =?utf-8?B?TFlVcDNaZk9yU3d4R0hDdHduNFRjSlloWDlYWm9rMzJuZWlpL2VvWDNyeXFB?=
 =?utf-8?B?Q1J4emx0ZXBaL3JoY2haZ0ZBWVYxU0hiWmdFeEZUbDlzZ0lYNng1ODFKYXZN?=
 =?utf-8?B?Q0tkQjdmK3did2hXbWU2L0JkS0t6clpqcUl1M2FvNmt0bm1DM3NBRmdyM0tu?=
 =?utf-8?B?Wmh4Qlowc3FaTFlpaFZxbXdGUmNNS0ljLzNPZ3ZZZTYxUnV3RlVDbkNTZ09v?=
 =?utf-8?B?SVlYNHdqSzhHVGZIY3JEbWF4SlJtdHlKNFh3WWYySWZYTGV0am5OYVFmQ0Z5?=
 =?utf-8?B?eHBraFhlS3I2SGJkaVp2eHdqVzVURWJndDFJUC9xY3NyMVZJOW5Ya1NKSStR?=
 =?utf-8?B?ZzAyN1JEankycnJqMDBKdDhHRS80LzUyY2JQNzYrblh5YWdrTXpucjJPZFc4?=
 =?utf-8?B?WmpaTFNSVEI1TlBwSExWRVFOak9qOEF0empmSmF1aVVEWW9GTGRQWGN2aFc2?=
 =?utf-8?B?UHZJeHJ6UWEwUG1UUndLazZWaXpORWN2blUxaDJwRkZYSjQwYmovSFBybVRj?=
 =?utf-8?B?dmtPNi9NWGlBbzhocFJRa1RYOUNXeXhzMXJQZlZzUUpudjB1czZiL2JRcUdY?=
 =?utf-8?B?TXRqVE9aS1ZyZUVwT3Q0UGJQWjZtQkdrZ2ttQ2ZVUzVtQkFYTnRicGp6VEV2?=
 =?utf-8?B?aW56VkN0bGJ0Unp5dzNmUldhN0c5SVJRZGYyRnFRTE1QdnRPTVoyYmdYSVFC?=
 =?utf-8?B?bE1uaGF1STZUa1NXWnMzUFBHL3NML0ZHRzA0MXJ3aDk2b3ZGVUZ5OHNTSy9K?=
 =?utf-8?B?aDI3cUEzR3NwcFhSd1BGdzJ1a3RhQUZranVPYUtQV0FCV0JPRndWT3dON0Rk?=
 =?utf-8?B?c2NVcm9EcTRTZzFqZ0RZTDVKUk5XMlBURTN0Y0oxeGtrdXgrMnBmaWZ5aHpy?=
 =?utf-8?B?b1pHbUM3Y2VSL2Z1NTVCcFdjVzBhQUxqa1pWTUFNRWxDckJGcFFWeG9VdnJi?=
 =?utf-8?B?d3JLUVcxNnVPeGZQSUpIQmVxZ3lGWW9SbVBDUHZKbjUyN2RWcHpDcS9yOThw?=
 =?utf-8?B?WHRuditGUTcvRlhONjFYbkFuK2JEQW1nb25mZXZaVnZrSzlvcHZnK0swcFdP?=
 =?utf-8?B?VmtQcnFvL2R6clJzck9WQzRQMXkydzQ4enJCdTZBdjBVdlozbDNOdCtKeGZw?=
 =?utf-8?B?QmdqMHc1ZENsS1lJZmJmZ1RGTE9zdHcyeVVlU3h5MG1GM29sMEFQMXgwak1u?=
 =?utf-8?B?K2lNcGxsZmxKcGZKNjhnQjNQYXVJYnlWTG4zU1V0bHdPMjNCeFZtUFF4dm9a?=
 =?utf-8?B?YTdyQkxEYmxjSTVtQk5vbHNjTk9veE8xa0x4TXBFRllpbCtXQXh5L29mNXZx?=
 =?utf-8?B?ZjhmZFk4b0FQSmVUY3ZpZ1dmU2hseDdmbGtrTVc4ZXZhd0hGeHdaUWRzQ3oy?=
 =?utf-8?B?MlFXRTdvVCt6TnpVZDliS3Q1K0YvM1VnZWpZaXFPTVJyd1JmM2FRSmc5aGwx?=
 =?utf-8?B?YVdoenlwbElzcFY3YTlESCtBOHJ4ZnlRMGtUeG0vazNkVUk2U0J3a1dwNkJH?=
 =?utf-8?B?ZkxCM3lIT254bmpDeVRleXBkWUdFR0VDcG5rR1RrQjJqMk5LQUpnc242KzZD?=
 =?utf-8?B?eUVqaTYvQlNYM0Nvb3dmcS9GWk1VK1dZV0VJU1VhZmJjK1VYVVN5NC9kV2JU?=
 =?utf-8?B?NlFodUtvT05UaTBucFUvaEpwZG1VaVc1TmN5WnRtaFNPNVlnQUswTFg2K3hw?=
 =?utf-8?B?T0ZZRWhxNC9YYVhOaDFhUU83azJQVWF2VmxVRkJ6K25RUG1LdFd1WkRiYW5W?=
 =?utf-8?B?Vi80WldRUVAyMGpiRUE4c29JSXRiOGRkdDc5cUdJak5TZ2ZjcklWTEZoaDd5?=
 =?utf-8?B?bGc4UWs4dnp3aG51aDlCTHN4ODRJM3o5cUZJS3o3TVBySlNtTFF4Z1Mxc0hK?=
 =?utf-8?B?Qm80eXkyVWRjRGNwSTNKZGxPV1cwV0xUSDZDNlpidWRldEJHdU5NUnFVZGVQ?=
 =?utf-8?B?MnpHazZXZlZtQVNGQkVQVjFkMWZ1dFphNDl3ZHJyU1phTjhTMGdhZHRlb1Nq?=
 =?utf-8?Q?Okk1H9ZIV3a/Ow6s6Unxbpw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1e465d-d908-4334-9bfd-08d9ef40a445
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 22:31:56.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGLGD8ovzcGqljMw60J/AhUlnCrfEGpPrQdfrtdKsOv82wq0xIverPfppOqBVxkZirYVHxW52tB7US5MEqqffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Whole series availabke through git, and shortly in linux-next:
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
> or git://git.infradead.org/users/willy/pagecache.git for-next

Hi Matthew,

I'm having trouble finding this series linux-next, or mmotm either. Has
the plan changed, or maybe I'm just Doing It Wrong? :)

Background as to why (you can skip this part unless you're wondering):

Locally, I've based a small but critical patch on top of this series. It
introduces a new routine:

     void pin_user_page(struct page *page);

...which is a prerequisite for converting Direct IO over to use
FOLL_PIN.

For that, I am on the fence about whether to request putting the first
part of my conversion patchset into 5.18, or 5.19. Ideally, I'd like to
keep it based on your series, because otherwise there are a couple of
warts in pin_user_page() that have to be fixed up later. But on the
other hand, it would be nice to get the prerequisites in place, because
many filesystems need small changes.

Here's the diffs for "mm/gup: introduce pin_user_page()", for reference:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 73b7e4bd250b..c2bb8099a56b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1963,6 +1963,7 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
  long pin_user_pages(unsigned long start, unsigned long nr_pages,
  		    unsigned int gup_flags, struct page **pages,
  		    struct vm_area_struct **vmas);
+void pin_user_page(struct page *page);
  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
  		    struct page **pages, unsigned int gup_flags);
  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index 7150ea002002..7d57c3452192 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3014,6 +3014,40 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
  }
  EXPORT_SYMBOL(pin_user_pages);

+/**
+ * pin_user_page() - apply a FOLL_PIN reference to a page ()
+ *
+ * @page: the page to be pinned.
+ *
+ * Similar to get_user_pages(), in that the page's refcount is elevated using
+ * FOLL_PIN rules.
+ *
+ * IMPORTANT: That means that the caller must release the page via
+ * unpin_user_page().
+ *
+ */
+void pin_user_page(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
+
+	/*
+	 * Similar to try_grab_page(): be sure to *also*
+	 * increment the normal page refcount field at least once,
+	 * so that the page really is pinned.
+	 */
+	if (folio_test_large(folio)) {
+		folio_ref_add(folio, 1);
+		atomic_add(1, folio_pincount_ptr(folio));
+	} else {
+		folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+	}
+
+	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+}
+EXPORT_SYMBOL(pin_user_page);
+
  /*
   * pin_user_pages_unlocked() is the FOLL_PIN variant of
   * get_user_pages_unlocked(). Behavior is the same, except that this one sets


thanks,
-- 
John Hubbard
NVIDIA
