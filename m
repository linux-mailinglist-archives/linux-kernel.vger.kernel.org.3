Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9274DE167
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiCRSzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiCRSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:55:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB7175385;
        Fri, 18 Mar 2022 11:54:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w8so7658535pll.10;
        Fri, 18 Mar 2022 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D6riYCuwhdTjzLUe/+Yv8Hnhc0ogbOfRXcayVWMHdwc=;
        b=ektuM+rMNgOG/lWodZ3kNOCNtB2U3hB7GmAz/S/9lH41i/3tSUZArSmbTj83Okes+5
         +5coCHprWzBQqpdX1iswsaQdkMfnFUuDGjUnODHhuUjFIDjfLeSZc3dXA+o2WFrpZr50
         e6/0qLdIWibuXSR0qoivUhii99SijqqrBrUz8MMPFZQtuIDN2sOtdB4X9oW+0J+ulqlR
         sTH/vadjbcb+0ubdANw/DF2bxXjfQpJdHe9NMClcYEdwCSp+CHgyxtNHHmuWgqsLySrl
         8DwyXpylcTQA5z8lcOTPb8TYtQMVRP2Kx+5M2TaIww9h64xo3F5Q9CUReX9fTs7hj+ao
         ef6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=D6riYCuwhdTjzLUe/+Yv8Hnhc0ogbOfRXcayVWMHdwc=;
        b=DkL9bkz63p9CUTRRv209ZdJvSAHjXCSxt94NrdSjb4kz0XzcupUifCFI0IL9qAIpnI
         dsDYmMdC5liO2mdeg60TIrFR1w/s8/mLYtJKp+3aJ/Yd5V65IHqvBo/t1teprFyJMBlK
         noxSLV+r9AjYhDZDocGhugELfwpmIdK9tMOOnMc5qiP9PClWCcVHLUnqktFcaZZN9Udb
         PBbLjMP+1jLFbJ2Ej1FwhRRNrDfBMUjumYcTKn9szkQXkIrW/odfBMGGnGaTZGQ7h5mL
         J+lE4jRMvPJqGwsNygsnZiEo2DAAq7j93JtQW5HK/xiXdFY+v1SFcyS8xAuewyLczHKl
         8/AQ==
X-Gm-Message-State: AOAM533nIQeCnRSN0tllCjFmur/EzgrLDF4hJAuZcoeRqNUzGiB5tKWG
        MTD5pnJnHmHXwS0g0e0bt2M=
X-Google-Smtp-Source: ABdhPJzx3eiQkf2xqwxmWTPxGigtRphUjCEbYmI7Zbci47g8G9c4dD1igAartVjpp9vIESsUY2jKgw==
X-Received: by 2002:a17:902:e94e:b0:154:3a4:c5e8 with SMTP id b14-20020a170902e94e00b0015403a4c5e8mr878212pll.19.1647629657790;
        Fri, 18 Mar 2022 11:54:17 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:20b4:90a0:8e2e:6022])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00234c00b004fa042e822bsm10460822pfj.14.2022.03.18.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:54:17 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Mar 2022 11:54:15 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Ivan Babrou <ivan@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
Message-ID: <YjTVVxIAsnKAXjTd@google.com>
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CABWYdi1PeNbgnM4qE001+_BzHJxQcaaY9sLOK=Y7gjqfXZO0=g@mail.gmail.com>
 <YjA439FwajtHsahr@google.com>
 <YjEOiZCLBMgbw8oc@google.com>
 <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
 <CABWYdi2gOzAK60gLYKx9gSoSfJRZaAjyAWm+55gLgcSKrDrP9Q@mail.gmail.com>
 <YjTCF37cUNz9FwGi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjTCF37cUNz9FwGi@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:32:07AM -0700, Minchan Kim wrote:
> On Fri, Mar 18, 2022 at 09:30:09AM -0700, Ivan Babrou wrote:
> > On Wed, Mar 16, 2022 at 11:26 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> > > I'm making an internal build and will push it to some location to see
> > > how it behaves, but it might take a few days to get any sort of
> > > confidence in the results (unless it breaks immediately).
> > >
> > > I've also pushed my patch that disables SWP_SYNCHRONOUS_IO to a few
> > > locations yesterday to see how it fares.
> > 
> > I have some updates before the weekend. There are two experimental groups:
> > 
> > * My patch that removes the SWP_SYNCHRONOUS_IO flag. There are 704
> > machines in this group across 5 datacenters with cumulative uptime of
> > 916 days.
> > * Minchan's patch to remove swap_slot_free_notify. There are 376
> > machines in this group across 3 datacenters with cumulative uptime of
> > 240 days.
> > 
> > Our machines take a couple of hours to start swapping anything after
> > boot, and I discounted these two hours from the cumulative uptime.
> > 
> > Neither of these two groups experienced unexpected coredumps or
> > rocksdb corruptions.
> > 
> > I think at this point it's reasonable to proceed with Minchan's patch
> > (including a backport).
> 
> Let me cook the patch and then will post it.
> 
> Thanks for the testing as well as reporting, Ivan!

From 1ede54d46f0b1958bfc624f17fe709637ef8f12a Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 15 Mar 2022 14:14:23 -0700
Subject: [PATCH] mm: fix unexpected zeroed page mapping with zram swap

Two processes under CLONE_VM cloning, user process can be
corrupted by seeing zeroed page unexpectedly.

    CPU A                        CPU B

do_swap_page                do_swap_page
SWP_SYNCHRONOUS_IO path     SWP_SYNCHRONOUS_IO path
swap_readpage valid data
  swap_slot_free_notify
    delete zram entry
                            swap_readpage zeroed(invalid) data
                            pte_lock
                            map the *zero data* to userspace
                            pte_unlock
pte_lock
if (!pte_same)
  goto out_nomap;
pte_unlock
return and next refault will
read zeroed data

The swap_slot_free_notify is bogus for CLONE_VM case since it doesn't
increase the refcount of swap slot at copy_mm so it couldn't catch up
whether it's safe or not to discard data from backing device.
In the case, only the lock it could rely on to synchronize swap slot
freeing is page table lock. Thus, this patch gets rid of the
swap_slot_free_notify function. With this patch, CPU A will see
correct data.

    CPU A                        CPU B

do_swap_page                do_swap_page
SWP_SYNCHRONOUS_IO path     SWP_SYNCHRONOUS_IO path
                            swap_readpage original data
                            pte_lock
                            map the original data
                            swap_free
                              swap_range_free
                                bd_disk->fops->swap_slot_free_notify
swap_readpage read zeroed data
                            pte_unlock
pte_lock
if (!pte_same)
  goto out_nomap;
pte_unlock
return
on next refault will see mapped data by CPU B

The concern of the patch would increase memory consumption since it
could keep wasted memory with compressed form in zram as well as
uncompressed form in address space. However, most of cases of zram
uses no readahead and do_swap_page is followed by swap_free so it will
free the compressed form from in zram quickly.

Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
Cc: <stable@vger.kernel.org> # 4.14+
Reported-by: Ivan Babrou <ivan@cloudflare.com>
Tested-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/page_io.c | 54 ----------------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index b417f000b49e..89fbf3cae30f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -51,54 +51,6 @@ void end_swap_bio_write(struct bio *bio)
 	bio_put(bio);
 }
 
-static void swap_slot_free_notify(struct page *page)
-{
-	struct swap_info_struct *sis;
-	struct gendisk *disk;
-	swp_entry_t entry;
-
-	/*
-	 * There is no guarantee that the page is in swap cache - the software
-	 * suspend code (at least) uses end_swap_bio_read() against a non-
-	 * swapcache page.  So we must check PG_swapcache before proceeding with
-	 * this optimization.
-	 */
-	if (unlikely(!PageSwapCache(page)))
-		return;
-
-	sis = page_swap_info(page);
-	if (data_race(!(sis->flags & SWP_BLKDEV)))
-		return;
-
-	/*
-	 * The swap subsystem performs lazy swap slot freeing,
-	 * expecting that the page will be swapped out again.
-	 * So we can avoid an unnecessary write if the page
-	 * isn't redirtied.
-	 * This is good for real swap storage because we can
-	 * reduce unnecessary I/O and enhance wear-leveling
-	 * if an SSD is used as the as swap device.
-	 * But if in-memory swap device (eg zram) is used,
-	 * this causes a duplicated copy between uncompressed
-	 * data in VM-owned memory and compressed data in
-	 * zram-owned memory.  So let's free zram-owned memory
-	 * and make the VM-owned decompressed page *dirty*,
-	 * so the page should be swapped out somewhere again if
-	 * we again wish to reclaim it.
-	 */
-	disk = sis->bdev->bd_disk;
-	entry.val = page_private(page);
-	if (disk->fops->swap_slot_free_notify && __swap_count(entry) == 1) {
-		unsigned long offset;
-
-		offset = swp_offset(entry);
-
-		SetPageDirty(page);
-		disk->fops->swap_slot_free_notify(sis->bdev,
-				offset);
-	}
-}
-
 static void end_swap_bio_read(struct bio *bio)
 {
 	struct page *page = bio_first_page_all(bio);
@@ -114,7 +66,6 @@ static void end_swap_bio_read(struct bio *bio)
 	}
 
 	SetPageUptodate(page);
-	swap_slot_free_notify(page);
 out:
 	unlock_page(page);
 	WRITE_ONCE(bio->bi_private, NULL);
@@ -394,11 +345,6 @@ int swap_readpage(struct page *page, bool synchronous)
 	if (sis->flags & SWP_SYNCHRONOUS_IO) {
 		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
 		if (!ret) {
-			if (trylock_page(page)) {
-				swap_slot_free_notify(page);
-				unlock_page(page);
-			}
-
 			count_vm_event(PSWPIN);
 			goto out;
 		}
-- 
2.35.1.894.gb6a874cedc-goog


