Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7DE4DA41D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351763AbiCOUlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351760AbiCOUk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:40:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD152B37
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:39:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b8so466121pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qO1EZxPk3EVYZjHmIZj/SC5/lmPYHCVAMvKpVV+UbkI=;
        b=lNItlz7lqZKKNSvgFx8p5I2NY3GMP9wTeXbVYdrJPCryt0IcrSh18D4QzjcMqzi+HR
         v+eGGmRhmBAzunxzblrnrfu7bJtD6d1vzXcNdaZt03OvaRZ2SN00vdvN59vTeU34n0BM
         DFVY1MUc7ddZfaAF1uhPOhnbUUVRqr1wueMc4XuS477LeOWHJ4MROyUXT2sS3whhkzER
         1p97lKTeLciQ2wqq6J57y9T9lVn7mrMyG3VQC4V2Liu+6DieALRYZfgJRPJKiOcPcxkw
         3EYVqjJR51Ymeb4QTzTpfLFZuVquNHi6hOrAjteVrJOwFhJgEox4WtFeDbsXLXqaMqo+
         qsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qO1EZxPk3EVYZjHmIZj/SC5/lmPYHCVAMvKpVV+UbkI=;
        b=2o8utobkA0eTpSI9oinrrp3VdjSilZw+FXIZ7QQd4+wo9EYKFZZc49rWwKDjWjdyB3
         RBBbxXUj4GArYUJGUbNyqY8uae9x11gZ8FwEmKR12WDESSD8UHhFbNciQ+wlYHh5q6Qp
         3rUmi6qXS7NW/wQF0KwSjuonrfIwIpcJhDyR8UdOSgvl6pk9oEMdhPMAtUUGyZHiSN1b
         BSMciUC20ZZVLgXoIWjMbgdiuS9aXoqtE21ytd/fwZZUlLcbMu6Cy9w4In7jtdgJcjbm
         5U7Ln6tMLkMePKQyqdZ5wyKQy0fkIj0YZwewO/VV6yO0oRJG3L5YznU8BFGB/0vHX7Eu
         L6Eg==
X-Gm-Message-State: AOAM531NVYEJ/TclqI96k95EM8WMTiaBTxhldjAAodsPLIt5x4Y0yfpP
        0LlrbpqoLvU70rY+S9Z0PpRVNg==
X-Google-Smtp-Source: ABdhPJyNhIOzgOk4J23C+RNMCO/AhRln4iWu4uKOJZurIutYWkz0FE5iluYGaRnuE5oHnmUO/MOn/Q==
X-Received: by 2002:a17:90b:2496:b0:1b9:a6dd:ae7 with SMTP id nt22-20020a17090b249600b001b9a6dd0ae7mr6577592pjb.35.1647376782485;
        Tue, 15 Mar 2022 13:39:42 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id s14-20020a056a0008ce00b004f66dcd4f1csm27714733pfu.32.2022.03.15.13.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 13:39:42 -0700 (PDT)
Message-ID: <ca6b85d7-3b58-dd6b-adf2-3dc3362bf54a@linaro.org>
Date:   Tue, 15 Mar 2022 13:39:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] ext4: check if offset+length is within a valid range in
 fallocate
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+7a806094edd5d07ba029@syzkaller.appspotmail.com
References: <d153bb2e-5f95-47d0-43db-b95c577e2b91@linaro.org>
 <20220315191545.187366-1-tadeusz.struk@linaro.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <20220315191545.187366-1-tadeusz.struk@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 12:15, Tadeusz Struk wrote:
> @@ -3967,6 +3968,16 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
>   		   offset;
>   	}
>   
> +	/*
> +	 * For punch hole the length + offset needs to be at least within
> +	 * one block before last
> +	 */
> +	max_length = sbi->s_bitmap_maxbytes - sbi->s_blocksize;

that supposed to be:
max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;

Please ignore this one. I will send a new version soon.
Sorry for the noise.

> +	if (offset + length >= max_length) {
> +		ret = -ENOSPC;
> +		goto out_mutex;
> +	}
> +


-- 
Thanks,
Tadeusz
