Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65002474932
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbhLNRWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbhLNRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:22:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70675C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:22:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id o14so14052502plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p4OSWNphBiQVoMt2kZ2nm3hHr3hL6tNHz+e++bXcpqc=;
        b=EjzdJ0O1ZCf9bCM5zR+2gwt+5GnbzH9DRXyTMFNStgi0KoGylGYuaN6jp/RDLlztGl
         ns7kABtr1itQ6Mq4FfH+yeSGuE0wCA2K5RZMhSIA2xlISrEYBMjx2ipeGP6OhCTr8nzH
         W3FvZ8cmcxY3EH4y/46kRwaKqMqO5StCPWy7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p4OSWNphBiQVoMt2kZ2nm3hHr3hL6tNHz+e++bXcpqc=;
        b=N54Io/eGt6/cndi8J+v6wnoKMBQQjnIPQu3fF3QW60Snn9NJRCkdQimxNVrZKBAjOM
         jIYW7k5eQrsVcbtNd7mnAKzrNgItxAvP8QP6g/j/QOuhn0fa2A04cKNjv33EqzOHZIFI
         j0U5FV3Y2NzmYxpAk7VZrCkPao4I4TL2hp8hKglYw+nxpNGmdQRaXNZmxa0j2zljqzFE
         YA3dj5SiMpJXV2oqYl1tOXzV5EimnbteHrafvTfcsFQME6N0hrpG+dbl/lhhfWfLbiVf
         sbmpvAbbFn4gI+43l+2F+J5VeVKasz00fDIFZ/jrI3giCGbqGaQObqY+P5sOKtc/rdoB
         VM+A==
X-Gm-Message-State: AOAM533y9da3NPTMIx0NR9a6UGdARi5yXWt24Z1dy7XX2mee7g7NjSV2
        hWCPZOl7YB9JH1R7RLHKaer2IA==
X-Google-Smtp-Source: ABdhPJyBm3ixztr1V0wi27Wp0/i4iiq4x1LaR18lktWzvg7nDADmuzarHD5daljHX6PPUTGTIgkAvA==
X-Received: by 2002:a17:902:7883:b0:144:ccb8:674b with SMTP id q3-20020a170902788300b00144ccb8674bmr6813402pll.63.1639502568948;
        Tue, 14 Dec 2021 09:22:48 -0800 (PST)
Received: from localhost ([2620:15c:202:201:5eee:2cbd:b842:f5c0])
        by smtp.gmail.com with UTF8SMTPSA id n16sm389899pfv.123.2021.12.14.09.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 09:22:48 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:22:46 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Panicker Harish <quic_pharish@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org,
        mcchou@chromium.org, quic_saluvala@quicinc.com
Subject: Re: [PATCH v3] Bluetooth: hci_qca: Stop IBS timer during BT OFF
Message-ID: <YbjS5sPkiyfl42np@google.com>
References: <1639484691-28202-1-git-send-email-quic_pharish@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1639484691-28202-1-git-send-email-quic_pharish@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 05:54:51PM +0530, Panicker Harish wrote:
> The IBS timers are not stopped properly once BT OFF is triggered.
> we could see IBS commands being sent along with version command,
> so stopped IBS timers while Bluetooth is off.
> 
> Fixes: 3e4be65eb82c ("Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990")
> 
> Signed-off-by: Panicker Harish <quic_pharish@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index dd768a8..6f44b26 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1928,6 +1928,9 @@ static int qca_power_off(struct hci_dev *hdev)
>  	hu->hdev->hw_error = NULL;
>  	hu->hdev->cmd_timeout = NULL;
>  
> +	mod_timer(&qca->tx_idle_timer, 0);
> +	mod_timer(&qca->wake_retrans_timer, 0);
> +

If one of the timers is already running it wouldn't be stopped by mod_timer().
I think you want a del_timer_sync() here to ensure the timers aren't running
when the chip is powered off.
