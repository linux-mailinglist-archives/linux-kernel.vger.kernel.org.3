Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E534FCF83
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348737AbiDLGbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348699AbiDLGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:31:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4335865;
        Mon, 11 Apr 2022 23:28:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id bo5so16637033pfb.4;
        Mon, 11 Apr 2022 23:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWPJQl0O9reNTOqA4s+DVRhGYY/e+TZiRNvFAD49Eq0=;
        b=kl1Y3+MOsimk1c9G0ZgEIdYDzHXcFBZzXklwvq4vEtXlrTpi12RmuE3IPeBjDW5LXM
         LxAFmAXUAFLHQy2El+ofs1WDqstq9EaCxNxUb1L1tRg7xZrWSl8/YWJyDDbvn8giBWf6
         /y8jkanDcX85vyGuNmZaCJySQ64kzcbDV6W3LkxPp0ppiUz5MKTVJx/05B6sOOC/ecSt
         4lC/04NnRjL1gF62QMp7i7XSv+gpWX7D3nHPMUFmgS/h0TgbDgS+BQ/XlOsS0dFjULci
         VKFA2QuCCTvzSytAkdjleCQEC4s/b2MYp/UL0IKuabajylGFZKkTfmHtLbnYwMkqzSuQ
         4iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWPJQl0O9reNTOqA4s+DVRhGYY/e+TZiRNvFAD49Eq0=;
        b=koNxeqNoe7lo+lhhrpWgYjmri1c3+dnZTvQZYHOXWSWd4ow7SOu1oCD4hKrd01c+YR
         dp4E5nLTR8j8y2laJJp7S0TpR1miOgD9Q6VcDl8VG6pi/Ylw9GLzEX5h120AwaYnW1JS
         XBGO2GZOBeamlk5JxPIggMwdGnNqTOvfIsSqVDcKhZp6HMw68vPRDI29AAG87m5+2dLA
         /03VydwaHVUkJT+DSYu0uPwsxaYFnwgJktu9ictyN2plTubn/IKT1MWfEP6Nv+rhYVoQ
         6ieQODXa3dLOAUkAdhhjYo27ip3ulfSO9cN5foDHLtYaS03fNhXLFbNDcCN5pglMBkgt
         ymOQ==
X-Gm-Message-State: AOAM533to6Ba5tM28CDozy7shqNW64yA2QEE64Xn9AaCQCBlJfVGDYd0
        uHlK03h1sIh4+dmS00D6eS70ZJXT7s/D8c10SA==
X-Google-Smtp-Source: ABdhPJwFj1oEy80pxWbYOfZRRfn5FeybU3w4qp6NEf3c4Bnc7sWesUmDssvvU3fu59IukIuD4tc4rBe3c7GQbTYgxHU=
X-Received: by 2002:a63:610:0:b0:39d:300c:ad9b with SMTP id
 16-20020a630610000000b0039d300cad9bmr10300635pgg.113.1649744930773; Mon, 11
 Apr 2022 23:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
 <05433153-0424-ab66-1573-993d0490c5bc@opensource.wdc.com> <556511649635338@mail.yandex.com>
In-Reply-To: <556511649635338@mail.yandex.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 12 Apr 2022 14:28:39 +0800
Message-ID: <CAMhUBjn4HJAy2aXv_M9rSJcZZv7ZihyK3rb5bj2NFyFx6W5dUg@mail.gmail.com>
Subject: Re: [BUG] ata: pata_marvell: Warning when probing the module
To:     Ozgur <ozgur@linux.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 8:09 AM Ozgur <ozgur@linux.com> wrote:
>
>
>
> 11.04.2022, 02:53, "Damien Le Moal" <damien.lemoal@opensource.wdc.com>:
>
> On 4/10/22 15:30, Zheyu Ma wrote:
>
>  Hello,
>
>  I found a bug in the pata_marvell module.
>  When probing the driver, it seems to trigger the error path and
>  executes the function marvell_cable_detect(), but the
>  'ap->ioaddr.bmdma_addr' is not initialized, which causes a warning.
>
>
>
> Hello,
> i'm not sure if this is a bug because you get as ap points to a port number.
>
> (ap->port_no)
>
> it points to 0x1 port that appears in error message.

Please correct me if i'm wrong, actually 'ap->port_no' is zero, and
the 'ap->ioaddr.bmdma_addr' is zero too since it is not initialized.

> otherwise BUG will work and if it cannot read warning will return.
> ( BUG(); is macro )

Zheyu Ma
