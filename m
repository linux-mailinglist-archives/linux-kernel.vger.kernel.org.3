Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAAF53B189
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiFBBbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiFBBbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:31:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D072A141B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:31:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o10so4404031edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 18:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k62nV7Jswjfh4J4CVA+J/+R723CZLyDDE2S4baqnCag=;
        b=H5FDe3jnuN+KGmzQtMY8FjzxIp5OgCVrg5TLH2gAYextyJrNTj0AvwoN6LuojxpTVR
         72gGqG52f8sxiemwN6dFAEz/4wR4xwg2kVv6Zf25KN/MGnHvxc86UCA3A5IdMufuJYk+
         qu7dPwyLLlHdNnFN2Wb9UYnpaxdFjlic3+Lto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k62nV7Jswjfh4J4CVA+J/+R723CZLyDDE2S4baqnCag=;
        b=hix5M9b3265crO4zuUgXBGBxjo39DYB2FyQwrkmwfv/4ZZfWXBg+Z7pd+HsS+trwKn
         MJ3dzmztyE56X8MYlaNHXMjPp9TDQ2i4f62w5yIonN0CDOLdcSfNH5/8vGckNqbpkY06
         3kRz1KCmShWyASKkTzllXZu1pUY1i9ggKFhoDiWaaKlWSDTtVbBcNTxtL5YPsBseLUGw
         Vv6L+8gKN3KJViQhXuDZ45VO2ZqxkQpC7UBKnNSq06nd7zva7SJmQNgkmqITsDINSaUb
         RxBKSIh1k0v5zknzD0yFF2yqBV/M+FKwG+7hlAOAkS/cwfXhQ++hJrYiA1qWSZYlyKFG
         plwg==
X-Gm-Message-State: AOAM530x3trVkxsTNhcUp4EEGSSUfnFa05FWcyACTsTtry/o0JuDudBe
        f8G2ZvMdt/cuxz955FKiJL+/wT4/KsmPaXv+
X-Google-Smtp-Source: ABdhPJz+uWriXmfYCjlcervOghrihDDirMeGU9ef2f/xoD9vmV0jHhtZ0/i+WeFXaTmsCvF+t1kxzg==
X-Received: by 2002:a05:6402:2788:b0:42b:710e:9bad with SMTP id b8-20020a056402278800b0042b710e9badmr2813900ede.180.1654133505914;
        Wed, 01 Jun 2022 18:31:45 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id gc19-20020a170906c8d300b007094f98788csm590209ejb.113.2022.06.01.18.31.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 18:31:45 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id t13so4484402wrg.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 18:31:44 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr1547932wrz.281.1654133504250; Wed, 01
 Jun 2022 18:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <165295023086.3361286.8662079860706628540.stgit@warthog.procyon.org.uk>
 <8735go11v0.fsf@stepbren-lnx.us.oracle.com>
In-Reply-To: <8735go11v0.fsf@stepbren-lnx.us.oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 18:31:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHHg_buCqw=Q2OtRWoFpD67OxsQ0jMzao+6rGM6hRE0A@mail.gmail.com>
Message-ID: <CAHk-=wjHHg_buCqw=Q2OtRWoFpD67OxsQ0jMzao+6rGM6hRE0A@mail.gmail.com>
Subject: Re: [PATCH] assoc_array: Fix BUG_ON during garbage collect
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        stable <stable@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 3:00 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Just wanted to check on this patch as the 5.19 window closes. David, are
> you planning on taking this through a particular tree, or is the ask for
> Linus to pick it directly?

Ok, picked up directly.

These fall through the cracks partly because it's not obvious what
they are for. Sometimes I get pull requests from DavidH, and sometimes
I get random patches, and while the pull requests are fairly
unambiguous ("please pull") the same is not necessarily true of the
patches. Are they for discussion, an RFC, or fro applying...

So then I pretty much guess.

                 Linus
