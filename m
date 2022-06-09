Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D075451AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiFIQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbiFIQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:13:24 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8031C176;
        Thu,  9 Jun 2022 09:13:23 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3137c877092so46231057b3.13;
        Thu, 09 Jun 2022 09:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkr4kpyjyxhytcYi9ZJbG4/P8VjvDKac01TatzKEEwk=;
        b=fNcsYxJ5RMwSY2iZ85Jjh3W66a/UG7RxnFNSrEh8iYPubAh7ZanqPc/HZbTdbkaoq4
         1rLSAxKDDUN52h9eECVIPDXumZkeEkmS4P+NadwKVi1adadxkRL9UxpXAZtGLtpCi8aa
         XIG5dAq/MmZAj1cqPHPnWDUWHf7+LRaMXVs8uhtfFRS3BNwegrRHse6FRTzj6h6IMwke
         1XI4mfQKzHzg9WQzSrUmWMA/jIqjc6APzSLY39QsApNXmhPTvjo7hCd8gXAjVUh81MoN
         4HK+GIR7UpVElHOTGBvI61VduB8i+xrM8N26PcUu9M850LbfqNLgsFCdCJhrl6l/mBgr
         H0uw==
X-Gm-Message-State: AOAM531+JiPx3rSwjMIXIzXflmwGGJ04dJkdsBi9pVer1AQ9fUaW5Yyf
        4pT7H5vigUpMGSOoCTbMgKqBgljRjihraqIujlw=
X-Google-Smtp-Source: ABdhPJwSGkzpfsEK18MU6vMMd4SUuG5LxBOhyOXdJeWtJgk0AEJ/f4LOGlEeVAomvMsvJWoPBt+27hqVj1/fRtw+MGY=
X-Received: by 2002:a0d:c442:0:b0:2fe:beab:1fef with SMTP id
 g63-20020a0dc442000000b002febeab1fefmr44227485ywd.196.1654791202217; Thu, 09
 Jun 2022 09:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <5296779.Sb9uPGUboI@kreacher> <63d7f3ed-b5a9-c869-5d25-a33a1d4e63c8@linux.intel.com>
In-Reply-To: <63d7f3ed-b5a9-c869-5d25-a33a1d4e63c8@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 18:13:11 +0200
Message-ID: <CAJZ5v0i7xtjrEOXgKiWP5St8OZoiZ4qq+gL62BFrmv-qpeaG_w@mail.gmail.com>
Subject: Re: [PATCH v1 14/16] soundwire: Use acpi_dev_for_each_child()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Linux PM <linux-pm@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Thu, Jun 9, 2022 at 5:23 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> Thanks Rafael. This looks mostly good but I have a doubt on the error
> handling, see below.
>
> > +static int sdw_acpi_check_duplicate(struct acpi_device *adev, void *data)
> > +{
> > +     struct sdw_acpi_child_walk_data *cwd = data;
> > +     struct sdw_bus *bus = cwd->bus;
> > +     struct sdw_slave_id id;
> > +
> > +     if (adev == cwd->adev)
> > +             return 0;
> > +
> > +     if (!find_slave(bus, adev, &id))
> > +             return 0;
> > +
> > +     if (cwd->id.sdw_version != id.sdw_version || cwd->id.mfg_id != id.mfg_id ||
> > +         cwd->id.part_id != id.part_id || cwd->id.class_id != id.class_id)
> > +             return 0;
> > +
> > +     if (cwd->id.unique_id != id.unique_id) {
> > +             dev_dbg(bus->dev,
> > +                     "Valid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
> > +                     cwd->id.unique_id, id.unique_id, cwd->id.mfg_id,
> > +                     cwd->id.part_id);
> > +             cwd->ignore_unique_id = false;
> > +             return 0;
> > +     }
> > +
> > +     dev_err(bus->dev,
> > +             "Invalid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
> > +             cwd->id.unique_id, id.unique_id, cwd->id.mfg_id, cwd->id.part_id);
> > +     return -ENODEV;
>
> if this error happens, I would guess it's reported ....
>
> > +}
> > +
> > +static int sdw_acpi_find_one(struct acpi_device *adev, void *data)
> > +{
> > +     struct sdw_bus *bus = data;
> > +     struct sdw_acpi_child_walk_data cwd = {
> > +             .bus = bus,
> > +             .adev = adev,
> > +             .ignore_unique_id = true,
> > +     };
> > +     int ret;
> > +
> > +     if (!find_slave(bus, adev, &cwd.id))
> > +             return 0;
> > +
> > +     /* Brute-force O(N^2) search for duplicates. */
> > +     ret = acpi_dev_for_each_child(ACPI_COMPANION(bus->dev),
> > +                                   sdw_acpi_check_duplicate, &cwd);
> > +     if (ret)
> > +             return ret;
>
> ... here, but I don't see this being propagated further...
>
> > +
> > +     if (cwd.ignore_unique_id)
> > +             cwd.id.unique_id = SDW_IGNORED_UNIQUE_ID;
> > +
> > +     /* Ignore errors and continue. */
> > +     sdw_slave_add(bus, &cwd.id, acpi_fwnode_handle(adev));
> > +     return 0;
> > +}
> > +
> >  /*
> >   * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
> >   * @bus: SDW bus instance
> > @@ -135,8 +200,7 @@ static bool find_slave(struct sdw_bus *b
> >   */
> >  int sdw_acpi_find_slaves(struct sdw_bus *bus)
> >  {
> > -     struct acpi_device *adev, *parent;
> > -     struct acpi_device *adev2, *parent2;
> > +     struct acpi_device *parent;
> >
> >       parent = ACPI_COMPANION(bus->dev);
> >       if (!parent) {
> > @@ -144,52 +208,7 @@ int sdw_acpi_find_slaves(struct sdw_bus
> >               return -ENODEV;
> >       }
> >
> > -     list_for_each_entry(adev, &parent->children, node) {
> > -             struct sdw_slave_id id;
> > -             struct sdw_slave_id id2;
> > -             bool ignore_unique_id = true;
> > -
> > -             if (!find_slave(bus, adev, &id))
> > -                     continue;
> > -
> > -             /* brute-force O(N^2) search for duplicates */
> > -             parent2 = parent;
> > -             list_for_each_entry(adev2, &parent2->children, node) {
> > -
> > -                     if (adev == adev2)
> > -                             continue;
> > -
> > -                     if (!find_slave(bus, adev2, &id2))
> > -                             continue;
> > -
> > -                     if (id.sdw_version != id2.sdw_version ||
> > -                         id.mfg_id != id2.mfg_id ||
> > -                         id.part_id != id2.part_id ||
> > -                         id.class_id != id2.class_id)
> > -                             continue;
> > -
> > -                     if (id.unique_id != id2.unique_id) {
> > -                             dev_dbg(bus->dev,
> > -                                     "Valid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
> > -                                     id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
> > -                             ignore_unique_id = false;
> > -                     } else {
> > -                             dev_err(bus->dev,
> > -                                     "Invalid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
> > -                                     id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
> > -                             return -ENODEV;
> > -                     }
> > -             }
> > -
> > -             if (ignore_unique_id)
> > -                     id.unique_id = SDW_IGNORED_UNIQUE_ID;
> > -
> > -             /*
> > -              * don't error check for sdw_slave_add as we want to continue
> > -              * adding Slaves
> > -              */
> > -             sdw_slave_add(bus, &id, acpi_fwnode_handle(adev));
> > -     }
> > +     acpi_dev_for_each_child(parent, sdw_acpi_find_one, bus);
>
> ... here?
>
> It looks like a change in the error handling flow where
> sdw_acpi_find_slaves() is now returning 0 (success) always?
>
> Shouldn't the return of sdw_acpi_find_one() be trapped, e.g. with
>
> return acpi_dev_for_each_child(parent, sdw_acpi_find_one, bus);

Sure, I'll do that.  Thanks!
