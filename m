Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1E4C95B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiCAUQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbiCAUQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:16:00 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F407C157
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:15:05 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v28so23365535ljv.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eHzcr1YBGh9o3F4BfOGRvjDUMT5g6q2aQ+3yXHWlOo=;
        b=IZ7/AMI7eJ+ZC/a6fwyXrw1yeswUH52MRpfmJL+44Eql30HG9WzC+yjvRBlCihk6qS
         EvBYRMpstobbwMQtFKPVT7whOd7g6EVNZ9/wh7HN9tT37SQk/kV5yveCnI1WKJxZgJfl
         u5hnXn2wSwbpo9fmHyh7tnjuQRET8kflkToPHzIjsE09X8R0kVDj2vdGuFiwf8ERMe6P
         ZUYFx2H+eXSISc3wqYR+rj1jGJiYrqhXhAk2plKyJAwvUaqs44FoSzMAFM70O9Zf7sm+
         roIZG0kJTwRPMpvGKMjoahCaVCHPIeV7xANIw5S+Q6dN5bwJxAjfKupRq3TdUUvC7rAX
         ewCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eHzcr1YBGh9o3F4BfOGRvjDUMT5g6q2aQ+3yXHWlOo=;
        b=v9aCXITTlZrPAg4x2v7qPDCizHoB4SuDvzFED4Bu7G/1bq9e0eCWK57jHCUgC8+MJ1
         6xoyImtpBA1KSImKQIKTcHduxcQTp0FsacKVfh7GCxMpkJ8rVJdSQQDjc/WyUgPa6CWC
         Eij9XwCASjbcRvfz5KOjTcUL0y6YVAhlxyh8WfURNRoNexXh1nwzeK/A5l/290BzR2HQ
         q6vdrHkOFsz0MSvlCEgcfd2pkN6IeuVythdBc3ryvaWXEm4TPR/BBcbBGIradWXysu2k
         16C4cFSBcGvjMbmmmcicrfk3RweSJVIOEtz96T4OMew87dynyHHwEHqwNUg/jKHoCmtm
         K7Ng==
X-Gm-Message-State: AOAM533Jbq2oHIBxVP7LtU3u2ewG+BYFR8gjs5ayqBuCHEh811/z6Y9p
        63fq/tkE7q+IqklfjTMU19pRXvlOMYORY0YKBM5F+Q==
X-Google-Smtp-Source: ABdhPJzNPHP87nTATQhKnvYuvIArBZyNmAuESqaseKTw/6hflPbUYbtD2HuT0mMBWgoGoh8R52W1FO0GY7/eOoWfE0w=
X-Received: by 2002:a2e:3004:0:b0:223:c126:5d1a with SMTP id
 w4-20020a2e3004000000b00223c1265d1amr18945849ljw.408.1646165703196; Tue, 01
 Mar 2022 12:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20220217153842.3252424-1-trix@redhat.com> <51018469-3bab-e56d-7407-b16170b5d74c@amd.com>
 <CADnq5_OGEURo76mzc4Sb2Jar465Xt4vkSMECDi5jCMH332zUAg@mail.gmail.com>
 <CAKwvOdnYTC7mku1=eVaDLGQFHdoN3u8Afoo582OAQ+ApJmfhQQ@mail.gmail.com>
 <CADnq5_PniW+-8G5AhOSwuovESpfeMxL4r6P30b3F1coa_NmMEQ@mail.gmail.com> <CAOWid-cXYze56YmUACWP4emNeGHXMFf4q5aZfFGUwVXWNFAvSg@mail.gmail.com>
In-Reply-To: <CAOWid-cXYze56YmUACWP4emNeGHXMFf4q5aZfFGUwVXWNFAvSg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Mar 2022 12:14:51 -0800
Message-ID: <CAKwvOdn52Kn1dnmp9cCwJtv5kPwZfHgApzhzajsdkjOwF8XqVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_ras_block_late_init error handler
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        llvm@lists.linux.dev, Dave Airlie <airlied@linux.ie>,
        Tom Rix <trix@redhat.com>, xinhui pan <Xinhui.Pan@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        John Clements <john.clements@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:12 AM Kenny Ho <y2kenny@gmail.com> wrote:
>
> On Thu, Feb 17, 2022 at 2:06 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Feb 17, 2022 at 2:04 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > >
> > > Alex,
> > > Has AMD been able to set up clang builds, yet?
> >
> > No.  I think some individual teams do, but it's never been integrated
> > into our larger CI systems as of yet as far as I know.
>
> I have just added clang build to our CI last night so hopefully we
> should be catching these now.

Wonderful! ++beers_owed;
-- 
Thanks,
~Nick Desaulniers
