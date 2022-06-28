Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30F455E480
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346448AbiF1N3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346604AbiF1N1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D677110E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656422827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3WbsWEZ/mNVf4IIjW1g8i/pcRIWzNJLpjYPpewMPXV8=;
        b=NTEcwwhjYJPFPRLrj5SuQ/LagvE1vcvkezLs0jrtMUVFjsZ7I7y/SmiaQ5YAuDVzrf0Ga/
        GjSjyhfUFjEJNRiJmwbJvz/bandYmJgst0RkyhZXCWcpCpuT38/VfJgCqwgWygqXyXCadS
        IKFypir84i3IDcGK4TsXtoRDEGzAUC4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-_7XemAgLNJizz3vs5Vgq4g-1; Tue, 28 Jun 2022 09:27:06 -0400
X-MC-Unique: _7XemAgLNJizz3vs5Vgq4g-1
Received: by mail-qk1-f198.google.com with SMTP id i124-20020a37b882000000b006af41a43f76so3984561qkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WbsWEZ/mNVf4IIjW1g8i/pcRIWzNJLpjYPpewMPXV8=;
        b=lt0Bwgf6t/KJpiOgExkg92Jhn9Cg4owKbpBMl8G+gDLE6R2sP20wKOqQUMap13pQ69
         HXgS22X5hovs3QU9exNYhm4fPmzMabuZCGEDN+C7Rc1Q7ZQeyqC/FY6m7d0K1I5pbQpj
         HfiAckEPP8flQVBAwZapvbXit1BPXCr2UIcXBuBJG7ZzxYvGzjicVkU9TZJuJ/zyGNbG
         V2lRQJ5LlFJLzwL3wYmbg2THTKeJmon6gk9xXQCJV6dFrneDuRKWncZzGeFHt4eRuEkx
         7MRpwA6PhNopSWrM2utdIfskmRyya+lxWviSbpwMt+dHB4tKgzXFCNXB5uT7KzZ1Iyzs
         FQ9g==
X-Gm-Message-State: AJIora87VCSCfqsmG4iSXOtcLD4bjzUgJ5E+PdVMaHX7iAfIJZjy8uLN
        I/mzMjJIBsLdZnHsP5ee9aS3rDoj6sNLPNUv6etxdf+SGfVHyYSxwLQhPlaCnUv+Gd9gG9RwGnD
        BA1WGCYpvF4Kz5w5W/T7VlslqznCgkFEp5geHVk9z
X-Received: by 2002:a05:620a:4723:b0:6af:46a2:8531 with SMTP id bs35-20020a05620a472300b006af46a28531mr4202363qkb.177.1656422825510;
        Tue, 28 Jun 2022 06:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tsWzlpf+KpXIDtDj3F+am63Ss3bkIPFmCxv2A+xlePARaj83XrP5hyjd8iOe/scwK2BxF/7To24Jkd7nVCV6s=
X-Received: by 2002:a05:620a:4723:b0:6af:46a2:8531 with SMTP id
 bs35-20020a05620a472300b006af46a28531mr4202346qkb.177.1656422825275; Tue, 28
 Jun 2022 06:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail> <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
 <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com> <20220628085821.kn3jjrviyprgai4w@mail>
In-Reply-To: <20220628085821.kn3jjrviyprgai4w@mail>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 28 Jun 2022 09:26:54 -0400
Message-ID: <CAK-6q+h2syRtu1+7tv7ZQB98z62bn7vSeMX4b3uV6Oi+WxKsVA@mail.gmail.com>
Subject: Re: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     jacob.e.keller@intel.com, akpm@linux-foundation.org,
        thunder.leizhen@huawei.com, linux-sparse@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Tue, Jun 28, 2022 at 4:58 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Mon, Jun 27, 2022 at 09:06:43PM -0400, Alexander Aring wrote:
> > >
> > > If we change the refcount code to _never_ calling unlock() for the
> > > specific lock, then all those foo_and_lock_bar() functions can be
> > > annotated with "__acquires()". This should also end in the same code?
> >
> > sorry, this will not work because of the first condition of "if
> > (refcount_dec_not_one(r))" which will never hold the lock if true...
> > that's what the optimization is all about. However, maybe somebody has
> > another idea...
>
> I would certainly not recommend this but ...
> if it's OK to cheat and lie then you can do:
> +       bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __acquires(lock);
> +
>         bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
>         {
> -               if (refcount_dec_not_one(r))
> -                       return false;
> +               if (refcount_dec_not_one(r)) {
> +                       __acquire(lock);
> +                       return false;
> +               }
>
>                 spin_lock(lock);
>                 if (!refcount_dec_and_test(r)) {
>                         spin_unlock(lock);
> +                       __acquire(lock);
>                         return false;
>                 }
>
>                 return true;
>         }
>
> In other word, pretend that the lock is always taken but ...
> 1) it's ugly
> 2) it's lying and can be confusing
> 3) now all the users of this function will have an imbalance problem
>    (but they probably already have one since refcount_dec_and_lock()
>     is not annotated).
>
> What is needed is some kind of annotation for conditional locks.
> I've tried a few time and in itself it was working but in most
> cases the usage pattern was so that there was a imbalance anyway.
>

may we can add something like __may_acquires() in the sense of
ignoring imbalances for the specific lock. This will not check
anything and probably ends in the same, but at least will stop
dropping warnings... my alternative would be to add a #ifdef
__CHECKER__ around my lock unlock().

Maybe just for now as no better option exists to validate such code
during compile time _at the moment_?

- Alex

