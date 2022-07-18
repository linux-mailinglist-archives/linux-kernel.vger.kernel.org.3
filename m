Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9A577BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiGRG4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiGRG4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:56:20 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1C41659E;
        Sun, 17 Jul 2022 23:56:17 -0700 (PDT)
Received: from [10.2.12.24] (unknown [10.2.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id A15BE1854C79;
        Mon, 18 Jul 2022 08:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1658127375; bh=pDIZI5+3ZaY8w1kvJ6Hn5NAeNyo0zewyITfCXLpRXvo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=G20NuvpRGxhGBynBq/IG3TYChKLPc66QgWMoIp+pTbxBbT+NSRJuk3hr5tWSV/yGs
         juQSH+vnQ+GyDLT1rx5L6p87B3WUch+43IuPMlSWXH3j13Bb1oDTX4CW6bnjc+Xml0
         2+gY9E6KlHvfqqL5JUJYmi2g3MXzz+OWUx2DMJj0=
Message-ID: <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
Date:   Mon, 18 Jul 2022 08:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/13] [RFC] Rust support
Content-Language: nl
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
From:   Olliver Schinagl <oliver+list@schinagl.nl>
In-Reply-To: <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Miguel,

Sorry for the late reply ;)

On 27-06-2022 19:44, Miguel Ojeda wrote:
> Hi Olliver,
> 
> On Mon, Jun 20, 2022 at 5:11 PM Olliver Schinagl <oliver@schinagl.nl> wrote:
>>
>> I apologize for being late to the party and for potentially using the
>> wrong thread, but I recall somewhere in v5 that it was best to respond
>> to the RFC for general comments.
> 
> No need to apologize! Feel free to use the latest threads or a new
> thread in e.g. the rust-for-linux ML.
> 
>> On 14-04-2021 20:45, ojeda@kernel.org wrote:
>>> From: Miguel Ojeda <ojeda@kernel.org>
>>>
>>> Moreover, as explained above, we are taking the chance to enforce
>>> some documentation guidelines. We are also enforcing automatic code
>>> formatting, a set of Clippy lints, etc. We decided to go with Rust's
>>> idiomatic style, i.e. keeping `rustfmt` defaults. For instance, this
>>> means 4 spaces are used for indentation, rather than a tab. We are
>>> happy to change that if needed -- we think what is important is
>>> keeping the formatting automated
>>
>> Enforcing this is great, but how will you enforce this 'everywhere'?
>> Right now, you can easily 'bypass' any CI put in place, and while 'for
>> now' this is only about the Rust infra, where this can be strongly
>> enforced, once we see actual drivers pop-up; these won't go through the
>> Rust CI before merging CI forever? A maintainer can 'just merge'
>> something still, right?
> 
> Indeed, but there are workarounds, for instance, we could have a bot
> checking -next.
Absolutly, but with the many luitenants, many tree's, and not a single 
CI source, this would still be tricky in the end; but certainly possible.

> 
> Or we could put it in an opt-in compilation mode (i.e. not for users)
> where extra things are checked (like `W=`) that maintainers use so
> that e.g. `allmodconfig` builds are kept clean.
> 
>> Anyway, what I wanted to criticize, is the so called "keeping with
>> `rustfmt` defaults". It has been known, that, well Rust's defaults are
>> pretty biased and opinionated. For the Rust project, that's fair of
>> course, their code, their rules.
>>
>> However, there's two arguments against that. For one, using the Rust
>> 'style', now means there's 2 different code styles in the Kernel.
>> Cognitively alone, that can be quite frustrating and annoying. Having to
>> go back and forth between two styles can be mentally challenging which
>> only causes mistakes and frustration. So why change something that
>> already exists? Also, see my first point. Having to constantly
>> remember/switch to 'in this file/function the curly brace is on a
>> different line'. Lets try to stay consistent, the rules may not be
>> perfect (80 columns ;), but so far consistency is tried. OCD and Autism
>> etc doesn't help with this ;)
> 
> Note that the point of using `rustfmt` is that one does not need to
> care about the details -- one can e.g. run the tool on file save. So
> no need to remember how to do it when writing Rust.
And that's great of course, I was mearly speaking of the configuration 
of rustfmt. I think as a tool it's pretty great!

> 
> Now, it is true that the Rust syntax resembles C in many cases, so
> things like the curly braces for function definitions are similar
> enough that we could do the same thing in both sides.
> 
> However, most Rust code uses `rustfmt` and typically also follow most
> of its defaults, including the standard library, books, etc.; which
> helps when reading and reusing other code. This is different from C
> and C++, where as you know there is no single style (at least as
> prevalent as `rustfmt`), thus one needs to become accustomed to each
> project's C style (or ideally use `clang-format` to avoid having to
> learn it). So while this is not relevant for C, in the case of Rust,
> there is value in using the `rustfmt` style.
I think this is a pretty poor argument for following Rust's opinionated 
view of the world. E.g. it's generally bad to copy/paste code to begin 
with. How many 'bugs' that we know of are copy/paste bugs?

Secondly, and more importantly so; you argue 'who cares about people 
with disablements, atleast its equally hard to read everywhere' which is 
a very poor argument :p

Finally, it must of course be mentioned, that rust is really trying to 
do an XKCD here, https://xkcd.com/927/ though I'm sure we'll get it 
right this time around ;)

> 
> As for consistency, one could argue that by using `rustfmt` we are
> being consistent with the rest of the Rust code out there.
But you are not, only those that follow rust's biased view. Everybody 
else that has a different opinion (like die-hard C programmers) that 
care enough (I'm sure there's plenty) would setup their rustfmt config 
file to resemble their C code; and thus the entire premisis is broken. 
Though; yes, in a perfect world it could have worked like this, but xkcd 
again :)

> This may be
> important for those that have expressed interest on sharing some code
> between kernel and userspace; as well as if we end up vendoring some
> external crates (similar to what we do with `alloc` now).
This though is a fair argument I understand, it would be weird in having 
2 styles in user-space and kernel-space code; though I see this 
happening today as well; where developers follow kernel style for kernel 
code (obviously) but use their preferred 2 or 3 space style on their 
userland code. Trying to 'force' this, usually however never gets the 
intended result ...

> 
>> Secondly, and this is really far more important, the Rust default style
>> is not very inclusive, as it makes readability harder. This has been
>> brought up by many others in plenty of places, including the `rustfmt`
>> issue tracker under bug #4067 [0]. While the discussion eventually only
>> led to the 'fmt-rfcs' [1], where it was basically said 'you could be on
>> to something, but this ship has sailed 3 years ago (when nobody was
>> looking caring), and while we hear you, we're not going to change our
>> defaults anymore.
>>
>> But I also agree and share these commenters pain. When the tab character
>> is used for indenting (and not alignment mind you), then visually
>> impaired (who can still be amazing coders) can more easily read code by
>> adjusting the width what works best to them.
>>
>> With even git renaming `master` to `main` to be more inclusive, can we
>> also be more inclusive to us that have a hard time distinguishing narrow
>> indentations?
> 
> As noted in the RFC, we are happy to tweak the style to whatever
> kernel developers prefer. We think the particular style is not that
> important. Absent other reasons, the defaults seem OK, so we chose
> that for simplicity and consistency with as most existing Rust code as
> possible.
> 
> As for accessibility, I am no expert, so that may be a good point,
> especially if editors cannot solve this on their end (so that everyone
> could program in all languages/projects regardless of style).
Yeah, this is a common reasoning. People without disabilities often 
oversee cases to those with. E.g. Traffic lights being red and green is 
horrible for colorblind people; luckily enough we have 'order' to help 
distinguish there for example. While I'm not colorblind myself, I often 
have to remind UX designers, with their fancy LED based UI's, to think 
of others as well, which always strikes them as odd first, then of 
course they only start to realize this.

I'm with you that style is the least important for the functionality, no 
argument there. Long-term though; this will matter of course, to those 
like me, have hard times here.

> 
>> Thanks, and sorry for rubbing any ones nerves, but to "some of us" this
>> actually matters a great deal.
> 
> No nerves were damaged :) Thanks for all the input!
> 
>> P.S. would we expect inline C/Rust code mixed? What then?
> 
> Everything is possible, e.g. we could have Rust proc macros that parse
> C and things like that. But if we ended up with such a thing, the
> solution would be to format each accordingly to its style (indentation
> could be an exception, I guess).
The first exception to the rule starts here already :p

Thanks for your thoughts,

Olliver
> 
> Cheers,
> Miguel

