Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153E152E4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbiETGCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiETGCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:02:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC70714AA79
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:02:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2A14227A87; Fri, 20 May 2022 08:02:44 +0200 (CEST)
Date:   Fri, 20 May 2022 08:02:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, tytso@mit.edu, Jason@zx2c4.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Message-ID: <20220520060244.GA16503@lst.de>
References: <20220519193133.194138-1-axboe@kernel.dk> <20220519194838.GA6361@lst.de> <83183894-155a-efe7-ea0d-a3d88ebeadb1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83183894-155a-efe7-ea0d-a3d88ebeadb1@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:55:26PM -0600, Jens Axboe wrote:
> I'm a bit torn on this one, because I _really_ want us to get rid of
> read/write and make everything use read_iter/write_iter. Firstly because
> it's really stupid to have two interfaces, and secondly because even
> basic things like "can we block here" doesn't work in the older
> interface without fiddling with file flags which is a non-starter for
> certain things.

Converting everything was my initial plan, but Linus said no and just
fix whatever breaks.  And compared to my initial fears the fallout
actually isn't that bad.
