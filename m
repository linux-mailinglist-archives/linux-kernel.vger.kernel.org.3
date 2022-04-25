Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3450DB2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiDYIby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiDYIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:31:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EE5DF91
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:28:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu29so24891877lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jwOMe0PYx7m3rTeqaWcpjbZkR+dZWgzgcwhEumSydo=;
        b=bWixug3Y4hVwOtAhfB47bgvZ8eP8IeA5kMCtmIlTL31LalsQbbNK+U9/17OYg1T/8Z
         Tp+yRPQGuw3a5QHcaX8eMs3HaudIkxOR8KHQQhaR4FUBTySPHjEM7n4Sa1BMw2S5Foki
         Gede7EwfU9IpLZWmT2v5pa74fzXl+BvSAjJ1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jwOMe0PYx7m3rTeqaWcpjbZkR+dZWgzgcwhEumSydo=;
        b=hZ8/J33HIcoJ0p8QAuAi3U/LvIBp3QgztaQse4GR76qu5MjlkXZHBAQjsl7gM2dlwN
         1crRAnyfed+thFlq5DhbS0YQMAQJ2y3YwPvRPyjwVnK7W6A7yJo31x6Evyst626ENLLL
         ymmWqVIBjIkJTyWwJSNZ+x8JX0vG+R2n6rd6f9y2jQARiAaNOxKomZkVs7hjy3oYMHXp
         tN4SjIbRzfpovnyIQaksxWEc+9v7OJlvzedsYg3jHexqxuQ3/phSjjo0rYj+ryIkAUdv
         HDZOCXeqZvNZDSY0m8m6Vnwk0LzI9+WE9RIoE1zY9hip0065h/UkYox2FjdNVtpI9HCJ
         Lolg==
X-Gm-Message-State: AOAM533Aig53CuCBqrNY+YdSrHKZdoCB2rhJDc/4tUatICAZu/A7eY5O
        nS52oTGGDAPNA7PedMKY3pzOWtTFHbrnk/WBxGY=
X-Google-Smtp-Source: ABdhPJyoqhNp7z0w1WA/Fm1sPkVklUIGpiAbHN+ZEv6gfFggorejaquusOx4cJ2j6TjWZzYWicIbYw==
X-Received: by 2002:a05:6512:e8f:b0:44a:bf22:89c8 with SMTP id bi15-20020a0565120e8f00b0044abf2289c8mr12304818lfb.323.1650875299198;
        Mon, 25 Apr 2022 01:28:19 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u29-20020ac25bdd000000b004720c866dd0sm171500lfn.87.2022.04.25.01.28.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:28:18 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id p12so19276087lfs.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:28:17 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr12311172lfv.27.1650875297704; Mon, 25
 Apr 2022 01:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYscb1y4a17Sf5G_Aibt+WuSf-ks_Qjw9tYFy=A4sjCEug@mail.gmail.com>
In-Reply-To: <CA+G9fYscb1y4a17Sf5G_Aibt+WuSf-ks_Qjw9tYFy=A4sjCEug@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Apr 2022 01:28:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ9H_Cama8RNyqNbPB5ydFy4P319JUcz9E27GyZ1xqdw@mail.gmail.com>
Message-ID: <CAHk-=wgZ9H_Cama8RNyqNbPB5ydFy4P319JUcz9E27GyZ1xqdw@mail.gmail.com>
Subject: Re: page_alloc.c:(.init.text+0xa7c): undefined reference to `vmalloc_huge'
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Song Liu <song@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Christoph Hellwig <hch@lst.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="000000000000b05d1505dd765b4f"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b05d1505dd765b4f
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 25, 2022 at 1:10 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> # CONFIG_MMU is not set

I just sent the stupid and straightforward patch in

  https://lore.kernel.org/all/CAHk-=wi5DYKbFE4j-jC2HGsKVuf1RpZbEiYt4tSXuxGKiN9oJg@mail.gmail.com/

but then I thought maybe the alias patch is as simple as the attached.

So does either (or both) of these patches work?

                  Linus

--000000000000b05d1505dd765b4f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l2egiimz0>
X-Attachment-Id: f_l2egiimz0

IG1tL25vbW11LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvbW0vbm9tbXUuYyBiL21tL25vbW11LmMKaW5kZXggNTVhOWU0OGE3YTAyLi45ZDdh
ZmMyZDk1OWUgMTAwNjQ0Ci0tLSBhL21tL25vbW11LmMKKysrIGIvbW0vbm9tbXUuYwpAQCAtMjI2
LDYgKzIyNiw4IEBAIHZvaWQgKnZtYWxsb2ModW5zaWduZWQgbG9uZyBzaXplKQogfQogRVhQT1JU
X1NZTUJPTCh2bWFsbG9jKTsKIAordm9pZCAqdm1hbGxvY19odWdlKHVuc2lnbmVkIGxvbmcgc2l6
ZSwgZ2ZwX3QgZ2ZwX21hc2spIF9fd2VhayBfX2FsaWFzKF9fdm1hbGxvYyk7CisKIC8qCiAgKgl2
emFsbG9jIC0gYWxsb2NhdGUgdmlydHVhbGx5IGNvbnRpZ3VvdXMgbWVtb3J5IHdpdGggemVybyBm
aWxsCiAgKgo=
--000000000000b05d1505dd765b4f--
