Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4874754C567
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiFOKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbiFOKEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 455E53EB8C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655287485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KvqCVAQytjRC5pnGMZtj//UN+D95bGj8Ywb9fXgge+Q=;
        b=N8RQjR22V7tddQx2XE8MiMGkjUmUay1wF6BME5Pffisb2J6vPAS22tVqKgYSarC50Fty73
        UuF3Due/TDYLso8PFkCkkJIJpkkJoJ7+w8Dm8vqQevKvSP10Nb/MGLK6oW4iCUEjQ6XpLP
        DnjVq2H1Zt3Nab0ehdDkXJfHxbnzBDo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-UaWmj1YCP4Kzp8IDaK-JYw-1; Wed, 15 Jun 2022 06:04:44 -0400
X-MC-Unique: UaWmj1YCP4Kzp8IDaK-JYw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-3175eae9b09so669887b3.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvqCVAQytjRC5pnGMZtj//UN+D95bGj8Ywb9fXgge+Q=;
        b=U7CkYsnAqJUC9CbT4Y9B6SyItBRceHeY95zapBeER8WBICHwsE8BNgLbZ93HncAx5u
         dP1FnifRgE8ZsVxCFefzXXl2YVfBbAFhC5m8PuNBCtjDVHlo0R+L4LXTW0QdO2P5waj6
         u0dnYJEH3Jy6XtZb1pNGHxOhftqB4A8ADBDPeXepDjHqb4NhvLgYngdI2HXAVfWYYzcn
         NLD55SBSvMfegKN1lYl2YyNrZ6uFxuG3JdLAdaQKmLxvTrRnYGzIDoaOneI4RytimWUi
         1yE1QHW44Y7Cotrt1S+EDR45qb3hED97uAmD+l8VZtHWeV9uZXpurLZkp/dP+mrvANeD
         wPTA==
X-Gm-Message-State: AJIora/USkIA2Y16HE986WdHS7Tx0291k67NXfGpTP9liqZaqX72jFRj
        cy5pOCZqQo+smPxpBE8NqlxDgKjgskRpq7nur47tGsqgOlUvWjsnEekRO6k+VBjAcLDhBNLaiq6
        QHyEADjOnzbkdZaQ0hcQyW2HH1WKTWMXuRPgqSUXT
X-Received: by 2002:a25:ce83:0:b0:664:6360:41ae with SMTP id x125-20020a25ce83000000b00664636041aemr9332108ybe.336.1655287483808;
        Wed, 15 Jun 2022 03:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sog9oD2BqIWvP3CAFG43nkBsaYyHyvoIWuWX1RsymVn4h6TgCzec2lpGYRhIMdWb9bnF1C+G0tHgDtlISsc/M=
X-Received: by 2002:a25:ce83:0:b0:664:6360:41ae with SMTP id
 x125-20020a25ce83000000b00664636041aemr9332079ybe.336.1655287483476; Wed, 15
 Jun 2022 03:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220614132333.143042-1-xiujianfeng@huawei.com> <CAHC9VhQdfPBn4kbY0xRPaCvNBJJGdQQe_90A4Hhdsj6gVr6pAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQdfPBn4kbY0xRPaCvNBJJGdQQe_90A4Hhdsj6gVr6pAQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 15 Jun 2022 12:04:32 +0200
Message-ID: <CAFqZXNswaUiHNZA65GCsgB7GNLm6tc2OFXsQrTWxBTfWviQ8+g@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_policy
To:     Paul Moore <paul@paul-moore.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Austin Kim <austin.kim@lge.com>, michalorzel.eng@gmail.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 4:03 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jun 14, 2022 at 9:25 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> >
> > In this function, it directly returns the result of __security_read_policy
> > without freeing the allocated memory in *data, cause memory leak issue,
> > so free the memory if __security_read_policy failed.
> >
> > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > ---
> >  security/selinux/ss/services.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
>
> This is another case where there is not actually a memory leak as the
> only caller of security_read_policy() is sel_open_policy() which will
> free the buffer it passes to security_read_policy() on error.
>
> If you want you could add a comment to security_read_policy()
> indicating that the caller is responsible for freeing the memory.

Can we please not have two almost identical functions with different
cleanup conventions? Please let's either make both functions guarantee
cleanup on error or neither of them (adapting the caller(s) and
comments accordingly).

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

