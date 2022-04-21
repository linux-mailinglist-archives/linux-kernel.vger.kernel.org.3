Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC194509446
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 02:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357996AbiDUAXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 20:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiDUAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 20:23:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD20C1A078
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 17:20:47 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p65so5825156ybp.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 17:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXocRW4Fcy3ODLwlLZMAvoG6TfyjzPBLt8Rv4un+YTQ=;
        b=nImhtQPJaOzP6XFyaGqECd5mDgHxWmDJRHdRNv+vEPa5JrDA9N7SPydqUH64Gq+hQV
         NtKuBALzWwwJkFIUXcbefjATqKncxCcqE2gX6X1+ZCEZp3/XoRyFVN3C+Ql4w+nDRuew
         q6TLmIqM0Dxfyp8AT8r4nBE3K28zycciwtrU9VM57sjM9jTtjOhzemgs1/LE7uhaTLj2
         NpaCFLd0cB6ZAvRcmI1b3nMSA5ulnNKoCmrGmxz11LR8/9BTE6vVDc9Y6RCpAcN8qZvl
         pAleeywzdXr1/wUhp8ubkefmyj0HuspW7uuqu7SdBu71UNDDY249sR3lJuwbxG1GMs/P
         PlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXocRW4Fcy3ODLwlLZMAvoG6TfyjzPBLt8Rv4un+YTQ=;
        b=5qEyE/lAvCqVsf3rbQS40aihDfAPWGYgW6eqoH1EC44GeOebhcFJWN6DDS4BGSWKqK
         E5TlzsC6rf15ljDSs1qDpCxeKLRUVzVr8Aq6HcrBrqSR4z0F5d8UbnbNb+2wVvhjS4VN
         FA1JcWgV3Jg71AMG7BakQPHTG4oMJY+euEleCl05BmRWINIxj+qIPvnFa6LinQEUjbNc
         9OBAffWT/GlAYiuLZ3PKgjkYh2rMhfdC2At1C5VhoEPPHEKk29SzOeDMpSBQLDlNmxm5
         KQZJgi/20f0FuadB/70K9loFkvr9rK408QnLHSeQgmB9Qcgr96EtkNqacaJxkuHeOyU+
         OwNw==
X-Gm-Message-State: AOAM532kkeM0+GpPgZaeA+NShTq3/+FKKNlkdMerKRRjp38vbDg8Nb0Q
        MWhaseK0mRq5M59aNHGghMLZI5JjqCQF24sWi7p6NLy7zTzJaRyt
X-Google-Smtp-Source: ABdhPJyY7IxMb9HzNn/D6HXins/F226memrjVTU9idaaExMqGEnSVuhTv/NpqoqY7E/6DLIx3N5uyai+7UzTD8B5MxM=
X-Received: by 2002:a05:6902:1109:b0:645:58e:a373 with SMTP id
 o9-20020a056902110900b00645058ea373mr18145423ybu.231.1650500446691; Wed, 20
 Apr 2022 17:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220420235659.830155EC021C@us226.sjc.aristanetworks.com>
In-Reply-To: <20220420235659.830155EC021C@us226.sjc.aristanetworks.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 20 Apr 2022 17:20:35 -0700
Message-ID: <CANn89iJjwV2gAKMc4iydUt_MqtnB-4_EKdVrqQO9q4Dt17Lf9w@mail.gmail.com>
Subject: Re: [PATCH] tcp: md5: incorrect tcp_header_len for incoming connections
To:     Francesco Ruggeri <fruggeri@arista.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 4:57 PM Francesco Ruggeri <fruggeri@arista.com> wrote:
>
> In tcp_create_openreq_child we adjust tcp_header_len for md5 using the
> remote address in newsk. But that address is still 0 in newsk at this
> point, and it is only set later by the callers (tcp_v[46]_syn_recv_sock).
> Use the address from the request socket instead.
>

Nice catch.

This seems like a day-0 bug, right ?

Do you agree on adding

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")

Thanks.

> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> ---
>  net/ipv4/tcp_minisocks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 6366df7aaf2a..6854bb1fb32b 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -531,7 +531,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
>         newtp->tsoffset = treq->ts_off;
>  #ifdef CONFIG_TCP_MD5SIG
>         newtp->md5sig_info = NULL;      /*XXX*/
> -       if (newtp->af_specific->md5_lookup(sk, newsk))
> +       if (treq->af_specific->req_md5_lookup(sk, req_to_sk(req)))
>                 newtp->tcp_header_len += TCPOLEN_MD5SIG_ALIGNED;
>  #endif
>         if (skb->len >= TCP_MSS_DEFAULT + newtp->tcp_header_len)
> --
> 2.28.0
>
>
