Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABEA510B02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355310AbiDZVOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355296AbiDZVN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:13:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC771C90E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:10:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i19so6874240eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGw1GMSb1sdzb8JrXjM5hw7tsCPcx5n6lAvLthnSZYU=;
        b=fVuWorKxwMArfubMUdtODgEyfmiOek7W75Rf7CVGnm3dpRdqZffae6/UHfyBbt+XT4
         JWgD0bNwxSqBZ2yM2ZULeEcSMxc0tW6ZpnIKffYTW2oAZjynSzoAI3ZPxHtIjwNI7jpz
         FklTjZTHKBznF23YwgzSe/92iYCpByG81a86BVVZolhXg39YbnR1wQoZrMH9jS0WRJsQ
         DjgeSUssLO1jAMhxFX3bV9FE6mFoJDRkWWwbebw2nA549SccaAuGwZVlT6u8RVZD0rDF
         CeNKOYpqyULLXLWuNqqpftWeZSY4lT9eoNrbmfOUN/75+TSXTYjVO2cMaJg579i6tOgj
         nRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGw1GMSb1sdzb8JrXjM5hw7tsCPcx5n6lAvLthnSZYU=;
        b=lwWxX3Y2N4qaxjLw3D633OHPyRJVVuj9xSnubrDRlZHXOYN6naiTf2jz60HgQuz4Nr
         sTC9BrnpP7QnEe8LZGEuhKUrG5NaFi9X0qU/HjMcZPe0F461u5XaWFFijdxf8g29PyR3
         MwP2OX/DvBbh8cUuGdh0ytTssdYwOVoaRNCqlVOFuZVFCdXrdWxT7AIC5/YVOqFGPKZV
         KnZ7YVphoCbxDXC31CI1VnDRnjnFAIhb0jDuSX5+B4CJxEGLuR+N6rtZUQnoakuzKJig
         6/mh0a47tyZ4p+/LsPwHL4XX46ewm5xfiW7HBI2g9ygBZtGTLo8+rQPK2e2VM6e4FzOE
         aKOA==
X-Gm-Message-State: AOAM533CcJiAYd5WyorC2gOxs2rZdtp7YFna/8XB5ufMKCUaY4O7fG+Z
        dMY/FdShk/MrHr68+tuv44MdUi5Ejd4=
X-Google-Smtp-Source: ABdhPJyv9YtRVZ0s5KggJH0S308hDhVO2YSo3XPG1zQ/H7D/V91qMqlii80sYMblFTVX6qTCJePXAw==
X-Received: by 2002:a17:906:d550:b0:6ec:9ff:8791 with SMTP id cr16-20020a170906d55000b006ec09ff8791mr23192272ejc.494.1651007447291;
        Tue, 26 Apr 2022 14:10:47 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ha8-20020a170906a88800b006f3bc1f1818sm922496ejb.213.2022.04.26.14.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:10:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
Date:   Tue, 26 Apr 2022 23:10:44 +0200
Message-ID: <5262074.Sb9uPGUboI@leap>
In-Reply-To: <20220426134811.63a398ea5d2212dfececfd83@linux-foundation.org>
References: <20220426193020.8710-1-fmdefrancesco@gmail.com> <1790890.atdPhlSkOF@leap> <20220426134811.63a398ea5d2212dfececfd83@linux-foundation.org>
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

On marted=C3=AC 26 aprile 2022 22:48:11 CEST Andrew Morton wrote:
> On Tue, 26 Apr 2022 22:19:57 +0200 "Fabio M. De Francesco"=20
<fmdefrancesco@gmail.com> wrote:
>=20
> > On marted=C3=AC 26 aprile 2022 21:34:12 CEST Andrew Morton wrote:
> > > On Tue, 26 Apr 2022 21:30:20 +0200 "Fabio M. De Francesco"=20
> > <fmdefrancesco@gmail.com> wrote:
> > >=20
> > > > Add VM_BUG_ON() bounds checking to make sure that, if "offset +=20
len>
> > > > PAGE_SIZE", memset() does not corrupt data in adjacent pages.
> > > >=20
> > >=20
> > > hm, why?  To match all the other functions in there?
> > >=20
> > > I suppose that's logical.  Or we could just delete all the other
> > > VM_BUG_ON()s.  Have any of them proven to be at all useful?
> > >=20
> > I am not so sure about it being so useful. I just noted that=20
memzero_page()=20
> > is the only function of that family that is implemented with no=20
> > VM_BUG_ON(). I have no actual proofs of usefulness :(=20
> >=20
> > This is why yesterday I sent an "RFC Patch" (please see =20
> > https://lore.kernel.org/lkml/20220424104806.25396-1-fmdefrancesco@gmail=
=2Ecom/
> >=20
> > Soon after sending it I thought that VM_WARN_ON_ONCE() could have been=
=20
> > better suited, but Ira Weiny wrote to use VM_BUG_ON() for consistency.
> >=20
> > Now I could either delete all other VM_BUG_ON() or replace them with=20
> > VM_WARN_ON_ONCE() (or some other macro).=20
> >=20
> > Ah, a third solution might be to leave highmem.h as it is now :)
> >=20
> > What do you prefer?
>=20
> Merge this patch as-is, I guess.  Going through and removing unuseful
> VM_BUG_ON()s is a separable activity.
>=20
Thanks!

While at this, I've just noted that you sent a confirmation which lists all=
=20
the patches of mine that are currently in your tree.

I see that you took v1 of "Extend and reorganize Highmem's documentation".=
=20
I suppose that you missed the v2 of that series at
https://lore.kernel.org/lkml/20220425162400.11334-1-fmdefrancesco@gmail.com=
/=20

Can you please check it?

Thanks,

=46abio



