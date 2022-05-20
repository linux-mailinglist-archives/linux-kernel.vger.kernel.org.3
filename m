Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78E52F050
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351453AbiETQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiETQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:15:20 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE281666A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mfhBwZcnaZ54WaOWHFXsaT0BxNawadzJQv+waAwgHL0=; b=OSX44A4pUo8LP0BG7RuO/YC5Tw
        2Qo6nCV3BGBkYPqfEcunShihpgpX5FIBj9i5epCkYNqapazT0V6xpqOXJLl0mE7OLEufpvk1TVmMK
        /ZKXneGPg2WyXUzlbFjxEpOHJt2xjvokpQqqeV7TBLLVo2lfaLkgfOTuGc+IiPIiw855On+HSKVHI
        JeXVWaObADNZ6UlxEp9Tyw1ZPdyPyiwDE6Kz+GRAitrMSo8Yy6MuA5UAjRAuvJqyYrMcFk1PbyDfa
        1xgRrfLVjBYz1pk65nj+RjuZGGQRhk43aaiC+sjdkNh+6USxmsGPq8ZX6oWCZxxer1Ur/sTLwmkVY
        87aAeFbA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns5HY-00GdoN-Al; Fri, 20 May 2022 16:15:16 +0000
Date:   Fri, 20 May 2022 16:15:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Message-ID: <Yoe+lK8RIRbK6lDZ@zeniv-ca.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com>
 <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe4HP9iTA6l/For@zeniv-ca.linux.org.uk>
 <7e78d6a7-1cc3-2408-fe91-0329f5020e77@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e78d6a7-1cc3-2408-fe91-0329f5020e77@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:53:30AM -0600, Jens Axboe wrote:
> On 5/20/22 9:47 AM, Al Viro wrote:
> > On Fri, May 20, 2022 at 09:34:46AM -0600, Jens Axboe wrote:
> > 
> >> I'm very sure, otherwise we're just accepting that we're breaking real
> >> world applications.
> > 
> > "Breaking" as in "it used to work with earlier kernels, doesn't work with
> > recent ones"?  Details, please...
> 
> Yes, as in exactly that. This is what drove this addition of
> ->read_iter() for urandom. See commit:
> 
> ommit 36e2c7421f02a22f71c9283e55fdb672a9eb58e7
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Sep 3 16:22:34 2020 +0200
> 
>     fs: don't allow splice read/write without explicit ops
> 
> related to the set_fs() changes, and now go look for any commit that
> has:
> 
> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> 
> in it and see that this isn't an isolated incident at all.
> 
> tldr - splice from /dev/urandom used to work, and I recently got a
> report internally on an application that broke on upgrade from 5.6 to
> 5.12 exactly because it now just just -EINVAL's instead.

IIRC, Linus' position at the time had been along the lines of
"splice is not so good ABI anyway, so let's do it and fix up
the places that do get real-world complaints once such appear".
So /dev/urandom is one such place...
