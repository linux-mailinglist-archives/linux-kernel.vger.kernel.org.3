Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D103F52DB8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbiESRoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiESRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27DA1674DC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652982245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbKUDAKlg/Ogjr+4QtQJqlmidAs8wGDhpgalHiP6hOo=;
        b=GncvwfsXmWksaV2D/D5dcRUcq2QlVL2Vurwa27vjeFOviWblnoM8H49ltvuZgG8HV5gdas
        hOu5Kn/4mqGiNqZ1ZZFLmPI3X2Mmx6NyM+i2b7ikKLcf2++j8xA8gqX7P6VhrSb1jaUW3B
        QQz0V+QcyzpgLBxtEfDgkZRSDcaBW/4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-vmnwhXpJPGGIgo8dDK-2oQ-1; Thu, 19 May 2022 13:44:03 -0400
X-MC-Unique: vmnwhXpJPGGIgo8dDK-2oQ-1
Received: by mail-ed1-f72.google.com with SMTP id b3-20020aa7d483000000b004282ca95814so4000876edr.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TbKUDAKlg/Ogjr+4QtQJqlmidAs8wGDhpgalHiP6hOo=;
        b=iYkiI7kPPHIF1tQwtb4MFUh1D5B2VnIgiqOjnSP/7q4aDzLfsdsWJyDKvAIq7l+oNY
         h+VUnvXci78BPDdHKRztrgKGX/Fqs960LynzOJYBqN23M78YyjZsPJLTrHsrtVtlTGI0
         pamhfTB9sFZSnLtqL+XELhc17aLsfh1FF0ke1f2jQ48gzM4exfbs7fY0WTqLIoi5anUV
         BCwaDLdFxf6HO8boGAzc3MUqO3NTRnOP8TP9INAt6qZta1eBajq8wTe0FBQtSCj8HbNF
         oENAPNcB1fBDFzqnjjBvmscA+AHKDc/GhlmhnbVfj/Fc6N+Uvi3tB5bMvlDSnSrqnu3G
         xfvw==
X-Gm-Message-State: AOAM533G6L4O/1OH1inJ4+gTRAredQOpSzv76b7myb9eJPIC/SuFSRQd
        4x+NR2zeIOn27NMiZ4X1oglOF9R+ZnXA1e1WT0U/iSFC7tyLtTERhk+lyoWkJkhOChe5Fo3o27j
        SbBAWz1jFmFEYN9TOMKVDtZBF
X-Received: by 2002:a05:6402:2999:b0:428:bb4d:6cea with SMTP id eq25-20020a056402299900b00428bb4d6ceamr6631358edb.29.1652982242776;
        Thu, 19 May 2022 10:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvMbOp5T/ObRZXQ6Jq5u59322uAqzlrp5apy+zFigpuah5J4H5qKyzhYRShJqiKytyVEbuWA==
X-Received: by 2002:a05:6402:2999:b0:428:bb4d:6cea with SMTP id eq25-20020a056402299900b00428bb4d6ceamr6631339edb.29.1652982242610;
        Thu, 19 May 2022 10:44:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id v18-20020a056402349200b0042ac43be19dsm3339522edc.3.2022.05.19.10.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 10:44:02 -0700 (PDT)
Message-ID: <b08e3ae2-18b8-fe4d-7658-c51baf2dd197@redhat.com>
Date:   Thu, 19 May 2022 19:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: intel_cht_int33fe: Set driver data
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519122103.78546-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220519122103.78546-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/19/22 14:21, Heikki Krogerus wrote:
> Module removal fails because cht_int33fe_typec_remove()
> tries to access driver data that does not exist. Fixing by
> assigning the data at the end of probe.
> 
> Fixes: 915623a80b5a ("platform/x86: intel_cht_int33fe: Switch to DMI modalias based loading")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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
>  drivers/platform/x86/intel/chtwc_int33fe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
> index 0de509fbf0209..c52ac23e23315 100644
> --- a/drivers/platform/x86/intel/chtwc_int33fe.c
> +++ b/drivers/platform/x86/intel/chtwc_int33fe.c
> @@ -389,6 +389,8 @@ static int cht_int33fe_typec_probe(struct platform_device *pdev)
>  		goto out_unregister_fusb302;
>  	}
>  
> +	platform_set_drvdata(pdev, data);
> +
>  	return 0;
>  
>  out_unregister_fusb302:

