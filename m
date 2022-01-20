Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C09495336
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiATR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:28:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:38521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232295AbiATR2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642699710;
        bh=UHhjAWf/9pVz8wScRWDow/ubaju2WM3ooNGJadQmmyw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=LRdm3g8HDi1CpAlqU42nsOWO6j9clZ6kil00zIf/i1lpPN3Z/0H7FCDwmtUKgP+mQ
         jaQlQhla/9hR9yZRmHoO0dCdhtdm/Bgefyv/trfyYxU78gsUy6jeccJvPBDN9bkPYL
         kAmBt7tDgWUG0Ta9d7UPMw8V0W4H58k+a23Ie/zU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.166.9]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1n8wH13hMY-002l7u; Thu, 20
 Jan 2022 18:28:29 +0100
Message-ID: <cb82c739-b496-670a-13dd-0f1a37c085f8@gmx.de>
Date:   Thu, 20 Jan 2022 18:27:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] parisc: pdc_stable: Fix memory leak in
 pdcs_register_pathentries
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220120121812.14943-1-linmq006@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220120121812.14943-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sN32WROnKtNl1RxHyC+SOF3Teld739cwnAAnkP9wfgeaXxFUhhc
 HiVZdhTDHPpKkVLSErcERtsnVHvlqkiK9tL/R+7eyeCgnBVQBQffCv1Eo/0wbTiqVMtfWQ4
 v/QHvC+xmOVTDRc98iy4+LfQtJcscKyGh1PFnUdQHE0iMhKbFA3OzJ8KjwyI8W9Au5odEgU
 1CfY2OvnxV5dv90XCXqGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Ox+WbnmG2g=:GiURZDMCA/lNYj9F43Y0Bw
 15dvZ1c90M8rfDJtwSdcZJ1UzYxt3UMCHu3SUlKoxROXz+l5GJWPOeAHWR83JgPebRBdaw45w
 T39mXwOWD5znid5BhWGbaOsgE+RLzKBSTzlXI3oBStWiOvaZfpzC30LJV71yP/vcACTtUPYfs
 d/x+QFqnqGiolIiTVaaG7ZADaMZEPGBiQKXpW4onk+Rb+7Sf6YWIfZY9W+gdGMgh46KmmSHvm
 VzaYc2mXmA20IKvNuDE/QW+d1Tnh9vikMpgToEpSv5fMPt8FTnK/KY3zjWZb+BWCRn4TZglQX
 cgAZDd97UX+3tSNOIJ23EyWDy5xVkFxEUS2mFOgM+Lw/mHXM0AyAgY7X0WdeD/p0+R2gMGtQ4
 5S76G+QbbSR+XFS8alBkYYJKDmY0PGXwey6DuIYffPQoSPEVNkVLLlfYkylXr3gLKnsubm4dk
 +UnWFd21Cp2Cqg2mVT+7gg70tk0oFDYVlCiOVmdr1eVnkPDdl/T1JV/b0u8+zn6QsCWoSHeML
 s3CGAdvGzkNuyhsSIuw9p9NruIkAy6+njrNq/3VnD5Sb53YRhYnBrxnK93/e6/ezv8jQV7cbS
 bkVlzsJ2tdyQC5M4d80N6z4r49ojutTP021urIUrKY+2E3B6Omx/IZWcKvuX4uQt5BTZJ8MR0
 0b2Z16EY+n3N7hc3NdUw0CLQfD50mUhJ5WZcdSkA+V5AiQmQCawuc2ghN3IFpjJI9J1dP5AG/
 r0tISGmPyga9jvWESoh1qI+YirTyJlz0cRu5/R2aN9wMZRkE2876i52AYkiwjfFcpV7jTPyFX
 5CyoreL1qoPPftnI1WzRzuJ+xp+Ux+7gnXn9au6LKMARFcnc0kqfLG7EuOdv6Iq4ZcmlpqUz4
 wSAxL/sxwNvFeu+vThlEqLnap0S2Dntu/TT2LkbTh3iTLQilLa0VWMvhM46UlOU1Q5++9QnhX
 gkknvHSQ4SWZXJwIY8Q6zQHJzj81A00oDHrug78ww3m3RTpDzyNcDEAXwv04/PEdPtQAT6c5h
 vIJC4zEEFO0waZfksRDiESPtmOHOX/Y2drEVlFIXtyWrrEF1NBp/NYVfoMpvjiISmt1g0KF1p
 QmjC4yrWVqFcUA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 13:18, Miaoqian Lin wrote:
> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()=EF=BC=9A
>
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
>
> Fix memory leak by calling kobject_put().
>
> Fixes: 73f368cf679b ("Kobject: change drivers/parisc/pdc_stable.c to use=
 kobject_init_and_add")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

applied.
Thanks!
Helge


> ---
>  drivers/parisc/pdc_stable.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
> index 9513c39719d1..d9e51036a4fa 100644
> --- a/drivers/parisc/pdc_stable.c
> +++ b/drivers/parisc/pdc_stable.c
> @@ -980,8 +980,10 @@ pdcs_register_pathentries(void)
>  		entry->kobj.kset =3D paths_kset;
>  		err =3D kobject_init_and_add(&entry->kobj, &ktype_pdcspath, NULL,
>  					   "%s", entry->name);
> -		if (err)
> +		if (err) {
> +			kobject_put(&entry->kobj);
>  			return err;
> +		}
>
>  		/* kobject is now registered */
>  		write_lock(&entry->rw_lock);
>

