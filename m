Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F16530F26
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiEWLPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiEWLPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:15:03 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD7441FA3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:15:00 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4L6F9G6b4RzMqRg2;
        Mon, 23 May 2022 13:14:58 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4L6F9F4PlPzlhRVb;
        Mon, 23 May 2022 13:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1653304498;
        bh=+T8+Qt8cxCMVtvjSjB7nIQYHhiPyELQadtTfyUjnfmU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ZfCmtCnz8Gnlbiu2owgijbxmqIvDPRNmxBk+hrxrtKiOhNJ57ori/2TI2UBPG1Z9o
         woLjtQq4qL6m45u5ZyyPfSiKjDaHkkzSX8xS/oxzLV8k/iMeFuY3xCSsEn3kV7JyvC
         0m4AvH+3QOIVgr2wIvBQxmEcI1RlrTAy/cCnpgSc=
Message-ID: <02494cb8-2aa5-1769-f28d-d7206f284e5a@digikod.net>
Date:   Mon, 23 May 2022 13:14:56 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20220506160106.522341-1-mic@digikod.net>
 <20220506160106.522341-5-mic@digikod.net>
 <CANiq72kbp3xTpj-L2BfLQ1Ecx-2Ki0W3e5YLERx8-T9bjb96=g@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v2 4/5] clang-format: Fix empty curly braces
In-Reply-To: <CANiq72kbp3xTpj-L2BfLQ1Ecx-2Ki0W3e5YLERx8-T9bjb96=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/05/2022 19:15, Miguel Ojeda wrote:
> On Fri, May 6, 2022 at 6:00 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> SplitEmptyFunction [1] should be false to not add a new line in an empty
>> function body.  This follows the current kernel coding style.
> 
> I don't think this is correct. Checking headers in `include/linux/`, I
> see ~70 using {} (when not in the same line as the signature), and
> ~700 in different lines. In `kernel/`, it is even more pronounced: 4
> vs. ~200.
> 
> Am I missing something?

You're right, it is not consistent across all kernel code. Using 
one-liners is easier but after a wider counting for *.c and *.h with 
5.18 I get:
- 187 for "\n{ }\n"
- 196 for "\n{}\n"
- 1963 for ") *{}\n"
- 4554 for "\n{\n}"

Please ignore this patch, I'll do the same for my changes.

Regards,
  Mickaël
