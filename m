Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2487E5253E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357164AbiELRlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357169AbiELRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:40:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1426013F27;
        Thu, 12 May 2022 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AQe6N02jfGCt1Tpv9ElZ85pDuhThz61shKfOKRMru0s=; b=BEvRkLgW7vQHVOsVfskg7QHDzS
        ni062Z+K9j8D+UEoCD+CUDlULmp8G0eqE7AShtpjvFXFN2noQCTx9si+LrIB/IWFcRZVwVaLjzXCH
        MJzaAZlkx1BkeZASvknqLNqpdNWlO1rC/DSvmazJzxaxaMLkFZJS2vr6qVWm687oHI8E/0f0m5Ea0
        WMXDQR9Emlr7kX8uSpzaU023iE3UxIpBFsp+FCPMTpDur0kK9BrrBvRMt6Fmh1VZitdsV6v99tEMm
        GCNNP1IX3GWFBEOA3faGjezvK6sBmnOfRYHi4cLJoXX+2o0ExMwpNiOCq7gg2kE0Sfr1wAT4YmLgv
        1QMG3h9g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npCnq-00D1Um-8K; Thu, 12 May 2022 17:40:42 +0000
Date:   Thu, 12 May 2022 10:40:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] sysctl: read() must consume poll events, not poll()
Message-ID: <Yn1GmlWKIvuoJJby@bombadil.infradead.org>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <Ym/5EEYHbk56hV1H@zx2c4.com>
 <Ym/8GTW2RfhnbqiF@gardel-login>
 <YnERsPIsiOCa8cty@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnERsPIsiOCa8cty@zx2c4.com>
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

On Tue, May 03, 2022 at 01:27:44PM +0200, Jason A. Donenfeld wrote:
> On Mon, May 02, 2022 at 05:43:21PM +0200, Lennart Poettering wrote:
> > On Mo, 02.05.22 17:30, Jason A. Donenfeld (Jason@zx2c4.com) wrote:
> > 
> > > Just wanted to double check with you that this change wouldn't break how
> > > you're using it in systemd for /proc/sys/kernel/hostname:
> > >
> > > https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/journal/journald-server.c#L1832
> > > https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/resolve/resolved-manager.c#L465
> > >
> > > I couldn't find anybody else actually polling on it. Interestingly, it
> > > looks like sd_event_add_io uses epoll() inside, but you're not hitting
> > > the bug that Jann pointed out (because I suppose you're not poll()ing on
> > > an epoll fd).
> > 
> > Well, if you made sure this still works, I am fine either way ;-)
> 
> Actually... ugh. It doesn't work. systemd uses uname() to read the host
> name, and doesn't actually read() the file descriptor after receiving
> the poll event on it. So I guess I'll forget this, and maybe we'll have
> to live with sysctl's poll() being broken. :(

A kconfig option may let you do what you want, and allow older kernels
to not break, however I am more curious how sysctl's approach to poll
went unnnoticed for so long. But also, I'm curious if it was based on
another poll implementation which may have been busted.

But more importantly, how do we avoid this in the future?

  Luis
