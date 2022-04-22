Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40A950BEB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiDVRdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiDVRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:32:57 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C7789CF8;
        Fri, 22 Apr 2022 10:30:00 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id b7so12288409plh.2;
        Fri, 22 Apr 2022 10:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L0VZiWPUDvoGtAJV+rMrpuEj6dHv4nQx4wlGW/anjZk=;
        b=q6rjtvC/ygrQrRn60iTrMkEa3xg0GQ5kmlNIL94JfDUibNGFoCdpEx6Qq0uWVBQUCe
         Z5ByGSd3/1L4G2su+Vy98xXE7U4lmSwXl0KixZXXR6HRNjCE9WtuoNY/xmx1uEoaO496
         gcSO2JkhVWs5pY78faYI42+FWrMaxoJ1v9g2m1MW9y+BYKMOt4Qsl9f3NDY4PYXlFy5N
         cBbBfGfLcdiT/Isn1Q0Pv5NpdqNfkEMgvO/NMP8fKeIErQ0ULzoVwDRqlba0OEbqec05
         hpTMOjpwq5ijWP4Ty7GlFgowNGpcvmTC2C2Snj/bRUncIEqBcu5nSlxHnAqSkD4+0mPw
         SZrg==
X-Gm-Message-State: AOAM5313qs32PvA3bul0xqcQzwS/STUJniEXoqt8VqNbOh6fzB64V8PI
        0yCxC9z7AbDNoGxIxTi2mFQ=
X-Google-Smtp-Source: ABdhPJxvwTkOkkyNA7wXQqprYp05cNssYZ3YEvlZbX43EXOI/ndmleuxVMLsu7YF8GHfJfNL8RA+NA==
X-Received: by 2002:a17:90b:1a89:b0:1d2:f7ae:4928 with SMTP id ng9-20020a17090b1a8900b001d2f7ae4928mr17434702pjb.46.1650648310473;
        Fri, 22 Apr 2022 10:25:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e473:77c4:b4f8:27d3? ([2620:15c:211:201:e473:77c4:b4f8:27d3])
        by smtp.gmail.com with ESMTPSA id h126-20020a628384000000b0050cfdceabbasm188350pfe.155.2022.04.22.10.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:25:09 -0700 (PDT)
Message-ID: <f426fa45-7d72-52ad-8557-0027bca84194@acm.org>
Date:   Fri, 22 Apr 2022 10:25:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] scsi: ufs: wb: Add Manual Flush sysfs and cleanup toggle
 functions
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220422120240epcms2p24bdcb416becf76b417f7c39006aa40f2@epcms2p1>
 <1891546521.01650629881201.JavaMail.epsvc@epcpadp4>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1891546521.01650629881201.JavaMail.epsvc@epcpadp4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 05:14, Jinyoung CHOI wrote:
> There is the following quirk to bypass "WB Manual Flush" in Write
> Booster.
> 
>    - UFSHCD_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL
> 
> If this quirk is not set, there is no knob that can controll "WB Manual Flush".
> 
> 	There are three flags that control Write Booster Feature.
> 		1. WB ON/OFF
> 		2. WB Hibern Flush ON/OFF
> 		3. WB Flush ON/OFF
> 
> 	The sysfs that controls the WB was implemented. (1)
> 
> 	In the case of "Hibern Flush", it is always good to turn on.
> 	Control may not be required. (2)
> 
> 	Finally, "Manual flush" may be determined that it can affect
> 	performance or power consumption.
> 	So the sysfs that controls this may be necessary. (3)
> 
> In addition, toggle functions for controlling the above flags are cleaned.

Please make all sentences in the patch description start at the left margin.

> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> index 5c405ff7b6ea..6bbb56152708 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -229,7 +229,7 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
>   		 * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
>   		 * on/off will be done while clock scaling up/down.
>   		 */
> -		dev_warn(dev, "To control WB through wb_on is not allowed!\n");
> +		dev_warn(dev, "To control Write Booster is not allowed!\n");
>   		return -EOPNOTSUPP;
>   	}

The new error message is grammatically incorrect. Please fix.

> +	if (!ufshcd_is_wb_flush_allowed(hba)) {
> +		dev_warn(dev, "To control WB Flush is not allowed!\n");

Same issue for the above error message.

> +static DEVICE_ATTR_RW(wb_flush_on);

"wb_flush_enabled" is probably a better name than "wb_flush_on".
Additionally, the "wb_flush_en" is closer to the terminology used in the
UFS specification (fWriteBoosterBufferFlushEn).

 > diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
 > index 4a00c24a3209..6c85f512f82f 100644
 > --- a/drivers/scsi/ufs/ufs.h
 > +++ b/drivers/scsi/ufs/ufs.h
 > @@ -611,7 +611,7 @@ struct ufs_dev_info {
 >
 >   	/* UFS WB related flags */
 >   	bool    wb_enabled;
 > -	bool    wb_buf_flush_enabled;
 > +	bool    wb_flush_enabled;
 >   	u8	wb_dedicated_lu;
 >   	u8      wb_buffer_type;

Adding a variable with the name "wb_flush_enabled" next to a variable with
the name "wb_buf_flush_enabled" is confusing. Please chose better names and
add comments.

> -static int __ufshcd_wb_toggle(struct ufs_hba *hba, bool set, enum flag_idn idn)
> +static int __ufshcd_wb_toggle(struct ufs_hba *hba, const char *knob,
> +			      bool set, enum flag_idn idn)
>   {
> +	int ret;
>   	u8 index;
>   	enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
> -				   UPIU_QUERY_OPCODE_CLEAR_FLAG;
> +		UPIU_QUERY_OPCODE_CLEAR_FLAG;
> +
> +	if (!ufshcd_is_wb_allowed(hba))
> +		return -EPERM;
>   
>   	index = ufshcd_wb_get_query_index(hba);
> -	return ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
> +
> +	ret = ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
> +	if (ret) {
> +		dev_err(hba->dev, "%s: %s %s failed %d\n",
> +			__func__, knob, set ? "enable" : "disable", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(hba->dev, "%s: %s %s\n",
> +		 __func__, knob, set ? "enabled" : "disabled");
> +
> +	return ret;
>   }

Please leave out the dev_dbg() message and move the dev_err() message to
the callers of __ufshcd_wb_toggle() such that the 'knob' argument does not
have to be added to __ufshcd_wb_toggle().

Thanks,

Bart.
