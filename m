Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30D45A35DE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiH0Ie1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 04:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiH0IeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1356A98D0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661589261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ozalmLP8Qt6JuDN0i4ihGC0n6gvbuXFOtNSS5/n1O8A=;
        b=fwikB+CZe3b4nsCQlpEcP4AAWWvoRJTdhVNY0Bnh4Xg4tAPkmbkMl6SqpiCrsVrT4NBEvu
        zgq0jMPoXprkMggGAp8lul1Xs5ApqzGhKzv1dxu4dbwhPEpKOLI1tCc2JlL5RGJBCElis4
        0EzhFZb09M6Rm4tm2lorQwmmxMbQOeo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-i7hE86BHMm6LTI1ONYUUdw-1; Sat, 27 Aug 2022 04:34:20 -0400
X-MC-Unique: i7hE86BHMm6LTI1ONYUUdw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-340862314d9so45896497b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ozalmLP8Qt6JuDN0i4ihGC0n6gvbuXFOtNSS5/n1O8A=;
        b=F4Q/dI3LKR1x+xxb2PIpCXCuMSxBbxndF5YW38aotKBFkbH0p+y+UAFKbJxKJRuti4
         Z1hh+qfUSAlaVr7pehEUGqWvlpmqTXpoYgcL/OgVgxC5RO4d6NDYlLZEGSpAbDTi3p+B
         wJFWKGPJUqEP7r0t6O1Q1RNTiw8MVWSvpo1xdaCujs9r/dGpg/CCt9TTLDUhjjqAiXRB
         LXIJKmtfInrRw1XXH+BaqgtPOTT/NdopKPC4tbo/DlG2NEXwvZJOJdkmy8wxrUsxhPB4
         JUOPSHkzkMtWrAxtCQJQ2VX4u2e8ItOP+dJOJ1dPZQdORtafr22OdB/y9WHhxXY4LYS/
         aJ2Q==
X-Gm-Message-State: ACgBeo0fnBB6+O/Vbco/Tu43yZycYn9TM45979l9uTV5dSWs7r+x8VfT
        kfKHJ+6rro9OIg93+f1dTne0acnno+3aGe08+BZSVXwoeuYihDLL9kux+TJCFT+zYLZarrOv7AL
        pvhD2h8QYeWbwcqdi4LgylAs24fYMQN4vzHu5mw0B
X-Received: by 2002:a81:c30a:0:b0:328:4a6c:bc89 with SMTP id r10-20020a81c30a000000b003284a6cbc89mr3108128ywk.29.1661589260043;
        Sat, 27 Aug 2022 01:34:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7BNxe3K/RBPxZunkJwttk33VQrVobmVJz0rNUmmvezNO079TRhdQMRWqXbsJ0MbZjbZAk36PfWigNu0kNQiRg=
X-Received: by 2002:a81:c30a:0:b0:328:4a6c:bc89 with SMTP id
 r10-20020a81c30a000000b003284a6cbc89mr3108121ywk.29.1661589259859; Sat, 27
 Aug 2022 01:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220823080118.128342613@linuxfoundation.org> <20220823080124.294570326@linuxfoundation.org>
 <9996285f-5a50-e56a-eb1c-645598381a20@kernel.org>
In-Reply-To: <9996285f-5a50-e56a-eb1c-645598381a20@kernel.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 27 Aug 2022 10:34:07 +0200
Message-ID: <CAFqZXNv2OvNu7BctW=csNLevgGWyoT1R81ypH8pGoAeo3vd4=w@mail.gmail.com>
Subject: Re: [PATCH 5.19 145/365] kbuild: dummy-tools: avoid tmpdir leak in
 dummy gcc
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Stable maillist <stable@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 9:51 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> On 23. 08. 22, 10:00, Greg Kroah-Hartman wrote:
> > From: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > commit aac289653fa5adf9e9985e4912c1d24a3e8cbab2 upstream.
> >
> > When passed -print-file-name=plugin, the dummy gcc script creates a
> > temporary directory that is never cleaned up. To avoid cluttering
> > $TMPDIR, instead use a static directory included in the source tree.
>
> This breaks our (SUSE) use of dummy tools (GCC_PLUGINS became =n). I
> will investigate whether this is stable-only and the root cause later.

It looks like both the Greg's generated patch and the final stable
commit (d7e676b7dc6a) are missing the addition of the empty
plugin-version.h file. It appears in the patch's diffstat, but not in
the actual diff. The mainline commit does include the empty file
correctly, so it's likely a bug in the stable cherry pick automation.

> > Fixes: 76426e238834 ("kbuild: add dummy toolchains to enable all cc-option etc. in Kconfig")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   .../dummy-tools/dummy-plugin-dir/include/plugin-version.h | 0
> >   scripts/dummy-tools/gcc |    8 ++------
> >   1 file changed, 2 insertions(+), 6 deletions(-)
> >   create mode 100644 scripts/dummy-tools/dummy-plugin-dir/include/plugin-version.h
> >
> > --- a/scripts/dummy-tools/gcc
> > +++ b/scripts/dummy-tools/gcc
> > @@ -96,12 +96,8 @@ fi
> >
> >   # To set GCC_PLUGINS
> >   if arg_contain -print-file-name=plugin "$@"; then
> > -     plugin_dir=$(mktemp -d)
> > -
> > -     mkdir -p $plugin_dir/include
> > -     touch $plugin_dir/include/plugin-version.h
> > -
> > -     echo $plugin_dir
> > +     # Use $0 to find the in-tree dummy directory
> > +     echo "$(dirname "$(readlink -f "$0")")/dummy-plugin-dir"
> >       exit 0
> >   fi
> >
> >
> >
>
> --
> js
> suse labs
>

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

