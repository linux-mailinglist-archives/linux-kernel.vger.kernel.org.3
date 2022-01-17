Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ADF4910F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiAQU1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiAQU1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:27:14 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A80C061574;
        Mon, 17 Jan 2022 12:27:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bu18so39044489lfb.5;
        Mon, 17 Jan 2022 12:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvHJLX7IdGzz1pAEtv5SH8by2bDEnibSRbenuruMozU=;
        b=nD6UwUsWlWWn3+8gIxQfzwEte1mhQ83mOiZ+3vV1xc5HfFrToq2AaEPGH+oXHW836J
         /N3bzIZ3AFgdrNva4+qXJLPUEkFmr9or/lsmG4lfox1sI7QHUVEN1h510+NXEDLdsMLf
         J5mk/XXTQHcXCTS/uBriOCXz+qCc1J6PlGnS+1chS8pkOPRC3vDAXF2hva6AFxfpXeZ1
         cH5Ie0JtAbATuayIBP4uv4+CJPFinP2DLHQgcHmlLfk1MOD+lxp7pRhoSua0Fkx7wS28
         nbbXTTmnTOEnE+G1l2Del9r6UOH6/0G5IJTbGXBuAamiBDfoz6BvbK6gH+iV8FcogjgX
         DtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvHJLX7IdGzz1pAEtv5SH8by2bDEnibSRbenuruMozU=;
        b=KwS1hurd1zcYVZs5mOR2/I4wBlBFtButTlolo8soR8uzugOI19KCDwLWG2bmPb1XMY
         aR5Ei5j1vs2dndrYdMXBM+piBbmlOpG6KZbGdLco1D6jN/e8KMIJduLoCTiF+1Smlegu
         9xQoUDhm1Y3CZmKg6oXvbcXRslG/AgM7qzVQKNffdk2MRC+sF/2WNaHdIoI4uvm6/bqE
         /w1zOAWN1OgvZ29x7auTtedSaLu1n4QRGh251QvQ9ExAGSDyNUOvKvgEVchJg/BPlYMc
         wsuAEH947Df9Nmh6gjGqInjQerPABjAxzwdbqfrjeiDj4SI1zhz6JvvxO+iY/eFGw5d5
         1/yw==
X-Gm-Message-State: AOAM533YdzBMoqM79e4Y3t+X1wy8rGLjTM78cr7OkFCg3nl0en6MIOrX
        blpXAnZJUGknzjydYY4HgYMBY7G5xu66EwPvuzc=
X-Google-Smtp-Source: ABdhPJzSjj3jXK0JEgHFned13cyE7P7wdzpQ11/VjVcSoX3gLfiDYpRXata+lJUvxbMQTujI2IxyTJXRGpAP6SzaV9E=
X-Received: by 2002:a05:6512:3090:: with SMTP id z16mr11502446lfd.601.1642451232764;
 Mon, 17 Jan 2022 12:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20220114064625.765511-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20220114064625.765511-1-deng.changcheng@zte.com.cn>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 17 Jan 2022 14:26:58 -0600
Message-ID: <CAH2r5msz3iUwJVirtSmpZNbxpbtD3A8t7YfeGHDLtko6u4w+-g@mail.gmail.com>
Subject: Re: [PATCH] cifs: Replace one-element array with flexible-array member
To:     cgel.zte@gmail.com
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't this change the address of the assignment in this line in the
function (smb2_ioctl_query_info)?

        /* Close */
        rqst[2].rq_iov = &vars->close_iov[0];

On Fri, Jan 14, 2022 at 8:44 AM <cgel.zte@gmail.com> wrote:
>
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use "flexible array members" for these cases. The older
> style of one-element or zero-length arrays should no longer be used.
> Reference:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  fs/cifs/smb2ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index af5d0830bc8a..5c104b2f308a 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -1609,10 +1609,10 @@ struct iqi_vars {
>         struct smb_rqst rqst[3];
>         struct kvec rsp_iov[3];
>         struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
> -       struct kvec qi_iov[1];
> +       struct kvec qi_iov[];
>         struct kvec io_iov[SMB2_IOCTL_IOV_SIZE];
>         struct kvec si_iov[SMB2_SET_INFO_IOV_SIZE];
> -       struct kvec close_iov[1];
> +       struct kvec close_iov[];
>  };
>
>  static int
> --
> 2.25.1
>


-- 
Thanks,

Steve
