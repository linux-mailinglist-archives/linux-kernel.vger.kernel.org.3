Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0948D58E152
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbiHIUqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbiHIUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:46:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349CEB97
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:46:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so18620188lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0Qy02k6+Ajv4Ag2mivoqOXtUuUF/P/EOzfJ1STVBz2M=;
        b=CG4Dw1M9UdPqZpV8B0sI5Fkw+fAHw9yeykPb4+HjQ5x2t6jF4FoQ1T90PopQrzs3T7
         BTLRToS9FGiKCaENH9YkBqYwuHt/P0qOdBwajxJreFpIUwgyaakUxHw2sm+eVOF3liYK
         aYKET9RkISdjZA3h9TtIFRIhmNKbirx0ITCsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0Qy02k6+Ajv4Ag2mivoqOXtUuUF/P/EOzfJ1STVBz2M=;
        b=LeVLueN8/HeFRelGpII5m8PzzgWBQB7Lv5XIFPW63rGcsfcGropGsG574tbcfonYtQ
         UJMTWp/8u8etuDkaVR5iaNrQdKMXXVjgouppdEvvD8gJ9U5IKMCX9BW/49OXNkKViyyW
         NKdRHg+Fc4vMuK6fx+3R+JcqCsBeANntP52/2N6buqCo0EhjeZckjcot2g12pxVZFSKL
         K/pj5hOwkP0sDGF88KJWkLHLUYfk7ENeib0BwdEmWQtRLv1k39ppOLaX9YbfG3by5DZq
         8/SM6go9j8UFsgKBvZgJdEPvbztZVE3w/YTetd5KWyciJ8kRriuvu8c0L9I30cEvOZGJ
         SV7g==
X-Gm-Message-State: ACgBeo0KVKsZiJadmBxsJWEL9uaTy3ZNlMB5qFVagwHuPBwsg33ulk9S
        qfvD+R5DZr2zefZK5/yNOJAYddvA86vAfiqd7VU=
X-Google-Smtp-Source: AA6agR7JjWw9nZFJy1DSoLmZI7g1AylCWclwADW4JhW1kzmAZPZtZinOl6yiLEgwaoTu9N0vWN+JNw==
X-Received: by 2002:a05:6512:108f:b0:48b:3a92:a2c6 with SMTP id j15-20020a056512108f00b0048b3a92a2c6mr7343225lfg.123.1660078001302;
        Tue, 09 Aug 2022 13:46:41 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id q18-20020ac25292000000b0048ad80a6d07sm86674lfm.170.2022.08.09.13.46.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 13:46:40 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id x25so14169278ljm.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:46:40 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr15548804wru.193.1660077527286; Tue, 09
 Aug 2022 13:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220808073232.8808-1-david@redhat.com> <CAHk-=wgsDOz5MfYYS9mE7PvFn4kLhTFdBwXvN6HCEsw1kvJnRQ@mail.gmail.com>
 <91e18a2f-c93d-00b8-7c1b-6d8493c3b2d5@redhat.com> <CAHk-=whg0ddey-LqFAPfZJDXHMjaHJNojAV3q17yvjc6W8QRvQ@mail.gmail.com>
 <c096cc82-60b4-9e75-06ad-156461292941@redhat.com> <CAHk-=wh1q7ZSWhDWOyqmVawqjq55sUVkn8ASjE_b2VOcE1vFaA@mail.gmail.com>
In-Reply-To: <CAHk-=wh1q7ZSWhDWOyqmVawqjq55sUVkn8ASjE_b2VOcE1vFaA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 13:38:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_PfZ1_8pjMmRftiq1dshheTFnctEwRt8PZMGndCisdA@mail.gmail.com>
Message-ID: <CAHk-=wi_PfZ1_8pjMmRftiq1dshheTFnctEwRt8PZMGndCisdA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 1:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And here we are, 30 years later, and it still does that, but it leaves
> the VM_MAYSHARE flag so that /proc/<pid>/maps can show that it's a
> shared mapping.

.. thinking about it, we end up still having some things that this helps.

For example, because we clear the VM_SHARED flags for read-only shared
mappings, they don't end up going through mapping_{un}map_writable(),
and don't update i_mmap_writable, and don't cause issues with
mapping_deny_writable() or mapping_writably_mapped().

So it ends up actually having random small semantic details due to
those almost three decades of history.

I'm sure there are other odd pieces like that.

                  Linus
