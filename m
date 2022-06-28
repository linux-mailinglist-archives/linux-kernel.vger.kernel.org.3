Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B902455E2AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbiF1E72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244499AbiF1E7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEC48DFA6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 21:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656392357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZNQqZ1BHUSITCdYmtKN1bf6mH2E51IBmEGFR1jGCIs=;
        b=Xc6Ilp/rasJ1r48Ddjjh3GKHk5fzkqgWAMI05TGQBAsYpI2hS3fcrP857uax21u93BOAQQ
        ZxZblTSAQ7E+7lzzk4FGGyq+mThJOpNi5kuv7zJZ/r88KZZyqk4fLOXu/532sAUvFTMT27
        hi7NJf9qO+y6mGJizp5y64xCowrPksk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-HrDToV-WO16e-wM57yUxVw-1; Tue, 28 Jun 2022 00:59:16 -0400
X-MC-Unique: HrDToV-WO16e-wM57yUxVw-1
Received: by mail-wm1-f70.google.com with SMTP id 6-20020a1c0206000000b003a02cd754d1so4566630wmc.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 21:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rZNQqZ1BHUSITCdYmtKN1bf6mH2E51IBmEGFR1jGCIs=;
        b=SSc6OEjBpsYa3NzQzPUq7pnuO6hS8ceSmaOiJythJnIiKCuIrBPgV917R53aKlp6sS
         zIv/FOYMaygboOF1BVXeVbLO1p0sWxN+RXHmjTUsOy6twQN1zxCs36FHF1k0Yb/AyOTJ
         BaEDmAMVFBr/KPZlNZi0BMXJPWwfJoiXMUZCCAWZnILoT9qFM0UVP/v5J5A393WmM0HP
         IFVCCTcjeT2JJ+H1YKljhfwVvd5hbtFOdCy/sdChm9lal1yeg6BWZBsHHs2qJMKLomqY
         qQdLPldgIVrsDTK6DYwWVHJnqq5JiT7aShvSdFRgEh0GbzZiwtYvT2QZJa/Zbebegu36
         lA3Q==
X-Gm-Message-State: AJIora/qwB46BqzwprGZd7esLnk2os7hbrHRoUR1+0zbIFUvj8NFuJop
        0FlTtnqnZdUSuHOum4bbV/AX8WoQzx6ZsMDpximMMCTWyt/KjGeCr3mPl0Rg2z5M/9KTaAFR4ep
        mmO2t0dFP53NvEEpSc98+UDyq
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id k6-20020a5d6d46000000b0021b933d7950mr15613692wri.679.1656392354560;
        Mon, 27 Jun 2022 21:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tyGGHEzmhFr36J5MuQpBJ//xCFRhKGBlqfoxm4YRVwOh1Ip5cEC8bLfCjZ0wmo1x6Rb/zEWA==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id k6-20020a5d6d46000000b0021b933d7950mr15613676wri.679.1656392354311;
        Mon, 27 Jun 2022 21:59:14 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0039747cf8354sm16024450wmq.39.2022.06.27.21.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:59:13 -0700 (PDT)
Date:   Tue, 28 Jun 2022 00:59:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220628005837-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
 <20211213054357-mutt-send-email-mst@kernel.org>
 <20211213185620-mutt-send-email-mst@kernel.org>
 <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
 <20220114151142-mutt-send-email-mst@kernel.org>
 <20220613025539-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613025539-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:58:59AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jan 14, 2022 at 03:12:47PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 16, 2021 at 08:58:31PM +0100, Marcel Holtmann wrote:
> > > Hi Michael,
> > > 
> > > >>>>> Device removal is clearly out of virtio spec: it attempts to remove
> > > >>>>> unused buffers from a VQ before invoking device reset. To fix, make
> > > >>>>> open/close NOPs and do all cleanup/setup in probe/remove.
> > > >>>> 
> > > >>>> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> > > >>>> to be doing. These are transport enable/disable callbacks from the BT
> > > >>>> Core towards the driver. It maps to a device being enabled/disabled by
> > > >>>> something like bluetoothd for example. So if disabled, I expect that no
> > > >>>> resources/queues are in use.
> > > >>>> 
> > > >>>> Maybe I misunderstand the virtio spec in that regard, but I would like
> > > >>>> to keep this fundamental concept of a Bluetooth driver. It does work
> > > >>>> with all other transports like USB, SDIO, UART etc.
> > > >>>> 
> > > >>>>> The cost here is a single skb wasted on an unused bt device - which
> > > >>>>> seems modest.
> > > >>>> 
> > > >>>> There should be no buffer used if the device is powered off. We also don’t
> > > >>>> have any USB URBs in-flight if the transport is not active.
> > > >>>> 
> > > >>>>> NB: with this fix in place driver still suffers from a race condition if
> > > >>>>> an interrupt triggers while device is being reset. Work on a fix for
> > > >>>>> that issue is in progress.
> > > >>>> 
> > > >>>> In the virtbt_close() callback we should deactivate all interrupts.
> > > >>>> 
> > > >>>> Regards
> > > >>>> 
> > > >>>> Marcel
> > > >>> 
> > > >>> So Marcel, do I read it right that you are working on a fix
> > > >>> and I can drop this patch for now?
> > > >> 
> > > >> ping
> > > > 
> > > > 
> > > > If I don't hear otherwise I'll queue my version - it might not
> > > > be ideal but it at least does not violate the spec.
> > > > We can work on not allocating/freeing buffers later
> > > > as appropriate.
> > > 
> > > I have a patch, but it is not fully tested yet.
> > > 
> > > Regards
> > > 
> > > Marcel
> > 
> > ping
> > 
> > it's been a month ...
> > 
> > I'm working on cleaning up module/device removal in virtio and bt
> > is kind of sticking out.
> 
> I am inclined to make this driver depend on BROKEN for now.
> Any objections?

OK patch incoming.

> 
> > -- 
> > MST

