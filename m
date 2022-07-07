Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8881E56AE6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiGGW2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiGGW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:28:37 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE122AE20;
        Thu,  7 Jul 2022 15:28:36 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id ju17so11400683pjb.3;
        Thu, 07 Jul 2022 15:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VKiK/yUZZo5ei9cBtzXZzfM6IejHS8M7awJrUSyIObA=;
        b=D8T431u1uwgKBNQ48sOpyjQkIOG+a2gUXAKauX4g1q5H/18qA6+mJVY/yDK4tHmqbt
         hAGD07Pc3S5h7ESqzLs1/f5DAcl2HSf9E4K/K/ItJWzDJM2LLejthvHp3JaqtnLPWLwa
         OSh3PG69wmwLCdh+n0AY16lwmTUfnvX7sUP/tXDlOrUPpGJWdV7evpMBsV/YjgfSekYR
         Dv+Z1PgtecikoIuW5Btf7w1uNmUg84wkNjna4NoWYyjK/Or+DWaA3VcTNhjVtZtAUs96
         EDpDbmPc8Yeb1kXyo4NRQL2YH6aXeHBuhewHWgLuGzCKkVfBWktgDIQadgw0Ea3ljuV6
         qYDA==
X-Gm-Message-State: AJIora+3VjxhhaNpvSTrzZydp2aMEDqui9oSB0defMaa2nGu4qwvfX3f
        sSoopypGiD9rG0YOP4bYzc0yOfaZO4E=
X-Google-Smtp-Source: AGRyM1vhiDvujjH0OEjEprqDtaLaHiD/hNm59vmG0puWWc2se7sDA/m513xafI3+oFwx3fH5DvHIQw==
X-Received: by 2002:a17:902:b107:b0:16b:d7f7:ff8a with SMTP id q7-20020a170902b10700b0016bd7f7ff8amr144982plr.148.1657232915320;
        Thu, 07 Jul 2022 15:28:35 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902680400b0016bf5557690sm6409167plk.4.2022.07.07.15.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 15:28:34 -0700 (PDT)
Message-ID: <56de725b-d07a-e78e-e573-cfb868d315c9@acm.org>
Date:   Thu, 7 Jul 2022 15:28:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] scsi: ufs: wb: renaming & cleanups functions
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p4>
 <CGME20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p5>
 <20220701074654epcms2p5fcc0a8abe766fa00851b00dff98ad3c7@epcms2p5>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220701074654epcms2p5fcc0a8abe766fa00851b00dff98ad3c7@epcms2p5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 00:46, Jinyoung CHOI wrote:
> The Function names were changed clearly, and the location of the
> comments was modified and added properly.
> 
> In addition, the conditional test of the toggle functions was
> different, so it was modified.
> 
> Unnecessary logs were removed and modified appropriately.

There are too many changes in this patch. Please split this patch, e.g. 
one patch that introduces ufshcd_is_wb_buf_flush_allowed(), one patch 
that renames ufshcd_wb_toggle_flush_during_h8() and its arguments and 
another patch that renames ufshcd_wb_config().

> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> index 0a088b47d557..6253606b93b4 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -230,7 +230,7 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
>   		 * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
>   		 * on/off will be done while clock scaling up/down.
>   		 */
> -		dev_warn(dev, "To control WB through wb_on is not allowed!\n");
> +		dev_warn(dev, "It is not allowed to control WB!\n");

I suggest to change "control" into "configure".

>   static void ufshcd_scsi_unblock_requests(struct ufs_hba *hba)
> @@ -1289,9 +1288,10 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
>   		}
>   	}
>   
> -	/* Enable Write Booster if we have scaled up else disable it */
>   	downgrade_write(&hba->clk_scaling_lock);
>   	is_writelock = false;
> +
> +	/* Enable Write Booster if we have scaled up else disable it */
>   	ufshcd_wb_toggle(hba, scale_up);

The above change could be yet another patch.

>   out_unprepare:
> @@ -5715,6 +5715,9 @@ static int __ufshcd_wb_toggle(struct ufs_hba *hba, bool set, enum flag_idn idn)
>   	enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
>   				   UPIU_QUERY_OPCODE_CLEAR_FLAG;
>   
> +	if (!ufshcd_is_wb_allowed(hba))
> +		return -EPERM;
> +

Moving the ufshcd_is_wb_allowed() call from ufshcd_wb_toggle() into 
__ufshcd_wb_toggle() should be yet another patch.

> -	if (!(enable ^ hba->dev_info.wb_enabled))
> +	if (hba->dev_info.wb_enabled == enable)
>   		return 0;

This change is independent of the rest of this patch and hence could be 
yet another patch.

> -	dev_info(hba->dev, "%s Write Booster %s\n",
> -			__func__, enable ? "enabled" : "disabled");

Why has this code been left out?

> -	ret = __ufshcd_wb_toggle(hba, set,
> -			QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
> -	if (ret) {
> -		dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed: %d\n",
> -			__func__, set ? "enable" : "disable", ret);
> -		return;
> -	}
> -	dev_dbg(hba->dev, "%s WB-Buf Flush during H8 %s\n",
> -			__func__, set ? "enabled" : "disabled");
> +	ret = __ufshcd_wb_toggle(hba, enable,
> +				 QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
> +	if (ret)
> +		dev_err(hba->dev, "%s: failed to %s WB buf flush during H8 %d\n",
> +			__func__, enable ? "enable" : "disable", ret);

The above error message is worse than the original error message. Please 
either keep the original message or change it into something better than 
the original, e.g. "Failed to %s WB buffer flushing during H8".

Thanks,

Bart.
