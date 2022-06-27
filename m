Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2456355DB23
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiF0Nvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbiF0Nv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:51:29 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F97A47E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:51:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cu16so14767493qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=IO/5LQDipzPqsfiPf2oKew6mU+NIadwTqMByhggPg0I=;
        b=GOyk+HaLucKVVNkgp6ddt+d56vzd0A8t7G4KOm1AbUEU5/BeYVRzygTy8xCIa+lNPf
         Si1v7SHohI30eBXdgPyC7mZJixMFZ35tJljXaSgkh0Li26Q+p0JAIButdSaunBS85MXd
         WXo6/Mf1UKxdoyn+uUXME6FEzJ7YFXrx6o2LDBi9QFHEZtTbCLtan2urHYd2GWdvzte5
         3V0ii1UopvsZFN2VxRhYSgOy6FU3B7szGbIf0CymZAbD0Ba5wzZmNVE7nN1mxUBGPJ2n
         duSOw6JuHYdOLa2znVpddX5BlAaBgG0AbhYMuNzwZXU/IS2NZvQlGSPIK6kyuB6VzIBx
         PFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=IO/5LQDipzPqsfiPf2oKew6mU+NIadwTqMByhggPg0I=;
        b=KhEj635TiVPaosDI1f4xgBoCf9Ud1Nt9yRfIqyd1R2nJSrUHlRUlBMJPWaxLPX4yuh
         XSn5cWtNWS1S3tAjvVQB/IzIgQfXaviZMdLC5ic0L8gqzFWC8BjXXqYIvTUvPpZIdKbX
         RQiGVGgq+8nKunbu2VHzAhb5iFUh9wsfgj5AxihnKZpnoWkhDmeEqA7v0d2WrRohYh0x
         x+a04/sJMK26HFya2o/U7ZIsiLGeYTsM/vRoC1yPVkBzNNAT8CspKYBV1sToInN8KXS8
         234WQuMxQGR7SxQzwILLEsXeiSP/D7h+8InYcCGqwdquX7RyjEPpbdx42VcPSIcNEQtr
         sisg==
X-Gm-Message-State: AJIora9344mGuGfcTSVB2Iv4N824n54137n09DnETg4HElyfcBcPCBKE
        0FW1YyPGrkND7UiMvOaC58/K+Q==
X-Google-Smtp-Source: AGRyM1uwTUgcdBTwPIHf6SCg4Il6IWSeM4ajg7IuHzzyn8HZDcP+XrUxKuXlZI8HzHEN016LOLSDHA==
X-Received: by 2002:a05:622a:5985:b0:31b:899:3093 with SMTP id gb5-20020a05622a598500b0031b08993093mr2059921qtb.616.1656337886689;
        Mon, 27 Jun 2022 06:51:26 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id s24-20020ac85ed8000000b00317c519be8bsm6996967qtx.66.2022.06.27.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:51:26 -0700 (PDT)
Message-ID: <36eef859d63640b4456360e17383635644703e3d.camel@ndufresne.ca>
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
Date:   Mon, 27 Jun 2022 09:51:24 -0400
In-Reply-To: <fbb228cd78e9bebd7e7921c19e0c4c09d0891f23.camel@pengutronix.de>
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

Hi,

Le jeudi 23 juin 2022 =C3=A0 10:58 +0200, Lucas Stach a =C3=A9crit=C2=A0:
> > > In the DMA API keeping things mapped is also a valid use-case, but th=
en
> > > you need to do explicit domain transfers via the dma_sync_* family,
> > > which DMA-buf has not inherited. Again those sync are no-ops on cache
> > > coherent architectures, but do any necessary cache maintenance on non
> > > coherent arches.
> >=20
> > Correct, yes. Coherency is mandatory for DMA-buf, you can't use=20
> > dma_sync_* on it when you are the importer.
> >=20
> > The exporter could of course make use of that because he is the owner o=
f=20
> > the buffer.
>=20
> In the example given here with UVC video, you don't know that the
> buffer will be exported and needs to be coherent without
> synchronization points, due to the mapping cache at the DRM side. So
> V4L2 naturally allocates the buffers from CPU cached memory. If the
> expectation is that those buffers are device coherent without relying
> on the map/unmap_attachment calls, then V4L2 needs to always
> synchronize caches on DQBUF when the=C2=A0 buffer is allocated from CPU
> cached memory and a single DMA-buf attachment exists. And while writing
> this I realize that this is probably exactly what V4L2 should do...

I'm not sure we are making any progress here. Doing so will just regress
performance of coherent devices used to render UVC video feeds. In fact, th=
ey
are all coherent except the display controller (on Intel). What my colleagu=
e was
suggesting me to try (with the expectation that some adaptation will be nee=
ded,
perhaps new signalling flags), is to read the dma_coherency_mask values on =
the
devices that calls attach() and adapt v4l2 exporter accordingly.

Its likely wrong as-is, not intended to be used for that, but the value is =
that
it tries to fix the problem, unlike what I'm reading here.

Nicolas

