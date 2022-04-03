Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B116A4F0887
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbiDCJMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 05:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiDCJMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 05:12:42 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB7632EEC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 02:10:48 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1nawFy-00091i-GC
        for linux-kernel@vger.kernel.org; Sun, 03 Apr 2022 11:10:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Akemi Yagi <toracat@elrepo.org>
Subject: Re: [PATCH] Makefile: fix config cc version check
Date:   Sun, 3 Apr 2022 09:10:38 -0000 (UTC)
Message-ID: <t2boae$9u9$1@ciao.gmane.io>
References: <20220307223231.608498-1-mst@redhat.com>
        <CAK7LNAR=fs+VJUZJj7YyprdA6xjx=4bttPRL6e4bvNkEeX9eng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Pan/0.149 (Bellevue; 4c157ba git@gitlab.gnome.org:GNOME/pan.git)
Cc:     linux-kbuild@vger.kernel.org
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2022 11:23:31 +0900, Masahiro Yamada wrote:

> On Tue, Mar 8, 2022 at 7:32 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
>>
>> .config is of the form:
>> CONFIG_CC_VERSION_TEXT="gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9)"
> 
> 
> No. This was changed.
> 
> See this:
> 
> $ git show 129ab0d2d9f -- Makefile
> 
> 
> 
>> while CC_VERSION_TEXT is of the form: gcc (GCC) 11.2.1 20220127 (Red
>> Hat 11.2.1-7)
>>
>> thus when comparing these, CONFIG_CC_VERSION_TEXT should not be put in
>> "", otherwise we get () outside "" which shell then tries to evaluate.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile b/Makefile index daeb5c88b50b..d5c03c827825
>> 100644 --- a/Makefile +++ b/Makefile @@ -1714,9 +1714,9 @@ PHONY +=
>> prepare
>>  # now expand this into a simple variable to reduce the cost of shell
>>  evaluations prepare: CC_VERSION_TEXT := $(CC_VERSION_TEXT)
>>  prepare:
>> -       @if [ "$(CC_VERSION_TEXT)" != "$(CONFIG_CC_VERSION_TEXT)" ];
>> then \
>> +       @if [ "$(CC_VERSION_TEXT)" != $(CONFIG_CC_VERSION_TEXT) ]; then
>> \
>>                 echo >&2 "warning: the compiler differs from the one
>>                 used to build the kernel"; \
>> -               echo >&2 "  The kernel was built by:
>> $(CONFIG_CC_VERSION_TEXT)"; \ +               echo >&2 "  The kernel
>> was built by: "$(CONFIG_CC_VERSION_TEXT)";" \
>>                 echo >&2 "  You are using:          
>>                 $(CC_VERSION_TEXT)"; \
>>         fi
>>
>> --
>> MST

I believe the patch proposed by Michael indeed fixes an issue 
introduced by 129ab0d2d9f (Makefile).

Please see the following bug reports:

https://elrepo.org/bugs/view.php?id=1215
https://elrepo.org/bugs/view.php?id=1214

and this forum post:

https://www.phoronix.com/forums/forum/software/general-linux-open-source/
1303986-linux-5-17-rc1-released-a-little-bit-early-but-with-shiny-new-
features#post1304036

Akemi

