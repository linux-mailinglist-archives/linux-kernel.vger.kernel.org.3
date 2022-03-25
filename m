Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963934E7269
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357122AbiCYLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiCYLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:47:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA068D3AEF;
        Fri, 25 Mar 2022 04:46:15 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z6so8611230iot.0;
        Fri, 25 Mar 2022 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=yuPZAq3ZYUPbLpLKOS/jc7hlwjV26RLWmc573RYnU2A=;
        b=AkeJ80vJz9TspKKR1V78P6leNzy/zWt3X5qpCiokIarPrfRm7bP82VVl3kMz1L3xPW
         wP1CvS+iVVTt8m6TcWOh8beWqc1ryAZm0iMgSnbIE/VwKaG4068+loX09vRs3upbCzci
         H1nwMcOB1mLmKlng7NjrF760XD/XERztwOAMqIw2E2M2OWT9b5ytcqa8HIuD+WMkna+l
         RoPTmNI00ntyc7KSk9FDQs06tboiYJ2LluJ3IbUc62ZjMk7hALHxdJZrCS99As/8GxXR
         vusOHzXCaBtHR/MnmB2RX2h1+2rswETDl08D5LSLq5FfrMSqBm/W/dch9KlEQDi0jyrr
         k+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yuPZAq3ZYUPbLpLKOS/jc7hlwjV26RLWmc573RYnU2A=;
        b=BV9JQS3H9M1fvN2QlnXZAP+JdYCIdvfnaz59NXVZ79hOas3uO4QIuFFJzpUI/tFWNG
         Dlwoy9nFPCqcdblt3Cu3tvUcocFCJeEAPfqMIFEnXaK64D7ISZITYS98b6exwWS+75Nv
         mUVh3EayIFhrwNUy304JUQdSBGAAwUOrXY3jmjBjFseLagYPFsULgNIj4jQa6/p2BlFQ
         vNMUoZ3kYI++aUYbgsakzCHQEVhToSIaJjTzb4RTlr41bCdajhwVNTb+6HMU4X27rqEI
         olhbPRBG0AULFIGe9sgyYLkJqt3uDe68RANlMI7a4AOtu7qeZwYRgnPg4NayrrV3l6Yk
         D1DQ==
X-Gm-Message-State: AOAM53284Y1HUhoTnf+tSYhKs1z2EhOf/lLxw19xEb1KTXj49iMrsqK1
        C05mbdlbwC5altWCzUhY6+d7M37e+4xxmWt8Jqg=
X-Google-Smtp-Source: ABdhPJwdeHv9CSgNylB9p3HPspFmJpE7ZpiPMI+Ktns/h7A/ZsdB+qotNh75aLovra9ycEkVF/Pbu8Elb+rI7hb8WoM=
X-Received: by 2002:a6b:f60d:0:b0:645:b224:8d45 with SMTP id
 n13-20020a6bf60d000000b00645b2248d45mr5299614ioh.131.1648208775189; Fri, 25
 Mar 2022 04:46:15 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 25 Mar 2022 12:45:39 +0100
Message-ID: <CA+icZUXYH4xfWtR=P8jXQfks7=zh0Os45yDFOiHNtM_KNWrfiw@mail.gmail.com>
Subject: Re: random: treat bootloader trust toggle the same way as cpu trust toggle
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Graham Christensen <graham@grahamc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Unsure which ML to CC - see [1] - so I used what was CCed in [3]]

Hi,

I am not a security expert but following the exciting changes to
random/crng changes in upcoming v5.18 and using it on top of Linux
v5.17.

Just saw this typo in [0]:

diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt
index c658e5d2d52c9..b9d764a492078 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4400,6 +4400,12 @@
  fully seed the kernel's CRNG. Default is controlled
  by CONFIG_RANDOM_TRUST_CPU.

+ random.trust_bootloader={on,off}
+ [KNL] Enable or disable trusting the use of the
+ a seed passed by the bootloader (if available) to

What do you want to say: "the" or "a" seed :-)?

+ fully seed the kernel's CRNG. Default is controlled
+ by CONFIG_RANDOM_TRUST_BOOTLOADER.
+
  randomize_kstack_offset=
  [KNL] Enable or disable kernel stack offset
  randomization, which provides roughly 5 bits of

Thanks for your work!

Regards,
- Sedat -

[0] https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=3032aedb16c77747f6a97d216887daec2b44f273
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n16315
[2] https://www.zx2c4.com/projects/linux-rng-5.17-5.18/
[3] https://marc.info/?t=164797651800005&r=1&w=2
