Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38D7526B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384101AbiEMUVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384091AbiEMUVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:21:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC33E6AA52
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:21:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso101636947b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rygsWmKSy8v7SEtOWG4PJRDSZuRNzXpM81fgoaPK2JM=;
        b=BnkYjLDAcO5Pqlbmze4sAm0WCYWmd+hL9sP7BPo4UgwEVwwWi3S3HI3bpjrHe5hP+f
         97DVPKUp3QauiCKBkgEC0NUV5wZRSwnne9lEk5/zIC760sa6HT9gLBFdJbzHE5FVKMxx
         TjgDtHWP55q5goQNKT7PgdHIYFvvBcVbHxMjntD/Mym/aRPKxUCx8PrlnhaAXVL4VNbP
         A20eYLQFBauNs7WnCZb1XO5Akwr0aYWSTEVvq6YzMJX5GS+fOKK6GI9hJyJy25vcZO/p
         xTAX5hYECYsGT5/ju+RN0dP/V7JnhvD/aWe0ghfNeeWu+CtU7U5O1MwMjy0M3RgVj9Z0
         uT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rygsWmKSy8v7SEtOWG4PJRDSZuRNzXpM81fgoaPK2JM=;
        b=Mj4bkEAVJGsPKutqdqS82a5Vtkk034P0xbg6XsFsUfUThzynxEf6x9CxW4sVqDsPM+
         UHiw8m9eRuHeCYrCZ12HHneLEaDFe/JhxyE3r9WKGCBGrJJkwREbuT20Rg9d+qmWAUPQ
         GegIqUhA44Gr1Yiab0e4iEGukn+3IZu3shZ4cZAg0xPF89u9kkB1X4PFy8VPwVQ767LR
         iZWF3WlWufdTUPhrEjuSR7gWyEJD1r9E1v+Yz7cg+FhpnaOuWHjQC8+vAhNYXksgBFs0
         ZWHfjdKbIB+G+MEocPCtLV0KTT8onPvdSE0olNVD6tOIU3cWBimS4t5IukD/JD0BIquS
         LC7Q==
X-Gm-Message-State: AOAM531rtpTzOxxa07pRLUe4Lg5gyCFgeTerUr+iV9IhSf0SOYnw1INp
        X7o1MAaBdh5u0jFHf3fWwnunEJvnGDsxi+T6zKWxjg==
X-Google-Smtp-Source: ABdhPJzl9Z5mG3VyfgLa795+ift0OsfF+5pqe2FKsOHgiI/5CJmP/gnDwwLCrySn55AqpNT4y0qQWjxPDFE89r73of0=
X-Received: by 2002:a0d:c4c2:0:b0:2f1:6c00:9eb4 with SMTP id
 g185-20020a0dc4c2000000b002f16c009eb4mr8133277ywd.448.1652473291809; Fri, 13
 May 2022 13:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652201921.git.william.gray@linaro.org>
In-Reply-To: <cover.1652201921.git.william.gray@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 22:21:20 +0200
Message-ID: <CACRpkdZjNt8fbAXF6_+RhDHGJKOmMBD9E7fVZPQFwCbNi918Qg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Utilize iomap interface for PC104 and friends
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, schnelle@linux.ibm.com,
        David.Laight@aculab.com, macro@orcam.me.uk,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 7:31 PM William Breathitt Gray
<william.gray@linaro.org> wrote:

> PC104 cards and similar devices do not need to access I/O ports directly
> via inb()/outb() and can instead use the more typical I/O memory
> ioread8()/iowrite8() accessor calls by first calling ioport_map(). This
> patchset converts the relevant PC104/ISA card drivers to do such. With
> these drivers now utilizing I/O memory accessor calls, work can be done
> to consolidate some similar devices (e.g. 104-idio-16, pci-idio-16,
> etc.) into a unified driver in a future patchset.
>
> This patchset spawned from a suggestion made in another thread titled
> "gpio: add HAS_IOPORT dependencies":
> https://lore.kernel.org/all/c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.aculab.com/

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
