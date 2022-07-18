Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF0578A89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGRTSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiGRTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:17:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA82F660
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:17:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ez10so23056325ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TdpNh/OtxrXAgRkyZLTx7sdU3f7L5qyIViCiqKyQJ5I=;
        b=OFD0dfOkX/Ub3w/l4upU/yo1HLwEnU8/D4qFP8bCzSuiF0FPoYp9aqVZAXPaNWYmg5
         j6RR4FW3j0s/IQEJ24FN9jyOjGCh5Wrep+tS1pwAh/psbXQ75dFjKYKDtw5SUqUfKpAk
         pF8xp6rX5tMH86kWWgvw2+CO5ipjAHrRrG0vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TdpNh/OtxrXAgRkyZLTx7sdU3f7L5qyIViCiqKyQJ5I=;
        b=4sv7/5/hyXw9nuttMz44Vg5CadqfdhCDpET1O15fgZjcnqIq59FzJehDOhn6p+HkW4
         lvKH42f7cSlcCph2Tem08dfOlhFpvTELTMsmLGFJN0/5D+h9nBq+IqZL/xxmyHwElYYe
         3z0cK1WP5IV9MBDUcabSNQjBGQ9Fc8FYPfpClxNb23EEJs1iUMZ/UJvo2rllO30+p4K/
         sfEw5C8Rq4Al8bi+5IU+EmfFPCQCwjhwD9PnHhoHp6LX1Pt1sUOP2KUeGrh9OJ0zNGBH
         G/OXj+Ik3gVYllkhdLrtvGwbX+v7Zkx5qFBYvn9T+pGmrFz6CIopi5uTWK8BmuJEaocq
         KZcg==
X-Gm-Message-State: AJIora/ef9wRxhASilbxDQfgoEvOWvtfnfI7qLOHoc58rtN+ueDmzYmM
        HVaxEVaPSjkA8eeSahBjm9bGSGaDVnqR/tT1xNE=
X-Google-Smtp-Source: AGRyM1vGWNfJZ362b+OLQ+4CCoEJ9Af54Px2LWU/lW25Pu25LgDTQD+jey/qD1bxFiTQdRnDkhaFqA==
X-Received: by 2002:a17:907:970b:b0:72b:5919:506c with SMTP id jg11-20020a170907970b00b0072b5919506cmr26383766ejc.241.1658171875507;
        Mon, 18 Jul 2022 12:17:55 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7de9a000000b0043a7293a03dsm9052653edv.7.2022.07.18.12.17.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 12:17:54 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id n12so5624564wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:17:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr22879411wrb.442.1658171873851; Mon, 18
 Jul 2022 12:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com> <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com>
In-Reply-To: <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 12:17:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
Message-ID: <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:04 PM Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> The regression in question caused overlayfs to erroneously return ENOSYS =
when one lower filesystem (e.g., davfs2) returned this upon checking extend=
ed attributes (there were two relevant submissions triggering this somewher=
e around 5.15, 5.16)

Well, if that's the case, isn't the proper fix to just fix davfs2?

If ENOSYS isn't a valid error, and has broken apps that want to just
ignore "no fattr support", then it's a davfs2 bug, and fixing it there
will presumably magically just fix the ovl case too?

Yes, yes, you point to that commit to util-linux to also accept
ENOSYS, but that's from 2021.

So it's presumably triggered by the same issue - a rare (or new) and
broken filesystem returned the wrong error code.

Let's just fix that.

I do not object to *also* doing the ovlfs "accept ENOSYS too", since
it seems harmless and understandable, but at the same time this all
does make me go "the actual *fundamental* cause of this was davfs2
being confused, it should be fixed there too.

And yes, yes, I realize that davfs2 is out-of-tree fuse filesystem,
and is not in the kernel. But have people made the bug-report to the
maintainers there?

I don't think we should *only* have a kernel-side fix for a broken
FUSE filesystem. Particularly not one to some random bystander like
ovlfs.

In fact if we do a kernel patch for this dodgy filesystem, it would
seem to me to make more sense to have FUSE notice that "ok, ENOSYS is
broken for this situation, let's translate it to the right ENOTTY",
and that would have fixed both the ovlfs case and the util-linux one.

Hmm?

              Linus
