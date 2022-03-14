Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE34D8E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 22:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbiCNVKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 17:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiCNVKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 17:10:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A746E0F6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:08:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 19so10084119wmy.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=onRiKUxqxTpyz6xmpPtyIH/p/E/1zKXRASWvdcQSPZI=;
        b=jq8Jv71y2M8KBXfZFfeFOrxZWXiIf59Pp9I2uiHQJKvhzLxrxoZFwarFgeJnMZFYZh
         G6woRIFKieK8tPoFzqMO6YXhAkO+me90TUA66ZC+dx2/lvKIN46Pke99ZM3zlRqiwnmn
         NHX40t8F09tKxPjijwuH58kNViOUHN99sQ2YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onRiKUxqxTpyz6xmpPtyIH/p/E/1zKXRASWvdcQSPZI=;
        b=q1+5LT4CdQwnqGyIzOb78aD86yrQ/q3edGoPGu7Xx7UNpOTpOlW4vZsOKSRcUqBdOl
         GsVebpMrc/bwa2SmAIyPQRelPJM35anLF1gMRY26BxJBRwu7CcgjlpLmy8i7jeTxxzrV
         S0z5qXJPoav3BBOdUwBQA+Ual39GW95yXl+/7Uo+beQrgJ9A033gZDMT7K6pQQhynncH
         oLzYU+iFbXgPuXpKcqjFNq3K2hnKCYmDa7+YCyLXIX4Q8j9kRASUJMCIX8Ku8Z3le7PS
         UU9KVmOLf4nCqRPKiOWCG9fOIl7/0KHfgYpuNoSdD5eDQrdsEvBpYqbbPEjLDPgDyD8i
         cGvw==
X-Gm-Message-State: AOAM53252FVJMjT2ECpVOf9RJKcz+lWFCS6I3B6ZBZLda9b6v6ykpXA7
        +AN3oLvV2Ahx1qevafLYaJEEow==
X-Google-Smtp-Source: ABdhPJzX8jTnDaYoB4AC5+83XFsomeyAdGycJjrabKIOrVkyLQQ7Ss2sr43LQ+PTLiaN4bOSN0WEuw==
X-Received: by 2002:a05:600c:4284:b0:389:c472:e05e with SMTP id v4-20020a05600c428400b00389c472e05emr772472wmc.19.1647292131761;
        Mon, 14 Mar 2022 14:08:51 -0700 (PDT)
Received: from xavier-xps ([2a01:e0a:830:d971:cc11:3255:8bf2:4a49])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b0020373b34961sm13883058wrs.66.2022.03.14.14.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 14:08:51 -0700 (PDT)
Date:   Mon, 14 Mar 2022 22:08:49 +0100
From:   Xavier Roche <xavier.roche@algolia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jean Delvare <jdelvare@suse.de>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v3] tmpfs: support for file creation time
Message-ID: <20220314210849.GA121935@xavier-xps>
References: <20220211213628.GA1919658@xavier-xps>
 <20220211213628.GA1919658@xavier-xps>
 <CAHk-=wh1oc0=YuMJCnjV_aY4FswtWk3OeO4-SEbCmAXGkAfDPA@mail.gmail.com>
 <b925ce4f-e9a4-92e6-6a95-6c718cfcb134@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b925ce4f-e9a4-92e6-6a95-6c718cfcb134@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 12:17:30PM -0800, Hugh Dickins wrote:
> Please ignore this patch for now: I presume Xavier did not understand
> the "from akpm to Linus in next merge window" flow, and thought he had
> to resend the patch to you.

I will resend a fixed v4 version in a moment, sorry for the noise (and
I indeed did not fully understand the flow).

> > And finally - if we really want to treat btime as a first-class entity
> > and expect things like tmpfs to support it, then we should just bite
> > the bullet and put it in 'struct inode' along with the other times.
> I've no objection if someone does that later.

I might give it a try if this is something that can be of interest.

The idea of having btime in 'struct inode' would make the btime a
first-class citizen, allowing to have more consistent (w.r.t filesystem
types) behavior.

This would also mean allowing to _change_ it, typically to allow archivers
to set the creation time as they do for {a,c,m}time.

Currently, birth time semantic is bound to the current filesystem's
life cycle and as such is irrelevant after a restore, or a 'tar xf'.

The only gray area to me is whether or not we "can" always change this
property without unforeseen consequences, typically for ext4.
