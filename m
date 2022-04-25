Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27EC50DAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiDYIVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiDYIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:21:24 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9F29C9C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:18:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 4so3300299ljw.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gf4qna+chgdqKRpP/Wa5zsGXxEnC9UfbtEiM/gls+m0=;
        b=Aml0zD/fxPnfqRhWfiNo69LwKx2/KRsDrIss9R5tS0Ba7quxETTRhXIyWpj4qhK09T
         Gt2fpu8LSyw0qXIyi384DNEtzxsABGGLhu4D3ZrRWYZkwVDzZaz5+/BzVYa3S302X1yY
         yYRDLXxGnGeSi1OfZ5tLmVptCJpEd526sjy/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gf4qna+chgdqKRpP/Wa5zsGXxEnC9UfbtEiM/gls+m0=;
        b=T8ZrYgJEkK3XNkVIFLcnvvY2esVVt7u1QJMJGkO0Ez13hRScwwfrfS3fo/vXaxPuD/
         JaRd5RzLOt5FsjCD/ERXWV7WjiS0m0qXhEvs++/Qrxiw0EAJmLOKqDISvKLBuNDV74PR
         pcCncCSUmn+H7xsqksVPknnnzWFinqi40TEtoGUWFA49qTBOnX1CKxeX3v28GaaZV+Yx
         VtFxew4gbtbCb/4OI02wkjkDIlxJAsRW3P7+TfmDJRDqHBxxaJ27+0M2srP8JhtRiIMb
         UD/ywAWz8FHyHffKmDn0TD7ZiUlyfy+k+bWKutMvCvcmZ4/mKwEDQehn4bVKiNSiw8j6
         ex9A==
X-Gm-Message-State: AOAM533LNBrjqMYaUyvn4DgVgaAm9beeDdzKCYTrsBLCRkysRVxamfzL
        U9hXQ2sBoxksy88vCU1pzQzEA5dwpjZQmfF9e9o=
X-Google-Smtp-Source: ABdhPJxujWdXt95DKaZWjJj1WuFBkAk+Awq63k2o3YIkirTaYGT4hKinfK2vUZloZRXWHQvc/9l+Pg==
X-Received: by 2002:a05:651c:2122:b0:24d:b9b4:aae5 with SMTP id a34-20020a05651c212200b0024db9b4aae5mr10552024ljq.157.1650874698088;
        Mon, 25 Apr 2022 01:18:18 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id bq8-20020a056512150800b00448ab58bd53sm1332923lfb.40.2022.04.25.01.18.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:18:14 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id l19so4239744ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:18:13 -0700 (PDT)
X-Received: by 2002:a2e:934b:0:b0:24f:cce:5501 with SMTP id
 m11-20020a2e934b000000b0024f0cce5501mr4447272ljh.443.1650874693427; Mon, 25
 Apr 2022 01:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <20220415164413.2727220-3-song@kernel.org>
 <5e5e4759efef83250f9511d4ab0e1ba34f987ce5.camel@fb.com> <CAMuHMdVdx2V1uhv_152Sw3_z2xE0spiaWp1d6Ko8-rYmAxUBAg@mail.gmail.com>
In-Reply-To: <CAMuHMdVdx2V1uhv_152Sw3_z2xE0spiaWp1d6Ko8-rYmAxUBAg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Apr 2022 01:17:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5DYKbFE4j-jC2HGsKVuf1RpZbEiYt4tSXuxGKiN9oJg@mail.gmail.com>
Message-ID: <CAHk-=wi5DYKbFE4j-jC2HGsKVuf1RpZbEiYt4tSXuxGKiN9oJg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 2/4] page_alloc: use vmalloc_huge for large system hash
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "song@kernel.org" <song@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Rik van Riel <riel@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "hch@lst.de" <hch@lst.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Content-Type: multipart/mixed; boundary="000000000000abeec805dd7637e2"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000abeec805dd7637e2
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 25, 2022 at 12:07 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> vmalloc_huge() is provided by mm/vmalloc.c, which is not
> compiled if CONFIG_MMU=n.

Well, that's annoying.

Does this trivial patch fix it for you?

I get this feeling that this could be done better with a weak alias to
__vmalloc(), and that could take care of the "arch doesn't support
VMAP_HUGE" case too, but the attached is the stupid and
straightforward version.

                  Linus

--000000000000abeec805dd7637e2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l2efx5810>
X-Attachment-Id: f_l2efx5810

IG1tL25vbW11LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvbW0vbm9tbXUuYyBiL21tL25vbW11LmMKaW5kZXggNTVhOWU0OGE3YTAyLi4y
YTY1NWVkNTY2NDQgMTAwNjQ0Ci0tLSBhL21tL25vbW11LmMKKysrIGIvbW0vbm9tbXUuYwpAQCAt
MjI2LDYgKzIyNiwxMSBAQCB2b2lkICp2bWFsbG9jKHVuc2lnbmVkIGxvbmcgc2l6ZSkKIH0KIEVY
UE9SVF9TWU1CT0wodm1hbGxvYyk7CiAKK3ZvaWQgKnZtYWxsb2NfaHVnZSh1bnNpZ25lZCBsb25n
IHNpemUsIGdmcF90IGdmcF9tYXNrKQoreworCXJldHVybiBfX3ZtYWxsb2Moc2l6ZSwgZ2ZwX21h
c2spOworfQorCiAvKgogICoJdnphbGxvYyAtIGFsbG9jYXRlIHZpcnR1YWxseSBjb250aWd1b3Vz
IG1lbW9yeSB3aXRoIHplcm8gZmlsbAogICoK
--000000000000abeec805dd7637e2--
