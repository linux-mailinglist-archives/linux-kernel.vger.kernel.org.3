Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C95707FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiGKQIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiGKQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:08:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE236E89E;
        Mon, 11 Jul 2022 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L9MaBX0ADCbYKPOd5iafLk3ONE1qneBOG6QIpxWT8/I=; b=eIweT0CWd1DwElj/q4N/Bs2EYQ
        fWkvmzkz3WP3CU2XidwPn9jHWSd0NKKlqsvFmJz7C11+LQHxWqgqf7eT/BANntkshoUrsdGe+0uvM
        B+gebA0UIGukk0caBUMIv4lh4Av7judVNRrosKCTpsKfDmtiN1GZH2oQxDV/JfeuhnwskYy+lRzBM
        daWZDfPgIfN1P40tTtJIWAJu44XpwfG/SM6i83vhK88/lvNBRKsTOjwpDdwerLQFfjM/pzGdnQ64Y
        e8ekbETuvWz5LgjIyfFeOI87+DZzjOBYiLKYUFT8nxGjYq7on30FucfTwt8DUgplc2SxnSbQA1BzU
        ZlGaZhpA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAvwn-0037cE-AB; Mon, 11 Jul 2022 16:07:45 +0000
Date:   Mon, 11 Jul 2022 09:07:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     jeyu@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3] modules: Ensure natural alignment for
 .altinstructions and __bug_table sections
Message-ID: <YsxK0ViJHnCAwHwI@bombadil.infradead.org>
References: <Ysf8lojv8UMZsvBM@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysf8lojv8UMZsvBM@p100>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 11:44:54AM +0200, Helge Deller wrote:
> In the kernel image vmlinux.lds.S linker scripts the .altinstructions
> and __bug_table sections are 4- or 8-byte aligned because they hold 32-
> and/or 64-bit values.
> 
> Most architectures use altinstructions and BUG() or WARN() in modules as
> well, but in the module linker script (module.lds.S) those sections are
> currently missing. As consequence the linker will store their content
> byte-aligned by default, which then can lead to unnecessary unaligned
> memory accesses by the CPU when those tables are processed at runtime.
> 
> Usually unaligned memory accesses are unnoticed, because either the
> hardware (as on x86 CPUs) or in-kernel exception handlers (e.g. on
> parisc or sparc) emulate and fix them up at runtime. Nevertheless, such
> unaligned accesses introduce a performance penalty and can even crash
> the kernel if there is a bug in the unalignment exception handlers
> (which happened once to me on the parisc architecture and which is why I
> noticed that issue at all).
> 
> This patch fixes a non-critical issue and might be backported at any time.
> It's trivial and shouldn't introduce any regression because it simply
> tells the linker to use a different (8-byte alignment) for those
> sections by default.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Link: https://lore.kernel.org/all/Yr8%2Fgr8e8I7tVX4d@p100/

Thanks! Queued onto modules-next.

  Luis
