Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19F853FFA5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiFGND4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiFGNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:03:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E0F13DC8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:03:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x62so22891054ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZc1/L5KP3c2RqT1UwG4d2l//fVFWWaRIHrfLzjY4Q8=;
        b=cUY5h88q6/03ae1B8lu027elIy5m2l/WHiZGMn/xeyj7gJEXYsjsPwSzowXq5MT0aB
         vs/U6bMMUKPYh0d/ykxV2GAxFqTsvmjxj/HqbgyRWWBoQMIIGxZsBFfYK2z4KK25FXG/
         XJOi+Fw4chFdmdlzeJPOn13/6GA1st4mb+IN4MeDFt0iK5LKHn3ZSBi1i3VXDd6X9b/a
         xCUSEl//aM4N42hLuDeID4CHWkaKe9LiIpwVbB91A0yI98W6uQzpBut4UnKkFlWntfAi
         xHa0odNgwFSWVWRADaHWAQY71wa82to7+wLjes7je0Tjh7HNEkg4Aquf1jzWAl1ZGdcF
         +OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZc1/L5KP3c2RqT1UwG4d2l//fVFWWaRIHrfLzjY4Q8=;
        b=k+N0GGFFSoaCIMHMtLqAwbHlJpi9p9n0U1csH8PLMpEmjJWysYil4nT+NWh8JNth0k
         9mFMX7M/hUh2kE9ibIbi8MACa6Nl8Dehds3AidAq2SHT08aUktiA/fvzbkyMx0sCVi2a
         DWivOnRhcEOYWc4vqYlpDMISW2cEzkFxPDXPiIW7bJjcFLYKnumS4M/yygdNQDUS+0tS
         RIrcmEq3R+pJPVItKJhRVKsZS1h3TElk7+pRIYwh6/CExt0rBvNOUercDV0cbEI4rnoy
         EwKYWdlDexl16x6OAwxW76wKHReGyi8zFd8M71xHSVbfEqhVY7SqLov7kXGfReQAOd15
         PiVg==
X-Gm-Message-State: AOAM533YV6Bn/D0rS4Ei+VptyKuVtkOYIomOQzkMPYcpXxTn/YfWCfVE
        r2+w19jSwQ9BGo00de4P+qbAOtWQS/FT5QN8iqY=
X-Google-Smtp-Source: ABdhPJzxJ20S1Cxy9uCu6I7cLjZK4NNWcoIFIjRn2k1n/G3Jlvl17Q9f5mECMbHDAV6K5of7ULt7AtuWZnp5RJ029RQ=
X-Received: by 2002:a05:6402:4145:b0:42d:842a:f916 with SMTP id
 x5-20020a056402414500b0042d842af916mr32905644eda.357.1654607030559; Tue, 07
 Jun 2022 06:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093449.3100-1-urezki@gmail.com> <20220607093449.3100-5-urezki@gmail.com>
 <Yp8ezezY37tvuZPy@infradead.org>
In-Reply-To: <Yp8ezezY37tvuZPy@infradead.org>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 7 Jun 2022 15:03:39 +0200
Message-ID: <CA+KHdyWaRKRu+EAFs=YWft+zmxcd4J_ikJkZ4g_SMx_T5dZvDg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm/vmalloc: Extend __find_vmap_area() with one more argument
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 11:47 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 07, 2022 at 11:34:48AM +0200, Uladzislau Rezki (Sony) wrote:
> > __find_vmap_area() finds a "vmap_area" based on passed address.
> > It scan the specific "vmap_area_root" rb-tree. Extend the function
> > with one extra argument, so any tree can be specified where the
> > search has to be done.
>
> Uhh, why?  This just adds a copletel useless argument.
>
I wrote about it in the cover latter. It is a preparation work for
making vmalloc per-cpu.
In that case free/busy data are located on different rb_roots that is
why those functions
have to be adopted to work with any tree.

-- 
Uladzislau Rezki
