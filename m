Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704684A86C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbiBCOoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiBCOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:44:32 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD889C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:44:32 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q204so3486335iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbhWRIOFYjgUC3Vb98+hQGA2AlTDbAX5g/E/ZuVec74=;
        b=E27QQ6wJuL3UmwpE9CQ6NCKwnrzvDVkIRvP3x9Jl3bZ48yhcJ5NgrprOkYYGCFF2dj
         sU7eOgR6FVApzEGit7UGjFPEK98K9huPKdypWNhgcRz72QgkP8NMMaPtSaQG8Y/DZFcw
         jV9Er86XWBIaAYokQXo3xujUImU9yG4PKbqDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbhWRIOFYjgUC3Vb98+hQGA2AlTDbAX5g/E/ZuVec74=;
        b=D0dcY2uJXgKu1Gw7m3NYpgG/XDnFxPqpDXOiDWmkKLorxaP/zyTZOs24nn2UeDMCH3
         emy2qZz3nUbuYOywHgPooM8GMT9bPiE0rm2hI/lg+azhJ5NkTTj8yq7V+YGzkgNQ5WdI
         uE06QyVxCaE99KPEs7T85u3BCR0jjikeHZb11rtq9wXGh0XhxkfCLu/mYEoCFqE8JBq6
         aE5+VQKM0RSesQhOz0ssc994Ypc72+0j7wInEXPfS6C7wCJgLnYINcjackyaTKDXyDkS
         wRFCKdehv3U0IGT1iEgpsrlyhfRa0LHPj5Ud6NDcxQIl89ZzHSZw2WUAR7wTYko79Ouk
         j4hw==
X-Gm-Message-State: AOAM5319bYKqMdqsfz+sYnxgsPAilx5BPek3GfWtwsoQUwNPDQhj0KQ6
        5LZpUlLXYyI94ag6aKv+v8wA4b8brgLi0A==
X-Google-Smtp-Source: ABdhPJykifNFjEn20kjsFP1qKEADGjPNzyoTK09Eqqr3WpCtg8E1WcmHFFavn6qMnGpN2QZCf35RBQ==
X-Received: by 2002:a02:95e7:: with SMTP id b94mr17089903jai.106.1643899471977;
        Thu, 03 Feb 2022 06:44:31 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id s18sm8546722ilj.53.2022.02.03.06.44.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 06:44:31 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id 9so3537788iou.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 06:44:31 -0800 (PST)
X-Received: by 2002:a02:3b67:: with SMTP id i39mr17234458jaf.50.1643899470709;
 Thu, 03 Feb 2022 06:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20220121064427.32059-1-quic_youghand@quicinc.com> <20220121064427.32059-2-quic_youghand@quicinc.com>
In-Reply-To: <20220121064427.32059-2-quic_youghand@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Feb 2022 06:44:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W-kPfnL2jB7bw4SSC=8hBfZg4kq7=rsHHCxDRj6yaSeQ@mail.gmail.com>
Message-ID: <CAD=FV=W-kPfnL2jB7bw4SSC=8hBfZg4kq7=rsHHCxDRj6yaSeQ@mail.gmail.com>
Subject: Re: [RFC 1/2] ath10k: Set tx credit to one for wcn3990 snoc based devices
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, quic_pillair@quicinc.com,
        Abhishek Kumar <kuabhs@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 20, 2022 at 10:44 PM Youghandhar Chintala
<quic_youghand@quicinc.com> wrote:
>
> -       htc->total_transmit_credits = __le16_to_cpu(msg->ready.credit_count);
> +       if (ar->hw_params.tx_credit_limit)
> +               htc->total_transmit_credits =
> +                       __le16_to_cpu(HTC_HOST_MAX_CREDIT_COUNT);
> +       else
> +               htc->total_transmit_credits =
> +                       __le16_to_cpu(msg->ready.credit_count);

Apparently 0-day had a bit of a problem with the syntax above. See
<https://crrev.com/c/3435607>. Basically you don't need the
__le16_to_cpu() around the constant HTC_HOST_MAX_CREDIT_COUNT.

-Doug
