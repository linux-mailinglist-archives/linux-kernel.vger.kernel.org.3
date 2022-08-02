Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0035758841D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiHBWUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiHBWUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:20:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75041997
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:20:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tk8so28309819ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3w2KqqM6Jon4wwPxOegeac+q79TdKrQ7N+AdrcSklFg=;
        b=H9BrTRLxOTaQlJ7/9iMdxEhU56cAjt38vgP4aXI9tjpNEj7NTnaimqQOHdoBqgS2WK
         G0vC8ZgWAYr843jGgPK9tLYckA6+aM+Iadoi+3epi1lmi/foBRdrxAob0URoiFr02BUA
         DF4HBlqMRXMHisqqe7OY1TXHjYw49r1kimsZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3w2KqqM6Jon4wwPxOegeac+q79TdKrQ7N+AdrcSklFg=;
        b=jymJdfQjvIzdpDxLe4Xjd3ZukPzN8LBlChHSHD2yXfvwwyl6/TFRIA3rQnTs2ENQMs
         MEztOFGrj6tDNdbZGObzmY9AuwaVehjtPCqezScDzbkliQ+9b89cCJm5v2p3Tj4SMPre
         ifZ3LEu7n+wjRS6IxbXsw6jKY0AkMQYiMriEJkrWzgDeDybkaj7+vt1wte53AmMyqzY9
         hgPte+OavVLWOw+AMKSq/7E4runk/UYyeRY39Q3cWnOUSkUY6AFYBKj7imReMUwI7d4m
         yXTqBrX+WrhIMu60R4PWl7/5hbShSPthFtXAfGgiJnbYSBTumZGyIib3Y+pwC9rCXmkC
         rHrA==
X-Gm-Message-State: ACgBeo2PvYRssSJLoLKgGv9ugb2kYictGvGppM+3dRoPV5BZXq1M1FD1
        mdwx6MWt178B61ZtfU8hLdhv40qlF13zfpt0
X-Google-Smtp-Source: AGRyM1svmzotAqyOsgg2CHkX8IvFLA9Ph69QRFGCP015WqSQqZbln8I1mokCq3RNOoseiIvehQ0fdQ==
X-Received: by 2002:a17:907:1608:b0:730:5ad0:ae1a with SMTP id hb8-20020a170907160800b007305ad0ae1amr12817462ejc.222.1659478802736;
        Tue, 02 Aug 2022 15:20:02 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id la21-20020a170907781500b007030c97ae62sm6634179ejc.191.2022.08.02.15.20.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:20:02 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n20-20020a05600c3b9400b003a4f2261a7eso47365wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:20:02 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id
 i19-20020a05600c355300b003a32b65299emr824925wmq.145.1659478801765; Tue, 02
 Aug 2022 15:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
In-Reply-To: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 15:19:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wim4B671BOPfxoXDSz0xfOruqoKCMQrjAX0R95PH5Wy4g@mail.gmail.com>
Message-ID: <CAHk-=wim4B671BOPfxoXDSz0xfOruqoKCMQrjAX0R95PH5Wy4g@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v6.0
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 7:40 PM Micah Morton <mortonm@chromium.org> wrote:
>
> This pull request contains one commit that touches common kernel code,
>
> one that adds functionality internal to the SafeSetID LSM code, and a
>
> few other commits that only modify the SafeSetID LSM selftest.
[...]

What odd MUA do you use that causes this double-spaced text email?

I can read it, but it really is a bit strange. It was all plain text,
and marked as utf-8, and otherwise looked normal except for that
double spacing.

I get flashbacks to my "writing papers at university" days.

             Linus
