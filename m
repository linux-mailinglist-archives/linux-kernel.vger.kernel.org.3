Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE152C08E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiERRFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbiERRFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:05:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E66B20B554
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:05:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p26so3841707eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGAntEp7VsrLOr9oJK5iuS5kORmPqq6P0c1ahFe/D8o=;
        b=NOHuR58P7UEw77Nstwjd1anEL7123NzoKqqXJhWJ93UpmIdu/IBnFdHCznT249ezIm
         UUxZ4ViAQmjrDqR2b4SYAHEgwjjSa+JDxBTVFW7lKT3pSLZ8t4BwcEWh2N+JT2hSIgkj
         wYT/SbAq37iUlVSvKsOvhCjSZB0Tgqd7D0pmMsBSnDy1wtwdFeracZFXkRpumUoq9gOL
         Qlz5TUTRFVm5K+y7l2OTYvxl4azvGVq4ot2pU7BqimzIcf3it6UbBmgU3LgbFbnl1G1z
         +4oEX/zUYVIy2bB3n7fJrHw2AtoLoSr+jMu2uEIZA1QxQBgrjIsgoA6Yy8w/s9O2kEjL
         WLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGAntEp7VsrLOr9oJK5iuS5kORmPqq6P0c1ahFe/D8o=;
        b=j3oAbdwlCfvcPCzRB4T10qjV2SrkcHzjaO+WBSRo6JwxEQTkauCptm7JAF8+UIX7NS
         qRLEtNXNIg3a523SmXlIWB6RzAKI6WjhCZVUWNJQGdaZMRvF7vAQ4Jv61Ay8ULG9HOox
         rNvLBJem6SptUJOSa9JftkHsAQwsNfN2POmQ7KFke5T4AjF8xLEeTSUurxoKGtblw23v
         qyjaexX8IPrqKdZMymhZ6rRZ1COpKIZvmvdYhHPCtyHQa9bYwxEnPZIN7fIfsDgBn+M2
         nDd6PtaRFtHnwi+mRTo3OQiodHYraVplTV2nTn6ucExsmETpkwQhF4p9ijBPpBkWQDvB
         ipjQ==
X-Gm-Message-State: AOAM532vAmR8s+Rw9lCnr+0jNGvqhr/6Nj29Y32a8l1OVn23fvyx/TvL
        QFm1J3Dzmnu2fpydX2pWAXIV5UmohLm5mbMu7+yRDw==
X-Google-Smtp-Source: ABdhPJyRynvfcdjaYd0uH0UVh6xTRNO4SHqkECs5n73xe/7fWJ5XV4uKzmGvFQGUoT7N6Iu/8CjQikRk5Xc+3bT14Ac=
X-Received: by 2002:a05:6402:3787:b0:42a:ea83:ad25 with SMTP id
 et7-20020a056402378700b0042aea83ad25mr754096edb.233.1652893511663; Wed, 18
 May 2022 10:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <CAGS_qxrOUYC5iycS436Rb-gEoEnYDa2OJLkQhEVXcDN0BEJ4YA@mail.gmail.com>
 <CANpmjNPSm8eZX7nAJyMts-4XdYB2ChXK17HApUpoHN-SOo7fRA@mail.gmail.com> <CAGS_qxr4vTSEtcGGFyoZibga2Q_Avp9pFD78GOA3W9o6F9RVRQ@mail.gmail.com>
In-Reply-To: <CAGS_qxr4vTSEtcGGFyoZibga2Q_Avp9pFD78GOA3W9o6F9RVRQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 18 May 2022 10:05:00 -0700
Message-ID: <CAGS_qxqb+pKeKBVxzFFTss5QLSWo6nVAajwQTMB2fWbMnMHvgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP testing
To:     Marco Elver <elver@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 8:39 AM Daniel Latypov <dlatypov@google.com> wrote:
> > Either way works. But I wouldn't mind a sane default though, where
> > that default can be overridden with custom number of CPUs.
> >
>
> Ack.
> Let me clean up what I have for --qemu_args and send it out for discussion.

Sent out as https://lore.kernel.org/linux-kselftest/20220518170124.2849497-1-dlatypov@google.com
