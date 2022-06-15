Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F83F54C12F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbiFOFlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFOFlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:41:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2254A3C6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:41:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s12so21053479ejx.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KN6L6DSfmYA7zey+PA8UdHfC7OKq4MhMKhks1KAMEAg=;
        b=L3zfvBwLfy7iqj6moUpIh1oiBrytFQZB4Qy1wiNw+7PcHuc2a31ik3n0S8a0nr9QEz
         QE3pJywAC7SeAYBaJj5O4JjNFs13Z/hn/LlT94gKj3CsxLQOYHqr77dOpyiQl4MsbrW1
         /Q/P5xSTzy5S/aK+0XRU/1dLfiCUFfd3MGTFJaRU+luWVJ3LyUyiFgJbgytG1MX3yCjy
         nBIsMmsdFNa4s8Tdnp6t7HfvzOamwtObZFtz83quin59fvz+sVJHRBxLT7yZzhX45W3G
         mpLL0rUxJtV4SfMkyt8jgOLf7j9EJw526vhkSOjBO1OqzwRg9nmFjOulpXQSDiochjO2
         sbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KN6L6DSfmYA7zey+PA8UdHfC7OKq4MhMKhks1KAMEAg=;
        b=yay8e6rTL4oDZzAj6rac/u4EpY/BvyqaEHSofOrmpBOADkVZKaM6IeT6cwnfi9a5W6
         F6jCW21SZ5q7P1ng5B2hlYAvxIY/Rdcv/nhQzA3mf9bVZ3350CajPMxhnQrRzMl60zPZ
         ZSMMtFj0yyYLSY2gFNJZXSQTds5rHdFSKjrtlx7RXdVcIAVdAyTTFxwpbuAp2lvZD3n1
         mgOjVrzJOSXcV/LGFAo6s1u96GPSSMeHOfSGCbhqg2dIcWAp5aO+qGItcRnDgb32p2b/
         8msP+gqwn7BNAFwOOIEDexXQQ2LDSUXxFFEFcaUW+g/gs2o0l6vYNWXgdEhtm+EwMgBF
         HgSA==
X-Gm-Message-State: AOAM532zM1U2x/ntWTMxgGqDQxaMqXiAK+U7vOq2q/n8vHoONiccNo/8
        UAB/OxcfCjLxb+1drlrorOQ=
X-Google-Smtp-Source: ABdhPJz42ifUMTtTBIP/J5etLko/VUugoJm7LdMTQAEPt0csXC8FQ7rx0rr9t/wGn4W/xm60KLI19A==
X-Received: by 2002:a17:907:6d0d:b0:711:c940:7f1c with SMTP id sa13-20020a1709076d0d00b00711c9407f1cmr7178230ejc.399.1655271661492;
        Tue, 14 Jun 2022 22:41:01 -0700 (PDT)
Received: from opensuse.localnet (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id i27-20020a50871b000000b0042dcbc3f302sm8483870edb.36.2022.06.14.22.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 22:41:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] highmem: Make kunmap_{local,atomic}() take pointers to const void
Date:   Wed, 15 Jun 2022 07:40:59 +0200
Message-ID: <5276974.Sb9uPGUboI@opensuse>
In-Reply-To: <20220615051256.31466-1-fmdefrancesco@gmail.com>
References: <20220615051256.31466-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=C3=AC 15 giugno 2022 07:12:56 CEST Fabio M. De Francesco wrote:
> kunmap_{local,atomic}() currently take pointers to void. However, this
> is semantically incorrect, since these functions do not change the memory
> their arguments point to.
>=20
> Therefore, make this semantics explicit by modifying the
> kunmap_{local,atomic}() prototypes to take pointers to const void.
>=20
> As side effects, compilers will likely produce more efficient code and
> they won't any longer need casts to pointers to void where these
> functions take arguments of type pointer to const void.
>=20
> Suggested-by: David Sterba <dsterba@suse.cz>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> v1->v2: Change the commit message to clearly explain why these functions
> should require pointers to const void. The fundamental argument behind
> the commit message changes is semantic correctness. Other bonuses come as=
=20
> side effects. Obviously there are no changes to the code.=20
>=20
> Many thanks to David Sterba and Ira Weiny for suggestions and reviews.
>=20
>  include/linux/highmem-internal.h | 10 +++++-----
>  mm/highmem.c                     |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
As said in another email, this is the second version of "[PATCH] highmem:=20
Make __kunmap_{local,atomic}() take "const void *"". You see that I changed=
=20
subject (involuntarily, that was just a mistake when formatting).

This is why I'm writing: make Maintainers find easily which patch this is=20
the second version of.

Sorry for that unwanted change to the subject.

Thanks,

=46abio


