Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD752BCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiERNp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbiERNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:45:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7919CEE4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zHCFhRbJ5KoBP25J/EVA30nZjwejxa0UyBXdd6YAaF4=; b=OfkWNCZWsoLrWqd56zXTPhczAR
        Xu6/rWTNKrHA5cVITymYCU7C4/BuduKoFrwDVkllDtDmTwQwvpwjUrpdfRvTvtZo8yvfgrRuSRptz
        dGZzY66n3hdKJFC0dVStt35QHnrIiK2a4cQzs1nuLJ6CLQydPerstjr5JbjRj7wd7gXMeR4XR6Fyl
        lTd2H2/zzj/WYjDnSh3AMB/sqU3wUqKqGTptHwfo0ecsQnNijGsQ3L3sW4OrscH+mwB3FG0Q48r3G
        KNYWIuEvYvH1LmuYE5O//C/SHYngGuQagyk3HMLrbcTMYU/L6AP1FKnFK27sU4snqP8olMxHVwBBt
        SSqd4aWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrJzC-002LqV-JH; Wed, 18 May 2022 13:45:10 +0000
Date:   Wed, 18 May 2022 06:45:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, jbeulich@suse.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/2] x86/pat: add functions to query specific cache mode
 availability
Message-ID: <YoT4Zk/SxBgadq2b@infradead.org>
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503132207.17234-3-jgross@suse.com>
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

On Tue, May 03, 2022 at 03:22:07PM +0200, Juergen Gross wrote:
> Some drivers are using pat_enabled() in order to test availability of
> special caching modes (WC and UC-). This will lead to false negatives
> in case the system was booted e.g. with the "nopat" variant and the
> BIOS did setup the PAT MSR supporting the queried mode, or if the
> system is running as a Xen PV guest.
> 
> Add test functions for those caching modes instead and use them at the
> appropriate places.
> 
> For symmetry reasons export the already existing x86_has_pat_wp() for
> modules, too.

No, we never export unused functionality.
