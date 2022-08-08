Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57A258CB25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbiHHPRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbiHHPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:15:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7324325ED
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:15:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 17so6655282qky.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=K+OJZaD6BfpKIEcZ76iDI7EwR6C1BGBUKKfMXoH29ZQ=;
        b=fQrKqqiaQQ7LKUZcKX24GDSIszjlOtO/68ziq/UZO2iXEqvse4bpklHULolRTPqAzi
         3JQd+4K6lpM8Fg24QjvcpmV/DfS3yL3hE3mQ4lyzAXrBHnhEUmK7S2yj03BFIF2d35iS
         btvEiwdYmEWTq0ZQzjin0wLHIk7oPzSTVRFJN1I85a1RGytM9fl8lK+jr1XrNbj4ZxqN
         jU0Bw8pgwlvJPvRT+K8EQN9EcIK34rsliq9SCPSq9hDwnDOoTdeCglSNyDLDxv0ozuzw
         jULhrcLhcRwOKLmI3HVd08RoMiPIThv3NiqHhwTlmrb2VX1N6rLme7depPBi+mAoTeJE
         2c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=K+OJZaD6BfpKIEcZ76iDI7EwR6C1BGBUKKfMXoH29ZQ=;
        b=QuLVjJBoLpiOz16+yRRN7jlwlsLWfkuGuijtW8fUf0j8vs0K5/PF+P6I0h15LqRuZr
         4pNXfrkwqzB9MAvYSl8C4yk5IJZCIi89MMRX9i15J1n/cNXjLvX9sLooJvL0MD25jorw
         JjxtkCzYrrwR1RQ2a/SpStrJXlobUu/H29E6CGcvThucw+x5waH+SHIEuDPc2bf0t/gF
         sfHlsi49SYp9U0H3CJ8TvmqYxfDDR4VE1iASV6ahYIzq+1GYuGzLnM7vVNfQn4bvng37
         ZNvnATw/1tnYl3BXnfhFo/IiaCr07zS8zQmE7DqJo3w5VkE6U2MbRXCZ+0gFVdeBVPkf
         4iHQ==
X-Gm-Message-State: ACgBeo0uRJoVR2cXSD/HrltZ3FUT7V2j7h91pkF+NgSYp/2wlD4XIYIJ
        eSHP7XogbJtKN0G4lkhw9w==
X-Google-Smtp-Source: AA6agR550gq47qy8bwKsftDi+9ltjRf3/b6LbcCpEfw1jf9ADcVd28VHTxJTqkpL/i413B7VklC5rA==
X-Received: by 2002:a05:620a:4403:b0:6b5:e1ad:75a7 with SMTP id v3-20020a05620a440300b006b5e1ad75a7mr14585657qkp.177.1659971733171;
        Mon, 08 Aug 2022 08:15:33 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j18-20020a05620a411200b006b5cb5d2fa0sm9916618qko.1.2022.08.08.08.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 08:15:32 -0700 (PDT)
Message-ID: <55e6e42f-b3ea-d9d0-4611-f13b3b88acab@gmail.com>
Date:   Mon, 8 Aug 2022 11:15:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v5 31/32] tracing: Convert to printbuf
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        Ingo Molnar <mingo@redhat.com>
References: <20220808024128.3219082-1-willy@infradead.org>
 <20220808024128.3219082-32-willy@infradead.org>
 <20220807225113.6a74b481@gandalf.local.home>
 <8e1df054-062f-63c9-16b4-38143f3e7983@gmail.com>
 <20220808093750.4dd24af2@gandalf.local.home>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20220808093750.4dd24af2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 09:37, Steven Rostedt wrote:
> On Sun, 7 Aug 2022 23:32:01 -0400
> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
>>> Please remove the two tracing patches and the deletion of the seq_buf from
>>> the series.
>>
>> Well, that's not really an option, as Christoph already (rightly)
>> pointed out.
> 
> These are the last patches of the series. There's no dependency on them.
> You should be able to simply drop them. If others find that these patches
> are worth their while then by all means, let them have them.
> 
>>
>> If you've got actual engineering concerns that you'd care to articulate
>> I'd (still) like to try to work with you - otherwise, I don't think this
>> is something I can accommodate you on.
> 
> Here's my technical reason. These are non trivial changes that are replacing
> code that has been stable for 8 years that the tracing infrastructure
> highly depends on. I do not have the time to sit down and review this code
> as it is not a priority. My time is extremely limited (as my wife keeps
> complaining to me about, as I'm not spending enough time with the family).
> 
> This change is likely to cause subtle regressions for no benefit to the
> tracing subsystem. Hence, when it comes to risk vs reward, I see none.

It sounds like you're saying you don't have time to maintain your 
subsystem..? Is there anyone else actively co-maintaining tracing? Part 
of our jobs is bringing new people in and training them (and not 
providing a hostile work environment so they'll want to), maybe 
something to think about.

I'm also not seeing the likelihood of subtle regressions - this isn't my 
first kernel refactoring and not _nearly_ the biggest or the most 
invasive. There's definitely some stuff in the tracing code code that is 
a bit on the unorthodox side, but nothing too crazy. The code's been in 
my tree for ages where I use tracing on a daily basis, and it passes 
your test suite (and there was just one bug that made it through to be 
caught by the tests, as I mentioned in the cover letter).

Anyways, if you've got specific, actionable concerns, I'll be happy to 
take a look. Otherwise... ¯\_(ツ)_/¯

Cheers
