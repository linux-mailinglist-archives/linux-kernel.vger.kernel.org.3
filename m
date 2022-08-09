Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECAD58D8CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiHIMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241027AbiHIMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:37:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911BD17A8B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:37:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx38so12813026ljb.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=S/vY+pHOAJw8ND8t13oTQazIac4o9LGilFJcZDyaByQ=;
        b=Mrb2Al4kVt5O3KiUdyGMMX9sVayGDb/FyFERwnGXD0vImjgWnB9fEsdatVsTaDfecG
         tvBp1u1TXVZ3p9+RiYyop/1CWPisZcwCgR9LRfnwCJTDts+eeXMqzsNrHTfIXOK8bsxg
         7oIhTFZA3U3EMwPCbiMwRNLvtfZtB21DPskCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=S/vY+pHOAJw8ND8t13oTQazIac4o9LGilFJcZDyaByQ=;
        b=1Gf/R7g9sMtcUmMz5pKzDAPsvkSUAPYAiKkqELmRmL3a/gvJoyn/GImaH9+GqoujIa
         e1dP2oTEV1H3D+Ae1t9DDU+oHgngjjtkOLe/yLOEZ79NHaJPAPSBvonfEc+U9CFjBZKw
         wQ9eFU8pTmEo77mYu5lDlwJyG2DdKD5l0Byx2Mhhm2xftvRjvVowZ8uizXkE1QuMzrZt
         qKgv3DBWpbpP6A09JRTWpvoGpUmpDXY01h+5ZvGVughWTkihxyvFYmG2moHDSxCqv1pU
         imR93HxDUrcDo2ahhFmrkor4DKDIMXIvDhOP+9xmwkhXDrKZhUD6YMNBr6lhYgQODVcA
         drow==
X-Gm-Message-State: ACgBeo1CyGLIBmUzMbjWR2Yp/w3FN25kRSj1jQYWbiB9z66Gz3VWn2oG
        2lFUmUP73HGsQ+OgtwGz7YNLaw==
X-Google-Smtp-Source: AA6agR7VK6CZDk/4NkzM6eVPldsJwBnFAODpPxiIOJfOv7G8gfUodLs+podMq64PJ/ngkiXV2YfR9A==
X-Received: by 2002:a05:651c:222:b0:25e:4ae2:c5ae with SMTP id z2-20020a05651c022200b0025e4ae2c5aemr7207953ljn.440.1660048647869;
        Tue, 09 Aug 2022 05:37:27 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512324600b0048b2245519asm1753471lfr.192.2022.08.09.05.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 05:37:25 -0700 (PDT)
Message-ID: <36677eab-6407-afd1-4cbf-a90be9554c8b@rasmusvillemoes.dk>
Date:   Tue, 9 Aug 2022 14:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/16] lib/test_bitmap: don't test bitmap_set if nbits ==
 0
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ben Segall <bsegall@google.com>,
        Christoph Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Mel Gorman <mgorman@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yonghong Song <yhs@fb.com>,
        linux-mm@kvack.org, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20220718192844.1805158-1-yury.norov@gmail.com>
 <20220718192844.1805158-4-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220718192844.1805158-4-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 21.28, Yury Norov wrote:
> Don't test bitmap_set(bitmap, start, 0) as it's useless, most probably
> a sign of error in real code, 

No it's not. The nbits can easily be the result of some computation that
ended up resulting in 0 being the right number to copy (or set, or
whatnot), and it's not unreasonable to _not_ check in the caller for
that special case, but rather rely on bitmap_set() to behave sanely - it
has perfectly well-defined semantics to "set 0 bits starting at @start".

The same way that memset() and memcpy() and memcmp() and countless other
functions have perfectly well-defined semantics with a length of 0, and
we don't add caller-side checks for those either.

NAK on this series.

Rasmus
