Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236BE4C09F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbiBWDJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiBWDJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:09:07 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240ED4249F;
        Tue, 22 Feb 2022 19:08:41 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c1so3923467pgk.11;
        Tue, 22 Feb 2022 19:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KNXD0wEnnMkYM4nYrbgaWbSHTPZHNFHQo3TG0wHLYW8=;
        b=NRaHKoYiZxCkZ95XddPmqFtPP8/CKf1EAyi99HvXty4/dIW5yTPQiYNFYYRVes6s3j
         MSr8HoYjeQO7uK9TIP0FVJIPovmmUHvGTBo6iyd9Yvtp43fpsW9Iuf8b1K+acKSTPUxK
         nyYkesUX2CRDTng09JNBMXkj2qXrEInQLHilJ8vnagPaFKDIHeFjFXO4jd0Yh5MMaIOw
         2RtF1uZPPT2k8kKHY15L3nxa2UN5dOWaFAhv9tew6PBRBwsPBWCfGaLp+3YbUarm2yQ8
         RgOrxUYjFg0wY+C6oNgojmWRGmkz1jBswXjrxq4AzgLDaTsxS9Gx2kZk67ubBl4+oNGW
         8g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KNXD0wEnnMkYM4nYrbgaWbSHTPZHNFHQo3TG0wHLYW8=;
        b=uR9TzqG8JK+plB45bfQENGWryyynbQvlHffM2WGVn1kuBIO911aehZHM4sR+/xvvVD
         ve6PYyxdVpZAO/9G0cR5jK7ZWDcu38fmDY5pBjaTcF+te9xEO/mwOjk9WcO01Uu/Yuup
         pPA/ZLbnbN3M3S0vvhIpIGAIPbPo+0Z+m7MOClOWgo7YbXSXT1m4XlkB3vjYfrX0Tcv8
         uxO5c5R4RLAyhwXtu6uBjASu9jAQHijuBrzFXrL42J5eXQnl3BeDJktOXsu2CMjErHVi
         J1AMZM/iXYAdM/i1N8UBRHavxB2eDIc0+ypL8t4Wt1AfQ9ntRKKywOnjFvoXhwZq8MbU
         9rnw==
X-Gm-Message-State: AOAM533z0Fe/h6+0ePt4FvIDoWnsiVy6lryv7+gT3l0QqEwUTMMOlaQN
        2FgzcqioUc277nVPjnThWw8=
X-Google-Smtp-Source: ABdhPJyWksdG10MEUd3zTqrliOUNefsK6qTWeibB0GA1rEIrxee+b+lcRtP6/P1z0aFhnXBZWrALvg==
X-Received: by 2002:a63:f745:0:b0:373:8350:889f with SMTP id f5-20020a63f745000000b003738350889fmr22134221pgk.620.1645585720594;
        Tue, 22 Feb 2022 19:08:40 -0800 (PST)
Received: from [172.20.119.15] ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id q1sm17972512pfs.112.2022.02.22.19.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 19:08:40 -0800 (PST)
Message-ID: <2e17c058-8917-4a37-896e-1093446339f6@gmail.com>
Date:   Wed, 23 Feb 2022 11:08:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
 <YhUbCH+dhKkgMirE@slm.duckdns.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <YhUbCH+dhKkgMirE@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/23 1:19 上午, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 17, 2022 at 11:13:44AM +0800, Wang Jianchao (Kuaishou) wrote:
>> (3) Add /sys/block/x/queue/qos
>>     We can use '+name' or "-name" to open or close the blk-rq-qos
>>     policy.
> 
> I don't understand why we're modularizing rq-qos in this non-standard way
> instead of modprobing to enable a policy and rmmoding to disable. Why are we
> building in qos names into the kernel and adding an extra module handling
> interface?

Hi Tejun

We just want to provide the flexibility for the user to open/close a policy
per device. If we need to the policy on a device, we needn't to waste cpu
cycles and memory for it.

Thanks
Jianchao
