Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006284ACC0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiBGWa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBGWa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:30:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F453C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:30:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AED8521102;
        Mon,  7 Feb 2022 22:30:55 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27E6E13C72;
        Mon,  7 Feb 2022 22:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NJGDNp2dAWK3CgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 07 Feb 2022 22:30:53 +0000
Date:   Mon, 7 Feb 2022 14:23:48 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>
Subject: [PATCH] md/raid5: silence sparse warnings wrt struct raid5_percpu
Message-ID: <20220207222348.wbokxgsdvmxhbidd@offworld>
References: <202202072158.7y7wxNRC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202202072158.7y7wxNRC-lkp@intel.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move out the nested declaration of the percpu bits of struct r5conf and
silence sparse complaining about address spaces:

drivers/md/raid5.c:7070:9: sparse: sparse: cast removes address space '__percpu' of expression
drivers/md/raid5.c:7070:9: warning: incorrect type in argument 1 (different address spaces)
drivers/md/raid5.c:7070:9:    expected struct lockdep_map *lock
drivers/md/raid5.c:7070:9:    got struct lockdep_map [noderef] __percpu *
drivers/md/raid5.c:7070:9: warning: incorrect type in argument 1 (different address spaces)
drivers/md/raid5.c:7070:9:    expected struct local_lock_t [usertype] *l
drivers/md/raid5.c:7070:9:    got struct local_lock_t [noderef] __percpu *

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
  drivers/md/raid5.h | 22 ++++++++++++----------
  1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 9e8486a9e445..125b925e2b0c 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -560,6 +560,17 @@ struct r5pending_data {
	struct bio_list bios;
  };

+/* per cpu variables */
+struct raid5_percpu {
+	struct page	*spare_page; /* Used when checking P/Q in raid6 */
+	void		*scribble;  /* space for constructing buffer
+				     * lists and performing address
+				     * conversions
+				     */
+	int             scribble_obj_size;
+	local_lock_t    lock;
+};
+
  struct r5conf {
	struct hlist_head	*stripe_hashtbl;
	/* only protect corresponding hash list and inactive_list */
@@ -634,16 +645,7 @@ struct r5conf {
					    * Cleared when a sync completes.
					    */
	int			recovery_disabled;
-	/* per cpu variables */
-	struct raid5_percpu {
-		struct page	*spare_page; /* Used when checking P/Q in raid6 */
-		void		*scribble;  /* space for constructing buffer
-					     * lists and performing address
-					     * conversions
-					     */
-		int             scribble_obj_size;
-		local_lock_t    lock;
-	} __percpu *percpu;
+	struct raid5_percpu __percpu *percpu;
	int scribble_disks;
	int scribble_sectors;
	struct hlist_node node;
--
2.35.1
