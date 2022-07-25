Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B591A580370
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiGYRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiGYRRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:17:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D51ADA0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:17:20 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l9-20020a056830268900b006054381dd35so9172326otu.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eL2xRVgOKUKmpeDr+ye9Ri8ghs0kUi231r2vO8s5QTI=;
        b=HqOGNKuh9UjoA3KqMsi4sgwjIiqMNEp7ViMRolZFcm0skyrs/0fv7ibsB5iSaMGOUd
         QAd/Jgj2OghlFzr35Lpd2xEbucsTpkVskvlQVnK85yPrEU5dBACad/V4ybkzrcNMrzWz
         6/LYJn4FXHc0kOFALzFawvLC2czaby16WLTZVo6fs5dBrGXTSt6uc7/hhAmqscDPAd76
         12MkiOrFj7bZtHQh2J+jpOBXW4omhhk7W6W9vCakSM2waO9pW4nmefNDUHLgsGox6POI
         HB32aJ7i6/jpG9FvHPYJ55CXc73FLYpyCbiov09Qg8DaBWGiEWSIYcbh9iRI83yJ+aFH
         ubWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eL2xRVgOKUKmpeDr+ye9Ri8ghs0kUi231r2vO8s5QTI=;
        b=TQ7ninzYalADTjTghYPb2nd5L3qrb8j9JLS3UBt6CHNjY0SjBAgozwrDLg5QuOhmTt
         BnIcEcaQ1PO2iO2M7G5ZIZHyOG6hTY2qXOm74gk+DA9skbjAMZRbMvzsOgduDFvejHgP
         1IBwvexMr0kwYZes/FcquaqxAeFEa0zV9pO/ztdNjwtehEX5V/8lXq8GC1aL0gCTIsOv
         mImKRfVldtjGD3+v0gXjJDylrcCAWULO4WS5BhzG+beUMHzJlyx7wVP2RcZK3oWxoPIx
         H0h6VFjumtG/CLMCVJYhH0Cz0RG41wkKwE5xB6u2pEjyUWODebwDNdpGvn720RDUaXoK
         HPUg==
X-Gm-Message-State: AJIora8JZSviDgSZcCbj829PqPTQpmE/3QGd+LRcf3T2ApvOPMmgpmZ1
        fTXMklBtetFTxxgae/fKgJ1X5g==
X-Google-Smtp-Source: AGRyM1tJMTAGKHUY7aX05hNL3la6HYs0t/QP9F9rkoXus7juxlpDN3oRs+6QZ5w3uVikT6Bz9CN2pA==
X-Received: by 2002:a9d:4547:0:b0:61c:7217:24bc with SMTP id p7-20020a9d4547000000b0061c721724bcmr5358756oti.48.1658769439771;
        Mon, 25 Jul 2022 10:17:19 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:f58b:5af2:526d:b883])
        by smtp.gmail.com with ESMTPSA id s30-20020a056870611e00b0010d04a20030sm6186302oae.36.2022.07.25.10.17.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 10:17:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20220724205007.11765-1-fmdefrancesco@gmail.com>
Date:   Mon, 25 Jul 2022 10:17:13 -0700
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2FB0201-8342-481B-A60C-32A2B0494D33@dubeyko.com>
References: <20220724205007.11765-1-fmdefrancesco@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 24, 2022, at 1:50 PM, Fabio M. De Francesco =
<fmdefrancesco@gmail.com> wrote:
>=20
> kmap() is being deprecated in favor of kmap_local_page().
>=20
> There are two main problems with kmap(): (1) It comes with an overhead =
as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when =
the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can =
take
> page faults, and can be called from any context (including =
interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, =
the
> kernel virtual addresses are restored and are still valid.
>=20
> Since its use in bitmap.c is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in bnode.c.
>=20

Looks good. Maybe, it makes sense to combine all kmap() related =
modifications in HFS+ into
one patchset?

Reviewed by: Viacheslav Dubeyko <slava@dubeyko.com>=20

Thanks,
Slava.

> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> fs/hfsplus/bitmap.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
> index cebce0cfe340..0848b053b365 100644
> --- a/fs/hfsplus/bitmap.c
> +++ b/fs/hfsplus/bitmap.c
> @@ -39,7 +39,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> 		start =3D size;
> 		goto out;
> 	}
> -	pptr =3D kmap(page);
> +	pptr =3D kmap_local_page(page);
> 	curr =3D pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
> 	i =3D offset % 32;
> 	offset &=3D ~(PAGE_CACHE_BITS - 1);
> @@ -74,7 +74,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> 			}
> 			curr++;
> 		}
> -		kunmap(page);
> +		kunmap_local(pptr);
> 		offset +=3D PAGE_CACHE_BITS;
> 		if (offset >=3D size)
> 			break;
> @@ -127,7 +127,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> 			len -=3D 32;
> 		}
> 		set_page_dirty(page);
> -		kunmap(page);
> +		kunmap_local(pptr);
> 		offset +=3D PAGE_CACHE_BITS;
> 		page =3D read_mapping_page(mapping, offset / =
PAGE_CACHE_BITS,
> 					 NULL);
> @@ -135,7 +135,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> 			start =3D size;
> 			goto out;
> 		}
> -		pptr =3D kmap(page);
> +		pptr =3D kmap_local_page(page);
> 		curr =3D pptr;
> 		end =3D pptr + PAGE_CACHE_BITS / 32;
> 	}
> @@ -151,7 +151,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> done:
> 	*curr =3D cpu_to_be32(n);
> 	set_page_dirty(page);
> -	kunmap(page);
> +	kunmap_local(pptr);
> 	*max =3D offset + (curr - pptr) * 32 + i - start;
> 	sbi->free_blocks -=3D *max;
> 	hfsplus_mark_mdb_dirty(sb);
> @@ -185,7 +185,7 @@ int hfsplus_block_free(struct super_block *sb, u32 =
offset, u32 count)
> 	page =3D read_mapping_page(mapping, pnr, NULL);
> 	if (IS_ERR(page))
> 		goto kaboom;
> -	pptr =3D kmap(page);
> +	pptr =3D kmap_local_page(page);
> 	curr =3D pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
> 	end =3D pptr + PAGE_CACHE_BITS / 32;
> 	len =3D count;
> @@ -215,11 +215,11 @@ int hfsplus_block_free(struct super_block *sb, =
u32 offset, u32 count)
> 		if (!count)
> 			break;
> 		set_page_dirty(page);
> -		kunmap(page);
> +		kunmap_local(pptr);
> 		page =3D read_mapping_page(mapping, ++pnr, NULL);
> 		if (IS_ERR(page))
> 			goto kaboom;
> -		pptr =3D kmap(page);
> +		pptr =3D kmap_local_page(page);
> 		curr =3D pptr;
> 		end =3D pptr + PAGE_CACHE_BITS / 32;
> 	}
> @@ -231,7 +231,7 @@ int hfsplus_block_free(struct super_block *sb, u32 =
offset, u32 count)
> 	}
> out:
> 	set_page_dirty(page);
> -	kunmap(page);
> +	kunmap_local(pptr);
> 	sbi->free_blocks +=3D len;
> 	hfsplus_mark_mdb_dirty(sb);
> 	mutex_unlock(&sbi->alloc_mutex);
> --=20
> 2.37.1
>=20

