Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2434D27CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiCIEPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiCIEPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:15:05 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2323B2BB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:14:03 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d187so1161646pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 20:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n2RwK9cIieKMhKrtyShZZPbFRUKXZafEsQW2DLOqgNU=;
        b=e5J+6qO9viI9tnZKacITygw6SfzgK6KtUlMYCUZs2ZHKdPyD6A3LdHoP3/6DYCIiZp
         6zwUcGrlaqknuI79kJuQZCIJzcmJ7A/2R0TL+RdMZeOrXehfcPC5I7pP1+ObjPfjhLb3
         FYZK6iH+iG+HBtAsqSbWtZsfor7v/KpUu0D2isLO9fHW00W705LNvY70twq8vuhs/KYt
         k/2AVkU3/gCcJdi4JUP3md+1kX6Jr3ujbFGzLnQUQ6jqbfQP14c3AJxYw0A08AbQO6ut
         QQcFZuXCbxkLfJS3mPH/9XfZow/zYa7cTz8pj5egF1QYlUcCPCkc4lji2T148VaMVRhV
         MyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n2RwK9cIieKMhKrtyShZZPbFRUKXZafEsQW2DLOqgNU=;
        b=brmZ+NRMYtRfL4Kmyb3WdOPMwEREK5L9KcbKGzqDIJnlm/kPk73worRrDxyhdj4hvp
         HOpcnzqmx+QTp6xnGnB+1mrNFubJ7XGgPhn/eQAjJX6BbNxaqXKmLGN1YoYxovZsRLF6
         alxh6+9mGQF9OrDTk+q1U1MkYEYWTLeTJYzeWrxzRMMkQnjIAn2lPXtVQo2wJEkWnSKs
         AgaUehKF3sI62VuVgQeULkpM3G9pirbwvGIVdkVyRQChGBW662lTSGqopJ6RtCwTiTns
         iBCUF0/XTG0otE4yDDsiYVgFzcnPYeevfZpUCLDP82wDMzpdlZDuTEdaDlN3KyWe+qkA
         wiCA==
X-Gm-Message-State: AOAM533Y+h/u3IzK/NyFTKLQL73o9wtPO/qaz7U5fQ5A5jVHHtDUkhwA
        Tsm16OCvAippT9vk8Xz/zpY=
X-Google-Smtp-Source: ABdhPJy02nsiNTVLqWhKJuGJNm96G/p/QKGuIv9pwJyXZ/R9WGji2HU/t+PO2wO9IoMVpmqusuDWlQ==
X-Received: by 2002:a65:4101:0:b0:372:1875:c19c with SMTP id w1-20020a654101000000b003721875c19cmr16618731pgp.435.1646799242995;
        Tue, 08 Mar 2022 20:14:02 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090aaf8500b001bd4c825deesm4419653pjq.43.2022.03.08.20.14.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 20:14:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] mm: reduce tlb flush range when changing vma protection
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220309025721.3051365-1-maobibo@loongson.cn>
Date:   Tue, 8 Mar 2022 20:14:01 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <87861C77-F203-40A5-814D-A3541081064E@gmail.com>
References: <20220309025721.3051365-1-maobibo@loongson.cn>
To:     Bibo Mao <maobibo@loongson.cn>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 8, 2022, at 6:57 PM, Bibo Mao <maobibo@loongson.cn> wrote:
>=20
> numa worker will periodically change vma prot with PROT_NONE, by
> default it will scan 256M vma memory size with pmd stepping size.
> If there are fewer pages changed with PROT_NONE, tlb flush is called
> with pmd size. This patch will calculate flush range for those
> pages with pte prot changed, it will reduce size for tlb flush.
>=20
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Hi Bibo,

I finally managed to make v3 of a patchiest, which I think does
something similar to what you are looking for (without introducing
yet another TLB batching mechanism).

Have a look at [1] and let me know if that would satisfy you.


[1] =
https://lore.kernel.org/linux-mm/20220309041043.302261-4-namit@vmware.com/=
T/#u

