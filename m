Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BAF560799
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiF2RpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiF2Roz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:44:55 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9F1DA78;
        Wed, 29 Jun 2022 10:44:54 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31bf3656517so64708547b3.12;
        Wed, 29 Jun 2022 10:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbXtlk75l5II3TFrGnNL59yjiisj9CH3v4uErLzTI6E=;
        b=M2ZHVYAJxpoEgXkZ0tTu96JQKwFIBziQonjq7BqXJ6/YYmtB3FLFgITFuWm54DY6jM
         bZEY0VWxj7rHR8oLCP4qloPMJCNv5K4KpI5QnB4+Ywb9wG3mvuLBIRkR158OsrPB/6nL
         B85tqGnxlLqBBm7jZpZufBLM5koqFkt9qmbXrTO0aPcaAT+E/QljcJNRO0rcOUS4P0gp
         /afqqGWJWBFtVpMnA1mYGPz3WJBiSQfmtLYcLSxuaA3A3SORWdaAs7tb6SYU209GBehR
         7IttOGLiV9wh1NXH88eOdibFwqQ3EAtYxKp/NuSY3lYloJUCEH4rGpEQWKSUaCAgaZ2I
         gg7A==
X-Gm-Message-State: AJIora+GmpQXn5lPhP9JyE6Nv5393y2y5tpMUsQQD9rfq8VNI42LvuXk
        D+EnQS6Ecg5ZJDtk/GouDyu/gkH/9s8bPTLIBU23tOGJ
X-Google-Smtp-Source: AGRyM1vL2ORVSpcQwNTd07xvkL0IKQ7Ef5ej3Ss+HPg4VbRwdWTF0L1ZBDWlj8UUo0SgeB14iMScs1icCte60cXOQWQ=
X-Received: by 2002:a0d:c486:0:b0:31c:3b63:91fe with SMTP id
 g128-20020a0dc486000000b0031c3b6391femr315208ywd.7.1656524693915; Wed, 29 Jun
 2022 10:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220620153045.11129-1-gch981213@gmail.com>
In-Reply-To: <20220620153045.11129-1-gch981213@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 19:44:42 +0200
Message-ID: <CAJZ5v0hDe39COAfy+Fsxi7FeUs-u4ikSU-v_dt+=x57CcLHcSw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Skip IRQ1 override for two laptops
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Jun 20, 2022 at 5:30 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> The IRQ1 of these laptops with Ryzen 6000 and Insyde UEFI are
> active low and defined in legacy format in ACPI DSDT. The
> kernel override made their keyboard non-functional.
> This patchset skips override for them.

Can you please merge the three patches in this series into one patch
and put the above information into its changelog?

> Changes since v1:
>  Match DMI_PRODUCT_NAME for ThinkBook because the board name
>  is used for other completely different Lenovo laptops.
>  Add a patch for RedmiBook
>
> Changes since v2:
>  Fix alphabetical order in skip_override_table
>  Add a patch for Asus Zenbook
>
> Chuanhong Guo (1):
>   ACPI: skip IRQ1 override on Lenovo ThinkBook 14G4+ ARA
>
> Kent Hou Man (1):
>   ACPI: skip IRQ1 override on Asus Zenbook S 13 OLED UM5302
>
> Tighe Donnelly (1):
>   ACPI: skip IRQ1 override on Redmi Book Pro 15 2022
>
>  drivers/acpi/resource.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> --
> 2.36.1
>
