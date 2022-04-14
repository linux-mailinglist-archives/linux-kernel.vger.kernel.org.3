Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6B1500497
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbiDNDUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDNDUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:20:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84DA3AA7B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhbQFO+xiwnMcMxbX5F2a0chmYUcTjHRP8r0r9OoAK8mzYIlWA9DPvBNk2S5xvJgj378o+oPnz7HoVJM73rFWN+Unu/Q4KMFylgESVkWot7N4H88h6LV9Ni57y+LKOAH6dRLPVpzJaTLHK7exF32OCRSHo9T9rfwzCaGjsCCn4Xl7hgHvF0MF9lXYES3xfKaVCxUp/8Hio1HDtX3v4ErzqNTmDu7OCosyXCo3GS5o/O4vUrQ/EHvvOEV72kNnJ1GOzhQe5iV6gj9j3L/+Q0e0mS05/oq35ejpJA1eo0O0ma+m50q4GtSYeRTl6h/el6nWjT+ejCItiNgjAvaclKvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykyLcbCpUmTRazmxshBm2wVohiYaxcQog2jO/6aM0sQ=;
 b=N3zpEJlth/8c+CWcQGnyqKuWt9Rp1s6icoMAlEv+Gdx8yb2vfeq0woTceVKMp1O6329K27JnJf04PWnGJzCTc8vLqRGsTK+z9uh6qB1P9+dXtTZwIdkfkjvc4HGW0FLJlQQU0d+zafo6f3BGt7Ely5QgA0IgwfMCghe8nrCETSRfbAEotOJHypgWrlKXciv0e7qDHlEMeAbSoZbRqB4sye8R8/EqS5xu0P3EE3en+qkCaamizbvFYprhRWj/eVN/W6TmEgzUaXKEXFt6JHW5U1qRcVloWzqUbJjVIz5KWrS1i7JqOKu5Rr7Msm02zAWFdKJMvTUCSYD9agQ6IIejrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykyLcbCpUmTRazmxshBm2wVohiYaxcQog2jO/6aM0sQ=;
 b=soyxPMpOMNrKmJG35LJkm/tKOYMDYCoyEmJNt0etxZ75/v/cBWDQW0Gd+jDnBQpSO97nmh6ZWe3LTHWjHr5GJ6terxo+gmyuPzjRmVq03FOp2T+C6MNs0dkPJ8qnOJWT8XmypHV479q6AMg/I4PyUpnfwSbLin/+Fn+9f7Xq6L7Sp9y+kW21FsBK8IqRC+JpVj7HfRn10EOsBt5WTfld4vK+Yy4Y0X373rcp6fCpsjihI9X5854hseg19gntUsG/uP9PMmOEiStalcP+iwPACjzX/zDpntMC46WD/g2Kx5Wv/f3GZCfRawbOcEQvbegjp1cPdaGd34QkR1jXA6/9cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 03:18:20 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 03:18:20 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, jhubbard@nvidia.com, jgg@ziepe.ca,
        rcampbell@nvidia.com, Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm/mmu_notifier.c: Fix race in mmu_interval_notifier_remove()
Date:   Thu, 14 Apr 2022 13:18:10 +1000
Message-Id: <20220414031810.1787209-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc7bb581-3069-4ca5-c8ca-08da1dc56d00
X-MS-TrafficTypeDiagnostic: BY5PR12MB4902:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4902E74CAFB30839AFD0981FDFEF9@BY5PR12MB4902.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8O+SL+N2AFLf+R2wxcCjIcdp7Tzb4KTuqs0UdAL4S9K6tX+WdWHApxFpzq2jOfmCsubQetQuJShmDxXXUsZeoVrJxVnogJXjY+/bRqzJJQ8RMpESq2Lc/cJUBjnM2ZyWci2Qm2nuscW/NSlSoKEHw6GZq5FG4HPHs5RkrGS5VjAbxjmJ4+UZ+488RpJnr5WTxVMz57f1km4i8FLSR58KRbJUjOfHe1nZFU7xx2TUOR3bqOVQn17k/ffiH8LnswZ+R7XFnpUJO6CJRi/t3k+LZ1dzsJPwXGjSu9Y6sHd/kBcQcOKoTcoQz0zioFLQ8rzQDHdAAWnUbRekNuFVy03MMwmRMyFx7oRenlQs20aTsuKpNH6wpKgSf5Rd20Zmw3dgcrgblfR/x2VmIGYe3LRCE/i9sOeLdVHKq+tAbz4H0pru3TbAcGzYwGkdWnwS6BZUkkgtxl9h+c14fZeoI/bxIxKwlcvzQQ6Mp8/5Fv9tv+pORl6IeSGOpX/V4uTIBX03hyRanVpvEjAtuHtsAPOiEQ/f/NTKg0LlV5fTwpgreudl/v17ihrxsRcSaf9E7y0o24+Ei0H0dV1eEop937tOm1VhjQHzhQu/bqmlYuxwKp01h3S3UOoCEqtClH0motNiUG9f86eWpKB84OZp+Xc1KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(508600001)(5660300002)(107886003)(6512007)(316002)(8936002)(2906002)(1076003)(38100700002)(36756003)(66946007)(6916009)(6506007)(2616005)(26005)(186003)(66476007)(4326008)(83380400001)(86362001)(8676002)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F2yk78zA9bhAntaS1d5tFrG61KoiEt/KhSoz8Xb1H2GNo4qbC3SyHJpbOEIp?=
 =?us-ascii?Q?M7ynxsG7rHFW1WyZfV6Y7/AKMNbhcKQf4tJ67KcHRcYVQeNb5JYUr+uk3+cL?=
 =?us-ascii?Q?1wrXXy4jPJMMeBJ5qkh1Wwe71MX71d3uEJKtmPtwkoAv9lfOBBWbyg6yOSO5?=
 =?us-ascii?Q?vtRyv3TzaQvOj5QObroCSr61SMaRGqYXkq5chChFEzX+6guja8TSot4TB6xc?=
 =?us-ascii?Q?g+kNv8zyDTnF0GqdyyGPE36qmenpuGrsdmfDiU8C/s+5NAgEo2ji6hOpNdD9?=
 =?us-ascii?Q?8X080JQxzY5ClZ/hOSnCx3IeAdLl5p4qUX62On6HPVrT2K8vCxfcYfQz+bg0?=
 =?us-ascii?Q?7VRXhmF3e7gq0gcV5lA7uDgJoqMGv+wpJUVhVpJrxT697HDmZ6y31Dlou5jH?=
 =?us-ascii?Q?SbOXblMr2uUIrQWmupMTB9ZyA217mVu5kG954vPn5N44sThtl/8P1wYqIXlQ?=
 =?us-ascii?Q?zByqb2j5N2BVy1eTAivngZ4XjvRSOykvG9OTTnYjLnqKPCqYAGbx+w4D5oec?=
 =?us-ascii?Q?QzlRv77nNki7vhoHNPpApmE1gx21rIs5aCvPwyA7Z2dRIbgY2xuNRIm+cK/u?=
 =?us-ascii?Q?3xSWUoOqsdihgyVd8d4zK2FzMc4Wa8U6C+rRV8Di4dXZPSZj7BFRtt/Lvkb4?=
 =?us-ascii?Q?dILEO6JzQ+vJb54gKuKX8CaferNtT0dGEbM1WFGp540RgxEiMftJo1OFFp1q?=
 =?us-ascii?Q?Lk0Osa7LSz5n1dAGdO0EgavVogcrIyV5WWkdnWMHidm199v9u9mBH074TjO1?=
 =?us-ascii?Q?xoKEbpCEiOV4doRPHT9D0EjulFqmChTzuTFPW7Ag1dKWx24hWqlqf0BO9C56?=
 =?us-ascii?Q?7rvLnrsRJEvIGactvjXmtauw+tp80WFz3TnwruYFPt1oUCxmI0xJSL97FfOd?=
 =?us-ascii?Q?AcGaYOfB1yKVb2ZccWX6gcv5cYx43oskSq/nrl37QE4SY5sHmSSHiJKj+p/s?=
 =?us-ascii?Q?QYulGW3qvTFVUOAMHpYpFn6Qp09YVwZg6unjmlvsBeTYACUDqfggcAFGV6yl?=
 =?us-ascii?Q?vGyolM1vtdgAJ/mWOgGWGfSHvbykd7kxjA9DC60BkV6XsHkOVEDcgnlCZWGL?=
 =?us-ascii?Q?Ha3vcTRiJ66aLX6mWKebRP6/3Bq6FmK+9RoGgI7MSMG59NkDqLYTavrnSagJ?=
 =?us-ascii?Q?Ly8qC6s5z2bru822xc67OEW0rkXolxQSdIYbBGjKdPJq06VDsIx/Ojd95yoT?=
 =?us-ascii?Q?nR6dDMmszMR6LzirWnDkNhGdG2TFfrZNJ5Xk3n+w5fI3hmBdbIg55THU9WhF?=
 =?us-ascii?Q?OJetq/GGBiGHZH1reRR6XUKpZYlitByHRPjWuyjGx5f5gzRP2aEdNUAQbct0?=
 =?us-ascii?Q?JzdZv37DW0B8ZZoga/4aO7pjZKyROLnTmAO4rEvri0E2Zr/5DinOYalvriEr?=
 =?us-ascii?Q?J305C1/Wfo04k4FxRkTEhriiuHUCGNvUEDiSLFCNUFmyN04L86TjcsFkgMLF?=
 =?us-ascii?Q?GAqVuVs3TkopVkLlwizTUOeADVfINgY5QAyekjU6NX1bvQtSbVQ3MCkf+J3+?=
 =?us-ascii?Q?s0d0kR/M9pDaLSyIIt15mESzU4Ur0inwWo+8xVOEYyh9tcbz67F1odrqS9VM?=
 =?us-ascii?Q?JWk+a8UdcJJmRW+Hwj3GfJbCIhiZwHZvsvHV/IYjWXqPg5lCUYb6Kan2nBBB?=
 =?us-ascii?Q?sufDlBplkUjfI2ucbh+kMLf2+V57RnzKm23x48lAyWu9JH6OB2lyyDnUUKCn?=
 =?us-ascii?Q?DMbEMRTveCyKCtnE7pDhVRj+iQJRAI5teuaKj6LOcn26z4/o3TimDHr6AtS/?=
 =?us-ascii?Q?2thmz+U2mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7bb581-3069-4ca5-c8ca-08da1dc56d00
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 03:18:20.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssWUPu3wEAozm5cjyvDyrYvaApQVWJsEBA+nfbRfkm/JfEs4elsy+8stvSkf+TWApZKAxD2AmHx4ZUMDpjUcOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases it is possible for mmu_interval_notifier_remove() to race
with mn_tree_inv_end() allowing it to return while the notifier data
structure is still in use. Consider the following sequence:

CPU0 - mn_tree_inv_end()            CPU1 - mmu_interval_notifier_remove()
----------------------------------- ------------------------------------
                                    spin_lock(subscriptions->lock);
                                    seq = subscriptions->invalidate_seq;
spin_lock(subscriptions->lock);     spin_unlock(subscriptions->lock);
subscriptions->invalidate_seq++;
                                    wait_event(invalidate_seq != seq);
                                    return;
interval_tree_remove(interval_sub); kfree(interval_sub);
spin_unlock(subscriptions->lock);
wake_up_all();

As the wait_event() condition is true it will return immediately. This
can lead to use-after-free type errors if the caller frees the data
structure containing the interval notifier subscription while it is
still on a deferred list. Fix this by changing invalidate_seq to an
atomic type as it is read outside of the lock and moving the increment
until after deferred lists have been updated.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
---
 mm/mmu_notifier.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 3f3bbcd298c6..41eb5c2e09f4 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -40,7 +40,7 @@ struct mmu_notifier_subscriptions {
 	bool has_itree;
 	/* to serialize the list modifications and hlist_unhashed */
 	spinlock_t lock;
-	unsigned long invalidate_seq;
+	atomic_long_t invalidate_seq;
 	unsigned long active_invalidate_ranges;
 	struct rb_root_cached itree;
 	wait_queue_head_t wq;
@@ -87,7 +87,7 @@ static bool
 mn_itree_is_invalidating(struct mmu_notifier_subscriptions *subscriptions)
 {
 	lockdep_assert_held(&subscriptions->lock);
-	return subscriptions->invalidate_seq & 1;
+	return atomic_long_read(&subscriptions->invalidate_seq) & 1;
 }
 
 static struct mmu_interval_notifier *
@@ -103,12 +103,12 @@ mn_itree_inv_start_range(struct mmu_notifier_subscriptions *subscriptions,
 	node = interval_tree_iter_first(&subscriptions->itree, range->start,
 					range->end - 1);
 	if (node) {
-		subscriptions->invalidate_seq |= 1;
+		atomic_long_or(1, &subscriptions->invalidate_seq);
 		res = container_of(node, struct mmu_interval_notifier,
 				   interval_tree);
 	}
 
-	*seq = subscriptions->invalidate_seq;
+	*seq = atomic_long_read(&subscriptions->invalidate_seq);
 	spin_unlock(&subscriptions->lock);
 	return res;
 }
@@ -138,9 +138,6 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 		return;
 	}
 
-	/* Make invalidate_seq even */
-	subscriptions->invalidate_seq++;
-
 	/*
 	 * The inv_end incorporates a deferred mechanism like rtnl_unlock().
 	 * Adds and removes are queued until the final inv_end happens then
@@ -158,6 +155,13 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 					     &subscriptions->itree);
 		hlist_del(&interval_sub->deferred_item);
 	}
+
+	/* Pairs with the atomic_long_read in mmu_interval_notifier_remove(). */
+	smp_mb__before_atomic();
+
+	/* Make invalidate_seq even */
+	atomic_long_inc(&subscriptions->invalidate_seq);
+
 	spin_unlock(&subscriptions->lock);
 
 	wake_up_all(&subscriptions->wq);
@@ -232,7 +236,7 @@ mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub)
 	spin_lock(&subscriptions->lock);
 	/* Pairs with the WRITE_ONCE in mmu_interval_set_seq() */
 	seq = READ_ONCE(interval_sub->invalidate_seq);
-	is_invalidating = seq == subscriptions->invalidate_seq;
+	is_invalidating = seq == atomic_long_read(&subscriptions->invalidate_seq);
 	spin_unlock(&subscriptions->lock);
 
 	/*
@@ -246,7 +250,7 @@ mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub)
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 	if (is_invalidating)
 		wait_event(subscriptions->wq,
-			   READ_ONCE(subscriptions->invalidate_seq) != seq);
+			   atomic_long_read(&subscriptions->invalidate_seq) != seq);
 
 	/*
 	 * Notice that mmu_interval_read_retry() can already be true at this
@@ -648,7 +652,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 
 		INIT_HLIST_HEAD(&subscriptions->list);
 		spin_lock_init(&subscriptions->lock);
-		subscriptions->invalidate_seq = 2;
+		atomic_long_set(&subscriptions->invalidate_seq, 2);
 		subscriptions->itree = RB_ROOT_CACHED;
 		init_waitqueue_head(&subscriptions->wq);
 		INIT_HLIST_HEAD(&subscriptions->deferred_list);
@@ -954,11 +958,11 @@ static int __mmu_interval_notifier_insert(
 			hlist_add_head(&interval_sub->deferred_item,
 				       &subscriptions->deferred_list);
 		else {
-			subscriptions->invalidate_seq |= 1;
+			atomic_long_or(1, &subscriptions->invalidate_seq);
 			interval_tree_insert(&interval_sub->interval_tree,
 					     &subscriptions->itree);
 		}
-		interval_sub->invalidate_seq = subscriptions->invalidate_seq;
+		interval_sub->invalidate_seq = atomic_long_read(&subscriptions->invalidate_seq);
 	} else {
 		WARN_ON(mn_itree_is_invalidating(subscriptions));
 		/*
@@ -968,7 +972,7 @@ static int __mmu_interval_notifier_insert(
 		 * soon.
 		 */
 		interval_sub->invalidate_seq =
-			subscriptions->invalidate_seq - 1;
+			atomic_long_read(&subscriptions->invalidate_seq) - 1;
 		interval_tree_insert(&interval_sub->interval_tree,
 				     &subscriptions->itree);
 	}
@@ -1066,7 +1070,7 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
 		} else {
 			hlist_add_head(&interval_sub->deferred_item,
 				       &subscriptions->deferred_list);
-			seq = subscriptions->invalidate_seq;
+			seq = atomic_long_read(&subscriptions->invalidate_seq);
 		}
 	} else {
 		if (WARN_ON(RB_EMPTY_NODE(&interval_sub->interval_tree.rb))) {
@@ -1086,7 +1090,7 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 	if (seq)
 		wait_event(subscriptions->wq,
-			   READ_ONCE(subscriptions->invalidate_seq) != seq);
+			   atomic_long_read(&subscriptions->invalidate_seq) != seq);
 
 	/* pairs with mmgrab in mmu_interval_notifier_insert() */
 	mmdrop(mm);
-- 
2.34.1

