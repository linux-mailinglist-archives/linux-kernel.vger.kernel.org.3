Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A684D573D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbiCKBR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344340AbiCKBRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:17:24 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F1119DE9D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:16:22 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id n11so553642qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXC5XHcV/Wbu2T0eQaB0nXVhI1w5Uiw1+os7WF404f4=;
        b=khGZZDjneArK+aWQ0eJ+CVypbvxl8Hccs4Kv00uBVk+YSpulAXMLw1UvswkczaBPbF
         PxbAsulQN4WiJPAEHzLAcp8a9kUq61LLqQVu+nofwfCB9Cida/hZz5CovewY/1tAC67x
         NiAUI2Mm2PB8pG87KIlV0tIDbbeLJbLgEy/pC0r8Y3ioKBhnf3zpXv+0B7fKWX6WXFFs
         4DwR27knrmYdywlxS2Cb5N2ySX6wj33aVhKOgg4ymJhlG0lfRhhb+Yf9mRxtIGy6mnRR
         gpis9PcXSVk6WbbyznDzUrVuuUkhbE6rEDxT0yfnBMNVLeQvQBC6InLIe4rHiqll45JX
         0snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXC5XHcV/Wbu2T0eQaB0nXVhI1w5Uiw1+os7WF404f4=;
        b=cMOuVQT4gjILc55+yxVBaBl8bflemlb4urKPY3serhrfL+s0gb/D4lDd7xz2hxXdHF
         2IVejVvIqPqgA8lzb0KsBCuREVq4cxaUY0JT/iPwI37+oW0jZhmiaS7E8QpF1MtyfkgN
         Cct8cK3viDHBrcgOShob3T6VhFnK4T7HdCvBTl45AtIkGUDivbHesTgI1pT+Eap08g3B
         qGS2ZKd4ePt3laPTZf8mFgQ+kkE3YKNouLtbyK0/QS2B6HX6JjjoBTmIhlmjC8VfvH9a
         vWms2RZ32nuyxQxRxUunNCYIhyoJmDi9n0lzOQXMh7wBW5UOutXjS3Oj4jzSbmgV7oai
         AuTA==
X-Gm-Message-State: AOAM532EJZYwp7J7SG0f0oufzhprdIrsWHonCBQYjM+cULq1n8qNQz7B
        jmd+Xdih8jL7RugKmE6Cq3EgdoSz7VLPdexdczYUOAH/qULV9g==
X-Google-Smtp-Source: ABdhPJwG8+Fvk1gGoWOkRZPRHLE7hlXkRbEqoEWnnxcszrpsuCbuBYlBgeeswv5iqor1ZPCsjz1cVlbjY4RbY/dZRiI=
X-Received: by 2002:a05:622a:1303:b0:2e0:710e:1372 with SMTP id
 v3-20020a05622a130300b002e0710e1372mr6392872qtk.566.1646961381032; Thu, 10
 Mar 2022 17:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com> <a7f26f93-c5f8-2abc-e186-5d179706ae8e@soleen.com>
In-Reply-To: <a7f26f93-c5f8-2abc-e186-5d179706ae8e@soleen.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 10 Mar 2022 17:16:10 -0800
Message-ID: <CA+khW7hwT0PSiToAJcdX1Te9QwhWL671sMX+92VS+V6Zsp+0Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
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

On Fri, Feb 25, 2022 at 12:43 PM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 2/23/22 19:05, Hao Luo wrote:
> > For binaries that are statically linked, consecutive stack frames are
> > likely to be in the same VMA and therefore have the same build id.
> > As an optimization for this case, we can cache the previous frame's
> > VMA, if the new frame has the same VMA as the previous one, reuse the
> > previous one's build id. We are holding the MM locks as reader across
> > the entire loop, so we don't need to worry about VMA going away.
> >
> > Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> > test_progs.
> >
> > Suggested-by: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Hao Luo <haoluo@google.com>
>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>

An update with performance numbers. Thanks to Blake Jones for
collecting the stats:

In a production workload, with BPF probes sampling stack trace, we see
the following changes:

 - stack_map_get_build_id_offset() is taking 70% of the time of
__bpf_get_stackid(); it was 80% before.

 - find_get_page() and find_vma() together are taking 75% of the time
of stack_map_get_build_id_offset(); it was 83% before.

Note the call chain is

__bpf_get_stackid()
  -> stack_map_get_build_id_offset()
    -> find_get_page()
    -> find_vma()

> Thanks,
> Pasha
