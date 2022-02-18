Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEECA4BC073
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiBRTrq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 14:47:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbiBRTrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:47:45 -0500
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75836EBADB;
        Fri, 18 Feb 2022 11:47:27 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id e140so21514030ybh.9;
        Fri, 18 Feb 2022 11:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YULenVBHCbgpW4h6bzsWkYMc9iBOxmalGocySqatDxE=;
        b=KICVnFen5KXpEynH1RbYeKdLiExoaxkc+I4NEq4Ve5FGVHm7zU18MI+ImqqejfPOkW
         2VxH+0lUOoYUYHyYcOdmnnUNLmNJIQ0I37wZl2cIzAPjjQnoeMkqVdEKnbl3pRb5BUpt
         0IUYoXSJfsfZhbnZLiYXY7STykO8kUU7o+G3Cp4VZU2880YEKJIbBmwTqghc4ucTbQHa
         3lvn+AGp8pvyF2oyELFKKE4JqbzRmTRfS1V+PcAm6hlm7Schgg4d6hFRDIFCb0vrf7iJ
         MzefnNNf+jnzoyVrRwBfkS0sanBZmfbOMYm90cnRO0gwUmScPb9SdvtFGdG0xf8VOYbV
         D6Jg==
X-Gm-Message-State: AOAM531+T/NCTjKFT2c90cYdJRItT3qGwyl3XfKoSA29tLhVlm6smHBG
        NPajUbeKmwb74bNWOBjXoqycpCmP4O37Lbxuo5c=
X-Google-Smtp-Source: ABdhPJwMVEmz5/hz5F8xbI86OXsROAY+/cIAJ/NbgN0uPOXar3V2KzbWMlPbhn4W67kUrspHVGDwCUCMhpIpRgIgaqc=
X-Received: by 2002:a25:d90d:0:b0:615:e400:94c1 with SMTP id
 q13-20020a25d90d000000b00615e40094c1mr8816026ybg.81.1645213646711; Fri, 18
 Feb 2022 11:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20220216203240.GA918517@embeddedor> <202202161236.FBD5D268@keescook>
In-Reply-To: <202202161236.FBD5D268@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Feb 2022 20:47:15 +0100
Message-ID: <CAJZ5v0j0+oAG3s_ZrhmG+1WaTTc-hogiKv9ZuKDiCkH8JtZ0YA@mail.gmail.com>
Subject: Re: [PATCH][next] ACPICA: iASL: Replace zero-length array with
 flexible-array member
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 9:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Feb 16, 2022 at 02:32:40PM -0600, Gustavo A. R. Silva wrote:
> > There is a regular need in the kernel to provide a way to declare
> > having a dynamically sized set of trailing elements in a structure.
> > Kernel code should always use “flexible array members”[1] for these
> > cases. The older style of one-element or zero-length arrays should
> > no longer be used[2].
> >
> > [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> >
> > Link: https://github.com/KSPP/linux/issues/78
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

I've created an upstream ACPICA pull request for this change, thanks!
