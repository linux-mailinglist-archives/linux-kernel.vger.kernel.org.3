Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6082F58AEA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiHERIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiHERIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:08:20 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60D3CBCB;
        Fri,  5 Aug 2022 10:08:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 123so4710825ybv.7;
        Fri, 05 Aug 2022 10:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0hkyQR/P6tkKTyA1L+y5V9deL6+UATBvdrUuSMJew0U=;
        b=8JRd/lkrCOu3hRP4RzSuDivhE38TXq185YM6hGTGEdAKl/EzM1vrCb0rUtti+0L6KG
         EUdRvmbb0t51trSqer8aqEaM+Gx2E5PWrkZqBMHBlVKDiCRMuWtfhkPjj/seHExoWSu8
         AhU+413wp9Zz7Y8B1yDNMib3bzx86VwuG5wrMMHgQO0FNSxBWW5gd8HU10jkbL9RPyuM
         Ql5VBJf6cLwHWldt4TtSpjDeQIgZg4ejQMZHF+3feCSxm26M6CXkXofnEoIdTFHQAocc
         fzLOZBDcE9D3f2atpARxEB4mNizgIXJFV8J1xysEKMZYdvMeV+h/ir2kbIJNZiDCjXG1
         mFaQ==
X-Gm-Message-State: ACgBeo3wjCMHFPGtfVUZysC7Ls8/OP+oHi22gkazZZpattgWWG4V+2Nj
        Fh/IbF3bqSFPCDaIn2cq8FRfI62YW8f+B9kBfOg=
X-Google-Smtp-Source: AA6agR7OOxmn5DzC9Hls1wBqCFIQ7cNtxZK7yQCmGxofvLM47vaHV4/Ss8lGiWgJeQvJdrIwF2wvCj/qmkxWbgdEgQQ=
X-Received: by 2002:a5b:40a:0:b0:677:a43b:dcd3 with SMTP id
 m10-20020a5b040a000000b00677a43bdcd3mr5716170ybp.622.1659719296723; Fri, 05
 Aug 2022 10:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <12042830.O9o76ZdvQC@kreacher> <1c7fa65d-47ab-b064-9087-648bcfbf4ab5@amd.com>
In-Reply-To: <1c7fa65d-47ab-b064-9087-648bcfbf4ab5@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Aug 2022 19:08:05 +0200
Message-ID: <CAJZ5v0ie7B=GvhbfBsi7Zxu+=YzYKUqvUNs6dNZQfT3CRm=KPg@mail.gmail.com>
Subject: Re: [PATCH] i2c: ACPI: Do not check ACPI_FADT_LOW_POWER_S0
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 6:59 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 8/5/2022 11:51, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> > use low-power S0 idle on the given platform than S3 (provided that
> > the latter is supported) and it doesn't preclude using either of
> > them (which of them will be used depends on the choices made by user
> > space).
> >
> > Because of that, ACPI_FADT_LOW_POWER_S0 is generally not sufficient
> > for making decisions in device drivers and so i2c_hid_acpi_probe()
> > should not use it.
> >
> > Moreover, Linux always supports suspend-to-idle, so if a given
> > device can wake up the system from suspend-to-idle, then it can be
> > marked as wakeup capable unconditionally, so make that happen in
> > i2c_hid_acpi_probe().
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> +Raul
> +Hans
> +KH
>
> Raul had a patch that was actually going to just tear out this code
> entirely:
> https://lkml.kernel.org/lkml/20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid/
>
> As part of that patch series discussion another suggestion had
> transpired
> (https://patchwork.kernel.org/project/linux-input/patch/20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid/#24681016):
>
> ```
> if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
>             !adev->flags.power_manageable) {
>                  device_set_wakeup_capable(dev, true);
>                  device_set_wakeup_enable(dev, false);
>          }
> ```
>
> If this is being changed, maybe consider that suggestion to
> check `adev->flags.power_manageable`.

Fair enough, I'll send a v2 with this check added.
