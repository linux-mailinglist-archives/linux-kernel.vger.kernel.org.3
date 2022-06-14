Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D2F54B3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbiFNO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344072AbiFNO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BE6ABE31
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655218665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeP+puKC7iqc3JqJxcTM30hLBB3IQ9iXeo4CTxtOs1Q=;
        b=KkSArLTQ/EvpXl1gg4Kz2GcJXyVNUTRzyNCaqego3FtQTSkMMchCHJIBsB/eFJhffzDa8l
        9J0VJl/jWIRy2qRDkUNKllKcF0WK43qJxcZn3l67Y5lzZ4dmU+0R7EJqNH2eRMQTJcRMVh
        /Oe9dU/YRf15nIpLbotUCUR0ap4Gu4Y=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-44DjIFCGM6yjk8NnZnsiDQ-1; Tue, 14 Jun 2022 10:57:44 -0400
X-MC-Unique: 44DjIFCGM6yjk8NnZnsiDQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-30c24697ffaso26950397b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YeP+puKC7iqc3JqJxcTM30hLBB3IQ9iXeo4CTxtOs1Q=;
        b=hvq87KFuJG5xAAeUaUSccDnzSQQJJQx3AjI6jkyAZAHWfSrrPtqZhjoWGcz8KNT9Cv
         8nWHmNE18vTkP/mIJT9/OyQGHmTT1EGWxsLieIX0VDYwJWzP1sZT/UYHBSGmQjFEmlag
         /0mrGTwaBIXYpmlLjEyYJRILoVMSFZ3Zwr9Opn6EhBD0f8wMCkwL5WsY8H4PNq7INhsA
         /8zRn3Sw1Vv4QeKoH984tEBM0L+CA0bSPUN8KiDjqP51FGdv6V1m8yIVWQPbJMTjkuKc
         j85jeTHrAhf03tbEjKk6kPD8GMvHDLif8pWWJYILBpMSQxjIXrAS+JmvmWijDCeac2rH
         SeOg==
X-Gm-Message-State: AJIora+qJDuj/HqRX0u/KRBRqXChW+IYVfUcXfX1DMo0p4SiP6dGVIw4
        ce/Y10ZpCbXK0J7g0TiUvxxN1AKQuAQRPt8Z1W46z0s24vbsTpT5QXJ8hUQnWlpvYIpvaTum7i5
        zR5sTaGsnfvuuKzT6Q0U3O/ptlC/EH5Kvy3S8cSka
X-Received: by 2002:a81:7010:0:b0:30c:c6cf:d4af with SMTP id l16-20020a817010000000b0030cc6cfd4afmr5862960ywc.459.1655218663604;
        Tue, 14 Jun 2022 07:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8GVmlpkJpn57LvMwqo6xyPSPwlUXKLw0485OkqUNbYQO5UFtXFwV5ecJBeDNPb/f1EuNf+nKY6oA09EKvnac=
X-Received: by 2002:a81:7010:0:b0:30c:c6cf:d4af with SMTP id
 l16-20020a817010000000b0030cc6cfd4afmr5862927ywc.459.1655218663378; Tue, 14
 Jun 2022 07:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220613135953.135998-1-xiujianfeng@huawei.com>
 <CAFqZXNvHB0cftgbK+mScbZbcO71OLpXrBMxWAx1z1eB27mm8Cw@mail.gmail.com> <f7151722-6450-7efd-1e3d-e31245dc3da2@huawei.com>
In-Reply-To: <f7151722-6450-7efd-1e3d-e31245dc3da2@huawei.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Jun 2022 16:57:32 +0200
Message-ID: <CAFqZXNvb2AD6T6NcubAbbzdbNoU1ThZ_P+5ioG844mnEs_9=xA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_state_kernel
To:     xiujianfeng <xiujianfeng@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        michalorzel.eng@gmail.com, Austin Kim <austin.kim@lge.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 3:35 PM xiujianfeng <xiujianfeng@huawei.com> wrote:
>
>
> =E5=9C=A8 2022/6/14 20:57, Ondrej Mosnacek =E5=86=99=E9=81=93:
> > On Mon, Jun 13, 2022 at 4:02 PM Xiu Jianfeng <xiujianfeng@huawei.com> w=
rote:
> >> In this function, it directly returns the result of __security_read_po=
licy
> >> without freeing the allocated memory in *data, cause memory leak issue=
,
> >> so free the memory if __security_read_policy failed.
> >>
> >> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> >> ---
> >>   security/selinux/ss/services.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/serv=
ices.c
> >> index 69b2734311a6..fe5fcf571c56 100644
> >> --- a/security/selinux/ss/services.c
> >> +++ b/security/selinux/ss/services.c
> >> @@ -4048,6 +4048,7 @@ int security_read_policy(struct selinux_state *s=
tate,
> >>   int security_read_state_kernel(struct selinux_state *state,
> >>                                 void **data, size_t *len)
> >>   {
> >> +       int err;
> >>          struct selinux_policy *policy;
> >>
> >>          policy =3D rcu_dereference_protected(
> >> @@ -4060,5 +4061,11 @@ int security_read_state_kernel(struct selinux_s=
tate *state,
> >>          if (!*data)
> >>                  return -ENOMEM;
> >>
> >> -       return __security_read_policy(policy, *data, len);
> >> +       err =3D __security_read_policy(policy, *data, len);
> >> +       if (err) {
> >> +               vfree(*data);
> >> +               *data =3D NULL;
> >> +               *len =3D 0;
> >> +       }
> >> +       return err;
> >>   }
> >> --
> >> 2.17.1
> >>
> > security_read_policy() defined a few lines above has the same pattern
> > (just with vmalloc_user() in place of vmalloc()). Would you like to
> > send another patch to fix that function as well?
> No problem, patch already sent.

Wow, you're fast :) Thanks!

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

