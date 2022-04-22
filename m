Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB9650B9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448588AbiDVOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392400AbiDVOUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:20:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C75AEF6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:17:50 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h83so8706816iof.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCYmIndiH4QxBgXp0gYdbitZyC6hIsjEz2mk+1J/x88=;
        b=Y77Bc1EtquV6mceoyBGGUgk2RZvTpo1zObncU2ykZciej+fymYF3lDlrnPbHYCxlFZ
         6rjbX/BHyTv9yDf+MwF2jhOOgqT2ISMT8S9ROsGZooIds5gwqz3Bhd4reQFKBoNWash9
         pzI4tvgbj3Kg+qT7xw9NJx4Dl0fhK0OBIwa77dpx42U4qnU3yPqrR8cx81HtNzD2/kdr
         2CPAh7xPvKR+KOYkiqonrMDaxgjhRn4as9PaladacmX1h07hAIL3SrM4NZ0Ryg0H+0JG
         hNLw7DM+tpXSfhb3c1vTpqQWOpDIdBI/I9IpNTWWk0j/sPXCoVLbtvTtZYCTc8ubn0J0
         lNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCYmIndiH4QxBgXp0gYdbitZyC6hIsjEz2mk+1J/x88=;
        b=ceWTmiLddGcCRWg4Re35AJMQB+kBlo9kku2UgHDh9MaTj0PKjVD6MCLGZHWyNTQCdV
         qvlfxGWxJwrrkyrisrCO6SDzcvCHnoqkPfCevhGtK/z/vOw8wUXRSS5HVcvMOO0SKHjo
         LjHSLhGlJRLS4GmoY9uHIaIiZQCA5OLAY9TGGgSxAH7E14y+o+JmdIlP8CBcHnzynESW
         MakgLuYiwCIejNTNiUgcZetib2mN4vpZf1KQ/evFr4FoTM9SoY8ppKHh0CEd0mnJ//ip
         oHm78lUyLZA43zYQIxBBjjqXnOOx+GAkGQXaEd4hE+rE7HtspnMTrN76t+mwLOUGR5WS
         NNUA==
X-Gm-Message-State: AOAM532tP9O/pk3eu50/RY6HqEuRBhgToE9oWOySL0Vw8CgkN5oc/j4u
        1R2Dj6FEcVAbCdM3rWAIt3U6zv5rNTRnlay11t4=
X-Google-Smtp-Source: ABdhPJyjZv0dxpP1TfDVnbplbLdekOcaH7HP+KZsVInf57gAiqNBECWUMJr212f9vCu+fh6ehZ0A+ZOTxNBSzc0JrY0=
X-Received: by 2002:a05:6638:dd6:b0:32a:9ba8:22e4 with SMTP id
 m22-20020a0566380dd600b0032a9ba822e4mr2335457jaj.264.1650637069552; Fri, 22
 Apr 2022 07:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220419205158.28088-1-cmirabil@redhat.com>
In-Reply-To: <20220419205158.28088-1-cmirabil@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Apr 2022 16:17:38 +0200
Message-ID: <CANiq72n1gBE+tv3oAF4wjdK2jEJJmU4V=Y1CTZ1PpCEeqLbo9g@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Raspberry Pi Sense HAT driver
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        fedora-rpi@googlegroups.com, Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
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

On Fri, Apr 22, 2022 at 1:02 AM Charles Mirabile <cmirabil@redhat.com> wrote:
>
> This patch series adds a set of drivers for operating the Sense HAT
> peripheral device. This board is an add on for the Raspberry Pi that is
> designed to connect using the GPIO connector and communicate via I2C.

Is there any feedback left to address? Which tree should take this?

Thanks for your work upstreaming this!

Cheers,
Miguel
