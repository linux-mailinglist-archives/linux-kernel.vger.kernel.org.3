Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833AA4CC075
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiCCO6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiCCO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:58:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA4F18FAF9;
        Thu,  3 Mar 2022 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nTOmvpJSqckbzDf6eNL7+28B+F+UJStxYN/hNpPhOJs=; b=2hK1c4rR4aVG0ad7mKz7MpWxDj
        x6Elg54vNkqJj+F/azQVGGzqo/Qf08ilktEoaP2BYNe8WJ/7ibQMOJtPLE9rYoqtChmuJ9/v0RYZM
        W6VeyNcyhWO3ldIEVBaB5ha56PHJFwGCTNj7iat+XgkOYPkU64D78XfHsWNdcsqOEjrBmk+Q+30qV
        tNEUNZtjNmgJpHKZymDRAR1LO7Itq+FYqPZafs++O8hGrqDYHsxt/SgmqyYJqHo45So8F3yRuobz8
        N9yu3tGeWjw8LWKyW1XR3/JgdKEyp+g1v+pIzlSSalPP0UBPwICyq21Hqc7ZwxjgKIuIUWrcyD1jh
        5JV27RdQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPmtL-006j7N-Eo; Thu, 03 Mar 2022 14:57:19 +0000
Date:   Thu, 3 Mar 2022 06:57:19 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <YiDXTycPZ555KI57@bombadil.infradead.org>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <Yh/zy7FCcDmIdAn8@bombadil.infradead.org>
 <20220303104404.crqt7oz4kydq36fo@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303104404.crqt7oz4kydq36fo@ava.usersys.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:44:04AM +0000, Aaron Tomlin wrote:
> On Wed 2022-03-02 14:46 -0800, Luis Chamberlain wrote:
> > Since we are doing this to help with the cleaning this crap up
> > the natural thing to do is have the code be a helper which only
> > built-in code can use, so writing a helper starting with
> > list_for_each_entry() which prints the modules out. I'm
> > surprised we have no other users of this. There is nothing
> > kdb specific about the functionality in that code. So it should
> > just be moved.
> 
> Hi Luis,
> 
> Good point, albeit is it really worth it since the only external
> user is kernel/debug/kdb/ code?

Yes, no need to be exposing that list out anywhere else. And if the list
is needed better to have a helper for the users.

  Luis
