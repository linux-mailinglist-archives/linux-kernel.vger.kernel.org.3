Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93408513C35
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbiD1Tx0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Apr 2022 15:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiD1TxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:53:23 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B3B26DA;
        Thu, 28 Apr 2022 12:50:06 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id w17so10899115ybh.9;
        Thu, 28 Apr 2022 12:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MjJFRl9zxHBD7Ef9rxT75GXYs6BfVSpg1GTO4h+nOHo=;
        b=UQiHkrTTB5YhdWVQSBm5bxf43qLkP/SMGyIhUYGZv6HlxVg+UuclWuaUYIYT68oih+
         MnBEvk4m1qIFWf8Qa7E6gqDc82HEEYhK+/LIN15uMwvqWF5xbRad8wIno5PRTBLB7jW1
         Uo1+n7DjWOVM2mk9BUHOrvahYw5TfeYq1qIOYQ4unXNneuJe1KF80VK8aR6OGbmmOsYh
         Z0T45p4+7Z/3FuYyj02xbBY3TZ61sMuVUAyZFMCBRnGdCrciOeIKl95rYrK0mroZvD5m
         tJ5V/Iy4v9yMvjwFomo6SQZh33oeAQw11cADykZgSb7cTZmUhgYgg1N10UMnXrCpC3xq
         zAAg==
X-Gm-Message-State: AOAM531v+2fk/sZ01n7VvShL8Gf9hB1QsMOPBZKdV6eG4O9fg86VOr5D
        Evb/BnhoGdjGE2IPJFVgHDFUTzPis++QKin+bsPYESvn4jQ=
X-Google-Smtp-Source: ABdhPJzd1gMQJMRF8n6zclaqn9im1EeqLqzsuhBkQncyHUtYxezKcxxDsdklplYjnIyfEOOJ6nEHelJompr8vXe/7+U=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr31156818ybh.81.1651175405157; Thu, 28
 Apr 2022 12:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
 <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com>
In-Reply-To: <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Apr 2022 21:49:53 +0200
Message-ID: <CAJZ5v0jpaAwq0Ad-ZA60bA5AU8JG1Y2muYtXy-bA4LapX8_dJQ@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.18-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 28, 2022 at 8:30 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> >  - Make the ACPI processor driver avoid falling back to C3 type of
> >    C-states when C3 cannot be requested (Ville Syrjälä).
>
> Hmm.
>
> Doesn't this avoid C3 for _everybody_ rather than some conditional
> "when C3 cannot be requested"?

The bug was that if acpi_idle_bm_check() returned 1, it would "fall
back"  to the same state via safe_state_index.

> Of course, it looks like the 'has_lpi' state still potentially allows
> C3 even for busmastering sleeps. Maybe that is what you meant.

That too.

Thanks for pulling!

Rafael
