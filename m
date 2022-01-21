Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858694964C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351841AbiAUSIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiAUSIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:08:53 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68362C06173B;
        Fri, 21 Jan 2022 10:08:53 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so12748382oto.4;
        Fri, 21 Jan 2022 10:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdV9jeW0XS2fClTtRWmHZ/pfb6gc0JxRxLCJ6LOKoaE=;
        b=meeX0EanCREvHkjbpCqG1ZNOiORRW+lck5Lrf1ekknEV8tSG9pCQLCeAnEuG4jpXD0
         bafWNuO2n56RKk4TdK9uv2oNQejIRjkllXH6p6aP4C9jAkMlf5+v0rcAW7sSOpN1Qweh
         lxSM31FA4Y43sLimq/jcXuW6eVM6AlExrxl1DXPcd/lnUWTfxapFeQ6Vroc9GMHHkVdm
         97m8GVhmzYVEmE10GbST644VMlhZCQisjDIHKzn7O25SSjVtP5rvi50XqDaxdl970OUf
         fiVIVPlAPQINuvTf/7SDsq/HZuPG3pCZGpJ3TIbB+GHG4qt4Msz5m9tPxcfApIeOkFGs
         jJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdV9jeW0XS2fClTtRWmHZ/pfb6gc0JxRxLCJ6LOKoaE=;
        b=7ZQ5ljfdMoojJtBWewgLdgGGEgy1abYzxPXqy2tjBMryxU+FZ9jsuVl2iIm8gR/A43
         k/7m00wCBZa/mQ3LqAERj0ZbaPsU3OZ6TFzrph94yMsH1Ez/c0KxOHRWArrX1AsHVBfM
         1Ib41ckLXGTW0MlBTdgBmleJiXd4WQLxr7iYzp11rFEzgqIpLPrP4XAcqzb3fuTFTmlE
         AGh8WURlScW4qgSiwft4baXSWJVXqs63TLgzksTUH/6yXTcrBHtx9HyL7MkxcH+P/Tva
         c5hMfz0zWF71vKjD1uK8OsmegmeT1UDPw+x1S3HoU2bppkxeB0ZmSkH00XnwR9hcz+so
         hvvA==
X-Gm-Message-State: AOAM532bVDL08nDTjw/DNXqGRRYhl3P6zc0f1hjFLg+sBqZJzwNHQcs4
        XOzKtyR3w+CS9hWfMIDif3s=
X-Google-Smtp-Source: ABdhPJwUwR1moHUHUerjoZQiDlOouzASByE3AZ2eOElQtAiRB0NohFq9+NrBSRM+s/N+I4ND4sgA/A==
X-Received: by 2002:a05:6830:2788:: with SMTP id x8mr3568081otu.349.1642788532834;
        Fri, 21 Jan 2022 10:08:52 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:f1a4:cff3:1fd1:7bc1])
        by smtp.gmail.com with ESMTPSA id m14sm1161490ooe.20.2022.01.21.10.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 10:08:52 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     daniel.thompson@linaro.org
Cc:     michael.hennerich@analog.com, lee.jones@linaro.org,
        jingoohan1@gmail.com, deller@gmx.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: Re: [PATCH 24/31] video: backlight: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 15:09:48 -0300
Message-Id: <20220121180948.2501-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121170540.w6c4wqwrqzpde2lm@maple.lan>
References: <20220121170540.w6c4wqwrqzpde2lm@maple.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Daniel

Thanks for your reply. This is one of my first patches, so I am still
learning. This series of patches affects others subsystems too (hid,
leds, sound etc). Should I create series for each subsystem
separately, instead of creating one series for everyone?
What do you mean by "this patch might wants to land in one tree"?

Thank you for your attention!
