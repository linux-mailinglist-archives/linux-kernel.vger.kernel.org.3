Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0CF58E177
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiHIVCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHIVCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:02:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6B630559
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:02:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h132so12462777pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 14:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Yzf75bRCQMALZ7m4QyOplsWHzkaKOssLSVH5NduHojs=;
        b=iaJnB4GJfzpWMjIyS8fVo6WbhfcQyHDGbqXRw1MsNysR2Gq8DBanh4DoPd9AVVct8Y
         mem25Qa23+gRT2Bp3v59SGyHZ48/quLw14+n8EDMhd4fn3lgqMA4tnpjOru0n334ckHk
         G1jW3dgyczwvhOwkQPcJz1qPScp0tyjoKvXSwu2gt0to0a4xxt8LwFSnkrnyF/zA/58Z
         0W+dx/lVk6OFugHrN+QPwEn+ZqCMPddsLzU5yvBoNrbG5tsQS6C21HLikTwfGM659Mol
         z3MCD22qtYeFDSkTd9b2rWOX8WMpMvHJ0rIIDM6wb4gYqw0RbvxqaKIHPISMWwWb6a/u
         twew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Yzf75bRCQMALZ7m4QyOplsWHzkaKOssLSVH5NduHojs=;
        b=x32pXL+UrDHJMcHsT7mpnmQlgnO1gG5h3hBMRKwGrm6MZpi7DlIlJmb7axqDHknX/W
         us1ZploFQIwE6qvbCyTyJmeYzxjU1g270bMSTfwRhLrXIwDwY8HmahscKNYN+Iwmt6pE
         T5x7uPoVpGIFCptIki5xOl0FTKV3TUJAFagnpZxPTrI4oex9hKkJ93A+LaJqA9vxJg4G
         DsQN2ohJ00jsu2LTuJW0302A0gTIaqLLnyV//1+c8y41qmB0qccyprI+vBAbANSsQg6m
         tC4XP4jHd1WiO4xCpjuImoeIcm15/m+6Mj5lyCFhuxfGwyYJz5sQIh+1aFfTQVYj6LMq
         6j0Q==
X-Gm-Message-State: ACgBeo1PJwRovghNKHFb15edIK1q5aqgPSMs5srpab4MBuUvFDVksWd6
        eKAekjwz90OsJ89UXxDSxfe45Q==
X-Google-Smtp-Source: AA6agR5MGHH1DtyGdsvEYz+paDTJ51eeo/p/X0YDN79KqsoMoGKdlMLf+ffWE5F5dWWMG3QBLzn0kA==
X-Received: by 2002:a05:6a00:1a44:b0:528:6af7:ff4a with SMTP id h4-20020a056a001a4400b005286af7ff4amr24911716pfv.78.1660078920159;
        Tue, 09 Aug 2022 14:02:00 -0700 (PDT)
Received: from google.com (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79ad9000000b00528f9597fb3sm309872pfp.197.2022.08.09.14.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:01:59 -0700 (PDT)
Date:   Tue, 9 Aug 2022 21:01:55 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Matthew Wilcox <willy@infradead.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Subject: Re: [PATCH] binder_alloc: Add missing mmap_lock calls when using the
 VMA
Message-ID: <YvLLQ/qasEJffdnn@google.com>
References: <20220809160618.1052539-1-Liam.Howlett@oracle.com>
 <YvKsI5pMbgQ5Irup@google.com>
 <20220809190211.ew4taam2lcomramw@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809190211.ew4taam2lcomramw@revolver>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 07:02:17PM +0000, Liam Howlett wrote:
> > 
> > do we need to hold on to the lock while we loop through the pages here?
> 
> I think we do?  Holding this lock will ensure the pages don't go away, I
> believe (looking at mm/rmap.c comments on locking at the top)?
> 
> In any case, this function is called from print_binder_proc_stats()
> which looks to be a debugfs/debugging call so I thought safer would be
> better than faster and with a potential race.

The pages are protected by alloc->mutex, so you could immediately
release the mmap lock after binder_alloc_get_vma() call. I agree this
is a debugging call so it would be nice to reduce contention.
