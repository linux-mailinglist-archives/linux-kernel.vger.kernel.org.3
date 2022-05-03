Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87060518345
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiECLbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiECLbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967AA2BB17;
        Tue,  3 May 2022 04:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16487615E3;
        Tue,  3 May 2022 11:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFE6C385AE;
        Tue,  3 May 2022 11:27:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bmSp7zT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651577267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Z1yd+nmgbRoyWcat7igmBFZSRP4D9Hrdh51MyJHDP0=;
        b=bmSp7zT6iHuJMV/++oUHvI8DLL64A2yJ0PRaYRXR827ntL/uL7goJVBxBEpdsQHV6kIXQG
        K8bl09659WhtODZTkdp/tynd4MojoKKLe2+Qck0s6/IdZUOw85g11Ge9D66CQ9wtHCFzUy
        UOriAqCSdLZGwJx6Pkgwcp0yKwkLc/A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 071a4d5f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 3 May 2022 11:27:46 +0000 (UTC)
Date:   Tue, 3 May 2022 13:27:44 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] sysctl: read() must consume poll events, not poll()
Message-ID: <YnERsPIsiOCa8cty@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <Ym/5EEYHbk56hV1H@zx2c4.com>
 <Ym/8GTW2RfhnbqiF@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym/8GTW2RfhnbqiF@gardel-login>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 05:43:21PM +0200, Lennart Poettering wrote:
> On Mo, 02.05.22 17:30, Jason A. Donenfeld (Jason@zx2c4.com) wrote:
> 
> > Just wanted to double check with you that this change wouldn't break how
> > you're using it in systemd for /proc/sys/kernel/hostname:
> >
> > https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/journal/journald-server.c#L1832
> > https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/resolve/resolved-manager.c#L465
> >
> > I couldn't find anybody else actually polling on it. Interestingly, it
> > looks like sd_event_add_io uses epoll() inside, but you're not hitting
> > the bug that Jann pointed out (because I suppose you're not poll()ing on
> > an epoll fd).
> 
> Well, if you made sure this still works, I am fine either way ;-)

Actually... ugh. It doesn't work. systemd uses uname() to read the host
name, and doesn't actually read() the file descriptor after receiving
the poll event on it. So I guess I'll forget this, and maybe we'll have
to live with sysctl's poll() being broken. :(

Jason
