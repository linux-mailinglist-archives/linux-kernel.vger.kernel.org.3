Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327215A6F43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiH3VkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiH3VkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:40:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F94815FE1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:40:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u18so3217158wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lg/tEfGo54uVOy47kxfnC2Ioo2LMnFA6rnTG+QKd5Tk=;
        b=Z6oOkavjVnED/mShXL5hsKZNMcoDOt4V5DtCsrOTgIy90U+X4CB9E+LkG6UwC23BOc
         5/vuWtGmsQ113awB4fdQoQfG0kmuyMWoNxkYGPu6Eg7rVUk5mCCBlaKpygTUPZcrtWaq
         jFi3kPCw2resLPwWvTatgKXTudFoIIpzraPdKefIgMeo0qcI+OPcf2HJwB4SFR2B/qyk
         vIhlJ0Y5tcLfAr1578pDlZazPYZg4g9nYC8IOv1lI6oU2YRvX1G/+leDUH/IquMTE1sc
         0Txb8CIMpowA0WMxAnJXMcv/1bVSxsgMKY1xoi2KqY1p/mGtVR5wRdvIuyND/uSQT1MI
         FS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lg/tEfGo54uVOy47kxfnC2Ioo2LMnFA6rnTG+QKd5Tk=;
        b=Pu0ezF18Okm7M5rJ/RACBKHTGaE2xxsn266bCad4sT7uRzPosLO7C+E9PB+B+p0erB
         hmFK7cr0YwIS5TOH+k+jnNxivjZC0qr7m+szvAca1cqTwRcdacwSZY2u+qcyGEMJTka5
         l1X8DxHc/NqaHdk0go6Y+dDNf0gAd/+GNXY389HvLokfs/hYAmWp78W6ASs1Db5kaTD0
         DuiSIUmwOUZfVPQDXgaL+Mtg1H4afiZvU9gcPzFuG7fO5hIZGKF7C9n6OsxRXwCw0oCL
         /yfFx8P+Yrryc4pUgjop0KWd+UxOvF86eM3hMbxlHUOO5y99xHnNMkdBCuRx5DJLfSY2
         6Jsw==
X-Gm-Message-State: ACgBeo2r+sEJACGteqd8VmzJFFywy9ShPe1kmrV2YWtE92BcVofNGTzO
        LIeR8wAxQ3C29njQv02rYPaVTkGMlhU=
X-Google-Smtp-Source: AA6agR5qQEilqp0MGt8d2vaiFLEH6jOxbq9ogp7W20gYy2g4K66xtD5zzz1R6CZVYoC79f2ABR/HGA==
X-Received: by 2002:adf:e583:0:b0:226:db76:ab6d with SMTP id l3-20020adfe583000000b00226db76ab6dmr6615942wrm.198.1661895613520;
        Tue, 30 Aug 2022 14:40:13 -0700 (PDT)
Received: from opensuse.localnet (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d4a05000000b00225213fd4a9sm10841293wrq.33.2022.08.30.14.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:40:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Venkataramanan Anirudh <anirudh.venkataramanan@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] nvmet-tcp: Don't map pages which can't come from HIGHMEM
Date:   Tue, 30 Aug 2022 23:40:09 +0200
Message-ID: <5295597.Sb9uPGUboI@opensuse>
In-Reply-To: <20220829075401.868981-1-sagi@grimberg.me>
References: <20220829075401.868981-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 29 agosto 2022 09:54:01 CEST Sagi Grimberg wrote:
> From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
>=20
> kmap() is being deprecated in favor of kmap_local_page().[1]
>=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>=20
> The pages which will be mapped are allocated in nvmet_tcp_map_data(),
> using the GFP_KERNEL flag. This assures that they cannot come from
> HIGHMEM. This imply that a straight page_address() can replace the kmap()
> of sg_page(sg) in nvmet_tcp_map_pdu_iovec(). As a side effect, we might
> also delete the field "nr_mapped" from struct "nvmet_tcp_cmd" because,
> after removing the kmap() calls, there would be no longer any need of it.
>=20
> In addition, there is no reason to use a kvec for the command receive
> data buffers iovec, use a bio_vec instead and let iov_iter handle the
> buffer mapping and data copy.
>=20
> Test with blktests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
>=20
> [1] "[PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
> list" https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel=
=2Ecom/
>=20
> Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> [sagi: added bio_vec plus minor naming changes]
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/target/tcp.c | 44 ++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 31 deletions(-)

Hi Sagi,

Thanks for changing the code according to the suggestions from Christoph an=
d=20
Al.

Differently from what I just wrote while thanking Al, and after Ira made me=
=20
notice that you are one of the maintainers, I decided to leave everything l=
ike=20
you did.

The only exceptions we'll be about sending a v2 with the "Suggested-by" tag=
s=20
from Christoph and Al. In the meantime checkpatch warned that the alignment=
 of=20
"nr_pages" doesn't match the open parenthesis, so I'm changing it too.

Again thanks,

=46abio



