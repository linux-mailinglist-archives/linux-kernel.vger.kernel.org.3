Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292C9552244
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbiFTQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243785AbiFTQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:28:43 -0400
X-Greylist: delayed 2401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Jun 2022 09:28:42 PDT
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F47BE0C;
        Mon, 20 Jun 2022 09:28:42 -0700 (PDT)
Received: from [10.2.12.24] (unknown [10.2.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 549661842F6F;
        Mon, 20 Jun 2022 17:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1655737904; bh=UqBZTWQhX1oGqwuuGk9ArGFlxBsKUZyh+tzOazjtW9s=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=bOAzh2IFJWlWBZypDTa0e5IixUmK4ODxJw2v/sUawktoEQv/WpwcVc3LTrMbtQHhF
         elnL57V0cO+lBHvFupyfUQQnTg4lArzlyPePP/ZUZOKyBBGv1uTDYimPzaXnBf04HK
         xyx9I2GtQpi6lx7toDHyNw8pQLpR57FT+sUwMkWU=
Message-ID: <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
Date:   Mon, 20 Jun 2022 17:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: oliver+list@schinagl.nl
Subject: Re: [PATCH 00/13] [RFC] Rust support
Content-Language: en-US
To:     ojeda@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        oliver+list@schinagl.nl
References: <20210414184604.23473-1-ojeda@kernel.org>
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <20210414184604.23473-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Miguel and others,

Having followed this for a while, I finally decided it best to at least 
share some thoughts in the hopes to make life better for us with some 
readability/accessibility issues, such as dyslexia for example.

I apologize for being late to the party and for potentially using the 
wrong thread, but I recall somewhere in v5 that it was best to respond 
to the RFC for general comments.

On 14-04-2021 20:45, ojeda@kernel.org wrote:
> From: Miguel Ojeda <ojeda@kernel.org>
> 
> Some of you have noticed the past few weeks and months that
> a serious attempt to bring a second language to the kernel was
> being forged. We are finally here, with an RFC that adds support
> for Rust to the Linux kernel.
> 
> This cover letter is fairly long, since there are quite a few topics
> to describe, but I hope it answers as many questions as possible
> before the discussion starts.
> 

<snip>

> 
> Moreover, as explained above, we are taking the chance to enforce
> some documentation guidelines. We are also enforcing automatic code
> formatting, a set of Clippy lints, etc. We decided to go with Rust's
> idiomatic style, i.e. keeping `rustfmt` defaults. For instance, this
> means 4 spaces are used for indentation, rather than a tab. We are
> happy to change that if needed -- we think what is important is
> keeping the formatting automated

Enforcing this is great, but how will you enforce this 'everywhere'? 
Right now, you can easily 'bypass' any CI put in place, and while 'for 
now' this is only about the Rust infra, where this can be strongly 
enforced, once we see actual drivers pop-up; these won't go through the 
Rust CI before merging CI forever? A maintainer can 'just merge' 
something still, right?

Anyway, what I wanted to criticize, is the so called "keeping with 
`rustfmt` defaults". It has been known, that, well Rust's defaults are 
pretty biased and opinionated. For the Rust project, that's fair of 
course, their code, their rules.

However, there's two arguments against that. For one, using the Rust 
'style', now means there's 2 different code styles in the Kernel. 
Cognitively alone, that can be quite frustrating and annoying. Having to 
go back and forth between two styles can be mentally challenging which 
only causes mistakes and frustration. So why change something that 
already exists? Also, see my first point. Having to constantly 
remember/switch to 'in this file/function the curly brace is on a 
different line'. Lets try to stay consistent, the rules may not be 
perfect (80 columns ;), but so far consistency is tried. OCD and Autism 
etc doesn't help with this ;)

Secondly, and this is really far more important, the Rust default style 
is not very inclusive, as it makes readability harder. This has been 
brought up by many others in plenty of places, including the `rustfmt` 
issue tracker under bug #4067 [0]. While the discussion eventually only 
led to the 'fmt-rfcs' [1], where it was basically said 'you could be on 
to something, but this ship has sailed 3 years ago (when nobody was 
looking caring), and while we hear you, we're not going to change our 
defaults anymore.

But I also agree and share these commenters pain. When the tab character 
is used for indenting (and not alignment mind you), then visually 
impaired (who can still be amazing coders) can more easily read code by 
adjusting the width what works best to them.

With even git renaming `master` to `main` to be more inclusive, can we 
also be more inclusive to us that have a hard time distinguishing narrow 
indentations?

Thanks, and sorry for rubbing any ones nerves, but to "some of us" this 
actually matters a great deal.

Olliver

P.S. would we expect inline C/Rust code mixed? What then?


<snip>

[0]: https://github.com/rust-lang/rustfmt/issues/4067#issuecomment-685961408
[1]: 
https://github.com/rust-dev-tools/fmt-rfcs/issues/1#issuecomment-911804826
