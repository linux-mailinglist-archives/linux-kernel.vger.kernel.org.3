Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72092577288
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 02:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiGQAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 20:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGQAFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 20:05:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3198718361;
        Sat, 16 Jul 2022 17:05:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f65so7568118pgc.12;
        Sat, 16 Jul 2022 17:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvc5QnDNvevbD8cpU2SRqKC1urfkP+uvE5heBXUe2+4=;
        b=oziB7A0EkBfra1KLj464rVXNuZ+pjC5Gy11QekAwFbnkzeBQPmwIgbzKzJh1LHW28N
         PScexfbKTdQzicu/Cs27nZ4cVPYw7NtoZDc1sbJTmxVhNn2QhJA8HD9deL0geKK+M5St
         d0C7ERHBbRUOW/n+vfMX0CvVHqhUkmEUiM+eyCTRqQp8igNmtZQXndgF87hcjnsGph42
         MFdJquMa3WichkswOD0ounARqfTm8OAtNsGM68D4ltBzp+lsZNG2zdHOJUEADS2dMXEP
         8OOf9gzgIDHw7GAVvmBg/enmiKwpfjAJhq6YhxzWUkE/wbVFq901yUmqDC+jJcS9JoJ+
         6JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvc5QnDNvevbD8cpU2SRqKC1urfkP+uvE5heBXUe2+4=;
        b=sI2kAnhuZoJYOcRoqcQ+QtUXbGc8Nvj3Z0yq+VL2SKZHD4X0Ze1MhkKISdlaz1cn2q
         pT2X53Xmgm2nup8RKkBsA5h+AXpBtXuHjV12+oqzXW6nACT+to0NDjg9VTFe3b3hlzDq
         I0iG4ygyF7XBHW+wkkyXPZPwQi2YlpPVXLtdkYjVRWvWFr7m1YbO9oO/fZ/WZu4ZzVuD
         ii3Buqa4VmCUPuqq1Xu+74HvWytj9GPBynZvSlKWMUt75PWOBt7HnKTZFeb6IV+zjTTe
         wII7adTntWVwRfS1ESxwXOQZAq75L7TCZQgbcFhYq8wYhYRXGrQqt7zr7FuKBzwBRDTg
         XUnw==
X-Gm-Message-State: AJIora/oW4vfkIohlvjDrjRQ8lXFTgCKb87SDf00BNfVx6kNr+GvGJPG
        PbEJNxrnXa4c7ZeZ21pjE2dCq7onrD85xi9vuCYuAHidSmo1
X-Google-Smtp-Source: AGRyM1voVlgt4czroxoBFv8HX05m2Y3yhAzDqzgeiwv2ZtzUUsyniDhVuS4w1kXpGSWfCkAZx0rW458wrb0WMnc+Pbw=
X-Received: by 2002:a63:7d49:0:b0:408:c70a:9496 with SMTP id
 m9-20020a637d49000000b00408c70a9496mr19546538pgn.616.1658016339158; Sat, 16
 Jul 2022 17:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBj=bs8rbiPGX1qOv9FSU8m=TdRZqqJGvRcynKbaWwf_A-A@mail.gmail.com>
 <5fc2c89d-5aaf-3b81-64cc-7e69b16266c9@infradead.org>
In-Reply-To: <5fc2c89d-5aaf-3b81-64cc-7e69b16266c9@infradead.org>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sun, 17 Jul 2022 08:05:27 +0800
Message-ID: <CAMhUBjnUfH6hKgP7nwoCXphwMtc838zjzJZuUuNzOo4b+cESHA@mail.gmail.com>
Subject: Re: [BUG] media: cx88-alsa: Found a bug at the probe time
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, Jul 17, 2022 at 3:03 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 7/14/22 18:54, Zheyu Ma wrote:
> > Hello,
> >
> > I found a bug in the driver cx88-alsa.
> >
> > When the driver fails in the function snd_cx88_create() at the probe
> > time, it will cause a UAF bug as follows:
>
> It's not a UAF. It's a WARN() macro with an IRQ management problem,
> as shown in the next 2 lines below:

You are right, that is indeed just a warning :)

regards,

Zheyu Ma
