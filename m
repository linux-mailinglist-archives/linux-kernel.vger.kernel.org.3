Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9E4DDF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbiCRQcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbiCRQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:31:53 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE63D1B84D8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:30:20 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2e5a8a8c1cdso87911767b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAE3uuJYaI6bZvK1JirdmvyIyu+ZeP4A7IF2vH7oYhI=;
        b=mOYCnnUxwb1osdLgXKMQa4A9q4QPWM9rhR+WhIZaDXV9nNkbEQeKnyjoT4a99+aSuN
         eF3SZaDvHbMGMLFbwS5OYwy0MsweHwpZZw5JzmfyW7ivcIWJ6uf0ZgB9B0CW5MC6OAdp
         W0TeQxoZCujax5Mn72w3oTLaCYhWpd3zCAEZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAE3uuJYaI6bZvK1JirdmvyIyu+ZeP4A7IF2vH7oYhI=;
        b=4eWGWD9Rj36TmTEvniQcno1apzo0PJHOmgdABT2CfAiak3V0KK90BdlimnLPMOeLbM
         ZWp5msrAHZA9UjgxTb9U+Cp8IGJP3o5wworT+bR5WgAQvKMOsQgHBRq1ySiqkI6e1vVr
         G3jEqmgz/6qxphL6D2LVrXstGlWmee4v1bpPFflLKCV+g2uMU+JZSy07RC5j2Qa+IQpY
         R7zC8ZGCK4vPbX9IM/YRD3oveg0OhzEHiNsUkmU2c72RIs3VUvLbvs2wr5mPLExRl2Ca
         72vqV85peVT0W21Pj3QyRfhzn8cFypXFJKA83ru7MBMijRUyoTJY67qqY+om11S0X8z2
         j0xA==
X-Gm-Message-State: AOAM531y146RaH9PEfTgcOaoAASOnPjDCKpkcewAF+/FRBWuM13hZxrG
        OFFsrnxdkYRBx3+w6dwedd4WEAYA+xJEHOLQV9KflQ==
X-Google-Smtp-Source: ABdhPJzl1HaVxL6M7wATA0aA7ue2teOSdQFdYnb3ZCTBjjtSXetDYzZ2exTvmluualwMq/4vLF3w3ZbC725ewFt67Vo=
X-Received: by 2002:a81:a842:0:b0:2db:562a:3f13 with SMTP id
 f63-20020a81a842000000b002db562a3f13mr11684645ywh.322.1647621020015; Fri, 18
 Mar 2022 09:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CABWYdi1PeNbgnM4qE001+_BzHJxQcaaY9sLOK=Y7gjqfXZO0=g@mail.gmail.com>
 <YjA439FwajtHsahr@google.com> <YjEOiZCLBMgbw8oc@google.com> <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
In-Reply-To: <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 18 Mar 2022 09:30:09 -0700
Message-ID: <CABWYdi2gOzAK60gLYKx9gSoSfJRZaAjyAWm+55gLgcSKrDrP9Q@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Minchan Kim <minchan@kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:26 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> I'm making an internal build and will push it to some location to see
> how it behaves, but it might take a few days to get any sort of
> confidence in the results (unless it breaks immediately).
>
> I've also pushed my patch that disables SWP_SYNCHRONOUS_IO to a few
> locations yesterday to see how it fares.

I have some updates before the weekend. There are two experimental groups:

* My patch that removes the SWP_SYNCHRONOUS_IO flag. There are 704
machines in this group across 5 datacenters with cumulative uptime of
916 days.
* Minchan's patch to remove swap_slot_free_notify. There are 376
machines in this group across 3 datacenters with cumulative uptime of
240 days.

Our machines take a couple of hours to start swapping anything after
boot, and I discounted these two hours from the cumulative uptime.

Neither of these two groups experienced unexpected coredumps or
rocksdb corruptions.

I think at this point it's reasonable to proceed with Minchan's patch
(including a backport).
