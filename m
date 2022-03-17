Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457734DCDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiCQSo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbiCQSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:44:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8519CD5563
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:43:06 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p17so5172876plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQEW/lPQ6xfHE8z4NalMYFGcFuJD2YWjzJ3BRVmyjX4=;
        b=LtDtw1Mu1QaThn5L7q9eGcDr/OkqkP4Yz2bLSdJllDcnWEeDAPFBsGkEX4JcRo+vFw
         xPnTLroTxnNJphORWThfAlhHDDi+CJ2y93lKWGEyIkyCjDNSFc+cp10LeVOV2nHPlQWI
         xlRT3LQepq3Re0yj766Rn7ODZTJi0wje6Aps8cqrUwqUaPF3RlpjiLKlAPvLvy/mSfHz
         ZqY0bHuyzw7BRysyG5lnvfO/WSITOZ2arLJ9WlP/KfsD6SRYLQ/Rvo0I/ZbDHLnD0BnW
         CpU7442ppE198PC7Lez+vyF1aOWeuXa1FmLAG1qBQocaS/VI2spsWsJGOg+RfpEV6/58
         igHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQEW/lPQ6xfHE8z4NalMYFGcFuJD2YWjzJ3BRVmyjX4=;
        b=WndjNm19xvAeZqnAU5QYAz5Kgru0YV59YkVwliQYDljQrm5HeLAmnkDTcXTNhCmY8f
         ncDJrgbzW5Z6Md7LFMlUALhvXinGrMkn3TvU4zolouyS5bL3nnscxaHXTrlH3eYxz53L
         UJFXeV7MES89rkYjma7rSIMZAwPCXSyvWoktTkpzM9ux34lw1OMBi3qL82sp6rJbmmIr
         CBgh0nJz+UO+FP3rQCg0oAVPmleIAyeZolvXNqXDzMi1eNGoOUvM2rvdTdahO7a9mmF/
         xXpiuDx+8O8KyYJDFVheVdewKJSHGjJRXVc5ZWxfDay/P22byzOuM0XXpds8P0v5EivI
         WPnA==
X-Gm-Message-State: AOAM531CSo7AS8JEnwnNrcW9eiFTEYLEikREly/eXNk0wZ0U8NW7B02L
        JpF2gw5XzLm5/caCyg0dWsp31cYKjgjlKkEx73LSFwP2yg==
X-Google-Smtp-Source: ABdhPJyj88oCapvSqhQbCjXfNFcN+y+jnlhdujAJTp+yixW38jgW1DX5+1i7Bzl0OCZ+w5lDgMBX9OBbEIYHZMvMI8o=
X-Received: by 2002:a17:902:ec89:b0:153:f480:5089 with SMTP id
 x9-20020a170902ec8900b00153f4805089mr3627171plg.166.1647542585558; Thu, 17
 Mar 2022 11:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213122.2352992-1-morbo@google.com> <9053a28a-0cc5-a35e-b613-c63689b9f8f7@infradead.org>
In-Reply-To: <9053a28a-0cc5-a35e-b613-c63689b9f8f7@infradead.org>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 17 Mar 2022 11:42:54 -0700
Message-ID: <CAGG=3QUmOg8KY9tkD744USFJ5Gd3He_Nzh6rz7=cUApeRvonQA@mail.gmail.com>
Subject: Re: [PATCH] nfsd: use correct format characters
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:09 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 3/16/22 14:31, Bill Wendling wrote:
> > When compiling with -Wformat, clang emits the following warnings:
> >
> > fs/nfsd/flexfilelayout.c:120:27: warning: format specifies type 'unsigned
> > char' but the argument has type 'int' [-Wformat]
> >                          "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
> >                              ~~~~              ^~~~~~~~~
> >                              %d
> > fs/nfsd/flexfilelayout.c:120:38: warning: format specifies type 'unsigned
> > char' but the argument has type 'int' [-Wformat]
> >                          "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
> >                                   ~~~~                    ^~~~~~~~~~~
> >                                   %d
> >
> > The types of these arguments are unconditionally defined, so this patch
> > updates the format character to the correct ones for ints and unsigned
> > ints.
> >
> > Link: ClangBuiltLinux/linux#378
>
> Please make the Link: more complete, such as a URL/URI.
>
Done. I sent out v2 of the patch. Sorry about this oversight!

-bw

> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> >  fs/nfsd/flexfilelayout.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
> > index 2e2f1d5e9f62..070f90ed09b6 100644
> > --- a/fs/nfsd/flexfilelayout.c
> > +++ b/fs/nfsd/flexfilelayout.c
> > @@ -117,7 +117,7 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
> >
> >       da->netaddr.addr_len =
> >               snprintf(da->netaddr.addr, FF_ADDR_LEN + 1,
> > -                      "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
> > +                      "%s.%d.%d", addr, port >> 8, port & 0xff);
> >
> >       da->tightly_coupled = false;
> >
>
> thanks.
> --
> ~Randy
