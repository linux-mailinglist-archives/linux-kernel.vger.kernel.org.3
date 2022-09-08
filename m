Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCAD5B24A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiIHRa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiIHRaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:30:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB0DBF36E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:28:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pj10so8046079pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bfLbaRY3OEI6NIyVDG7lfBiHKdWozSjwE3PfT7WX9HA=;
        b=UxJEIbohV0qzVhZT0mVn+cgfss2A2jRc4w9+kHkJ3AUSa+YbC2kfGSPUTNXy6w/Qw0
         M0o4GlG6/UUE9UPiBID4gLI30q+zJKH3P4v0ZzjDCMeQcEeccRYBu0/20o//dtryB1eV
         yklbRveRfuLzFI9+S2PUvGQOsq6WSYtZBHJUrSXIMMarbQIxiOsnjbpbjynKBdAULxJs
         rIWQ3VoSambpb1t27x3+ZnxcSUNeJysw5dyJ3soMGjybxuAFMZZOw+q8Wy24Co4xGVjG
         KrQd/vBWvCTGal67dIeHzJJNPZrEoR1qiQSgbSG1CYbOPolphFVm7ofsNsCIcLAbarKe
         +pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bfLbaRY3OEI6NIyVDG7lfBiHKdWozSjwE3PfT7WX9HA=;
        b=W85XQBND0q2OybzYsPgkhZwHPyD+Rrxlh6EsyS3NkQ9cwJpY1XEd5ALafQIAvj6w7F
         VBco3hj3/mI9I2gm8UdwtPQbI+cW0B7pFSURezLB177sPauHVv7u396nXsyV8woCumq1
         aHxZCu86+wrfrgraH+CFZBlMM/SmdqQcPVEEcuTeStpiF8oRcZyOVV71K18PqAl3AgFw
         ll7ivetDZ1KIY8OL3z8SnmaJsau3avUyCl7ykGi6SwklVDaQkc/XRO3Aq8KSQgDuAZex
         9E88WDZ1yFedY0HqurLwGI8lUQ+kmaj5PB/TC7vznM94+8ng43wcpz3JlhF8HTxzm6zZ
         SpaA==
X-Gm-Message-State: ACgBeo1XhvM7vC9Pl50FaNK/oixXEa+6K8p0dbqQyhMSAqJZREuNuEN6
        O3tx1BzcKXSTUQGfrZFUtQ8SFUV1b+887gs6WFg=
X-Google-Smtp-Source: AA6agR5NfjEu0ZKKTdhGPdz2qkt7hcXVSqhGJGTTdQqoE7AG6+x07aftcoV6YzNHbiXgQpFqLW9WDnoworbRbiFOLMQ=
X-Received: by 2002:a17:90b:1bc7:b0:202:52ce:a1d with SMTP id
 oa7-20020a17090b1bc700b0020252ce0a1dmr5308453pjb.110.1662658115376; Thu, 08
 Sep 2022 10:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220908170133.1159747-1-abrestic@rivosinc.com> <CANaf2scedFxwDwBYNwk-9Y_p4O7Sc62FFjZPptdZeAs4H4JGiQ@mail.gmail.com>
In-Reply-To: <CANaf2scedFxwDwBYNwk-9Y_p4O7Sc62FFjZPptdZeAs4H4JGiQ@mail.gmail.com>
From:   SS JieJi <c141028@gmail.com>
Date:   Fri, 9 Sep 2022 01:28:24 +0800
Message-ID: <CANaf2scD5QtgZuAXru5=uaZOkAQ_seHbJO0YKmT07DCTDLwKQw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Allow PROT_WRITE-only mmap()
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> https://fars.ee/1sPb, showing *inconsistent* read results on -r- pages
> before/after a write attempt performed by the kernel.

That said, maybe prohibit mmap-ing -w- pages is not the best fix for
this issue. If -w- pages are irreplaceable for some use cases (and
hence need to be allowed), I'd suggest at least we need to re-fix the
read result inconsistency issue somewhere else despite simply
reverting the patch.

Yours, Pan Ruizhe
