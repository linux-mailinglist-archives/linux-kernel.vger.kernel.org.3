Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDC532C10
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiEXORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiEXORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:17:06 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD75DA6D;
        Tue, 24 May 2022 07:17:04 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b4so3785612iog.11;
        Tue, 24 May 2022 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjuWKxDk9RAN3mZ0GM191A9EN0cxhiMzxFIkK2ExfSA=;
        b=a6GYOOPZGFhRIzp0awKIbDgh1fu/UomvZgkaErd8fsyrY1aWWO4xaEOmAnXQmC0Bd8
         EnwXwjoyuqdFdlRYjyn2dTanBjUyzC8STz4Ad/DRKs4eYmWLt1jm5TKLNOEH0ytuW1IB
         24Pn/+p0CocJFi/5B+jJdbjOA1rp1lQhl9jkZDmTeH7ds06yVCJD41Ozzg83issomAQr
         I8rt5n5TLkCflSICeyG3eVO3ze0mU+HsKvMPyNiuaEuGYQ9IGj+IQB/dW0JpWhwH7nTa
         Jl2PSHI6fPV504SrOp1xJuBCyHZEjdhSiUBtt8AIqcxK0N4ClsIV8hIAMhI77YWAkKDs
         NEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjuWKxDk9RAN3mZ0GM191A9EN0cxhiMzxFIkK2ExfSA=;
        b=2HMCUTygXVF4N8NxZbN/dYtXaK3vuA/FY8Q2jsX2HENoz5gQ8w4rhBQH48uo5xGz/B
         5witmlYyAn8q2iy/BLoLSG0L4sC8bZUoh/BEMpmCV2/xPWRJK+zZWXSSFSPKWiZ5hHxP
         Ho9a9HIvxQrHJc2pSxVq5KVxDaBhNNv8XMKszRMS9vPb8E65UscbsfWssXOb1AdLCTTx
         3FvRQ7EIrpJo+kma7U10CDQRX76HnCoC9SxLt9/fH83fk2ioWpsXPqnWVaV78F1WxAsO
         RVmBUve4ZcZe4oVrb/7aPrOk9xad9n2Bib5j/Kva+By/9lAH8kvX/QTSrFHlgoKcXW/S
         y6LA==
X-Gm-Message-State: AOAM531TOKvFde4lBvGFpG5Em5e8p3FTOpuV1GZuUcuPYkXle+QxkNMa
        K85oGdXKKRI+UlZr0hKaLZLFDKpeUAa+94hRpys=
X-Google-Smtp-Source: ABdhPJykNWAZ95bp152og2CRbhi4QrZD6lKX1NZOFb4EQCTUCb/ozKZrjBg5P4D8EwhRkLiji1LhF6OWWr74GocQp78=
X-Received: by 2002:a05:6602:15c6:b0:611:591d:1d9a with SMTP id
 f6-20020a05660215c600b00611591d1d9amr12331589iow.177.1653401823713; Tue, 24
 May 2022 07:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <23e0ba7863d51ab629498762a97d477645aeafea.1653123744.git.christophe.jaillet@wanadoo.fr>
 <CANiq72=GZs5CmAMGAMaHrp1yJ8b7nv3HrsWNeQ42kfy0z5uuAg@mail.gmail.com> <002f1094-3232-75c0-44e8-1ea77749cc2e@wanadoo.fr>
In-Reply-To: <002f1094-3232-75c0-44e8-1ea77749cc2e@wanadoo.fr>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 24 May 2022 16:16:52 +0200
Message-ID: <CANiq72k-QfLX4s3TN9BNZ+vKymMK76JS3j9QzqdiaL+333X8NA@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: Add an option to enable -O1 and speed-up
 compilation time
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dan <dan.carpenter@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:44 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Yes, I work on -next.
>
> Honestly, this "RUST flag" was just a mimic of the KBUILD_CFLAGS.
> No real opinion on it, I just put something that looked consistent for a
> patch that was only a RFC.

Understood, thanks!

Cheers,
Miguel
