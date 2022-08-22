Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4651459BA0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiHVHKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiHVHKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:10:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D62983C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:10:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w10so496360edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OXJSHC3u10OP+HTbMpSxeKMRN8oREsLJAZ1clqoMmSE=;
        b=RA4HZQCDGyC/SIDeLGpy5vj438ALKhnGrTPthx9WF5F5HpgPWbDULm3ZlExFGAc+XU
         9TsJVTaLDSbjyoumB0uaFuxID66Xi0UX+lP/uzTBbVBLCqQfOQBFVLTsNaa1Nu1gFVPM
         yeD6KyTOSzgfNeF+ICDsLrL4weCG72go6GbDCuVATFaQLL1ywpBnEq0oz5qGr/kfWznP
         HPQ43J8OvsDDKcrL7nl4kCWc1P9UBD8HnAqD/6Ukgwy98732aajgzuqiLeH2wptvoSh0
         cKvsSp87AAINTffTiuu/6mUev0LmUwqTYB3ivP+ugQlsh02tsfcavwdvLsx6Mp6hSRbf
         tEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OXJSHC3u10OP+HTbMpSxeKMRN8oREsLJAZ1clqoMmSE=;
        b=t8sU0OqBqb0uv54nWL6Mrr2lKb7T7fucoQlmWqf7vZgmnyGoukTCHboddMfbPuflYC
         wSGzpaWa5ZIIkxbecmRa7kwOGIHUm26Ckd/jAjHEe7ZrSC5ROoPckcCd9gOja/dRrKFP
         U7N3b/Kt+2OMRdTZHVYfzY87w7QRGXM6soY2JAa4EtH89bZnVBCvYfPeRTl92BpVW0RB
         hP9UcpNacO6ZCg1yDAZh12mZc8FswStWBjUu0KB946OQezVlHqNrAZ/Q42I79FNVhS3R
         lgiGTIRsiNj6SZWr9mKJxWceVVsjy9HCKrcfggtl68TlAigJ8vlNesGNBTYWLnpd00JI
         5/Yg==
X-Gm-Message-State: ACgBeo0189KqPDoat4IF6I1oIVcxtWy664FWjyxNclrw84b+avcJrlzz
        WMxw6Z71uiSiplIgTDEDqqmDuECvg5qAfgA3sNqpbav3hdE=
X-Google-Smtp-Source: AA6agR6GlsGATx8E1XQpTn7CSZWm+8KDw8Qzr9k38Vth1pGheZzAb26A/rhtk2zLUbTv2V3eAdYhXR2P8sP7f+aMfWg=
X-Received: by 2002:a05:6402:5106:b0:440:3693:e67b with SMTP id
 m6-20020a056402510600b004403693e67bmr15167256edd.226.1661152244210; Mon, 22
 Aug 2022 00:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-15-jinpu.wang@ionos.com>
 <20220821055745.GA26064@lst.de> <CAMGffEkhQd6oGgg+m9AUkquYnkufyrt1ptEkg5LG_HE_7s-Vsw@mail.gmail.com>
 <20220822062537.GA21455@lst.de>
In-Reply-To: <20220822062537.GA21455@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 22 Aug 2022 09:10:33 +0200
Message-ID: <CAMGffEk1CJAkaZi5GHrKdW-y1HQRUuo0YfRuGR8hFpNe1dZyoA@mail.gmail.com>
Subject: Re: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 8:25 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Aug 22, 2022 at 07:12:23AM +0200, Jinpu Wang wrote:
> > On Sun, Aug 21, 2022 at 7:57 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Please don't send me just two random patches out of a series, as I
> > > have no way to review them.  If the patches are independent, send them
> > > independently and if they depend on common prep work send the entire
> > > series to everyone.
> > Hi Christoph,
> >
> > As mentioned in the cover letter, the bugfixes are all independent,
> > for each of the drivers.
>
> I still haven't seen the cover letter as it was never sent to me.
> But if patches are independent please send a series per subsystem
> as that makes that very clear.
Thanks for the hint, this definitely helps the subsystem maintainer to
get a clear background.
I'll do it in the future.
