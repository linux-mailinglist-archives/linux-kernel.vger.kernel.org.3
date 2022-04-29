Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B851491D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359027AbiD2MYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359045AbiD2MXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:23:51 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DAC44A1B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:20:31 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id j6so15062799ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKaet2TJN9yDQhg2o4o9RJ2bTM/lmyY9KQMHlDiAIXI=;
        b=3VtlJfopV8Q7oqD3QB1WjdScXkGz1PPuSXXcXYzZL5qiSiK/wFGL3Q7isUYZDVQStF
         MbQ2bn8uxhrarzGrFAnYGtoI3RJE/uPFM7haEf7kStLhMsoiFQH6t4gr0v6OSJS8IfUq
         pY8c8AaZgC/gS97bQxFM5jT+/0OBOIuQIErQq0qsvniElG2GZgF82NQ0WG0yN2ysSQVv
         iV+ewCl2L9XzwKuZd2/4RmcbfoCnLJeo9NFOOPyKUUlPKY1yGZHbqDtWZUhtOnDDIV6U
         Wb3ymkH+z7rGV38Rv0YMvCyhecVyOpqoOXAYE3UQR/2CAIGDwqUhg4F9J3clQh/RBjse
         rzng==
X-Gm-Message-State: AOAM531Ji3XHUdp2L8wgeha0ycJUw3S9LzMHjZxh03zWg5BRBYKoGaav
        wsumAKYcizIgoGV0bqxQoQ4L1wA8HVW1+Q==
X-Google-Smtp-Source: ABdhPJzfSFugP6A7LNPL3C50OYflcHNGDX055rPubCOKirwxZ/562owBR+FMkvR7iTVI5iA6LjAF9w==
X-Received: by 2002:a17:907:a411:b0:6f3:e579:dce3 with SMTP id sg17-20020a170907a41100b006f3e579dce3mr6417344ejc.141.1651234830417;
        Fri, 29 Apr 2022 05:20:30 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id w14-20020a170907270e00b006f3ef214e3bsm579026ejk.161.2022.04.29.05.20.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 05:20:29 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id u3so10574743wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:20:29 -0700 (PDT)
X-Received: by 2002:a5d:4882:0:b0:207:97dd:111c with SMTP id
 g2-20020a5d4882000000b0020797dd111cmr32080192wrq.115.1651234829363; Fri, 29
 Apr 2022 05:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <165109503652.611257.12851860419631266883.stgit@warthog.procyon.org.uk>
In-Reply-To: <165109503652.611257.12851860419631266883.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Fri, 29 Apr 2022 09:20:17 -0300
X-Gmail-Original-Message-ID: <CAB9dFdtU05RgYwscCm-WX3ZNMiD0gbd2kTS61HvRHrPN=f25UA@mail.gmail.com>
Message-ID: <CAB9dFdtU05RgYwscCm-WX3ZNMiD0gbd2kTS61HvRHrPN=f25UA@mail.gmail.com>
Subject: Re: [PATCH] rxrpc: Enable IPv6 checksums on transport socket
To:     David Howells <dhowells@redhat.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        Vadim Fedorenko <vfedorenko@novek.ru>,
        "David S. Miller" <davem@davemloft.net>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 6:30 PM David Howells <dhowells@redhat.com> wrote:
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

Works for me, and I think we want all 3 settings, as a socket created
by a userspace application other than kafs may be a V4 socket.

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
