Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E556C585606
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbiG2UUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2UUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:20:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662EFB874
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:20:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so7814715pjh.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=idAIy7+0S11QYa5sGcSX6gc9lPvRo9Vp3l0WAuHQtjk=;
        b=PMFaHTHQa+PrAa0+3LB0YE2Gw3DO46zUmMLxgR5INe3c+vUatwzrBO/Quyv7D7kKIZ
         MiB6o3DlmAIna/epLhM8AagB7AATmiOJW5lgRVY1ldZbPfk6+ZuZOd+mWxpJRPwHmHvK
         G5675hLDgJcFqZ6fJSBHJNdZxpDapVRjBAaxZ1TgY1nr4TuFlGNcte5o1kXBPZy1zoIU
         pejl+FRpY27xM7h3VKQkIel6sunkXnYcguxcWOPLoX3EchVU8nrnnEHuQL73COaquSBG
         RNU+5NOL07s0GgIaQfkMmVltngB2RAJPQaMDE/f5wk9OZg0RwF1A3XJB71AZYR6ONm2q
         g59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=idAIy7+0S11QYa5sGcSX6gc9lPvRo9Vp3l0WAuHQtjk=;
        b=BM95WBNdzgTmUR/ptzSAjTDG6Un7onqOlHFtTeOqfj99H++dO6Rr1KSveKHFKIyrPD
         0PNNkh42rVMhRA0SGw94tJ5mOc2QtPm1SVlfoX6MR4d/vbemem3a/lMDsi90RwxQo9Hv
         uVQ4+vtTJTNl1Kw55ehl2joQ6DTIK37OUu/vnfojwcVpiy7RLvVTK/H8ys+3FG8gtdpO
         lSEVbzhSCtUqka+sFOZdN4UrFatkpdb2TP2HmFNXzS+TUJ1DD/TbbVonZMywuU69bdCa
         ojOtUZNEXIxbHzzxgHubg2RWPHsPqmslQtuyT97Hqa0HsFoEF0Z9VoecjgjCXTxZ+EJ4
         tiTg==
X-Gm-Message-State: ACgBeo3ZZRtJzxxK5ZmJyjTUZvM5zv3k0xK7LB/hKrnSqcp3zSRwhpxl
        198TPhc7fxoSu12jZM3qWQmdzQ==
X-Google-Smtp-Source: AA6agR6nHUcK/hTH9iTjPWf4bRPNRP8DKrbeNmMfaeO+5rE7W52o17goAn5aG0xF9I3FEwSDa+iTIg==
X-Received: by 2002:a17:90a:ba11:b0:1f2:38ec:3be3 with SMTP id s17-20020a17090aba1100b001f238ec3be3mr5810238pjr.177.1659126010749;
        Fri, 29 Jul 2022 13:20:10 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id x22-20020aa78f16000000b0052cec54e3b8sm467009pfr.215.2022.07.29.13.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 13:20:10 -0700 (PDT)
Date:   Fri, 29 Jul 2022 20:20:05 +0000
From:   Joe Burton <jevburton@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joe Burton <jevburton.kernel@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
Message-ID: <YuRA9Tmy6YNdM7Ih@google.com>
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAEf4BzbWpQS6js5LfS80PkqwDwcLc+NgzfqqUTG-CkLP16shCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbWpQS6js5LfS80PkqwDwcLc+NgzfqqUTG-CkLP16shCg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 04:02:43PM -0700, Andrii Nakryiko wrote:

Applied both of these in v3, which I'll send out in a moment. Thanks for
the feedback!

> >  int bpf_obj_get(const char *pathname)
> > +{
> > +       LIBBPF_OPTS(bpf_obj_get_opts, opts);
> 
> if you were doing it this way, here should be an empty line. But
> really you can/should just pass NULL instead of opts in this case.

> > +struct bpf_obj_get_opts {
> > +       size_t sz; /* size of this struct for forward/backward compatibility */
> > +
> > +       __u32 file_flags;
> 
> please add size_t :0; to avoid non-zero-initialized padding  (we do it
> in a lot of other opts structs)
> 

TIL about this trick. Very clever.
