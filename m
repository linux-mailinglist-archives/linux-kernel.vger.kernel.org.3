Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681D7584022
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiG1Nhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiG1Nhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:37:48 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC1E54;
        Thu, 28 Jul 2022 06:37:48 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id c3so1931668pfb.13;
        Thu, 28 Jul 2022 06:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4RLlGi5dAg2VHKxbnNsmBFx3UyLfmfFc7h36hZHmzx8=;
        b=ggvGoRVaHJFAvy7QjcWwrjd73AJF6I2xTzZqd4+KpDDJONQxsB4kgvbkRENGW90tn7
         jHgGd/5o+HMIJHgwV2FPdsNbjs6kVJCaYJ2dZ1dAQObvyfRWbgfvQV9HBLAiOphuz65P
         vTsYxvhdGolSVD8FXe6Plfsd6JD+HgUBkOYxca/7w5q1E55UivikdcwNL15n17BZ0F/3
         yJG+bGoOikgEY+6mBEMXXpPzytKuMpYFYPp9rvOsDQZWh591pq7fMJHmj6WNm57GTgFS
         seWi2+z3JPy+CmeySIbae4zKMsyxDzer8WG4UUeNRZxvB034KaRf4YeBegZAvHbLuXPK
         KMNQ==
X-Gm-Message-State: AJIora/g33ugQZVMm90BxAGQmuFP1I38bsTnfgpoSseBwlE0A2BsObtj
        ktklvlBYY/MyEEAMJovFBfc=
X-Google-Smtp-Source: AGRyM1towNySqyGC9e26YS+cLOL4fnOnEp8PYg5c3M86CM2n/7wpJ+CfvrBhStzIT5TsmM0TxL09+w==
X-Received: by 2002:a05:6a00:99f:b0:52a:dd61:a50f with SMTP id u31-20020a056a00099f00b0052add61a50fmr27257824pfg.9.1659015467889;
        Thu, 28 Jul 2022 06:37:47 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id f34-20020a17090a702500b001f254ec83aesm3615951pjk.38.2022.07.28.06.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:37:47 -0700 (PDT)
Message-ID: <28005e66-ba90-8986-1b8f-b76bba46064c@acm.org>
Date:   Thu, 28 Jul 2022 06:37:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ufs: core: print capabilities in controller's sysfs node
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220728144710.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220728144710.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 21:49, Daniil Lunev wrote:
> +static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "0x%08llx\n", hba->caps);
> +}

This code change includes all of the UFSHCD_CAP_* constants in the 
kernel ABI. Is that really what we want? I'm wondering whether it 
perhaps would be better only to export those capabilities to user space 
that user space needs to know about.

Thanks,

Bart.
