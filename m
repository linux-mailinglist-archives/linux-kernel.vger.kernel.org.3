Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65335094E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 04:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383759AbiDUCDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383776AbiDUCDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:03:02 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A91101D1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:00:13 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ec42eae76bso37480217b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AE7l3U3Ok/l/ma4wVBxTAWhqFVPfRK/mIEy0ba9HyK0=;
        b=mZ9Ge9eiHVANFgD4+KOUXL1r2F71/Kiyi5Ioyx/BT61bDLjjP95WftDAMJrBH//GBC
         kV63YgO+r6UptKN1T3M+prV/q4e1QlwHPXiwAuPcyrYzA/F1hQbLYtN1JgyS55X3OimJ
         eOBuVnNJg4CnBIZLypL2m4P06HJxTDCet3rYw5r1EAw/FPMrPwUF2xXOTRWKVcVet2Lq
         S/uQ6UisWZiXssiKxQJ7aiN30BdjW6+ETRI0pR5fQmWbIt+FzLk1ZBLDUx6HmxEkmfT/
         7WSh2BNHOP5jm4tR7JnBcG55if9Tr9Ri4sRI97AEOydNb3VDhfC5keLovEe+sLJlHw0F
         9lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AE7l3U3Ok/l/ma4wVBxTAWhqFVPfRK/mIEy0ba9HyK0=;
        b=q8iMi3mIsktCPtR0v3h3lr8mPlAvmStJedFIqHtL42QdanuZ1HFDUA08AAoeywMEWb
         LwM406H2OfbJN/qUKDbLlA1xaijJBAdOV7d0Te9+WADr6TGu3O4gAaVobMaqkzDXwSZh
         bRleHxx4PFFJZOmOSzl1r5XLoYQ4WDYzwf/Sl+J0MDQeERhGliad282YwMrLml9db/GT
         uV636K5uE94QT+/vLRKdhPZx0Y4wbwnLei6E8OkjlAq5nLXXxjLhPWbsEmAMMfRoX6oK
         IqrYg1W2HoVB0gyAvCspLEB6WPJotRDSyMnnzJE8G9tDQTUA9VfT7Fcm81ho5MsX2tP/
         MJZQ==
X-Gm-Message-State: AOAM533cWuuBcps3U8LII6uGjKojW3mrx++pdVyQDshRmi5mQeucVQSe
        h5SfMFkatE89asleLGaXlndEyxFORj3a24dGfJZjijBFgH9EAw==
X-Google-Smtp-Source: ABdhPJxY/JAVTGMP2eoLuvovfMVq8brdmJ26/zPXma9LAq3yXWvRIrK3lcHo514gkcUIfT8zyY3+9TvhKloqfqWgcQs=
X-Received: by 2002:a0d:cb07:0:b0:2f1:c718:b273 with SMTP id
 n7-20020a0dcb07000000b002f1c718b273mr11764955ywd.467.1650506412639; Wed, 20
 Apr 2022 19:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220421005026.686A45EC01F2@us226.sjc.aristanetworks.com>
In-Reply-To: <20220421005026.686A45EC01F2@us226.sjc.aristanetworks.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 20 Apr 2022 19:00:01 -0700
Message-ID: <CANn89iJ-iMgoy9AYoAhZ3y8wcNCsQ5Bu=4rnC3x1o9UY07E9Ag@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: md5: incorrect tcp_header_len for incoming connections
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

On Wed, Apr 20, 2022 at 5:50 PM Francesco Ruggeri <fruggeri@arista.com> wrote:
>
> In tcp_create_openreq_child we adjust tcp_header_len for md5 using the
> remote address in newsk. But that address is still 0 in newsk at this
> point, and it is only set later by the callers (tcp_v[46]_syn_recv_sock).
> Use the address from the request socket instead.
>
>
>
> Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>

Thanks for fixing this Francesco.

Reviewed-by: Eric Dumazet <edumazet@google.com>
