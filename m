Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB4848C823
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355173AbiALQUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355044AbiALQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:20:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB7C06173F;
        Wed, 12 Jan 2022 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=duDlEvV9eu+0iPLAKykc3Kf0qmlJpQ1JD7j/tSd6K6c=; b=Q08smAEhVZglLoGBh6IU9zTKKu
        ZPacSBrgpFIEy8WNotjTe8AlCQBQZcD9eLtkKzfeMQrYYIK+Tdsv24J0HbW94MzLZw5toGhUe6GL8
        Or4/jb1wucK2peTZWZuM4Jr13msAgenZJyWa2UNeKx0ghOu1M9LrLmE7IjsvYAEqcZJk9+9hmQ7BS
        skn1D9ZxEVbgeDGcp1mJqu+BBHwbrPYMN5PvLeAW664cRYe77j9VLm+yAOahWasITJEmQycr8DIFs
        90cj/0u4lrksvt4OCUj+pmxqQJigxpinb/ozb+hU4EFlHP4lSKoN9aCdhZLdUK4Vx1vfN1qN0Yoii
        mqwVD6rg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7gLy-0034rL-1F; Wed, 12 Jan 2022 16:20:02 +0000
Date:   Wed, 12 Jan 2022 08:20:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: Re: [RFC PATCH 11/12] module: Move sysfs support into a separate file
Message-ID: <Yd7/sqLNQzl15zQ+@bombadil.infradead.org>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
 <20211228213041.1356334-12-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228213041.1356334-12-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 09:30:40PM +0000, Aaron Tomlin wrote:
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 2da580c7b069..354fb2697188 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1017,7 +1015,7 @@ static ssize_t show_taint(struct module_attribute *mattr,
>  static struct module_attribute modinfo_taint =
>  	__ATTR(taint, 0444, show_taint, NULL);
>  
> -static struct module_attribute *modinfo_attrs[] = {
> +struct module_attribute *modinfo_attrs[] = {
>  	&module_uevent,
>  	&modinfo_version,
>  	&modinfo_srcversion,
> @@ -1031,6 +1029,8 @@ static struct module_attribute *modinfo_attrs[] = {
>  	NULL,
>  };
>  
> +size_t modinfo_attrs_count = ARRAY_SIZE(modinfo_attrs);
> +
>  static const char vermagic[] = VERMAGIC_STRING;
>  
>  static int try_to_force_load(struct module *mod, const char *reason)

Can't modinfo_attrs and modinfo_attrs_count be left static and moved to
the new file?

  Luis
