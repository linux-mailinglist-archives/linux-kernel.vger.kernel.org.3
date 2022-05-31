Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDB539871
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347892AbiEaVKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbiEaVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:10:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A99CF7C;
        Tue, 31 May 2022 14:10:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v15so13926214pgk.11;
        Tue, 31 May 2022 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dnk2AtX+fZ2ctPjFQBljU3ZU+UG3REYKSVdEhuHNNPY=;
        b=KoUu302b5j+3qOJqXYF7I535JkHpHPO+UslnzxBtqcOuS4HB4dYoqU2fEx/QCvpXA6
         Q7Iy0/OCX7DbOsS5xu/UnXk4R1veNyR4PLISVtMTtNtfrJz3kRYB/2rPdKAq61B72Z7h
         VJzORAipjEwPFaZshqjg5KSiErvoMSTpdILh+vf7mH3DLaYu/3aetK5XPxL7AxllBe+y
         3rYZGyuWrtTROQiUq3HImp4W1GvXQwa5O36I6mykh9dWrB7gkOAYIjBS8s4L/Y1oplL5
         NYxv7trGlCtr2TpmoqECjqk+FkfL/F9u0YCJfNsTOvSBy1D/24dzyElQPF67+JsPQ6q/
         U4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dnk2AtX+fZ2ctPjFQBljU3ZU+UG3REYKSVdEhuHNNPY=;
        b=HFbFmt9YwB2h6F6kKR+zqsVu5dp/vfXiD35GPdnJn5tVenzOba3doH+c0fFa3wb3id
         Ni/tyxiiwQpdpwSuSUoO+l9+LSuSkcVxREMpYe3b5DVwe4NJ0FiAXuVZZxC0m53i0mB3
         09D1nnkKJyNrYcEKShEPLPiOpnW4kgM7puhKfmjKIiZnIADGFV8rau1eUEMzSTmdejr0
         Hv2EtcG34iivC7bigM9qR3VZoy1mvS30+eHy6lH57Ut+BNiC0l9mm6AZGFCHm0OKzBin
         9moEzYkMRSpVsv/j/+3I1qOaASntP6bVGGkkbU+h5WaACn5luHNw0bEXumLaIu9Ggr41
         VDYg==
X-Gm-Message-State: AOAM5330tnd+8IDR4fC3kNFHQZN2noiJ0Z8+JcBh0kFFlEfSi3ERJK80
        1fyFJw8bpTbSLI40Av+Dg/4=
X-Google-Smtp-Source: ABdhPJwS7vs0ve8LtYT/JWiBRN9GiDwA2oAv9Vws6sqEdnxh/l31gkHY97QkL0Rg/H4dA6x1t7XTrg==
X-Received: by 2002:a65:4304:0:b0:3fb:9303:de99 with SMTP id j4-20020a654304000000b003fb9303de99mr22183202pgq.429.1654031445527;
        Tue, 31 May 2022 14:10:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3b8f:bcac:41a7:7a32])
        by smtp.gmail.com with ESMTPSA id l71-20020a63884a000000b003fc704c250dsm1548784pgd.94.2022.05.31.14.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 14:10:44 -0700 (PDT)
Date:   Tue, 31 May 2022 14:10:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Mirabile <cmirabil@redhat.com>,
        Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>, linux-input@vger.kernel.org
Subject: Re: [PATCH -next] Input: joystick: Raspberry Pi Sense HAT depends on
 HAS_IOMEM
Message-ID: <YpaEUZYtlVf2aCuA@google.com>
References: <20220531022942.16340-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531022942.16340-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 07:29:42PM -0700, Randy Dunlap wrote:
> Since JOYSTICK_SENSEHAT selects MFD_SIMPLE_MFD_I2C and the latter
> depends on HAS_IOMEM, and since 'select' does not follow any
> dependency chains, JOYSTICK_SENSEHAT should also depend on HAS_IOMEM
> to prevent a kconfig warning and a build error:
> 
> WARNING: unmet direct dependencies detected for MFD_SIMPLE_MFD_I2C
>   Depends on [n]: HAS_IOMEM [=n] && I2C [=y]
>   Selected by [y]:
>   - JOYSTICK_SENSEHAT [=y] && INPUT_JOYSTICK [=y] && INPUT [=y] && I2C [=y]
> 
> s390-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
> simple-mfd-i2c.c:(.text+0xc8): undefined reference to `devm_mfd_add_devices'
> 
> Fixes: 41657514c796 ("Input: add Raspberry Pi Sense HAT joystick driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Charles Mirabile <cmirabil@redhat.com>
> Cc: Daniel Bauman <dbauman@redhat.com>
> Cc: Mwesigwa Guma <mguma@redhat.com>
> Cc: Joel Savitz <jsavitz@redhat.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org

Applied, thank you.

-- 
Dmitry
