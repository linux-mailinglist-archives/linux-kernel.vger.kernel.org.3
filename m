Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC254550A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbiFITef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiFITed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:34:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F0A144BD7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:34:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 25so32240615edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYQS2BycOf2pIc7BMF0PksT1jBEDsJyPkRGFI48wG5A=;
        b=GR0eghBFetA/j6CagqMDEwUFzE+B9kpynm9G6QNbHgsjl7/cAHE5AYAKh5139WJKBj
         wqJkXf8QMAGWnsKKoPHnpmiBJlu01XcjwFySmIQb38tx9rm0VNlZUILbApILoprIS7ia
         wJalCu8RTlTiXdd0uo29QU+WUu+7y0ADcD0OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYQS2BycOf2pIc7BMF0PksT1jBEDsJyPkRGFI48wG5A=;
        b=rvxKPdAaX8NhJQP47bi2JbhwAW4dja3uTUy6gSOKx1WjqonOOXCUa4OlgEX80mRHN0
         CS8SP8XqcHzsYrRPjJG+S6Jzof5KSE6FA7u4QYE3SkNpdpW7WNA1E6Tz+CEPRLDTBuha
         UZLlrLPUBl3qLiPbjy+9BpATC4vTwxln8W4y5lprQqKHwxnsBwZOgiGoETNxpXcwXHz+
         YQSTR7SePitqaPQzEkHVYuo7mScluwzvDDbcZE9E6fWwbC/bHjkckWMUq433tC6qLxND
         cLUWbK+WphEl5unGPXWAY6FLNs6r7AHVNcuM8oba+DLb7D1R/IcuKiHPShFpic7F6a/g
         KdhQ==
X-Gm-Message-State: AOAM531sPr2tpb+Pj366emehqjNMfv4HFA7Teh7dvXOX5T336fkA7IXJ
        0QatkKURMVoVR6GSOVLF7NFqdytKqZ5MEmuQ
X-Google-Smtp-Source: ABdhPJxd5RoxVi8hREqQjZ5LIP6Ma0AarUu15sVsXPVUaUtcR9L0CRide6pW8gmUxNKG86Y6URH18g==
X-Received: by 2002:a05:6402:278d:b0:42e:d3d5:922e with SMTP id b13-20020a056402278d00b0042ed3d5922emr37814539ede.154.1654803270781;
        Thu, 09 Jun 2022 12:34:30 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a23-20020aa7cf17000000b0042dc882c823sm14894632edy.70.2022.06.09.12.34.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 12:34:30 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so81299wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:34:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:39c:69c7:715d with SMTP id
 g9-20020a05600c4ec900b0039c69c7715dmr5003770wmq.154.1654803269839; Thu, 09
 Jun 2022 12:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
 <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
 <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
 <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com>
 <20220609192308.GB10732@1wt.eu> <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
 <20220609193238.GD10732@1wt.eu>
In-Reply-To: <20220609193238.GD10732@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jun 2022 12:34:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8t3S3kWjzTywO5RTv4QrTSYYapEw10kFgD-dRLt08ug@mail.gmail.com>
Message-ID: <CAHk-=wg8t3S3kWjzTywO5RTv4QrTSYYapEw10kFgD-dRLt08ug@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Willy Tarreau <w@1wt.eu>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 12:32 PM Willy Tarreau <w@1wt.eu> wrote:
>
> Finally we did better and disabled engines completely!

Some day that fix will make it to me, and I can remove that ugly pragma.

                Linus
