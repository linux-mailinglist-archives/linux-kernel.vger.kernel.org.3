Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C0950F8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344694AbiDZJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347777AbiDZJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:06:10 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93718B2E;
        Tue, 26 Apr 2022 01:45:44 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id q13so4669870qvk.3;
        Tue, 26 Apr 2022 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8JC263FgFy3jyxA285+ySjFZq/wFTiKMNVDc/5kVhk=;
        b=nt1HXhudCOieSH/ymuSaNTnhqUd/Yn/oVUEEYb3qthVUMbdwFvIw1v0rc1C1Tp+WPw
         UJWxenWHUbFlqtiaar8qbKkHXa6imluukeApPMlTrfLlhVpvNewvoHvuIml4/HByW/yT
         SbUZp/GU+AxFM2GbY9mOu3wrneuQnRKWo1rNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8JC263FgFy3jyxA285+ySjFZq/wFTiKMNVDc/5kVhk=;
        b=A7006gB/6uliZT16r9BmaNo704b/t6cFMbHSqFSeZSY2xZ67WboSGS6bTNtSV2NsT6
         /zMFp+spygDQ9c1VnvRwbXDI4Lja8Og4y7OKuRKs126Lp+RB48VcZvgdu3bi4j5L1dka
         S+A84qGNhmCAamq+UDihY8q7W/picAo2v4vABIr/HW4g1dBpoBt3FWMcHcupp88gNVvR
         gpgwuJ1XZzKnZYnlrH5LKmNabsURZJPu+iWfXAWqtzfb1LG0Ty4b3QYdjazKrTVRFzDE
         y07kqCfWI1SSTR0UKoIBibEq1l5gU0va4F18nkqKV4VgbsUN89YRUeFtDiM75EsI7bZy
         iUDQ==
X-Gm-Message-State: AOAM532JRvuIN5iKnS5id8qLkOKdWsZ9awQAkf+hUIcD9o3WUG32A8EQ
        vHfatmv0uzzoo1U1sQcNhKvBzg8lNewzXOhzTAk=
X-Google-Smtp-Source: ABdhPJy/a7R5QcfkDGNvXevfex9gGYiGDw8Vgm3NWqkPXA+VHo8PUgOW+SRHNkzWV1ncHmUfOz8hiw4ynmpzy6AWqSo=
X-Received: by 2002:ad4:53c5:0:b0:42d:7bb4:a8e8 with SMTP id
 k5-20020ad453c5000000b0042d7bb4a8e8mr15201215qvv.8.1650962743952; Tue, 26 Apr
 2022 01:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220426071848.11619-1-zev@bewilderbeest.net> <YmetYjSKFs+WWwYz@hatter.bewilderbeest.net>
In-Reply-To: <YmetYjSKFs+WWwYz@hatter.bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 26 Apr 2022 08:45:32 +0000
Message-ID: <CACPK8Xf2a2tC-u_9CjLVoh9iJmUdOKveLfjy1UNKQbqYPr0Zhw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] hwmon: (nct6775) Convert to regmap, add i2c support
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>, webmaster@kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Rob Herring <robh+dt@kernel.org>,
        Renze Nicolai <renze@rnplus.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 08:29, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> [Adding korg webmaster re: list infrastructure]
>
> On Tue, Apr 26, 2022 at 12:18:42AM PDT, Zev Weiss wrote:
> >Hello,
> >
> >This is v3 of my effort to add i2c support to the nct6775 hwmon
> >driver.
> >
> >Changes since v2 [0]:
> > ...
> > - Renamed drivers and Kconfig symbols to keep existing platform
> >   driver as "nct6775" (SENSORS_NCT6775) and the core module as
> >   "nct6775-core" (SENSORS_NCT6775_CORE) [Guenter]
>
> Unfortunately while this was a simple enough change to make (a few 'git
> mv' commands and a handful of actual text changes), it ballooned the
> size of the diff for patch 5 to the point that vger bounced it for
> exceeding the 100K message-size limit.  As far as I can tell it looks
> like it went through elsewhere, but does leave a bit of a gap in the
> public list archives -- please let me know if there's anything I should
> try in terms of re-sending it.  (The only combination of 'git
> format-patch' flags I've been able to find that gets it back down to
> approximately its previous size is '-B -D', which isn't so useful for
> actually applying.)

FWIW, I moderated it through to the openbmc list, which is on lore:

 https://lore.kernel.org/openbmc/YmetYjSKFs+WWwYz@hatter.bewilderbeest.net/

So the series can be fetched with eg. b4.

Aside from the mega-diff in patch 5 the changes look good to me (If
you can think of a way that makes patch 5 easier to review then let me
know).

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> I'm not sure how critical a limit that 100K is, or if it's something we
> might consider raising a bit?
>
>
> Thanks,
> Zev
>
