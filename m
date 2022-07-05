Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604C756727A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiGEPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiGEPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:23:49 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C606186F1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:23:44 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i7so22399848ybe.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbVsBczVaC01ss9ZdsMqCueIH9ug5l+GvumYQcFuz2E=;
        b=W15qJlg+8A3z2kPB/fACPSPkhRq/ynTg51J2BH6eUnGWVotp8A3ALHK1dhMBFBrPc/
         H50xKWEh0pyyNvJQ66oHj6u4xYU+uoVAxYGJjI7ItXklmZhN04jH4UYaIloUKzrpukzU
         ndOt4zc5I/7RBzC/vIqh8chxhCAjQlNGih1/hApyVe9HfSy1ujNh2Awp8ENSIEfAUjvx
         53ygKId1jXtwjuCYomRNwJ9n9gqWEiprexhZlGdi8Ly0ZJWs1fovwKaiCCzdS9dRhTTi
         vZGws3MxmSyak7koYFEeZD9DLUCRyZXWzGdh1/oOmzziPaKMhNPnMCJYpHJQFSgnid3B
         mr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbVsBczVaC01ss9ZdsMqCueIH9ug5l+GvumYQcFuz2E=;
        b=sZnGxRzG4ll+Kbr1Tf1NVonSZfvOMxI1WaaQfibofgJMZPQyMGZL6WVus+vownrj2T
         waRCdJlgGUIWTeBkEymwsQJ2edzP9cSxTgJ07ZBCjfM/fdJRFSmOxS5ZGapxvHPYZ8ji
         lDpuRJ3s2yAkPL6ryfi485mt2srRjAujmb2dBrGL1OYsBVyC0vBu3OzCRSMMaOnTly0y
         /g76EHp39N3t9k27d2ZNYA18G6z/YH384QUXgENs13CsWEW57xPX8YJsyNugKnVH7VhP
         xM3HZxJAWZXqIPZ4qYhDvUIJwPJBMoIi/G2F1qSOFnxv3fvLsIRiRmPHzvXV6V31xbMf
         51qg==
X-Gm-Message-State: AJIora8vGW8ps/eUCT7TIbcXhxBjkv7kLzD6xi7Cna6e9Td7Tsrts4RR
        5v6lmOX4IX6RxEqA0lW0swe+eIKUN7lm21DpIlE=
X-Google-Smtp-Source: AGRyM1vf2aDM/4JaRqSYQxo1wrSBhgFILmfAlD1xOr+Xf5whmnze+D6cKyfQUIqwO3ku8dPVQqu1VP8LK7uA3Cs+tOs=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr37738677ybg.79.1657034622907; Tue, 05
 Jul 2022 08:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com> <ee6b33f5-c5c0-658e-8cf9-61031cd27dca@huawei.com>
In-Reply-To: <ee6b33f5-c5c0-658e-8cf9-61031cd27dca@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 17:23:06 +0200
Message-ID: <CAHp75Vf6S0sRSKx8wyhiS6o7c+yKHU_AkYDZXhN_npMDzgi9oA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] bus: hisi_lpc: Don't dereference fwnode handle
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

On Tue, Jul 5, 2022 at 5:11 PM John Garry <john.garry@huawei.com> wrote:
> On 05/07/2022 12:43, Andy Shevchenko wrote:
> > Use dev_fwnode() and acpi_fwnode_handle() instead of dereferencing
> > an fwnode handle directly.
>
> ...which is a better coding practice, right? If so, it would be nice to
> mention it - well at least I think so.

Not only. In the case of fwnode it's a long story behind its corner
case(s) where in the future we might switch from embedded structure to
linked list, for example, in order to address those corner cases.
Should I write a paragraph for that as well?

...

> Apart from above and nit, below:

See below my answer.

> Acked-by: John Garry <john.garry@huawei.com>

Thanks.

...

> > -     sys_port = logic_pio_trans_hwaddr(&host->fwnode, res->start, len);
> > +     sys_port = logic_pio_trans_hwaddr(acpi_fwnode_handle(host), res->start, len);
>
> nit: currently the driver keeps to the old 80 character line limit.
> While the rules may have been relaxed, I'd rather we still maintain it.

First of all, even before the 100 characters era the rule had two exceptions:
1) the string literals;
2) the readability over strictness of the 80 characters rule.

While I agree in general with you, in this case I think keeping
strictness makes readability worse.

-- 
With Best Regards,
Andy Shevchenko
