Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22252508DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380800AbiDTQ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiDTQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:57:07 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D633F3E5C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:54:20 -0700 (PDT)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 23KGrnri003946
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:53:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 23KGrnri003946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650473629;
        bh=z2vQXfsB4fXcjEsk0DIVaRzap9JiljN6sNWS4DQ1igw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eg+RtSp9AsBhjhK2prhsGIEj5CN/ry7/pGzK3EqRUOTIPS2v9WskwfE2pEIZqjR4c
         JQkXaUXv/9E4YZB3mQ6/A8WnZR4y9G4gQTE3rD0iHS/LFQD3eSm6k5Hrmmcb+9c4Ig
         vtizcyRWVNvXRJeJ01/I1F1dbzVcGf+QkNBIQkUV9bU90tqmchjtSrYs8OLL4PB9pH
         nPhQyZ9hQHV+tFJ643rUHXietgH6SvTpVv9hm3xGugY6Txvu3QzleHbCaWefufhkw/
         DZqJ8Vyzkuv/sfzBqBs6CCa6Jzx7b2P41Jf8M0LmzHuNCQy4y59cNE+0vlHq1+TucF
         e7CiiKrc4gFcw==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id p8so2469792pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:53:49 -0700 (PDT)
X-Gm-Message-State: AOAM531NnsMCDwMr+B85LEINAM6A9HcC+Jt6O3VjR/QuZ+BspDpXbIVm
        bJ7X+VauA4QJYyWGi7/l753JXwTI3QT+WGOLbL8=
X-Google-Smtp-Source: ABdhPJzE85rGVe/eao0UDw4UZervYHePBzjr5r9QXOwN40U2faUR8iNPFtDsVHL+PTnARoyuO8Iw0LS5/+47oVeY0uQ=
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr19699006pgb.616.1650473628452; Wed, 20
 Apr 2022 09:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220413233649.1394087-1-danielmentz@google.com>
In-Reply-To: <20220413233649.1394087-1-danielmentz@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 21 Apr 2022 01:52:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQSeTnaHbsTTaY-2nD8Nb=44nc06EicNMhxh_zze-Tj9g@mail.gmail.com>
Message-ID: <CAK7LNAQSeTnaHbsTTaY-2nD8Nb=44nc06EicNMhxh_zze-Tj9g@mail.gmail.com>
Subject: Re: [PATCH] kheaders: Have cpio unconditionally replace files
To:     Daniel Mentz <danielmentz@google.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 8:37 AM Daniel Mentz <danielmentz@google.com> wrote:
>
> For out-of-tree builds, this script invokes cpio twice to copy header
> files from the srctree and subsequently from the objtree. According to a
> comment in the script, there might be situations in which certain files
> already exist in the destination directory when header files are copied
> from the objtree:
>
> "The second CPIO can complain if files already exist which can happen
> with out of tree builds having stale headers in srctree. Just silence
> CPIO for now."
>
> GNU cpio might simply print a warning like "newer or same age version
> exists", but toybox cpio exits with a non-zero exit code unless the
> command line option "-u" is specified.
>
> To improve compatibility with toybox cpio, add the command line option
> "-u" to unconditionally replace existing files in the destination
> directory.
>
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---

Applied to linux-kbuild.
Thanks.


>  kernel/gen_kheaders.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 1966a749e0d9..0c78e64f747d 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -74,7 +74,7 @@ fi
>  # of tree builds having stale headers in srctree. Just silence CPIO for now.
>  for f in $dir_list;
>         do find "$f" -name "*.h";
> -done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
> +done | cpio --quiet -pdu $cpio_dir >/dev/null 2>&1
>
>  # Remove comments except SDPX lines
>  find $cpio_dir -type f -print0 |
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>


-- 
Best Regards
Masahiro Yamada
