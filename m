Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF946B3C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhLGHYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhLGHYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:24:23 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681DC0698C3;
        Mon,  6 Dec 2021 23:20:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so1890499pjq.4;
        Mon, 06 Dec 2021 23:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7NhaFlgTlpHBmCQ/Myhs69h/DpMo/3O0GaxFUNvHdeg=;
        b=GssPBZJrHosVhYrE6JSKGMJEBG/mCYU1HptrhLmrC0yxSWidCbmNJWKePmUAXY2PYX
         HAcnUYkl1IoKnKJVYCWiC+5MotxtIkMBrydN782o5f06NCaXeZx0et/p7+QH0NkuWf1s
         qdryt+TdREQECxXqrWW7IRkkPRB4425nRqpp3nrBLJEIfjQ0DsRKJlVOg1jfsyOZQyjp
         MyuwivhPGCeD15uA0ZMnBWgRqMqSjoaSoyYL7iJ9i3VMtSvoEqXfsGgf9VO2H0NGzVFN
         Ag3fKtNJKtBV7Z1c8prsflvNb/O2QqPu/qWyBKEPD7lfdqysb1bz/tGZztENW1vYP7wU
         Yvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7NhaFlgTlpHBmCQ/Myhs69h/DpMo/3O0GaxFUNvHdeg=;
        b=rq4GaVOcxd1a6FNL1tTFa1cKNR7amWs11WnVmEif3UqZP9JRsZSZEMs4t0Y1k18zef
         q9YrIICXGuhgzcVlIG1oPeCr9+MkBZ8tgcqf4DrTXhRMs1E78tkbX5mJoEJOtbmE0VzL
         RLYdtG5ZQkN13XnWg6kPMLmxILxczAPmKJ7nBxDC5ldW2LgNmGLXBGsPZvfcOMQ82Y0O
         SwVsdaCyGK4vWI6huzBIV6q4AyTOlTy1aAUK+ndotU7YsBwMTwIK6Fm/hvMkjPVGXWDg
         VVzXqPRRLQKfocm8DwpmJKe59STo26H+x/Du06lt7t2y9QQt4AGZyL8XA1C+4joYTIRM
         XcIw==
X-Gm-Message-State: AOAM532HU64muxhiWMq6N3XVEDo1BKMRGew3+jyTp4qMu6VSiMRy3h39
        V9RIaxD+w3T8q5MrNO7BToYuCgHoLWU=
X-Google-Smtp-Source: ABdhPJxpEekoP7HBjFGLmfa7yIPRnVHIp5Repv9gpdjevv9e+73db6NSsrzU7ANQ5A28mSIFVZ6n+Q==
X-Received: by 2002:a17:902:f545:b0:145:4402:c334 with SMTP id h5-20020a170902f54500b001454402c334mr48514899plf.65.1638861649290;
        Mon, 06 Dec 2021 23:20:49 -0800 (PST)
Received: from google.com ([2620:15c:202:201:25b0:d110:b844:ea00])
        by smtp.gmail.com with ESMTPSA id j127sm14737783pfg.14.2021.12.06.23.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 23:20:48 -0800 (PST)
Date:   Mon, 6 Dec 2021 23:20:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] Input: i8042 - enable deferred probe quirk for ASUS
 UM325UA
Message-ID: <Ya8LTs/l5xAJKymP@google.com>
References: <20211204015615.232948-1-samuel@cavoj.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211204015615.232948-1-samuel@cavoj.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 02:56:16AM +0100, Samuel Čavoj wrote:
> The ASUS UM325UA suffers from the same issue as the ASUS UX425UA, which
> is a very similar laptop. The i8042 device is not usable immediately
> after boot and fails to initialize, requiring a deferred retry.
> 
> Enable the deferred probe quirk for the UM325UA.
> 
> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1190256
> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
> Cc: Takashi Iwai <tiwai@suse.de>
> Link: https://lore.kernel.org/r/20211117063757.11380-1-tiwai@suse.de

Applied, thank you.

-- 
Dmitry
