Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F84EAE25
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiC2NKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiC2NKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:10:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D703DF10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cTMwKalK7QXcN3cet26Iin/abX8tZmbV6bru+8JGtfI=; b=FJw0zubQ07UUlTaiwOPvhMpdEi
        U442VB+nkCNvx5N2krFK86rGtIL+JYiJx+SCfII34bS0HPXmjS5JyEJ5FQDqQ2Fj100s0akK4COcS
        jo4/fHskA5JpNKlg4fZvFLUJMK74BpiuHiskt3U0d+SFb0i1NW+0XfanIIg/9xzL1V9Nj3duWugO4
        YUDkDFerDEVWhVQeVW/XrOd9fRWHsk/dfVjGXjT8Njzt88icGVkLy3ZQZqRecaXlxGvKQcRpDPuD8
        Lp4BiDxj2y/B/54dG71Omd5W9oyzzkgN8tyHn2tzxTnMZHUlg9cgZ2EzX7tNf5LZHx4ezj3ip17Vo
        KHYXbtRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZBaf-00CICc-HL; Tue, 29 Mar 2022 13:08:53 +0000
Date:   Tue, 29 Mar 2022 06:08:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kirill Tkhai <kirill.tkhai@openvz.org>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com
Subject: Re: [dm-devel] [PATCH 0/4] dm: Introduce dm-qcow2 driver to attach
 QCOW2 files as block device
Message-ID: <YkME5ZS2CpXuNmN6@infradead.org>
References: <164846619932.251310.3668540533992131988.stgit@pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164846619932.251310.3668540533992131988.stgit@pro>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 02:18:16PM +0300, Kirill Tkhai wrote:
> This patchset adds a new driver allowing to attach QCOW2 files
> as block devices. Its idea is to implement in kernel only that
> features, which affect runtime IO performance (IO requests
> processing functionality).

From a quick looks it seems to be like this should be a block driver
just like the loop driver and not use device mapper.  Why would
you use device mapper to basically reimplement a fancy loop driver
to start with?

> The maintenance operations are
> synchronously processed in userspace, while device is suspended.
> 
> Userspace is allowed to do only that operations, which never
> modifies virtual disk's data. It is only allowed to modify
> QCOW2 file metadata providing that disk's data. The examples
> of allowed operations is snapshot creation and resize.

And this sounds like a pretty fragile design.  It basically requires
both userspace and the kernel driver to access metadata on disk, which
sounds rather dangerous.

> This example shows the way of device-mapper infrastructure
> allows to implement drivers following the idea of
> kernel/userspace components demarcation. Thus, the driver
> uses advantages of device-mapper instead of implementing
> its own suspend/resume engine.

What do you need more than a queue freeze?
