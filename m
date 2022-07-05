Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0457656724A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiGEPQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiGEPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:16:26 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC35165B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:16:25 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g4so22383894ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DSbvTo7+AL83tbYmZRcTVuzyAaPVRXPMpXm5zUKzjk=;
        b=DXXktTlSBaSyfyP5PANcVvKzhRMpDyVurssqm2mmRBDqKjJbpHscEfmzRjHSlSiqv7
         9GJYPvBTn4aOz0RSeVzzNEmzL6Ym2kQRQLk13ROzVmq22KD1atjP/SXrCk1nL/4H/Hvu
         bbNl+UxcjxkpOY5q/m+oOg5TD4KT4KZj8PXvkb0TU5CiuIBpzy5EBhj2f/1sEHaXk44K
         0YqRc2KZo+ERa6MCSza3L8WMJ8Ut467Cu0AcRN6uOdgmoMhGayTcUiBHPvGCLPeGSgpG
         MNHmxo9fTllpluBp1IrbUy/3UaXpH1JYDfiTGhHYbgjQCpLrwgsdVf8qnlIyeETEjKP8
         dQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DSbvTo7+AL83tbYmZRcTVuzyAaPVRXPMpXm5zUKzjk=;
        b=sbedAOqBZlvcMtM8vpR91TLaGO/OLrnJwLA6uMaOdgDIsckHL/JMKYbFRmAmJPRf9P
         RUHlkHtrb7L79gWe4hj341fKpKd/L7lzkTCPyf/rnOIZJsl5KzKx4by6vAi6uFAI65bT
         +gNYN6Gz0ewEFYGSfm0SanlLpXeNvBKx0Ek6FHyH1ctCkS145uBpfhono5y/DpR+GyMR
         0GHZt0/l/OsyoLGCFl/w554l1UUeRG4L5XzHzRfmyy2vuF3aBOqC2RyyNzgf+/mcaKcO
         cIRM/XHh19ab3WTSWLAnbXc7vXVsaHIlUsrZs3EL/OpxkhqATWUDCY3h10XzkxVZ4I7M
         ra0A==
X-Gm-Message-State: AJIora/wPUVIgRjUQSxsQ2v6xBJFuEDAC9f3SPS2Cpt4IhkhrBjJvb4q
        zU/GiS0cGUP3FjV4N+CecaU9fEb9nakCcSyUuPOlUlSKTBUdMqNM
X-Google-Smtp-Source: AGRyM1v8sVLFzmodnC5Lowuu33TseCdut1qCR3nApuLoc6/xH3rU99PEbvOt6MqJivA1C4rFSAIB+WAisMBBV8fHsjE=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr1596326ybg.460.1657034184561; Tue, 05
 Jul 2022 08:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
 <20220705114312.86164-4-andriy.shevchenko@linux.intel.com> <f85d13df-b3b9-5cde-6f4c-a68507cedee9@huawei.com>
In-Reply-To: <f85d13df-b3b9-5cde-6f4c-a68507cedee9@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 17:15:48 +0200
Message-ID: <CAHp75Ves4VZHRWGW9hP1cz-Cytx_c2GsK3BHuNiCyRqCufB1Hg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] bus: hisi_lpc: Don't guard ACPI IDs with ACPI_PTR()
To:     John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 5:02 PM John Garry <john.garry@huawei.com> wrote:
> On 05/07/2022 12:43, Andy Shevchenko wrote:
> > The OF is not guarded, neither ACPI needs.
>
> This doesn't read well.

"The OF is not guarded, neither ACPI needs it."

Better? Otherwise please propose how it can be amended here.

> > The IDs do not depend
> > to the configuration. Hence drop ACPI_PTR() from the code and
> > move ID table closer to its user.
>
> Do you need to explicitly include mod_devicetable.h, which has the
> definition of acpi_device_id?
>
> I saw a similar change for another driver and it was claimed that
> including mod_devicetable.h was required.

Strictly speaking, yes we need mod_devicetable.h. But of.h and acpi.h
include it.

What you have seen is probably dropping of.h and/or acpi.h completely
from the user. In such cases the mod_devicetable.h is compulsory.

-- 
With Best Regards,
Andy Shevchenko
