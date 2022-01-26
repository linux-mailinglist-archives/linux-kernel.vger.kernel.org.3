Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9777049CCAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiAZOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242343AbiAZOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643208492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HN71mf0vMw5Y31vR+H9m6lal17Jfz5hrvv3szh/D3C4=;
        b=epBeAw3efLnD4ip3ouiLbUihMj+ErP6z3Bl5lds6Hp6Ik3VUJPP4iwMfFK1f0GmQNvpsJA
        hjRn3K8E3GlcNxkJqPENFnBOC7ZazMqDQ0bSJwUjXmOkzmBxBMWQvbXcm9BywEAw34fpcs
        +s91hDGK57WepcbK8iys7HFJ1AmEDe8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-qwEVo3fXNJmjtdR2VL4lqQ-1; Wed, 26 Jan 2022 09:48:11 -0500
X-MC-Unique: qwEVo3fXNJmjtdR2VL4lqQ-1
Received: by mail-pl1-f199.google.com with SMTP id ij18-20020a170902ab5200b0014b7c05a719so2436376plb.17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HN71mf0vMw5Y31vR+H9m6lal17Jfz5hrvv3szh/D3C4=;
        b=ebbuLDOwatLTcp+DaCagM3jhepeqexUsoWIeyezg6HCi/zFXWFqoiaWx8hHBZ0FCPl
         G1Amddbq2B0b3KkFQ+sr8TIcHTQBJMAhgvbExZBfy5ypUmA+7tXGyCJMHDq4tfrX0Xrh
         P4Ti7JR4ybNuGwxaTEqIU10nUzNir+jXe+RLOSPXdchnjS7qokV6hHfpwGC6oZB3tUko
         F8bPOV5CShUNFU23cjb345YCgAfXlD6gcHaSqsvpmJW6qpSQq442qvHwj02SaHBzHKHm
         tqGvdUaoYHY4bu41+uhRR1sVLrwvxs5bhONNO6Nekd9ICl1wk+EDB1F+FrJ8BTJa2Tpo
         lAfg==
X-Gm-Message-State: AOAM533s9V7VyPB7UsxankAUp7skpUzgs7770RV7zmXoSKiNj3i4Dd2N
        PYC+DMu849ukRam6DuKPZc4w0jSs+mftwP3v/nfjFWUeFJukO+Vm0Ti0Y1Xe/7SXfnuM7VRTEWO
        65PL5Cd10cvUqDA7nQWSJHntpgMOOOAuFEW+c+4fS
X-Received: by 2002:a17:902:cec6:b0:14b:81e8:ad1b with SMTP id d6-20020a170902cec600b0014b81e8ad1bmr5498070plg.116.1643208489474;
        Wed, 26 Jan 2022 06:48:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWvHZnYyLTDdYS3oEDLZxZ1+2etR/fUurJrH4irZ9idWQxNgLPQRRxu/O5mnlFNbkxO76hwhMViXdn3lSNADo=
X-Received: by 2002:a17:902:cec6:b0:14b:81e8:ad1b with SMTP id
 d6-20020a170902cec600b0014b81e8ad1bmr5498061plg.116.1643208489249; Wed, 26
 Jan 2022 06:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20220126144400.130797-1-lzampier@redhat.com>
In-Reply-To: <20220126144400.130797-1-lzampier@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 26 Jan 2022 15:47:57 +0100
Message-ID: <CAO-hwJ+KyV+Ks38DDF8EuT9kEc9jd9SvNn=nGyTwjkD3GOQ+RA@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-dj: add new lightspeed receiver id
To:     Lucas Zampieri <lzampier@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 3:44 PM Lucas Zampieri <lzampier@redhat.com> wrote:
>
> As of logitech lightspeed receiver fw version 04.02.B0009,
> HIDPP_PARAM_DEVICE_INFO is being reported as 0x11.
>
> With patch "HID: logitech-dj: add support for the new lightspeed receiver
> iteration", the mouse starts to error out with:
>   logitech-djreceiver: unusable device of type UNKNOWN (0x011) connected on
>   slot 1
> and becomes unusable.
>
> This has been noticed on a Logitech G Pro X Superlight fw MPM 25.01.B0018.

The patch looks good to me.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Ideally, Nestor, can you confirm this is expected and that we won't
have any bad surprises there?

I think we probably want this to be Cc-ed to stable once it gets
merged (we can add the tag as we merge it).

Cheers,
Benjamin

>
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  drivers/hid/hid-logitech-dj.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index a0017b010c34..9f68c0631439 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1068,6 +1068,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
>                 workitem.reports_supported |= STD_KEYBOARD;
>                 break;
>         case 0x0f:
> +       case 0x11:
>                 device_type = "eQUAD Lightspeed 1.2";
>                 logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>                 workitem.reports_supported |= STD_KEYBOARD;
> --
> 2.34.1
>

