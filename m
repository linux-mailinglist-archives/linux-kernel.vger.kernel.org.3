Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5EC4D91D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbiCOA6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiCOA6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:58:40 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12032899A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:57:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e186so34274939ybc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URKjjowY0h/0Z8zQ1fAqigHaBDlWDlO+XfCZxksc+d4=;
        b=RICGTgRYNylyisjerEuIWzJ8fZdKLcskLqhxucD/uGx3zgwwzUK+U00nyTB8KwDYpb
         yuBtphxFdvM5/Jwd4YaSzSrW7tdFzaMhHvbGc4LbaFJvudS89VA+B9A65kb0PYPlgkdC
         RWgfuEvV+dqfb4Jh/EmnSfmm4umVdB1tvi0FyP0hF8a99YqZGHtO2XJKpOVvZF18Xz1u
         y+AHhFWztDgC6Gc2ioucRkoDth3cdTPIlK4AYeCqUudeIq/UpO0eD/WV4m1swNO2aRrM
         jTdF6rZIrWK30Yl4v/e0OXHqa7ym1DBc6D+T+Pt4XyOt9aOQuG+Q0tdQleZBY4EF2qGa
         Hhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URKjjowY0h/0Z8zQ1fAqigHaBDlWDlO+XfCZxksc+d4=;
        b=6sd1l1UPbVdjA+9cfeqJ04ZL55UQxv4giSMQJbOVgZY5K2ZNun1gzdufnkNXsSgAzD
         K5xIMv7O6DPVVWcrD8TzNLhyIrACIsIJMvGOVfoeNVTKAnVooUzmhzqr7TTNt/FyAYM4
         4rXX6ukjrOng8YViOcrx8K95bFTE+JErJR3ME5XSQtiV7oImiaF/e81CfF6xOPOj9d9H
         iGcCzorrrGRAsTTLRNMx8C/w6D/T2QDex72o5ugA6fetWPjxBYbQvweHYm+dbtQgphPe
         cQbiAeg84fBqBaICntEIsVxbVYk7mMjD0qXiDx2XROoq5/xGKR4cwKZYHRjDv1eePqBE
         uOaA==
X-Gm-Message-State: AOAM533PhJunsAko96gW24W82l1vzLtMo5XuNgdW7E/OwrjOhgVlEh6k
        Pa2MEqKK2kH5hth164ieK5XNQk5gbGb37ddvhCqXsY5kZm8=
X-Google-Smtp-Source: ABdhPJzzoq1w5Z5Ax8LKyjNFwGBQHKqhXx+iO7JkJYga4JSoMD2kRDmPq24+htGemMNNEVXVseUw9tVaZmXH6imEkKM=
X-Received: by 2002:a05:6902:203:b0:628:7b6f:2845 with SMTP id
 j3-20020a056902020300b006287b6f2845mr21211853ybs.533.1647305847868; Mon, 14
 Mar 2022 17:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220226204507.2511633-1-michael@walle.cc>
In-Reply-To: <20220226204507.2511633-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:57:16 +0100
Message-ID: <CACRpkdaDxYntOxnJiX-fwUU8UPFu7SFR_5UnoUPzhWG-xtJphQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pinctrl: microchip-sgpio: locking and synchronous output
To:     Michael Walle <michael@walle.cc>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Foster <colin.foster@in-advantage.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 9:45 PM Michael Walle <michael@walle.cc> wrote:

> There are boards which use the output of the SGPIO to drive I2C muxers.
> SGPIO right now is broken in a way that when the software sets this bit
> there is a rather large delay until that value ends up on the hardware
> pin.
>
> While digging into this, I've noticed that there is no locking at all
> in this driver. Add locking for all RWM accesses.
>
> Please note, that parts of the modification of the first patch are
> removed again in a later patch. This is because the first patch is
> intended to be backported to the stable trees.
>
> This was also just tested on a LAN9668 SoC. If you have additional
> hardware, please test.

Nobody is protesting for three weeks or so, I just applied the patches
for v5.18.

If there are problems we can fix them in the v5.18-rc:s

Yours,
Linus Walleij
