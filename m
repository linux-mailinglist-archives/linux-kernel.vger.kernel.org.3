Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3664706B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbhLJRNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbhLJRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:13:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD7DC061746;
        Fri, 10 Dec 2021 09:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BMp/3Rxta5vGEmVQKQULL2D7UCjIkk1uGCPfneb0M1c=; b=3u+xKPuVA1Ux5lCsk1++m00Cbs
        o5SugFMIHU9UntwI/Kl35zgQoa9y0vCAlfBS2u18GBvG3yb5dm6krKBt95iT41L5p9GWMC+aQQNGi
        H6IBH/+W9306+wbiNVY0Wqp0+o5JFErORWYJLU6wcWbyXP/HaBANXAs/U/zs3EnvpTfsd9jaQOoG+
        n05KIhDloKPjF1pu/Ssercr806x/RSei0Swhf5NBFGVKQR73RebiPpacCPpTCpbWExM1ynOMNa63n
        7XbYJQUDpV6B/ofn0yJQGysn7HAIMkH1+gmueW6+az6ileYmadQbfYECyEUHrFUYMzkKc4baEthuJ
        TeeDGphg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvjOd-002k3D-PT; Fri, 10 Dec 2021 17:09:23 +0000
Date:   Fri, 10 Dec 2021 09:09:23 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <YbOJw4B4p7V+bfPU@bombadil.infradead.org>
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
 <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <YbMlVFwBiRujKdEX@alley>
 <20211210160931.ftvxpulno73a2l7c@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210160931.ftvxpulno73a2l7c@ava.usersys.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 04:09:31PM +0000, Aaron Tomlin wrote:
> On Fri 2021-12-10 11:00 +0100, Petr Mladek wrote:
> This is an interesting suggestion. Albeit, as per the subject, I prefer to
> just keep track of any module that tainted the kernel. That being said,
> Petr, if you'd prefer to track each module unload/or deletion event, then I
> would suggest for instance to remove a module once it has been reintroduced
> or maintain an unload count as suggested by Luis.

Come to think of this again, although at first it might be enticing to
keep track of module unloads (without taint), we have to ask ourselves
who would need / enable such a feature. And I think Aaron is right that
this might be better tracked in userspace.

The taint though, that seems critical due to the potential harm.

Maybe how many unloads one has done though, that might be useful
debugging information and does not create a huge overhead like a
pontential -ENOMEM.

  Luis
