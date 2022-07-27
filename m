Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0250F581CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 02:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiG0A07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 20:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG0A05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 20:26:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3368D3A4B4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:26:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h9so22210685wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Yw+cKl53wNMcfpI/MRnxnx1KIbCu6LC2VYr7vldE9s=;
        b=CVhRJgIAzdoOMqq25qQOjSnIvOpcLPVX/EzmFfAuCwGD+WxjLsVqIVbSivJUmCeg9K
         uDL5NHcMveoTbyzfKZiOpaVm3GHrYYVKta16Kq0iNbmbOyxHnHELviJrDmbiI0gA6E17
         4yA+JrC7NIaCDqbggmsf246K96Z+LCAZIYXOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Yw+cKl53wNMcfpI/MRnxnx1KIbCu6LC2VYr7vldE9s=;
        b=6oyfUBrbHazwqd5LZvSvdXyLZJJUY3lceE68G96MWr7RRNShDo9BWNihxZE0MJNVZz
         rDYV4MEw/7TmhQBArnQphga5Zr8B8z30BKii/A1m8hKv1U/oRe2bsdvQI1GHS2nkVDWG
         hvntO1CY3qDrkTDK/7qTppfp6SW21CCqmaty/sjB9DL54oHe9FSaQy7B1dpyoNZwtD4Z
         JMFwqkC1sIe7AFYPfP04KR0UyQ340/0h5GVfzQIQkFXtQ2tw4E4q48JGvbbMbwkR5blS
         Ab9EdmhDl/X6eOcOtAIIr4XZ0DcG++u7Dg9eGiy4P4wzLEXdn979cpahCiA+cl6WnRCt
         +H1A==
X-Gm-Message-State: AJIora/0KmomX2UDs3mcJtsm1nOq1GwheZM+ulTG6heC/YEx7VG+urSY
        /gNU1F/H0NwWvMkxvQeEZ3argO3AiXOC3B4VKCz5hg==
X-Google-Smtp-Source: AGRyM1v282cuWyMIrxlKYKG+Y2hspRzqXJoTLgdsCs6bWpGyhUZ69tYSLecLQbclcK88MzyVVu8yo+0M5DtJSCxKDsI=
X-Received: by 2002:adf:ee8f:0:b0:21e:529e:fa3b with SMTP id
 b15-20020adfee8f000000b0021e529efa3bmr11946186wro.207.1658881613377; Tue, 26
 Jul 2022 17:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220726235115.1184532-1-jrosenth@chromium.org>
In-Reply-To: <20220726235115.1184532-1-jrosenth@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 26 Jul 2022 17:26:41 -0700
Message-ID: <CAODwPW-9UPokepL_VVGuCLaWTDT7hmN9R9Z2yXABrP4g3_N4uQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: google: Implement vboot workbuf in sysfs
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

Sorry, this wasn't quite what I meant. I think we should definitely
not hardcode any details about the vboot data structure layout here.
It's already enough of a pain to keep crossystem in sync with
different data structure versions, we absolutely don't want to have to
keep updating that in the kernel as well.

I assume that the reason you went that route seems to have been mostly
that the lb_cbmem_ref coreboot table entry has no size field, so you
had to infer the size from within the data structure. Thankfully, we
don't need to use lb_cbmem_ref for this, that's somewhat of a legacy
entry type that we're trying to phase out where it's no longer needed
for backwards-compatibility anyway (and in fact I think we should be
okay to remove the vboot entry there nowadays). We also have
lb_cbmem_entry (see
https://review.coreboot.org/plugins/gitiles/coreboot/+/refs/heads/master/src/lib/imd_cbmem.c#222)
that exports info about every area in CBMEM, with address, size and
CBMEM ID. The vboot workbuffer is CBMEM ID 0x78007343.

I think we should just add a general driver for lb_cbmem_entry tags
here, that uses the "id" as (part of) the device name and contains
node to read/write the raw bytes of the buffer. Then crossystem can
easily find the right one for vboot, and the infrastructure may also
come in handy for other uses (or debugging) in the future.
