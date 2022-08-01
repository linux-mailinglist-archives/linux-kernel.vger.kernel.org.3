Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9F58682B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiHALeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHALeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:34:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77630F4E;
        Mon,  1 Aug 2022 04:34:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sz17so19760617ejc.9;
        Mon, 01 Aug 2022 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0nrlg1hueJXUxVV+lqZApf1awzm2sOxgKLEM6ZoqXq0=;
        b=k0FM184C+weVBG0o7xTXc42UTJo44dONfU2J8NdsEQVZD3XPlIj3p7ByWt6tf9n64L
         F5sHU5tfzMY35XKY/moKpYKVxUOWc2a8T5Wpt6/9c68I2MZfjWgSXTORg2QzJ0bZulp4
         Edm/UZyrCcEHTEL26f4R5PtPQcWuss6NVKFRP/w518+7sqvQE7ukQTJrB7Fr/ARJMBK2
         8fRTIuh2GiCXZAkNgednWq59DwquG0MVtHK85mhrU+tZUTZg1Nne7d7BzrVnJTp1ejzh
         I3Edy8pAIHAB93hisd+Q5ua9UCGshGBOatHDIDbKNdANvHvH8h+Sn3mly8iy/XZ5dq5a
         Yazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0nrlg1hueJXUxVV+lqZApf1awzm2sOxgKLEM6ZoqXq0=;
        b=ValnY48cJvVj8q0kQELUZ2HoU/o1eGNjBMV7yTT1yTNM5YYNKh/Nat201hBynhIcrz
         YXgFO+zw1DZ4BJS7kDPPZ7DfWZVqdRxklKZn5r11oygU70Sslvglxq58fNtuf/L/c1ev
         yipZgVc6itlIGbT+/SOJXHhUMM2oo4/vjg92fjkZjRbxw45gwSoiji9JFimd8qM3+KFX
         oG+BW9ivSgRyM/Ok8/ibJGNXwFUxc3S1Exb17JEVSk96CaZq0c53+hnhA5ikLulUsVc4
         gRwAaq0IYr/3gTYoGA/Xx68TVxvh/qXz1ooEdMCWS3wJlx5fot59U8yt86zYWbtMrNkp
         GFcQ==
X-Gm-Message-State: AJIora+vGaxOCi32tl88ZR11BFqfNZMYKUSZsfzvArfWQjkhybox+vjR
        A/2Vola5sRsM5sQwZ1I2URix9Ot2+H81HaiFYzMV0f6OZIY=
X-Google-Smtp-Source: AGRyM1tr+APqQ02vqalZVF3lyVSzQ8hsaqeXlfegTbvkYEciJO5YSt6hbva9Rqbdj9JYC2N/iOW8xngkwbLJbTjskj8=
X-Received: by 2002:a17:907:6e02:b0:72b:9f16:1bc5 with SMTP id
 sd2-20020a1709076e0200b0072b9f161bc5mr12684280ejc.676.1659353655417; Mon, 01
 Aug 2022 04:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220801113018.9882-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220801113018.9882-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 13:33:38 +0200
Message-ID: <CAHp75VeYQy0oZLU6FiSdw3AKzuKnAP=-hE1=tr6VQiDjq=J7iw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] platform/x86: pmc_atom: Fix SLP_TYPx bitfield mask
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 1:30 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Intel hardware the SLP_TYPx bitfield occupies bits 10-12 as per ACPI
> specification (see Table 4.13 "PM1 Control Registers Fixed Hardware
> Feature Control Bits" for the details).
>
> Fix the mask and other related definitions accordingly.

Please, discard this series, it has compilation issues.

-- 
With Best Regards,
Andy Shevchenko
