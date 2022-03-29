Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5044EB58D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiC2WGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbiC2WGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38D9235DCD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648591496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IBLVNEPOUf5WmMPDsR6Y4RldMomDgegBLpjKSzD4JRA=;
        b=JLHV1TI5dOZ/MWOs/vk6MHKAZPjdI113aN/CSiVGSWI22mHerM5KOmTJXt1six4jHUHo7e
        tkYXCcq5z+JfczSZNnnbBaYqBeIG9L8z/2UF42U94ujbSaBbUVJz5VOMJwUBce17+i/2fT
        +kCs+PyPekonz0VaIvarXcQq0GgIT2g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-ZmXwXS_eOV-9d7RzHXXpYg-1; Tue, 29 Mar 2022 18:04:55 -0400
X-MC-Unique: ZmXwXS_eOV-9d7RzHXXpYg-1
Received: by mail-wr1-f69.google.com with SMTP id 15-20020adf808f000000b00203e488fa4eso5354224wrl.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IBLVNEPOUf5WmMPDsR6Y4RldMomDgegBLpjKSzD4JRA=;
        b=fLri+k49/yULhLG+lWBYjjM9QXZTF3KtLC/maQvzeaXfzqWHhoL/+F2oLrtomAuCVb
         vIZLq2bNPvZYpQA4HXzHBNmm3PtSmWxJv1WDsLIm8okqQ4JvzZrU03/2lSJoRNM30FZU
         1b7ECdpmWrkHz1Z5313xq5hQhquiroj6z+bikDuPvyhGwg0YJ/UhT3LjV8ZJ8AZtooC+
         WAfwS+ji3N/vX7bGH8NEfzUddvIxVxm4uAMbib0WHMtNGxOZ4dPcGlxFVzaIXfb/2TTU
         VIShuxUYlFsEnpXWnt90bJSlot/ayWGGc9ZBUjipUgYXD1YWmfZieCchyupbaoI/8nmN
         vXkw==
X-Gm-Message-State: AOAM533KZOCOkpJxWK74oVkwd5x5lpib4kyuKhoTHkH1IzMgLjLsIpnU
        EH1QJyJ0p5qUaBuYj8/qi/grW9DMPXLfpa3x79GAFd0D9OOOYZcEz3kJYXgJdUhEVKNGRChLLgs
        Ae0epBOwbYqaisjcTCu0XlHCe
X-Received: by 2002:a05:6000:1848:b0:204:e90:cb55 with SMTP id c8-20020a056000184800b002040e90cb55mr33430809wri.58.1648591493929;
        Tue, 29 Mar 2022 15:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZklsWDLtlBufF6gMqI6XIA4yF+Av43mfXR6BICacO/J+twKmWzR7EUSvOK/qjb3IJxAX0yw==
X-Received: by 2002:a05:6000:1848:b0:204:e90:cb55 with SMTP id c8-20020a056000184800b002040e90cb55mr33430788wri.58.1648591493646;
        Tue, 29 Mar 2022 15:04:53 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm5309811wmq.27.2022.03.29.15.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:04:53 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:04:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Keir Fraser <keirf@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re:
Message-ID: <20220329175426-mutt-send-email-mst@kernel.org>
References: <20220325050947-mutt-send-email-mst@kernel.org>
 <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org>
 <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org>
 <87v8vweie2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8vweie2.ffs@tglx>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 08:13:57PM +0200, Thomas Gleixner wrote:
> On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> > On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> > We are trying to fix the driver since at the moment it does not
> > have the dev->ok flag at all.
> >
> > And I suspect virtio is not alone in that.
> > So it would have been nice if there was a standard flag
> > replacing the driver-specific dev->ok above, and ideally
> > would also handle the case of an interrupt triggering
> > too early by deferring the interrupt until the flag is set.
> >
> > And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> > enable_irq instead of dev->ok = true, except
> > - it doesn't work with affinity managed IRQs
> > - it does not work with shared IRQs
> >
> > So using dev->ok as you propose above seems better at this point.
> 
> Unless there is a big enough amount of drivers which could make use of a
> generic mechanism for that.
> 
> >> If any driver does this in the wrong order, then the driver is
> >> broken.
> > 
> > I agree, however:
> > $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> > 113
> > $ git grep -l request_irq drivers/net/|wc -l
> > 397
> >
> > I suspect there are more drivers which in theory need the
> > synchronize_irq dance but in practice do not execute it.
> 
> That really depends on when the driver requests the interrupt, when
> it actually enables the interrupt in the device itself

This last point does not matter since we are talking about protecting
against buggy/malicious devices. They can inject the interrupt anyway
even if driver did not configure it.

> and how the
> interrupt service routine works.
> 
> So just doing that grep dance does not tell much. You really have to do
> a case by case analysis.
> 
> Thanks,
> 
>         tglx


I agree. In fact, at least for network the standard approach is to
request interrupts in the open call, virtio net is unusual
in doing it in probe. We should consider changing that.
Jason?

-- 
MST

