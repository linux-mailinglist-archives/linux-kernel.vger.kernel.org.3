Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FB4A6E0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiBBJrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiBBJrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:47:42 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E03C061714;
        Wed,  2 Feb 2022 01:47:42 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nFCEm-0002jG-6d; Wed, 02 Feb 2022 10:47:40 +0100
Message-ID: <a41bb41e-1a3e-a6eb-be31-3fe94e7f7db6@leemhuis.info>
Date:   Wed, 2 Feb 2022 10:47:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-BS
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1643710947.git.linux@leemhuis.info>
 <e655527632dc4324cc7584cb3a73880d9c733df5.1643710947.git.linux@leemhuis.info>
 <87fsp25g28.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v4 2/3] docs: regressions*rst: rules of thumb for handling
 regressions
In-Reply-To: <87fsp25g28.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1643795262;13038e33;
X-HE-SMSGID: 1nFCEm-0002jG-6d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.22 00:21, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
> One thing that caught my eye this time around...
> 
>> + * Address regressions in stable, longterm, or proper mainline releases with
>> +   more urgency than regressions in mainline pre-releases. That changes after
>> +   the release of the fifth pre-release, aka "-rc5": mainline then becomes as
>> +   important, to ensure all the improvements and fixes are ideally tested
>> +   together for at least one week before Linus releases a new mainline version.
> 
> Is that really what we want to suggest?  I ask because (1) fixes for
> stable releases need to show up in mainline first anyway, and (2) Greg
> has often stated that the stable releases shouldn't be something that
> most maintainers need to worry about.  So if the bug is in mainline,
> that has to get fixed first, and if it's something special to a stable
> release, well, then the stable folks should fix it :)

Hmmm. Well, afaics in the end many (most?) of the regressions that
happen in these series are present in mainline as well: either they
where introduced in an earlier devel cycle or came with a backport to
stable/longterm and thus are present in mainline as well (unless the
backport was incomplete or broken). So I'd say it's up to the regular
developers and not the stable team to fix many (most?) of them.

That being said: yes, I think you have a point. This could be fixed with
some small adjustments to the wording above, but...

>> + * Fix regressions within two or three days, if they are critical for some
>> +   reason -- for example, if the issue is likely to affect many users of the
>> +   kernel series in question on all or certain architectures. Note, this
>> +   includes mainline, as issues like compile errors otherwise might prevent many
>> +   testers or continuous integration systems from testing the series.

...the same aspect is relevant for other points like this one, too. And
there it's not as easily solved. So maybe this is better addressed with
a separate point early in the list:

```
* Developers are expected to handle regressions in all kernel series,
but are free to leave them to the stable team, if the regression
probably at no point in time occurred with mainline.
```

Regressions for example caused by incomplete or broken backports thus
would be something developers could leave to Greg (and I expect he won't
mind).

>> + * Aim to merge regression fixes into mainline within one week after the culprit
>> +   was identified, if the regression was introduced in a stable/longterm release
>> +   or the development cycle for the latest mainline release (say v5.14). If
>> +   possible, try to address the issue even quicker, if the previous stable
>> +   series (v5.13.y) will be abandoned soon or already was stamped "End-of-Life"
>> +   (EOL) -- this usually happens about three to four weeks after a new mainline
>> +   release.
> 
> How much do we really think developers should worry about nearly-dead
> stable kernels?  We're about to tell users they shouldn't be running the
> kernel anyway...

I'd expect we handle near EOL stable release round about normally until
they become EOL. But anyway, I had something different in mind when I
wrote the above and I get the feeling my text didn't express it well and
got you on the wrong track. :-/

My intention was: I want to prevent users getting stuck on EOLed stable
series (say 5.13.y) when a regression makes it hard or impossible for
the user to run the directly succeeding stable series (5.14.y).

I think this expresses it better:

```
* Aim to merge regression fixes into mainline within one week after the
culprit was identified, if the regression was introduced in either:

  * the development cycle of the latest proper mainline release

  * a recent release in a stable/longterm series

  Try to address regressions in the latest stable series even quicker,
if the previous series will be abandoned soon or already was stamped
"End-of-Life" (EOL) -- this usually happens about three to four weeks
after a new mainline release.

  Remember to mark the fix for backporting by using both the ``Fixes:``
tag and ``Cc: stable@vger.kernel.org``.
```

How does that sound?

Thx for the feedback, it's good that these things turned up.

Ciao, Thorsten
