Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9AD52EF7E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350971AbiETPoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiETPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:44:11 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC58179093
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DiDfLAXq5OXic23EfOc3wXlMoPBG932gPA4+ltevFWQ=; b=eUHMqYiH0BTIRFgTvQXExFPOjO
        Q5/clk7FTDLCL2bB7fYo7NIEyWpvCqL3QjgltmBbesGSkafVDnpSjbho5C+9cwyp6584Iwv4nHCml
        DZwpCPoSXiklGMFRy4M6NELvJyd0bcPlaFqhBgId4CB0hk0EdQuQi7emM16c5QUzVrXq2sj+zN8zJ
        5LNJt8NlXuDy/3uI0ei5GCAzAuhNwXrlqna7grV5Jvh+qKm/nit5K80RQPTfsK5tBil7dzswQTujX
        AlGyLrr0KMpXa7W8oosl9KsbUqI+fhfFgpwmz7b3wcpMVDP79nift6C2Tv+ApFnCApMDivRN52TUP
        1owLKsRQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns4nM-00GdKP-R0; Fri, 20 May 2022 15:44:04 +0000
Date:   Fri, 20 May 2022 15:44:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/mem: only use {read,write}_iter, not the old
 {read,write} functions
Message-ID: <Yoe3ROmrA8sNe3Cb@zeniv-ca.linux.org.uk>
References: <20220520135030.166831-1-Jason@zx2c4.com>
 <YoevH5YFLcBBfsB0@zeniv-ca.linux.org.uk>
 <f35d7a15-0cbf-1663-15af-eae37a90d0ff@kernel.dk>
 <f3878dfd-67f7-9a01-8dcf-7202bf5f3918@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3878dfd-67f7-9a01-8dcf-7202bf5f3918@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:32:34AM -0600, Jens Axboe wrote:

> Didn't look closer, but I'm assuming this is _mostly_ tied to needing to
> init 48 bytes of kiocb for each one. There might be ways to embed a
> sync_kiocb inside the kiocb for the bits we need there, at least that
> could get us down to 32 bytes.

My bet would be on iocb_flags() (and kiocb_set_rw_flags()) tests and
pointer-chasing, actually.  I'd been sick on and off since early November,
trying to dig myself from under the piles right now.  Christoph's
patches in that area are somewhere in the pile ;-/
