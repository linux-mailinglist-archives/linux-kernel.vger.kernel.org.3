Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1102592DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiHOLMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiHOLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31B0717AAD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660561923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLIvWJoaKsBToa2OjdmBppry5f+hWPPKPJLweAi/lmE=;
        b=HiS44VquQenNKfExrvPNR8QPdWubJNEjv65Mb6wBDurUbLc6kAKutpqKx88YiH3acX8d3R
        Fa5bzTBiYShtW0NoFPgbeazP68yc2tJofOpFItR1sR6cDW31aE6q0GWRCIs2NNFxgs32YK
        G0MIM08ECZym5SKauFaQ6H/A/h4q8DI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-x1YDrNG_NiikP5iE9VmLNQ-1; Mon, 15 Aug 2022 07:12:01 -0400
X-MC-Unique: x1YDrNG_NiikP5iE9VmLNQ-1
Received: by mail-ej1-f72.google.com with SMTP id sd6-20020a1709076e0600b0073315809fb5so999846ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pLIvWJoaKsBToa2OjdmBppry5f+hWPPKPJLweAi/lmE=;
        b=ZsfClOxombYFo8gS+egDq/S1pJFfNXQr38nTK3Crds1V+1kQLXOul8/jYyi8zcqkJr
         5vn9jd/EA16ugvlvqGEevRyFgFg1oF9mfFVXcPXf51A/JIjnfSVtnot99Y/82w5WdspY
         bTC4y+A25uVK/l9sqEn/HFdtBaeY/eSm/nYHw03Shu6FH8XANdD9aJftj5r/DelNsOYH
         Lh1nRQTSVNbQm75qDd7g9zr3bvlCH3MxHa10TGm7ovlYuw7f7P46wYLuniCUH4s6gX6f
         4aMcN+qmh0/q4IT0Qbn2c68G5n+mcfv9GivklcS0K1y9qsZpPQm6tKTxzQUu3xHSVpqs
         iUsA==
X-Gm-Message-State: ACgBeo2xvvgsJh/YeFMyiwWXg0flnRkUxhDLNfLiPa4rlsdXRKSAKF75
        0QW3GhEdSe9TNC/TjYI4ZpfvXJDc34aTQin6sE/9wws/v1l58p8yzbTAlRU+pLOsCbW9LafVD5U
        2VNXxL+Ilpx03Aw0Emn1w3Dq4
X-Received: by 2002:aa7:d58e:0:b0:443:9d64:5877 with SMTP id r14-20020aa7d58e000000b004439d645877mr6169609edq.18.1660561920888;
        Mon, 15 Aug 2022 04:12:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR707GczBpKnxanO1QI8AkizmjVMkepys8pnmIeYwtyMBfi8nAA61VSWCIxJVg34/X7cNEHlAA==
X-Received: by 2002:aa7:d58e:0:b0:443:9d64:5877 with SMTP id r14-20020aa7d58e000000b004439d645877mr6169597edq.18.1660561920710;
        Mon, 15 Aug 2022 04:12:00 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ch15-20020a0564021bcf00b00440a1888e00sm6441556edb.59.2022.08.15.04.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 04:12:00 -0700 (PDT)
Message-ID: <7d6718e0-5dfa-c688-8ae3-1cf8d0eba79c@redhat.com>
Date:   Mon, 15 Aug 2022 13:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V3] Input: synaptics-rmi4 - filter incomplete relative
 packet.
Content-Language: en-US
To:     margeyang <marge.yang@synaptics.corp-partner.google.com>,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
Cc:     marge.yang@tw.synaptics.com, derek.cheng@tw.synaptics.com,
        vincent.huang@tw.synaptics.com
References: <1660559273-5387-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1660559273-5387-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/15/22 12:27, margeyang wrote:
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
>  drivers/input/rmi4/rmi_f03.c | 77 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
> index c194b1664b10..05076db83808 100644
> --- a/drivers/input/rmi4/rmi_f03.c
> +++ b/drivers/input/rmi4/rmi_f03.c
> @@ -23,8 +23,12 @@
>  #define RMI_F03_BYTES_PER_DEVICE_SHIFT	4
>  #define RMI_F03_QUEUE_LENGTH		0x0F
>  
> +#define RMI_F03_RESET_STYK		0xFE
> +
>  #define PSMOUSE_OOB_EXTRA_BTNS		0x01
>  
> +#define RELATIVE_PACKET_SIZE		3
> +
>  struct f03_data {
>  	struct rmi_function *fn;
>  
> @@ -33,6 +37,11 @@ struct f03_data {
>  
>  	unsigned int overwrite_buttons;
>  
> +	int iwritecommandcounter;
> +	unsigned int ipacketindex;
> +	unsigned int serio_flagsArry[RELATIVE_PACKET_SIZE];
> +	u8 ob_dataArry[RELATIVE_PACKET_SIZE];
> +
>  	u8 device_count;
>  	u8 rx_queue_length;
>  };
> @@ -88,6 +97,7 @@ static int rmi_f03_pt_write(struct serio *id, unsigned char val)
>  		return error;
>  	}
>  
> +	f03->iwritecommandcounter++;
>  	return 0;
>  }
>  
> @@ -107,6 +117,8 @@ static int rmi_f03_initialize(struct f03_data *f03)
>  		return error;
>  	}
>  
> +	f03->iwritecommandcounter = 0;
> +	f03->ipacketindex = 0;
>  	f03->device_count = query1 & RMI_F03_DEVICE_COUNT;
>  	bytes_per_device = (query1 >> RMI_F03_BYTES_PER_DEVICE_SHIFT) &
>  				RMI_F03_BYTES_PER_DEVICE;
> @@ -284,6 +296,22 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
>  		ob_data = obs[i + RMI_F03_OB_DATA_OFFSET];
>  		serio_flags = 0;
>  
> +		if (ob_status & (RMI_F03_OB_FLAG_TIMEOUT | RMI_F03_OB_FLAG_PARITY)) {
> +			//  Send resend command to stick when timeout or parity error.
> +			//  Driver can receive the last stick packet.
> +			unsigned char val = RMI_F03_RESET_STYK;
> +
> +			error = rmi_write(f03->fn->rmi_dev, f03->fn->fd.data_base_addr, val);
> +			if (error) {
> +				dev_err(&f03->fn->dev,
> +					"%s: Failed to rmi_write to F03 TX register (%d).\n",
> +					__func__, error);
> +				return error;
> +			}
> +			f03->ipacketindex = 0;
> +			break;
> +		}
> +
>  		if (!(ob_status & RMI_F03_RX_DATA_OFB))
>  			continue;
>  
> @@ -298,7 +326,54 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
>  			serio_flags & SERIO_TIMEOUT ?  'Y' : 'N',
>  			serio_flags & SERIO_PARITY ? 'Y' : 'N');
>  
> -		serio_interrupt(f03->serio, ob_data, serio_flags);
> +		if (f03->iwritecommandcounter > 0) {
> +			// Read Acknowledge Byte after writing the PS2 command.
> +			// It is not trackpoint data.
> +			serio_interrupt(f03->serio, ob_data, serio_flags);
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
> +			if ((f03->ipacketindex == 0) && (ob_data & ((BIT(7)|BIT(6))))) {
> +				dev_err(&f03->fn->dev,
> +				"%s: X or Y is overflow. (%x)\n",
> +				__func__, ob_data);
> +				break;
> +			} else if ((f03->ipacketindex == 0) && !(ob_data & BIT(3))) {
> +				dev_err(&f03->fn->dev,
> +				"%s: New BIT 3 is not 1 for the first byte\n",
> +				__func__);
> +				break;
> +			}
> +			if (f03->ipacketindex >= RELATIVE_PACKET_SIZE)
> +				f03->ipacketindex = 0;

(f03->ipacketindex >= RELATIVE_PACKET_SIZE) is never true at this point, since it
gets reset to 0 when it reaches RELATIVE_PACKET_SIZE below already.

So these 2 lines can be dropped.

Regards,

Hans



> +
> +			f03->ob_dataArry[f03->ipacketindex] = ob_data;
> +			f03->serio_flagsArry[f03->ipacketindex] = serio_flags;
> +			f03->ipacketindex++;
> +
> +			if (f03->ipacketindex == RELATIVE_PACKET_SIZE)	{
> +				serio_interrupt(f03->serio, f03->ob_dataArry[0],
> +				 f03->serio_flagsArry[0]);
> +				serio_interrupt(f03->serio, f03->ob_dataArry[1],
> +				 f03->serio_flagsArry[1]);
> +				serio_interrupt(f03->serio, f03->ob_dataArry[2],
> +				 f03->serio_flagsArry[2]);
> +				f03->ipacketindex = 0;
> +			}
> +		}
> +	}
> +	if (f03->iwritecommandcounter > 0) {
> +		f03->ipacketindex = 0;
> +		f03->iwritecommandcounter = f03->iwritecommandcounter - 1;
>  	}
>  
>  	return IRQ_HANDLED;

