Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB550BA3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448728AbiDVOjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448508AbiDVOjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:39:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F368B5BD14
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:36:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c23so11299673plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rF/C3AMO9J9Xcm0GDkakDkZ6D9mvu8tIygaqpNdvpMU=;
        b=guyS8Iw2jNo3NG/fqFX/2t3DskAnRGI89PzemXKM9OIkNum3FWKypc6gOar9BzusRO
         BC9cfMrY7u8QAc3BRRpsvtdXuSyLihUliWYKmfqSSrbgLB6VX/+K3a6Z8bEfsYE3WtKA
         b9Q1utlzoiGyt7MOVXJN1pdnMXvHNVM4aCDDUVwwYJ/MzIHFKS81PvNS881Q1syj1ybp
         YnsRkp5j3MzbAnX9oeME9lNM/ogjMkUzxwkGH3GtZJWxO1+324Y+bZd3EkT1fRqp1JPp
         7ebPoEp7dqQkAhfpsle9S+goqQbY5m6hON75jlHhT/fQUVQY9nAkVjl+GkrytzlxBKDo
         Txug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rF/C3AMO9J9Xcm0GDkakDkZ6D9mvu8tIygaqpNdvpMU=;
        b=K4m66gVcGZC5XHxxGkso+2Hmjku6qwUitlASbD+ekIbxyWbZ5cu/XNFnp9D7PUlHOw
         BZEIMYosktyZX3RvUBK8MtenmcgrW0eeg7Kjb1bq3s6aG2zsPV2aSsuAcidOeAAcKLH6
         5Zr0TFKh42qQVOmFPIBD1w3i7k+RzmJV+f9/N23+CYqfJovn9rO9SBnB8v0MTira6eA9
         K5zJ/pCKjJ6LpzGpjp0qAq+GDs2aJB+iIcOfWIF8Qxoh0Uq4Df3Eh4lSQd/E6RuBJXFa
         dHCNksTCMToiGKr4u5HBGsJ+SaTOKOpN/LOFUlul8Lr/0cYytRJZfj+2MljLRyEUJQGQ
         r6VQ==
X-Gm-Message-State: AOAM5339O9D9AOzqCdEqikA2Bqe5Ur9TlJtor1xpBSti3wO+pdi3lZEz
        ZkfzanPTv285DtltVAD0fHoWM9+nKDGgSQf8lb4AgQ==
X-Google-Smtp-Source: ABdhPJx+8awO7N+ykm6cx8j9n6uD/I784MCgtzeksoaz1FhjzdeJ7TXPoru3pfF1uMyrXsf4vRQf1SiSrI7SDFDpyW8=
X-Received: by 2002:a17:90a:6501:b0:1ca:a7df:695c with SMTP id
 i1-20020a17090a650100b001caa7df695cmr5785713pjj.152.1650638213282; Fri, 22
 Apr 2022 07:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220319151016.983348-1-alvin@pqrs.dk> <20220319151016.983348-3-alvin@pqrs.dk>
In-Reply-To: <20220319151016.983348-3-alvin@pqrs.dk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 22 Apr 2022 16:36:42 +0200
Message-ID: <CAG3jFyu64Hq=8Jh0Gj=H+tojBmERcjCZ-tq6PoYb9yrfar7iFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: bridge: adv7511: use non-legacy mode for CEC RX
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022 at 16:10, Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:
>
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> The ADV7511 family of bridges supports two modes for CEC RX: legacy and
> non-legacy mode. The only difference is whether the chip uses a single
> CEC RX buffer, or uses all three available RX buffers. Currently the
> adv7511 driver uses legacy mode.
>
> While debugging a stall in CEC RX on an ADV7535, we reached out to
> Analog Devices, who suggested to use non-legacy mode instead.  According
> to the programming guide for the ADV7511 [1], and the register control
> manual of the ADV7535 [2], this is the default behaviour on reset. As
> previously stated, the adv7511 driver currently overrides this to legacy
> mode.
>
> This patch updates the adv7511 driver to instead use non-legacy mode
> with all three CEC RX buffers. As a result of this change, we no longer
> experience any stalling of CEC RX with the ADV7535. It is not known why
> non-legacy mode solves this particular issue, but besides this, no
> functional change is to be expected by this patch. Please note that this
> has only been tested on an ADV7535.
>
> What follows is a brief description of the non-legacy mode interrupt
> handling behaviour. The programming guide in [1] gives a more detailed
> explanation.
>
> With three RX buffers, the interrupt handler checks the CEC_RX_STATUS
> register (renamed from CEC_RX_ENABLE in this patch), which contains
> 2-bit psuedo-timestamps for each of the RX buffers. The RX timestamps
> for each buffer represent the time of arrival for the CEC frame held in
> a given buffer, with lower timestamp values indicating chronologically
> older frames. A special value of 0 indicates that the given RX buffer
> is inactive and should be skipped. The interrupt handler parses these
> timestamps and then reads the active RX buffers in the prescribed order
> using the same logic as before. Changes have been made to ensure that
> the correct RX buffer is cleared after processing. This clearing
> procesure also sets the timestamp of the given RX buffer to 0 to mark it
> as inactive.
>
> [1] https://www.analog.com/media/en/technical-documentation/user-guides/A=
DV7511_Programming_Guide.pdf
>     cf. CEC Map, register 0x4A, bit 3, default value 1:
>     0 =3D Use only buffer 0 to store CEC frames (Legacy mode)
>     1 =3D Use all 3 buffers to stores the CEC frames (Non-legacy mode)
>
> [2] The ADV7535 register control manual is under NDA, but trust me when
>     I say that non-legacy CEC RX mode is the default here too. Here the
>     register is offset by 0x70 and has an address of 0xBA in the DSI_CEC
>     regiser map.
>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511.h     | 26 +++++-
>  drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 98 +++++++++++++++-----
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 17 +++-
>  3 files changed, 109 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/b=
ridge/adv7511/adv7511.h
> index da6d8ee2cd84..9e3bb8a8ee40 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> @@ -209,10 +209,16 @@
>  #define ADV7511_REG_CEC_TX_ENABLE      0x11
>  #define ADV7511_REG_CEC_TX_RETRY       0x12
>  #define ADV7511_REG_CEC_TX_LOW_DRV_CNT 0x14
> -#define ADV7511_REG_CEC_RX_FRAME_HDR   0x15
> -#define ADV7511_REG_CEC_RX_FRAME_DATA0 0x16
> -#define ADV7511_REG_CEC_RX_FRAME_LEN   0x25
> -#define ADV7511_REG_CEC_RX_ENABLE      0x26
> +#define ADV7511_REG_CEC_RX1_FRAME_HDR  0x15
> +#define ADV7511_REG_CEC_RX1_FRAME_DATA0        0x16
> +#define ADV7511_REG_CEC_RX1_FRAME_LEN  0x25
> +#define ADV7511_REG_CEC_RX_STATUS      0x26
> +#define ADV7511_REG_CEC_RX2_FRAME_HDR  0x27
> +#define ADV7511_REG_CEC_RX2_FRAME_DATA0        0x28
> +#define ADV7511_REG_CEC_RX2_FRAME_LEN  0x37
> +#define ADV7511_REG_CEC_RX3_FRAME_HDR  0x38
> +#define ADV7511_REG_CEC_RX3_FRAME_DATA0        0x39
> +#define ADV7511_REG_CEC_RX3_FRAME_LEN  0x48
>  #define ADV7511_REG_CEC_RX_BUFFERS     0x4a
>  #define ADV7511_REG_CEC_LOG_ADDR_MASK  0x4b
>  #define ADV7511_REG_CEC_LOG_ADDR_0_1   0x4c
> @@ -220,6 +226,18 @@
>  #define ADV7511_REG_CEC_CLK_DIV                0x4e
>  #define ADV7511_REG_CEC_SOFT_RESET     0x50
>
> +static const u8 ADV7511_REG_CEC_RX_FRAME_HDR[] =3D {
> +       ADV7511_REG_CEC_RX1_FRAME_HDR,
> +       ADV7511_REG_CEC_RX2_FRAME_HDR,
> +       ADV7511_REG_CEC_RX3_FRAME_HDR,
> +};
> +
> +static const u8 ADV7511_REG_CEC_RX_FRAME_LEN[] =3D {
> +       ADV7511_REG_CEC_RX1_FRAME_LEN,
> +       ADV7511_REG_CEC_RX2_FRAME_LEN,
> +       ADV7511_REG_CEC_RX3_FRAME_LEN,
> +};
> +
>  #define ADV7533_REG_CEC_OFFSET         0x70
>
>  enum adv7511_input_clock {
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_cec.c
> index 1f619389e201..399f625a50c8 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> @@ -17,7 +17,8 @@
>
>  #define ADV7511_INT1_CEC_MASK \
>         (ADV7511_INT1_CEC_TX_READY | ADV7511_INT1_CEC_TX_ARBIT_LOST | \
> -        ADV7511_INT1_CEC_TX_RETRY_TIMEOUT | ADV7511_INT1_CEC_RX_READY1)
> +        ADV7511_INT1_CEC_TX_RETRY_TIMEOUT | ADV7511_INT1_CEC_RX_READY1 |=
 \
> +        ADV7511_INT1_CEC_RX_READY2 | ADV7511_INT1_CEC_RX_READY3)
>
>  static void adv_cec_tx_raw_status(struct adv7511 *adv7511, u8 tx_raw_sta=
tus)
>  {
> @@ -70,25 +71,16 @@ static void adv_cec_tx_raw_status(struct adv7511 *adv=
7511, u8 tx_raw_status)
>         }
>  }
>
> -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
> +static void adv7511_cec_rx(struct adv7511 *adv7511, int rx_buf)
>  {
>         unsigned int offset =3D adv7511->reg_cec_offset;
> -       const u32 irq_tx_mask =3D ADV7511_INT1_CEC_TX_READY |
> -                               ADV7511_INT1_CEC_TX_ARBIT_LOST |
> -                               ADV7511_INT1_CEC_TX_RETRY_TIMEOUT;
>         struct cec_msg msg =3D {};
>         unsigned int len;
>         unsigned int val;
>         u8 i;
>
> -       if (irq1 & irq_tx_mask)
> -               adv_cec_tx_raw_status(adv7511, irq1);
> -
> -       if (!(irq1 & ADV7511_INT1_CEC_RX_READY1))
> -               return;
> -
>         if (regmap_read(adv7511->regmap_cec,
> -                       ADV7511_REG_CEC_RX_FRAME_LEN + offset, &len))
> +                       ADV7511_REG_CEC_RX_FRAME_LEN[rx_buf] + offset, &l=
en))
>                 return;
>
>         msg.len =3D len & 0x1f;
> @@ -101,18 +93,76 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511=
, unsigned int irq1)
>
>         for (i =3D 0; i < msg.len; i++) {
>                 regmap_read(adv7511->regmap_cec,
> -                           i + ADV7511_REG_CEC_RX_FRAME_HDR + offset, &v=
al);
> +                           i + ADV7511_REG_CEC_RX_FRAME_HDR[rx_buf] + of=
fset,
> +                           &val);
>                 msg.msg[i] =3D val;
>         }
>
> -       /* toggle to re-enable rx 1 */
> -       regmap_write(adv7511->regmap_cec,
> -                    ADV7511_REG_CEC_RX_BUFFERS + offset, 1);
> -       regmap_write(adv7511->regmap_cec,
> -                    ADV7511_REG_CEC_RX_BUFFERS + offset, 0);
> +       /* Toggle RX Ready Clear bit to re-enable this RX buffer */
> +       regmap_update_bits(adv7511->regmap_cec,
> +                          ADV7511_REG_CEC_RX_BUFFERS + offset, BIT(rx_bu=
f),
> +                          BIT(rx_buf));
> +       regmap_update_bits(adv7511->regmap_cec,
> +                          ADV7511_REG_CEC_RX_BUFFERS + offset, BIT(rx_bu=
f), 0);
> +
>         cec_received_msg(adv7511->cec_adap, &msg);
>  }
>
> +void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
> +{
> +       unsigned int offset =3D adv7511->reg_cec_offset;
> +       const u32 irq_tx_mask =3D ADV7511_INT1_CEC_TX_READY |
> +                               ADV7511_INT1_CEC_TX_ARBIT_LOST |
> +                               ADV7511_INT1_CEC_TX_RETRY_TIMEOUT;
> +       const u32 irq_rx_mask =3D ADV7511_INT1_CEC_RX_READY1 |
> +                               ADV7511_INT1_CEC_RX_READY2 |
> +                               ADV7511_INT1_CEC_RX_READY3;
> +       unsigned int rx_status;
> +       int rx_order[3] =3D { -1, -1, -1 };
> +       int i;
> +
> +       if (irq1 & irq_tx_mask)
> +               adv_cec_tx_raw_status(adv7511, irq1);
> +
> +       if (!(irq1 & irq_rx_mask))
> +               return;
> +
> +       if (regmap_read(adv7511->regmap_cec,
> +                       ADV7511_REG_CEC_RX_STATUS + offset, &rx_status))
> +               return;
> +
> +       /*
> +        * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of=
 RX
> +        * buffers 0, 1, and 2 in bits [1:0], [3:2], and [5:4] respective=
ly.
> +        * The values are to be interpreted as follows:
> +        *
> +        *   0 =3D buffer unused
> +        *   1 =3D buffer contains oldest received frame (if applicable)
> +        *   2 =3D buffer contains second oldest received frame (if appli=
cable)
> +        *   3 =3D buffer contains third oldest received frame (if applic=
able)
> +        *
> +        * Fill rx_order with the sequence of RX buffer indices to
> +        * read from in order, where -1 indicates that there are no
> +        * more buffers to process.
> +        */
> +       for (i =3D 0; i < 3; i++) {
> +               unsigned int timestamp =3D (rx_status >> (2 * i)) & 0x3;
> +
> +               if (timestamp)
> +                       rx_order[timestamp - 1] =3D i;
> +       }
> +
> +       /* Read CEC RX buffers in the appropriate order as prescribed abo=
ve */
> +       for (i =3D 0; i < 3; i++) {
> +               int rx_buf =3D rx_order[i];
> +
> +               if (rx_buf < 0)
> +                       break;
> +
> +               adv7511_cec_rx(adv7511, rx_buf);
> +       }
> +}
> +
>  static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable=
)
>  {
>         struct adv7511 *adv7511 =3D cec_get_drvdata(adap);
> @@ -126,11 +176,11 @@ static int adv7511_cec_adap_enable(struct cec_adapt=
er *adap, bool enable)
>                 regmap_update_bits(adv7511->regmap_cec,
>                                    ADV7511_REG_CEC_CLK_DIV + offset,
>                                    0x03, 0x01);
> -               /* legacy mode and clear all rx buffers */
> +               /* non-legacy mode and clear all rx buffers */
>                 regmap_write(adv7511->regmap_cec,
> -                            ADV7511_REG_CEC_RX_BUFFERS + offset, 0x07);
> +                            ADV7511_REG_CEC_RX_BUFFERS + offset, 0x0f);
>                 regmap_write(adv7511->regmap_cec,
> -                            ADV7511_REG_CEC_RX_BUFFERS + offset, 0);
> +                            ADV7511_REG_CEC_RX_BUFFERS + offset, 0x08);
>                 /* initially disable tx */
>                 regmap_update_bits(adv7511->regmap_cec,
>                                    ADV7511_REG_CEC_TX_ENABLE + offset, 1,=
 0);
> @@ -138,7 +188,7 @@ static int adv7511_cec_adap_enable(struct cec_adapter=
 *adap, bool enable)
>                 /* tx: ready */
>                 /* tx: arbitration lost */
>                 /* tx: retry timeout */
> -               /* rx: ready 1 */
> +               /* rx: ready 1-3 */
>                 regmap_update_bits(adv7511->regmap,
>                                    ADV7511_REG_INT_ENABLE(1), 0x3f,
>                                    ADV7511_INT1_CEC_MASK);
> @@ -304,9 +354,9 @@ int adv7511_cec_init(struct device *dev, struct adv75=
11 *adv7511)
>         regmap_write(adv7511->regmap_cec,
>                      ADV7511_REG_CEC_SOFT_RESET + offset, 0x00);
>
> -       /* legacy mode */
> +       /* non-legacy mode - use all three RX buffers */
>         regmap_write(adv7511->regmap_cec,
> -                    ADV7511_REG_CEC_RX_BUFFERS + offset, 0x00);
> +                    ADV7511_REG_CEC_RX_BUFFERS + offset, 0x08);
>
>         regmap_write(adv7511->regmap_cec,
>                      ADV7511_REG_CEC_CLK_DIV + offset,
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 0be65a1ffc47..ffb034daee45 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1030,10 +1030,19 @@ static bool adv7511_cec_register_volatile(struct =
device *dev, unsigned int reg)
>         reg -=3D adv7511->reg_cec_offset;
>
>         switch (reg) {
> -       case ADV7511_REG_CEC_RX_FRAME_HDR:
> -       case ADV7511_REG_CEC_RX_FRAME_DATA0...
> -               ADV7511_REG_CEC_RX_FRAME_DATA0 + 14:
> -       case ADV7511_REG_CEC_RX_FRAME_LEN:
> +       case ADV7511_REG_CEC_RX1_FRAME_HDR:
> +       case ADV7511_REG_CEC_RX1_FRAME_DATA0...
> +               ADV7511_REG_CEC_RX1_FRAME_DATA0 + 14:
> +       case ADV7511_REG_CEC_RX1_FRAME_LEN:
> +       case ADV7511_REG_CEC_RX2_FRAME_HDR:
> +       case ADV7511_REG_CEC_RX2_FRAME_DATA0...
> +               ADV7511_REG_CEC_RX2_FRAME_DATA0 + 14:
> +       case ADV7511_REG_CEC_RX2_FRAME_LEN:
> +       case ADV7511_REG_CEC_RX3_FRAME_HDR:
> +       case ADV7511_REG_CEC_RX3_FRAME_DATA0...
> +               ADV7511_REG_CEC_RX3_FRAME_DATA0 + 14:
> +       case ADV7511_REG_CEC_RX3_FRAME_LEN:
> +       case ADV7511_REG_CEC_RX_STATUS:
>         case ADV7511_REG_CEC_RX_BUFFERS:
>         case ADV7511_REG_CEC_TX_LOW_DRV_CNT:
>                 return true;

This is a bit of a nitpick, but the syntax of these "case X...Y"
statements was kind of hard to parse, do you mind putting them on one
line?

With or without the above suggestion fixed, r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
