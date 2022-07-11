Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E0956F980
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiGKJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiGKJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:00:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D2E21E16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:00:29 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id y195so7732473yby.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEZTXnyP1ypRhIOVBb5C3Lixd7/6JMjBXBBFzMC7F6E=;
        b=Z6gblNxiWuKDhSqDXw6E4NGxHBDK/XG2Q55Mv4bypHG1jbMGszOi9lYyZyfkKQNhTX
         QT7A0HI+MK2Gz90VLW31l6G1nbyIsFh1O2wBeXBoq5WyZuj3V+eJQAvMPDYXoxbug5mV
         fvh7e2PN0KGNpZmNcBmLHp467Dw/AKh9PERMSUn9UVHMqYyQ504dp4y1ZoEupPFtbSyr
         fhQ8LRn+jM68T/pvtIQ56o+DexWegOLPmLdqzHeoHQa50tNKv2aekrWmceZ027hKpzzO
         OmWI13OA2raS9mzaC0Ot8iIBVopTBPDLyo3YQL3fbtODHcqCedzZz80HTLRxEXXWAgUB
         M/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEZTXnyP1ypRhIOVBb5C3Lixd7/6JMjBXBBFzMC7F6E=;
        b=wxIxLY1v+WkWg4HClEy56HinYrqzV/IltNbE9yYxOT8/ZDEZNEjAyfKrE7l0dt/c/L
         w5qtALwWOlsbHeCcs0+vO52D3N8s30z6f0QderiRvnAWfBICQIxFw+d4J8WdnY/fDtVO
         uSs02QKLpcsP4iSF1UAdzibr5KYr1QIS1PcFBWJ85jyJuMjuqAI9b0zrfS7ZnhYorWAF
         0PsSj3suiLl12ecMTJt7kNuxduV5pYPesVb8eS4nx6rIdF3/UuPgTfZTPvXv3rvWfSQa
         dSMxNfrXNIEHXaJDJKIXxeTBj9Rfw+jxaI40psBkC5ru5E60O9iyorb9KBMbZ3Tnu4MB
         Zd8g==
X-Gm-Message-State: AJIora9OB/7S0a2XNTuXZN2wcSrhDAS/L+KUjTjGq53j3ArjYFmkBo0s
        tPTs5icAWVZYXAXI/BrDDv6Iw/l5t13UwfTT3Cc=
X-Google-Smtp-Source: AGRyM1swBdUKOOZB+7XaeibMGvE6ibyrd6cRsnsTf97IqsYBdiE+lmD/Or0CTRIvsQGhxomqDq3rkKTUkLzntZEesOg=
X-Received: by 2002:a05:6902:686:b0:66e:627f:4d29 with SMTP id
 i6-20020a056902068600b0066e627f4d29mr14942056ybt.385.1657530029028; Mon, 11
 Jul 2022 02:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220708210859.6774-1-andriy.shevchenko@linux.intel.com> <f1d58027-099c-0486-0433-f97ec64ecfb7@huawei.com>
In-Reply-To: <f1d58027-099c-0486-0433-f97ec64ecfb7@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 10:59:52 +0200
Message-ID: <CAHp75Vf1JmkJ06np18+iTb+U7RZtbFQTRg-COyc+-V6URSsfZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] bus: hisi_lpc: Don't dereference fwnode handle
To:     John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>
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

On Mon, Jul 11, 2022 at 10:17 AM John Garry <john.garry@huawei.com> wrote:
>
> Andy, Thanks for this work. I am not sure if you are hoping that Rafael
> picks up this series also. JFYI, I would normally route any changes to
> this driver through the arm soc tree via xuwei5@huawei.com, but if we
> want to try that it may take an extra cycle now.

The series has been inspired by the recent work Rafael has done
regarding some ACPI API changes. It's not critical per se and can be
routed as the best for all maintainers.


-- 
With Best Regards,
Andy Shevchenko
