Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2624E22CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbiCUJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345571AbiCUJBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:01:55 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1058C7CA;
        Mon, 21 Mar 2022 02:00:28 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id v14so11398604qta.2;
        Mon, 21 Mar 2022 02:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIZ3EUUKNdtUQ47jI5vIUZBFjHsbOyEGol2LvB0SN0o=;
        b=Qxv/MUakbXwXTRVO/SQZjifkWTraB0Rm845cccjc923wfyieY+oThu4I80gLXMhCoJ
         Bq4xBRcm/MIr8BEzMK8MLxpJeFpBhxhTIDHIdSUauT/Slnr5rbAHrB1c7qTmEctPab8+
         UD9RuBi9bbKeTSj0ZbYbughNdeiA5qaa6nKjpR/ieguZOWRFuVeEyalWpwWfKgslX3Zw
         u+E5M4/4z0GhVldXkNx9brEO7tx+9dH8r9mnMs6HaKGnITpbTsC6tw4mNiW+s71a4IAQ
         6+2gaU1JfzKutYNtT5ZUsXXDMgt1x1lqXGNhQiTpQ4W048YE/lWaX85C0WvwdA44TQ7u
         M1FQ==
X-Gm-Message-State: AOAM533bT6UM+3YeKf029hmGcH2kI/Ao+yMSS34YcPhWptpMxhFNXw7F
        X5rOa8IIQcPWf83XAkTZtCGTzMW9MBWAtQ==
X-Google-Smtp-Source: ABdhPJxbdHbBA3Bahrof3NselpCQ3MCeJHm0U7LjM7L4UufcxNIF2+MXvsTPmVtLCxiKPM3GrG3G/Q==
X-Received: by 2002:a05:622a:1822:b0:2e1:b2d4:d877 with SMTP id t34-20020a05622a182200b002e1b2d4d877mr15423381qtc.630.1647853227458;
        Mon, 21 Mar 2022 02:00:27 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id bm21-20020a05620a199500b0067d5e6c7bd8sm7374128qkb.56.2022.03.21.02.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 02:00:27 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id h126so26834183ybc.1;
        Mon, 21 Mar 2022 02:00:26 -0700 (PDT)
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr21473033ybn.6.1647853226676; Mon, 21
 Mar 2022 02:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <247066a3104d25f9a05de8b3270fc3c848763bcc.1647673264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <247066a3104d25f9a05de8b3270fc3c848763bcc.1647673264.git.christophe.jaillet@wanadoo.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Mar 2022 10:00:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgXek+BDT4vJQfFcwDgQfyDAB=wXfdC0poynzH26=okw@mail.gmail.com>
Message-ID: <CAMuHMdUgXek+BDT4vJQfFcwDgQfyDAB=wXfdC0poynzH26=okw@mail.gmail.com>
Subject: Re: [PATCH] zorro: Fix a resource leak in zorro7xx_remove_one()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, Mar 19, 2022 at 8:01 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> The error handling path of the probe releases a resource that is not freed
> in the remove function.
>
> In some cases, a ioremap() must be undone.
>
> Add the missing iounmap() call in the remove function.
>
> Fixes: 45804fbb00ee ("[SCSI] 53c700: Amiga Zorro NCR53c710 SCSI")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks for your patch!

The online-summary should be
"scsi: zorro7xx: Fix a resource leak in zorro7xx_remove_one()".

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
