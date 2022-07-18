Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028855788AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiGRRmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiGRRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:42:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F5626561;
        Mon, 18 Jul 2022 10:42:01 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C9E86601A6D;
        Mon, 18 Jul 2022 18:41:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658166120;
        bh=E3vs2i0OWA/PGgoM/Ot0zDeqmpuTL564D6XnyU7mbik=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PBwC5zxGRZEpUiSYPo/TIUXZC3qFus5E0xu6qA/8ZwcLcVwRw9SLkJDPPs0Z6em0h
         y+4L8JSN7yDDp7LXVm7+FWCkiVYo5aJxgFzlu130dEljrWx8ZwGt8xjDlb8eyRFgn2
         GLmI0BjQcmOVqKotlVSw88XnX2GTey+GzsWBh1jPlLsAkYmk4448/8CP9ThSCPqX5Z
         0Q/9zagQQncCiyGUjlpW5fuyV/KwJhnpRByUriJB3BTXizZxS0ftXvBkGa19BP11Q1
         AEI6+fMSMdXE5qJovysQ+fUpsyXjIPySY68Tiq5qf+nCMRpAC/KRl4Uol36oYZuHlR
         +AMQqXd6+4ISg==
Message-ID: <d58e8624e9703e5dbbc54908aa142d10ef7f5a22.camel@collabora.com>
Subject: Re: [PATCH] media: cedrus: hevc: Add check for invalid timestamp
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jul 2022 13:41:48 -0400
In-Reply-To: <20220718165649.16407-1-jernej.skrabec@gmail.com>
References: <20220718165649.16407-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 18 juillet 2022 =C3=A0 18:56 +0200, Jernej Skrabec a =C3=A9crit=C2=
=A0:
> Not all DPB entries will be used most of the time. Unused entries will
> thus have invalid timestamps. They will produce negative buffer index
> which is not specifically handled. This works just by chance in current
> code. It will even produce bogus pointer, but since it's not used, it
> won't do any harm.
>=20
> Let's fix that brittle design by skipping writing DPB entry altogether
> if timestamp is invalid.
>=20
> Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h265.c
> index 1afc6797d806..687f87598f78 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -147,6 +147,9 @@ static void cedrus_h265_frame_info_write_dpb(struct c=
edrus_ctx *ctx,
>  			dpb[i].pic_order_cnt_val
>  		};
> =20
> +		if (buffer_index < 0)
> +			continue;

When I compare to other codecs, when the buffer_index does not exist, the a=
ddr 0
is being programmed into the HW. With this implementation is is left to wha=
tever
it was set for the previous decode operation. I think its is nicer done the
other way.

> +
>  		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
>  						    pic_order_cnt,
>  						    buffer_index);

