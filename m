Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF4158E312
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiHIWRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiHIWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:16:44 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F418D27B00
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:16:35 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l8so4957287qvr.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LwT+AEAk7mZV8lHHB00sp9fZBT8AmzQ2N9+/NKLsea4=;
        b=Et4MXaReXplB3KkhQOKNcBhJZxwvClvL3gXrdMoRW+0B1QTMFrbx677BZ8eTvmzrwl
         v7L4hxBpQL+JcKTCtoeDwLd7FWT/7hEGodffs14PrwDE/p+2wrlSP6EdwSyBcNKOeUCB
         mwH56fKAtzbG+IgFZNCWlUrgCW+YSdWfiopK9KG8rDGtxuOdUVsz45LK2uELPTHKKC1y
         VmF7hvQhB4wr0QdebYz2eezVssBD4Hq13GnOb/yn3GWx6h9WR6Wv7J7LfHsIZdxuS/FO
         xd2z2N9kl2zZRe+OzJWDfMwYZJG8HSSQ4rgV5XJiP4QuxeRfc5GMoqMmfR+nj0EmjKR7
         lBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LwT+AEAk7mZV8lHHB00sp9fZBT8AmzQ2N9+/NKLsea4=;
        b=CjVI6SGqJZ/ciZbHBVXswcQR0i4jAopWBPJkJ+QyDPljBg/V/n5d0TTFP1qJUqQ/xZ
         JVWaI0kUN6FsxSfoRmWzzE1e7HySWMX31WjUYzueXs9K7FInFabnvHIxAs01DzCRJdh2
         D7+KIdZII8aAsx3diokmmlDp2fYrEHXfFxsObUcTnVTM4eElU19xpcwYxM5T4EMqAR7C
         P0Tlo/jfsu58o35pK6+4vetLPKSeJSmcpVwh7wL9Wx+iiF8lGxfq/IVy5pmNmlMUksBk
         973U4OJoLdlpIdNL6B12jWhrKXWZR98Er93X/Lf1W11lu39PcsVSv25MWdPqLtfroqXm
         y8Pw==
X-Gm-Message-State: ACgBeo3oe05MexXoe983dAAbNRONmkyahdcIcRotcr3a95IpdaWDqWeS
        CJMYvMu3moMWZc3PuQS3d0TvYQ==
X-Google-Smtp-Source: AA6agR7vr5wFQdgkTKJuPIsq9tI1T4jj/DyT28obhLhVbrAddU5mXO8Aml3nBY90+wolp/4KIe6AJw==
X-Received: by 2002:ad4:5bc2:0:b0:476:a281:5330 with SMTP id t2-20020ad45bc2000000b00476a2815330mr22348838qvt.24.1660083395113;
        Tue, 09 Aug 2022 15:16:35 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:b19b:cbb5:a678:767c])
        by smtp.gmail.com with ESMTPSA id o4-20020ac841c4000000b00342fd6d6dd3sm3791677qtm.42.2022.08.09.15.16.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 15:16:33 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/4] hfsplus: Unmap the page in the "fail_page" label
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20220809203105.26183-2-fmdefrancesco@gmail.com>
Date:   Tue, 9 Aug 2022 15:16:29 -0700
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F9CF812-32DB-4A2F-B81A-D5382039FD56@dubeyko.com>
References: <20220809203105.26183-1-fmdefrancesco@gmail.com>
 <20220809203105.26183-2-fmdefrancesco@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 9, 2022, at 1:31 PM, Fabio M. De Francesco =
<fmdefrancesco@gmail.com> wrote:
>=20
> Several paths within hfs_btree_open() jump to the "fail_page" label
> where put_page() is called while the page is still mapped.
>=20
> Call kunmap() to unmap the page soon before put_page().
>=20
> Cc: Viacheslav Dubeyko <slava@dubeyko.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> fs/hfsplus/btree.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 66774f4cb4fd..3a917a9a4edd 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -245,6 +245,7 @@ struct hfs_btree *hfs_btree_open(struct =
super_block *sb, u32 id)
> 	return tree;
>=20
>  fail_page:
> +	kunmap(page);
> 	put_page(page);
>  free_inode:
> 	tree->inode->i_mapping->a_ops =3D &hfsplus_aops;
> --=20
> 2.37.1
>=20

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


