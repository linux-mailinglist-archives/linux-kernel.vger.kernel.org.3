Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF57E511A55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiD0O3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiD0O3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09DC5B48
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651069548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=meZFqi3CaO9c14DiZ4KXudhKEdsdw2cnBxB6ExEDL0M=;
        b=hYzkOoDoC8mbafbeG2sUWno5m4LrRu2FVx2teD12f9YxMIZ66OKtcf2f09SYwliUv1VsMc
        78n6Hm9fftZ9fsFZo+LVaFEXSPSy0Ff1FCjtuKaE+4jiEUs9c8oBCtQR8rqBcmouRp4hfH
        5u8u7AVKh+ttWlWNc+nfkzpCZJsFv3I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-8pCG2fkwP3uPGgx0EUTOaA-1; Wed, 27 Apr 2022 10:25:46 -0400
X-MC-Unique: 8pCG2fkwP3uPGgx0EUTOaA-1
Received: by mail-ed1-f70.google.com with SMTP id co27-20020a0564020c1b00b00425ab566200so1098583edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=meZFqi3CaO9c14DiZ4KXudhKEdsdw2cnBxB6ExEDL0M=;
        b=XdNS/zl141qfdeIb2YAqx90/HJQs5DrI5rzVM6vXpXTKWE2PAVvobb44+g8WX/v0YH
         obGM09qft0w7kftrWh8NgR8wtc+HyvxmvaaGGBK+SSyK3stgRDyErnIXq967eY6Ea8iR
         +MDYFTl2RVhMca+RbIC4d1pbhPfrHrsdxnHSnBUdrCg0Pyf7M3EafxRkwp4yE6w9PTAB
         sAUKbaZZBSzd3IdjgPJ4lfoZ5oYkhpxKb9Ru89ahbCFK2YAdaqvoWTTNlFQOQMkTEy2S
         i5woKU+lvUIPDcOs4qWzgxb9S1KPGAyp2M8yacFsYYyp1PTyar2v5T3y7plfnBc3w2ng
         ns5w==
X-Gm-Message-State: AOAM531YBlUgLkXtdG3fpvFH71OD44svZ4CixGCfB8MCKjxT2dGDpYzC
        zGVQKYrXuyqgqzUQt4PuVw8KdP5wRgqT6HS6GChnFPUQSYJrTt77jU3c/U19GyJ10DdvpsUdMJt
        ji1UZqLPktjgpZu9OM8Dy1Cmu
X-Received: by 2002:a17:907:9958:b0:6e7:f67a:a1e7 with SMTP id kl24-20020a170907995800b006e7f67aa1e7mr25754853ejc.400.1651069545030;
        Wed, 27 Apr 2022 07:25:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9XKL0rxhNeXaJaz/zgQG2tvcs8GubQ2HP1+7At1pUpLGpAmENJVs5SaOdECl5AuxYCPQTlQ==
X-Received: by 2002:a17:907:9958:b0:6e7:f67a:a1e7 with SMTP id kl24-20020a170907995800b006e7f67aa1e7mr25754825ejc.400.1651069544772;
        Wed, 27 Apr 2022 07:25:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm6907231ejy.37.2022.04.27.07.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 07:25:44 -0700 (PDT)
Message-ID: <362138c7-7d6a-69b5-1e0f-0d6e29b1b958@redhat.com>
Date:   Wed, 27 Apr 2022 16:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: amd-pmc: Shuffle location of
 amd_pmc_get_smu_version()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20220418213800.21257-1-nathan@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220418213800.21257-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/18/22 23:38, Nathan Chancellor wrote:
> When CONFIG_DEBUG_FS is disabled, amd_pmc_get_smu_version() is unused:
> 
>   drivers/platform/x86/amd-pmc.c:196:12: warning: unused function 'amd_pmc_get_smu_version' [-Wunused-function]
>   static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
>              ^
>   1 warning generated.
> 
> Eliminate the warning by moving amd_pmc_get_smu_version() to the
> CONFIG_DEBUG_FS block where it is used.
> 
> Fixes: b0c07116c894 ("platform/x86: amd-pmc: Avoid reading SMU version at probe time")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/amd-pmc.c | 40 +++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 668a1d6c11ee..e266492d3ef7 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -193,26 +193,6 @@ struct smu_metrics {
>  	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
>  } __packed;
>  
> -static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
> -{
> -	int rc;
> -	u32 val;
> -
> -	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
> -	if (rc)
> -		return rc;
> -
> -	dev->smu_program = (val >> 24) & GENMASK(7, 0);
> -	dev->major = (val >> 16) & GENMASK(7, 0);
> -	dev->minor = (val >> 8) & GENMASK(7, 0);
> -	dev->rev = (val >> 0) & GENMASK(7, 0);
> -
> -	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
> -		dev->smu_program, dev->major, dev->minor, dev->rev);
> -
> -	return 0;
> -}
> -
>  static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
>  {
>  	struct amd_pmc_dev *dev = filp->f_inode->i_private;
> @@ -417,6 +397,26 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
>  
> +static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
> +{
> +	int rc;
> +	u32 val;
> +
> +	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
> +	if (rc)
> +		return rc;
> +
> +	dev->smu_program = (val >> 24) & GENMASK(7, 0);
> +	dev->major = (val >> 16) & GENMASK(7, 0);
> +	dev->minor = (val >> 8) & GENMASK(7, 0);
> +	dev->rev = (val >> 0) & GENMASK(7, 0);
> +
> +	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
> +		dev->smu_program, dev->major, dev->minor, dev->rev);
> +
> +	return 0;
> +}
> +
>  static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>  {
>  	struct amd_pmc_dev *dev = s->private;
> 
> base-commit: b0c07116c894325d40a218f558047f925e4b3bdb

