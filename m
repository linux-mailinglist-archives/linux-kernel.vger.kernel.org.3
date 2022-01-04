Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7118483B45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 05:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiADEYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 23:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiADEYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 23:24:44 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B835C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 20:24:44 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q5so42715525ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 20:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=fysgzqADL/lBpOy4VPT5bc0kbkh347ywGZe1pIcOs5M=;
        b=qeBt172nL1IAP3rTVlHJnaaBDgpYbvJHhH5lPOjRLyaO6KNi9t8oOe+4S1MHsuL9Lj
         Ed4JlToLjjE5Xs0OBMzz739ioOgS/rlGl9eFdMtBnJTeIkbmfmfwyAWWPsLBDQ3Fc0vr
         W4L9hbuF2EA9WcKHl1W2nZ0VWLrxfneO1dGlVcpf7vI3k7MBU+R1QMLz7aliW8RisBPX
         PYW+vcNcyOd+lacwqzhK//8UIFjrUZOcpJYjvAol9RaQ8yeFoup8oNzPLhMPLN/f0INX
         o2dDy4DMgXG360NUZkMG+hvd+q+DrA9qr64MR3XoxWGTMVaq8Rlcs/rCmr2ACne+tNZb
         k1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=fysgzqADL/lBpOy4VPT5bc0kbkh347ywGZe1pIcOs5M=;
        b=EBMQrEl7VZyTAXc7NpRxwesjKKmDY8JSWr4vP3KcUqGeoOxp0K4MtG7yhs6FHPy4p0
         8QqGW26Kui5sSk4OovJmVyFmio/x6gZ+tiRtu/vMbY3TTKNKB4XIoPmxSfGvHqEVebUW
         AbFi1tc3i97QsHPxobGv+K9lqNNXYfB9MIMItW3vy1zcjVCd6Qlo5pqy0LbBgpnfIP2n
         RmC4e6mReSFV1IF+nQ4VGuaweIp/nESCPs9jg78LZty+bcLptVkGFspHzzYYY1X/3s5K
         DZp0fN3DzwvMU4kLPyiPo8Ma6p1TdkCmfjwgKnVYwe8JiClYfUVFEVZ5dj6NGCc5fFEz
         vL3A==
X-Gm-Message-State: AOAM530XMwNMrafI7B4c2ruMTinTO7SUMhGKsASIYXvKacQ+fUPmLrD9
        fI3KhjqRGw0VIjsrfRsMHFsCL7t56W0iSQ==
X-Google-Smtp-Source: ABdhPJxGj5WEFOVDh/ojNhTb+ma9rGNeAotZnvSLkrPSdnx9XVirxl9inzRwRgVtmcnpQig9LO7qCw==
X-Received: by 2002:a05:6602:330e:: with SMTP id b14mr19580953ioz.192.1641270283348;
        Mon, 03 Jan 2022 20:24:43 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y19sm19195536iov.23.2022.01.03.20.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 20:24:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220103162408.742003-1-gregkh@linuxfoundation.org>
References: <20220103162408.742003-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pktcdvd: convert to use attribute groups
Message-Id: <164127028280.171067.13286005071410412665.b4-ty@kernel.dk>
Date:   Mon, 03 Jan 2022 21:24:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 17:24:08 +0100, Greg Kroah-Hartman wrote:
> There is no need to create kobject children of the pktcdvd device just
> to display a subdirectory name.  Instead, use a named attribute group
> which removes the extra kobjects and also fixes the userspace race where
> the device is created yet tools like libudev can not see the attributes
> as they think the subdirectories are some other sort of device.
> 
> 
> [...]

Applied, thanks!

[1/1] pktcdvd: convert to use attribute groups
      commit: d5dbcca70182501bed99de85c224cef04c38ed92

Best regards,
-- 
Jens Axboe


