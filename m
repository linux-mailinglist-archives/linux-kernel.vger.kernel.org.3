Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4087558A55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiFWUrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiFWUrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:47:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1FCC5D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fzm0xUn31Pm/Wg3fgHhB0BIV4CKu3NRALLqFJvYYT+FtsHr5KlgpylilNJ00CeVTEHQHvYRZA6EXMRQmqX2MbpS5S7xcS3Dy7/1gCD9GePSyQbq71GtrG/W77sVXzEG7YmpekuyE2dD1buU1g7+AkW6lJCsAcxIYcT2rF108Y13P+qxYxVthX1KK89r+Qpp6VLOQABWqQ9GasojDZeRyfqLd+fCyZ/PO2mM1Y08qt5FpBUADuNGs/i91hMTN1Az0bVWznhk9IuJ4LfLITk5Eq6gfbBYKkXuaFR0h0kdF+1dhv5d9dBXC4BTJCO/3rHEhQSBt07dgsJfn4jHo+FBI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul+h/x1vwYbxFpQ+p6dJ3++3PM+RJZLNicPZA2HGrjY=;
 b=OrTVf5twvAncGvySiFCkgSoS3vrRjT44fjJU2zSRPy6xGJkyZLVDPB7kt4b1eWPHtBF2SbdzzdVT6F7e52zO5nsP5LTvGbrloDLF45kWF0e6Y/mvn6Lfbx1H8ebglU7I1TXmb5Pc6kkk1TwBUdU2D6Eiqk2TR6HmX2jXn925Y2/wLaZblQRTHBOXuqqeK+Y+Li/tj+TmArqePl7n9ZXIshNmAiYB5/F0/0fe2HzFsW++zkuKR9PzyoIL/zRic2oh2SOo4BVltFD3vDQJkoObhpXZWWcmKdTgu7NNVMuACuYaWWXDfU3PSxIOyPgYW/ji4Oz7MeirEJi4Cwh75q91xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul+h/x1vwYbxFpQ+p6dJ3++3PM+RJZLNicPZA2HGrjY=;
 b=A/poxKU1drxBPC7Xg6l4Now4r8uNfRTFpUJk3e2+2G29SobIE325x0SQrjc5/sPgvjGnS547crbl8CFLmqkG2nonciLj4sHDEygkofdHKgOGVwpddSbvo180H/V6KlurmRx45w07UGnNxUWEHnsCwmfKUeFpbLeqIqn6F6BvPhwIux46XKgPTvrWCGPaATNtEeaXNDfVzDGFwpFlTS6pTHbE9PjBwCV9CaHSYZ5CrXtPANrz1nKf/b8CHQtBV/p25uflg0qJxj7k4+gx6iU2yF1dUdRu8qQJabkPWl3p5EvxhNYTeOUQjJmFRrjceWzKpcruQJAjnen4xBc/u6dxGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Thu, 23 Jun
 2022 20:47:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 20:47:13 +0000
Date:   Thu, 23 Jun 2022 17:47:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Message-ID: <20220623204712.GG4147@nvidia.com>
References: <165490039431.944052.12458624139225785964.stgit@omen>
 <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
 <20220615155659.GA7684@nvidia.com>
 <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
 <20220623142139.462a0841.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623142139.462a0841.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:208:c0::45) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c1e9d49-cbcf-4980-dd65-08da55598cfe
X-MS-TrafficTypeDiagnostic: DM4PR12MB6637:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxNjds5k6mPMWejzreZfF/SCLo6DnlcKYO5EemXpgfr9Vh7HUSLobHx/M399NL02aGyFfASusqOvSwpsuuLnM6oK+iytzvnD2hYS6X1JDUb1UQNQUz9Cx9QazsNlxxCggzHcK3x44ErvyN943/ggWqbjl+aQqhBLc/8OgzjBRISm66MewbbKyL4tVYrPlHe3t9/LGl3rl6fC8CbxyZEvL9v61bupa8Vz0A8+xHOeaI7WFDXbAn5wk0qieWxEZgpuwvWjye4IE1rjlclZfsWnGzatTeVimGco5ulwU3vvzGZYSuOkQk/tzGHOAspNhvhIDj+hDG/EyqkwTpKh+QqRsSEa0IpM4AHi/eEwy3iCdMNGrt8GG28/xPjih/gkaUG9U4cSa+NETiUWvZe1MUMJmwK023rN5GSZwdAahdQz38G5rJp1wOhKbceMDfSMeGjPcO9QZavJUQNhuHjgyUl2tfhgnit5YJmcBqJ24ZP3hGclTZhUdng6D57mTpzx398p6KLe88guwJ/+LLfOLdiKQwoEi1ZG1Sd3NKP5mUbRfi+LcbeBpy2ZhvWrmy+5kqKHFueIDoBzCFIWLKtFzOPI5B71TmY6invSQvrtnBfgFO+mpWNvuXl7atGSaRXdVR/uUbVcfZjSVO8X42ljguYnfTbEs0dilNLfEDyxL2JsSh3sp4L5yDzXVOfiiGpSA7TPEmwDQBNPzcnGSjboxjcUcL+cGl6r2DfhV2k/bvT/488+rBxlQTV9yru22xXqy1yB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(8676002)(8936002)(478600001)(6636002)(36756003)(316002)(41300700001)(2906002)(186003)(110136005)(83380400001)(38100700002)(66556008)(6512007)(66476007)(6486002)(86362001)(4326008)(33656002)(26005)(5660300002)(1076003)(66946007)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14UumVPcMZLUBCUMD3KcIUK+UM6XvUuiANBNSBIGdMLiwct0O5dkU9rEl0az?=
 =?us-ascii?Q?4jg8Zf8z6B0r+TCMRkpSwKMUAlQaBckyJfEQ+qV9/hSAqx2hSLIsQSRUolTN?=
 =?us-ascii?Q?JsrXwIGMNE3hQIPnawUWBwKmnqsjE2w8Gcp5yTkkXRX152uZzNNSBl1Sjcry?=
 =?us-ascii?Q?yKnE2MpkuPz1vL5n3XB2XACoLo0ZjFSPKbp7H38nS5SKAqR9khecoj0kLwTC?=
 =?us-ascii?Q?k8lJJ//JBM9GyAf+jQhwYE8rGI2WRzVpF8SH4Bg2d06uatKI2Q6ZojZszFK3?=
 =?us-ascii?Q?Spo+XCZJHuaobrCF8EeuqhN68BNN4bhHlJSX6Yis4vxfVM7MTc8Bggb90kz2?=
 =?us-ascii?Q?+KvrBmAs05wiPyJJififXLzx6JLU0/zBo1PGqakj0aapSwa2KxwIW54zprK7?=
 =?us-ascii?Q?/xMOiQ5XKsmrELirMwUkDoLotdwCB/m9TaHRA0O545kwXjzJ0nHpFiRigRu0?=
 =?us-ascii?Q?4JxUzJBS5skA4Ty5apdz1uekrfsDTkYw/KD5B9i9RxXD3ORUxAynPUjd3+yK?=
 =?us-ascii?Q?j5PcJDIqDRy7BdwiWVewxn6ONQIBSRKCP1hQiI4QN6hrlinn4UwgHVVKOSOH?=
 =?us-ascii?Q?sc7UgxnecQcGrqGoPjJx7lsdIr0+jJcjlb1GzSgTWBm9hDU0LyxPhqXVXsRb?=
 =?us-ascii?Q?UsZMwHTl2Cqc395g7/K+DWLwBdfGsDYiMqx/i1k8F+Ozb9/xYoj5jcVsduZ/?=
 =?us-ascii?Q?5FRzTnXRxM/Jh2WYlCQUmiPsYCX8iT32hyYOje9pnu2J97fGs9vOtaigOQ4U?=
 =?us-ascii?Q?cedbDlV81y0bs9bw9F5kIt24YWXKBYrpfEYqjCwh6zepX6nbeWUv0L9bD4Hu?=
 =?us-ascii?Q?uyhUTserrCijLsNYVPAhmowIbHvguxpxxvKUtjB7TtlYqlH2nNQlKvKp4Sjk?=
 =?us-ascii?Q?TT2szk+TjvGYBN4JesedwwT5RbopPeEu6AeEHmE4veFqexslOJ47HQK5lP0k?=
 =?us-ascii?Q?DVoqKDNNixbMPOEd54EIC7sxsZgZTwqODcdwVVG1vxeyqQuCxRnMSP1kJMqO?=
 =?us-ascii?Q?YzDQoZn+jxsbcsyh3h0XTw1PpuYzaDGmIVeWc9NSQhCsPyYd7IYG7xWG648o?=
 =?us-ascii?Q?AEf9XCbx1nfNbAkwb2Z/aT19xrSEhV41AAdi9kM98x8so6scZKKCn0bnZg0I?=
 =?us-ascii?Q?X1nOwFixXyx3GV79lh3Q83SpSvYfHWVwghx0XqdziwtgGBmbKEQvBCcuOfYv?=
 =?us-ascii?Q?BX191hBZjyiBdoWisrIJSRyXI97nkvdeHLLB2RuasThTwU4yu0H6QB90MjSY?=
 =?us-ascii?Q?7oWj2Aa9CJ/pqJMYsoRL8CwtFUywLELD8lWtSAl6/abultzpq/dxzvdRA/Dh?=
 =?us-ascii?Q?aQM+QO8ETV1Up4k7Nurt3fZEYgZwmdaXgODq1h2kGIFanAzakVL5onFDUbFX?=
 =?us-ascii?Q?BNfpvimiKZXgaVSgySvsQB90BTM5D4JyMsnpcPC/hjsgwAeu+JUJjbNwU15i?=
 =?us-ascii?Q?yMvlRLPRM6TKC+Tm9h9EgPeC2b2gltRgcyMYhUvTDmmW77RgP3MEy7Z8I88W?=
 =?us-ascii?Q?qjSMroHCUiiU6huB2JJuUKNUIVO5NBuSCYywI+m+vb8KL1GlRkA/DKPKI5PM?=
 =?us-ascii?Q?0wU8CZ3WTNp86ZE631xNTrYKeUT7SMXsqGqiV/eR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1e9d49-cbcf-4980-dd65-08da55598cfe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 20:47:13.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0D/u7oz5pQc6p28Z2waHw4WKZdrkbrQD9+UkXm0oazueLMASkx4XpjuDQ83xZ5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:21:39PM -0600, Alex Williamson wrote:

> check_and_migrate_movable_pages() perpetually returns zero.  I believe
> this is because folio_is_pinnable() previously returned true, and now
> returns false.

Indeed, it is a bug that check_and_migrate_movable_pages() returns
0 when it didn't do anything. It should return an error code.

Hum.. Alistair, maybe you should look at this as well, I'm struggling
alot to understand how it is safe to drop the reference on the page
but hold a pointer to it on the movable_page_list - sure it was
isolated - but why does that mean it won't be concurrently unmapped
and freed?

Anyhow, it looks like the problem is the tortured logic in this
function, what do you think about this:

diff --git a/mm/gup.c b/mm/gup.c
index 5512644076246d..2ffcb3f4ff4a7b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1879,10 +1879,15 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    unsigned int gup_flags)
 {
 	unsigned long isolation_error_count = 0, i;
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
+	};
 	struct folio *prev_folio = NULL;
 	LIST_HEAD(movable_page_list);
 	bool drain_allow = true;
-	int ret = 0;
+	int not_migrated;
+	int ret;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1919,16 +1924,13 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 				    folio_nr_pages(folio));
 	}
 
-	if (!list_empty(&movable_page_list) || isolation_error_count)
-		goto unpin_pages;
-
 	/*
 	 * If list is empty, and no isolation errors, means that all pages are
-	 * in the correct zone.
+	 * in the correct zone, nothing to do.
 	 */
-	return nr_pages;
+	if (list_empty(&movable_page_list) && !isolation_error_count)
+		return nr_pages;
 
-unpin_pages:
 	if (gup_flags & FOLL_PIN) {
 		unpin_user_pages(pages, nr_pages);
 	} else {
@@ -1936,20 +1938,22 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			put_page(pages[i]);
 	}
 
-	if (!list_empty(&movable_page_list)) {
-		struct migration_target_control mtc = {
-			.nid = NUMA_NO_NODE,
-			.gfp_mask = GFP_USER | __GFP_NOWARN,
-		};
+	if (isolation_error_count) {
+		ret = -EINVAL;
+		goto err_putback;
+	}
 
-		ret = migrate_pages(&movable_page_list, alloc_migration_target,
-				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_LONGTERM_PIN, NULL);
-		if (ret > 0) /* number of pages not migrated */
-			ret = -ENOMEM;
+	not_migrated = migrate_pages(&movable_page_list, alloc_migration_target,
+				     NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+				     MR_LONGTERM_PIN, NULL);
+	if (not_migrated > 0) {
+		ret = -ENOMEM;
+		goto err_putback;
 	}
+	return 0;
 
-	if (ret && !list_empty(&movable_page_list))
+err_putback:
+	if (!list_empty(&movable_page_list))
 		putback_movable_pages(&movable_page_list);
 	return ret;
 }

> If I generate an errno here, QEMU reports failing on the pc.rom memory
> region at 0xc0000.  Thanks,

Ah, a ROM region that is all zero'd makes some sense why it has gone
unnoticed as a bug.

Jason
