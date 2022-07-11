Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2325570828
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiGKQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiGKQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98C1A7A530
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657556271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFy7tx4vuflJ9T67q4fsWyscGk3VBcpn9gI9HIE/8ZA=;
        b=dcBdbSa+U6dmDLaTIPYSsUKUWbEy2paoLMcS05UMmAX/pnrXTPve+HT2UBsbeFpLJK245B
        t18e+lgLjBC5N4OFkQtuWSQx8d0+Xj4nPnKjCdU4mLcjxyRpTBtRFb/oUGZWeThdGyKk9v
        8Xi6rS6be5BN7iAsyF7PTtl507XRZfM=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-_XPTBpIMMs6U-vF69Sn_OQ-1; Mon, 11 Jul 2022 12:17:50 -0400
X-MC-Unique: _XPTBpIMMs6U-vF69Sn_OQ-1
Received: by mail-ua1-f71.google.com with SMTP id l7-20020ab053c7000000b003791afd560cso1073826uaa.21
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NFy7tx4vuflJ9T67q4fsWyscGk3VBcpn9gI9HIE/8ZA=;
        b=KRZY6gCoT7lAQNc/S8cOBvGOl6WxBDUywFGoigXnzHJpe80xvv5nH2zCTgNPbw9LJ3
         VG+n4ZNqcuXvgj+VVXu1l8f4gz6xOo7R5wl45195iV8EhYaLdcfcwAChNaxf18RGmFcH
         vivZLT+lNt1Swyf+o6FkyJhoL8qbX5uL5N0OkOpnj0+MdNSUi5guIFjN5JFRatm/hB+b
         38jvP4SUT3hxLKzUrXIsYDbZaXO5NV9+WdizYYBV16wA2zKD9d6CKk3xgI1qAgBtZufI
         6ttk5pPSBDi5FqhJH99Y+7jhqlt+O18dM+inK2SGTNbz+gnR/ykiU8/3boUXL4j66Pc2
         rUXQ==
X-Gm-Message-State: AJIora9xtnKckjnzc6djy1FgtbjW/3oQ+AD5JWEwuMLy8hC351qDT33v
        DXzT2FR2n4iOkBMKfPueEgJFZWU1949BqT4mPsu2urO3LQdSV92jJNFglMwpZUGK5yOcm705d7+
        lAYN45LZrmpMZF0LU4hr44aR8Qt6LuD3Jg3gPbDwu
X-Received: by 2002:a67:e9c2:0:b0:357:547e:d541 with SMTP id q2-20020a67e9c2000000b00357547ed541mr2640135vso.68.1657556269854;
        Mon, 11 Jul 2022 09:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tcsrYRDtkH4eUNCid1rUG2+vczmpwYghbpC6RG7cGJFQGmWBSLROKXXH4pGLODJIZOU2JW5CpBt0iHf5vZvHw=
X-Received: by 2002:a67:e9c2:0:b0:357:547e:d541 with SMTP id
 q2-20020a67e9c2000000b00357547ed541mr2640130vso.68.1657556269612; Mon, 11 Jul
 2022 09:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220711075225.15687-1-mlombard@redhat.com> <CAKgT0UedQL-Yeum8m=j6oX5s2SjzjtwcwFXBZQde+FzmkmL5bQ@mail.gmail.com>
In-Reply-To: <CAKgT0UedQL-Yeum8m=j6oX5s2SjzjtwcwFXBZQde+FzmkmL5bQ@mail.gmail.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Mon, 11 Jul 2022 18:17:38 +0200
Message-ID: <CAFL455nwqqrviZranVvVgRapSF_Na3vwR4NYM+=Hqbvt3+fJeA@mail.gmail.com>
Subject: Re: [PATCH] mm: prevent page_frag_alloc() from corrupting the memory
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Chen Lin <chen45464546@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 11. 7. 2022 v 17:34 odes=C3=ADlatel Alexander Duyck
<alexander.duyck@gmail.com> napsal:
>
> Rather than forcing us to free the page it might be better to move the
> lines getting the size and computing the offset to the top of the "if
> (unlikely(offset < 0)) {" block. Then instead of freeing the page we
> could just return NULL and don't have to change the value of any
> fields in the page_frag_cache.
>
> That way a driver performing bad requests can't force us to start
> allocating and freeing pages like mad by repeatedly flushing the
> cache.
>

I understand. On the other hand, if we free the cache page then the
next time __page_frag_cache_refill() runs it may be successful
at allocating the order=3D3 cache, the normal page_frag_alloc() behaviour w=
ill
therefore be restored.

Maurizio

