Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A352E172
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbiETBAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiETBAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:00:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228D2131F3E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE54FB82949
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA5BC385AA;
        Fri, 20 May 2022 01:00:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TmzkSPUu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653008404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMfNzGKnUlK4z4BpoSOAcGlQLkUvQ3JPr2QrI6m1i5I=;
        b=TmzkSPUuqC7MrAMD4KeWm2GXp+CpdGu6p3NT/dx1ANG8XtQwT97xQT9qQu6hJkXdSXElsP
        c8MHZ+QN0Pxd5us2dmIhoR+B9I4BaBCvWLsCFyEge78ZibXCxEkYoWCG0MQOJfVi0RbQfe
        BgnuLY5nS5TeJnZ+L2+6bDxaZNYG+MI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 71b0c024 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 01:00:04 +0000 (UTC)
Date:   Fri, 20 May 2022 03:00:02 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Message-ID: <YoboEokc00YACuha@zx2c4.com>
References: <YobPB27Ozl7uqUEu@zx2c4.com>
 <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
 <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
 <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
 <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
 <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
 <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
 <13899409-e81b-8689-3380-249de46c0b6f@kernel.dk>
 <YobldmDn6pU9mr4f@zx2c4.com>
 <84d073aa-9937-1a58-dd7a-b1828874c21a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84d073aa-9937-1a58-dd7a-b1828874c21a@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, May 19, 2022 at 06:56:12PM -0600, Jens Axboe wrote:
> On 5/19/22 6:48 PM, Jason A. Donenfeld wrote:
> > sendfile() returns -EINVAL even with your patches. Only splicing to pipes
> > seems to work.
> 
> Huh, that really should work. Are you trying to sendfile() to random? If
> so, you need that last write_iter patch too, and add the splice_write as
> I mentioned.
 
No, I've only tried the read side so far. I made a little program:

#include <sys/sendfile.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
        ssize_t s = sendfile(1, 0, NULL, 0xffff);
        fprintf(stderr, "ret: %zd\n", s);
        return 0;
}

Then I ran `./a.out < /dev/urandom > /dev/null`. Fails. OTOH, if I
replace /dev/urandom with an ordinary file, it succeeds.

Jason
