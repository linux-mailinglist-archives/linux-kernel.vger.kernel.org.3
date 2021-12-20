Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B547AB11
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhLTOLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233479AbhLTOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640009464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7x3Yj+bf5SRda5v35eOr/TWOXggky5rJXTXtDeJkHCM=;
        b=heO8NlyYcQpmeAn/PCW0cpw4iayjEEEhf6XjwhaK+fbdtpbcKLSzYcUdNNyDQim240TmlQ
        O3bbh10EW0mxFGmkzu9quFu6xdG1hsktboLNjQDuLyVXeCs61QNd7iGmJG1BYimbXEyG2t
        JnfNEUrhYOhaXAPSMtgNYvjLQseLnMQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-t-FkDsZhPwCXGRY9sO9-Vw-1; Mon, 20 Dec 2021 09:11:02 -0500
X-MC-Unique: t-FkDsZhPwCXGRY9sO9-Vw-1
Received: by mail-pj1-f70.google.com with SMTP id p4-20020a17090a348400b001b103a13f69so9784943pjb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7x3Yj+bf5SRda5v35eOr/TWOXggky5rJXTXtDeJkHCM=;
        b=miaS7Zl40bPJwVzClV5y5DpfV6EigGomqo4YgzmqZ1blnUhaOHp7TcuFyvaVlobd+M
         1njg/jdEAF8qyNDRqHXZtxE7ZKebh922D5pQCHKets1NSkQ20uKvQsklnFyvsleO1K2p
         JVbPldhOLnvD/2cB5VYofjDcmQBbpID/mwDHEpf4DiFhzk7X8C0wTyiD1qyTXUiAVTvf
         3MIaKuIw7MRHmUGhMmgSBrfh4N63s5h0hC1c6gC6YuxDw3Inobo/Uc3owBOPIclcenfp
         FYNC0qGTVSj/2NowpUGuD/wrLWIQnBDmo9w333BBjwIi8SceW6DrLyLTY3wVDavbyXfc
         GLCA==
X-Gm-Message-State: AOAM531y6tv4hEB9fof1FRHqqGFG04LlA+pk8dEKDjQcaO9pIUU9kldb
        mfnAyJNY4wyFrJwkDPUyl+wDZ8Z00vQyagZ+j5iayZQPwmVLRD8gizTsnze7uTHDN1eqzjbb/tE
        U+G9MY2XhrfZChH6vKf6Ng+9z2ENfipwGJaowm/C2
X-Received: by 2002:a17:903:1ca:b0:149:2125:9a13 with SMTP id e10-20020a17090301ca00b0014921259a13mr2497949plh.73.1640009461413;
        Mon, 20 Dec 2021 06:11:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyz7Lzpf8qTZb+BOpbafi/m/Rtvan0nbNH0abUqJMPCoVzsBuO8rydUJne9VUVWoV1WbMaft0UiVp9emZclYxk=
X-Received: by 2002:a17:903:1ca:b0:149:2125:9a13 with SMTP id
 e10-20020a17090301ca00b0014921259a13mr2497929plh.73.1640009461208; Mon, 20
 Dec 2021 06:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20211215083605.117638-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20211215083605.117638-1-jiasheng@iscas.ac.cn>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 20 Dec 2021 15:10:50 +0100
Message-ID: <CAO-hwJ+VZscrj9yGOkPruuUXXkg4NOPRnj36aa+-+5JvGxGk+w@mail.gmail.com>
Subject: Re: [PATCH] HID: potential dereference of null pointer
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 9:36 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> The return value of devm_kzalloc() needs to be checked.
> To avoid hdev->dev->driver_data to be null in case of the failure of
> alloc.
>
> Fixes: 14c9c014babe ("HID: add vivaldi HID driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Thanks for the fix. I have now pushed it to hid.git, branch
for-5.16/upstream-fixes

Cheers,
Benjamin

>  drivers/hid/hid-vivaldi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
> index cd7ada48b1d9..72957a9f7117 100644
> --- a/drivers/hid/hid-vivaldi.c
> +++ b/drivers/hid/hid-vivaldi.c
> @@ -57,6 +57,9 @@ static int vivaldi_probe(struct hid_device *hdev,
>         int ret;
>
>         drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (!drvdata)
> +               return -ENOMEM;
> +
>         hid_set_drvdata(hdev, drvdata);
>
>         ret = hid_parse(hdev);
> --
> 2.25.1
>

