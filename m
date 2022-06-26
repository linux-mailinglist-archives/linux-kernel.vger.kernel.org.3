Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4B55B428
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 23:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiFZVMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 17:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFZVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 17:12:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D48388B;
        Sun, 26 Jun 2022 14:12:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso10516222pjg.1;
        Sun, 26 Jun 2022 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cEPrEFRzl8/hH5h4Kq/JMLZy1JAPCmAuI9Gd2Rq87rg=;
        b=Tdhn7mYaWJqKozxEVc41aBHeMwUAHCviE3P9m99KGmu2E6ETH7CQOLHveynLjO43v6
         oMJO2v/sCMWvLIvRZUjn5JCyH3aZ1fVEe9NRAPxWglzh+dCvdvC+9mns2mmJvyy3xMDb
         qSLMl7EzSIpgsiB77EJJvsAqk/LMPXbxxNbp2ZEbtgptlHdnZwTUOd6iMlSzR1P4DAMu
         epSax1+dqB+FeQ4hwWoGlX9clWi6cZuFEXN7oJzEmVwOB5GgSHWJTGtYRh06fo/iuwxE
         HYhZaZU2QjeOdNAj6zW9Jfn15a7vZelnWUY3jyUFHZzCamB3C2mZinoVL5bo2VwzlMOO
         59ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=cEPrEFRzl8/hH5h4Kq/JMLZy1JAPCmAuI9Gd2Rq87rg=;
        b=glAJxoafrrS1yBY4eHIOaQm0qNCuaDTwR2uqZByH2aIIVeElF1zodITpn/ing1bIv9
         7M+ogi/tCg37jwOBOdEiwUIlHL9d4NZEIB6XEAVD6NN77Fep0/gWhaxASfMywzBrz7Sp
         msrA3PvtsA8B/NrHEVnF97RcNVAAIOn4y2CBZRXW12Zs3s9OkPhyf8JWV2Y25wT/J4Ga
         /kB+QBvzZIaF9c9DK76JSsKbyUbSLO0/QGrwJqAM0Z4aad0vFi2dFgxD8Sh7gq9/EpRP
         D9fcVYBtR0W12HR+s7pSawW5arFCSH3TBnPyWtN7jhh+1Q7CGly6AjOBllVqEOxod+YI
         8jVQ==
X-Gm-Message-State: AJIora+dz8drhFIJuFm8mv6NweFtWxeOecYRX6ehqVLhpDPgOMNcvNUS
        z8LmSIgUh5W49Z3TJsZN5VhgC/WjOVakZgkOEdzhOanZnlljRQ==
X-Google-Smtp-Source: AGRyM1uK2n2rrbTo68LgcBR0h/JBHHQzfaDaQY/3vI/V+9tKewavo5JWH1UshDtgt9NfR5sSUlrbaUU4PzgKBbDtzro=
X-Received: by 2002:a17:90b:4a4c:b0:1ec:9036:8f91 with SMTP id
 lb12-20020a17090b4a4c00b001ec90368f91mr11752496pjb.33.1656277920825; Sun, 26
 Jun 2022 14:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220623103543.4138-1-yongsuyoo0215@gmail.com>
In-Reply-To: <20220623103543.4138-1-yongsuyoo0215@gmail.com>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Mon, 27 Jun 2022 06:11:53 +0900
Message-ID: <CANXPkT49g7_YaL3rABY5Uhohz=EPgPqOL2tb6K4SHsWmshtysw@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Hans Petter Selasky <hps@selasky.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ~

How is this patch going ?
Can you share current status ?

Thank you


2022=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:35, Y=
ongSu Yoo <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
>
> The function dvb_ringbuffer_pkt_next in
> /linux-next/drviers/media/dvb-core/dvb_ringbuffer.c,
> which searches the idx of the next valid packet in the ring
> buffer of the ca->slot_info[slot].rx_buffer at
> /linux-next/drivers/media/dvb-core/dvb_ca_en50221.c,
> has the following problem.
> In calculating the amounts of the consumed address of the ring
> buffer, if the read address(rbuf->pread) of the ring buffer is
> smaller than the idx, the amounts of the searched address
> should be (idx - rbuf->pread),
> whereas if the read address(rbuf->pread) of the ring buffer is
> larger than the idx, the amounts of the consumed address should
> be (idx - rbuf->pread + rbug->size). But there exists an
> incorrect logic that the rbug-size was not properly added on
> (idx - rbug->pread) in the later case. With this commit, we
> fixed this bug.
> ---
>  drivers/media/dvb-core/dvb_ringbuffer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c b/drivers/media/dvb-=
core/dvb_ringbuffer.c
> index d1d471af0636..7d4558de8e83 100644
> --- a/drivers/media/dvb-core/dvb_ringbuffer.c
> +++ b/drivers/media/dvb-core/dvb_ringbuffer.c
> @@ -335,7 +335,9 @@ ssize_t dvb_ringbuffer_pkt_next(struct dvb_ringbuffer=
 *rbuf, size_t idx, size_t*
>                 idx =3D (idx + curpktlen + DVB_RINGBUFFER_PKTHDRSIZE) % r=
buf->size;
>         }
>
> -       consumed =3D (idx - rbuf->pread) % rbuf->size;
> +       consumed =3D (idx - rbuf->pread);
> +       if (consumed < 0)
> +               consumed +=3D rbuf->size;
>
>         while((dvb_ringbuffer_avail(rbuf) - consumed) > DVB_RINGBUFFER_PK=
THDRSIZE) {
>
> --
> 2.17.1
>
