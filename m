Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBDB59AEDD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbiHTPbZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 20 Aug 2022 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTPbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 11:31:22 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B867697A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 08:31:21 -0700 (PDT)
Received: from [192.168.0.105] (unknown [136.169.224.60])
        by mail.ispras.ru (Postfix) with ESMTPSA id CFF9740D403D;
        Sat, 20 Aug 2022 15:31:19 +0000 (UTC)
Message-ID: <6228a437bb9d7f677f5e97973518bcd555bc2a07.camel@ispras.ru>
Subject: [POSSIBLE BUG] Dereferencing of NULL pointer
From:   Rustam Subkhankulov <subkhankulov@ispras.ru>
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Date:   Sat, 20 Aug 2022 20:30:56 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version: 6.0-rc1

Description: 

In function 'privcmd_ioctl_dm_op' (drivers/xen/privcmd.c: 615)return
value of 'kcalloc' with GFP_KERNEL flag is assigned to "pages"
variable. GFP_KERNEL flag does not guarantee, that the return value
will not be NULL. In that case, there is a jump to the "out" label. 

---------------------------------------------------------------------
667	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
668	if (!pages) {
669		rc = -ENOMEM;
670		goto out;
671	}
---------------------------------------------------------------------

Variable 'pages' is passed to function 'unpin_user_pages_dirty_lock' as
1st parameter at [drivers/xen/privcmd.c: 695].

---------------------------------------------------------------------
694	out:
695		unlock_pages(pages, nr_pages);
---------------------------------------------------------------------

Then, variable 'pages' is passed to function
'unpin_user_pages_dirty_lock' as 1st parameter at
[drivers/xen/privcmd.c: 612].

---------------------------------------------------------------------
610	static void unlock_pages(struct page *pages[], unsigned int
nr_pages)
611	{
612		unpin_user_pages_dirty_lock(pages, nr_pages, true);
613	}
---------------------------------------------------------------------

'pages' and 'npages' are passed as parameters to function
'sanity_check_pinned_pages' at [mm/gup.c: 311].

---------------------------------------------------------------------
299	void unpin_user_pages_dirty_lock(struct page **pages, unsigned
long npages,
300					 bool make_dirty)
301	{
302		unsigned long i;
303     struct folio *folio;
304     unsigned int nr;
305		
306		if (!make_dirty) {
307			unpin_user_pages(pages, npages);
308			return;
309		}
310
311		sanity_check_pinned_pages(pages, npages);
---------------------------------------------------------------------

In function 'sanity_check_pinned_pages', if
(IS_ENABLED(CONFIG_DEBUG_VM)) and (npages > 0), NULL pointer 'pages' is
dereferenced at [mm/gup.c: 51].

---------------------------------------------------------------------
32	static inline void sanity_check_pinned_pages(struct page
**pages,
33						     unsigned long
npages)
34	{
35		if (!IS_ENABLED(CONFIG_DEBUG_VM))
36			return;
..
50		for (; npages; npages--, pages++) {
51			struct page *page = *pages;
								^^^^^^
^
---------------------------------------------------------------------

Else if (!IS_ENABLED(CONFIG_DEBUG_VM)) and (npages > 0) function
'gup_folio_next' is called with 'pages' and 'npages' as parameters at
[mm/gup.c: 311].

---------------------------------------------------------------------
312		for (i = 0; i < npages; i += nr) {
313			folio = gup_folio_next(pages, npages, i, &nr);
---------------------------------------------------------------------

In function 'gup_folio_next' NULL pointer 'list' is dereferenced at
[mm/gup.c: 263].

---------------------------------------------------------------------
262	static inline struct folio *gup_folio_next(struct page **list,
263			unsigned long npages, unsigned long i,
unsigned int *ntails)
264	{
265		struct folio *folio = page_folio(list[i]);
								
		^^^^^^^^^
---------------------------------------------------------------------

