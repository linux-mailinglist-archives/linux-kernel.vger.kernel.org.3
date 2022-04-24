Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB550D40F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiDXRq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiDXRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:46:56 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B580DD399F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 10:43:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v4so3145627ljd.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peeXpSGRMeGEzoalpORyTqQLMLKNcHauKDKhUxOBeNk=;
        b=IekpBZl+Z1RTJbQ89uIac/0pvqJlPZbLqqT1M3FrGlhuNapxhk9LXvDklkTRji31Iv
         YqTjbVNa45HZCZIFzco0ewinoAbriHZX7UDnNI0FvzoEh8a8GQ8BBe2n2fDNj6t+nH15
         eBbh3tx/hkS1SojrqBNx+y9nwQoRTjBiF36VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peeXpSGRMeGEzoalpORyTqQLMLKNcHauKDKhUxOBeNk=;
        b=y7BBVF1tkot/yjyCJkhm5c+xCKKRDreiOOhS+loOYPvJyqTzEOSF3ItN+HpLVsbGxY
         BGPfExSOBJaX5n3NrvosbnPed0+1esqZGmOS01vGx1HicctgulQ3hBaRvYqAime4renS
         AyeU7LvswR9LJASgoRuGPdowXfXpkb7sAKWyCpGycY9cckFsjTP3gWACIwbZ2zcHHRWC
         RGvlNcFuMNEXNE/RS6yF+g7SFuQwAkZTfbEkUG/hdFY1+jRdvoMpFaxrcIaJf1Bu3qse
         GfGu21J7GtoNofW/Ht8QdZmbyLtx8ON/ydaq4uXWAFwsZMXST5hJOkEaG6BNZSjjOaHe
         aajQ==
X-Gm-Message-State: AOAM530sZUHBQvblF/qPTz+C3v2ziXZIAklYKIr5CKsyaD7Q5r3ozA5U
        3Nwrjqrl0GG9zloeUnJpqAXdempAVjvjjGfp
X-Google-Smtp-Source: ABdhPJwgOBjRY5xH/xRcoIKNulpgVPjErAJ57YXX1hv9yngTCfUB4RUdTT0KbhHP2zQ9seyzyiWKkA==
X-Received: by 2002:a2e:9010:0:b0:244:c66c:c3e6 with SMTP id h16-20020a2e9010000000b00244c66cc3e6mr8691494ljg.391.1650822232780;
        Sun, 24 Apr 2022 10:43:52 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id g18-20020a2eb0d2000000b0024f0fe97fc4sm193293ljl.56.2022.04.24.10.43.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 10:43:47 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t25so22549181lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 10:43:46 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr10677909lfu.449.1650822226569; Sun, 24
 Apr 2022 10:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
In-Reply-To: <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Apr 2022 10:43:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whadDF2MGN_THUo-n9S-m9isA-+vwhMeVvwGvmuZaYb6Q@mail.gmail.com>
Message-ID: <CAHk-=whadDF2MGN_THUo-n9S-m9isA-+vwhMeVvwGvmuZaYb6Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Song Liu <songliubraving@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ I see that you posted a new version of the series, but I wasn't cc'd
on that one, so I'm replying to the old thread instead ]

On Sat, Apr 16, 2022 at 12:55 PM Song Liu <songliubraving@fb.com> wrote:
>
> Patch 2/4 enables huge pages for large hash.

I decided that for 5.18, we want to at least fix the performance
regression on powerpc, so I've applied the 2/4 patch to enable huge
pages for the large hashes.

I also enabled them for kvmalloc(), since that seemed like the one
ObviouslySafe(tm) case of vmalloc use (famous last words, maybe I'll
be informed of somebody who still did odd protection games on the
result, but that really sounds invalid with the whole SLUB component).

I'm not touching the bpf parts. I think that's a 5.19 issue by now,
and since it's new, there's no equivalent performance regression
issue.

               Linus
