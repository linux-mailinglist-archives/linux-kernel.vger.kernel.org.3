Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEE350C12D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiDVVin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiDVVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:38:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ACC40F7A5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:44:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f5so11006071ljp.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUIRwjAdRkEnvc7qu/4QggxdGOExn65onlukWBeFsUI=;
        b=drjmZFpO/eg/aqGWeRXDxMCuiAMKW8i3ror9N/4lB8yyadnzfP6lQwSgAMyFconsgF
         gtxeRu1lzm5b8ZvABGsb/Gg6xXWFCEfiAv57raWOKsjF3F86wC9KYCYdqkg5OlLl266C
         AY7IdQrNB2qHZU4X9tcv18FCJYEOYNS5JELfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUIRwjAdRkEnvc7qu/4QggxdGOExn65onlukWBeFsUI=;
        b=2+0261NTs5fwjb/T4QX+V3DQixU5gj5GzaBC/czQWBhxdvJqH4m848y74fLOmCJSc/
         /zVp+1fqNeSnxQ4sdmyysCFRNC0HtSYnGatHNo1LG09fvi21stCbDHhw6sECsUBIYgb6
         tQbKbAMolPU3lQDaftXHMuZ00gDcf6Yd8nW7yZPhKJOcdtc5FUrO/jK3De43xxQGEciL
         zgzkBptJoMTDo5H0nSnKOi+/z8A1xFKqGZHVLoGJhJLKjwfWUjTSxhUwR9SMnClZ5G2E
         +06p37qVmYDtZ5WeE2tf8OTYKNKx8Ilxq4Qa6UE70n69BUylO4wQIhOtXXUPXfdvIJsd
         2vvw==
X-Gm-Message-State: AOAM532roMZ5QnXGEQE1DdNkRa+ryk/GpJMqObizWUXn0blEV7uE5J6H
        fdOD4CdUficGEj0H8ppdnCmQrFy7L+AclhekP+A=
X-Google-Smtp-Source: ABdhPJz4o4mx27GLr6qo+F1LDk5XCjO/ft+J+dcjSkD578SX4kffLe7g7O7w0PiCTs17067Sib3Taw==
X-Received: by 2002:a2e:a162:0:b0:24e:fbab:ca0c with SMTP id u2-20020a2ea162000000b0024efbabca0cmr1490733ljl.236.1650659720557;
        Fri, 22 Apr 2022 13:35:20 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id f5-20020a05651201c500b0046be0fefa16sm344497lfp.174.2022.04.22.13.35.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 13:35:19 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id v1so7606879ljv.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:35:19 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr3953312ljg.291.1650659719109; Fri, 22
 Apr 2022 13:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <YmMF32RlCn2asAhc@casper.infradead.org>
In-Reply-To: <YmMF32RlCn2asAhc@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Apr 2022 13:35:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn-V-b=w=4GS_nJQ1nsVcJm0FPTv2Ene_xP_AWPBBFsg@mail.gmail.com>
Message-ID: <CAHk-=wjn-V-b=w=4GS_nJQ1nsVcJm0FPTv2Ene_xP_AWPBBFsg@mail.gmail.com>
Subject: Re: [GIT PULL] Rare page cache data corruption fix
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Fri, Apr 22, 2022 at 12:45 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Syzbot found a nasty race between large page splitting and page lookup.
> Details in the commit log, but fortunately it has a reliable reproducer.

The commit message does mention it ("I have not added a new test for
this bug."), but I'll echo it anyway, since you say it can be reliably
reproduced - getting that repro into the testsuite would be lovely.

               Linus
