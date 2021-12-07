Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC246B3CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhLGH04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhLGH0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:26:53 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42036C061746;
        Mon,  6 Dec 2021 23:23:23 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id m24so1381207pgn.7;
        Mon, 06 Dec 2021 23:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjS51En7n8gHrcWP/egVu3VHwRNlf0avUlOLs1QnapQ=;
        b=BBpa3nWIrGZ1flMBMsERcvYMGG0rm6vSv0vllKB7Az0QXGmSCFHa/NKP1kfb7XF8cC
         zXtjjOFBE1tbBC2GacT126muJ91Rlort9R+7UTaBNarmqYw5gBjaOWXG3mZctZmzoLrs
         oDAZuIZE8nus4KMMJIbPRaQaEec0yU41JwZ+EA8oaBcn+6onV7XE+Z0ZSZH29fZHbYB2
         KORI0/InWX4G+gCBwQInk4YEzHencJtw+aw2pkVHh1dYiR2eYg/IGU61D69kEaCGe4n7
         tP/8FvM1/JcF0K9/h9vIPCtyQvXuQ6Mb0EfJonmAuO6VBaAjkvGB7uhYhUnrZmEiH1eB
         fp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjS51En7n8gHrcWP/egVu3VHwRNlf0avUlOLs1QnapQ=;
        b=IGkr6tAMzirjfma26ZOxwMxjNLW/Yqo8MRPCWQ1YVN0FIHURlF1oqNz7h7mr/nrmPJ
         aeSlHxl5M+SzNsDHSwXYqzabPI8MaHJv9N2275aoDO9BINjEywvib0Dzo6nsx7Oh2nvM
         E/3L4qU/sT24yOW0b2qBlthmzTtk71rHACi0YT3KVZg8MypqjiABzPmG9ydjcNjUxVk3
         /hIgyFYnJUEFLnVJwct7Lph+O+napVXFf9nmLgZYqC6ICo5Hvc9mrOOU6zFuR3rTATL7
         /+pju1ngNOKF5/yTaZxqe097WnZP2OUEr0zdlSxOMr3LVVI2z5fVANFL2+2I8j0dUT1b
         Trog==
X-Gm-Message-State: AOAM530fNAQJWkiclLCMnk6J0d9A/IdwyWjTLJdnv/pBh4jxYsGvI/rh
        wiZq64cbVKjZTJ3wgnUzB45I5lBf8n4=
X-Google-Smtp-Source: ABdhPJzL9q+yGpYrRF8Wlz/n+/OmUlhngRHFwepBpr2M2lbOC8TLhwTXT95fYaZI9C+bSuT2fdB2rQ==
X-Received: by 2002:a63:6cc2:: with SMTP id h185mr23717412pgc.306.1638861802664;
        Mon, 06 Dec 2021 23:23:22 -0800 (PST)
Received: from google.com ([2620:15c:202:201:25b0:d110:b844:ea00])
        by smtp.gmail.com with ESMTPSA id g18sm14527030pfb.103.2021.12.06.23.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 23:23:21 -0800 (PST)
Date:   Mon, 6 Dec 2021 23:23:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-input@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ff-core - Correct magnitude setting for rumble
 compatibility
Message-ID: <Ya8L5x7cL5GKmL0y@google.com>
References: <20211130135039.13726-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130135039.13726-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:50:39PM +0000, Charles Keepax wrote:
> When converting a rumble into a periodic effect, for compatibility,
> the magnitude is effectively calculated using:
> 
> magnitude = max(strong_rubble / 3 + weak_rubble / 6, 0x7fff);
> 
> The rumble magnitudes are both u16 and the resulting magnitude is
> s16. The max is presumably an attempt to limit the result of the
> calculation to the maximum possible magnitude for the s16 result,
> and thus should be a min.
> 
> However in the case of strong = weak = 0xffff, the result of the first
> part of the calculation is 0x7fff, meaning that the min would be
> redundant anyway, so simply remove the current max.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Applied, thank you.

-- 
Dmitry
