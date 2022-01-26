Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77249D369
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiAZU1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiAZU1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:27:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B14EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:27:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n10so813194edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P7fKMSKo+zYB6l0bcCRLZSEvmbTEgZGQHcFcWTESB/8=;
        b=T8XsmF7/RkWSoa1Uofykc8YgJ4ksfOBVQ1W3E/PAqloI2DNVWNHR8DK4/+nARWFYwQ
         HAqBsXl7/U8MFdaDgmNL53zfIDS+/owDmCBKF+Vr/VI7Rb191veqqQzedmj5eEuR+AhJ
         7jkOnAW4G7iRcOb9YrTFFIP89YB37hE+6K+lR+DuhHrBkITgBEoUXNbj7HJ4pISDixZS
         gSNotfzQG9YKFtGdg6IhR1+rAUXSFvxT20JTgRF4IiMTidXOZGyz+kCMa2/SuLniPvJi
         SfDjxssD0L+wzJXmgpw4hRDBZsJvI9PwLlcfj5LEn6l9IDXKjPdOidn/R4LtViAq9a1o
         wd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P7fKMSKo+zYB6l0bcCRLZSEvmbTEgZGQHcFcWTESB/8=;
        b=ImN9szSGReHvuIdZFuqo8qySd3tfi1E33SYJMx8ObsBaHL+wXKfmWwo0e1hrqcCMFO
         Kd2ypkhiJ1bGSKG0kUAme6aEVPbGpH+vmIsspyq+SV0TjGE9/hXUNiFpXBpV7JYsxi9W
         T0h3qCotQl7SOgFP4f0B8MLNfQSikBcxF3BmYxSIv+nDbYcxKoq3TY91Jr1tnhXQbTf6
         AwGMphHi81ahOVGx82qY2qqMBpI3H/yP/tagldaPRkhuwYrvxMQei+BuG8xqwWoMP18v
         XNmdW2/arCsyvIDPQ8tZtqihGZCROUpGBHrxVSQYxt8KKx43ujxncVJmdbOLLGFlMoXp
         3rGA==
X-Gm-Message-State: AOAM530sekgNLNcZqJkpsRrUMDcZOosDRUeE4YugRN0TM4oZrna+jwQB
        u6CKUpRkZn6t3eRL1FiURIawbq38eCkGNaYhxYB1
X-Google-Smtp-Source: ABdhPJwpLDsxPl9dSCn/6ZhjVdqQvY+qo0gszHugbTZ1j/RmIs9yltE48w5RGwnPuintOLFvvMDgAvBG1ksxt3bQg78=
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr604716edd.405.1643228848645;
 Wed, 26 Jan 2022 12:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-4-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-4-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 15:27:17 -0500
Message-ID: <CAHC9VhSqp-PCp4rLc9Mgco6_3j5JLuym0EZU1xAvzbtt5O87fA@mail.gmail.com>
Subject: Re: [PATCH 5/9] selinux: drop cast to same type
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:14 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Both the lvalue scontextp and rvalue scontext are of the type char*.
> Drop the redundant explicit cast not needed since commit 9a59daa03df7
> ("SELinux: fix sleeping allocation in security_context_to_sid"), where
> the type of scontext changed from const char* to char*.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

--=20
paul-moore.com
