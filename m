Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E97491005
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbiAQSFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:05:21 -0500
Received: from relay038.a.hostedemail.com ([64.99.140.38]:19625 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242087AbiAQSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:05:19 -0500
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id F0F6325307;
        Mon, 17 Jan 2022 18:05:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 817716000E;
        Mon, 17 Jan 2022 18:05:07 +0000 (UTC)
Message-ID: <e67388e4bdd25ca5ccb4cf20df0527d82ba31277.camel@perches.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
From:   Joe Perches <joe@perches.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Jan 2022 10:05:15 -0800
In-Reply-To: <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
         <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
         <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
         <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
         <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
         <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 817716000E
X-Spam-Status: No, score=-2.18
X-Stat-Signature: sggpbsqu86ytmdasds6m67ecweokaouf
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+TONOwT8Ea+r8Fe4q7nQp8jsSucvMhp3w=
X-HE-Tag: 1642442707-812029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-17 at 13:47 +0100, Jason A. Donenfeld wrote:
> Hey again,

Rehi.

> Four years later I went through basically the same motions: "oh hey I
> should clean this up", "I'll start with clang format", "oh cool it
> adds spaces before the iterator paren so it looks like a normal for
> loop to me", "that seems so reasonable; I love clang format", "oh no
> checkpatch.pl complains; I hope it's wrong", "I wonder if anybody has
> thought about this before", "oh, look, I asked about this already in
> 2018."

Original thread:

https://lore.kernel.org/lkml/CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com/

> So, here we are again. I'm wondering:
> - Can we switch to spaces before iterator parens?

Still doubtful because the kernel sources has ~150:1 preference
for no space, and it's still just a whitespace convention...

$ git grep -P '\b\w*for_each\w*\(' | wc -l
31920
$ git grep -P '\b\w*for_each\w*\s+\(' | wc -l
196

> - If not, is clang-format ever going to be fixed to quit adding them?

Doubtful as it's likely the .clang-format for_each list is
just out of date for your particular for_each type use and
the scripted bit that it uses to create them hasn't be
updated in awhile.  Also that scripted bit only works on files
in include/ and not anything locally defined.

in .clang-format:

# Taken from:
#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ \
#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'," \
#   | sort | uniq

commit 4792f9dd12936ec35deced665ae3a4ca8fe98729
Author: Miguel Ojeda <ojeda@kernel.org>
Date:   Wed May 12 23:32:39 2021 +0200

    clang-format: Update with the latest for_each macro list
    
    Re-run the shell fragment that generated the original list.
    
    Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

checkpatch basically just looks for any use of 'for_each'

(?:[a-z_]+|)for_each[a-z_]+)

So it has false positives for some functions and not macros.


