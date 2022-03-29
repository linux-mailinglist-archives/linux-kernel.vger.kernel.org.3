Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB64EB5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiC2WL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiC2WL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:11:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B75617F3FC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:10:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q5so25277005ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LvBYeYfBoZJc79yYSPnS826rdgV+cPYE10MJAFxYNM=;
        b=dOVvQA7kSwT12KogfeblNCFZmeDnP0NcO+zbV7mdC0pzrgfwwE1wjt+N4N+67ecJe6
         6fwZ3iHx48LSpVSsdXdq2LUiLOuQvq608Q+dmRZOKB3y3Hf6H8b0vGCa7no/JxyksZ2w
         dXedeMsxaKKschQxtL/GLo//4AK3cX+O2t43NEc+ADNU3OF2WqpKYYkUh7NPsOWqoLUm
         Q28Ir3ot5WZd9ccsvFza8pd5KSDfPbmV5pbvX6rc+PKB8TqXi0eJX7JUZF3PRaLcjdGL
         Gb686CapS849MYx4C7mP738nht8RYJ4mm545HfK9Yz4JVK2aNYXa+VITjf8f67tmPj/7
         hTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LvBYeYfBoZJc79yYSPnS826rdgV+cPYE10MJAFxYNM=;
        b=5GhLDsjrKQX/I91hc5wYL0j7eZ8ZM/GfTYiRl9mvxaFiBm4ymZBMU2P8JNERTq57I9
         0F3XBqpFM9wk+vbwIpyHbS8fdudcn+3JzkuuBdo4FBX0uy+SuhA3veuYsko/P0kdZm7e
         By6qq2kVCJfdRgNCuq0l03bc4jDdsHsxm87HEWQq0of6RnXqEbI6pcQjTccuCJbRqCBs
         dAFMCxoW90LkiX+5FksD9FyR7CD6pdoQvAlVQfPrDTi4ris6jBUsfS92AL8js1qvj5VL
         BfIJX8yfPfAByizXPyrSfcvibXpAHKZxqCg1qMO6tZQLhRGapH8szjtKfZcb2rQffTzi
         BWlw==
X-Gm-Message-State: AOAM533Jf/4LNXGxALEzqQKKosxubrAj7go4nlojhVPCQQmRXlL4Reec
        b4WBO7lhNdacgpYbBaa1SzIH95526tFIYuC/MS0qlA==
X-Google-Smtp-Source: ABdhPJwcmlQ2nui24j4yCidYZBTwVR2xC8LhRv9e0j02XK2Dd2nYOdr7NuZ5Mz3G4K6ccst2RQl5G043wQTyuqLjXys=
X-Received: by 2002:a2e:7808:0:b0:24a:eacb:ab9f with SMTP id
 t8-20020a2e7808000000b0024aeacbab9fmr7505ljc.468.1648591811035; Tue, 29 Mar
 2022 15:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220329212946.2861648-1-ndesaulniers@google.com> <CAKwvOdmsnVsW46pTZYCNu-bx5c-aJ8ARMCOsYeMmQHpAw3PtPg@mail.gmail.com>
In-Reply-To: <CAKwvOdmsnVsW46pTZYCNu-bx5c-aJ8ARMCOsYeMmQHpAw3PtPg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Mar 2022 15:09:59 -0700
Message-ID: <CAKwvOdnJB5u96fm1w-R-VUayvhq58EQeqZst32NDRscK17Z8pQ@mail.gmail.com>
Subject: Re: [PATCH] net, uapi: remove inclusion of arpa/inet.h
To:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        David Howells <dhowells@redhat.com>
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

On Tue, Mar 29, 2022 at 2:50 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Mar 29, 2022 at 2:29 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Testing out CONFIG_UAPI_HEADER_TEST=y with a prebuilt Bionic sysroot
> > from Android's SDK, I encountered an error:
> >
> >   HDRTEST usr/include/linux/fsi.h
> > In file included from <built-in>:1:
> > In file included from ./usr/include/linux/tipc_config.h:46:
> > prebuilts/ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/arpa/inet.h:39:1:
> > error: unknown type name 'in_addr_t'
> > in_addr_t inet_addr(const char* __s);
> > ^
>
> Oh, this might not quite be the correct fix for this particular issue.
>
> Cherry picking this diff back into my Android kernel tree, I now observe:
>   HDRTEST usr/include/linux/tipc_config.h
> In file included from <built-in>:1:
> ./usr/include/linux/tipc_config.h:268:4: error: implicit declaration
> of function 'ntohs' [-Werror,-Wimplicit-function-declaration]
>                 (ntohs(((struct tlv_desc *)tlv)->tlv_len) <= space);
>                  ^
>
> Is there more than one byteorder.h? Oh, I see what I did; ntohs is defined in
> linux/byteorder/generic.h
> not
> usr/include/asm/byteorder.h
> Sorry, I saw `byteorder` and mixed up the path with the filename.
>
> So rather than just remove the latter, I should additionally be adding
> the former. Though that then produces
>
> common/include/linux/byteorder/generic.h:146:9: error: implicit
> declaration of function '__cpu_to_le16'
> [-Werror,-Wimplicit-function-declaration]
>         *var = cpu_to_le16(le16_to_cpu(*var) + val);
>                ^
>
> Oh?

Should there be a definition of ntohs (and friends) under
include/uapi/linux/ somewhere, rather than have the kernel header
include/uapi/linux/tipc_config.h depend on the libc header
arpa/inet.h?

It looks like we already have
include/uapi/linux/byteorder/{big|little}_endian.h to define
__be16_to_cpu and friends, just no definition of ntohs under
include/uapi/linux/.

Also, it looks like include/uapi/linux/ has definitions for
__constant_ntohs in
include/uapi/linux/byteorder/{big|little}_endian.h.  Should those 2
headers also define ntohs (and friends) unprefixed, i.e. the versions
that don't depend on constant expressions?

(I wish there was an entry in MAINTAINERS for UAPI questions like this...)

>
> >
> > This is because Bionic has a bug in its inclusion chain. I sent a patch
> > to fix that, but looking closer at include/uapi/linux/tipc_config.h,
> > there's a comment that it includes arpa/inet.h for ntohs; but ntohs is
> > already defined in include/linux/byteorder/generic.h which is already
> > included in include/uapi/linux/tipc_config.h. There are no __KERNEL__
> > guards on include/linux/byteorder/generic.h's definition of ntohs. So
> > besides fixing Bionic, it looks like we can additionally remove this
> > unnecessary header inclusion.
> >
> > Link: https://android-review.googlesource.com/c/platform/bionic/+/2048127
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  include/uapi/linux/tipc_config.h | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/include/uapi/linux/tipc_config.h b/include/uapi/linux/tipc_config.h
> > index 4dfc05651c98..b38374d5f192 100644
> > --- a/include/uapi/linux/tipc_config.h
> > +++ b/include/uapi/linux/tipc_config.h
> > @@ -43,10 +43,6 @@
> >  #include <linux/tipc.h>
> >  #include <asm/byteorder.h>
> >
> > -#ifndef __KERNEL__
> > -#include <arpa/inet.h> /* for ntohs etc. */
> > -#endif
> > -
> >  /*
> >   * Configuration
> >   *
> >
> > base-commit: 5efabdadcf4a5b9a37847ecc85ba71cf2eff0fcf
> > prerequisite-patch-id: 0c2abf2af8051f4b37a70ef11b7d2fc2a3ec7181
> > --
> > 2.35.1.1021.g381101b075-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
