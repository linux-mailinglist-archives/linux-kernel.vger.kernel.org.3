Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0851D862
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392218AbiEFNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346526AbiEFNCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:02:22 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576868F86;
        Fri,  6 May 2022 05:58:36 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i20so7963740ion.0;
        Fri, 06 May 2022 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfCqPDeeSaGFFEME8Ca8+0Y3WqdQwWkIOfIAg0xgMNQ=;
        b=qmDgoJ0izFpWUD+ROEjPOAPmt+1ewR7azB70xyNRmjxviEKMBdlPRCjCXKGqVtR0lL
         6j3U5GRoU8o0sufHiyyjcS0H4NPPYeNtJDq2aR1cVv09J+pTSYsUbLWu3Fo2xCdDErBq
         2qTisgxylEvpmJKPAKpl/J/oYsbBuBSzQm46vE6wMvCbJELMptrdHqWZwb0HRAX3viGS
         eJYTFCXE8KdyfbHiLDPshzWY0JPYnpFd+HVO5fJmGQGHV/64d2b/xtcEATZhDn+7T8d2
         F51mBRiRqMqLGXWfRUAFCrV8bsgCl1IFNBIYxoD4HARXp2AboZTfWb785s1JfA7kMO71
         j+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfCqPDeeSaGFFEME8Ca8+0Y3WqdQwWkIOfIAg0xgMNQ=;
        b=IBKs/6fsGzWbqpR+b3pSLqOakXbhO03uc2wk5yl/OSol5GcyJeX+R32Ts2xxc9Zp6y
         3617vLdGCmSgGZ43Zhc3XGc0M2V/GGRdILJx9xgtKInA4SLtKJGD/00s8+ZD++RYLuRN
         PqO5g2idtFTx6j0auSIDH/rgLt9TIYNtglWaDE5CG9xINiCQCcNKCrFGUV6W2QYLW9bA
         KZ84NbOT16TW2rqNN1WrBJTbagLse1qXwK3ih9dJWiGqT79DGdFedY9PG3CuziZP5M0r
         ztoncebghLVUWpuLDkh1BsIuYVZBDUW/rpdtJ2qoJHJSnqn4tP8i9ESAbVxDiASyQl11
         0HBA==
X-Gm-Message-State: AOAM532jLvCRJy7SvxDlT2fMal2WtM5fMApVTym2U0cFcjP3TjBT/RrB
        23kgPYoL5iblnJP0oTCTyydSxYX8hSBPZCNraT4=
X-Google-Smtp-Source: ABdhPJzPsUYCoRDJ7wUMHnrhe1fj8X/rzmYRw8AE0RtEIY/Z7nBJAiDrwvHeHpPQsI+z7YxbgmWteaiQd7H57FacCr8=
X-Received: by 2002:a02:8624:0:b0:32b:397d:eeb1 with SMTP id
 e33-20020a028624000000b0032b397deeb1mr1438879jai.264.1651841915781; Fri, 06
 May 2022 05:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220505191704.22812-1-ojeda@kernel.org> <20220505191704.22812-2-ojeda@kernel.org>
 <7e20c844dadacb3dac822220ca108f4d786ceb7d.camel@HansenPartnership.com>
In-Reply-To: <7e20c844dadacb3dac822220ca108f4d786ceb7d.camel@HansenPartnership.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 6 May 2022 14:58:24 +0200
Message-ID: <CANiq72m0unKrwRrb-tnYZ5w5oodJQ+3wNHMaQazeUSCOfUBJiQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kallsyms: avoid hardcoding the buffer size
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
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

Hi James,

On Fri, May 6, 2022 at 1:19 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> When you raise KSYM_NAME_LEN to 512, this on stack allocation becomes
> 2049 bytes.  How did you manage not to trigger the frame size warning,
> which is 1024 on 32 bit and 2048 on 64 bit by default?

Thanks for taking a look!

If you mean `CONFIG_FRAME_WARN`, that applies to kernel objects, not scripts.

If I enable it for `HOSTCC` with a 2048 threshold, we do get the warning:

    scripts/kallsyms.c: In function 'read_symbol':
    scripts/kallsyms.c:257:1: warning: the frame size of 2080 bytes is
larger than 2048 bytes [-Wframe-larger-than=]
     257 | }
          | ^

as well as in a few other places (e.g. for my config [0]), but given
it is userspace it should be fine unless they happen to end up
recursing quite a few times.

Cheers,
Miguel

[0]
    scripts/mod/modpost.c: In function 'main':
    scripts/mod/modpost.c:2636:1: warning: the frame size of 4208
bytes is larger than 2048 bytes [-Wframe-larger-than=]
     2636 | }
          | ^
    scripts/mod/sumversion.c: In function 'get_src_version':
    scripts/mod/sumversion.c:419:1: warning: the frame size of 4272
bytes is larger than 2048 bytes [-Wframe-larger-than=]
      419 | }
          | ^
    usr/gen_init_cpio.c: In function 'cpio_mkgeneric_line':
    usr/gen_init_cpio.c:223:1: warning: the frame size of 4384 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
      223 | }
          | ^
    usr/gen_init_cpio.c: In function 'cpio_mknod_line':
    usr/gen_init_cpio.c:293:1: warning: the frame size of 4400 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
      293 | }
          | ^
    usr/gen_init_cpio.c: In function 'cpio_mkfile_line':
    usr/gen_init_cpio.c:456:1: warning: the frame size of 12560 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
      456 | }
          | ^
    usr/gen_init_cpio.c: In function 'cpio_mkslink_line':
    usr/gen_init_cpio.c:150:1: warning: the frame size of 8496 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
      150 | }
          | ^
    usr/gen_init_cpio.c: In function 'main':
    usr/gen_init_cpio.c:640:1: warning: the frame size of 8528 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
      640 | }
          | ^
    drivers/tty/vt/conmakehash.c: In function 'main':
    drivers/tty/vt/conmakehash.c:290:1: warning: the frame size of
65584 bytes is larger than 2048 bytes [-Wframe-larger-than=]
      290 | }
          | ^
