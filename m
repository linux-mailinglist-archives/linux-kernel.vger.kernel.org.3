Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781504F525F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850024AbiDFCqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455045AbiDEXia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:38:30 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695E71C1EFC;
        Tue,  5 Apr 2022 14:59:41 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id w7so686269pfu.11;
        Tue, 05 Apr 2022 14:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4kuF8230aMW6d0OsvBIcvsWtoggvqTBCLky46GdsMso=;
        b=uCos0OFGfekxx1r7cUdeZFojtRe3uJRfTog6bC9lA2shkArq6WCjWyBGCHRpRlEP60
         S0sEa3dvcwA5QHO+8g4QMjiTaCwwmGVXb9RHOg8ynXu6UbtH4Q/51F7NGFAwxj1X0UHp
         Gz/CgvyqRqxwKGjJ+75STKGmaGES9spvq60jp9VRGsrbVapzB4zXps95OGau1xDay70n
         gOM8wsNNU78Oh1zFOzs/SsbdmmGiNYu5NZaVAa2Wx+O2mVHD2Ni/NSmF/hkfrD/Sy0JY
         GhUTNID3AFCPn13T5TpemaMdjvqr2wc2+HihWMP4ATA1HRPeq0aohRWq9CLuffxq203K
         dp7Q==
X-Gm-Message-State: AOAM530RMPgBc6D/hethQ+MmNOkwa5S3nGyDHSxdiQSLS44pCyldIHKg
        +T3vGo40vEo10phaP7Po8Ow=
X-Google-Smtp-Source: ABdhPJwhBcPZ+gmGsaAc0wPUsqNrHhpguaqtod46qQyGAJ7EPIMuVpxIgk7lPW3RP5xTG3XVxTRk2w==
X-Received: by 2002:a63:5144:0:b0:382:11ef:7962 with SMTP id r4-20020a635144000000b0038211ef7962mr4530436pgl.171.1649195980716;
        Tue, 05 Apr 2022 14:59:40 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a001a0c00b004e1307b249csm16991028pfv.69.2022.04.05.14.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 14:59:39 -0700 (PDT)
Message-ID: <d01942c2-e600-b789-e613-9ead8c11d94a@acm.org>
Date:   Tue, 5 Apr 2022 14:59:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Content-Language: en-US
To:     =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ulf.hansson@linaro.org, ilias.apalodimas@linaro.org,
        arnd@linaro.org, ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20220405093759.1126835-2-alex.bennee@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220405093759.1126835-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 02:37, Alex Bennée wrote:
> +int rpmb_get_write_count(struct rpmb_dev *rdev, int len, u8 *request, int rlen, u8 *resp)
> +{
> +	int err;
> +
> +	if (!rdev)
> +		return -EINVAL;
> +
> +	mutex_lock(&rdev->lock);
> +	err = -EOPNOTSUPP;
> +	if (rdev->ops && rdev->ops->get_write_count)
> +		err = rdev->ops->get_write_count(rdev->dev.parent, rdev->target,
> +						 len, request, rlen, resp);
> +	mutex_unlock(&rdev->lock);
> +
> +	return err;
> +}

The names rpmb_get_write_count() and get_write_count() look confusing to 
me since these functions query the write counter. How about adding "er" 
at the end of both function names?

Are there any plans to add an implementation of struct rpmb_ops for UFS 
devices?

Thanks,

Bart.
