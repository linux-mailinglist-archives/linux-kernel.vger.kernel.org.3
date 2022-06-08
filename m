Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08285421E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiFHCz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442431AbiFHCwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:52:32 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB41A408A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:24:55 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-30fdbe7467cso157898817b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVwpegGHiLEJYUfgCGY6xrStHaKjaQ53gSOs9QMJll0=;
        b=HAfOjcDhaOCD2pHcLlVJsvBvouBVgzJhzrdxCP+MbU6cE680LHIaEI6prYz/VfymVI
         7brK+DPoE8RR7YuhJ8OJ43ii4CVehxPlpedhVPCiDmx6xGtgSOrRmvJCedaUjLDb+4LO
         kx72K4u1rANJqxsn5zPNb3JK11RE7gffMxL/Z0TjSnovYvXcpz+R+UC/0SnpPL2Fggix
         cXGSAgejZHy+ffmh0qkWmaBIBEbEFFw17uH97hRH4cNXRLhyV2tG/AKWgFklo0FEQNO5
         mSUHN7YBo9GXjSrIHBalr7H+cPsZWo0NZTVLU8MdBUTBG2fOGH3iCD5+JaFwbO2t46Y2
         8/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVwpegGHiLEJYUfgCGY6xrStHaKjaQ53gSOs9QMJll0=;
        b=fqJTykE+Mhmz5JL+7y9MlxCxrKuOvcMhaMhO6Tru+EQKGuEOZ6DsPFaLjs3P8XT5tJ
         gVCS449djOGsd5lvWUTjq2Jh6LU0zdNQL042sB1fu18yy8lTVenzZptBJRBx1eBcP7Wj
         7d3AvloUS85vbxY8fIqbEn+Kk+gwV8YY3iSY1JmVVXqNr0MHXLPNIosDMzByobnvN9Kv
         SrFD1wgs+Q/XFYP04JJMmIVYaptXPLCmnN7IDA/jErGglyNma9UkqAQzWUOKfPOvsUps
         tmuGIEMmJ8YOZgbSZl/DcNsThUISD7JGDalgaFfcQEIq0TiYaAjOWAQjagslHgLbWS4o
         GpoA==
X-Gm-Message-State: AOAM530EKdyes47ywOZ8o70wbBhRJKe/CtsDHQVMCo5jHkfQaYTEFUxx
        jHPBASkEk7SXU8rZbfiY1N2UjxvK9kdf24sMJH68kQ==
X-Google-Smtp-Source: ABdhPJzypSawcFrP1JEuhsI8jAP607O5WWQytyOVGWPuXBhhebSmqFIVRRklQa6b7Yi4CXdM4nuefMch/LB8lk0p8oY=
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr34499432ywa.47.1654647891026; Tue, 07
 Jun 2022 17:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654528729.git.jtoppins@redhat.com> <ac422216e35732c59ef8ca543fb4b381655da2bf.1654528729.git.jtoppins@redhat.com>
 <20220607171949.764e3286@kernel.org> <8b94a750-dc64-d689-0553-eba55a51a484@redhat.com>
In-Reply-To: <8b94a750-dc64-d689-0553-eba55a51a484@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 7 Jun 2022 17:24:39 -0700
Message-ID: <CANn89iJEyV2uDsh4jybyePuv1CaTW2zKrdkUTcoyMsH8rXiMKA@mail.gmail.com>
Subject: Re: [net-next 1/2] bonding: netlink error message support for options
To:     Jonathan Toppins <jtoppins@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 5:23 PM Jonathan Toppins <jtoppins@redhat.com> wrote:

>
> Thanks, will post a v2 tomorrow. What tool was used to generate the
> errors? sparse? checkpatch reported zero errors.
>

make htmldocs
