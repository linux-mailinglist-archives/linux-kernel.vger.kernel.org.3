Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86C6578435
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbiGRNrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiGRNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A10B825C6C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658152026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtcmjGXV4czePnEOaU9k1n+wgG1RmX/RhdWW1Odaz3Q=;
        b=KT8TzByYD1CNs5wraTfvzIDDIKvtfBjqc8Yfp6OMWLzo0rBfmF7/veURpBRK81rSBTKVTE
        ik7Q9TdKC1C+Iy36FOUaviHeqP0nSFKws9zS4oB7Sd4dwRtPpwSGMWzoF8tvkM8EP0wBv7
        Z916P1n6Ga+Wqi2ykv3UlUCtbUtR+F8=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-fFM0BVWgND-FY1Jjf72TcQ-1; Mon, 18 Jul 2022 09:47:05 -0400
X-MC-Unique: fFM0BVWgND-FY1Jjf72TcQ-1
Received: by mail-vs1-f72.google.com with SMTP id q4-20020a056102100400b003572f6bd5a0so1014569vsp.16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RtcmjGXV4czePnEOaU9k1n+wgG1RmX/RhdWW1Odaz3Q=;
        b=bpFunsj5FHIy7XFgO9XjwQ5qXfWgYTlUimRp5QeKwFLFN5OKxXfsbCW8vKLfi7aZGC
         wKQ2jdBGlKMHf+ojHebgOSbI42z6LkJu/QeA4DLTuZeFUJjfLylECVNqUUOVX/64KAnt
         7Wt6CCQmf0/IFfFkrtKjmFfF0OvcOFm6VjUnfsfq3zChVUhwrIZ0jO62HC5gA//26ugF
         COty6cyRQWqYSua+XRXZ4Z5XVQYYei3n98aVAP/RMdweVCbp+PCJf0VdXjiYhYJF+pCw
         MMvCMtXM4Nm3CCfCqTg4evDorVpBgIuAUtulObdl15NDRKzoDHzW/6TQD046I719EWIO
         K7Eg==
X-Gm-Message-State: AJIora+us9Cq9PpwFUKVAHICuiE/l6sqlzsQDJRpI/i+SEHmTmt2J4sl
        1E3k+ftFBqFnY62rnZetXFbMk4DWkdGviivuBQCKqsKPM+NUc7BBWshhkPTeaKkO7GE4qGfxKxy
        1MiWdQFku+o2XkkbCADDQG/6G61W5HN9DFZfxMebf
X-Received: by 2002:a67:c894:0:b0:324:c5da:a9b5 with SMTP id v20-20020a67c894000000b00324c5daa9b5mr9160122vsk.33.1658152024942;
        Mon, 18 Jul 2022 06:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uiBu7OtwOgQIzMRRe6G0eAhpYwuwmFJy8ENPD1LcyPCRQSKTZ0hfu7BXyhst+U/lKFwugYJ1Hu0+fBVs8yG0c=
X-Received: by 2002:a67:c894:0:b0:324:c5da:a9b5 with SMTP id
 v20-20020a67c894000000b00324c5daa9b5mr9160107vsk.33.1658152024680; Mon, 18
 Jul 2022 06:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220715125013.247085-1-mlombard@redhat.com> <62aacb46.a9b1.182110646cf.Coremail.chen45464546@163.com>
In-Reply-To: <62aacb46.a9b1.182110646cf.Coremail.chen45464546@163.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Mon, 18 Jul 2022 15:46:53 +0200
Message-ID: <CAFL455kBP+_PTgDY51V2YgbMCLjYDKS_Jh4k6pvDnqUnYCf-TA@mail.gmail.com>
Subject: Re: [PATCH V3] mm: prevent page_frag_alloc() from corrupting the memory
To:     Chen Lin <chen45464546@163.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 18. 7. 2022 v 13:17 odes=C3=ADlatel Chen Lin <chen45464546@163.com> naps=
al:
>
> Will  this lead to memory leak when device driver miss use this interface=
 muti-times=EF=BC=9F

No, I tested it and pagecnt_bias and the page refcnt are always consistent.

Maurizio

