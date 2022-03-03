Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D116B4CB361
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiCCADd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiCCADX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:03:23 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDB205E0;
        Wed,  2 Mar 2022 16:02:38 -0800 (PST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2230255c029376;
        Thu, 3 Mar 2022 09:02:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2230255c029376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646265726;
        bh=1GjC9yWawG+f9/7QP15mK3z9L/3WiA7vCZuCL3HZ/ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NKGLhqH/8mKIE4g16dYZk/L6M7ik/8e6QSzSPnBskQWr+t4IVxZpgOewQNsjXIUQs
         3k9zOisBbUOsWN5JeeFBvPJnxny+kgqGydth9aNTxDjutVWV1phP/poVez4DzDV+YQ
         Olxupv1WEVnbZsxLxcCtrvOF9gJwlNtdxtjhLzjGfdg+xD34W67yirbOBVwUWQJxT5
         APM+OwypDnmPKXewHxcmM0z/EJoYUYxnqx7ZoaUketWqPeIiEIeOUNiVdrC1IgxyKp
         PcXOqG80ErZdSkqNiX4fN9auVaMTnuPcFvB7Xiz+CwXlcWxggzMmmqjC3TlroHFDI/
         7OxcpgDqUO1+w==
X-Nifty-SrcIP: [209.85.215.176]
Received: by mail-pg1-f176.google.com with SMTP id o8so3010598pgf.9;
        Wed, 02 Mar 2022 16:02:05 -0800 (PST)
X-Gm-Message-State: AOAM532nSsXtVlxZAVTgh4TdqF2PrwQthnfaGuwkvijrJq7Tk/QyDhZr
        bOFMmQJRwFrAEUa6nEVAK/z1FYJoCfgDNKiyKac=
X-Google-Smtp-Source: ABdhPJzczkt6XTF1gd+/tMp7E2XEb5DrYtXsH1n4BNIFbWW6DCaFDFVyXHX09r9xlLxr6aZAyW4lJSxqyBndLDNhDtw=
X-Received: by 2002:a63:e758:0:b0:378:8511:cfe7 with SMTP id
 j24-20020a63e758000000b003788511cfe7mr17071801pgk.126.1646265725034; Wed, 02
 Mar 2022 16:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20220226123755.85213-1-masahiroy@kernel.org> <boris.20220302145825@codesynthesis.com>
In-Reply-To: <boris.20220302145825@codesynthesis.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Mar 2022 09:01:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8GO=XzzaVze8y7142Os6J_htBNVV+6kwiXjSxWfnPDw@mail.gmail.com>
Message-ID: <CAK7LNAS8GO=XzzaVze8y7142Os6J_htBNVV+6kwiXjSxWfnPDw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: change .config format to use =n instead of "is
 not set"
To:     Boris Kolpackov <boris@codesynthesis.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 10:17 PM Boris Kolpackov <boris@codesynthesis.com> wrote:
>
> Masahiro Yamada <masahiroy@kernel.org> writes:
>
> > With this commit, Kconfig will output disable options in a more natural
> > form, "CONFIG_FOO=n".
>
> While I agree with the overall direction, I was wondering how this
> relates to string and int/hex options. It appears that they either
> have a value or are not written to the .config at all, for example,
> if the option is disabled via the `depends on` attribute. At first
> I thought this would be inconsistent (i.e., =n for bool and omitted
> for string), but it appears a disabled bool option is also omitted.
> Hopefully the fact that sometimes a false bool option is =n and
> sometimes it's omitted won't surprise anyone.


Options with unmet 'depends on' are all omitted in the .config
It is consistent for all types.





>
> Reviewed-by: Boris Kolpackov <boris@codesynthesis.com>




--
Best Regards
Masahiro Yamada
