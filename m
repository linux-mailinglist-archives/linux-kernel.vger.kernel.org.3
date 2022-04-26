Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4CF510C15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355866AbiDZWh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355853AbiDZWh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:37:27 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BF21344D4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:34:16 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e93bbb54f9so134221fac.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOVruyTRY05/IB4dGodf9j5s8WkZhLYEMF1zPjhJnqU=;
        b=FJgqu7tUhGTf4pp2slwvkEMS7a5eJjGcvKCLSIztNY+14AkXepqJ0SqpdNBcZky/WX
         Fb90MZZxHTxzXlynFw3KyoxfOqTufkEYeGoGRNzqOyKWVxYAUerSB1pA3QZMrJsotXdQ
         YjIu5S4xHw9lauMzCV2DA+LrVZzjomjl/ywhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOVruyTRY05/IB4dGodf9j5s8WkZhLYEMF1zPjhJnqU=;
        b=qMhwvPt4D01fJi+J1p5WY2VJQiYd3H3a1Cf6LPTv8+kXR+t4NsMEDQs4vmQsvEPrmF
         FKByN5X/dy6Jy91MrdwrtlEJmUWfb6aJ/gUVlQnonF3obrPy2a/S0Tya5UreH8PkoCq2
         Yqt8Pz5cI1EN6hMRRhP/0WcvezDJRo4Je0cK+63Nc82VmaElkF/yGxLAja9rE72rr38h
         X8V56nOxF2Bw7xnxoiUDGIz5ldHwgavjGhCfEDwX56QUdla6BeHTTKJND5hXlE8TE1kK
         s2UmCBwdFVo7gWozFd6fy9Ht6qLiAmMG+5EpEXf0nw7G9VyEirMA96cDE+5VS3ln85gs
         99QQ==
X-Gm-Message-State: AOAM531LT3Sp4eN4gwAgxTcDrJ8TQvkmdNHt7szZUmitzbLPKDiXWDHD
        x9fozmWTMuJvfe41bt5n1JNsyh8L9ewdWQ==
X-Google-Smtp-Source: ABdhPJwOpLj5Ly429rmM33WUDOYp82+YWiEPhE6zL/aoWB1xUT+jUGRKzH1nd6baINABHgBXpHpK5A==
X-Received: by 2002:a05:6870:5702:b0:e2:9f03:dae1 with SMTP id k2-20020a056870570200b000e29f03dae1mr10328824oap.201.1651012455252;
        Tue, 26 Apr 2022 15:34:15 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com. [209.85.160.41])
        by smtp.gmail.com with ESMTPSA id q203-20020acad9d4000000b002f8ee3f69e2sm5414868oig.52.2022.04.26.15.34.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 15:34:13 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-d39f741ba0so126312fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:34:13 -0700 (PDT)
X-Received: by 2002:a05:6870:4201:b0:e6:47c4:e104 with SMTP id
 u1-20020a056870420100b000e647c4e104mr14046899oac.257.1651012453086; Tue, 26
 Apr 2022 15:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220426221859.v2.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
In-Reply-To: <20220426221859.v2.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Apr 2022 15:34:02 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPNFwvYVBMHjbTNQ-uTnQrs5TvPAH2jXgPKuFLUw2GbZA@mail.gmail.com>
Message-ID: <CA+ASDXPNFwvYVBMHjbTNQ-uTnQrs5TvPAH2jXgPKuFLUw2GbZA@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: skip ath10k_halt during suspend for driver
 state RESTARTING
To:     Abhishek Kumar <kuabhs@chromium.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:20 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> Double free crash is observed when FW recovery(caused by wmi
> timeout/crash) is followed by immediate suspend event. The FW recovery
> is triggered by ath10k_core_restart() which calls driver clean up via
> ath10k_halt(). When the suspend event occurs between the FW recovery,
> the restart worker thread is put into frozen state until suspend completes.
> The suspend event triggers ath10k_stop() which again triggers ath10k_halt()
> The double invocation of ath10k_halt() causes ath10k_htt_rx_free() to be
> called twice(Note: ath10k_htt_rx_alloc was not called by restart worker
> thread because of its frozen state), causing the crash.
...
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> Co-developed-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> ---
>
> Changes in v2:
> - Fixed typo, replaced ath11k by ath10k in the comments.
> - Adjusted the position of my S-O-B tag.
> - Added the Tested-on tag.

You could have retained my:

Reviewed-by: Brian Norris <briannorris@chromium.org>

but no worries; it's just a few characters ;)
