Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CBF563C09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiGAVqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiGAVp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:45:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFD16F364;
        Fri,  1 Jul 2022 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9PKKVS1Djzcd3i6RAIYB6RmRU+DE2negWwrSWG/F8eE=; b=bslDrEd1URcwtv/m+49JA/js5c
        cEsxUgbmPZh/uTRzJAU6l8JSi93lhjh0a90Cjy6Bqb2wYRg+QtNOp6rTW7hxgGtieEEv3I0lUwpce
        JNf+N6ICRQHeT95j8IRyume83PzX9NYizxrHQqLhv/Mj4rb0KtkMF7OO1A1ME0bVeWsPX7SJd5Z2+
        qyMb8LlETmi/D6NdpyJufgPCbSJ4AhfEx9panSrDZKu3ozm+LOigvk8wKUMBz952KskghaSW4lBNw
        PqwVVordGivmqEpfvlE9hvuKuKdBAzqATX9DhsnT6qr1D7x5b9p+iglTS14yAmg3c8Y+BfuCFChly
        W7iLvNvw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7OSZ-0074JN-28; Fri, 01 Jul 2022 21:45:55 +0000
Date:   Fri, 1 Jul 2022 14:45:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] module: Fix "warning: variable 'exit' set but not used"
Message-ID: <Yr9rEzCse4GSOEMU@bombadil.infradead.org>
References: <a7e1cf121cc52969878d0450b273e7fa10043835.1655047991.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e1cf121cc52969878d0450b273e7fa10043835.1655047991.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 05:33:20PM +0200, Christophe Leroy wrote:
> When CONFIG_MODULE_UNLOAD is not selected, 'exit' is
> set but never used.
> 
> It is not possible to replace the #ifdef CONFIG_MODULE_UNLOAD by
> IS_ENABLED(CONFIG_MODULE_UNLOAD) because mod->exit doesn't exist
> when CONFIG_MODULE_UNLOAD is not selected.
> 
> And because of the rcu_read_lock_sched() section it is not easy
> to regroup everything in a single #ifdef. Let's regroup partially
> and add missing #ifdef to completely opt out the use of
> 'exit' when CONFIG_MODULE_UNLOAD is not selected.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Queued up thanks!

  Luis
