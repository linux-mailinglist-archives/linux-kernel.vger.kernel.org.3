Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E658FE32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiHKOXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHKOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE4EB6B663
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660227796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/GK/JSV/KciKY8R8wWvgS0jrL8EQYeLHgsmbC6kR1U=;
        b=KvOsSNMx5wkmhBbUQe6rFSN11TL7bGX3phOp4LJwowu7eR9Xz2Ost2F3RlNamPw5MODEk0
        B36FLcte7xMwiPQ9fxlmbfKo0XkM7Umh7A8rrA7v4Hb/2qbjZ+AaD2bxT4eSa4D9F3Q3FO
        1p9BDNRGea+nRMKEZyI+R5d4xYM3P3g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-RdY5c5KVMeKxcXQkYuRFeA-1; Thu, 11 Aug 2022 10:23:15 -0400
X-MC-Unique: RdY5c5KVMeKxcXQkYuRFeA-1
Received: by mail-ed1-f71.google.com with SMTP id x20-20020a05640226d400b0043d50aadf3fso11163937edd.23
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=k/GK/JSV/KciKY8R8wWvgS0jrL8EQYeLHgsmbC6kR1U=;
        b=3YfNjFS1tNQEkg6u6OVH+ZGlJRvTOumoQxCbdLstXtqZ4jB4IYNuLZLJ85fAEueOxn
         DUTMK0ddY7ScKmP89AvYdsc0ItS82rgk/hU9/0Xdd0IeWZlhZ5SxoGU80xNQyW9pU7rf
         cUxagqPXdouAhUyiY/M2NfPkBKsm17l86AQsSQUg7Iv1EfvlJ2TPJhbpPXbQ7AMfzC6r
         QzUFDmpUCQ4NyC4IdFRZ46RLdrWoY1bbZ+358dBUYmuLqlOEGxtj2X6ov2b3OSceNneY
         79JSxh71w33sh7Ypc73NctLYX9uZr4tweQOLiWQqo7rnNKyqzK35bCFL+RlivjCa9iQF
         s81g==
X-Gm-Message-State: ACgBeo3vwQcKBn3XB1LcXhqMdKpBn10htzCTm38yCFAAqQJphcsJb78x
        AzJ8TVItlDB2As3Z/oAX5eIoATxtGps2lYyiBCl8Zo1eovyDNjA5F16sjboh00WwaqmpMTLiEoz
        Tn8VaQbL13qcyPax5eSvntmOO
X-Received: by 2002:a05:6402:3583:b0:43d:6943:44a with SMTP id y3-20020a056402358300b0043d6943044amr30638712edc.409.1660227794488;
        Thu, 11 Aug 2022 07:23:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5z1uZE7dm5s8SHSKbGZPuCBf2MsEnEX8VMtQSnm1KfXxrbFQ0PpDc/5Kwvh/6DtDqAgi6C+w==
X-Received: by 2002:a05:6402:3583:b0:43d:6943:44a with SMTP id y3-20020a056402358300b0043d6943044amr30638704edc.409.1660227794291;
        Thu, 11 Aug 2022 07:23:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090694c400b007313a25e56esm3516087ejy.29.2022.08.11.07.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:23:13 -0700 (PDT)
Message-ID: <41ca4d6b-e19c-c039-ed57-716106135e06@redhat.com>
Date:   Thu, 11 Aug 2022 16:23:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Input: synaptics-rmi4 - filter incomplete relative
 packet.
Content-Language: en-US
To:     margeyang <marge.yang@synaptics.corp-partner.google.com>,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
Cc:     marge.yang@tw.synaptics.com, derek.cheng@tw.synaptcs.com,
        vincent.huang@tw.synaptics.com
References: <1659944641-2625-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1659944641-2625-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/8/22 09:44, margeyang wrote:
> From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>
> 
> RMI4 F03 supports the Stick function,
> it's designed to support relative packet.
> This patch supports the following case.
> When relative packet can't be reported completely,
> it may miss one byte or two byte.
> New Synaptics firmware will report PARITY error.
> When timeout error or parity error happens,
> RMI4 driver will sends 0xFE command and
> ask FW to Re-send stick packet again.
> 
> Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
> ---
>  drivers/input/rmi4/rmi_f03.c | 82 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 78 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
> index c194b1664b10..57f03dfcb4ff 100644
> --- a/drivers/input/rmi4/rmi_f03.c
> +++ b/drivers/input/rmi4/rmi_f03.c
> @@ -23,8 +23,12 @@
>  #define RMI_F03_BYTES_PER_DEVICE_SHIFT	4
>  #define RMI_F03_QUEUE_LENGTH		0x0F
>  
> +#define RMI_F03_RESET_STYK 0xFE

Please use tabs in front of the 0xFE to align it with the other values.

> +
>  #define PSMOUSE_OOB_EXTRA_BTNS		0x01
>  
> +#define RELATIVE_PACKET_SIZE		0x03

Just "3" please since this is a size (not a register value).

> +
>  struct f03_data {
>  	struct rmi_function *fn;
>  
> @@ -36,7 +40,8 @@ struct f03_data {
>  	u8 device_count;
>  	u8 rx_queue_length;
>  };
> -
> +int iwritecommandcounter;
> +unsigned int ipacketindex;

Please do not use global variables like this, instead store these
e.g. inside struct f03_data.

>  int rmi_f03_overwrite_button(struct rmi_function *fn, unsigned int button,
>  			     int value)
>  {
> @@ -87,7 +92,7 @@ static int rmi_f03_pt_write(struct serio *id, unsigned char val)
>  			__func__, error);
>  		return error;
>  	}
> -
> +	iwritecommandcounter++;
>  	return 0;
>  }
>  
> @@ -197,10 +202,12 @@ static int rmi_f03_register_pt(struct f03_data *f03)
>  
>  static int rmi_f03_probe(struct rmi_function *fn)
>  {
> +
>  	struct device *dev = &fn->dev;
>  	struct f03_data *f03;
>  	int error;
> -
> +	iwritecommandcounter = 0;
> +	ipacketindex = 0;
>  	f03 = devm_kzalloc(dev, sizeof(struct f03_data), GFP_KERNEL);
>  	if (!f03)
>  		return -ENOMEM;

If you put the 2 variables into the f03_data then there will be no need
to zero them.

> @@ -251,9 +258,12 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
>  	const u8 ob_len = f03->rx_queue_length * RMI_F03_OB_SIZE;
>  	u8 obs[RMI_F03_QUEUE_LENGTH * RMI_F03_OB_SIZE];
>  	u8 ob_status;
> +	static u8 ob_dataArry[RELATIVE_PACKET_SIZE];
>  	u8 ob_data;
>  	unsigned int serio_flags;
> +	static unsigned int serio_flagsArry[RELATIVE_PACKET_SIZE];

Please drop these 2 static arrays here and instead store the info in
the f03_data struct.

>  	int i;
> +

Unrelated whitespace change, please drop.

>  	int error;
>  
>  	if (drvdata->attn_data.data) {
> @@ -284,6 +294,22 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
>  		ob_data = obs[i + RMI_F03_OB_DATA_OFFSET];
>  		serio_flags = 0;
>  
> +		if (ob_status & (RMI_F03_OB_FLAG_TIMEOUT | RMI_F03_OB_FLAG_PARITY)) {
> +			//  Send resend command to stick when timeout or parity error.
> +			//  Driver can receive the last stick packet.
> +
> +			error = rmi_write(f03->fn->rmi_dev, f03->fn->fd.data_base_addr,
> +			 RMI_F03_RESET_STYK);
> +			if (error) {
> +				dev_err(&f03->fn->dev,
> +					"%s: Failed to rmi_write to F03 TX register (%d).\n",
> +					__func__, error);
> +				return error;
> +			}
> +			ipacketindex = 0;
> +			break;
> +		}
> +
>  		if (!(ob_status & RMI_F03_RX_DATA_OFB))
>  			continue;
>  
> @@ -298,9 +324,57 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
>  			serio_flags & SERIO_TIMEOUT ?  'Y' : 'N',
>  			serio_flags & SERIO_PARITY ? 'Y' : 'N');
>  
> -		serio_interrupt(f03->serio, ob_data, serio_flags);
> +		if (iwritecommandcounter > 0) {
> +			// Read Acknowledge Byte after writing the PS2 command.
> +			// It is not trackpoint data.
> +			serio_interrupt(f03->serio, ob_data, serio_flags);
> +
> +		} else {
> +			//   The relative-mode PS/2 packet format is as follows:
> +			//
> +			//              bit position            position (as array of bytes)
> +			//     7   6   5   4   3   2   1   0
> +			//   =================================+
> +			//    Yov Xov DY8 DX8  1   M   R   L  | DATA[0]
> +			//                DX[7:0]             | DATA[1]
> +			//                DY[7:0]             | DATA[2]
> +			//   =================================+
> +			//		Yov: Y overflow
> +			//    Xov: X overflow
> +			if ((ipacketindex == 0) && (ob_data & ((BIT(7)|BIT(6))))) {
> +				dev_err(&f03->fn->dev,
> +				"%s: X or Y is overflow. (%x)\n",
> +				__func__, ob_data);
> +				break;
> +			} else if ((ipacketindex == 0) && !(ob_data & BIT(3))) {
> +				dev_err(&f03->fn->dev,
> +				"%s: New BIT 3 is not 1 for the first byte\n",
> +				__func__);

Why no break; here like above ?

> +			} else {
> +				if (ipacketindex >= RELATIVE_PACKET_SIZE) {
> +					ipacketindex = 0;

This means that you are skipping every 4th byte, since you only store
the ob_data + serio_flags the next cycle through the loop!

> +				} else {
> +					ob_dataArry[ipacketindex] = ob_data;
> +					serio_flagsArry[ipacketindex] = serio_flags;
> +					ipacketindex++;
> +				}
> +				if (ipacketindex == RELATIVE_PACKET_SIZE)	{
> +					serio_interrupt(f03->serio, ob_dataArry[0],
> +					 serio_flagsArry[0]);
> +					serio_interrupt(f03->serio, ob_dataArry[1],
> +					 serio_flagsArry[1]);
> +					serio_interrupt(f03->serio, ob_dataArry[2],
> +					 serio_flagsArry[2]);
> +					ipacketindex = 0;
> +				}
> +			}
> +		}
>  	}
>  
> +	if (iwritecommandcounter > 0) {
> +		ipacketindex = 0;
> +		iwritecommandcounter = iwritecommandcounter - 1;
> +	}

You check iwritecommandcounter inside the:

        for (i = 0; i < ob_len; i += RMI_F03_OB_SIZE) {

loop, I understand that you want to forward the entire PS/2 response
data and only decrement iwritecommandcounter once, but what if
the rmi_f03_attention() did not contain any OOB data at all ?

I believe that in that case iwritecommandcounter should not be
decremented ?

Regards,

Hans

