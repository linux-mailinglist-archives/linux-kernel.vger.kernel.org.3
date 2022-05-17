Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB552ADA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiEQVoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiEQVoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:44:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818C750445;
        Tue, 17 May 2022 14:43:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652823829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=38MBY5TPzPDWJJ7wfIQbCIMC4tpzXNoTQctp5Q2omdE=;
        b=qZ3I2loQXge4Fi5CVcicg69+ghn9lriVgyi3NPWmWzPAuEX4KXYC/io9C4AXS96a19FZvx
        sk1Umv9m5xJUUCYUQidygcv20wzvES58fTIPGUWt0HIL1u/BmyZdNqbM5FBXKK5ZXJIU0o
        IwORWcFZnh1x4G9pJZ42qKzguh2Xm6q6vcOIWCmplWNOrx00Xh8cYmEN3xKCCQJ0r+c5jw
        +zXFQBy0yHB/DcGyPRPBTS9NrvwdKbO349DVwwFkmaupoE5CSeEK+sbcC3lOXhDL/FPGr3
        VHXaGq808dpm0+s5+EGiQ7S1/uOkK2esRwO6IJSSDj5CRwxKkfdO+o168nD1KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652823829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=38MBY5TPzPDWJJ7wfIQbCIMC4tpzXNoTQctp5Q2omdE=;
        b=if0dLSyC9FrNTNSWRenQex+bMgszw9+Et1v5yB1Ku/+X13/fdyfRbbOCPfr0sAhB0cGrJk
        aExYqttNsV6KH+AA==
To:     Max Mehl <max.mehl@fsfe.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-spdx@vger.kernel.org
Subject: Re: [patch 0/9] scripts/spdxcheck: Better statistics and exclude
 handling
In-Reply-To: <1652775347.3cr9dmk5qv.2220@fsfe.org>
References: <20220516101901.475557433@linutronix.de>
 <1652706350.kh41opdwg4.2220@fsfe.org> <87zgjhpawr.ffs@tglx>
 <87wnelpam3.ffs@tglx> <1652775347.3cr9dmk5qv.2220@fsfe.org>
Date:   Tue, 17 May 2022 23:43:49 +0200
Message-ID: <8735h7ltre.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17 2022 at 10:25, Max Mehl wrote:
> ~ Thomas Gleixner [2022-05-16 20:59 +0200]:
>> There is also an argument to be made whether we really need to have SPDX
>> identifiers on trivial files:
>> 
>> #include <someheader.h>
>> <EOF>
>> 
>> Such files are not copyrightable by any means. So what's the value of
>> doubling the line count to add an SPDX identifier? Just to make nice
>> statistics?
>
> We agree that such files are not copyrightable. But where is the
> threshold? Lines of code? Creativity? Number of used functions? And how
> to embed this threshold in tooling? So instead of fuzzy exclusion of
> such files in tools like spdxcheck or REUSE, it makes sense to treat
> them as every other file with the cost of adding two comment lines.
>
> This clear-cut rule eases maintaining and growing the effort you and
> others did because developers would know exactly what to add to a new
> file (license + copyright) without requiring looking up the thresholds
> or a manual review by maintainers who can interpret them.

Seriously no. I'm outright refusing to add my copyright to a trivial
file with one or two includes or a silly comment like '/* empty because */.

     There is nothing copyrightable there.

I'm not going to make myself a fool just to make tools happy, which can
figure out on their own whether there is reasonable content in the vast
majority of cases.

Also you need some exclude rules in any case. Why?

  - How do you tell a tool that a file is generated, e.g. in the kernel
    the default configuration files?

    Yes, the file content depends on human input to the generator tool,
    but I'm looking forward for the explanation how this is
    copyrightable especially with multiple people updating this file
    over time where some of the updates are just done by invoking the
    generator tool itself.

  - How do you tell a tool that a file contains licensing documentation?

    Go and look what license scanners make out of all the various
    license-rules.rst files.

  - ....

  Do all scanners have to grow heuristics for ignoring the content past
  the topmost SPDX License identifier in certain files or for figuring
  out what might be generated content?

You also might need to add information about binary blobs, which
obviously cannot be part of the binary blobs themself.

The exclude rules I added are lazy and mostly focussed on spdxcheck, but
I'm happy to make them more useful and let them carry information about
the nature of the exclude or morph them into a general scanner info
which also contains binary blob info and other helpful information. But
that needs a larger discussion about the format and rules for such a
file.

That said, I'm all for clear cut rules, but rules just for the rules
sake are almost as bad as no rules at all.

As always you have to apply common sense and look at the bigger picture
and come up with solutions which are practicable, enforcable and useful
for the larger eco-system.

Your goal of having SPDX ids and copyright notices in every file of a
project is honorable, but impractical for various reasons.

See above.

Aside of that you cannot replace a full blown license scanner by REUSE
even if your project is SPDX and Copyright notice clean at the top level
of a file. You still need to verify that there is no other information
in a 'clean' file which might be contradicting or supplemental. You
cannot add all of this functionality to REUSE or whatever.

Thanks,

        tglx
