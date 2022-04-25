Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B00450ED11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiDZAAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiDZAAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:00:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D63107700
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h5QXgxJ1aGDceWrYuG1jHB6di1JRZTFGfTsmuiIJuLI=; b=cTUxTt2w7Cd4Omul8GluhjKvMy
        IgxMLdp7R2egxMUOh8rwLY3KI0/ZvCAcQTwDCurSvPfX5otLeixPESApdXmQfs8+yozu3zD+UMeHD
        OJ1x09XCsoq4haPh6oh36mi25XLt7auXzvmyxLC4Mtj+eAaJyBGt7m5MDAmA3hjx38fo5ucw2c6HS
        hbewRNEZ9NrmSeu02balT5srjsLE1T49h9JCL9YSKWGkQzZkOEbRm2dgJlx+YvzesnTHYuepBOSuS
        rHe/KqZZRCRx+ie8Zn3Nwa6cZlO46wqX3/vs+8oBhBjksfxXhlTI4Q28TeOPkEc5U/gq5KcTvCx/s
        In5OO/CQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj8a6-00BmLt-D2; Mon, 25 Apr 2022 23:57:26 +0000
Date:   Mon, 25 Apr 2022 16:57:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Julius Hemanth Pitti <jpitti@cisco.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, Ingo Molnar <mingo@elte.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Eli Cohen <elic@nvidia.com>
Subject: Re: [proc/sysctl]  1dd38979b2:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Ymc1Zn8BbQMbjb58@bombadil.infradead.org>
References: <20220425083302.GD21864@xsang-OptiPlex-9020>
 <YmbvxQVNFESRwxxU@bombadil.infradead.org>
 <20220425144607.2c2588e6b1f00ab8a6f3f6ea@linux-foundation.org>
 <YmcqCVLv3HQ+Kxeq@bombadil.infradead.org>
 <20220425163434.5f8f47e8c301ea30c2f94a5a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425163434.5f8f47e8c301ea30c2f94a5a@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:34:34PM -0700, Andrew Morton wrote:
> On Mon, 25 Apr 2022 16:08:57 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > On Mon, Apr 25, 2022 at 02:46:07PM -0700, Andrew Morton wrote:
> > > On Mon, 25 Apr 2022 12:00:21 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > 
> > > > Andrew, can we drop this patch for now?
> > > 
> > > I've been sitting on (ie, forgotten about) this patch
> > > (https://lore.kernel.org/all/20200709235115.56954-1-jpitti@cisco.com/T/#u)
> > 
> > Jesh, yeah I see.
> > 
> > > for two years.  Evidently waiting for you/Kees/Ingo to provide
> > > guidance.  So sure, the need seems very unurgent so I can drop it.
> > 
> > Well Keew as OK with it, but I yeah I can't decipher the issue at this
> > point in time.
> > 
> > > However I fail to see how that patch could have caused this crash.  I'm
> > > suspecting a bisection error?
> > > 
> > > Maybe something is unwell in drivers/vdpa/vdpa_user/vduse_dev.c.
> > 
> > At a quick glance, yes it could very well by vduse_init() is messy and
> > races somehow with init, but if a race does lurk here my instincts tell
> > me this can't be the only place.
> > 
> > Not sure if leaving a patch in place more time to see how else things
> > can explode is worth it.
> 
> Confused.  Are you thinking that the above-linked patch was somehow
> involved in this crash?  If so, but how?  All it does it to permit
> unprivileged reads to four ints via proc_dointvec_minmax()?

If the priv allows for it access to dereferencing a pointer is allowed.
How that race happens though, indeed is beyond the patch's fault.

  Luis
