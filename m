Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C60C59C9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiHVUJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiHVUJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:09:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC6452450;
        Mon, 22 Aug 2022 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661198965;
        bh=vM8dIaRuq/YyehZA7pwQXyRcVb/iqx4/5RXN88g/5yk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FHe5bxd/m91Xqz8hJnf4R/2aI49TeCdh6y1KyycViLZI5eVSfrUZzNbHSS3np9Pzp
         z5ie0nYjWxJr8rJRpG4giWYTyAbqe2uget3xw8N1hyIg0drbCEiAMPVT4NvgsMTFJ0
         Cr6gTxtplVEbcFIThwf2cPgLCQIk6uf5Lml0jhh0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.222]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1pAFrB00Vc-00kLGk; Mon, 22
 Aug 2022 22:09:25 +0200
Message-ID: <5fcc858a-c9f2-0a9c-ded9-5df2d794e3be@gmx.de>
Date:   Mon, 22 Aug 2022 22:09:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] fbcon: Destroy mutex on freeing struct fb_info
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220821111731.247446-1-syoshida@redhat.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220821111731.247446-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wzAQ+Bzi2y+wnwtxdQ3Yh8A8Ue1WmeKBSk3OxvudWmIMPj8FvMF
 1Or2PMxUF4oW3Y95M2RWK56cDZk0IE7uyI7o3VlNKI9/waB0hLyJEuflAcvJaln/BPjJe/J
 EYFrUAnhShD2IV+2ylG6f7BQIvP1zN5uLpnWPqTU7vTKzd/Da9dKSTSCCXAt5BKplTFNAvd
 axHr1aMdYjt5YesvTzqHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RdCxWpvtXEE=:9E5cH3on88rnyv/vob6GXh
 RG7v94IoM1Y4H1Cv+c8XldzzygqbKr3N6xkqxYN6ZXBjP01cdyO9PJgdvA+l0Ws2CvfgB86Bf
 leNTbh1i9wx72zMF4A4vg6qYewdxREdGrxUsHvEALvNYmiVi08LpEW57QLN4cx6kXFTt32mxx
 trK6LDJPWoUDOrTtS0gVopd1vNTpFLWv4UuTiZsDQ/6g7QloiiwBjpWwewoM+0krD2tt+emiO
 dQs5Ik6HiJAkKZ0PE0LC5TrOEDqPA6XRBGF6jkBxKDA7BFSTbPuS0vjgBX/RL9TUgbhRx7zfG
 JeoKIZi3fgSiAMFXuMdWRt/GO3KAixGOeKKprN9DkW7tMJuyGAarliY4ulTNT+tsrfv9qUvkk
 6AQEO1VykNXoCL0IsScXaA/qbfGGMFcqAy5S9BDHaj80lah3frd+MUScZp+l+LMXUILqwChs7
 5Ywfg2gTxb4+8cXbDs7qXehX/yHbY7xZieOrFGgQpx5kZoCe/Ny0YsVFb99cTN/on69r9bPV2
 Wp8zyFSJgj+PmnPid/vbgi2j0eOKDMyxoIZTIE5gOItWhT1QImBHnRGeuQ67G3jq9K9yNhvM8
 v5EA1aJl/PlWVCmohnUX2BByfGm0T7gvK4UhDSSwcway2/IJE0uW97RAlGsPerH0IlIRS/pLh
 C3vVHiI8R9TKllvssRkPIL+l5Qwwu0PlLS5KbmvV1J5TWNYSReq1CnHa/lMxJ/B1mu2CInI62
 Bf2an6VqkiqDH+qQhjdAyDy5EF90XpS7Ama+ACuU0rzmlzcNyVz9k+/DYdXDWMMf16Pk7fgx9
 bqaP6WQ/f6o+GkS5F7xfnjXv/lL8OW4hyJ4Oypz4SNxE9YRd2LzJdv1LhysLzSgd0n/3sHg+H
 SWc8z0zcqwpDfxKVuVDag0aa5pLa+Bh3R9T6ypwzeLwcdzDb7zDWtLaFJRNQb3KPBQCapZJvD
 TRRAFunscZx7qAtU+ZpqDN6EazMdAKTEi3lsqCci1aQCxEYtpP0ew3ZTkQY1wjCrzB/6AytFm
 x1NKtnTJkAl5ySQ2YQPZY3R6GXe61JMS4R869JV0hOAjQ9JKMRCg34WYiunn5JNHCMWkVlUke
 NuUJBSZQPhoQKx9Pj19ToKNoXb8Y0APLdAxoWgoNc3CeouIJ6j7dGHXmQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 13:17, Shigeru Yoshida wrote:
> It's needed to destroy bl_curve_mutex on freeing struct fb_info since
> the mutex is embedded in the structure and initialized when it's
> allocated.
>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

applied.
Thanks,
Helge

> ---
>  drivers/video/fbdev/core/fbsysfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/co=
re/fbsysfs.c
> index c2a60b187467..4d7f63892dcc 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -84,6 +84,10 @@ void framebuffer_release(struct fb_info *info)
>  	if (WARN_ON(refcount_read(&info->count)))
>  		return;
>
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
> +	mutex_destroy(&info->bl_curve_mutex);
> +#endif
> +
>  	kfree(info->apertures);
>  	kfree(info);
>  }

