Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC1578637
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiGRPZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGRPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7B18286FF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658157917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNCpXXx/UVAScX22Wy0a2l/ouu+CQDoAik/pVsqQbrE=;
        b=FJw2YfLbbBZsRvjYxLcid1sb5oHSEvqRO6O7pp0Kzsowr0+cZh0qQgEyW91wmIGvjCe1MF
        ESP2bw7B5MwHyYjFWeO+CpLVDFglY8iiE4XLNfzBgDYBhEDM555eYyjpfQ3getzWX2rnvK
        GmGkp4M7IcQeA+7yHpLqvAixhb8Myko=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-4UwBTS2DMm6oJkJ9wLcRkQ-1; Mon, 18 Jul 2022 11:25:12 -0400
X-MC-Unique: 4UwBTS2DMm6oJkJ9wLcRkQ-1
Received: by mail-vs1-f69.google.com with SMTP id x128-20020a676386000000b003572c961a12so1029111vsb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qNCpXXx/UVAScX22Wy0a2l/ouu+CQDoAik/pVsqQbrE=;
        b=FlWaTLYP3ETeH79vBkJKEv01PdbUWo18g81aGg9D5cjPU88Nr6aSTt1LDuLTf5iqLH
         +RRa+M8D6Bm4u85glLgrT+g6o6RuTjWx1p3lrWUlhCqx1qLo5v1I/kEhweXJu3balwqg
         YToFOCS1BBKz0mzigQY6Y0EE7X3KrFQ77FZ9VWa45LuCnjrwTJiWZ+xiOVVuMFCjzqTx
         Gc3UiA68ccxDtJ4IweUQL7TyXaEfLgv+M/3K9C6GdRw3kjz2SW77lRQoYdLyzuGNLphE
         1vSEuOHo8WAU3DI0E1MO2QkCz85rGeK6NCVcB7PpvbBe3L76i+QRqqCG1F+cIYqdeLNc
         arOg==
X-Gm-Message-State: AJIora+vT8ucDBP/MxkjPeml1axyLPDI8VNezH6BbPD55NCPjTekaGK5
        Ee+q69dI1rWV+oJ29jxBXeMsK/J+dMZ1iJFGd3vqgfO6HRSBxCygESLnbPLWP/Sn0uJtieOFcth
        0TIveNWOplNjq2ngIIQu/xCnK3n/BvKNf7ck45xx9
X-Received: by 2002:ab0:2714:0:b0:383:63cc:70e7 with SMTP id s20-20020ab02714000000b0038363cc70e7mr10319475uao.97.1658157912169;
        Mon, 18 Jul 2022 08:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vQvotaRoyIf2nMEL/TrLxO/+smhp3pgFkVffKPh5ZGRbIJX5oDe2aU0aj6XtvxQJlPnKTVdYY0+aNRWws2JW4=
X-Received: by 2002:ab0:2714:0:b0:383:63cc:70e7 with SMTP id
 s20-20020ab02714000000b0038363cc70e7mr10319431uao.97.1658157911235; Mon, 18
 Jul 2022 08:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220715125013.247085-1-mlombard@redhat.com> <5a469c5a.8b85.1821171d9de.Coremail.chen45464546@163.com>
 <CAFL455nnc04q8TohH+Qbv36Bo3=KKxMWr=diK_F5Ds5K-h5etw@mail.gmail.com> <22bf39a6.8f5e.18211c0898a.Coremail.chen45464546@163.com>
In-Reply-To: <22bf39a6.8f5e.18211c0898a.Coremail.chen45464546@163.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Mon, 18 Jul 2022 17:25:00 +0200
Message-ID: <CAFL455mXFY5AFOoXxhpUY6EkPzc1677cRPQ8UX-RSykhm_52Nw@mail.gmail.com>
Subject: Re: Re: [PATCH V3] mm: prevent page_frag_alloc() from corrupting the memory
To:     Chen Lin <chen45464546@163.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

po 18. 7. 2022 v 16:40 odes=C3=ADlatel Chen Lin <chen45464546@163.com> naps=
al:
>
> But the original intention of page frag interface is indeed to allocate m=
emory
> less than one page. It's not a good idea to  complicate the definition of
> "page fragment".

I see your point, I just don't think it makes much sense to break
drivers here and there
when a practically identical 2-lines patch can fix the memory corruption bu=
g
without changing a single line of code in the drivers.

By the way, I will wait for the maintainers to decide on the matter.

Maurizio

