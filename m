Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E361A4CC829
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiCCVgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiCCVgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:36:44 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC216FDD9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:35:59 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p17so5933834plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 13:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mTTQbV2A2vstkO2kh5RQpGJLvdRtPFWdqW179J6hNJ0=;
        b=N0Hu/qem+pyMDDz2i8akwdkI4o0ab5wiaqXHx0jVz8DekzDFJJGKCRQh9OzA8XMX+h
         gmZ1SbI4TvAiqXEdoRbtS21W9hIOgHzQKi2Dbvkfbf83YeFsb5H4IQswCLbgbo9P0wg0
         Sb45Ip01tIdIB6zxEYBtv29Tf7VEYsuPCETkD5wrZt09QwMEXceBkvR3WAzUnfsQYp63
         GWU0E/r+PovlZQjGUuQsjGLyAh6YJkuPB4XmvgitREtgMLbKEy6EVKB8CfEg9iIYi59E
         RLaHzAzuN7Cg5+vQznojiovQNSR3CrW8Xt6p0DJnY9XqFDx29JyvX1AWhJzBaqu1h+/c
         rQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mTTQbV2A2vstkO2kh5RQpGJLvdRtPFWdqW179J6hNJ0=;
        b=oDBzjxHPANXHSyLZSBIhbEgZ/uEKIExbfEX0s/3FhlJmb4SxhJrYbUmPXQBErOGe5h
         JSuyRhHpkDkZjR/TqIi67uzW9oF8JjaGx3VNuhg8uYAoCxMFoQzsr60oXrfpbOBZAjCR
         3Ae5ZD2Roz4a0ZOpQ1x/4PAqYJ0aeQQiaqdRTf3zBLCMrkui+7YU+LQ8K/4UiW9wB/YP
         IhAvHQXfuP0IpMLdNbFVd5GrUtNhbdSwc2iNtbktnYAlEgMOFoK2wNohShyadsnPptzy
         N4s3BcK4dxNa1TpYK/46rodarxgt1cLuJ2KAPiKe4wPOl6luXXBwVVsu8hyODeBAsOm1
         H07w==
X-Gm-Message-State: AOAM531X2KWE+JBMcjt9gEK3nC+wrZu++kZvANr9iPyOG9qAoqz199c7
        cCr+XTfw5NtUkbfyRkzGBwnXoxNc05g=
X-Google-Smtp-Source: ABdhPJxeEj71FVOkpuYaEuAffExNYk8JYhq8TPI0C0rV51GW4k3JxXIM0Wc66BertAkOp9bnEhGOsQ==
X-Received: by 2002:a17:902:7b8d:b0:14f:1aca:d95e with SMTP id w13-20020a1709027b8d00b0014f1acad95emr37928815pll.122.1646343358520;
        Thu, 03 Mar 2022 13:35:58 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id lr11-20020a17090b4b8b00b001bc4098fa78sm3115724pjb.24.2022.03.03.13.35.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2022 13:35:58 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220303212956.229409-1-hannes@cmpxchg.org>
Date:   Thu, 3 Mar 2022 13:35:56 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5A8E655-0CE6-4F27-85FD-E99726776EAC@gmail.com>
References: <20220303212956.229409-1-hannes@cmpxchg.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
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



> On Mar 3, 2022, at 1:29 PM, Johannes Weiner <hannes@cmpxchg.org> =
wrote:
>=20
> MADV_DONTNEED historically rejects mlocked ranges, but with
> MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
> there are valid use cases for depopulating locked ranges as well.

...

> @@ -850,7 +858,7 @@ static long madvise_dontneed_free(struct =
vm_area_struct *vma,
> 		VM_WARN_ON(start >=3D end);
> 	}
>=20
> -	if (behavior =3D=3D MADV_DONTNEED)
> +	if (behavior =3D=3D MADV_DONTNEED || behavior =3D=3D =
MADV_DONTNEED_LOCKED)
> 		return madvise_dontneed_single_vma(vma, start, end);
> 	else if (behavior =3D=3D MADV_FREE)
> 		return madvise_free_single_vma(vma, start, end);
> @@ -988,6 +996,7 @@ static int madvise_vma_behavior(struct =
vm_area_struct *vma,
> 		return madvise_pageout(vma, prev, start, end);
> 	case MADV_FREE:
> 	case MADV_DONTNEED:
> +	case MADV_DONTNEED_LOCKED:
> 		return madvise_dontneed_free(vma, prev, start, end, =
behavior);
> 	case MADV_POPULATE_READ:
> 	case MADV_POPULATE_WRITE:
> @@ -1113,6 +1122,7 @@ madvise_behavior_valid(int behavior)
> 	case MADV_REMOVE:
> 	case MADV_WILLNEED:
> 	case MADV_DONTNEED:
> +	case MADV_DONTNEED_LOCKED:
> 	case MADV_FREE:
> 	case MADV_COLD:
> 	case MADV_PAGEOUT:

Don=E2=80=99t you want to change madvise_need_mmap_write() as well and =
add
MADV_DONTNEED_LOCKED there too?

