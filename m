Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6849956AF19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbiGGXkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiGGXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:40:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8660539
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:40:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so133683wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpm5T5rrAKH4mSookDRGpy+67Q9o6aKuYw1+9EoK1vQ=;
        b=KbGt49C9L59Bpvx1m1Ad3LlnQbW/JZFrzQsv5EblzyBkQ9StrftKOHLk00Cgp17eWV
         xmFdWqHX1JAT6vJMmadhxu8XPg3UxRpveHwFJc8Di+aPaT/JEV8x84Ab2yWru7dcLsZS
         l4aBQwOIFMlfD9LWt3Odc6HlB478R4au3yWbekprQy4lYEWHxthrjZtKxWfxLeIGQWHJ
         ExAF0qTUC4tKQ1pFyi9mFFutI1lERYIjiWyduti1cVLEmjnkenWhHvNO065llo6UFw3v
         222bugfioJW1PIy0wHfZ1JujYxqI07UFid569YdDRc+d73HmMFxk/NtOvKN2Zt3Ot6EO
         hksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpm5T5rrAKH4mSookDRGpy+67Q9o6aKuYw1+9EoK1vQ=;
        b=SPrx9ou7w+chjEcWJ3CQ9N6AwiTPEy+dO/m/mL8KlnvVa8G1m+st5+A54lnHT3zZGC
         Fo8fbmQQ1RoDc3SHIEOC8QvdbNJEptNNWjzRMNRJnj6aiNWB1jLLiw5dtPABSQXQWZ2T
         r/RBYQXcYYzm0ltANEH0+/eIbExiI9XrOl84aty0NNtLv0IuSpcHRFBX6uZbodxl9xCb
         ujIRc8QovzS9FrufUKwzqECdWhwpYHkCxfh/z49c0INbwUr1Io9XvpcLqyYP5Xg1h/lO
         hCka900+mUUdwV/Kp3sTpbf0ybFHsrWReBLKgAzoiKDZjSaeZfGAETWWXe57v5viPEnU
         MQzA==
X-Gm-Message-State: AJIora/f6waox8Z4n/87/pgNDUGBlNHebuXmwlOy2yJm2+mT1rnCQTgm
        6x+tQk5mXx78VFxeymNji/8=
X-Google-Smtp-Source: AGRyM1uIddC9eip6lfVZ65ltrxoHMS/51LDdcQmBhhU1DC6ST66K64iAhEXXDGC2WzpO1Yh2n1+S+A==
X-Received: by 2002:a7b:ce8a:0:b0:3a1:8ead:2ae5 with SMTP id q10-20020a7bce8a000000b003a18ead2ae5mr355455wmj.100.1657237228520;
        Thu, 07 Jul 2022 16:40:28 -0700 (PDT)
Received: from opensuse.localnet (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b0039c41686421sm289124wmg.17.2022.07.07.16.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:40:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] kexec: Replace kmap() with kmap_local_page()
Date:   Fri, 08 Jul 2022 01:40:14 +0200
Message-ID: <4410443.LvFx2qVVIh@opensuse>
In-Reply-To: <20220707184939.6086-1-fmdefrancesco@gmail.com>
References: <20220707184939.6086-1-fmdefrancesco@gmail.com>
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

On gioved=C3=AC 7 luglio 2022 20:49:39 CEST Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().
>=20
> With kmap_local_page(), the mappings are per thread, CPU local and not
> globally visible. Furthermore, the mappings can be acquired from any
> context (including interrupts).
>=20
> Therefore, use kmap_local_page() in aio.c because these mappings are per
> thread, CPU local, and not globally visible.
>=20
> Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
> enabled.
>=20
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  kernel/kexec_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
Please discard this version because there is a small error in the commit=20
message due to bad copy and paste. Version 2 is at=20
https://lore.kernel.org/lkml/20220707231550.1484-1-fmdefrancesco@gmail.com/

Thanks,

=46abio


