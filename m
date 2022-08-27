Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E333E5A3422
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 05:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiH0DMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 23:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiH0DMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 23:12:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B154E871
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 20:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0F15CE3209
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE843C433D6;
        Sat, 27 Aug 2022 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661569964;
        bh=PkNFJBIXlxGTFGa9sfOyJ1hkMvHVayd6VKip+kMlVgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xb7ZaS4wfFRvselZgPCbtJc7ZGkc9kh7V7z5fKEgK0mEl4tuyGwEvtw5/hln7N1N1
         WoClXMLvLGGnfkNgGSxciXWngZ2t6ohso2Oz3JsYDrxTNPT9y1VZNHoJxszFXZHY90
         cf9V14Vi480HkMw2AJA94lYJCNEao0xbUkALyKew=
Date:   Fri, 26 Aug 2022 20:12:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>, david@redhat.com,
        vbabka@suse.cz, pasha.tatashin@soleen.com, shakeelb@google.com,
        sieberf@amazon.com, sjpark@amazon.de, william.kucharski@oracle.com,
        willy@infradead.org, quic_pkondeti@quicinc.com, minchan@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V5] mm: fix use-after free of page_ext after race with
 memory-offline
Message-Id: <20220826201242.bbf4948e5221c883dadfc2d6@linux-foundation.org>
In-Reply-To: <Ywh5BHIpMpTjy3B6@dhcp22.suse.cz>
References: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
        <Ywh5BHIpMpTjy3B6@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 09:40:52 +0200 Michal Hocko <mhocko@suse.com> wrote:

> > Changes in V5:
> >    o Used the loop variable name as ext_put_continue -- David
> 
> If this is the only change since the last version (I didn't have much
> time to read through the whole patch) then my ack still applies.

yup.

--- a/mm/page_owner.c~mm-fix-use-after-free-of-page_ext-after-race-with-memory-offline-v5
+++ a/mm/page_owner.c
@@ -326,7 +326,7 @@ void pagetypeinfo_showmixedcount_print(s
 				continue;
 
 			if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
-				goto loop;
+				goto ext_put_continue;
 
 			page_owner = get_page_owner(page_ext);
 			page_mt = gfp_migratetype(page_owner->gfp_mask);
@@ -341,7 +341,7 @@ void pagetypeinfo_showmixedcount_print(s
 				break;
 			}
 			pfn += (1UL << page_owner->order) - 1;
-loop:
+ext_put_continue:
 			page_ext_put(page_ext);
 		}
 	}
@@ -561,14 +561,14 @@ read_page_owner(struct file *file, char
 		 * because we don't hold the zone lock.
 		 */
 		if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags))
-			goto loop;
+			goto ext_put_continue;
 
 		/*
 		 * Although we do have the info about past allocation of free
 		 * pages, it's not relevant for current memory usage.
 		 */
 		if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
-			goto loop;
+			goto ext_put_continue;
 
 		page_owner = get_page_owner(page_ext);
 
@@ -577,7 +577,7 @@ read_page_owner(struct file *file, char
 		 * would inflate the stats.
 		 */
 		if (!IS_ALIGNED(pfn, 1 << page_owner->order))
-			goto loop;
+			goto ext_put_continue;
 
 		/*
 		 * Access to page_ext->handle isn't synchronous so we should
@@ -585,7 +585,7 @@ read_page_owner(struct file *file, char
 		 */
 		handle = READ_ONCE(page_owner->handle);
 		if (!handle)
-			goto loop;
+			goto ext_put_continue;
 
 		/* Record the next PFN to read in the file offset */
 		*ppos = (pfn - min_low_pfn) + 1;
@@ -594,7 +594,7 @@ read_page_owner(struct file *file, char
 		page_ext_put(page_ext);
 		return print_page_owner(buf, count, pfn, page,
 				&page_owner_tmp, handle);
-loop:
+ext_put_continue:
 		page_ext_put(page_ext);
 	}
 
@@ -654,13 +654,13 @@ static void init_pages_in_zone(pg_data_t
 
 			/* Maybe overlapping zone */
 			if (test_bit(PAGE_EXT_OWNER, &page_ext->flags))
-				goto loop;
+				goto ext_put_continue;
 
 			/* Found early allocated page */
 			__set_page_owner_handle(page_ext, early_handle,
 						0, 0);
 			count++;
-loop:
+ext_put_continue:
 			page_ext_put(page_ext);
 		}
 		cond_resched();
_

