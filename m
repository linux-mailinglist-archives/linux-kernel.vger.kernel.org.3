Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350EB4DC7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiCQNqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiCQNqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:46:39 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2EDEB96;
        Thu, 17 Mar 2022 06:45:23 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id l2so10285628ybe.8;
        Thu, 17 Mar 2022 06:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPkA9tWXGYSPfTkvzhOngjgt6GqV+PZtcZByWXDH0PM=;
        b=1/iO2RCInkV3rhF/DbTZqvuFQgmbXPWT+s0fXqBrlbn39rnJ2EckyldzY2ic3yR5i5
         71gJsdLnoKMDn+MmgqgeTrYIKCxcV9yGj/0b7GizTDS3V49wfh22XDlAwjVUSK0fUDJp
         KkGcYzn+rHPvsw4FELmAV1A7SjM1NLESzR/NVdI1agrk24Fgiz/Kvc0KXvoJ3N55XQlm
         U/5NNQ/eoJ00fWQQMmfDjw+8qVcvE7NEG9EgfY+VLMbRIx5HmB9IZ/1KpyM6qga1Qhna
         FBrJfgTh7D5rto7WZtLh75FU/k6A76x2e/Dk+Qpk7jAP8jzDYoGjh9rFRFWnLCFZUMYN
         iRnQ==
X-Gm-Message-State: AOAM530sAF7ao7h0W1ZRJua7k1IpsjgVX7Stz/1q59WvGks0ZU5dp/KS
        l6H7u5kf1xDDEaHUyVdgu0J3B5iX6gxZF42hiJ4=
X-Google-Smtp-Source: ABdhPJwOGOZbUy+HA0zjr99J3BqTy7SnKUJf0UQ7rf44mwXAJU0ylPDrV/TF0wNiU6KHSW1fQ9vIXEVRqIbbDcN8beQ=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr4852801ybe.365.1647524722391; Thu, 17
 Mar 2022 06:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220312043624.40732-1-dacohen@pm.me>
In-Reply-To: <20220312043624.40732-1-dacohen@pm.me>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Mar 2022 14:45:11 +0100
Message-ID: <CAJZ5v0gqpQTuNN0WpnEd4dAQmnR=BXSoH_w7kkAxOG7xkftW6Q@mail.gmail.com>
Subject: Re: [PATCH v2] PM: fix dynamic debug within pm_pr_debug()
To:     David Cohen <dacohen@pm.me>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Sat, Mar 12, 2022 at 5:37 AM David Cohen <dacohen@pm.me> wrote:
>
> Currently, pm_pr_debug() and pm_deferred_pr_debug() use __pm_pr_debug()
> to filter pm debug messages based on pm_debug_messages_on flag.
> According to __pm_pr_debug() implementation, pm_deferred_pr_debug()
> indirectly calls printk_deferred() within __pm_pr_debug() which doesn't
> support dynamic debug, but pm_pr_debug() indirectly calls pr_debug()

I'm not sure what you mean by pm_pr_debug().  There's no such thing in
the kernel tree.

Assuming that it means pm_pr_dbg(), it doesn't call pr_debug():

#define pm_pr_dbg(fmt, ...) __pm_pr_dbg(false, fmt, ##__VA_ARGS__)

and

void __pm_pr_dbg(bool defer, const char *fmt, ...)
{
...
        if (defer)
               printk_deferred(KERN_DEBUG "PM: %pV", &vaf);
        else
               printk(KERN_DEBUG "PM: %pV", &vaf);

And as I said printk(KERN_DEBUG ...) is not equivalent to
pr_debug(...), because it is not dynamic printk().

pm_pr_dbg() is not dynamic printk() on purpose, so they both can be
controlled independently.
