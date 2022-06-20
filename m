Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03A55526C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbiFTV4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFTV4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:56:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C8D193F9;
        Mon, 20 Jun 2022 14:56:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so11488506pjz.1;
        Mon, 20 Jun 2022 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=151HFblY1lwXymNA1HK3iTBlso3zy5ZP5wBtRRxvVyM=;
        b=FDjiPDUY1wEBHX0EiYNuHM/qYw050Hq+iRQvd4EP8+MGqSjx4Yjs+VTXdZqVKpgLJy
         7f74qcI0JcBYLmYPNTg+4N5+S1MDn9jg1IuVphw9n6uf/nJXfcxgZba8NC9IH4Imp13H
         /8gR/xXyZE1y5tnQpuGXDLVlI9owurBJCUwLQpNvNNARCJR7CbUJrIm2Y/UR+kM6oG+q
         bzvmtgBQJB6ftlqi7dDvHEU+JxxKiOJi9oxDngM0pEKcTolsScPpbT3mepRtrGTie5mo
         H3iKweYXz2KzfmrhPTV0YsFQ0WE5QZlkKMY/ExEC2Z7kN2wCTurg9DY5npEWp7ogvUlh
         eH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=151HFblY1lwXymNA1HK3iTBlso3zy5ZP5wBtRRxvVyM=;
        b=cqbdwRl2SXnqbDAe7rVSBKxBQPYIyAlYya3UdCZB826ttPcySy2W1JPW4L9u/uJgMv
         KE9qclP1ethYzqVm3O8PpJK0guV3YdzNCwXvDOexV3eaT2H3MGRUsESwv/yyNLeY77Nb
         ItphVmGI6GTNALQh5RtQRcsFHPkG/zkZIqS5aXTY3yujlW452SeF3V0yQHsVDHbPXONi
         7d/fUCxzrAPldg8ZFNzZNZWbRuc2N5OpNdWTl1BWbPxF0QQUJENmMjck3biRsAcA9sTV
         dehTifY3NLNWo4Yp9jfZcSgr9ckubpN5pOGT8vGJh7rASGz5eQPWAR3M9RtwTup992ZT
         mZ0g==
X-Gm-Message-State: AJIora8NEawSQcNhqFDhwTy2PbKqFUxqiyV24/Oe3IfcwxNwudKqL8ed
        MXFPVmUiFXflTafqabs31dmvJ2RFgvj/wykej7Y=
X-Google-Smtp-Source: AGRyM1uZ7KnjmzjDpF3W2OjlRCHTeTuo+S+rOMEbCoW+lJpejZfY+1YHwemZLUml543VwaM0fhEIwnstamfY9Hq2b/Q=
X-Received: by 2002:a17:90b:1c11:b0:1e7:8bd2:697d with SMTP id
 oc17-20020a17090b1c1100b001e78bd2697dmr39976866pjb.90.1655762197720; Mon, 20
 Jun 2022 14:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CtjkjsbOTaNF7+Hwswsn-fs2WNK=zyFL53JnBBpS8=0Q@mail.gmail.com> <CAHp75Vd9yah3D8dUOPinhj=nm9GQs3xOsWZRL=6CvaROZC3OCQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd9yah3D8dUOPinhj=nm9GQs3xOsWZRL=6CvaROZC3OCQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Jun 2022 18:56:27 -0300
Message-ID: <CAOMZO5Bp83NSWPmbwp4uzrGSVkW2xQ+pRMFHaghs_XN+j32fcw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
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

On Mon, Jun 20, 2022 at 6:34 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Still? Does it mean you have it before my patch? If no, I will be very puzzled...

Yes, the warning is present before your patch.

> Otherwise does the touchscreen work?

I cannot test touchscreen at the moment.

>> Any suggestions?
>
> Perhaps, but we need to eliminate the proposed change from the  equation

If you send a v2 with "#include <linux/property.h>" then you can add:

Tested-by: Fabio Estevam <festevam@gmail.com>
