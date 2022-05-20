Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1427D52F18C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352244AbiETRY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352176AbiETRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:24:49 -0400
Received: from relay3.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C22187DA4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:24:48 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 1047A819FC;
        Fri, 20 May 2022 17:24:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 90A222F;
        Fri, 20 May 2022 17:24:41 +0000 (UTC)
Message-ID: <5be32ddf7688db38408466315a80e03e9af7ac40.camel@perches.com>
Subject: Re: [PATCH v2 4/5] clang-format: Fix empty curly braces
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Date:   Fri, 20 May 2022 10:24:40 -0700
In-Reply-To: <CANiq72kbp3xTpj-L2BfLQ1Ecx-2Ki0W3e5YLERx8-T9bjb96=g@mail.gmail.com>
References: <20220506160106.522341-1-mic@digikod.net>
         <20220506160106.522341-5-mic@digikod.net>
         <CANiq72kbp3xTpj-L2BfLQ1Ecx-2Ki0W3e5YLERx8-T9bjb96=g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 90A222F
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: egq551txxc3afjxpmwups4w9xq1sq7cr
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+q3qK2ENX7TEoV39UpiiLOyeJIHyMH308=
X-HE-Tag: 1653067481-758101
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 19:15 +0200, Miguel Ojeda wrote:
> On Fri, May 6, 2022 at 6:00 PM Mickaël Salaün <mic@digikod.net> wrote:
> > 
> > SplitEmptyFunction [1] should be false to not add a new line in an empty
> > function body.  This follows the current kernel coding style.
> 
> I don't think this is correct. Checking headers in `include/linux/`, I
> see ~70 using {} (when not in the same line as the signature), and
> ~700 in different lines. In `kernel/`, it is even more pronounced: 4
> vs. ~200.
> 
> Am I missing something?

historic vs recent uses ?

I think it's mostly a 'don't care' style.
It's not like there's a significant line count advantage.

Sometimes there is though for blocks like

#if CONFIG_FOO

void foo1(...);
void foo2(...);
...
void fooN(...);

#else

static inline void foo1(...) {}
static inline void foo2(...) {}
...
static inline void fooN(...) {}

#endif



