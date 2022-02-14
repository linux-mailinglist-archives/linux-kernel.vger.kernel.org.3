Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040E34B5A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiBNTRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:17:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBNTRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:17:03 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16E38BE8;
        Mon, 14 Feb 2022 11:16:47 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id c6so49189552ybk.3;
        Mon, 14 Feb 2022 11:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzrVMcjVHERtKSM0FYQPAihvxExHzZg8a0NX0dN9W9w=;
        b=LzC9CpZJw5c/+sCSHlomBOlNFZex7aWXnBGiIv5HvRZvFwBmzv0fU1YaY8VuW5cS9a
         kl8RCQg+q9bPskItICSprAaOJ1lDH2vcH6JkjsVzjbHeeCIJ/TqYLNcu6SHljpuz5hlG
         2/Vxcze7DthyCnubaw2low8Kqqz4n1cB4RL8IcjZtbJFY7NrbP+CWfqbhNAsSbT0Br20
         blNGU9DIcfQWCXKZB1CSEOR1rrJIA+gqpNmQRKtN7FEwEj4M2NMfMDfZuX1tkqhR2Cci
         NaYoh9hSGkFwCIS89d5Ejdrn6lNtSqEop0izf1IrKs24GdnrsTlyuWJaCarKjJTI8iXr
         kQXg==
X-Gm-Message-State: AOAM5328lZ2Ulr+eqV/NjHKXdJQkyjPTBhApH1PSCrPF/zTDSnZqDJGs
        xYNzR0WfsUnyAcpgQo4CFPu8S3Tx28NybG+2tRQ=
X-Google-Smtp-Source: ABdhPJwHuusDjPsm1V25596Pa1nnl0uuNq2nUq1Q2KPf6t8ejUsf1/sI+e3wOa6pH5dhS69iAHuzDZULSkIaGapKRHg=
X-Received: by 2002:a25:7e81:: with SMTP id z123mr523455ybc.466.1644865924393;
 Mon, 14 Feb 2022 11:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20220211023008.3197397-1-wonchung@google.com>
In-Reply-To: <20220211023008.3197397-1-wonchung@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Feb 2022 20:11:53 +0100
Message-ID: <CAJZ5v0gD4zs3uBAYv6M4_1gNpkZ-g9XKOywJnf5007e6GwoGVA@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: device_sysfs: Add sysfs support for _PLD
To:     Won Chung <wonchung@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Fri, Feb 11, 2022 at 3:30 AM Won Chung <wonchung@google.com> wrote:
>
> When ACPI table includes _PLD fields for a device, create a new
> directory (pld) in sysfs to share _PLD fields.

This version of the patch loos better to me, but I'm not sure if it
goes into the right direction overall.

> Currently without PLD information, when there are multiple of same
> devices, it is hard to distinguish which device corresponds to which
> physical device in which location. For example, when there are two Type
> C connectors, it is hard to find out which connector corresponds to the
> Type C port on the left panel versus the Type C port on the right panel.

So I think that this is your primary use case and I'm wondering if
this is the best way to address it.

Namely, by exposing _PLD information under the ACPI device object,
you'll make user space wanting to use that information depend on this
interface, but the problem is not ACPI-specific (inevitably, it will
appear on systems using DT, sooner or later) and making the user space
interface related to it depend on ACPI doesn't look like a perfect
choice.

IOW, why don't you create a proper ABI for this in the Type C
subsystem and expose the information needed by user space in a generic
way that can be based on the _PLD information on systems with ACPI?
