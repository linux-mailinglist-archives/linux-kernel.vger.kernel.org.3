Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8280B484172
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiADMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiADMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:05:02 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27057C061761;
        Tue,  4 Jan 2022 04:05:02 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k69so91682097ybf.1;
        Tue, 04 Jan 2022 04:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/I5Ah1No+IpmF4Eci4a1wynvY0dF++LDExr+NlwhiM=;
        b=UVPDdtLwGsnHz/K20jufX5JZ/9azR61+VQ5FvbmkOzjCWST3oGp1ZurAEZfg1GtoUh
         tH8ryqv64HzXkgrlAcYN3qFVJzk/sdnoffVu3ekKrMU3Cq0D6C/9uXJ3YUsFXTPQAoe2
         6znMtVZwjHRr3aGrCecz6kqr9yal0Zw+Fv2ufDO6YRv8yPm12P09XxtvMzgHvoFTO9PW
         jU4+uHRzHM+1d2YcjNARSCPVYh+53vlkcz3ViTSuiUSN0OId1fhXOPRX4o5h/VL3pkDQ
         ahGvgbl0ysoT7UoGil7JlIcPgzQFk2MNKhkmnHicC/M+naiKdZ31cD7TstZ1aOjY62mI
         aVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/I5Ah1No+IpmF4Eci4a1wynvY0dF++LDExr+NlwhiM=;
        b=zqZAhokuU5nrrodEBaXj9D8lbXGqtxp3r+I3vAVYNpFibaegXLhpSqTrklypPwbv5U
         zxKVPufRI3JG/4vFa0dRroUqn2Wk5l8fk5zUpOKy9ysmHY5/Hu/bGOqsEZxtDOP6t/KP
         pkw3gPQTDTdRw2MuGsNrYmrY0unnlieyuq3JZrv2KEXcZlpdDPpBiNwfHiETGC0dC46R
         4TFlMTpI2X6aN4y1P7I+jEds3IEPpzVCTf7SLlSnAtRNW1B32m3+i9big4JeUYhT+6vl
         fCum0Q6jWubTy46M10lcaZYdAC0XSOZU3djZU8a/YLgHaPlM3bhp9fyqayGL3fP2IvAP
         Tswg==
X-Gm-Message-State: AOAM531pI19u9W5Qpo7ES3LeoAZSQnKvnqHEdOE6mqp/QjlSN0yHdXAX
        1kHUxUzn1Q7ky/easurZWtHa2cIhvZ2VgwtYMen87XiOkhI=
X-Google-Smtp-Source: ABdhPJx9Fc4XaNuqUUxkXvESNiwDEQ+10mI662MFgb2vVAgeLo6yDNKvk9sAHSSpRRXiQO18TexgNp6ER7/P4VH6W5M=
X-Received: by 2002:a25:2cd0:: with SMTP id s199mr48746235ybs.234.1641297901311;
 Tue, 04 Jan 2022 04:05:01 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMy=M42hapfG1S4ZT1v5WEdH2KYiF8Cgukmf48=FKFCyJg@mail.gmail.com>
 <20220103163532.GB3151@lst.de>
In-Reply-To: <20220103163532.GB3151@lst.de>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 4 Jan 2022 13:04:50 +0100
Message-ID: <CAKXUXMxxNBYhb37PQRnRaVAwd98ASKKeWDYDE11SzvyTQ9Lv9g@mail.gmail.com>
Subject: Re: Potentially broken error path in bio_map_user_iov()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 5:35 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Lukas,
>
> we can just remove the queue_dma_alignment check entirely, the caller
> already ensures bio_copy_user_iov is called instead of this case.

Okay, I have sent you a patch to do so:

https://lore.kernel.org/all/20220104120158.20177-1-lukas.bulwahn@gmail.com/

Feel free to pick it, reword it, rework it or ignore it.

Lukas
