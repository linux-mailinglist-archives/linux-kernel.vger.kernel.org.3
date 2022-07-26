Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0516E58176B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiGZQ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiGZQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:26:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F852124B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:26:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f15so9901414edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttV5vBFo81neCUa67b9tRifIFb4vLEVioSDpa2+KStc=;
        b=bQNn/HIEV6bNqMxSkqhpn4F1zuXjz1nAKwJuWwLas4x5rbqspUs4sfKW2IrX9JC/Z8
         R8wsOZP1GmQxF2GOMGx+JO8TuOmZmJDbMl5Z0bkLy/XRtFz/ZUXZ1rGiV5qZuHHHkQrE
         +H5bBo55CttlIBNL7fMpNXlGOnttCDBoa1FwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttV5vBFo81neCUa67b9tRifIFb4vLEVioSDpa2+KStc=;
        b=OrshPow09kkKTZFfuLlg72GkfRTnMm4zB4vXczXl9nCbSKUMc/6aU4bwhG6sTfk7N6
         f0NPaSF6Zwuofbr7ZpLEBLgFTEniA/fPQYmrKBY4acExHOvz7BjLufmclOAD89/18Pco
         RIR7eAN92ABd882kZhQhTjb9ouHUAuPrCFvp4BZVn4pF8JVLQ1S3bLUmMvfTHFePdUJo
         ERG5v6VQs/sTuBUK6g4bpLVed7pcYd9gcv76hT43SuLwetZUn00VYsAJASFQWHxcfUuk
         hSV/r+BK2sSmmaHl1Wa0Bd8oWhr6S/ankSyUqHgzLVcA7V3f+43PAvkglLBOe6Fb/td0
         VfyQ==
X-Gm-Message-State: AJIora8KWeqtdtMMu1/W/Uuk/IUcS3bZtbTPaV4qiYi/KnjxYsxEfRz6
        lfXRbo15CDePzeWUTilNYRcnsl6IinjTb9Zv
X-Google-Smtp-Source: AGRyM1ubAST9mEuFYeXzd+QtDRUl7Rwy02ARRJ7cJnpPzrMWCA8ohdMtCTD5OsrAbTijACQQE0dWTg==
X-Received: by 2002:a05:6402:524f:b0:43b:ff9b:2cc0 with SMTP id t15-20020a056402524f00b0043bff9b2cc0mr11137654edd.398.1658852815417;
        Tue, 26 Jul 2022 09:26:55 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090649d700b0072b33e91f96sm6649829ejv.190.2022.07.26.09.26.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 09:26:55 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id g2so12837792wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:26:54 -0700 (PDT)
X-Received: by 2002:adf:dd91:0:b0:21e:4e97:c146 with SMTP id
 x17-20020adfdd91000000b0021e4e97c146mr11197493wrl.281.1658852814595; Tue, 26
 Jul 2022 09:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220726062436.90290-1-zhengqi.arch@bytedance.com> <621fb975-413d-a6b4-8126-0b78d5b60853@redhat.com>
In-Reply-To: <621fb975-413d-a6b4-8126-0b78d5b60853@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jul 2022 09:26:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_TrgNm6vz7=7CgZppr0UrZ9TwLyb3dgPXyG-w=a8kJQ@mail.gmail.com>
Message-ID: <CAHk-=wh_TrgNm6vz7=7CgZppr0UrZ9TwLyb3dgPXyG-w=a8kJQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix NULL pointer dereference in wp_page_reuse()
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:45 AM David Hildenbrand <david@redhat.com> wrote:
>
> >       VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
> > -     VM_BUG_ON(PageAnon(page) && !PageAnonExclusive(page));
> > +     VM_BUG_ON(page && PageAnon(page) && !PageAnonExclusive(page));
>
> Indeed, fortunately, only an issue in the VM_BUG_ON statement

Well, at least Fedora ends up enabling CONFIG_DEBUG_VM by default, so
normal people - not just VM people - can definitely see this.

> Reviewed-by: David Hildenbrand <david@redhat.com>

Applied.

                    Linus
