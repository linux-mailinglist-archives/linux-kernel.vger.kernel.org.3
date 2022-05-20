Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A56552E666
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbiETHkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346578AbiETHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:40:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4F915AB2D;
        Fri, 20 May 2022 00:40:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A9A8F1FA2F;
        Fri, 20 May 2022 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653032425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sKLzeIIqnBt4yP78l19nj+8S8t8g+Th2jCDsFT3mjiE=;
        b=lQaQYQHpsQvuGrA0mbbqVjgJ+4zqwIaKN84hF0sxYRB2+6QwUo52/agj1wAONq4c9eZssp
        hMMlSMWD530L+IYcYogaC9MdQ0UtNELofAMas4HpXbqURBN6GdGqCnahxqGO/KzhgA+a0Z
        kmWI1sTrSfbwW2CyHoWCwsR5BU22Q2o=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0CC212C141;
        Fri, 20 May 2022 07:40:24 +0000 (UTC)
Date:   Fri, 20 May 2022 09:40:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <YodF6C9ib2/kh5px@dhcp22.suse.cz>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172421.162394-4-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-05-22 13:23:56, Kent Overstreet wrote:
[...]
> The goal is to replace most of our %p format extensions with this
> interface, and to move pretty-printers out of the core vsprintf.c code -
> this will get us better organization and better discoverability (you'll
> be able to cscope to pretty printer calls!), as well as eliminate a lot
> of dispatch code in vsprintf.c.

Is this really something that we want? While I do see arguments about
our existing %p$FOO mess there is at least one good argument to have all
those "pretty printers" at a single location. That approach allows to do
a proper review whether those printers are safe from the printk point of
view. If we allow any random callback to be called from the printk
context we just give a free ticket to anybody to do whatever from there
without understanding of all potential consequences. 

Maybe that is less of a concern these days when printk locking has been
reworked a lot but I still do remember how frustrating it is to debug
issues related to printk getting stuck...
-- 
Michal Hocko
SUSE Labs
