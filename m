Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6BA5B175F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiIHIm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIHImx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:42:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED5112B02
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:42:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r18so9154170eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=mHQSSgNhDkCOub491AbEBE7T5spa2DJLZtfO6t6+O/A=;
        b=yqn6NPkic3xE35zdfAsS1MeaHM57cjrz+j7qNGgMi12rgcIQS7rcb/cF4kPuIdq5sU
         6S7Eh8WhmM3y0PR7hSOfvIyXqGG2QvJvDiwYdEi+ige8inRADkf2BwQp3wjiS06G0gZk
         pDE5To0lxIzYA8cLvVkLa+8UFgE1g/C9AUd7Zezx2tU/oz4PA/TSM3zxyreZgdKk383D
         nVv8rtfczJ4dVNQkG2go9nwd8F8GIAnyp2KYh4LE2Q/hUP63otPGmNrusiFIJ9ucbCNL
         jhB/uKWSzb6Bd7oV8TMwwQSTy6iT30dvhDHXtf9AZEclAEMxUJ6SYZYjxbA3GDiJbEyB
         cLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mHQSSgNhDkCOub491AbEBE7T5spa2DJLZtfO6t6+O/A=;
        b=jhBIUnTm9zb6ZHCV/yZPrnq0ohAmdDNMb6BzRUir7F21DkA9ZH9XuN8c18/+P3qJiC
         dIIx2YukV6MNejD8dLXUnpBkQi/PkCcHlrvLiFf9iAJ2nX76oPpUr8rIMvlQbjP/PTxG
         bneuR+w8krx2mkQJ8OpN5WXB8xleFyDF+WOPFmUimk4m5OtRZeffiavagY6+dveLpN40
         CPHva7lHj54Mi36ys9UqTlAWqvYE6jIgqygGg+4EZwGXKgfdBUCvwKPYOLbPzb6c6sU2
         JzkCwtKAF33hSYjqgczTWT2LhksOau+KSTFHCYHNMXSYsc/5BhT2NO3qc+5YNGANycHN
         MnqA==
X-Gm-Message-State: ACgBeo0n6Fkb5zPDrUj7hrUfocuu28P/mZYHNixtapJ94IrMAxwldRhx
        XxKDsrrljtl0zJKwoHWIMfiFEq+q37uFDkVX9eyUbQ==
X-Google-Smtp-Source: AA6agR6+9iRUrEemUzwPpukwFryEqyHQQbUVBor9maor4rQNOJdvVLTNYDLuIH9ifvicN//eR+7p98ksvS2lWYSUNK0=
X-Received: by 2002:a17:907:1690:b0:770:80d4:ec4c with SMTP id
 hc16-20020a170907169000b0077080d4ec4cmr4651626ejc.690.1662626571261; Thu, 08
 Sep 2022 01:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com> <20220906211628.6u4hbpn4shjcvqel@pali>
In-Reply-To: <20220906211628.6u4hbpn4shjcvqel@pali>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:42:39 +0200
Message-ID: <CACRpkdbG6gzYjkgW=3w33Mvmc3gdS6Wz-9t71JQti-AJ5aZRFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 11:16 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Tuesday 06 September 2022 13:43:01 Dmitry Torokhov wrote:

> > This patch switches the driver away from legacy gpio/of_gpio API to
> > gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> > make private to gpiolib.
>
> There are many pending pci-mvebu.c patches waiting for review and merge,
> so I would suggest to wait until all other mvebu patches are processed
> and then process this one... longer waiting period :-(

What about the MVEBU maintainers create a git branch and pile up
all patches and send a pull request to Bjorn then?
This usually works.

Yours,
Linus Walleij
