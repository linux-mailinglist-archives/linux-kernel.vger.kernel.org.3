Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAB52EEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350650AbiETPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244681AbiETPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:09:21 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E88B0A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wSyuHLs+qqBN2mr7NMcFoXql9989BJT6BYaka7G1yv8=; b=oFP+t9mJfZMjpkwCftZKeInkdH
        NL/ppMU37Do3zgOXJeqC8T7d9geKQBJZOqeBd4XunfknHbmuHlH74ZkZTIxzYcdncupV/ZhK3r0pd
        FYhbNmkYw1Aze+oRGlU9hjulTAuzxoaei81OJRYjuLQc6HD8GoErp/eqlKuFhGIq77GLjE75rtVB1
        jI00+m4YsdcLPC46m8/mQ9ucezzF8FZNKwXwRUmFwyOFEN5E969VPjx8kNyGlX6wuTQiVGWvdGcFe
        VW4T5cMPOJNIu9WTXEo+ZTL/Kw/lGuUBHBaD3W/+B7un9Wco2LGgpLYqjj7rrKsnmX0/qdnjYGMUy
        3mb2Q4TQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns4Fj-00GcvK-Ml; Fri, 20 May 2022 15:09:19 +0000
Date:   Fri, 20 May 2022 15:09:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] char/mem: only use {read,write}_iter, not the old
 {read,write} functions
Message-ID: <YoevH5YFLcBBfsB0@zeniv-ca.linux.org.uk>
References: <20220520135030.166831-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520135030.166831-1-Jason@zx2c4.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 03:50:30PM +0200, Jason A. Donenfeld wrote:
> Currently mem.c implements both the {read,write}_iter functions and the
> {read,write} functions. But with {read,write} going away at some point
> in the future,

Not likely to happen, unfortunately.

> and most kernel code made to prefer {read,write}_iter,
> there's no point in keeping around the old code.

Profile and you'll see ;-/
