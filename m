Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF544573415
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiGMKYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiGMKYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:24:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1FDA78D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:24:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a9so18299733lfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PQ7TlErz9smov0rfx19Na+1VuDOymVWccAObGubD7hE=;
        b=j3Im0x2bE4D19GrrzFvEHiywctG624H/V6PfGPXeeKLO89ES02QmxTzGtZiHoSfIIt
         WQo8N59T2vYLPAiWh1ERS+CrQ9vxZBCNvCvU+KvuTIlx1M/nz1kBTeif1g8+mTRj4P+j
         ZfZVvzS5GEqgZ26cUr8/o34YBYoTItxb6hJze7yK33Z4zmygVaSrOj9nE+/ZmUn509G2
         B+XGIYZWMD7Pp9QwwIrjFvEJsH09twOKr/GGqBORBJfmMhXv+bpSVlh8BKatiMg4LjPM
         Q+R3zzd0vuxbJgKsJ08pDTK4ivem9OatHJqy8v3a/Ovaj1kwIkPWE/UV+QuKb9pZ34w0
         4tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PQ7TlErz9smov0rfx19Na+1VuDOymVWccAObGubD7hE=;
        b=HnTZ0+AbNdPykTvH5iCVOiCADfgU+DkRPoZmIYsS8yYdcXS5jVL8CTk/xBpMeF/uA6
         e3uAO94se7BIdC5xWW/HwQrRYV0pnREyhWEwBmANdkZOFmY4WqHSH3X72+WyfP5y0+/I
         gQCvv8kYPNe/VupbK9fra+9+ZVh6rxolOrc6mkvX8RUwTtHbTXirdqwTEqjVEOL9QdnE
         HsaxUX7iUAmcJyIXFEH9ZqWC6dED32k9WGP5bXcHtpCVyIWOQRFcttL3DCBYK4EM5OSY
         4JAH8qgxgvXGJviTGTFb7IuJ4755SpXm9lknl9fGi6K4nwHAR3HP3S0kzs6lXSbtC2bO
         Gu1g==
X-Gm-Message-State: AJIora80GFkOx8u7xbpAEcQsYzb6XEcvVPKCM6K1McmhOQqK0KsdmRWD
        UUVSlNN0enaP6zuAHBrOoi8=
X-Google-Smtp-Source: AGRyM1skQh9Jgh7G2eTiKQGhgpSh87g4zJf6atlVqh7gkzR/TrDYVBtdFIgudz1CX+zJh/nVmujKPw==
X-Received: by 2002:a05:6512:2254:b0:489:d168:20cf with SMTP id i20-20020a056512225400b00489d16820cfmr1537677lfu.97.1657707883409;
        Wed, 13 Jul 2022 03:24:43 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.63])
        by smtp.gmail.com with ESMTPSA id a28-20020a2eb17c000000b0025d3c2e6b8dsm2943803ljm.105.2022.07.13.03.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 03:24:42 -0700 (PDT)
Message-ID: <5445d915-0c6c-b84f-158e-160e7645cbbd@gmail.com>
Date:   Wed, 13 Jul 2022 13:24:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] staging: r888eu: use dynamic allocation for efuse buffer
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220713075804.140986-1-martin@kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220713075804.140986-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Kaiser <martin@kaiser.cx> says:
> Use kmalloc to allocate the efuse buffer in ReadAdapterInfo8188EU and
> free it on exit. This is better than using a 512 byte array on the stack.
> 
> It's ok to drop the __aligned(4) qualifier. kmalloc aligns to
> ARCH_KMALLOC_MINALIGN, this is at least 8 bytes.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 8902dda7b8d8..421fe7c40390 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -926,7 +926,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
>   {
>   	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
>   	struct led_priv *ledpriv = &Adapter->ledpriv;
> -	u8 efuse_buf[EFUSE_MAP_LEN_88E] __aligned(4);
> +	u8 *efuse_buf;
>   	u8 eeValue;
>   	int res;
>   
> @@ -937,7 +937,10 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
>   
>   	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
>   
> -	memset(efuse_buf, 0xFF, sizeof(efuse_buf));
> +	efuse_buf = kmalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
> +	if (!efuse_buf)
> +		return;

I think, it worth returning an error to caller. Functions right after 
the allocation do initialization, so leaving fields as-is seems to be 
dangerous





Thanks,
--Pavel Skripkin
