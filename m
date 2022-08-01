Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD2586E6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiHAQRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiHAQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:17:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585192AC42
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:17:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a7so8307520ejp.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gbhIr0dMzm81+SDBkNEjnMlQtKTmm0VmrGqMRqLxYPs=;
        b=NDxKoaJiNPQBSEq08NX3l0jM8LCk8mtj7rxUXmG2bPj5YQFFaQqM/wNFRi9l8jtYUy
         iLIL9lX0aereoQUPGAFZAWwJ1EJ3X4xQfQkWsVVzrj8kzUc6MWrZ+u68R30AUXKiD9Xs
         idhNYaYWb9LnOFTpLDDxd9gm+Ca8arF9Ry65s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gbhIr0dMzm81+SDBkNEjnMlQtKTmm0VmrGqMRqLxYPs=;
        b=Eo9Gu6aTm70CsXoFrBTIAxlAv0Ni7ye4Kz4BY5X5qPbR6b3FTQYKxiBPUtgtNfvpCd
         rYvzfEsGZkY5KmQjdrcK3RZKa1vIf1gQKQa/fRnHQJj+2WewKE5zTjj3EMtPT6w4gXJ+
         Jw9/70rvvnTnIIIigC/z7mFjAQLHA7G9kmBgtBUnFFq1cwkzBXM6J3eifHH1JtZ8/p5J
         8HfLgV9DEKEiJpZdXGK70LV5QcIcmo7vZrGSVXHBQcBlkbGxS9geA8fQ42Hmu7bHIcGk
         weCq4+n70i4gKGtuhACMjFAQ4/wUsNmxU9W567ZA8tjJc8cntfPtRRasO6yENhfmcaG0
         kn2g==
X-Gm-Message-State: AJIora+QUuKYQ34P97OX+2GbAC2T9H6m7Stykty9AgYrHjLFaUTrmL0i
        dNUbFz3WofjLB9PynQfjY2sFN/giWShm0Y6zLZo=
X-Google-Smtp-Source: AGRyM1vK6l3tSeN1ClKHd4RBIXihD+Gl3L1SC1EgcojmOKaiNCT8lMqxLI9d/Z+iVJCyEq2+9/EH4Q==
X-Received: by 2002:a17:907:7d8b:b0:72f:2306:329a with SMTP id oz11-20020a1709077d8b00b0072f2306329amr12615439ejc.369.1659370667731;
        Mon, 01 Aug 2022 09:17:47 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id ek6-20020a056402370600b0043a2b8ab377sm7017051edb.88.2022.08.01.09.17.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 09:17:47 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id v5so6040431wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 09:17:47 -0700 (PDT)
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id
 x23-20020a05600c21d700b003a32088bbc6mr11480857wmj.68.1659370666735; Mon, 01
 Aug 2022 09:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220801144329.GA10643@redhat.com> <CAHk-=wgCi2LLzSJg_7nRs+nQbVgT8HwEKzjMae_4geVCA+1SNg@mail.gmail.com>
 <20220801155028.GA12328@redhat.com> <20220801155624.GB12328@redhat.com>
In-Reply-To: <20220801155624.GB12328@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 09:17:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi07ue68JuYXDdPD-s93UTs0Tp0oAvdnyxS3zQQSosEOA@mail.gmail.com>
Message-ID: <CAHk-=wi07ue68JuYXDdPD-s93UTs0Tp0oAvdnyxS3zQQSosEOA@mail.gmail.com>
Subject: Re: [GIT PULL] dlm updates for 6.0
To:     David Teigland <teigland@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 8:56 AM David Teigland <teigland@redhat.com> wrote:
>
> At risk of compounding your trouble, I could have added that you can use
> the original merge and have me send the fixup.

Well, I only had something like 4 other merges on top, none of them
*that* complicated.

And I hadn't pushed out, so I just redid them.

I did notice your "v2" pull request fairly quickly, because I try to
do my pulls (when I have lots of them, like at the beginning of the
merge window) in some kind of "order of areas", so I was doing
filesystem and vfs stuff, and  your v2 ended up showing up in that
bunch too, and I hadn't done too much.

I doubt I would have needed help with the conflicts, but I decided to
not even look at them, because even with them resolved it would just
have been ugly to have that pointless duplication from the rebase when
I could just start from scratch again.

But again: please don't rebase stuff you have already exposed to
others. It causes real issues. This was just one example of it.

And if you *do* have to rebase for a real technical reason ("Oh, that
was a disaster, it absolutely *must* be fixed"), please let involved
people know asap.

And a version number change is not a "huge disaster, must rebase".

           Linus
