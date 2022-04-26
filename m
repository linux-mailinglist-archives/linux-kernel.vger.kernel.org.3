Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC50D510A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354479AbiDZUXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354931AbiDZUXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:23:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A992220EE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:20:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so17609814ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAwxeqqwR+YgP5QGHkC3buj9fMgZibJGqjxdsqdpyyM=;
        b=hSLWMEVA5RO6QTSkFF6+Qa7rMLHId3fQh7+dnYos7FARKY1sWxN8rCF7pJ4erHS9hv
         0/NQW9iE0C/Fv7RSQiG7yukE0x9kltBngKLgmTSsbyvFmpQFqQ5FOedMlUeI4u0HYNPX
         3b0IdSbKYoQfW02JNRYaEjuBHAerN7yTKRZ/RlI39S00v2hY8Ky6Rt1jnAAmFa3NOm5n
         okAfgcjiagAJ2wdqTAsYCHlDCZwZkrcroFmtwKKafBIDVN2y6H7pa0BOEgsi3FRiRZkT
         XP+dW2KBwhLl0kRXoP3rpspFdCKf9jX2MKvhyTA8G721oqyfmIJdy9V9eGz66WlUNd/s
         Ygvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAwxeqqwR+YgP5QGHkC3buj9fMgZibJGqjxdsqdpyyM=;
        b=6d0bexrd+25y1izz/0pM4wy+HwaCRZnOaANS6SwCxtLuPo/HU/d0liBkDL4LdiYAvk
         Qj0HBzi4CHJOpOCu8QCYw71pDN7qZKmaGY8jIyX9bXsgm6tx+sugE4QtUCp3+EWhkZKo
         ggzC2/i9z9sbxtl0UyRso/F2iahL1qGG3ql8QCer/l2qkVLLRLuA0UCofZ4tZh+wWfMV
         kgzV3VASmbmZ0Lel6PXPWdTOASrSbZXImJ/Vfg7+RRFbG/1Tdch3Nny985KmvqCb0rZ+
         Ct3PnpYyr8F4HQT7dCsSTeAJCoULS+nO0M/u++maMIU6iPWKHmR/Ka0Ruqc3v24cUyv6
         rNCA==
X-Gm-Message-State: AOAM530ceL1kKfwoU9QYjVu5kLh+Ow/apW/QqaohmJQ1w5F+pf9j9jXO
        RouycXvUNIlxs18VDA+6ABc=
X-Google-Smtp-Source: ABdhPJxSrCCGv1c85JrK9mU3kpYCIcVv2QZHPjYHDwo3E1OZdvmDXkxehZr2YSHnMR1TmHqk9szLUg==
X-Received: by 2002:a17:907:6095:b0:6e7:cc3f:c33d with SMTP id ht21-20020a170907609500b006e7cc3fc33dmr23143614ejc.570.1651004400502;
        Tue, 26 Apr 2022 13:20:00 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id o3-20020aa7c7c3000000b0042237eda622sm6841328eds.83.2022.04.26.13.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:19:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
Date:   Tue, 26 Apr 2022 22:19:57 +0200
Message-ID: <1790890.atdPhlSkOF@leap>
In-Reply-To: <20220426123412.51fb58780a8fe2b32c7814ce@linux-foundation.org>
References: <20220426193020.8710-1-fmdefrancesco@gmail.com> <20220426123412.51fb58780a8fe2b32c7814ce@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 26 aprile 2022 21:34:12 CEST Andrew Morton wrote:
> On Tue, 26 Apr 2022 21:30:20 +0200 "Fabio M. De Francesco"=20
<fmdefrancesco@gmail.com> wrote:
>=20
> > Add VM_BUG_ON() bounds checking to make sure that, if "offset + len>
> > PAGE_SIZE", memset() does not corrupt data in adjacent pages.
> >=20
>=20
> hm, why?  To match all the other functions in there?
>=20
> I suppose that's logical.  Or we could just delete all the other
> VM_BUG_ON()s.  Have any of them proven to be at all useful?
>=20
I am not so sure about it being so useful. I just noted that memzero_page()=
=20
is the only function of that family that is implemented with no=20
VM_BUG_ON(). I have no actual proofs of usefulness :(=20

This is why yesterday I sent an "RFC Patch" (please see =20
https://lore.kernel.org/lkml/20220424104806.25396-1-fmdefrancesco@gmail.com/

Soon after sending it I thought that VM_WARN_ON_ONCE() could have been=20
better suited, but Ira Weiny wrote to use VM_BUG_ON() for consistency.

Now I could either delete all other VM_BUG_ON() or replace them with=20
VM_WARN_ON_ONCE() (or some other macro).=20

Ah, a third solution might be to leave highmem.h as it is now :)

What do you prefer?

Thanks,

=46abio


