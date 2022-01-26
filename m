Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BBA49C3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiAZG45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiAZG44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:56:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1288C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:56:55 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k25so36360269ejp.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=t8hOeIp91qIAihHomDZFOV5h+fopZv1icntSUvmh1gI=;
        b=RGFGBymCwu0l/NBsyeMfQgzgJQNYpLDTxR/7RkPIekobVCqJdvE0sDmSmm5qUmRC6T
         0l75RtvvQOAENZKibU9bi3Fr/9T6ureFFHP9Xw7DD6QMmDwZ3umzuFdUImEdpQYq23C6
         sqGXK5Pk/gNVPdgC3XPhVTtQqj3j5m1UtCUP7Njl3a9Ww6AOC4S3hNTa2DkVygh1vZLy
         huMM2VWk/wmzpI5CrmpV67pSziASp2mJBfRKPsrIQgmd96FHYfHtRNWtU5ehuNN6ou3H
         Y/n10d9a5I7BSfYBfQjd5Vo2b8UdKiiww5V4tMg9BPXnq4dHegsC5UJy/8itpLvKt2al
         v+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=t8hOeIp91qIAihHomDZFOV5h+fopZv1icntSUvmh1gI=;
        b=cYCElnggFHSUqOg4AaxjUlJqcWnjWswQuyqtxh14B4zjnQNTOY8t+3Dv/vv40OulxZ
         aC5pnU9LRtVysO0svvcfvufKc3cpcvbEiBZyrGiKh2ApwdOWkgQ79r/BeEIkn0S/qe5d
         dv0Ut72citSC8iPkTGwGa9f/S37sgz5Mot6RFOLffkOMilksN2A63v3u+WLogFiM1K8L
         CDP/uD1H+0G+PFP9lekcLlJnxQIDzpyrU6XZtel9RoGdeHSilcq6NVU0K81engcXB+ib
         jZx0ATmhNoRcbKG+SVwGLApi6STqAQ4yyMWQHwZksN58yqb1qZSgHHUqCWt0buD2K6Ra
         zs+A==
X-Gm-Message-State: AOAM530npdRgTX/C6f68bSsPXTgoDeTuXZp0AcLD31TnNdbM5WqKs7Ft
        3wyZkWl+T6W2JhV5bu4LztOD60mTMCWp6ns6vgcnMA0DCcz0U9aN
X-Received: by 2002:a17:906:4347:: with SMTP id z7mt16228582ejm.671.1643180214351;
 Tue, 25 Jan 2022 22:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20220113060235.546107-1-jaeman@google.com>
In-Reply-To: <20220113060235.546107-1-jaeman@google.com>
From:   JaeMan Park <jaeman@google.com>
Date:   Wed, 26 Jan 2022 15:56:43 +0900
Message-ID: <CA+9Zrq-=of09w0BhpwMeYGYK7dTJ=9evHO3KKr5MTLzV+eER3w@mail.gmail.com>
Subject: Re: [PATCH] mac80211_hwsim: initialize ieee80211_tx_info at hw_scan_work
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alistair Delva <adelva@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Gentle ping on this patch.

On Thu, Jan 13, 2022 at 3:03 PM JaeMan Park <jaeman@google.com> wrote:
>
> In mac80211_hwsim, the probe_req frame is created and sent while
> scanning. It is sent with ieee80211_tx_info which is not initialized.
> Uninitialized ieee80211_tx_info can cause problems when using
> mac80211_hwsim with wmediumd. wmediumd checks the tx_rates field of
> ieee80211_tx_info and doesn't relay probe_req frame to other clients
> even if it is a broadcasting message.
>
> Call ieee80211_tx_prepare_skb() to initialize ieee80211_tx_info for
> the probe_req that is created by hw_scan_work in mac80211_hwsim.
>
> Signed-off-by: JaeMan Park <jaeman@google.com>
> ---
>  drivers/net/wireless/mac80211_hwsim.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
> index 0307a6677907..95f1e4899231 100644
> --- a/drivers/net/wireless/mac80211_hwsim.c
> +++ b/drivers/net/wireless/mac80211_hwsim.c
> @@ -2336,6 +2336,13 @@ static void hw_scan_work(struct work_struct *work)
>                         if (req->ie_len)
>                                 skb_put_data(probe, req->ie, req->ie_len);
>
> +                       if (!ieee80211_tx_prepare_skb(hwsim->hw,
> +                                                     hwsim->hw_scan_vif,
> +                                                     probe,
> +                                                     hwsim->tmp_chan->band,
> +                                                     NULL))
> +                               continue;
> +
>                         local_bh_disable();
>                         mac80211_hwsim_tx_frame(hwsim->hw, probe,
>                                                 hwsim->tmp_chan);
> --
> 2.34.1.703.g22d0c6ccf7-goog
>

Thanks,
JaeMan
