Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7B2557719
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiFWJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiFWJt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4B5E2DC7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655977796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljQzQy0siBI3YQFBdaVmxjoZw+inMzXrS6RH+F+yiBk=;
        b=WVjZ8CIGOzi+Q2/ECSfZEmwxKqYIPH/nBQsPyCKidmBozkt5QoYRjyRlLauVEgMxWGs6Gn
        Ez3uiLlIOzFRV0kkuDvC4z8uXCW8kv/CIzMyXCzoeikCljGuyVlRueIn75tVGAQ3wvQDG1
        obhtvsfFIkM2rujgxhOh8/SiTtFuISM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-HJKTucGiNGK5w5wCAkfPOw-1; Thu, 23 Jun 2022 05:49:55 -0400
X-MC-Unique: HJKTucGiNGK5w5wCAkfPOw-1
Received: by mail-wr1-f72.google.com with SMTP id r20-20020adfb1d4000000b0021b8507563eso3421706wra.16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ljQzQy0siBI3YQFBdaVmxjoZw+inMzXrS6RH+F+yiBk=;
        b=BaWpCcsGG9WIGx2oaTnlmeY6/MMg9LAnmHbkUymGtALZXoxbm1hYb6NaT/XCR+n+8b
         OuyMR+5LMaN/s88iaGQehkaCtpU10SLe2VVU9H+lbkz0XNhveZYjtrNxFHdoKHn4Ifdr
         t/Dx3jgFFj8V8G/C0kcFTJWl5d+Rn0M9pdDWFNb+hU1fSe0ifrOFNESSR9ZxYbhLXznn
         KFe9YuTHuzaOhcI+ScLvyQEFKXioiXMjctSrbcr8uy37xWj8CDhAI7YYKLalyOAP4CmW
         7zR+daWEM9gHNvkEUx9ik3tVpWE6jdQdhSL2lWi+8r4R7EqJNDW4h0cU+492r3ozL8OA
         WlOA==
X-Gm-Message-State: AJIora8Yp7pkrnAIMTnCIK8GDSb6NCTvyTZBcNq4+L6Z1fKnpMgaxijB
        hhkf55JEuLb5UTTtSi+CmTId3ec6PdHjSrSc4Aj03rUZvHVAb5+niI4vRB9/lB/TsyYId2q3Xsh
        FNcB7nm+FyRLFI/5HWU56SeCY
X-Received: by 2002:a05:6000:1812:b0:21b:adf8:97c0 with SMTP id m18-20020a056000181200b0021badf897c0mr38776wrh.672.1655977794189;
        Thu, 23 Jun 2022 02:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tbqOuglokR/R4NLFp9lzPd0/9wmTmvF86SuMJYyCJLj0XNrqT1N9x6+pt30LWugsIMw39khA==
X-Received: by 2002:a05:6000:1812:b0:21b:adf8:97c0 with SMTP id m18-20020a056000181200b0021badf897c0mr38754wrh.672.1655977793872;
        Thu, 23 Jun 2022 02:49:53 -0700 (PDT)
Received: from localhost ([195.213.152.79])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b0021b881c4c5csm15460836wrv.53.2022.06.23.02.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 02:49:53 -0700 (PDT)
From:   Andrew Burgess <aburgess@redhat.com>
To:     Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: init_disassemble_info() signature changes causes compile failures
In-Reply-To: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
References: <20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de> <CACdoK4LeRPkACejq87VLFgP-b=y1ZoRX3196f7xEVo-UWm8jWA@mail.gmail.com> <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
Date:   Thu, 23 Jun 2022 10:49:51 +0100
Message-ID: <871qvfd800.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Freund <andres@anarazel.de> writes:

> Hi,
>
> On 2022-06-22 23:53:58 +0100, Quentin Monnet wrote:
>> Too bad the libbfd API is changing again :/
>
> Yea, not great. Particularly odd that
> /* For compatibility with existing code.  */
> #define INIT_DISASSEMBLE_INFO(INFO, STREAM, FPRINTF_FUNC, FPRINTF_STYLED_FUNC)  \
>
> was changed. Leaving the "For compatibility with existing code." around,
> despite obviously not providing compatibility...
>
> CCed the author of that commit, maybe worth fixing?

Greetings!

First, massive appologies for breaking you existing code.  I wasn't
aware that the libopcodes disassembler was used by anything out of
tree.

> Given that disassemble_set_printf() was added, it seems like it'd have been
> easy to not change init_disassemble_info() / INIT_DISASSEMBLE_INFO() and
> require disassemble_set_printf() to be called to get styled printf support.

When I did this work I desperately wanted to maintain the original API
as much as possible.  But I couldn't figure out a way for this to work.

The problem is that we now have two classes of disassembler, those that
call the styled printf callback, and those that call the classic
non-styled printf.

When I originally did this work I did want to leave
INIT_DISASSEMBLE_INFO untouched, and provide a default styled printf
that would forward calls to the non-styled printf.

The problem I ran into is that the disassemble_info printf API is not
great.  If the API had passed the disassemble_info* as one of the
arguments then this would have been trivial.  But instead, we only get
passed a 'void *', which is one of the fields of disassemble_info.

As a result there's no easy way to forward calls from this imagined
default styled printf, to the actual, user supplied non-styled printf.

I did consider changing the 'void *' field from being the stream to
write to, to be the disassemble_info*, but then the non-styled printf
calls would need to be updated anyway, which would be a breaking change.

I also considered changing the 'void *' stream to be the
'disassemble_info*', then wrapping both styled and non-styled printf
calls.  This would allow me to provide a default for the styled printf,
and we can pull the required information from the 'disassemble_info*',
but the problem I have now is that the wrapper functions would be a
vararg function, and the user supplied printf functions are also vararg
functions.... and I didn't know how to forward the args from my wrapper
to the user supplied functions without changing the API of the user
supplied functions to take a va_list ... which again is an API breaking
change.

I'm aware that non of the above helps you at all, other than to say, I
didn't make this change without a little thought.  But, that doesn't
mean there isn't a better way this could have been done.  So, if you
have any suggestions, then I'm happy to give them a go.

Once again, sorry for the additional work this has created for you, and
if I can help at all to put this right, then please, do let me know.

Oh, and you're absolutely correct about the comment.  I should have just
deleted it.  Or really, I should have just deleted the macro entirely I
guess and forced everyone to call init_disassemble_info directly.  Bit
late for that now though!

Thanks,
Andrew


>> > The fix is easy enough, add a wrapper around fprintf() that conforms to the
>> > new signature.
>> >
>> > However I assume the necessary feature test and wrapper should only be added
>> > once? I don't know the kernel stuff well enough to choose the right structure
>> > here.
>> 
>> We can probably find a common header for the wrapper under
>> tools/include/. One possibility could be a new header under
>> tools/include/tools/, like for libc_compat.h. Although personally I
>> don't mind too much about redefining the wrapper several times given
>> how short it is, and because maybe some tools could redefine it anyway
>> to use colour output in the future.
>
> I'm more bothered by duplicating the necessary ifdefery than duplicating the
> short fprintf wrapper...
>
>
>> The feature test would better be shared, it would probably be similar
>> to what was done in the following commit to accommodate for a previous
>> change in libbfd:
>> 
>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb982666e380c1632a74495b68b3c33a66e76430
>
> Ah, beautiful hand-rolled feature tests :)
>
>
>> > Attached is my local fix for perf. Obviously would need work to be a real
>> > solution.
>> 
>> Thanks a lot! Would you be willing to submit a patch for the feature
>> detection and wrapper?
>
> I'll give it a go, albeit probably not today.
>
> Greetings,
>
> Andres Freund

