Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE95349B64C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiAYOb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:31:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1578999AbiAYO0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643120777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLtIFJjgUtOUVDA99ng5/AGYu7PV8wK1w9Iei4rx6Qg=;
        b=eN7cCiL1RTWtEPi+pCzfJ+JeAsLx6NWd0J5Na1+geEwjo27YSHQEDvWWsZiLz3D3najCzu
        8xR4bJyDHUJY9wHmILqbObrtt4jmu1FWwOZSNFLonykallljz5qs0W8+7yfJNDfhmKs2V7
        NXERGBqOAoE8SD+x1hqZ+/hmL64Is8w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-488mywHbN5SQtNDqinftjg-1; Tue, 25 Jan 2022 09:26:16 -0500
X-MC-Unique: 488mywHbN5SQtNDqinftjg-1
Received: by mail-ed1-f72.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so15035001edt.15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLtIFJjgUtOUVDA99ng5/AGYu7PV8wK1w9Iei4rx6Qg=;
        b=qgySIFMEfkIE5WOzF7dup0PI1gwZILzMyh5r61s+BPb9iiVOI7ZbLR3Lrg18bQqkRl
         aRIX9wG0akZ0Gkyra5PSYGzscA8L4WFqtl4C/5VAQ7QFxVTs9dv9GhvuLv9c0bdFefLt
         rk/Yf7CjrRT5e18/3cjgKm9uKbArYCeMnioQlZYxSfhk6vMxgl6wDNRdFWGESvEADn8e
         FiabCDTIzmwHWF/D14xr3K18Jdq5SqaBiRkECs89PNE6kAcMZ61FiYYowWOtEe/FFvcI
         T/uWhpog+M1rMk8HivYfrjRJiRZI4DmXmLYpQ/ulAnuSX4FPcoaFg2lHuOaOXZ+yyKR6
         9lUA==
X-Gm-Message-State: AOAM530/UrBtJbLd4Tc30WsKCjzFJN30y6JN4Y/JRmziG0dVb1bdrSVN
        8fygi3DHe8odpbprbJjQCVyr9AsORI4M8o5+px47BQgY11ie/b0PfvbcjotPN9jPh/D670GElsF
        dmVZvId0EAGQlMHdjMV7NwerbUblHyH+19YruAzrs
X-Received: by 2002:a17:906:1f15:: with SMTP id w21mr16253527ejj.205.1643120774973;
        Tue, 25 Jan 2022 06:26:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9O9o4wfs8N1leHAikkbwJT29Az/OoR2DjwNtoJWQuQqqvtGNb1WTEw1Hy2QO4rGn2JAk000qaKRVjx7pfKF8=
X-Received: by 2002:a17:906:1f15:: with SMTP id w21mr16253499ejj.205.1643120774706;
 Tue, 25 Jan 2022 06:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20211222112831.1968392-1-wander@redhat.com> <20211222112831.1968392-2-wander@redhat.com>
 <Ye/1+Z8mEzbKbrqG@linutronix.de> <CAAq0SUmdGinqdWXrHztx8g9hb+5UF5rDJJjVeVMj3CQ=Fw3kJg@mail.gmail.com>
 <YfAFAcYmJ+Zrontd@linutronix.de>
In-Reply-To: <YfAFAcYmJ+Zrontd@linutronix.de>
From:   Wander Costa <wcosta@redhat.com>
Date:   Tue, 25 Jan 2022 11:26:03 -0300
Message-ID: <CAAq0SUkuG2uyouBhT5yDiq_KbOGUCO=9ondq6dkt1QZLN_C4uA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tty: serial: Use fifo in 8250 console driver
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:11 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-01-25 10:15:04 [-0300], Wander Costa wrote:
> > There is another thread[1] reporting some issues with this patch.
> > There, this diff seems to fix the problems, could you please try and
> > report if it works for you too?
>
> Nope. Still there.

I will check on my side if I see something similar. Do you still get
lines lost as well?

