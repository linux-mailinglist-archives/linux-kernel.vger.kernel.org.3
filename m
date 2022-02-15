Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C44B7A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbiBOWOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:14:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241830AbiBOWOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:14:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A152227CCA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644963269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SgVDXV404yMNw+CNJPlab88lztIU+ojT1PQnfND6pg=;
        b=LWBnKJNaJetTAOCODlUxESNd6GNovueiPKnRoVZi4TIi2cC677hbz+1n++3AydLg6r7VsO
        WcRspo4w4DReeAMmbnZO+/eLmEnWySGufH5aa65w4Sg3lpD4/1FZwGl/srkBVjUq6B1H4Z
        /SP8a6Nfy7nt2DfUZj4TCRS2/FIroNw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-4bxrQ4XPPuqkFC_NYeoUMg-1; Tue, 15 Feb 2022 17:14:28 -0500
X-MC-Unique: 4bxrQ4XPPuqkFC_NYeoUMg-1
Received: by mail-oo1-f71.google.com with SMTP id l10-20020a4ac60a000000b002de84253574so129277ooq.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0SgVDXV404yMNw+CNJPlab88lztIU+ojT1PQnfND6pg=;
        b=2DtlVzWHai3uJxRsCE8wrTUgh0xvwOlAOUCdBCIiuy7dLbiWYAiI1+OBUxHWlm2OSt
         /wl0bZjbwwddtsGcZfG7yCWYJXGf9EbEpuYULR1NjziQMuo0ERQl6EUJ2sZ/uoBMATmf
         yYZYH4TG3oiCVn7KBVAguzGgzt3g98bAaStyMGMdJbHTntD54We8sexIqwaqlmibN5hd
         izBv6plZ3jNWwHt3WVlLPxpEgFkY+apKBUIvHgwqVLgK3U11DOOQtS8hqwVablrecMa2
         jCz936GGYscte5Uwa9tvMEvELUH6WY5J6HMBJ7dQlfRWra1WRz76+tS7aa9oHI9E0Mgj
         mnMg==
X-Gm-Message-State: AOAM530GK2F8nxLuTEwQrSuUu7EMIiK2/ikSUCd1Q+leIIjx65DsZ5wY
        /2VhN7WAsDBZP5ONCZ3ikvfbU5T90Y4yax/0e+0VFrjmcCW46jS1uhrQpDatunqjuZTGha2Brwp
        MY6XoxN0Ap+BNXYsBrGGJZflS
X-Received: by 2002:a9d:634c:: with SMTP id y12mr426953otk.247.1644963267663;
        Tue, 15 Feb 2022 14:14:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVXfIWZdTFKoCWv5zBjTEK28rZYLt4d2ssRGQsRnGv5qqbZqev0beqgPvRqsVb8AYyrRoeMg==
X-Received: by 2002:a9d:634c:: with SMTP id y12mr426943otk.247.1644963267400;
        Tue, 15 Feb 2022 14:14:27 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id 8sm13835736oav.28.2022.02.15.14.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:14:26 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:14:24 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tools: Fix use-after-free for realloc(..., 0)
Message-ID: <20220215221424.hmnei74ar5gtqfy2@treble>
References: <20220213182443.4037039-1-keescook@chromium.org>
 <20220214200730.a3qz6ocy2ohwafrt@treble>
 <YgwQO1Z0UmV241vg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgwQO1Z0UmV241vg@kernel.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 05:42:35PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 14, 2022 at 12:07:30PM -0800, Josh Poimboeuf escreveu:
> > On Sun, Feb 13, 2022 at 10:24:43AM -0800, Kees Cook wrote:
> > > GCC 12 was correctly reporting a potential use-after-free condition in
> > > the xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
> > > when size == 0:
> > > 
> > > In file included from help.c:12:
> > > In function 'xrealloc',
> > >     inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
> > >    56 |                 ret = realloc(ptr, size);
> > >       |                       ^~~~~~~~~~~~~~~~~~
> > > subcmd-util.h:52:21: note: call to 'realloc' here
> > >    52 |         void *ret = realloc(ptr, size);
> > >       |                     ^~~~~~~~~~~~~~~~~~
> > > subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
> > >    58 |                         ret = realloc(ptr, 1);
> > >       |                               ^~~~~~~~~~~~~~~
> > > subcmd-util.h:52:21: note: call to 'realloc' here
> > >    52 |         void *ret = realloc(ptr, size);
> > >       |                     ^~~~~~~~~~~~~~~~~~
> > > 
> > > Reported-by: "Valdis Klētnieks" <valdis.kletnieks@vt.edu>
> > > Fixes: 2f4ce5ec1d44 ("perf tools: Finalize subcmd independence")
> > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > v1: https://lore.kernel.org/lkml/20220212181855.3460176-1-keescook@chromium.org/
> > > v2: simplify logic (josh)
> > 
> > Thanks, running through testing now.
> 
> I assume that testing went ok, may I add a Tested-by: you?

Yes, feel free to add:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

