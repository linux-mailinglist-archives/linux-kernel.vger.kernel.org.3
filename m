Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3E595BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiHPMnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiHPMnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:43:02 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34FCA5723;
        Tue, 16 Aug 2022 05:43:00 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-33365a01f29so49523117b3.2;
        Tue, 16 Aug 2022 05:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=affDx7YYSj6xQ4eR6nXfR9zJnf72TelRFUd9ASs8gI8=;
        b=ScCda5S/rGxwuPWNJ4DlWiDO/omZO+iTIhSz9ps9CrrXwzxdAYCG3JIywGh2JCeLFU
         N2GV1CA7onZnk4WBA1P7lHQrwhlYlrBKO67hlAHom89uvqPdp72SJUrjuRaS5z+y1k11
         /2PC5oeEkNrOja7afSUDrSChWOMiKhwxvo2t0srBbzW01bwyRGf2WvQh6MPp/DJwsiot
         mV3xXBKCvqOBK28wZXbLGNtIysZcqRTB0GJetnnPGdjg6bSPRuNK/Aapg6oTmMtzjlYF
         pg04cUrXNOOMKCHBrwNdcQn/DMRRXnMhKrnn+Qp1k8LCKZTnV2Iw77FM9z1TFzQibrde
         4X6w==
X-Gm-Message-State: ACgBeo1AeTQxMFC7oQsb0R7QL8iGMbzVtkFaAjK+lkBoKKOrIKQae2VC
        iGYwCujYPWtckL88np7oHYRwoWAKGXyntT7YJdg=
X-Google-Smtp-Source: AA6agR6298vDmFGG8jEUrJ93CW+t8ntfXsS5nCUDda/RQskP2VBB3GNoirtC1qS/JKwLem0RiMkbWhNdsDt+BJ2PsBE=
X-Received: by 2002:a25:e90d:0:b0:67e:e3c:1459 with SMTP id
 n13-20020a25e90d000000b0067e0e3c1459mr14395165ybd.622.1660653779341; Tue, 16
 Aug 2022 05:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <e431a4ce-b9c3-a9d8-57c1-c9d055c2ca0f@huawei.com>
In-Reply-To: <e431a4ce-b9c3-a9d8-57c1-c9d055c2ca0f@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Aug 2022 14:42:48 +0200
Message-ID: <CAJZ5v0i0ZpG=2W=XowHACnP9q2ScNZJ8urpHT-69J6ZYAEJaGQ@mail.gmail.com>
Subject: Re: [BUG] Issue with commit 923044133367 ("ACPI: property: Unify
 integer value reading functions")
To:     John Garry <john.garry@huawei.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi John,

On Mon, Aug 15, 2022 at 11:55 AM John Garry <john.garry@huawei.com> wrote:
>
>
> My driver of interest fails to probe for v6.0-rc1 for ACPI FW:
> [    5.373722] hisi_sas_v2_hw HISI0162:01: could not get property sas-addr
>
> from a device_property_read_u8_array() call
>
> The following fixes it:
> https://lore.kernel.org/linux-acpi/YvatSoqXEtI7oqUO@paasikivi.fi.intel.com/T/#t
>
> Tested-by: John Garry <john.garry@huawei.com>
>
> I'm just sending a separate mail to highlight this issue as I spent an
> appreciable time bisecting and want others to avoid that. And I could
> not find the fix mail for some reason, even though I subscribe to the
> acpi list.

Appreciated, thanks a lot!

I'm out of office this week, but I'll be pushing the fix for -rc3 next week.

Thanks!
