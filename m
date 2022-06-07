Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A0E5421C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441801AbiFHAxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448881AbiFGXJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:09:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0938237C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:45:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a29so1617768lfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=on30OEe/DO5zamISOEay2WIQIU04GrMtf4oLpYULsi0=;
        b=qiK8I6WsrgYjyC91chUFuazIMqEbG3bN/GrHqaSMF4F8x6MV8QSOzCE71g3Nm8aqBY
         GkphlLTEkCrLci6izemxw/C9WRQBv0IXrmoR1/KWbahNRw7cGoDMRwr5A/9l3/GzShi+
         JRNwJT9PDXB63R0cJa3JnoL1VCWjQ1Cw1KWCrjyLqSoei6nvABDIIIhTw64rVpOQW1Kg
         q1rMMkLT+fM3bK5K1OUIlEHDQDNblUNPpHV3zEMjJkKkxaj0qLC8V8JO+mZY8C44m+YZ
         prF8n8lV7evp1UVmD7avSiGmHM86dDosTsCNkBqWSZoZeC8M3ague2Ctr85fdwk5aXGn
         nRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=on30OEe/DO5zamISOEay2WIQIU04GrMtf4oLpYULsi0=;
        b=G47dhc/cSg3dGlsY57hSk20fr8V2wuvv7igG9vdlqTC1GEhTGBDRULOJuc3c3dOOKY
         13PqW7c2OGtJTw7ZrlfyUzoNFx0PUrRWWplnwUTiJHsVIK7WDPGfNwbKC2tLD6KfblHd
         tY2DlRJyQRXoE64hsNi9xSrFXjg9s6qTPYWzcnkAGAckH1NExvIUMzyomK8oIVjAvIdH
         wEPl6Vl4FR3rbb+9GwZs1u4+BCE2M63KBlvgESxg3RGGTxyUneZl3c2HL3/zCjpgKJYI
         KKjS7tH0b0JGjiG67rTr1mGt968NoTXP/CNqj0gBIfFXjdEvLpqsqn+fzoxrTGwsrMd1
         SXpw==
X-Gm-Message-State: AOAM533rDr1syAs+IQT+bAvmEj4Q+ou9yJKHtt92kOUO7DZJjhefm6KB
        0skGP/MNVGwGViF6bOuwvB+4Dg9x8ljosFUGPHSdiWTyxLP39w==
X-Google-Smtp-Source: ABdhPJydJnHSMFNA7KkWvxEBYxxyscRFA6vipqsuXxkhyRm5UrhSrOPz9WDL3yIG52KtyuSzUpI+acnnvERqzMf/7Ko=
X-Received: by 2002:a05:6512:401c:b0:479:7232:5444 with SMTP id
 br28-20020a056512401c00b0047972325444mr2089108lfb.403.1654634701789; Tue, 07
 Jun 2022 13:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220607191119.20686-1-jstitt007@gmail.com>
In-Reply-To: <20220607191119.20686-1-jstitt007@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Jun 2022 13:44:50 -0700
Message-ID: <CAKwvOdkHb9W1dePaKAuSKv2D0e0uMGLGCZGeakzgD3ZWxf-2iA@mail.gmail.com>
Subject: Re: [PATCH] net: amd-xgbe: fix clang -Wformat warning
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        Tom Rix <trix@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 12:11 PM Justin Stitt <jstitt007@gmail.com> wrote:
>
> see warning:
> | drivers/net/ethernet/amd/xgbe/xgbe-drv.c:2787:43: warning: format specifies
> | type 'unsigned short' but the argument has type 'int' [-Wformat]
> |        netdev_dbg(netdev, "Protocol: %#06hx\n", ntohs(eth->h_proto));
> |                                      ~~~~~~     ^~~~~~~~~~~~~~~~~~~
>
> Variadic functions (printf-like) undergo default argument promotion.
> Documentation/core-api/printk-formats.rst specifically recommends
> using the promoted-to-type's format flag.
>
> Also, as per C11 6.3.1.1:
> (https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf)
> `If an int can represent all values of the original type ..., the
> value is converted to an int; otherwise, it is converted to an
> unsigned int. These are called the integer promotions.`
>
> Since the argument is a u16 it will get promoted to an int and thus it is
> most accurate to use the %x format specifier here. It should be noted that the
> `#06` formatting sugar does not alter the promotion rules.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Justin Stitt <jstitt007@gmail.com>

LGTM; thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Don't forget to cc everyone from ./scripts/get_maintainer.pl!
$ /scripts/get_maintainer.pl
20220607_jstitt007_net_amd_xgbe_fix_clang_wformat_warning.mbx
Tom Lendacky <thomas.lendacky@amd.com> (supporter:AMD XGBE DRIVER)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUPPORT)
Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD SUPPORT)
Tom Rix <trix@redhat.com> (reviewer:CLANG/LLVM BUILD SUPPORT)
netdev@vger.kernel.org (open list:AMD XGBE DRIVER)
linux-kernel@vger.kernel.org (open list)
llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index a3593290886f..4d46780fad13 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -2784,7 +2784,7 @@ void xgbe_print_pkt(struct net_device *netdev, struct sk_buff *skb, bool tx_rx)
>
>         netdev_dbg(netdev, "Dst MAC addr: %pM\n", eth->h_dest);
>         netdev_dbg(netdev, "Src MAC addr: %pM\n", eth->h_source);
> -       netdev_dbg(netdev, "Protocol: %#06hx\n", ntohs(eth->h_proto));
> +       netdev_dbg(netdev, "Protocol: %#06x\n", ntohs(eth->h_proto));
>
>         for (i = 0; i < skb->len; i += 32) {
>                 unsigned int len = min(skb->len - i, 32U);
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
