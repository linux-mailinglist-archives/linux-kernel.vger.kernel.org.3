Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581255340F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiEYQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiEYQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:02:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690F56B7FC
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:02:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id er5so27568577edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lb8jI+HgCwwCo9V7MBgxPMSbhS6L6pVhhain2dWQdfw=;
        b=SrcSxh5jk6TjzFY/hFo4GziSI+tKwhTA+Bvj+vAZBzjRzoe5Yq5yUQ8S6OgM7ow5UA
         I1rF2QLtzS87ewjkBnw11tZEocdxf3LdCJ+RmmexCCKPZsRw7wjUq4DXjoL498yjLWPZ
         rYUCkLMUhIDW61u3uDHvosCrwx9NoPonecdyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lb8jI+HgCwwCo9V7MBgxPMSbhS6L6pVhhain2dWQdfw=;
        b=XDuxkXKuyCozrk2DpFqKIibpzwhIVQnhtYlPfjOsAn3fWSUYtyVnoVhAqO1tRXzxGZ
         JFQ4qH1sqTAG96vXov/wF7cINFsD+jTTz4HSzJbCdEwyrR+tDt6tVl0lTpLJbfjXL9jm
         1J/dzirocBXeXqlgz4S5mk8e+kMBE1T97FsXq/JWbpla1cm9ekkBvfsOyY0XyIDLTwmg
         kgOAwTGcwYAk9er5yg4XBywnNxtSShB5OSA6/xcX4mbpUdB6K/lOTHncpi7OORZWuZf0
         rDCuXcU/VIIyPVglZ/KaLPDOye4M96HTqYF0shAo0DG0zBgES2unxVCXI+p5QE9FcpfW
         fjHA==
X-Gm-Message-State: AOAM530h9lzp1Gl57vcfNUbPsTVaQuIffLY8JJgO851SHdZV9zGAqMFQ
        /qufXYshufxumPCy5nlFnMOJblONfUdZ2eTn
X-Google-Smtp-Source: ABdhPJyed6CJ6lNWlKrFqbGgBuXMEEkvAauPEM9ReLmDr9eTi96hbxlbqo/XqiFrgWWtcRbSEbwqoQ==
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id b10-20020a056402084a00b00423fe998c53mr34809571edz.195.1653494559105;
        Wed, 25 May 2022 09:02:39 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906225a00b006f3ef214db9sm8266378ejr.31.2022.05.25.09.02.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 09:02:36 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id x12so6495435wrg.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:02:36 -0700 (PDT)
X-Received: by 2002:a5d:59ac:0:b0:20e:6fd6:88c1 with SMTP id
 p12-20020a5d59ac000000b0020e6fd688c1mr25406709wrr.442.1653494556145; Wed, 25
 May 2022 09:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220525144638.293934-1-helgaas@kernel.org>
In-Reply-To: <20220525144638.293934-1-helgaas@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 09:02:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whk=ygWsxt=1HhndCwjtXdga9sPmkxFGby5PJWRk5yx9Q@mail.gmail.com>
Message-ID: <CAHk-=whk=ygWsxt=1HhndCwjtXdga9sPmkxFGby5PJWRk5yx9Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "linux/types.h: remove unnecessary __bitwise__"
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, llvm@lists.linux.dev,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Wed, May 25, 2022 at 7:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> This reverts commit c724c866bb70cb8c607081a26823a1f0ebde4387.
>
> Jiri Slaby reported that c724c866bb70 ("linux/types.h: remove unnecessary
> __bitwise__") broke userspace, including open-iscsi, because it uses
> __bitwise__.
>
> Restore the __bitwise__ definition.

Hmm.

Presumably it's only the uapi case that actually wants to re-instate it.

And I'd rather make that "__bitwise__" case explicitly special, with a
comment about why it exists when the kernel itself doesn't use it.

IOW, rather than the revert, maybe something like the below
(whitespace-damaged) instead?

Jiri, does something like this work for you?

                 Linus

---
 include/uapi/linux/types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index c4dc597f3dcf..308433be33c2 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -26,6 +26,9 @@
 #define __bitwise
 #endif

+/* The kernel doesn't use this legacy form, but user space does */
+#define __bitwise__ __bitwise
+
 typedef __u16 __bitwise __le16;
 typedef __u16 __bitwise __be16;
 typedef __u32 __bitwise __le32;
