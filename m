Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4581E4C711E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiB1QA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiB1QAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:00:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4657E14086
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:59:46 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p15so25723379ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udUUwQMYZOQdeQeu7KJflNOXp5UljA8CQOPQlhHKm+Y=;
        b=Ps2g3Rmx7y+RxaExNigUlAShr8r9n4HJx4jXh3jX3l48QN2GGz17bPjHQGFh/RPT/a
         Xe3Y302EzQSNvW7VzbwzWaqmO5xMMVqpxy+XXofnecS/u0ED0x+tbYTlqkSLsLRhSciu
         N6rSkzsDR47sLeOm/7rAJXCL4mb6S7A5gjjMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udUUwQMYZOQdeQeu7KJflNOXp5UljA8CQOPQlhHKm+Y=;
        b=qAqYwsP5nmYZjbPpfySUp1VGiFf9bgBoxXeGmOh8di0ug8AbbZ56aG9cwehh/T8Ndn
         aQoIbEjPkvxyepgWQm4t5upYoSE4fe43TDOm7gPxh2xCMDfEsK7vNERCbQEtGgpqFoM2
         UERUBYZJfg2d8z0LXONEW+ezULRY9WF9hu+lVnMCRluhPTh0ZRL2UDM7tnZCk+ulyX8e
         BsoeY8VSz7kYN8lB/Nqab45153VoB0nV+reV6dixN2uJHVNl3MPs3xRms2n7RBRePyW9
         J8eIF1WRHedSlQjUazW/kAEUYgnz/G7yNa0yAqAILN8SJdca+qhHUfOyHC76Yz+T0AiP
         GXhw==
X-Gm-Message-State: AOAM532+31/K4XR6VMityar0HUJ8lFuoFirSLR73HH01qqgDdXfThCQ+
        BTUVBLuLXhq5mW2bZiLarVIlW//Ve/2iCpd82cTCAQ==
X-Google-Smtp-Source: ABdhPJzFuwC4cXK43NRFP1CzDPmxJHkeyiho2pckN/boPKiQ0vuUKSn6l1ZxMqIRvXXEFW5bhRCbL2ZNT2f45sLUzvo=
X-Received: by 2002:a17:907:76fc:b0:6ce:a836:34a1 with SMTP id
 kg28-20020a17090776fc00b006cea83634a1mr16312616ejc.663.1646063984879; Mon, 28
 Feb 2022 07:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20220227093434.2889464-1-jhubbard@nvidia.com> <20220227093434.2889464-7-jhubbard@nvidia.com>
In-Reply-To: <20220227093434.2889464-7-jhubbard@nvidia.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Feb 2022 16:59:33 +0100
Message-ID: <CAJfpegsDkpdCQiPmfKfX_b4-bkkj5N5vRhseifEH6woJ7r0S6A@mail.gmail.com>
Subject: Re: [PATCH 6/6] fuse: convert direct IO paths to use FOLL_PIN
To:     jhubbard.send.patches@gmail.com
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 at 10:34, <jhubbard.send.patches@gmail.com> wrote:
>
> From: John Hubbard <jhubbard@nvidia.com>
>
> Convert the fuse filesystem to support the new iov_iter_get_pages()
> behavior. That routine now invokes pin_user_pages_fast(), which means
> that such pages must be released via unpin_user_page(), rather than via
> put_page().
>
> This commit also removes any possibility of kernel pages being handled,
> in the fuse_get_user_pages() call. Although this may seem like a steep
> price to pay, Christoph Hellwig actually recommended it a few years ago
> for nearly the same situation [1].

This might work for O_DIRECT, but fuse has this mode of operation
which turns normal "buffered" I/O into direct I/O.  And that in turn
will break execve of such files.

So AFAICS we need to keep kvec handing in some way.

Thanks,
Miklos
