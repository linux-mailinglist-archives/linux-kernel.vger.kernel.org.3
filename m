Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A65581D44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbiG0BlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiG0Bk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:40:58 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2DE388A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:40:57 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j70so19258612oih.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ZQP39BlWuH5uB0igKBxBSRYwBAlp0vmJqoxShBhFmBY=;
        b=dI2oF0ZD8dQ0SzyPbg8twIuj4mxUSEjCINx9u4QJDkseMmtr0SHQJ+/mijZafeqRTS
         yjCUC7o6km74hUzt+USVp7m+SHz8f9jdwRmiDdZugO4cH9w3k7NQh4k4m++b4Jj/ftbX
         qsMI4p0BMuDs0sn+J29Su2nd190GkHbD7dmQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ZQP39BlWuH5uB0igKBxBSRYwBAlp0vmJqoxShBhFmBY=;
        b=kzWbUw2n21tdykAkV3cyVFNiozjfY7iuIEsTHLPDnaTEp6vEy1cRprsHw9EJJpTA4k
         V0QN6B+QHsYQ/j65LJqUOnt5WvpgraOxUvWROcxz9rRYuKJ+Egt1w+MB4dDOLr3hTJY5
         cVpLiEm+mOo0XnfCKCjY5Nt7B/2f6gHFeYuwokmN+0NZc7IN7Z8HlbcbwwCYCwjzMAGI
         fVM0ui0hfs3RMoXnSpQ4D8UTPMB4VtrOIgWdbMeNWCurWXVpHrk9/tx1EqXSD24FEn7I
         XSLkufX3fdbq/ZoDTgHJoG3hNUiRil4T7UYv4E60+3YIL60fxlP4VcanG9jIzJugBeZJ
         LnnA==
X-Gm-Message-State: AJIora/HdMVfjpF//mt1kwfqcMxWyenVO3lo+f7+ST4msfu//dSbs9lm
        KNTI5EDyQX9ll2D9q3ATLZxmjIfbxFdVTr6k+pLqkA==
X-Google-Smtp-Source: AGRyM1uoeYlsAmwt/493nEC5g8suOwARV4xuMdrjwWz2LdrSKJMHfmgJDWrtUE5AcUZccggj4+diTgO6NtU5+paSQ98=
X-Received: by 2002:a05:6808:2206:b0:33a:b472:48fd with SMTP id
 bd6-20020a056808220600b0033ab47248fdmr874798oib.44.1658886057293; Tue, 26 Jul
 2022 18:40:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Jul 2022 20:40:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAODwPW-9UPokepL_VVGuCLaWTDT7hmN9R9Z2yXABrP4g3_N4uQ@mail.gmail.com>
References: <20220726235115.1184532-1-jrosenth@chromium.org> <CAODwPW-9UPokepL_VVGuCLaWTDT7hmN9R9Z2yXABrP4g3_N4uQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 26 Jul 2022 20:40:56 -0500
Message-ID: <CAE-0n51RsN3P5hT+kApw-kPqjm_K7=7bvySWLNdQuQPnrQYZRw@mail.gmail.com>
Subject: Re: [PATCH] firmware: google: Implement vboot workbuf in sysfs
To:     Jack Rosenthal <jrosenth@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2022-07-26 17:26:41)
> Sorry, this wasn't quite what I meant. I think we should definitely
> not hardcode any details about the vboot data structure layout here.
> It's already enough of a pain to keep crossystem in sync with
> different data structure versions, we absolutely don't want to have to
> keep updating that in the kernel as well.
>
> I assume that the reason you went that route seems to have been mostly
> that the lb_cbmem_ref coreboot table entry has no size field, so you
> had to infer the size from within the data structure. Thankfully, we
> don't need to use lb_cbmem_ref for this, that's somewhat of a legacy
> entry type that we're trying to phase out where it's no longer needed
> for backwards-compatibility anyway (and in fact I think we should be
> okay to remove the vboot entry there nowadays). We also have
> lb_cbmem_entry (see
> https://review.coreboot.org/plugins/gitiles/coreboot/+/refs/heads/master/src/lib/imd_cbmem.c#222)
> that exports info about every area in CBMEM, with address, size and
> CBMEM ID. The vboot workbuffer is CBMEM ID 0x78007343.
>
> I think we should just add a general driver for lb_cbmem_entry tags
> here, that uses the "id" as (part of) the device name and contains
> node to read/write the raw bytes of the buffer. Then crossystem can
> easily find the right one for vboot, and the infrastructure may also
> come in handy for other uses (or debugging) in the future.

If there's nothing to really "drive" then a driver is overkill. Would
exposing some raw bytes in /sys/firmware/coreboot be sufficient here,
possibly under some sort of /sys/firmware/coreboot/cbmem_entries/ path?

I honestly have no idea what vboot workbuffer is though so maybe I'm
just talking nonsense. If this ends up in sysfs please document the
files in Documentation/ABI/ and include it in the patch so we know what
is being exposed in the kernel ABI.
