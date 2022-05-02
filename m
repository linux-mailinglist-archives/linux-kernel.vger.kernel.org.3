Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A06517638
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386792AbiEBSDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386778AbiEBSDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:03:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875CA32F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 497DDB81999
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B65C385AC;
        Mon,  2 May 2022 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651514414;
        bh=EubwGzbfbBYKRz56gIaYdoiNqVKpVK+pxTm8DS7GvNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tL1nasUabAClUQj0vHyo9fmQaefv0v2UsPdxEM3b0Q8C0HKe4ClW/DuFLtRjZBCyG
         iGgar/NCR1lRDQ+YQLFTlzfxhPK5r4YHIJLksmJEw+8DThHWXrsJq5BP1bbg0uxATm
         wKqevIxCY3B1AIdhwtGqBbrVJJ2x1tttTN4mEqqo8E8x63+8BQJpVp/WnaetpjQ7TL
         eo7055YbMDW/DEZBjbSIIEltuKEkzzZwb6zol1WvbKsKw62UuFilvQsQpG6F/jd21o
         EejZj0JkfdxFK2Ds/eMAXYAMw6jbuB9NNKCsQHIqolYPWYRlmXJUM7ZgCzS60fxFf0
         WqdeI0KfZ9jIA==
Date:   Mon, 2 May 2022 11:00:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [willy-pagecache:for-next 60/69] fs/ntfs/aops.c:378:12: warning:
 stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio'
Message-ID: <YnAcLApzs6frds2n@dev-arch.thelio-3990X>
References: <202204301355.hFVoSOPa-lkp@intel.com>
 <Ym2rzWiP8iNRHWxS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym2rzWiP8iNRHWxS@casper.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 10:36:13PM +0100, Matthew Wilcox wrote:
> On Sat, Apr 30, 2022 at 01:11:43PM +0800, kernel test robot wrote:
> > >> fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio' [-Wframe-larger-than]
> >    static int ntfs_read_folio(struct file *file, struct folio *folio)
> >               ^
> >    1 warning generated.
> 
> Am I getting this warning because I changed the name of the function?
> Or did I do something Bad?

I assume so. There have been other reports of high stack usage in this
function, which it seems Arnd narrowed down to 64K pages (or 256K pages
in this case):

https://lore.kernel.org/20210927141815.1711736-1-arnd@kernel.org/

https://lore.kernel.org/202103280658.kByZmw5Q-lkp@intel.com/

Cheers,
Nathan
