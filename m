Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3575A89E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIAAjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIAAjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:39:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADFFFE819;
        Wed, 31 Aug 2022 17:39:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b16so12663693wru.7;
        Wed, 31 Aug 2022 17:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=CVfG3OZHSQeL/ZXooertYMXI000OU/UMRXwtJHlA8e8=;
        b=oZhKlUlP7bcmm1JTX638nCKlWyaX01Vhtppq9VGZfVhTV0BXY0vgLoYhgnLNptZ9bb
         RQPtHSN97ojezdYz3/TQa3uS53e0hBv1BaqEdE6DC6XuCIwez4oBg1d4tK8XVoiJT46f
         KIPP9XHq3zhWjMhHcbdUxwwdbDctIOCqnFEK3fpiJQAHTItlksUJZfwg08pL6ULDb2zF
         MdaJnOmuegcoOmCaWNgSah7HUSysZqawTd7ZK0l14EjZM/7HqB067ESK1wuM37ccC1V8
         oiQ0xa3wz9G4hR9I7gdTLyWPJdnrb4VMaiffmOWzN1aU65q2EOkDv1tLX3ZvB+VXpDCT
         lwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=CVfG3OZHSQeL/ZXooertYMXI000OU/UMRXwtJHlA8e8=;
        b=b+CypC85AolfHY7OIB0ljek68cCi6xkXro0T/Uti9THQhLq2kaCMnoXNPSSQbPEsSI
         UzXtvubmG/+tc0LPyEIbGo9EI5Dp8Ev6rHbCjhegC52N9RvljKYhpUheINIG36DneukI
         ql9lbiI84H9E3gv1NxpUTWTY7DG2p+xKb8uQHv2cz5VNkgV23FwRyMyBfpafx7XmMsUH
         ivswSM9LNFuePCDS39C1YLbvXSqLrEHVqfVIQBqjdNZye/zrbJGaZO4uQtJcjJMECmea
         /LyPaodVh7bbRZq4f12pqEN/F9ks5R5USWHbQsXTRqIOZGKuiylqQWi2d/OtRZG49k4R
         gakw==
X-Gm-Message-State: ACgBeo34NZPp50HXAajZqnmIosJGDPtE7TTwLKq7O6ywrgBoFKxLZnso
        NBNO+R1Ci/E/71q9C0adzzx5qeMNa6qXg1IQY8WJBwjP
X-Google-Smtp-Source: AA6agR6zpz1DhRQx7BF1x+tzBCkVPbBe8kZrT6e+1BYPVKk6LnNiqKwtUD2qV5mqxx4Y22230tIm/WdSBSnCIgGJ3YA=
X-Received: by 2002:adf:f647:0:b0:226:1c05:933a with SMTP id
 x7-20020adff647000000b002261c05933amr12540470wrp.121.1661992757012; Wed, 31
 Aug 2022 17:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
 <1660100142-32493-4-git-send-email-u0084500@gmail.com> <Yw/lC9rjnbFW3ORC@google.com>
In-Reply-To: <Yw/lC9rjnbFW3ORC@google.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 1 Sep 2022 08:39:05 +0800
Message-ID: <CADiBU38AuVW9yeFisKvK=_080tQzn-1PUxsDXH4p0QrA2AUSww@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] input: misc: rt5120: Add power key support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> =E6=96=BC 2022=E5=B9=B49=E6=9C=
=881=E6=97=A5 =E9=80=B1=E5=9B=9B =E6=B8=85=E6=99=A86:47=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi ChiYuan,
>
> On Wed, Aug 10, 2022 at 10:55:42AM +0800, cy_huang wrote:
> > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > +MODULE_DESCRIPTION("Richtek RT5120 power key driver");
> > +MODULE_LICENSE("GPL v2");
>
> I changed this to be simply "GPL" (per checkpatch.pl, see commit
> 'bf7fbeeae6db module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
> bogosity' for details) + did a couple of minor edits, and applied, thank
> you.
>
Ok, got it.
Old "GPL" text as GPL v2 or "later", and  the "later" keyword is the proble=
m.
This patch is to fix it.

How about the SPDX license string? The same definition?

> --
> Dmitry
