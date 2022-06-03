Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF0653C3C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 06:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiFCEbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 00:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiFCEbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 00:31:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4AD36B71;
        Thu,  2 Jun 2022 21:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=h11mfFrK9QMlt7x6lBFFIFgCiCt5fV9MimCmymWkWMQ=; b=I208srKiAt4VBcE6LOzAteUE5T
        J/iH43L+s9B00CBhtAekBO/BRB8C8jJjTJI3xsF5w53J799Ag5+2/FF8r0CdvrANbNPkI9JO6cGcy
        QcQazxvlASiJBUDptiQ8I9zQHq5k39/ASmiL5L9/q96VeUy49feaoxCMclzLTu+GBYBqW8rZEyQ28
        5XlU1AhGiMUpqUraysO/jc7VPnHyAC3G12eIi+9fGSDkX3ArZH8tA1eicdrEvAzChD+9jTvPmiLgR
        pkVqVG3JlP+zZZYhQvN/Lp0SWjk68HrqrERGDjUd8/Be9EHF6W91pzdMjXXD+smfemW6znXjDsSpV
        vIbyludA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwyxi-004Iu4-JQ; Fri, 03 Jun 2022 04:31:05 +0000
Message-ID: <01bf93d3-06c4-594e-e3c6-b6f56a1efa83@infradead.org>
Date:   Thu, 2 Jun 2022 21:30:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1] module: Fix prefix for module.sig_enforce module param
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, Allen Pais <allen.lkml@gmail.com>,
        Joe Perches <joe@perches.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20220322140344.556474-2-atomlin@redhat.com>
 <20220602035653.4167316-1-saravanak@google.com>
 <YpkMelZC+E5hKTw6@bombadil.infradead.org>
 <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
 <CAGETcx9f5BiojqU6wr29eUrYr9s8k+CGj_t-7RvrTSmDm6WwJw@mail.gmail.com>
 <YplAxCvRiNnthK6d@bombadil.infradead.org>
 <CAGETcx-gEbH2ymx7FXCXZNt3p=r=5FXuhLUiMuNvofcb1HXysA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAGETcx-gEbH2ymx7FXCXZNt3p=r=5FXuhLUiMuNvofcb1HXysA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/2/22 20:48, Saravana Kannan wrote:
> On Thu, Jun 2, 2022 at 3:59 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> On Thu, Jun 02, 2022 at 02:47:04PM -0700, Saravana Kannan wrote:
>>> On Thu, Jun 2, 2022 at 12:41 PM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>> On Thu, Jun 2, 2022 at 12:16 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>>>
>>>>> Linus want to take this in or should I just queue these up?
>>>>
>>>> I'll take it, and remove the unnecessary #ifdef/#endif. The #undef
>>>> might as well be unconditional - simpler and doesn't hurt.
>>>
>>> Sounds good. I just copy-pasted how it was done elsewhere. Luis was
>>> mentioning adding a wrapper to go this cleanly and I needed it in
>>> another instance too. So I'll look into doing that in a future patch.
>>
>> Virtual hug, or something hippie like that.
> 
> Thanks :)
> 
> I gave this a shot.
> 
> + #define set_module_param_prefix(prefix) \
> + #undef MODULE_PARAM_PREFIX              \
> + #define MODULE_PARAM_PREFIX prefix
> 
> I even wrote up a nice chunk of "function doc" before I tried
> compiling it. And once I compiled it, I was smacked in the head by the
> compiler for trying to put a #define inside a #define (Duh, the
> preprocessing in a single pass).
> 
> Before I tried this, I looked up the current uses of the "hacky" snippet:
> 
> $ git grep -l "define.*MODULE_PARAM_PREFIX" -- :^include/
> block/disk-events.c
> drivers/misc/cxl/fault.c
> drivers/mmc/core/block.c
> drivers/pci/pcie/aspm.c
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> drivers/tty/serial/8250/8250_core.c
> drivers/xen/balloon.c
> drivers/xen/events/events_base.c
> kernel/debug/kdb/kdb_main.c
> kernel/kcsan/core.c
> kernel/rcu/tree.c
> kernel/rcu/update.c
> mm/damon/reclaim.c
> mm/kfence/core.c
> 
> 
> In a lot of those files, there are a lot of module params that follow
> this snippet. Going on a tangent, some of the uses of #define
> MODULE_PARAM_PREFIX don't seem to have any obvious use or param
> macros.
> 
> So adding a module_param_prefixed() doesn't make sense to me either,
> because I'll have to repeat the same prefix in every usage of
> module_param_prefixed() AND I'll have to create a _prefixed() variant
> for other param macros too.
> 
> So, something like:
> module_param_prefixed("module.", sig_enforce, bool, 644);
> module_param_prefixed("module.", another_param1, bool, 644);
> module_param_prefixed("module.", another_param2, bool, 644);
> 
> Or replace "module." with a MY_PREFIX so that it's easy to ensure the
> string is the same across each use:
> #define MY_PREFIX "module."
> module_param_prefixed(MY_PREFIX, sig_enforce, bool, 644);
> module_param_prefixed(MY_PREFIX, another_param1, bool, 644);
> module_param_prefixed(MY_PREFIX, another_param2, bool, 644);
> 
> But at that point, all I'm avoiding is one #undef MODULE_PARAM_PREFIX
> and a whole lot of code churn.
> 
> One other option is to do something like:
> #ifndef MOD_PREFIX
> #define MODULE_PARAM_PREFIX KBUILD_MODNAME "."
> #else
> #define MODULE_PARAM_PREFIX MOD_PREFIX "."
> #endif
> 
> But that will have the limitation that MOD_PREFIX has to be defined
> before any #includes is in a file (similar to pr_fmt())  and doesn't
> allow you to redefine the prefix half way through a file -- which is
> also a thing that happens in drivers/tty/serial/8250/8250_core.c.
> 
> So, long story short, none of these options sound especially appealing
> that it's worth all the code churn across multiple maintainer trees.
> Let me know if you have other ideas that might work or you think one
> of the options I dismissed is actually worth doing.

I agree with your assessment. Nothing new is needed.

-- 
~Randy
