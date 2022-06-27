Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28555C70C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiF0Nyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiF0Nyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:54:37 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1EFA1AF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:54:36 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id o43so14803365qvo.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=+rT6LzOd0Ynn4L0BL114LxRE92j4qXXlsy4/5QmiSjk=;
        b=VyTjn5Ro348LXEPtw2w2syMtzdMPEZ6X7C/Fw4X9wyUUT3HPVakiQB8V2V197BUjFp
         PqUnOJH63MHHh5gWdb+uMnVyh8k1yPGBbnBaLlHgBlsFR8BbNniU01pw7FJckXFOf+51
         zJaaiL3NjdTjjTj0GlpzdHcxuGcQt8lvRNWa7dkDDRQGn8cLkOUc3dhyAvJq/foeMak2
         oe297m7nYPA+6+r2EUbtBfLXAhVBj3rLmL2tUc8gsu/fMp6mqbH5oJpcm47Q9+v717Jq
         82/NaHub6V3BEnXN2htMrunDsPSOGd5x+f4/OZ4aSlMRdkAwNzk5K3IJPVcnn5SYvsz8
         1j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=+rT6LzOd0Ynn4L0BL114LxRE92j4qXXlsy4/5QmiSjk=;
        b=1nVOG+tu3rMTHq1AlPIfm9WRB/lWdjk/nt+rNg+QGadDM8q0D3dO/XCnBUUQD+Ztk1
         kjCWEcPN+vfGySA4k4aQQG7X+7bnOyqj5pIxOuSez5PfOSQboRG9tzj+GGnT5qoyFRSI
         ggJjKjhgtWJSA6XTjcNGRayBeJqDvxqEciNJe5rRy7MO9o/5fyKWiHJWAoa66tqZmvi0
         UTHBo/NJRQhrO49AS3kJUxbHTTUY+BqeSs5af72aSMUyQ/hgczKngmftjxllOghdfS2Q
         6N0sCyfzsZ6BjVjLtbjgtZnDsM7R2HW74E/eD7epDVj7gqrMpI2ztMJinjnqoVbh1ok7
         lGgw==
X-Gm-Message-State: AJIora+co/9teWB9IZQU2srtsn1ZKUOddWEz4Wd5hBIzQNPb3NMiTXOG
        TAx9EBa+BRiUKBVXRJ2AWjuQRQ==
X-Google-Smtp-Source: AGRyM1u0PSq5wvrP+0gsBOTu5G7rYKCZmC5okHVqQiWH9j0V5hIV4K4cJ+oQ8PeKxOq7oGdESYJ8CQ==
X-Received: by 2002:a05:622a:1209:b0:305:2d22:3248 with SMTP id y9-20020a05622a120900b003052d223248mr9153550qtx.189.1656338075795;
        Mon, 27 Jun 2022 06:54:35 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id t16-20020a37aa10000000b006a760640118sm8624036qke.27.2022.06.27.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:54:35 -0700 (PDT)
Message-ID: <0abe475a7b4b04758c03a9d19b228e86d95ac1dd.camel@ndufresne.ca>
Subject: Re: DMA-buf and uncached system memory
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>
Cc:     "Sharma, Shashank" <Shashank.Sharma@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media <linux-media@vger.kernel.org>
Date:   Mon, 27 Jun 2022 09:54:34 -0400
In-Reply-To: <95cca943bbfda6af07339fb8d2dc7f4da3aa0280.camel@pengutronix.de>
References: <91ff0bbb-ea3a-2663-3453-dea96ccd6dd8@amd.com>
         <YCuPhOT4GhY3RR/6@phenom.ffwll.local>
         <9178e19f5c0e141772b61b759abaa0d176f902b6.camel@ndufresne.ca>
         <CAPj87rPYQNkgVEdHECQcHcYe2nCpgF3RYQKk_=wwhvJSxwHXCg@mail.gmail.com>
         <c6e65ee1-531e-d72c-a6a6-da7149e34f18@amd.com>
         <20220623101326.18beeab3@eldfell>
         <954d0a9b-29ef-52ef-f6ca-22d7e6aa3f4d@amd.com>
         <4b69f9f542d6efde2190b73c87096e87fa24d8ef.camel@pengutronix.de>
         <adc626ec-ff5a-5c06-44ce-09111be450cd@amd.com>
         <fbb228cd78e9bebd7e7921c19e0c4c09d0891f23.camel@pengutronix.de>
         <e691bccc-171d-f674-2817-13a945970f4a@amd.com>
         <95cca943bbfda6af07339fb8d2dc7f4da3aa0280.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 23 juin 2022 =C3=A0 11:33 +0200, Lucas Stach a =C3=A9crit=C2=A0:
> >=20
> > See for example on AMD/Intel hardware most of the engines can perfectly=
=20
> > deal with cache coherent memory accesses. Only the display engines can'=
t.
> >=20
> > So on import time we can't even say if the access can be coherent and=
=20
> > snoop the CPU cache or not because we don't know how the imported=20
> > DMA-buf will be used later on.
> >=20
> So for those mixed use cases, wouldn't it help to have something
> similar to the dma_sync in the DMA-buf API, so your scanout usage can
> tell the exporter that it's going to do non-snoop access and any dirty
> cache lines must be cleaned? Signaling this to the exporter would allow
> to skip the cache maintenance if the buffer is in CPU uncached memory,
> which again is a default case for the ARM SoC world.

Telling the exporter for every scan is unneeded overhead. If that informati=
on is
made available "properly", then tracking it in attach/detach is sufficient =
and
lightweight.

Nicolas

