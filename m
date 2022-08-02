Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D91587E73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiHBO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiHBOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:55:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D221CB16
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:55:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r4so10235270edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+wxkILs1XPjXI14YovBxlfOcpoRiTNhnTeuF0IZkMKQ=;
        b=GtcOwKkqWEMy+ACwmz0p7Mm7g2mk+CWyAjSo+9SGKo3Yf+TBbl1rlnpLK60YAqNwTf
         PWs+fDCTRe2oTDrl+hvysgUGQ5sdhNa5oJvq77kGdt3CdWYnt2lWHKUE/AWx6bCrNLij
         /a/w9ubEGuvfYobxZSgR2ErPpwXQ8csZ/anXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+wxkILs1XPjXI14YovBxlfOcpoRiTNhnTeuF0IZkMKQ=;
        b=apGveHWhhfFbjLiwDgtsR6mrbFhsE15iu7wp12f5I+beb5GduUjkB96Pn1XoF/KTgB
         906LsNvlGC3MAmruxMzU+tUtcgczyM3vu/KvyQgKqkC0mdK52dr2DEThWkR0rzPAWW0Q
         duRCqYzwvdqyB9KN68NivwCSKm914bSA42NDNP98zgVIRhFIXtDCSPOHAAElYAJfsN61
         0jE+OkolpIr/ErLkbxGXIUBSOSLSPTzHAbaACPaOXDeWSQQ5ah9NDa4d3mR8i/6ahAHD
         WnJj7bCviM0DPQvDiu3/iCNErA/B4ehJgAt5CJyKzLkDzkSeN1u1kukFW9Mlx7Q7dBI7
         mCcA==
X-Gm-Message-State: AJIora+FsTfOIdNdCnhTxrfjipXg4lkLTjhXAvQ0GWy9luCBZk8go/+5
        m+J4sCGASXDGOldWRlR8tAzLYn5eM0APly5X
X-Google-Smtp-Source: AGRyM1vlX9YM7EMudVZAhM2Q2jJpm5mfq6EZm1Odz3ulmXZBg4JZo+U2oVQGZGTaQQNzyFktMc9REw==
X-Received: by 2002:a05:6402:40d5:b0:43b:eaa7:f195 with SMTP id z21-20020a05640240d500b0043beaa7f195mr20783774edb.405.1659452156072;
        Tue, 02 Aug 2022 07:55:56 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id f4-20020a056402328400b0043d18a875d1sm7131557eda.79.2022.08.02.07.55.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 07:55:55 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id q30so13803513wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 07:55:55 -0700 (PDT)
X-Received: by 2002:a5d:59a4:0:b0:21e:8704:ea35 with SMTP id
 p4-20020a5d59a4000000b0021e8704ea35mr12648547wrr.442.1659452154701; Tue, 02
 Aug 2022 07:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220729102205.GA24050@willie-the-truck> <CAHk-=wj=CQsmGPzDUZjey3DoMFsiCqn-O6kmCv6ZCW0AoO=kOg@mail.gmail.com>
 <20220802090000.GD26962@willie-the-truck>
In-Reply-To: <20220802090000.GD26962@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 07:55:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcDUd-vGTTBN8UQJN7OyiDWvJy6udg3O0BFodkut1EkQ@mail.gmail.com>
Message-ID: <CAHk-=wgcDUd-vGTTBN8UQJN7OyiDWvJy6udg3O0BFodkut1EkQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 5.20
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 2:00 AM Will Deacon <will@kernel.org> wrote:
>
> Seriously though, if you could share any details about exactly how you're
> running this (e.g. in a VM or native, .config, any extra patches on top)
> then we could probably mimic it in CI to avoid any last minute surprises
> with the pull requests.

So my setup is basically an 2022 M2 Apple Macbook Air, with a Fedora
spin of Asahi.

I run it natively, but because not all of the Asahi kernel patches are
in, currently I end up with two trees (exactly like my main desktop,
actually): one that is my plain kernel that I run allmodconfig builds
on, and a separate tree for "local boot testing".

That "local boot testing" tree is basically the same tree except I
merge in the Asahi kernel to get the drivers (that aren't upstream yet
(it's 150+ patches for iommu, HID, GPIO, wireless, power, and dts
files).

The asahi side doesn't contain any actual architecture changes
(outside of the dts files).

             Linus
