Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0FF5202CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbiEIQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiEIQry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:47:54 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345061F2D71
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:43:59 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso15375403fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqWCEiFRZR6d7K91PH8ezSoYLh3BKRbhvIoPlxx9A7I=;
        b=HUq4PANpxSIB27eIQbGcBLcJ1kMRfgia2LIbn1U/sr3tsZ29aWkap3rwOThAhgUyct
         MW4AAxZzt0kalHcKw0VYco7ySwx5B0Q6L9DvBsfj/UbG57AwzHEN8a6JkyYUfNQ29VTC
         pohnxIWc1viOIWSeXqW8vA+HehX4XegFte3mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqWCEiFRZR6d7K91PH8ezSoYLh3BKRbhvIoPlxx9A7I=;
        b=DGgJc7a0l3RvToATzOCyCyLINwbIzIAv0lyldLRT8us6XAQSdJUJ1rh/OzMdnG0IUi
         ryUB6S9LWWTTHZZ+7J+wt//Y1SFkZov7K0/YqyBGVbLfqwy0PovIwwj8/Al0osDxVB8H
         AcoZU25RYljNOoUi+KZ6M/zlma/IvGXYdPA9+pR+VyuXtT1VlO0+7tOSAuoN517zorl/
         PIaeQEbjAJYTM1nNyzs9Yc+bm1mIRLpP7Z1Ndf4Jl+omJmJaqbh25+wYM+1Grn6jE77P
         MdFztvGffPgKMeGKa1dDnf5ajUrhF+2zO+/KtStdtvFhZ1fVApz4+kU2WYnBBK1J40+m
         0GhQ==
X-Gm-Message-State: AOAM531o4LT97X75tMi2ddwVTpSzc/hvtvaqzyCXfxb8RinB0nFe7APW
        8F397lNFSFm6qXS/H8GCg8AeMUKOc8u/U3al
X-Google-Smtp-Source: ABdhPJyIQgqx58YC0Vp7vH0o7u3xLL2NvOsTX0xZi/UikZsstRQ6nTdM0HFrmB9NCrb4zaTnQ7XLIQ==
X-Received: by 2002:a05:6871:6a7:b0:ec:6a95:408b with SMTP id l39-20020a05687106a700b000ec6a95408bmr9900700oao.127.1652114638422;
        Mon, 09 May 2022 09:43:58 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id o34-20020a056870912200b000ee2bb503d0sm3359251oae.50.2022.05.09.09.43.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 09:43:57 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id k25-20020a056830169900b00605f215e55dso10491488otr.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:43:56 -0700 (PDT)
X-Received: by 2002:a9d:6953:0:b0:606:3534:168e with SMTP id
 p19-20020a9d6953000000b006063534168emr6192989oto.237.1652114636260; Mon, 09
 May 2022 09:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220506160807.GA1060@bug>
In-Reply-To: <20220506160807.GA1060@bug>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 9 May 2022 09:43:19 -0700
X-Gmail-Original-Message-ID: <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
Message-ID: <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Encrypted Hibernation
To:     Pavel Machek <pavel@ucw.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        rjw@rjwysocki.net, Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 9:08 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > We are exploring enabling hibernation in some new scenarios. However,
> > our security team has a few requirements, listed below:
> > 1. The hibernate image must be encrypted with protection derived from
> >    both the platform (eg TPM) and user authentication data (eg
> >    password).
> > 2. Hibernation must not be a vector by which a malicious userspace can
> >    escalate to the kernel.
>
> Can you (or your security team) explain why requirement 2. is needed?
>
> On normal systems, trusted userspace handles kernel upgrades (for example),
> so it can escalate to kernel priviledges.
>

Our systems are a little more sealed up than a normal distro, we use
Verified Boot [1]. To summarize, RO firmware with an embedded public
key verifies that the kernel+commandline was signed by Google. The
commandline includes the root hash of the rootfs as well (where the
modules live). So when an update is applied (A/B style, including the
whole rootfs), assuming the RO firmware stayed RO (which requires
physical measures to defeat), we can guarantee that the kernel,
commandline, and rootfs have not been tampered with.

Verified boot gives us confidence that on each boot, we're at least
starting from known code. This makes it more challenging for an
attacker to persist an exploit across reboot. With the kernel and
modules verified, we try to make it non-trivial for someone who does
manage to gain root execution once from escalating to kernel
execution. Hibernation would be one obvious escalation route, so we're
hoping to find a way to enable it without handing out that easy
primitive.

[1] https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/

> Best regards,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
