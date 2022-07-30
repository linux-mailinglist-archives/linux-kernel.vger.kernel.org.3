Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE04585783
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 02:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiG3AIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 20:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3AI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 20:08:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C262DD2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 17:08:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a11so3236806wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 17:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2WINx4ONMT5wiFIiO5PeVQw7Ko03HZeFZ82O/EDiScs=;
        b=BW39Q9qQf63iIQFrTh2NUvyKcMNfCnGUnQFIgjWhYk5EJHg+NUjqKOB8LgO+tlETJ5
         R+vOlfh9l86S7r/0lBlUtuKeGSfgVmSxaFjy4UnjXfVKU/9xMbdMW64O5HNuCpVMLd42
         JTIieYzYCwqAIMG4rvA0hOGd5shT97S7imZ/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2WINx4ONMT5wiFIiO5PeVQw7Ko03HZeFZ82O/EDiScs=;
        b=iO2J3MrXP9y/OIynwewL3TOBb/jC//SHDp8VRuT+Fb3Pi+FH851gLqx1ttyw6oJdVk
         lRXaOVYrn/GVArspiE87LvIa9VEOh08jL0OQl4inZGh8OFbdfTV977/OOeFx2ZAWvdGv
         qjj/kmLXoEgc1te25qNH+/jsYVVcw4CAjDjX15NiaYHnVCZMvBTSnzO51LK8w/FRQAji
         s4C3dH961mqRCXdGoMS29imYU6dIQpBxIGm2tSSLet6aXv6Ku1MM+5/YO7FZsY1/Je7C
         cW611OoxVmUm/TujhlRs5t5P4TCLrTFOYWgzcUDl/67PZdOLiHW/llbGh8Oja6BGo8VT
         9RIw==
X-Gm-Message-State: AJIora/s1/MbxezYmdVUdxm1KHelOQ+MTUuCteFPOcVxYWN4JaBUVkrz
        lvA9hBfMsM9Y6gSIPjc+A34SY9s1utuPrn+lo8Zw2g==
X-Google-Smtp-Source: AGRyM1uVgzbeHPCN35MD8rG8omEj8mDY5Xip3bGarjKIXUhS3qzBQANpuYHcjwieh7sLbbUVoA0Qmu8P8cQmxKhtBXU=
X-Received: by 2002:a1c:7c07:0:b0:3a2:fef0:f999 with SMTP id
 x7-20020a1c7c07000000b003a2fef0f999mr4297951wmc.62.1659139705723; Fri, 29 Jul
 2022 17:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <YuGTL79tPPoalk/j@chromium.org> <20220729193107.2466530-1-jrosenth@chromium.org>
In-Reply-To: <20220729193107.2466530-1-jrosenth@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 29 Jul 2022 17:08:14 -0700
Message-ID: <CAODwPW-JzXXsEANaS+6n695YqriAQ0j0LXm31R2u1OP3MhX9Uw@mail.gmail.com>
Subject: Re: [PATCH v3] firmware: google: Implement cbmem in sysfs driver
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I think this looks great in general!

> + * Copyright 2022 Google Inc.

LLC

> +/*
> + * This list should be kept in sync with
> + * src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h from coreboot.
> + */
> +static const struct {
> +       const char *alias;
> +       u32 id;
> +} cbmem_aliases[] = {
> +       { "acpi", 0x41435049 },
> +       { "acpi-bert", 0x42455254 },
> +       { "acpi-cnvs", 0x434e5653 },

I don't think we really want to keep this in the kernel? New entries
get added here all the time, I think it would really be way more
effort than benefit to keep this in sync. It also doesn't really mesh
with the idea that this is a thin interface in the kernel that doesn't
do any heavyweight interpretation. I'd say keep out the alias stuff
and just have the numeric nodes only.

> +static ssize_t cbmem_entry_mem_write(struct file *filp, struct kobject *kobp,
> +                                    struct bin_attribute *bin_attr, char *buf,
> +                                    loff_t pos, size_t count)
> +{
> +       struct cbmem_entry *entry = bin_attr->private;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;

Not sure what the current standard kernel policy on these things is,
but we already have file permission bits to control this so generally
I'd leave it at that and let userspace decide how to manage access.
(Forcing everything that could possibly be security-sensitive to be
"root only" just means more things are forced to run as root, which is
also not a good thing.)

> +static int cbmem_entry_setup(struct cbmem_entry *entry)
> +{
> +       int ret;
> +
> +       entry->mem_file_buf = memremap(entry->dev->cbmem_entry.address,
> +                                      entry->dev->cbmem_entry.entry_size,
> +                                      MEMREMAP_WB);
> +       if (!entry->mem_file_buf)
> +               return -ENOMEM;

Can this use devm_memremap() for automatic cleanup?

> +MODULE_AUTHOR("Google, Inc.");

LLC
