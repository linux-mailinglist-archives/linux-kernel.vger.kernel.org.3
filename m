Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2423C5A0274
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiHXUEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbiHXUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:04:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75B7632E;
        Wed, 24 Aug 2022 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661371480;
        bh=mT+JncqykK1/MQG4BV6pGNhG34tuIpbu4gUj8Qq5OJg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=je1iScQue2PuzOXKqByGfXSW1Qx1ZMfpotwkROyCZsJdSHIqDzw70Z0WtBzwWKyyO
         T0ZcxrYqSNG599BfW8OSma065E/e+6srrPudnzs+1zheu+/wxH/0Wt8EM/6AaK5dSe
         6URRu5A9fA7zjrdRf//AyC3DzDSuuUOT5U/cjiA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.173.19]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1oqcLl1B5B-00RtjX; Wed, 24
 Aug 2022 22:04:40 +0200
Message-ID: <6efc0d2a-c2af-947c-d928-104e3add1650@gmx.de>
Date:   Wed, 24 Aug 2022 22:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] fbcon: Properly revert changes when vc_resize() failed
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        syzbot+a168dbeaaa7778273c1b@syzkaller.appspotmail.com
References: <20220818181336.3504010-1-syoshida@redhat.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220818181336.3504010-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bPYtDBYr/fK766CKWILWMU7xF4/wZ+tyXxZ1o8D2m8Jo85BJ+as
 DNW6Cz5IoGsD2PzMXfhkHHJBmrmJi0/gZdkacY5RzJBUap2qs1wCwreOlmx6Y/XNoOsTg+o
 9MRQE0QR54b3UTUFtfdSXRChRLYQyp/1RIqWJFyFBQZldaNXhs6p4GYoBrUTmwMgMfMbl33
 N6FltjFkdpDIxKBB4r6BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v/nCVi1yI7M=:ftuED5v4WP4ZqnIzTwPVlg
 xvrViHqKL0rzJ7LDMoCsR+/heF0xhFSK0UMYKhhwh40W1BPiTK1E64EzZSy1/Cl037/RXsDBb
 9D+dxZzx3dm1h6B5MDGlSJ+g+YtEnLe51gQSWNvyw1lnO/DIuvQvaCqXJeOP7BZcuWg/ZNkme
 /mVbVPz0eYkIfNXwy0wbr/kMiGjwDTKfcnW6z0zbARDZQkLOVwiFuJp0IjBAFOtThwrpXp7Ch
 dttQLKauLvJ0aOT1iuUA4TzNOfCjMBjWnP9SjfzqZIg1ROskjF43YiZ2ik0+adsESHsmIeu+1
 puv5l5z9j8Mwx0rYF1FFRLjHurmQ37IbEfMWfwIzdUdK//Y7bV+ZIdlF2M2Pb5SbIoFK4+uCB
 yLmA3XiJekW5rtNuTgovWtkVZ1f8Nck1zGtlD6W8Wm+22tjROxAx6CIPA382GrSrLP9oH/U/m
 48yQOY1xfh4UNyZ++Mzw+CE96QSkWFgIxZ39sAOrQedThM2xXCF6Mzvk/L1AfEaYT9kd+8Dio
 QzU6ysz9+nL9hH5aIox0KZzzxvLj6mGlWYn4qvy5E2XiwtHCEoOgip9XDfjGo478AqSReGqY7
 685niWvag0B+MphtZOzIWWHSpvOYZCfbquDOkiRSiqE3rhLbeBZzfbFb/vWhov78H2Cs1TkpW
 L9B39CKWpS7P8OerSEOV56nOQBm1X1ty2/yRu2A8y0s0pfgg3C8zKw0ljwIp4LK6r0HShPJTN
 bk+Li0hINWJI7zg3aBEctiqz0rZy6fnYRG/QMaUSw1/JeBYNK4OoH5j9HFg4vWYyyfhHzS0AD
 P2UbsPpV2xxm5ujfbX4Ei9U4DOtcoRnLAydGkL6h1slTcHcyqw3QyOi2/WWJkErNhyCKqPtMT
 e3Vm7pVjUVY5dYTSmajTtgKWXncilU6uh8uaewB3Qq1hdbkEv5B2csrIs18Zh2eR7Y1edsM7h
 W6hvBofJhVeZJFTjdhhxERqeeYISGlYt6mhXCDmxLg4unvMfYWutpcxFQ/eemx/rNrrlgBMJh
 mt1NRjlPOKGmR6AgqlAJyjubEifg2N7PzG4AXmpAF2U8ZC7YRvuyfuOaiPsEOw7dAgddNsFIh
 L4+G6iYQvfZXgTRxnaowfsEVSq0z7oeaAJh87IvmNpAIu1P2q8Yn6fQvw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shigeru,

On 8/18/22 20:13, Shigeru Yoshida wrote:
> fbcon_do_set_font() calls vc_resize() when font size is changed.
> However, if if vc_resize() failed, current implementation doesn't
> revert changes for font size, and this causes inconsistent state.
>
> syzbot reported unable to handle page fault due to this issue [1].
> syzbot's repro uses fault injection which cause failure for memory
> allocation, so vc_resize() failed.
>
> This patch fixes this issue by properly revert changes for font
> related date when vc_resize() failed.
>
> Link: https://syzkaller.appspot.com/bug?id=3D3443d3a1fa6d964dd7310a0cb16=
96d165a3e07c4 [1]
> Reported-by: syzbot+a168dbeaaa7778273c1b@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

applied.

Thank you!
Helge

> ---
>  drivers/video/fbdev/core/fbcon.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
> index cf9ac4da0a82..825b012debe7 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2401,15 +2401,21 @@ static int fbcon_do_set_font(struct vc_data *vc,=
 int w, int h, int charcount,
>  	struct fb_info *info =3D fbcon_info_from_console(vc->vc_num);
>  	struct fbcon_ops *ops =3D info->fbcon_par;
>  	struct fbcon_display *p =3D &fb_display[vc->vc_num];
> -	int resize;
> +	int resize, ret, old_userfont, old_width, old_height, old_charcount;
>  	char *old_data =3D NULL;
>
>  	resize =3D (w !=3D vc->vc_font.width) || (h !=3D vc->vc_font.height);
>  	if (p->userfont)
>  		old_data =3D vc->vc_font.data;
>  	vc->vc_font.data =3D (void *)(p->fontdata =3D data);
> +	old_userfont =3D p->userfont;
>  	if ((p->userfont =3D userfont))
>  		REFCOUNT(data)++;
> +
> +	old_width =3D vc->vc_font.width;
> +	old_height =3D vc->vc_font.height;
> +	old_charcount =3D vc->vc_font.charcount;
> +
>  	vc->vc_font.width =3D w;
>  	vc->vc_font.height =3D h;
>  	vc->vc_font.charcount =3D charcount;
> @@ -2425,7 +2431,9 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>  		rows =3D FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
>  		cols /=3D w;
>  		rows /=3D h;
> -		vc_resize(vc, cols, rows);
> +		ret =3D vc_resize(vc, cols, rows);
> +		if (ret)
> +			goto err_out;
>  	} else if (con_is_visible(vc)
>  		   && vc->vc_mode =3D=3D KD_TEXT) {
>  		fbcon_clear_margins(vc, 0);
> @@ -2435,6 +2443,21 @@ static int fbcon_do_set_font(struct vc_data *vc, =
int w, int h, int charcount,
>  	if (old_data && (--REFCOUNT(old_data) =3D=3D 0))
>  		kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
>  	return 0;
> +
> +err_out:
> +	p->fontdata =3D old_data;
> +	vc->vc_font.data =3D (void *)old_data;
> +
> +	if (userfont) {
> +		p->userfont =3D old_userfont;
> +		REFCOUNT(data)--;
> +	}
> +
> +	vc->vc_font.width =3D old_width;
> +	vc->vc_font.height =3D old_height;
> +	vc->vc_font.charcount =3D old_charcount;
> +
> +	return ret;
>  }
>
>  /*

