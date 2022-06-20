Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB3E55206B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiFTPRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiFTPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:16:58 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261FEB14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:07:23 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id cu16so15670896qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gOTFxkGUqMupIw22AxS/Rx8lIZoYdQhdeAt9oipInOQ=;
        b=nGz6JXChASVFK16Z11+FZHiHcu/oPhoi4TDFXPqfeIYM3weFxOXE5d5yKyqrsA8twT
         rSF6U6BAAcwcEvJx6eZVUdlXk3fGIa1UKeeuprlOlF8addMXTqwonC8dtxEATCi1H3sL
         Pg01qgPGnp5Sh0HA3z8CavZcEN6DEIp7a588glqb4bXjnIDDRxOdbGeWRjZzUUn5GTxQ
         fZJGbr8oL1pg/5N8i5bjBx24EIeJomjiApPwaHcZe0Gb5PU5y51UAS9RUQ6/oGdloFMw
         znHSbdVgVuSmIpKKim7L8rWI6RGdQ4+bwhfjy7wF/fgz2SswOdxFtddPCgY1AuCEZ7Ot
         MzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gOTFxkGUqMupIw22AxS/Rx8lIZoYdQhdeAt9oipInOQ=;
        b=UdLnnVtvW+9DjbmNYbpWCWWcWI+FAwfokelBj1vz0GguUnMnzAK6QC+npJxLxoLmOC
         1/GWFtn4eKy9TEpF48FBeUxQHgIt11cmmm3JxpBrVOl/As2rUZm0X/6o4Vokx5iuLdx0
         TOLW+qdSU6RQrdZ8egHNuQ8oUVaR1H6vcErcdUm8JJh2G770Ug5bCIjLCo3RoLCyn2u2
         4vi3B6inDyy6kG9ADFVO62H7VW7fV1/HBGJdWYRZn3XSEZq6ELwo1MHQCrxoYVkI+dXz
         NbzGNyyekGad7LjL7uONGBimblJMvcjwsuILzvjMI54qj3DVQvbcXab/dx0nSA7dw3O1
         SWeg==
X-Gm-Message-State: AJIora8wqPZ6MZbQmLpVM+kHaO6Lq7Zp6OjHMAUTSh1uHkS6IdbKNntK
        wEiQ1HYJWRXhdHfopPKwnw==
X-Google-Smtp-Source: AGRyM1u7rJu4JgvhcW8gXh8UcVQZ1bu+UwmmklndWij/TRVUJ58+t67cAb8NQnR+v4XDuUq5MVr/5w==
X-Received: by 2002:a05:622a:3d0:b0:305:2e8e:e185 with SMTP id k16-20020a05622a03d000b003052e8ee185mr20509541qtx.418.1655737642238;
        Mon, 20 Jun 2022 08:07:22 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id x9-20020ac84a09000000b00307c8b4f5ccsm8414441qtq.52.2022.06.20.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:07:21 -0700 (PDT)
Date:   Mon, 20 Jun 2022 11:07:20 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Message-ID: <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 04:19:31AM +0000, David Laight wrote:
> From: Kent Overstreet
> >   Rasmus pointed out that -fno-strict-aliasing is going to cause gcc to generate
> >   nasty code, and indeed it unfortunately does but according to worst case
> >   scenario microbenchmarks it's not a problem for actual performance.
> 
> Just copy some of the structure members to local variables
> and, if necessary, write them back at the end.

You must not have read any of the code - half the point of this patch series is
implementing proper helpers for printing chars, strings of bytes, etc. and that
doesn't work if we're not using actual types.

> >      printk("%pd", dentry);
> > 
> >    becomes
> > 
> >      printk("%pf(%p)", prt_dentry, dentry);
> > 
> >    My OOM debugging & reporting patch series that builds off of this uses this
> >    to solve a very real problem that Michal Hocko brought up at LSF - with this
> >    we write shrinkers_to_text(), slab_to_text() which can _also_ now be used for
> >    reporting in debugfs (which Roman has been working on), as well as in the
> >    show_mem() report - the "%pf()" syntax lets us print the output of those
> >    functions without allocating (and having to preallocate) a separate buffer.
> 
> I really think that is a bad idea.
> printk() already uses a lot of stack, anything doing a recursive
> call is just making that worse.
> Especially since these calls can often be in error paths
> which are not often tested and can already be on deep stacks.

We went over this before - this patch series drastically reduces stack usage of
sprintf by eliminating a bunch of stack allocated buffers. Do try to keep up...
