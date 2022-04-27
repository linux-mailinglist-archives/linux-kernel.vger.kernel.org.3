Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182A4511077
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357837AbiD0FXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357846AbiD0FXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:23:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC11A82C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:20:38 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g21so1469615iom.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWO4Mspuj1NfsztZ/htvKaV2IwuMSQIdLcGu3cF8Od4=;
        b=LAveLaPAkwobxI2RuBJNilJKnbX2XKgLApjEquMlBS/UvoIN/9qxBt3vhewUmBv56x
         KE2L9cevl7O+cnyfshj0/9p9zQKEScaxxvr1QHchpU7rQPj9+tTMqDnU5ofETiDXHmD8
         iMUJOk60FQtBND6Lx5U7JP70EZ+4ypKXlSGMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWO4Mspuj1NfsztZ/htvKaV2IwuMSQIdLcGu3cF8Od4=;
        b=CHE3b5Za4IK0MxWeIjaHRzImgs5ltPxKTHoxDbSiqbTpBNVjJtxddLfboUraJTI8TL
         34ZW+330Oa7YbmLO3wdR6mNQzWAmekvp9JYmeWdSgbFpOXJ//3sF6X7/a4GOliAkf3vM
         s3bHnSUEHdj4tVFrFOX2aAgbdAqwg3TvFWukrzz1QRLOXkfVESjcMQyOhcBVtJm4Vp/Q
         5qY/DOuAeEzaBBUxFRh6cF2y9CAJgfgP74hXhH2h3+d7XlESS+mREAXwn4dpOHDSqOHE
         yapBpXtu5St957JnoDLu55CEyKmaIvNUK2mcIMnvf5Q+rb1+uic+cLoGBL35M9zCtmiL
         Ryaw==
X-Gm-Message-State: AOAM531MYKHAyVqjNpSvaUnd/2yH4jff7vNlZji4nBk74ytpR5cRlop2
        +v+cXNSNBf7Coq+1MhdWjNgu/GEhRAk86g60EFNaIw==
X-Google-Smtp-Source: ABdhPJxHWH/VmZfTUvM9ujXjTEU01KceOoaZNdOkUFInIFr9FVW1BkqTC5B6NSlGZgh0ev8kRRFVN+Ams+9EFezSwBY=
X-Received: by 2002:a05:6e02:1c0c:b0:2cc:1757:ebbe with SMTP id
 l12-20020a056e021c0c00b002cc1757ebbemr10000010ilh.205.1651036838034; Tue, 26
 Apr 2022 22:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220426221859.v2.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
 <CA+ASDXPNFwvYVBMHjbTNQ-uTnQrs5TvPAH2jXgPKuFLUw2GbZA@mail.gmail.com>
In-Reply-To: <CA+ASDXPNFwvYVBMHjbTNQ-uTnQrs5TvPAH2jXgPKuFLUw2GbZA@mail.gmail.com>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Tue, 26 Apr 2022 22:20:26 -0700
Message-ID: <CACTWRwtXSHnhxTEZ+pWWNpfd-BANtHuNUDimmwxJ=COL6HJQTA@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: skip ath10k_halt during suspend for driver
 state RESTARTING
To:     Brian Norris <briannorris@chromium.org>
Cc:     kvalo@kernel.org, quic_wgong@quicinc.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:34 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Tue, Apr 26, 2022 at 3:20 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
> >
> > Double free crash is observed when FW recovery(caused by wmi
> > timeout/crash) is followed by immediate suspend event. The FW recovery
> > is triggered by ath10k_core_restart() which calls driver clean up via
> > ath10k_halt(). When the suspend event occurs between the FW recovery,
> > the restart worker thread is put into frozen state until suspend completes.
> > The suspend event triggers ath10k_stop() which again triggers ath10k_halt()
> > The double invocation of ath10k_halt() causes ath10k_htt_rx_free() to be
> > called twice(Note: ath10k_htt_rx_alloc was not called by restart worker
> > thread because of its frozen state), causing the crash.
> ...
> > Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> > Co-developed-by: Wen Gong <quic_wgong@quicinc.com>
> > Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> > Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Fixed typo, replaced ath11k by ath10k in the comments.
> > - Adjusted the position of my S-O-B tag.
> > - Added the Tested-on tag.
>
> You could have retained my:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
>
> but no worries; it's just a few characters ;)
Oh! sorry about that, I was under the impression that if the next
iteration is posted, then I cannot just add the Reviewed-by tag
provided in the previous iteration by myself.
