Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993F5513BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351276AbiD1Sxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348911AbiD1Sxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:53:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562F56229
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:50:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h29so2964750lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/3kak4px7jr3LInyUqNpuxAJYL7n0yOLiasgLA10vts=;
        b=I6KWsFSB6vz32X8DnsS8yLCJaLOJTYxiA2Puz8Fx6icNuiQsPvy/oIhqF0ORPdhQOt
         Th9ZVpd9sHvAarrSdfHK/SpuW/5HWf1PYD+3siS5jtp1bykTFknkwTDU1LO62qH3wLG6
         907IvJnTw3shXZpDWyBzOOW5IM+QU51o4eZTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/3kak4px7jr3LInyUqNpuxAJYL7n0yOLiasgLA10vts=;
        b=AnubPsNm1rvr18UaYWTPMZ71YOeohIjJvl/zk928DcgWspUJrqlSAPBWBLXClcMdia
         Hak8pQEeVDfX1jI9TrlyghnwwWA2q7iDQiWJnZjWA3E7/HQ42l6rJaLggxTUOysFhLBk
         PtbsxvHHDDo8DibaXTBf/mWjgSqRExFXu/bB4lv7hUAI8oPkidwuC6v/B9/mSV+DcavQ
         KboGB0RmPaUn4wMNDU5v+qP9Hh9E8HDmoDmzXD/DAIRh2+JP1kTXbqXTJFEVXBYJSu7e
         Qclaq7Wv64A60KzWPI/yIMEZuJcy8zZE+/ENFRj9l7yejN4hc01CKPNlc1qzQrSSooik
         fDpQ==
X-Gm-Message-State: AOAM533S5/iqxWMCvRGYH3DidMvLFLdF6AnPurNs03U48DctBcUBCwD+
        Ag+QYpanUbfWrimC/OJBlfVtYnYUActgSwlAI8A=
X-Google-Smtp-Source: ABdhPJxyEBgG4Q2MKmlPX3ATiQU2cB1K78VaItBBWdVZPL8atDEeDzj4atuxkkUKCml91lDolgXCVg==
X-Received: by 2002:a05:6512:3b1:b0:471:f9e9:d8d1 with SMTP id v17-20020a05651203b100b00471f9e9d8d1mr20342683lfp.72.1651171820933;
        Thu, 28 Apr 2022 11:50:20 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id g22-20020a19e056000000b0047200b2f9dcsm69575lfj.22.2022.04.28.11.50.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 11:50:20 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q185so7872563ljb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:50:19 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr22123546ljh.152.1651171819543; Thu, 28
 Apr 2022 11:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Apr 2022 11:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com>
Message-ID: <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.18-rc5
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:30 AM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
>  - Make the ACPI processor driver avoid falling back to C3 type of
>    C-states when C3 cannot be requested (Ville Syrj=C3=A4l=C3=A4).

Hmm.

Doesn't this avoid C3 for _everybody_ rather than some conditional
"when C3 cannot be requested"?

Of course, it looks like the 'has_lpi' state still potentially allows
C3 even for busmastering sleeps. Maybe that is what you meant.

             Linus
