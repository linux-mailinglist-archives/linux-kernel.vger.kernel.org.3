Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D64EC787
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbiC3O5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbiC3O45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:56:57 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDDA49CB8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:55:10 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 125so25038817iov.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=R/QA3qwuvc+FZQ+dv5ME79tUgBYzzyKos1+TF13+4yQ=;
        b=beGWf5RZrPnpIIOChN9iUKTh3sfzxfPCjZ2JKiQR+vhrtTmfVYrJe0tkng2GZnstMC
         KADRrLbuu5wPJEPpFqNfW0F0u3eEMSJszujRTf3I+7wa2RlYGONVH5KrzXP9E1odfute
         JRkkPR8lV4Efrsf8+D7wIP5Hb1xMf1K3Z9SK2P3S08WKyUoBNIVM4/taAaPTmn7mnyx7
         NebS4jRL7C3ErmStAR6cntI6m1Waae+ZCBjF4reLMj8qy5u/wfr//fADwKtS1kqIGWeG
         Sb1LFDbkiqUs39uWKHXAlSKgPr3PCQ7mnrLrfr/Ht5R6TSKr6qIgFEMT6d2y57XftrzM
         5LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=R/QA3qwuvc+FZQ+dv5ME79tUgBYzzyKos1+TF13+4yQ=;
        b=urFH37RBZGaGZ+K0CfyiE8G92DMzN/VLd3ZcojO56FOo3W+nunRUTAkPUvUk1qqn7K
         l7llWkR/TfNhklK1DgOLgKfNE3AtWIN3jUxBNO0OVXGaULzXaM9KG2G5Z8fRqKRDxCbS
         RXkxw9UnpfTUWEsHUp5sGn6Z5F8ERkwDZyqifjhtVbUA0T3p+/x7BmnuAlV94hYlvzMf
         vOt0tYmStL1/6OT1QIk6NqNjYHzFFIklAorVpvMeJ7u5GBZhMNJnGAfJuqWM8n469Hcb
         +aN1F/f/tFWJio0Kl3tKEJkgG2KloZ5TNE6be9EQPSZpQHUy9h6GdCxqaLGey4EC/Tzj
         k+wQ==
X-Gm-Message-State: AOAM530MhdbsHvf00d85KPk4o4yVMmEcMzvoonQyevK4bi0OAY0nEljA
        3tjMtK+rkhiO2HxunltdEbecCQ==
X-Google-Smtp-Source: ABdhPJz3ogEsUt77/dKerlk0+F1wbN/aqIEn3YfWAm1SNqiQ5Px+22BxvDghI7kN/xbnyk/nI0XREA==
X-Received: by 2002:a6b:14a:0:b0:649:a974:9042 with SMTP id 71-20020a6b014a000000b00649a9749042mr11501105iob.81.1648652109714;
        Wed, 30 Mar 2022 07:55:09 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q197-20020a6b8ece000000b00648d615e80csm11473586iod.41.2022.03.30.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:55:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Carlos Llamas <cmllamas@google.com>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220329201815.1347500-1-cmllamas@google.com>
References: <20220329201815.1347500-1-cmllamas@google.com>
Subject: Re: [PATCH] loop: fix ioctl calls using compat_loop_info
Message-Id: <164865210886.39485.16982992188546747372.b4-ty@kernel.dk>
Date:   Wed, 30 Mar 2022 08:55:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 20:18:15 +0000, Carlos Llamas wrote:
> Support for cryptoloop was deleted in commit 47e9624616c8 ("block:
> remove support for cryptoloop and the xor transfer"), making the usage
> of loop_info->lo_encrypt_type obsolete. However, this member was also
> removed from the compat_loop_info definition and this breaks userspace
> ioctl calls for 32-bit binaries and CONFIG_COMPAT=y.
> 
> This patch restores the compat_loop_info->lo_encrypt_type member and
> marks it obsolete as well as in the uapi header definitions.
> 
> [...]

Applied, thanks!

[1/1] loop: fix ioctl calls using compat_loop_info
      commit: f941c51eeac7ebe0f8ec30943bf78e7f60aad039

Best regards,
-- 
Jens Axboe


