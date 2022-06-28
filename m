Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCC355CE71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiF1Ewf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiF1Ewd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:52:33 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5646318340;
        Mon, 27 Jun 2022 21:52:32 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31780ad7535so104856257b3.8;
        Mon, 27 Jun 2022 21:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zzeVUvmrdRDrIRvgcHgKadk9t05nKd85Pyeof8/CAc=;
        b=Y5gF075MBlbrtJE0O9n9GI4LE0zH+m6JrPGou3k0FLPFxodf8PWxquD9XFfyiOAhYx
         lBsF8TMWIKI24T/JolXYP87rLylrPYk6f9tefR2v5n/Aafsc3q5KG5BPeqnGLqYeVgky
         oLywdpssfr7HxRfobh4dKoA9skDfrLYIpS6ttHOp9+7wf2eXNEyQE/tGFdZmVFZy/nTl
         6HvJpa/nFhqer0e4qx3mo93OU70z5hc/y2VQr4dVEbiT/4QqfQ50xxZ+b1HuK2l/HlIs
         8qP+HYCyImlo3jUC4kbohsY2fV0zBUAXjyQlKFtmfY6791H3CCzR8SKD2wExR1tdfH3g
         tTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zzeVUvmrdRDrIRvgcHgKadk9t05nKd85Pyeof8/CAc=;
        b=QelBx/GCjAyznf2ms3pQWKqJZ3bzqWsu1FqwPh7rLA7o0S8bF/AWVGsfC0xd85cNng
         R02cjtkUlNpAZg1TtDhyFGaGrnPjdMDvgx8cAOT04gc+k8QH1lQDG/K8v+BSeFX7EHGL
         mBVt50qWas5UX/yeK2CXdJz11jHAOnixzeYLXWwnbtZ6gdjfQUez++J/jbw/eLx46emO
         sqk8WsTjPg9T/oZsVzkj953w7Qb42RPCxAe3nKavuo7MmYZUgHBh2BZjXWTfr3IzEEZD
         Nqq1VuJuj1Haz+pzUNmts8Yxr1MWAXtaUNUURf1syh18lOTwO1Y+yu7mPPjHCQQRXdab
         o9MQ==
X-Gm-Message-State: AJIora+i94iIwQ1icu0FZcmp99AC0LH5IcDv+wjTYwOog6Cnpr5PD0nf
        8BeF6kGfdAsagI+k3vl7K95mvngbLst1jUx1bZA=
X-Google-Smtp-Source: AGRyM1uZPwQOckyo5Vxp49Qo+QR2VaYig06UD7Jbqnv7SJX9ZX2F81NIuNwl0MEbQaIAWqqpj7mGUpM4UF/Gw5jBPQU=
X-Received: by 2002:a81:9201:0:b0:31b:a963:c7e1 with SMTP id
 j1-20020a819201000000b0031ba963c7e1mr11971603ywg.335.1656391951442; Mon, 27
 Jun 2022 21:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com> <c7c21381-fa1c-a67a-e5e0-ac590fe0612f@gmail.com>
In-Reply-To: <c7c21381-fa1c-a67a-e5e0-ac590fe0612f@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 28 Jun 2022 06:52:20 +0200
Message-ID: <CAKXUXMyyT_yj4c-EH06Ln0W19oJ=9Vtg97ZKki4y5tzEgWgSOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] docs: remove submitting-drivers.rst
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 4:50 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 6/27/22 22:18, Lukas Bulwahn wrote:
> > As future work---with this one submitting checklist gone---I see the harder
> > follow-up task to synchronize and clean up the various submission hints/
> > guidelines/checklists in the remaining kernel documentation that partly
> > overlap and differ in detail, their structure (unstructured, unordered
> > lists vs. sections and subsections) and their state of being outdated:
> >
> >   Documentation/process/submit-checklist.rst
> >   Documentation/process/submitting-patches.rst
> >   MAINTAINERS#Tips for patch submitters
> >
> > My next task at hand is to read through all three documents, figure out
> > what still applies and what is outdated, determine a good common structure
> > for all three documents, include cross-links and make them to some extent
> > follow a clear consistent policy. E.g., one document is a more detailed
> > description of everything mentioned in the short list of another document.
> > I will try to work through that in the next months or motivate and guide
> > some colleague or mentee to work together with me on that.
> >
>
> Hi,
>
> I think MAINTAINERS#Tips for patch submitters contains redundant info
> compared to other submission guidelines, and some tips there are outdated
> (like using `diff -u` instead of git). For consistency, that section can
> be removed (in your next RFC series).
>

Thanks for the suggestion. I noticed the outdated hint on 'diff -u' as well.
I was considering replacing it with 'Use git format-patch and git
send-email to get submitting patches via email right.'. (or to avoid
some pitfalls when submitting patches, I have not decided yet).

But let us first clean up the submitting-drivers with this patch
series and get this done.

Lukas

> --
> An old man doll... just what I always wanted! - Clara
