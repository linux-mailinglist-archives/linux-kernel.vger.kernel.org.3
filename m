Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC1D4BE25B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378856AbiBUPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:11:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiBUPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:11:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15A81A396
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:11:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A5D6611A2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADD1C340E9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:11:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FtVHG7lJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645456267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/TQxR2945fuquOnrBphMAxVUXZPMijOC/VjXQu57pqE=;
        b=FtVHG7lJkrJXh23Pspo+vAq150h9OJcd9MMBRkGzl+3waNHywPDlxVkVqBLSZ82uSf7Dkl
        t8bx+fasJE8OGgKWYV489pSJ9Z3etTSbKmWF4n7x1y9rSc7azMzMIzJt4vvey6cDPfFbTK
        8irnsWprKENzA4gz1OIn+VQ6j5uPrOo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 69e61459 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Feb 2022 15:11:07 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2d646fffcc2so141508337b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:11:07 -0800 (PST)
X-Gm-Message-State: AOAM533iae578CTOIvQEtoSy2U0sdcYYkMnE24M/SZ/fqcrctjKr1aJS
        cS5oNiEIeVkeev38x2lIWwJACDJRIjbM9e/PtiM=
X-Google-Smtp-Source: ABdhPJxQBo8W+HUwNYl3w//wD+OhW/wQTMmeTLe8/SxBlU7lacnpqmV6n30VGcEaS+hFwPrYv2M1If65skA50z9ffi0=
X-Received: by 2002:a81:8147:0:b0:2ca:287c:6c42 with SMTP id
 r68-20020a818147000000b002ca287c6c42mr19678342ywf.231.1645456266760; Mon, 21
 Feb 2022 07:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20220212122318.623435-1-Jason@zx2c4.com> <20220212122318.623435-5-Jason@zx2c4.com>
 <YhMZyrF2jkXRwA/D@sol.localdomain>
In-Reply-To: <YhMZyrF2jkXRwA/D@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 16:10:56 +0100
X-Gmail-Original-Message-ID: <CAHmME9r5+9JLN8KjDwmuc1+p1O7THPmzW3sz0jMKKf9k6gCDtQ@mail.gmail.com>
Message-ID: <CAHmME9r5+9JLN8KjDwmuc1+p1O7THPmzW3sz0jMKKf9k6gCDtQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] random: group initialization wait functions
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 5:49 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sat, Feb 12, 2022 at 01:23:12PM +0100, Jason A. Donenfeld wrote:
> > +/*
> > + * Static global variables
> > + */
> > +static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
> > +static struct fasync_struct *fasync;
> > +
> > +static int crng_init_cnt = 0;
> > +static void _get_random_bytes(void *buf, size_t nbytes);
>
> A couple oddities here:
>
>   - 'fasync' is being defined twice.  It's already defined earlier in the file.
>   - The prototype for _get_random_bytes() is unnecessary.
>
> Other than that this patch looks good.

Nice catch, thanks. Will fix.

Jason
