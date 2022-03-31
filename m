Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452C74EE3EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbiCaWWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242369AbiCaWWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83D16173F5D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648765211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcacMdqd3bf9RhdWBIFn3jh9EYGsuLJ5EDgnlxHe6hY=;
        b=V7GjAglvSMSC6Tbc5GTFLZ5OVuoPCjrDy/fCoK8jYKAJNn0SRoX+WMFHF6p0HyYIAMbe/S
        GNKrvk19aJAxvywobbU0dLCOKW52meqSr13UAg6ih6pUIS5E0iGj0i8I403I9Q6Bgccm/o
        IPbggj/T8CsIY4OvTrvhslWk5+NJVBc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-sq51nJkxN1yHK0w7-a03LA-1; Thu, 31 Mar 2022 18:20:10 -0400
X-MC-Unique: sq51nJkxN1yHK0w7-a03LA-1
Received: by mail-ej1-f71.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso478429ejc.22
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcacMdqd3bf9RhdWBIFn3jh9EYGsuLJ5EDgnlxHe6hY=;
        b=BV3gc0OASXOhI8QTu09K5mJea93TsZsmK3ZFfd4UTJXgW0JEGn3VhrV28gwqiLYSAe
         J2Cw/v4OzNroG30LRcwm371LBVNI9Y0oZyK79nKwBDDq4kq0Vo2JaPhg0KQInUq99Jzk
         aZYfcAlPc6PnJz/wqwPQhVtadDQXRDcErk+G+M+zJFStB+Fn4CYxDYbFWDXB2MJmDVOt
         ke6leLFSjsywY8L9kiNVo4FqebIQEcUGW1c7TS/ROB9sK0XedH2/wRaVgj8ej9dDhBCy
         3BwmtoWp+uMu1rdGEV104plp3cBCP6Yy7uqKB2yPZnUXjPZu1FCX5dE0zQ04M2j/Xi7F
         6DPA==
X-Gm-Message-State: AOAM532WFyhpdGjmN6to461Ne2L5QBCSqxVVB0qPE17Gl8yOd6oM+Uqg
        Ra2Ir2u5t06pKWuVVNzNr63YCCYrcSqp9uYoPb2PZFCosTvpZXLUrXAC6wLZoES0IEJWjFKNvka
        GkI7Cfo37gDgtQ6ZRp7qZBnFyaf+FcGwDNQ/iXwky
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr18443746eds.100.1648765208972;
        Thu, 31 Mar 2022 15:20:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJS+G0lRPGKhUebBKREDAXsEcg0UrX4NCWqjao2fTUSk/VCXDWb6txzdyF194RLS6KRUjV8UwtsdLq0U1h44U=
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id
 n9-20020aa7c789000000b00413605d8d17mr18443736eds.100.1648765208701; Thu, 31
 Mar 2022 15:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220331151654.184433-1-javierm@redhat.com> <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
 <YkYA/Wpqa/PMczkp@lx-t490>
In-Reply-To: <YkYA/Wpqa/PMczkp@lx-t490>
From:   Javier Martinez Canillas <javierm@redhat.com>
Date:   Fri, 1 Apr 2022 00:19:57 +0200
Message-ID: <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ahmed,

On Thu, Mar 31, 2022 at 9:36 PM Ahmed S. Darwish
<a.darwish@linutronix.de> wrote:
>
> Hi Ard, Javier,
>
> Am Do, Mar 31, 2022, schrieb Ard Biesheuvel:
> > On Thu, 31 Mar 2022 at 17:17, Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
>

[snip]

> In case of (CONFIG_PREEMPT_RT=y && CONFIG_EFI_DISABLE_RUNTIME=n),
> shouldn't we add a small message in the kernel log warning that EFI
> runtime services are enabled for the RT kernel?
>
> In almost all HW, except custom ones with "verified" firmware, such a
> warning would be useful... This is especially true since in the embedded

I considered that as well but was not sure about what that message should be.

Since it will be printed even on systems whose EFI firmwares do not
have such long call times as the ones described in the commit that
disabled the runtime services for RT.

And in that case the warning may be misleading and make users believe
that a problem exists, which might not be accurate.

> domain, manually-configured RT kernels are almost always the norm.
>

Agreed. That is why the default for CONFIG_EFI_DISABLE_RUNTIME=y, if
CONFIG_PREEMPT_RT=y. So users will need to explicitly disable the
option if they want the EFI runtime services to be enabled with
CONFIG_PREEMPT_RT.

Best regards,
Javier

