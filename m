Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5EF53FAED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbiFGKL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiFGKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:11:54 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B1E8B94
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:11:52 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 257ABV1r073398;
        Tue, 7 Jun 2022 19:11:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Tue, 07 Jun 2022 19:11:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 257ABVSk073394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Jun 2022 19:11:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bc424a36-24f6-3f52-5fdd-5d24cc209a6f@I-love.SAKURA.ne.jp>
Date:   Tue, 7 Jun 2022 19:11:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] kbuild: fix build failure by
 scripts/check-local-export
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <62ba96a2-0a0c-ab8e-351d-398f31a880ae@I-love.SAKURA.ne.jp>
 <ce0b0a88-f8cb-ba9c-8a0e-1a818f8c50e0@I-love.SAKURA.ne.jp>
 <8af7aebf-61ae-f126-57fa-8ff358c1841e@I-love.SAKURA.ne.jp>
 <CAK7LNAREqTb=Y08R-jX8mNZoTmEYt_6WrUrP+U2oZQk2tT9kBg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAK7LNAREqTb=Y08R-jX8mNZoTmEYt_6WrUrP+U2oZQk2tT9kBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/07 17:34, Masahiro Yamada wrote:
> This patch does not work because you did not avoid
> running the while-loop in a subshell.
> 
> It is well described in  this page:
> https://riptutorial.com/bash/example/26955/to-avoid-usage-of-a-sub-shell
> 

I didn't know that. Then, adding below diff will work.

@@ -24,7 +24,7 @@ exit_code=0
 # symbol_types is fine because export_symbols will remain empty.
 result=$(${NM} ${1} 2>&1) || die "${result}"

-echo "${result}" | while read value type name
+while read value type name
 do
        # Skip the line if the number of fields is less than 3.
        #
@@ -48,7 +48,9 @@ do
        if [[ ${name} == __ksymtab_* ]]; then
                export_symbols+=(${name#__ksymtab_})
        fi
-done
+done <<EOF
+"${result}"
+EOF

 for name in "${export_symbols[@]}"
 do

> 
> 
> I will send a working patch with a proper commit log.

OK. "[PATCH] scripts/check-local-export: avoid 'wait $!' for process substitution" works.

Thank you.
