Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B164706AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbhLJRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhLJRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:07:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F68AC0617A1;
        Fri, 10 Dec 2021 09:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mZefXl8JrGnTBBGRf+1m4azQgtumDj+tcEt6wFuWc+Q=; b=ELTZo9dEWvNTXF78oD3M0mpV6L
        itChSBgU/G9hnhKFRowKTQ6q3Adg5VHQt3IWDu0E+tLsYfZeFpTU/dJLUPRqWQ4tmd04UZoruOn8A
        YprI+0x+c+BUQ+ngKHlODenqmxDokA5rf70BM3qlSnE47Xl6Apm9UNo84AnubNPSYf+zhaNzO54D+
        /FQfwVailoBPav+PXqnpBM2IwASGcQQ6kCFVwZ6BgbzDA3wZI0Aut1gxk3DKD7KSV9++CGPmGfqqz
        5lBIgk1SiU/oDINe5ynclbwAfKEyA9BKxfPlRgQ1OhTqV7XZ5Pv7VTRLBmTuYwK7TO/mbTgpoF4Ma
        6RplkJFA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvjIy-002hw5-Ve; Fri, 10 Dec 2021 17:03:32 +0000
Date:   Fri, 10 Dec 2021 09:03:32 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <YbOIZOsiOarBtLxF@bombadil.infradead.org>
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
 <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <YbMlVFwBiRujKdEX@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbMlVFwBiRujKdEX@alley>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:00:52AM +0100, Petr Mladek wrote:
> Please, do not remove records that a module was removed. IMHO, it
> might be useful to track all removed module, including the non-tainted
> ones.

Then we'd need two features. One modules removed, and another which
limits this to only tainted modules. On kernel-ci systems where I
try to reproduce issues with fstests or blktests I might be unloading
a module 10,000 times, and so for those systems I'd like to disable
the tracking of all modules removed, otherwise we'd end up with
-ENOMEM eventually.

> Module removal is always tricky and not much tested.

It is tricky but I have been trying to correct issues along that path
and given that fstests and blktests uses it heavily I want to start
dispelling the false narrative that this is not a common use case.

> The tain flags might be just shown as extra information in the output.

Yes!

  Luis
