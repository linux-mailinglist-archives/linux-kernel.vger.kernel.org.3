Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FCD558AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiFWV0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:26:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F06551E5C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:26:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ge10so813153ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W457I2l5RFm8vi3OAKFMpeADxn0Oxv8muZtylILpgpc=;
        b=jQKPPJer8kzjeU3krkA9h8NYl+8ae/4sd8vnJKce7dDLs+Ibie/h051V4l+6KOrk93
         RNKVA9Zw0EUIv90J6u14b6tzHmoF9Wcq7nPVt0eyyAZ7At1jr3/dSstH4rvaCybn3yhB
         Ajw6ojKrKp4U2I8iUKfDWYFgM0B5R580Uq+iIzmdpblK+hBq/KglKuCLjvWc5yPnhB2g
         2LmAcTs7QqElkSJI52QHshf/esTVTIdQLFg2BTIMKNi7WLLlb3LV7Uo5hTR6UdqZ5aqX
         Ifq3+w0AV1kvm/4qGa8vPWcsXdk7Rb2F4o6T01ik9Oz9t/Uarxf27nQzCfY1Z80Etqxz
         MADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W457I2l5RFm8vi3OAKFMpeADxn0Oxv8muZtylILpgpc=;
        b=vZerxEdo4JXScJFJrHWBLGqDCInTZ34Ed7UI4am6Mhbbozgy+qOOlApamQQiJAssPl
         fD3IdISPfkI+luKSV31mHEznqw2xyGxM7NgJI03AM0kCDp8HrLEcTXOgcZLIGL3t/Lob
         7K/y1KvrexupS4k93gsV9Ssu4rKYkFfCpcxk8DcMucr+90UDDzztM432OkaJRNtdCkkt
         yPznATdp94SIaKtezvzmlZJepsu7685vpRiUYw0iHHV/bZIJjblOof8eqKP1bWiPS4ne
         sFlqlp31ahUhUm1sHWts+S8jTIC3W+NLt012a5C2YIx4PtqmsPjbhOy3ZrXUJdkfYGVY
         AT2w==
X-Gm-Message-State: AJIora/NPcyu08S1Z6hb61dZD1uIYSTLLmEa/OLbCShiC3cvu/Ft4B3C
        mRBwgOeHLABmWjE5h6+MHSUB7Hf8Sw06DQtAlQwIKK5WGtA=
X-Google-Smtp-Source: AGRyM1vN3xIaU3awlRQiIyYOfxsa1F7eiMWFr8WVZGtZLsEMmhVqIEcczJoZ9yLJ0+XcgISf8ZpDM/bRCw0PzwFgYLk=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr10265579ejh.497.1656019610745; Thu, 23
 Jun 2022 14:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com> <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 23:26:10 +0200
Message-ID: <CAHp75VfTqTfMsrdqyqRj61JAAJ4a_h3rrFriY2d+rrqpVviy=w@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned int
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 23, 2022 at 11:13 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Use 'unsigned int' for bitfields for consistency with most other
> kernel code.

...

There is no point to convert the fields you are about to remove.

So, either don't touch them or make this patch closer to the end of the series.


-- 
With Best Regards,
Andy Shevchenko
