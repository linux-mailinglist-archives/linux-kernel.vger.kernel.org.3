Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0798494319
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357555AbiASWhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbiASWhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:37:01 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB1DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:37:01 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s9so1692280plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dxE4r1z1cIfSGWJM621bK96VrUIyVV92x6PrrwpFRXY=;
        b=3jmCLS/O1Tvc4I9EcgW+vSU8+bHw3fiuSLb8QBBFgnjhcJ5TBVgWAsgBRkL3a3BYKD
         B38FGcRvYxRCPVi9I//mp1Op4BJClqNBzMkBUd6cytmd/QdYvSp7N0XjWzvC8oGGsiZP
         YIoTbzn7LIhb7DJlIo12jni+ncZcxIDEl1lNAtS8/IYRdIMQhyD1m6LD7ntzYNxIi4sn
         7yK8JltnuRpVwKYL85hmJpwtSbixKHx9L9ZLo7vnpI6W7mzH8+gTgQ9XuKzBg0btwiD4
         lqiBj8d7xmg1PSH6vq7/iRvjAhhGASBFqeIMA7g6mDLZ9NltVPocwZazaaUs043hvvCW
         OQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dxE4r1z1cIfSGWJM621bK96VrUIyVV92x6PrrwpFRXY=;
        b=O1tqKhXgaHysRvuDlCUIax7x+f4P2Q024Qow0Ft9ZI++L2zVmV6O144GWrfVPvmSZM
         52PnjvcPfC5/I9jmwYFFEk/1UcwLTOL/2R9WtpnhV4oAQgm7+ELsYXP25ptOOtOQk21K
         v4fhDc8nC8rUiqjZ9xG5pKP/3MQr97np6lRayNxDH71uCkQFFic0EbPeH4LW4cUzI6oV
         DGSOPiYSEbYUEXT9leps2mQPvvuAPa/yr0gvqsiLlRBFpmtJWeK3l55FouAJ5KsmwUC4
         tfq40QnZXxnvqi+hbgepiWzUCqYd614u2xOYlsrusn1lkuGcjtYti81fVefc0eSZtHjl
         98Zg==
X-Gm-Message-State: AOAM530mzu/xRRnB2tk8FTrhy19H0v/pCUp5/1ykmZ2JZBBo0Uc5+z7w
        ypXLrjVlN8fNouBxRjmzG3gE/w==
X-Google-Smtp-Source: ABdhPJxv6F63q9VzJdxY0ckhpZZbC07AudfrnDivjIRxSeMR+ozHNzZi+g2TSfEoU169TmiRdyIcag==
X-Received: by 2002:a17:90a:6288:: with SMTP id d8mr6922737pjj.199.1642631820957;
        Wed, 19 Jan 2022 14:37:00 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id b9sm587995pfm.154.2022.01.19.14.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 14:37:00 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: Re: [PATCH V6 0/5] Use CCF to describe the UART baud rate clock
In-Reply-To: <20220118030911.12815-1-yu.tu@amlogic.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
Date:   Wed, 19 Jan 2022 14:37:00 -0800
Message-ID: <7hfspjqrn7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yu Tu <yu.tu@amlogic.com> writes:

> Using the common Clock code to describe the UART baud rate
> clock makes it easier for the UART driver to be compatible
> with the baud rate requirements of the UART IP on different
> meson chips. Add Meson S4 SoC compatible.

Could you describe how this was tested and on which SoCs?  There seem to
be some changes in this series that might affect previous SoCs.

Thanks,

Kevin


