Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A900551296C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbiD1CVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiD1CVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:21:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E0A71A37
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:18:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so4792404wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YQLEpePQ0s5/TYsbGG8QOihmSo3DTXYfheeLH1cqLw=;
        b=XoIWwqe+KggVK4FHK2yy56Lm5reOsZYSHm3tWwfV2KMdUYq/jtfDUyX5PRDseoMiKL
         wZkMk7E5PdA4kwrLeouW40/33vowyy+3yZJWJLVtZ6fESI2WLq/yn1+pct1l11yDPaaS
         j+w628LwBS54pVpkH2qXcAI28+tonAY9VuBA7KfSz4Bsv/uFzEnG4jPGbBaW1KSJPiOm
         CbP7OoVCjn9WRRW47enKhO9PLFSpZ+udIisX0tiMYIOf3Z/m1w8RkxGkgb00B+SMXZQ9
         7R7+u5lw7S7nSMwzKqlKp9bRhIiyVb+Vw3b72lrrhIBuHJqadVbYu1gBSXcloP26uxoe
         zKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YQLEpePQ0s5/TYsbGG8QOihmSo3DTXYfheeLH1cqLw=;
        b=CgJX5uQQg3p9OOouYljxjO1PlutStlhJnByFQaIYoMy6CSFJjri8sxU975b8ikcWWc
         pGZZx1DhcZIxNMJoCpZOpwmm5KRjPGUChFAEhhGsIX2CTWUM5osor6CvTqavq0xNfSzQ
         k44JB5WB3T3gQIlyyHGURs3iA9FQ6SyxNXTNi0B1TCft1w/gLzF4s4+dUYXQmnRjR+P4
         z38b9lr6g4ZsG7AVcTW3psupQ1fDcQKSereZvQ4Jpug4W3897JD3+mXCv0WD/9nwTjL3
         IJ5yLyiOBkTz88eT2+lNpWNFSKYuo6aQwRm97bTak6iceyBBBosE1EVR7xYYGwYGWjK0
         DyJg==
X-Gm-Message-State: AOAM530gV7dtnN7eSZqcarwx8AxNwu29aaPxzgvm+Us7VE7rfDJGxI4A
        Fwvx0RvJXXf2LlgSwKrJ0pe/Wl2GBSIormyvPZ1RnzJl900=
X-Google-Smtp-Source: ABdhPJwLO+UCk9RGSNsvp53gMeOT5T82G/u+prscup3Mn4Wh8Uji/Dk9yHVlH0VQtb/gtKiZYJkNxuvRDV8nqAaoDMI=
X-Received: by 2002:adf:ec51:0:b0:20a:cd42:fe3b with SMTP id
 w17-20020adfec51000000b0020acd42fe3bmr21942602wrn.719.1651112316110; Wed, 27
 Apr 2022 19:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <165109503652.611257.12851860419631266883.stgit@warthog.procyon.org.uk>
In-Reply-To: <165109503652.611257.12851860419631266883.stgit@warthog.procyon.org.uk>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 27 Apr 2022 22:18:06 -0400
Message-ID: <CADvbK_fBafuWZq8wcxwyGFeS+YEuKfGrfs6igTR_ThhL+ZFDDQ@mail.gmail.com>
Subject: Re: [PATCH] rxrpc: Enable IPv6 checksums on transport socket
To:     David Howells <dhowells@redhat.com>
Cc:     marc.dionne@auristor.com, Vadim Fedorenko <vfedorenko@novek.ru>,
        "David S. Miller" <davem@davemloft.net>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 5:30 PM David Howells <dhowells@redhat.com> wrote:
>
> AF_RXRPC doesn't currently enable IPv6 UDP Tx checksums on the transport
> socket it opens and the checksums in the packets it generates end up 0.
>
> It probably should also enable IPv6 UDP Rx checksums and IPv4 UDP
> checksums.  The latter only seem to be applied if the socket family is
> AF_INET and don't seem to apply if it's AF_INET6.  IPv4 packets from an
> IPv6 socket seem to have checksums anyway.
>
> What seems to have happened is that the inet_inv_convert_csum() call didn't
> get converted to the appropriate udp_port_cfg parameters - and
> udp_sock_create() disables checksums unless explicitly told not too.
>
> Fix this by enabling the three udp_port_cfg checksum options.
>
> Fixes: 1a9b86c9fd95 ("rxrpc: use udp tunnel APIs instead of open code in rxrpc_open_socket")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Xin Long <lucien.xin@gmail.com>
> cc: Vadim Fedorenko <vfedorenko@novek.ru>
> cc: David S. Miller <davem@davemloft.net>
> cc: linux-afs@lists.infradead.org
> ---
>
>  net/rxrpc/local_object.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
> index a4111408ffd0..6a1611b0e303 100644
> --- a/net/rxrpc/local_object.c
> +++ b/net/rxrpc/local_object.c
> @@ -117,6 +117,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
>                local, srx->transport_type, srx->transport.family);
>
>         udp_conf.family = srx->transport.family;
> +       udp_conf.use_udp_checksums = true;
>         if (udp_conf.family == AF_INET) {
>                 udp_conf.local_ip = srx->transport.sin.sin_addr;
>                 udp_conf.local_udp_port = srx->transport.sin.sin_port;
> @@ -124,6 +125,8 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
>         } else {
>                 udp_conf.local_ip6 = srx->transport.sin6.sin6_addr;
>                 udp_conf.local_udp_port = srx->transport.sin6.sin6_port;
> +               udp_conf.use_udp6_tx_checksums = true;
> +               udp_conf.use_udp6_rx_checksums = true;
>  #endif
>         }
>         ret = udp_sock_create(net, &udp_conf, &local->socket);
>
>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
