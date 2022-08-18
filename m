Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A687559910D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbiHRXN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiHRXNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:13:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB0218B;
        Thu, 18 Aug 2022 16:13:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so3301733pjl.0;
        Thu, 18 Aug 2022 16:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=71WU1tSryIfzAsh7GgKK1cxDQTcuKciCw5vj5eWtlaw=;
        b=Z8rM6gXlyNZ9DCZSyoetAJEXK/RJIGD+AmHfc0rBaw7kUXP/Y7TXvT9whn/qbvKX33
         v0CICzEpsNpOStqe+FO+oi+3nsIK5NHXB7dRjml5aB7gPRZf3ZvRAmBwha0n2uqkqoRu
         SJFwXOF/K0qFFv4T2QxnMg06C6StdKE3rG4LzjuY3WOBOJpsMxn/04Sa9sbvMUaI4Svb
         Y22NJagvxUWxKttNIgCRBW9ry25MEqRjgUyDfhK9679f9nl92lgcCR4fdneHdwcAps/o
         vhpu6Cm4CQft8PZ1Q3UlIDjBvxZk4VPlbzz8U/rQy28xhqOQA6YdcdK1CdTmUi+IoK3f
         XKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=71WU1tSryIfzAsh7GgKK1cxDQTcuKciCw5vj5eWtlaw=;
        b=QwzfAtjMz8RLNiKSMSdjO8vtNqyIRzg6EpgvuEYqPIsscmgOz0M0Io5XhPuGNGhvwZ
         +h0eycIZbSnkqJQukHZjuZ9bg/faXxE6epDHAUUc7GmaKk7RiMZgvhVgVWoG9iB4BWvN
         GUfVdVvQLxVF4sDagSxEkAhxzkpkK6FeixEgxszeufgjMCOzVLAS8Dt8+My59bTC3URG
         fyagh+nSdEnUSjURTzfql7LoYKlDfGREP3O1kEiWPmfTXJYvdiVaV6lsBIDBhvuCjeSX
         cTiZKQxy4L6AUKclxylG0xZBFLGzaYVB7pf6HlAJfAGP+VVt61LnaR1/qeeG/JZ+kDAK
         qRRA==
X-Gm-Message-State: ACgBeo0dQbKTyFxFMq1AGyESOixnfMHv0qrxXCH0W5PtilEoPN5lkyh9
        3BlY+gadi7bzsHooYo2opv3yjhE7dJc=
X-Google-Smtp-Source: AA6agR7cBOkWN8BHYZkqjyWGZ7sJfcoZTpYSL2ZmkuG83MpV6dkVvmO5gxbt+C1ZfDuFXV+i/AFxjQ==
X-Received: by 2002:a17:903:11c7:b0:170:cde7:d24a with SMTP id q7-20020a17090311c700b00170cde7d24amr4612138plh.91.1660864392659;
        Thu, 18 Aug 2022 16:13:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b0016d1f474653sm1928472plk.52.2022.08.18.16.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:13:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 16:13:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        George Joseph <george.joseph@fairview5.com>,
        Juerg Haefliger <juergh@gmail.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Riku Voipio <riku.voipio@iki.fi>,
        Guillaume Ligneul <guillaume.ligneul@gmail.com>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: move from strlcpy with unused retval to strscpy
Message-ID: <20220818231310.GA3505377@roeck-us.net>
References: <20220818210014.6769-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818210014.6769-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:00:11PM +0200, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/adc128d818.c  |  2 +-
>  drivers/hwmon/adm1021.c     |  2 +-
>  drivers/hwmon/adm1025.c     |  2 +-
>  drivers/hwmon/adm1026.c     |  2 +-
>  drivers/hwmon/adm1029.c     |  2 +-
>  drivers/hwmon/adm1031.c     |  2 +-
>  drivers/hwmon/adt7411.c     |  2 +-
>  drivers/hwmon/adt7462.c     |  2 +-
>  drivers/hwmon/adt7475.c     |  2 +-
>  drivers/hwmon/amc6821.c     |  2 +-
>  drivers/hwmon/asb100.c      |  2 +-
>  drivers/hwmon/asc7621.c     |  2 +-
>  drivers/hwmon/dme1737.c     |  2 +-
>  drivers/hwmon/emc1403.c     | 12 ++++++------
>  drivers/hwmon/emc2103.c     |  2 +-
>  drivers/hwmon/emc6w201.c    |  2 +-
>  drivers/hwmon/f75375s.c     |  2 +-
>  drivers/hwmon/fschmd.c      |  2 +-
>  drivers/hwmon/ftsteutates.c |  2 +-
>  drivers/hwmon/gl518sm.c     |  2 +-
>  drivers/hwmon/gl520sm.c     |  2 +-
>  drivers/hwmon/jc42.c        |  2 +-
>  drivers/hwmon/lm63.c        |  6 +++---
>  drivers/hwmon/lm73.c        |  2 +-
>  drivers/hwmon/lm75.c        |  2 +-
>  drivers/hwmon/lm77.c        |  2 +-
>  drivers/hwmon/lm78.c        |  2 +-
>  drivers/hwmon/lm80.c        |  2 +-
>  drivers/hwmon/lm83.c        |  2 +-
>  drivers/hwmon/lm85.c        |  2 +-
>  drivers/hwmon/lm87.c        |  2 +-
>  drivers/hwmon/lm90.c        |  2 +-
>  drivers/hwmon/lm92.c        |  2 +-
>  drivers/hwmon/lm93.c        |  2 +-
>  drivers/hwmon/lm95234.c     |  2 +-
>  drivers/hwmon/lm95241.c     |  2 +-
>  drivers/hwmon/lm95245.c     |  2 +-
>  drivers/hwmon/max1619.c     |  2 +-
>  drivers/hwmon/max1668.c     |  2 +-
>  drivers/hwmon/max31730.c    |  2 +-
>  drivers/hwmon/max6639.c     |  2 +-
>  drivers/hwmon/max6642.c     |  2 +-
>  drivers/hwmon/nct7802.c     |  2 +-
>  drivers/hwmon/nct7904.c     |  2 +-
>  drivers/hwmon/smsc47m192.c  |  2 +-
>  drivers/hwmon/stts751.c     |  2 +-
>  drivers/hwmon/thmc50.c      |  2 +-
>  drivers/hwmon/tmp401.c      |  2 +-
>  drivers/hwmon/tmp421.c      |  2 +-
>  drivers/hwmon/w83781d.c     |  2 +-
>  drivers/hwmon/w83791d.c     |  2 +-
>  drivers/hwmon/w83792d.c     |  2 +-
>  drivers/hwmon/w83793.c      |  2 +-
>  drivers/hwmon/w83795.c      |  2 +-
>  drivers/hwmon/w83l785ts.c   |  2 +-
>  drivers/hwmon/w83l786ng.c   |  2 +-
>  56 files changed, 63 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
> index fd938c70293f..e7b9578631ec 100644
> --- a/drivers/hwmon/adc128d818.c
> +++ b/drivers/hwmon/adc128d818.c
> @@ -384,7 +384,7 @@ static int adc128_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	if (i2c_smbus_read_byte_data(client, ADC128_REG_BUSY_STATUS) & 0xfc)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "adc128d818", I2C_NAME_SIZE);
> +	strscpy(info->type, "adc128d818", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
> index 91ecfee243bf..2dc45e958730 100644
> --- a/drivers/hwmon/adm1021.c
> +++ b/drivers/hwmon/adm1021.c
> @@ -426,7 +426,7 @@ static int adm1021_detect(struct i2c_client *client,
>  
>  	pr_debug("Detected chip %s at adapter %d, address 0x%02x.\n",
>  		 type_name, i2c_adapter_id(adapter), client->addr);
> -	strlcpy(info->type, type_name, I2C_NAME_SIZE);
> +	strscpy(info->type, type_name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
> index 4352f6a884e8..2984c4f98496 100644
> --- a/drivers/hwmon/adm1025.c
> +++ b/drivers/hwmon/adm1025.c
> @@ -470,7 +470,7 @@ static int adm1025_detect(struct i2c_client *client,
>  	else
>  		return -ENODEV;
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
> index 69b3ec752944..1f084f708743 100644
> --- a/drivers/hwmon/adm1026.c
> +++ b/drivers/hwmon/adm1026.c
> @@ -1610,7 +1610,7 @@ static int adm1026_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "adm1026", I2C_NAME_SIZE);
> +	strscpy(info->type, "adm1026", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
> index 3e1999413f32..eaf6e5e04aac 100644
> --- a/drivers/hwmon/adm1029.c
> +++ b/drivers/hwmon/adm1029.c
> @@ -329,7 +329,7 @@ static int adm1029_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "adm1029", I2C_NAME_SIZE);
> +	strscpy(info->type, "adm1029", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> index ac841fa3a369..b42797bcb5b4 100644
> --- a/drivers/hwmon/adm1031.c
> +++ b/drivers/hwmon/adm1031.c
> @@ -985,7 +985,7 @@ static int adm1031_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	name = (id == 0x30) ? "adm1030" : "adm1031";
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
> index fad74aa62b64..bf5c5618f8d0 100644
> --- a/drivers/hwmon/adt7411.c
> +++ b/drivers/hwmon/adt7411.c
> @@ -590,7 +590,7 @@ static int adt7411_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "adt7411", I2C_NAME_SIZE);
> +	strscpy(info->type, "adt7411", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
> index e75bbd87ad09..9c0235849d4b 100644
> --- a/drivers/hwmon/adt7462.c
> +++ b/drivers/hwmon/adt7462.c
> @@ -1782,7 +1782,7 @@ static int adt7462_detect(struct i2c_client *client,
>  	if (revision != ADT7462_REVISION)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "adt7462", I2C_NAME_SIZE);
> +	strscpy(info->type, "adt7462", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index ac480e6e4818..51b3d16c3223 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -1342,7 +1342,7 @@ static int adt7475_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 0c16face3fd3..3bfd12ff4b3c 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -809,7 +809,7 @@ static int amc6821_detect(
>  	}
>  
>  	dev_info(&adapter->dev, "amc6821: chip found at 0x%02x.\n", address);
> -	strlcpy(info->type, "amc6821", I2C_NAME_SIZE);
> +	strscpy(info->type, "amc6821", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
> index 8cf0bcb85eb4..45bedf619457 100644
> --- a/drivers/hwmon/asb100.c
> +++ b/drivers/hwmon/asb100.c
> @@ -769,7 +769,7 @@ static int asb100_detect(struct i2c_client *client,
>  	if (val1 != 0x31 || val2 != 0x06)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "asb100", I2C_NAME_SIZE);
> +	strscpy(info->type, "asb100", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
> index e835605a7456..8385dadf7e19 100644
> --- a/drivers/hwmon/asc7621.c
> +++ b/drivers/hwmon/asc7621.c
> @@ -1153,7 +1153,7 @@ static int asc7621_detect(struct i2c_client *client,
>  
>  		if (company == asc7621_chips[chip_index].company_id &&
>  		    verstep == asc7621_chips[chip_index].verstep_id) {
> -			strlcpy(info->type, asc7621_chips[chip_index].name,
> +			strscpy(info->type, asc7621_chips[chip_index].name,
>  				I2C_NAME_SIZE);
>  
>  			dev_info(&adapter->dev, "Matched %s at 0x%02x\n",
> diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
> index e3ad4c2d0038..ae309e90477a 100644
> --- a/drivers/hwmon/dme1737.c
> +++ b/drivers/hwmon/dme1737.c
> @@ -2456,7 +2456,7 @@ static int dme1737_i2c_detect(struct i2c_client *client,
>  	dev_info(dev, "Found a %s chip at 0x%02x (rev 0x%02x).\n",
>  		 verstep == SCH5027_VERSTEP ? "SCH5027" : "DME1737",
>  		 client->addr, verstep);
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index 314838272049..61d59189a6d1 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -329,22 +329,22 @@ static int emc1403_detect(struct i2c_client *client,
>  	id = i2c_smbus_read_byte_data(client, THERMAL_PID_REG);
>  	switch (id) {
>  	case 0x20:
> -		strlcpy(info->type, "emc1402", I2C_NAME_SIZE);
> +		strscpy(info->type, "emc1402", I2C_NAME_SIZE);
>  		break;
>  	case 0x21:
> -		strlcpy(info->type, "emc1403", I2C_NAME_SIZE);
> +		strscpy(info->type, "emc1403", I2C_NAME_SIZE);
>  		break;
>  	case 0x22:
> -		strlcpy(info->type, "emc1422", I2C_NAME_SIZE);
> +		strscpy(info->type, "emc1422", I2C_NAME_SIZE);
>  		break;
>  	case 0x23:
> -		strlcpy(info->type, "emc1423", I2C_NAME_SIZE);
> +		strscpy(info->type, "emc1423", I2C_NAME_SIZE);
>  		break;
>  	case 0x25:
> -		strlcpy(info->type, "emc1404", I2C_NAME_SIZE);
> +		strscpy(info->type, "emc1404", I2C_NAME_SIZE);
>  		break;
>  	case 0x27:
> -		strlcpy(info->type, "emc1424", I2C_NAME_SIZE);
> +		strscpy(info->type, "emc1424", I2C_NAME_SIZE);
>  		break;
>  	default:
>  		return -ENODEV;
> diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
> index e4c95ca9e19f..361cf9292456 100644
> --- a/drivers/hwmon/emc2103.c
> +++ b/drivers/hwmon/emc2103.c
> @@ -643,7 +643,7 @@ emc2103_detect(struct i2c_client *new_client, struct i2c_board_info *info)
>  	if ((product != 0x24) && (product != 0x26))
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "emc2103", I2C_NAME_SIZE);
> +	strscpy(info->type, "emc2103", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
> index 29082c8463f4..bcd93f0fe982 100644
> --- a/drivers/hwmon/emc6w201.c
> +++ b/drivers/hwmon/emc6w201.c
> @@ -439,7 +439,7 @@ static int emc6w201_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "emc6w201", I2C_NAME_SIZE);
> +	strscpy(info->type, "emc6w201", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index 57c8a473698d..8a469b2df5e1 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -897,7 +897,7 @@ static int f75375_detect(struct i2c_client *client,
>  
>  	version = f75375_read8(client, F75375_REG_VERSION);
>  	dev_info(&adapter->dev, "found %s version: %02X\n", name, version);
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
> index c26195e3aad7..82652990063a 100644
> --- a/drivers/hwmon/fschmd.c
> +++ b/drivers/hwmon/fschmd.c
> @@ -1075,7 +1075,7 @@ static int fschmd_detect(struct i2c_client *client,
>  	else
>  		return -ENODEV;
>  
> -	strlcpy(info->type, fschmd_id[kind].name, I2C_NAME_SIZE);
> +	strscpy(info->type, fschmd_id[kind].name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
> index ceffc76a0c51..bb26ca97abbd 100644
> --- a/drivers/hwmon/ftsteutates.c
> +++ b/drivers/hwmon/ftsteutates.c
> @@ -739,7 +739,7 @@ static int fts_detect(struct i2c_client *client,
>  	if (val != 0x11)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, fts_id[0].name, I2C_NAME_SIZE);
> +	strscpy(info->type, fts_id[0].name, I2C_NAME_SIZE);
>  	info->flags = 0;
>  	return 0;
>  }
> diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
> index dd683b0a648f..95286c40f55a 100644
> --- a/drivers/hwmon/gl518sm.c
> +++ b/drivers/hwmon/gl518sm.c
> @@ -586,7 +586,7 @@ static int gl518_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	if (rev != 0x00 && rev != 0x80)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "gl518sm", I2C_NAME_SIZE);
> +	strscpy(info->type, "gl518sm", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
> index 096ba9797211..394da4ac977c 100644
> --- a/drivers/hwmon/gl520sm.c
> +++ b/drivers/hwmon/gl520sm.c
> @@ -811,7 +811,7 @@ static int gl520_detect(struct i2c_client *client, struct i2c_board_info *info)
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "gl520sm", I2C_NAME_SIZE);
> +	strscpy(info->type, "gl520sm", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index 07f7f8b5b73d..8379a5da46b8 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -441,7 +441,7 @@ static int jc42_detect(struct i2c_client *client, struct i2c_board_info *info)
>  		struct jc42_chips *chip = &jc42_chips[i];
>  		if (manid == chip->manid &&
>  		    (devid & chip->devid_mask) == chip->devid) {
> -			strlcpy(info->type, "jc42", I2C_NAME_SIZE);
> +			strscpy(info->type, "jc42", I2C_NAME_SIZE);
>  			return 0;
>  		}
>  	}
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index 339a145afc09..9ab2cab4c710 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -996,11 +996,11 @@ static int lm63_detect(struct i2c_client *client,
>  	}
>  
>  	if (chip_id == 0x41 && address == 0x4c)
> -		strlcpy(info->type, "lm63", I2C_NAME_SIZE);
> +		strscpy(info->type, "lm63", I2C_NAME_SIZE);
>  	else if (chip_id == 0x51 && (address == 0x18 || address == 0x4e))
> -		strlcpy(info->type, "lm64", I2C_NAME_SIZE);
> +		strscpy(info->type, "lm64", I2C_NAME_SIZE);
>  	else if (chip_id == 0x49 && address == 0x4c)
> -		strlcpy(info->type, "lm96163", I2C_NAME_SIZE);
> +		strscpy(info->type, "lm96163", I2C_NAME_SIZE);
>  	else
>  		return -ENODEV;
>  
> diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
> index beb0d61bcd82..1346b3b3f463 100644
> --- a/drivers/hwmon/lm73.c
> +++ b/drivers/hwmon/lm73.c
> @@ -257,7 +257,7 @@ static int lm73_detect(struct i2c_client *new_client,
>  	if (id < 0 || id != LM73_ID)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "lm73", I2C_NAME_SIZE);
> +	strscpy(info->type, "lm73", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 66dc826f7962..bcc3adcb3af1 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -893,7 +893,7 @@ static int lm75_detect(struct i2c_client *new_client,
>  			return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, is_lm75a ? "lm75a" : "lm75", I2C_NAME_SIZE);
> +	strscpy(info->type, is_lm75a ? "lm75a" : "lm75", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
> index df6af85e170a..645cb2191abe 100644
> --- a/drivers/hwmon/lm77.c
> +++ b/drivers/hwmon/lm77.c
> @@ -302,7 +302,7 @@ static int lm77_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	 || i2c_smbus_read_word_data(client, 7) != min)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "lm77", I2C_NAME_SIZE);
> +	strscpy(info->type, "lm77", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
> index 5e129cbec1cb..694e171cab7f 100644
> --- a/drivers/hwmon/lm78.c
> +++ b/drivers/hwmon/lm78.c
> @@ -617,7 +617,7 @@ static int lm78_i2c_detect(struct i2c_client *client,
>  	if (isa)
>  		mutex_unlock(&isa->update_lock);
>  
> -	strlcpy(info->type, client_name, I2C_NAME_SIZE);
> +	strscpy(info->type, client_name, I2C_NAME_SIZE);
>  
>  	return 0;
>  
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index e85e062bbf32..35db0b97f912 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -586,7 +586,7 @@ static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
>  		name = "lm80";
>  	}
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
> index 905f5689f907..616449f2cc50 100644
> --- a/drivers/hwmon/lm83.c
> +++ b/drivers/hwmon/lm83.c
> @@ -412,7 +412,7 @@ static int lm83_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index 88cf2012d34b..8d33c2484755 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -1539,7 +1539,7 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	if (!type_name)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, type_name, I2C_NAME_SIZE);
> +	strscpy(info->type, type_name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
> index 1750bc588856..818fb6195245 100644
> --- a/drivers/hwmon/lm87.c
> +++ b/drivers/hwmon/lm87.c
> @@ -833,7 +833,7 @@ static int lm87_detect(struct i2c_client *client, struct i2c_board_info *info)
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 221de01a327a..c151c0bf43f2 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -2547,7 +2547,7 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
> index 5bae6eedcaf1..2ff3044a677d 100644
> --- a/drivers/hwmon/lm92.c
> +++ b/drivers/hwmon/lm92.c
> @@ -287,7 +287,7 @@ static int lm92_detect(struct i2c_client *new_client,
>  	else
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "lm92", I2C_NAME_SIZE);
> +	strscpy(info->type, "lm92", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> index dc67bf954b21..4cf50d5f4f59 100644
> --- a/drivers/hwmon/lm93.c
> +++ b/drivers/hwmon/lm93.c
> @@ -2575,7 +2575,7 @@ static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  	dev_dbg(&adapter->dev, "loading %s at %d, 0x%02x\n",
>  		client->name, i2c_adapter_id(client->adapter),
>  		client->addr);
> diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
> index ac169a994ae0..b4a9d0c223c4 100644
> --- a/drivers/hwmon/lm95234.c
> +++ b/drivers/hwmon/lm95234.c
> @@ -644,7 +644,7 @@ static int lm95234_detect(struct i2c_client *client,
>  	if (val & model_mask)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  	return 0;
>  }
>  
> diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
> index 8ea46ff20be5..f1ed777a8735 100644
> --- a/drivers/hwmon/lm95241.c
> +++ b/drivers/hwmon/lm95241.c
> @@ -389,7 +389,7 @@ static int lm95241_detect(struct i2c_client *new_client,
>  	}
>  
>  	/* Fill the i2c board info */
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  	return 0;
>  }
>  
> diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
> index 29388fcf5f74..c433f0af2d31 100644
> --- a/drivers/hwmon/lm95245.c
> +++ b/drivers/hwmon/lm95245.c
> @@ -461,7 +461,7 @@ static int lm95245_detect(struct i2c_client *new_client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	strscpy(info->type, name, I2C_NAME_SIZE);
>  	return 0;
>  }
>  
> diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
> index eae9e68027bc..445c77197f69 100644
> --- a/drivers/hwmon/max1619.c
> +++ b/drivers/hwmon/max1619.c
> @@ -241,7 +241,7 @@ static int max1619_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "max1619", I2C_NAME_SIZE);
> +	strscpy(info->type, "max1619", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
> index 78688e6cb87d..9f748973d6a3 100644
> --- a/drivers/hwmon/max1668.c
> +++ b/drivers/hwmon/max1668.c
> @@ -386,7 +386,7 @@ static int max1668_detect(struct i2c_client *client,
>  	if (!type_name)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, type_name, I2C_NAME_SIZE);
> +	strscpy(info->type, type_name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/max31730.c b/drivers/hwmon/max31730.c
> index 23598b8b8793..9bdff881f59c 100644
> --- a/drivers/hwmon/max31730.c
> +++ b/drivers/hwmon/max31730.c
> @@ -399,7 +399,7 @@ static int max31730_detect(struct i2c_client *client,
>  			return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "max31730", I2C_NAME_SIZE);
> +	strscpy(info->type, "max31730", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 14bb7726f8d7..936861131d74 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -514,7 +514,7 @@ static int max6639_detect(struct i2c_client *client,
>  	if (dev_id != 0x58 || manu_id != 0x4D)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "max6639", I2C_NAME_SIZE);
> +	strscpy(info->type, "max6639", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
> index 699d265aae2e..47ea34ff78f3 100644
> --- a/drivers/hwmon/max6642.c
> +++ b/drivers/hwmon/max6642.c
> @@ -148,7 +148,7 @@ static int max6642_detect(struct i2c_client *client,
>  	if ((reg_status & 0x2b) != 0x00)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "max6642", I2C_NAME_SIZE);
> +	strscpy(info->type, "max6642", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index d1eeef02b6dc..a175f8283695 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -1038,7 +1038,7 @@ static int nct7802_detect(struct i2c_client *client,
>  	if (reg < 0 || (reg & 0x3f))
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "nct7802", I2C_NAME_SIZE);
> +	strscpy(info->type, "nct7802", I2C_NAME_SIZE);
>  	return 0;
>  }
>  
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index b1c837fc407a..ecc5db0011a3 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -798,7 +798,7 @@ static int nct7904_detect(struct i2c_client *client,
>  	    (i2c_smbus_read_byte_data(client, BANK_SEL_REG) & 0xf8) != 0x00)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "nct7904", I2C_NAME_SIZE);
> +	strscpy(info->type, "nct7904", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
> index a5db15c087ae..70d2152234e2 100644
> --- a/drivers/hwmon/smsc47m192.c
> +++ b/drivers/hwmon/smsc47m192.c
> @@ -582,7 +582,7 @@ static int smsc47m192_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "smsc47m192", I2C_NAME_SIZE);
> +	strscpy(info->type, "smsc47m192", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/stts751.c b/drivers/hwmon/stts751.c
> index 0ed28408aa07..2f67c6747ead 100644
> --- a/drivers/hwmon/stts751.c
> +++ b/drivers/hwmon/stts751.c
> @@ -692,7 +692,7 @@ static int stts751_detect(struct i2c_client *new_client,
>  	}
>  	dev_dbg(&new_client->dev, "Chip %s detected", name);
>  
> -	strlcpy(info->type, stts751_id[0].name, I2C_NAME_SIZE);
> +	strscpy(info->type, stts751_id[0].name, I2C_NAME_SIZE);
>  	return 0;
>  }
>  
> diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
> index 6a804f5036f4..81cdb012993c 100644
> --- a/drivers/hwmon/thmc50.c
> +++ b/drivers/hwmon/thmc50.c
> @@ -352,7 +352,7 @@ static int thmc50_detect(struct i2c_client *client,
>  	pr_debug("thmc50: Detected %s (version %x, revision %x)\n",
>  		 type_name, (revision >> 4) - 0xc, revision & 0xf);
>  
> -	strlcpy(info->type, type_name, I2C_NAME_SIZE);
> +	strscpy(info->type, type_name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index cc0a1c219b1f..f358ba679626 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -671,7 +671,7 @@ static int tmp401_detect(struct i2c_client *client,
>  	if (reg > 15)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, tmp401_id[kind].name, I2C_NAME_SIZE);
> +	strscpy(info->type, tmp401_id[kind].name, I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index 1fd8d41d90c8..45fd7fb5ee01 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -353,7 +353,7 @@ static int tmp421_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, tmp421_id[kind].name, I2C_NAME_SIZE);
> +	strscpy(info->type, tmp421_id[kind].name, I2C_NAME_SIZE);
>  	dev_info(&adapter->dev, "Detected TI %s chip at 0x%02x\n",
>  		 names[kind], client->addr);
>  
> diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> index b3579721265f..35a847dfce68 100644
> --- a/drivers/hwmon/w83781d.c
> +++ b/drivers/hwmon/w83781d.c
> @@ -1171,7 +1171,7 @@ w83781d_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	if (isa)
>  		mutex_unlock(&isa->update_lock);
>  
> -	strlcpy(info->type, client_name, I2C_NAME_SIZE);
> +	strscpy(info->type, client_name, I2C_NAME_SIZE);
>  
>  	return 0;
>  
> diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
> index 80a9a78d7ce9..85ea408e28d1 100644
> --- a/drivers/hwmon/w83791d.c
> +++ b/drivers/hwmon/w83791d.c
> @@ -1333,7 +1333,7 @@ static int w83791d_detect(struct i2c_client *client,
>  	if (val1 != 0x71 || val2 != 0x5c)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "w83791d", I2C_NAME_SIZE);
> +	strscpy(info->type, "w83791d", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> index 31a1cdc30877..2c766a9209da 100644
> --- a/drivers/hwmon/w83792d.c
> +++ b/drivers/hwmon/w83792d.c
> @@ -1346,7 +1346,7 @@ w83792d_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	if (val1 != 0x7a || val2 != 0x5c)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "w83792d", I2C_NAME_SIZE);
> +	strscpy(info->type, "w83792d", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index 0a65d164c8f0..0c59162a7bf5 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -1636,7 +1636,7 @@ static int w83793_detect(struct i2c_client *client,
>  	if (chip_id != 0x7b)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "w83793", I2C_NAME_SIZE);
> +	strscpy(info->type, "w83793", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
> index 45b12c4287df..be5bb19e9afe 100644
> --- a/drivers/hwmon/w83795.c
> +++ b/drivers/hwmon/w83795.c
> @@ -1967,7 +1967,7 @@ static int w83795_detect(struct i2c_client *client,
>  	else
>  		chip_name = "w83795g";
>  
> -	strlcpy(info->type, chip_name, I2C_NAME_SIZE);
> +	strscpy(info->type, chip_name, I2C_NAME_SIZE);
>  	dev_info(&adapter->dev, "Found %s rev. %c at 0x%02hx\n", chip_name,
>  		 'A' + (device_id & 0xf), address);
>  
> diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
> index a41f989d66e2..56359350fd7f 100644
> --- a/drivers/hwmon/w83l785ts.c
> +++ b/drivers/hwmon/w83l785ts.c
> @@ -157,7 +157,7 @@ static int w83l785ts_detect(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "w83l785ts", I2C_NAME_SIZE);
> +	strscpy(info->type, "w83l785ts", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
> index 11ba23c1af85..2c4646fa8426 100644
> --- a/drivers/hwmon/w83l786ng.c
> +++ b/drivers/hwmon/w83l786ng.c
> @@ -687,7 +687,7 @@ w83l786ng_detect(struct i2c_client *client, struct i2c_board_info *info)
>  		return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "w83l786ng", I2C_NAME_SIZE);
> +	strscpy(info->type, "w83l786ng", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
