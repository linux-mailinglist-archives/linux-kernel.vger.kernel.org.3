Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA164F8AFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiDHArN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiDHArK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:47:10 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A40B53E2A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:45:08 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id l14so12511645ybe.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 17:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9o8sGMkfG1jeyFOXZpLH64iA8m+M6x0mckBPZB78tzo=;
        b=fxTAOs+GhjoaxPxbBlMf896vsg3DjAYfwRkWhqPKYkU/sU/QX3SYpF369qI8oRsdnW
         woLa1QozV/d9z0eC9L3JU/0A+aribrkLH4ztc8jw9lhQWMxS831uV9ppubc/d7bKXugU
         QyXyl7Jl58hSrjCPIAWBgqpbZSSFH9bXGL7Iv9NKhx2qKgbkgNI8CS8difiT5eT+VRON
         ENZErFFpoqSvrsSZLFYAYlYR+kSB6/W3/6XL2Yqs/xTN9Wxgv3GTOSQWi57eBWVdeuCX
         dypxNXfkTBmDeW9jVyd+lnOuFdt65mBP3eWqWRUNxyKCfIaAO+mulasGqNdVNJUDjAfG
         TYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9o8sGMkfG1jeyFOXZpLH64iA8m+M6x0mckBPZB78tzo=;
        b=ws3yDys0f2mQz9uqKJngJCSmNvlictURylYI4HD9zqMwpOW3oANxgyX3h4z45UEQQ4
         1xflLZYkAH7BEN63lDyxQjbkpHy9jWT81SO5Mg6Olj950TmmPR3TY/TCIj78Ud9zt46T
         lvOZjhFzLoQ+LhWPhvzwsGFxuUpatcVCG4Q1P4aMTWxXTTCr9MydDaaqbIgL8Lx+A6X0
         DuctJn05+baDuMMCADmadCh73Q/ugpThNQQT1vvtMP4UPrkQZtlEG8QiezIvYnuhxCRg
         gtl+I/72UTKnNsXQyee7ltZex6O6FD1Y1YSwmMo9tMN4YJtE3bPSRFgl31oHdEgmimQv
         B33g==
X-Gm-Message-State: AOAM532FefARFEflRIcCjpW/9R96deIdbB6nkJ+L885fjsKau7xjcZem
        cdiZ+tIK221ZOICHlkQEsc0zP6DJ4A57b8urii8RSA==
X-Google-Smtp-Source: ABdhPJyl1O7lQda//8EbXV5VwDYB+8PqHGnFKUiZ1hcxbXh0ZCvhD5e/KZ0r3XzSRE96KsFP249zWyB1k/AGf6SztRg=
X-Received: by 2002:a25:e68b:0:b0:63d:942e:17a3 with SMTP id
 d133-20020a25e68b000000b0063d942e17a3mr12898845ybh.563.1649378707402; Thu, 07
 Apr 2022 17:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx-tH0+WoqH6s=Zw6VSaHwFcBhvaJKLJRLHGtUEs+skCvQ@mail.gmail.com>
In-Reply-To: <CAGETcx-tH0+WoqH6s=Zw6VSaHwFcBhvaJKLJRLHGtUEs+skCvQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Apr 2022 17:44:31 -0700
Message-ID: <CAGETcx_7_r7NJb+uU05YxzJu1QZfvMBxwOo2M_wK6JU_h=wJKw@mail.gmail.com>
Subject: Re: [PATCH v2] printk: ringbuffer: Improve prb_next_seq() performance
To:     pmladek@suse.com
Cc:     Chunlei.wang@mediatek.com, john.ogness@linutronix.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, senozhatsky@chromium.org,
        Android Kernel Team <kernel-team@android.com>
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

Messed up mail headers. I'll resend this with proper mail headers.

-Saravana

On Thu, Apr 7, 2022 at 5:36 PM Saravana Kannan <saravanak@google.com> wrote:
>
> > --- a/kernel/printk/printk_ringbuffer.h
> > +++ b/kernel/printk/printk_ringbuffer.h
> > @@ -75,6 +75,7 @@ struct prb_desc_ring {
> >  struct printk_info *infos;
> >  atomic_long_t head_id;
> >  atomic_long_t tail_id;
> > + atomic_long_t last_finalized_id;
>
> I really know nothing about this code, but while looking around
> kernel/printk/ I noticed kernel/printk/printk.c has these lines in
> log_buf_vmcoreinfo_setup().
>
>         VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
>         VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
>         VMCOREINFO_OFFSET(prb_desc_ring, descs);
>         VMCOREINFO_OFFSET(prb_desc_ring, infos);
>         VMCOREINFO_OFFSET(prb_desc_ring, head_id);
>         VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
>
> Would this header file change also require a change to that location?
> Something like
>
>         VMCOREINFO_OFFSET(prb_desc_ring, head_id);
>         VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
> +        VMCOREINFO_OFFSET(prb_desc_ring, last_finalized_id);
>
> -Saravana
>
> > };
> >
> > /*
> > @@ -258,6 +259,7 @@ static struct printk_ringbuffer name = { \
> >  .infos = &_##name##_infos[0], \
> >  .head_id = ATOMIC_INIT(DESC0_ID(descbits)), \
> >  .tail_id = ATOMIC_INIT(DESC0_ID(descbits)), \
> > + .last_finalized_id = ATOMIC_INIT(DESC0_ID(descbits)), \
> >  }, \
> >  .text_data_ring = { \
> >  .size_bits = (avgtextbits) + (descbits), \
