Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B794D51FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245578AbiCJStV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiCJStS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:49:18 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2464D9C3;
        Thu, 10 Mar 2022 10:48:16 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id x200so12688005ybe.6;
        Thu, 10 Mar 2022 10:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MTgeYPyfFm0jf3sbZyxxk/7jvLER9ox+8hl8j5mQNM=;
        b=Cen+4mX+YEqYVpfprX6nDd3qita+XMchSL9agFF9BOLhkbkJTRIsS+yM4dvY4h0j2m
         whyrtMBmE0aZIQyMIHHdCRm+cqgseD7lFVoybQk4pUcC5p9J0J1qgiiJb4dgz77fi2PO
         C8xDnszTe5rQStpAbAwSCySdsJtTUPyxRo+p/uqfaDg7MFlJjme26QN5msi1Ob8E42bN
         2O7H2eeg6GhN3NHPEii3Fg2D4RN98Cobsd2Um45RQYzN8bupW4OW7ARXwDCBYAkNyEMn
         shvh3HQlWQAcf0hFxAIWXFKPOMq8bAT4Z0h9j3+ddoRK0S8VkjJd4/c6eVZX7LLoGFVy
         N4Ig==
X-Gm-Message-State: AOAM532nlRQmA+nFcZ0OkSg+5NHkk0OEDIr72xx0ACdNCdHZal03VMT4
        spqXzbhSMLxFSwhW/xhwQF7YRB59v9Y6V01doHgira6a
X-Google-Smtp-Source: ABdhPJxwIP3Vq2gEyZal0MKhjVzWbyOi4Y2iq3Nj79SDr0ARs88DeDenr5sct2NMMwOIjby8Wq6QUSKf+WLyxCh20bM=
X-Received: by 2002:a25:24d7:0:b0:628:79dc:1250 with SMTP id
 k206-20020a2524d7000000b0062879dc1250mr5093341ybk.153.1646938095508; Thu, 10
 Mar 2022 10:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20220306055207.386821-1-dacohen@pm.me>
In-Reply-To: <20220306055207.386821-1-dacohen@pm.me>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Mar 2022 19:48:04 +0100
Message-ID: <CAJZ5v0iRfK2vDFUeD1vXeRUr4ngG5-34pHpsmfiS2pFf3HWa-g@mail.gmail.com>
Subject: Re: [PATCH] PM: fix dynamic debug within pm_pr_debug()
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

On Sun, Mar 6, 2022 at 6:52 AM David Cohen <dacohen@pm.me> wrote:

The patch has been sent as an attachment, so I cannot comment it inline.

However, printk(KERN_DEBIG, ...) is not the same as pr_debig() AFAICS.
