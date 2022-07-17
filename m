Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BF5773E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiGQDsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiGQDsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:48:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD117E36;
        Sat, 16 Jul 2022 20:48:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f65so7801046pgc.12;
        Sat, 16 Jul 2022 20:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Z0QE6TqiTLpNVLq0d6Tn+LJm8jdHQlIKPBhpl1b1IvI=;
        b=Hm/XZDORe8w/23YWh1ILjh5kveofdNCqQ0V7yu07TXBiadO710B4sQcFi584OFzxTg
         MbAbTUZxhED4dxph0IUuYzrgaFeGgk+qs59KYL9dU6a4gT/Amg2JYMnVB+1qPNu3XDlL
         R1CV6eXisR3zOqmF9wvS27nea+FsemZ6R9CtRQEC1ZE1UZ5Oq9V1E8Rb387rHvGuzrRw
         9f/WdSbAJJzOIdI8t7bcdfwGoHSSV3KG0XUyDKKLroc6HTzX7n2UnG5JsSj8jenqMBhN
         jVjVpUyZ5psvEY4DhPxJ1H2wqVxDINPWNUkibUyXCa1/AgSOx41fMuH/SKmrwwavgqDu
         u9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Z0QE6TqiTLpNVLq0d6Tn+LJm8jdHQlIKPBhpl1b1IvI=;
        b=Do6klEJY8Ym8UPzVOxIkeHwhZR0UPMHnd0U5x/qPesYSA+1tJv1b0fOtOOZsMNZPLK
         V8qK28PhocpJrTov6/SU0+KO1CCjHc5trVEN29Gp6yoFpXneUN4dbCxUT9LlhpafS8CT
         tamKSjJea1m4Jmx1nmmpdKiimBvQakLa37qbRgpIjEc5fyOsJZ3YCmKbci8JYHhRIgng
         gaUA6JIB9Ie7BaOuNNREKZT1OnAAsGI78kAxGFb0ZBE7T69Ltrid0jgQ/7de6j6m8cgC
         iIfemrQOfH3zHBdAJsPVlXCDAUEb9J6NUptWL+T/IVueamDrobdwVF1DLGAL9HukeP7u
         sIag==
X-Gm-Message-State: AJIora8gg7Mz9BKyfsU/Gp66UwLgXvCkpGlNZVROAznJxhNb0BxXNv/6
        p56chyrY2biOonVeAm5qaypK8H0Ed73bPtmwFQ==
X-Google-Smtp-Source: AGRyM1ts9KqXoDY4UHuc4G3SVfNilEGzmKzpCb1uTJFtaEWLMKAvCulqjjlSB/KMEm3RW8jR0HClTPzAZCj2jB06jKU=
X-Received: by 2002:a05:6a02:113:b0:412:a7c0:da8e with SMTP id
 bg19-20020a056a02011300b00412a7c0da8emr19808019pgb.113.1658029687199; Sat, 16
 Jul 2022 20:48:07 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sun, 17 Jul 2022 11:47:56 +0800
Message-ID: <CAMhUBjn=k-4DV0-u_30_rNQc9n__ZkwVFaLwfP1CP-uk1LjMpg@mail.gmail.com>
Subject: [BUG] most: usb: Found a bug at the probe time
To:     sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a bug in the most usb driver.

When the driver fails at

    mdev->conf = kcalloc(num_endpoints, sizeof(*mdev->conf), GFP_KERNEL);

I got the following warning message:


[   15.406256] kobject: '(null)' (ffff8881068f8000): is not
initialized, yet kobject_put() is being called.
[   15.406986] WARNING: CPU: 3 PID: 396 at lib/kobject.c:720
kobject_put+0x6e/0x1c0
[   15.410120] RIP: 0010:kobject_put+0x6e/0x1c0
[   15.410470] Code: 01 75 29 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08
4c 89 ff e8 14 2e 73 ff 49 8b 37 48 c7 c7 c0 fc de 85 4c 89 fa e8 e2
61 21 ff <0f> 0b 49 8d 5f 38 48 89 df be 04 00 00 00 e8 df 2e 73 ff b8
ff ff
[   15.416529] Call Trace:
[   15.416896]  hdm_probe+0xf3d/0x1090 [most_usb]

Since I'm not familiar with the driver, I ask for your help to solve
the warning.

regards,

Zheyu Ma
