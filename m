Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9752B15D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiERERZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiERERQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:17:16 -0400
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2E02661;
        Tue, 17 May 2022 21:17:14 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id B5A474401D4;
        Wed, 18 May 2022 07:16:05 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1652847365;
        bh=9RQ9Noiiv587Vg/jTUw5O1TnbrjqBwOFn7otp7MOCi0=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=bXuURY9a52Og3+pbv1jjY63EQxht7omaZJX8cTIQV252f47OGAtEA5CvXe1horI+X
         cmCcnrAWGGSdRTZ16c2XhjicBxxHIVRKFj+nBcVeJuNiLew3LVnGSGkczUbSmpfzqH
         t41Z+0LElO80K+bHOXB9xH2awU5qNodFcGXBHomw5AFW+De+MrZSydg9Vo1J3Z6nO1
         LIP2ZzJvnIQL/t4CC5hq+M08hEcbS1ZDP/AUzbcjPigyFBPBS+HFLA0tiBNJqTVoGV
         CD1cLk0a8kv/li5/nHsZIo/xGb0d6rIC2EKWNMxg1IsQNmGAgZBzz1c/7OeJ54epVq
         TDCzLAvWEyu3g==
References: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
 <20220517110737.37148-3-ilpo.jarvinen@linux.intel.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] serial: digicolor-usart: Don't allow CS5-6
Date:   Wed, 18 May 2022 07:16:01 +0300
In-reply-to: <20220517110737.37148-3-ilpo.jarvinen@linux.intel.com>
Message-ID: <87tu9nqxtk.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On Tue, May 17 2022, Ilpo J=C3=A4rvinen wrote:
> Only CS7 and CS8 seem supported but CSIZE is not sanitized to CS8 in
> the default: block.
>
> Set CSIZE correctly so that userspace knows the effective value.
> Incorrect CSIZE also results in miscalculation of the frame bits in
> tty_get_char_size() or in its predecessor where the roughly the same
> code is directly within uart_update_timeout().
>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Fixes: 5930cb3511df (serial: driver for Conexant Digicolor USART)
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/tty/serial/digicolor-usart.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/di=
gicolor-usart.c
> index 6d70fea76bb3..65e653eb5026 100644
> --- a/drivers/tty/serial/digicolor-usart.c
> +++ b/drivers/tty/serial/digicolor-usart.c
> @@ -309,6 +309,8 @@ static void digicolor_uart_set_termios(struct uart_po=
rt *port,
>  	case CS8:
>  	default:
>  		config |=3D UA_CONFIG_CHAR_LEN;
> +		termios->c_cflag &=3D ~CSIZE;
> +		termios->c_cflag |=3D CS8;
>  		break;
>  	}


--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
