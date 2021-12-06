Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45932468FBE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhLFDl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbhLFDlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:41:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC898C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 19:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zc629guViPb5O8ziVPTQC0LL2CGfjHRLkDsDY1SlIy0=; b=LvdUSXXI9B02qW5VzNfefVMBP7
        HXrAGs30vWpS6fcQMRQSInDShxEuqIhRkUSRVvRl9w9GBZvIYiWtbszfruGRZMIgHflrPR9qq8r2p
        pgM9Iat+sWrYnHFaeoVrkAUGXMsZgyar5bT3n4sOqwUZ4XQQtVaE9nzhRWemzNFtZL7AfhrTQFGHm
        XoJFO8xV59uc2UrzLPLUNpnSrrR6lsBhVi450sajcEWEY4W/m7iJBCZ5VccTHPplM2lZx9xvc2ZRD
        Fh/kdbmHGHeMuv//iOaF0Rxex+oC0lqIbM2BQ+P16UN2hy9Q1lm43hCbYNIj8TXk8VnelBupoXNsO
        W1e3JCFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mu4p8-002iBy-8R; Mon, 06 Dec 2021 03:37:54 +0000
Date:   Mon, 6 Dec 2021 03:37:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [RFC PATCH 1/2] include/linux/gfp.h: Do not allocate pages on a
 offlined node
Message-ID: <Ya2FkkhZdUvWbU/f@casper.infradead.org>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-2-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206033338.743270-2-npache@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 10:33:37PM -0500, Nico Pache wrote:
> We shouldn't allocate pages on a unavailable node. Add a check for this
> in __alloc_pages_node and return NULL to avoid issues further down the
> callchain.
> 
> Also update the VM_WARN_ON in __alloc_pages_node which could skip this
> warn if the gfp_mask is not GFP_THISNODE.

Why is this not also needed in __folio_alloc_node()?
